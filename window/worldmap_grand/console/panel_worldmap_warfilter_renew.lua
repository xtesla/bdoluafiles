local _panel = Panel_Worldmap_WarFilter_Renew
local WarFilter = {
  _ui = {
    txt_categoryLeft = UI.getChildControl(_panel, "StaticText_CategoryLeft"),
    txt_categoryRight = UI.getChildControl(_panel, "StaticText_CategoryRight"),
    txt_territory = UI.getChildControl(_panel, "StaticText_Category_Territory"),
    btn_template = UI.getChildControl(_panel, "Button_FilterTemplate"),
    stc_bottomKeyGuide = UI.getChildControl(_panel, "Static_BottomKeyBG"),
    btn_gradeFilters = {},
    btn_dayFilters = {},
    btn_territoryFilters = {},
    stc_selectedGrade = {},
    stc_selectedDay = {},
    stc_selectedTerritory = {},
    txt_gradeFilterNames = {},
    txt_dayFilterNames = {},
    txt_territoryFilterNames = {},
    stc_gradeCheck = {},
    stc_dayCheck = {},
    stc_territoryCheck = {}
  },
  _gradeCount = 4,
  _dayCount = nil,
  _territoryCount = 6,
  _currentGradeFilter = 1,
  _currentDayFilter = 1,
  _currentTerritoryFilter = 1,
  _currentColumn = 1,
  _COLUMN_COUNT = 3
}
local _buttonStrings = {
  [1] = {
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_1"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_2"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_3")
  },
  [2] = {
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY_COLOR"),
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY_COLOR")
  },
  [3] = {
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_0"),
    PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_1"),
    PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_2"),
    PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_3"),
    PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_4"),
    "\235\158\143 \237\149\173\234\181\172",
    PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6")
  },
  [4] = {
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_LOW_LEVEL"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_MIDDLE_LEVEL"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_HIGH_LEVEL"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_1"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_2"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_3")
  },
  [5] = {
    PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_LOW_LEVEL"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_0") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_MIDDLE_LEVEL"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_1"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_2"),
    PAGetString(Defines.StringSheet_GAME, "LUA_NODEGRADE_3")
  }
}
function FromClient_luaLoadComplete_WarFilter()
  WarFilter:init()
end
function FromClient_WarFilter_OnScreenResize()
  WarFilter:resize()
end
registerEvent("onScreenResize", "FromClient_WarFilter_OnScreenResize")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WarFilter")
function WarFilter:init()
  self._ui.txt_categoryLeft:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_categoryRight:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_categoryLeft:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTTAXGRADE"))
  self._ui.txt_categoryRight:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDAY"))
  self._ui.txt_territory:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTTERRITORY"))
  local addPosX = 0
  if true == _ContentsGroup_ConquestSiege then
    addPosX = 190
    self._ui.txt_territory:SetPosX(self._ui.btn_template:GetPosX())
    self._ui.txt_categoryLeft:SetPosX(self._ui.btn_template:GetPosX() + addPosX * 1)
    self._ui.txt_categoryRight:SetPosX(self._ui.btn_template:GetPosX() + addPosX * 2)
    self._currentColumn = self._COLUMN_COUNT
  else
    self._COLUMN_COUNT = 2
  end
  if true == _ContentsGroup_SiegeLevel6 then
    if true == _ContentsGroup_ConquestSiege then
      self._gradeCount = 5
    else
      self._gradeCount = 6
    end
  end
  for ii = 1, self._gradeCount + 1 do
    self._ui.btn_gradeFilters[ii] = UI.cloneControl(self._ui.btn_template, _panel, "Button_GradeFilter_" .. ii)
    self._ui.btn_gradeFilters[ii]:SetPosX(self._ui.btn_template:GetPosX() + addPosX * 1)
    self._ui.btn_gradeFilters[ii]:SetPosY(self._ui.btn_template:GetPosY() + (ii - 1) * 49)
    self._ui.btn_gradeFilters[ii]:addInputEvent("Mouse_On", "InputMOn_WarFilter_GradeFilter(" .. ii .. ")")
    self._ui.stc_selectedGrade[ii] = UI.getChildControl(self._ui.btn_gradeFilters[ii], "Static_Selected")
    self._ui.stc_selectedGrade[ii]:SetShow(false)
    self._ui.stc_gradeCheck[ii] = UI.getChildControl(self._ui.btn_gradeFilters[ii], "Static_Check")
    self._ui.stc_gradeCheck[ii]:SetShow(false)
    self._ui.txt_gradeFilterNames[ii] = UI.getChildControl(self._ui.btn_gradeFilters[ii], "StaticText_FilterName")
    self._ui.txt_gradeFilterNames[ii]:SetTextMode(__eTextMode_LimitText)
    if true == _ContentsGroup_SiegeLevel6 then
      if true == _ContentsGroup_ConquestSiege then
        self._ui.txt_gradeFilterNames[ii]:SetText(_buttonStrings[5][ii])
      else
        self._ui.txt_gradeFilterNames[ii]:SetText(_buttonStrings[4][ii])
      end
    else
      self._ui.txt_gradeFilterNames[ii]:SetText(_buttonStrings[1][ii])
    end
  end
  self._dayCount = CppEnums.VillageSiegeType.eVillageSiegeType_Count
  for ii = 1, self._dayCount + 1 do
    self._ui.btn_dayFilters[ii] = UI.cloneControl(self._ui.btn_template, _panel, "Button_DayFilter_" .. ii)
    if true == _ContentsGroup_ConquestSiege then
      self._ui.btn_dayFilters[ii]:SetPosX(self._ui.btn_template:GetPosX() + addPosX * 2)
    else
      self._ui.btn_dayFilters[ii]:SetPosX(self._ui.btn_template:GetPosX() + 190)
    end
    self._ui.btn_dayFilters[ii]:SetPosY(self._ui.btn_template:GetPosY() + (ii - 1) * 49)
    self._ui.btn_dayFilters[ii]:addInputEvent("Mouse_On", "InputMOn_WarFilter_DayFilter(" .. ii .. ")")
    self._ui.stc_selectedDay[ii] = UI.getChildControl(self._ui.btn_dayFilters[ii], "Static_Selected")
    self._ui.stc_selectedDay[ii]:SetShow(false)
    self._ui.stc_dayCheck[ii] = UI.getChildControl(self._ui.btn_dayFilters[ii], "Static_Check")
    self._ui.stc_dayCheck[ii]:SetShow(false)
    self._ui.txt_dayFilterNames[ii] = UI.getChildControl(self._ui.btn_dayFilters[ii], "StaticText_FilterName")
    self._ui.txt_dayFilterNames[ii]:SetTextMode(__eTextMode_LimitText)
    self._ui.txt_dayFilterNames[ii]:SetText(_buttonStrings[2][ii])
  end
  if true == _ContentsGroup_ConquestSiege then
    self._ui.txt_territory:SetShow(true)
    for ii = 1, #_buttonStrings[3] do
      if 7 ~= ii then
        local indexY = ii
        if ii > 7 then
          indexY = indexY - 1
        end
        self._ui.btn_territoryFilters[indexY] = UI.cloneControl(self._ui.btn_template, _panel, "Button_TerritoryFilter_" .. ii)
        self._ui.btn_territoryFilters[indexY]:SetPosX(self._ui.btn_template:GetPosX())
        self._ui.btn_territoryFilters[indexY]:SetPosY(self._ui.btn_template:GetPosY() + (indexY - 1) * 49)
        self._ui.btn_territoryFilters[indexY]:addInputEvent("Mouse_On", "InputMOn_WarFilter_TerritoryFilter(" .. indexY .. ")")
        self._ui.stc_selectedTerritory[indexY] = UI.getChildControl(self._ui.btn_territoryFilters[indexY], "Static_Selected")
        self._ui.stc_selectedTerritory[indexY]:SetShow(false)
        self._ui.stc_territoryCheck[indexY] = UI.getChildControl(self._ui.btn_territoryFilters[indexY], "Static_Check")
        self._ui.stc_territoryCheck[indexY]:SetShow(false)
        self._ui.txt_territoryFilterNames[indexY] = UI.getChildControl(self._ui.btn_territoryFilters[indexY], "StaticText_FilterName")
        self._ui.txt_territoryFilterNames[indexY]:SetTextMode(__eTextMode_LimitText)
        self._ui.txt_territoryFilterNames[indexY]:SetText(_buttonStrings[3][ii])
      end
    end
  else
    self._ui.txt_territory:SetShow(false)
  end
  self._ui.btn_template:SetShow(false)
  local bottomButton = self._ui.btn_dayFilters[#self._ui.btn_dayFilters]
  local bottomPoint = bottomButton:GetPosY() + bottomButton:GetSizeY()
  if true == _ContentsGroup_ConquestSiege then
    _panel:SetSize(_panel:GetSizeX() + bottomButton:GetSizeX() + 30, bottomPoint + self._ui.stc_bottomKeyGuide:GetSizeY())
  else
    _panel:SetSize(_panel:GetSizeX(), bottomPoint + self._ui.stc_bottomKeyGuide:GetSizeY())
  end
  self._ui.stc_bottomKeyGuide:ComputePos()
  self:resize()
end
function PaGlobaFunc_WarFilter_GetShow()
  return _panel:GetShow()
end
function PaGlobaFunc_WarFilter_Open()
  WarFilter:open()
end
function WarFilter:open()
  self:setGradeFilterTo(self._currentGradeFilter)
  self:setDayFilterTo(self._currentDayFilter)
  self:setTerritoryFilterTo(self._currentTerritoryFilter)
  self:snapToColumn(self._currentColumn)
  if true == _ContentsGroup_ConquestSiege and nil ~= Panel_Worldmap_TopMenu then
    _panel:ComputePos()
    _panel:SetPosX(Panel_Worldmap_TopMenu:GetPosX() + Panel_Worldmap_TopMenu:GetSizeX() - _panel:GetSizeX() - 30)
    _panel:SetPosY(Panel_Worldmap_TopMenu:GetSizeY() - 10)
  end
  _panel:SetShow(true)
end
function InputMOn_WarFilter_GradeFilter(index)
  WarFilter:setGradeFilterTo(index)
end
function WarFilter:setGradeFilterTo(index)
  self._ui.stc_gradeCheck[self._currentGradeFilter]:SetShow(false)
  self._ui.stc_selectedGrade[self._currentGradeFilter]:SetShow(false)
  if index > self._gradeCount + 1 then
    self._currentGradeFilter = 1
  elseif index < 1 then
    self._currentGradeFilter = self._gradeCount + 1
  else
    self._currentGradeFilter = index
  end
  self._ui.stc_gradeCheck[self._currentGradeFilter]:SetShow(true)
  self._ui.stc_selectedGrade[self._currentGradeFilter]:SetShow(true)
end
function InputMOn_WarFilter_DayFilter(index)
  WarFilter:setDayFilterTo(index)
end
function WarFilter:setDayFilterTo(index)
  self._ui.stc_dayCheck[self._currentDayFilter]:SetShow(false)
  self._ui.stc_selectedDay[self._currentDayFilter]:SetShow(false)
  if index > self._dayCount + 1 then
    self._currentDayFilter = 1
  elseif index < 1 then
    self._currentDayFilter = self._dayCount + 1
  else
    self._currentDayFilter = index
  end
  self._ui.stc_dayCheck[self._currentDayFilter]:SetShow(true)
  self._ui.stc_selectedDay[self._currentDayFilter]:SetShow(true)
end
function InputMOn_WarFilter_TerritoryFilter(index)
  WarFilter:setTerritoryFilterTo(index)
end
function WarFilter:setTerritoryFilterTo(index)
  if false == _ContentsGroup_ConquestSiege then
    return
  end
  self._ui.stc_territoryCheck[self._currentTerritoryFilter]:SetShow(false)
  self._ui.stc_selectedTerritory[self._currentTerritoryFilter]:SetShow(false)
  if index > self._territoryCount + 1 then
    self._currentTerritoryFilter = 1
  elseif index < 1 then
    self._currentTerritoryFilter = self._territoryCount + 1
  else
    self._currentTerritoryFilter = index
  end
  self._ui.stc_territoryCheck[self._currentTerritoryFilter]:SetShow(true)
  self._ui.stc_selectedTerritory[self._currentTerritoryFilter]:SetShow(true)
end
function WarFilter:snapToColumn(index)
  self._ui.stc_selectedGrade[self._currentGradeFilter]:SetShow(1 == index)
  self._ui.stc_selectedDay[self._currentDayFilter]:SetShow(2 == index)
  if true == _ContentsGroup_ConquestSiege then
    self._ui.stc_selectedTerritory[self._currentTerritoryFilter]:SetShow(3 == index)
  end
  self._currentColumn = index
end
function Input_WarFilter_DPad(dPadtype)
  local self = WarFilter
  if dPadtype == __eJoyPadInputType_DPad_Down then
    if 1 == self._currentColumn then
      self:setGradeFilterTo(self._currentGradeFilter + 1)
    elseif 2 == self._currentColumn then
      self:setDayFilterTo(self._currentDayFilter + 1)
    elseif 3 == self._currentColumn then
      self:setTerritoryFilterTo(self._currentTerritoryFilter + 1)
    end
  elseif dPadtype == __eJoyPadInputType_DPad_Up then
    if 1 == self._currentColumn then
      self:setGradeFilterTo(self._currentGradeFilter - 1)
    elseif 2 == self._currentColumn then
      self:setDayFilterTo(self._currentDayFilter - 1)
    elseif 3 == self._currentColumn then
      self:setTerritoryFilterTo(self._currentTerritoryFilter - 1)
    end
  elseif dPadtype == __eJoyPadInputType_DPad_Left then
    local columnIndex = self._currentColumn - 1
    if columnIndex <= 0 then
      columnIndex = self._COLUMN_COUNT
    end
    if columnIndex > self._COLUMN_COUNT then
      columnIndex = 1
    end
    self:snapToColumn(columnIndex)
  elseif dPadtype == __eJoyPadInputType_DPad_Right then
    local columnIndex = self._currentColumn + 1
    if columnIndex <= 0 then
      columnIndex = self._COLUMN_COUNT
    end
    if columnIndex > self._COLUMN_COUNT then
      columnIndex = 1
    end
    self:snapToColumn(columnIndex)
  end
end
function PaGlobaFunc_WarFilter_Close()
  WarFilter:close()
end
function PaGlobaFunc_WarFilter_ApplyAndClose()
  WarFilter:apply()
  WarFilter:close()
  ToClient_WorldmapEraseFocusedUi()
  PaGlobal_WorldMapNodeTooltip_VillageWar_Close()
end
function WarFilter:initFilter()
  local filterColumn = 1
  if true == _ContentsGroup_ConquestSiege then
    filterColumn = self._COLUMN_COUNT
  end
  self:setGradeFilterTo(1)
  self:setDayFilterTo(1)
  self:setTerritoryFilterTo(1)
  self:snapToColumn(filterColumn)
  self:apply()
end
function PaGlobaFunc_WarFilter_InitFilter()
  WarFilter:initFilter()
end
function WarFilter:apply()
  if 1 == self._currentGradeFilter then
    ToClient_resetVisibleVillageSiegeTaxLevel()
  elseif true == _ContentsGroup_ConquestSiege then
    local taxGrade = self._currentGradeFilter - 2
    if taxGrade >= 2 then
      taxGrade = taxGrade + 1
    end
    ToClient_setVisibleVillageSiegeTaxLevel(taxGrade)
  else
    ToClient_setVisibleVillageSiegeTaxLevel(self._currentGradeFilter - 2)
  end
  if 1 == self._currentDayFilter then
    ToClient_resetVisibleVillageSiegeType()
  else
    ToClient_setVisibleVillageSiegeType(self._currentDayFilter - 2)
  end
  if true == _ContentsGroup_ConquestSiege then
    if 1 == self._currentTerritoryFilter then
      ToClient_resetVisibleVillageTerritoryKey()
    else
      PaGlobaFunc_WarFilter_SetTerritoryKey(self._currentTerritoryFilter - 2)
    end
    PaGlobalFunc_WorldMap_TopMenuInfo_SetWarInfoString(self._currentTerritoryFilter - 2)
  else
    ToClient_resetVisibleVillageTerritoryKey()
  end
end
function PaGlobaFunc_WarFilter_SetTerritoryKey(territoryKeyIndex)
  if -1 == territoryKeyIndex then
    ToClient_resetVisibleVillageTerritoryKey()
    return
  end
  local index = territoryKeyIndex
  if territoryKeyIndex >= 5 then
    index = index + 1
  end
  local territoryKey = getTerritoryByIndex(index)
  if nil == territoryKey then
    return
  end
  ToClient_setVisibleVillageTerritoryKey(territoryKey)
  local mianTownPos = ToClient_getMainTwonPosition(index)
  ToCleint_gotoWorldmapPosition(mianTownPos)
end
function PaGlobaFunc_WarFilter_GetCurrentTerritoryIndex()
  if nil == WarFilter then
    return 1
  end
  return WarFilter._currentTerritoryFilter
end
function WarFilter:close()
  _panel:SetShow(false)
end
function WarFilter:resize()
  _panel:ComputePos()
end
