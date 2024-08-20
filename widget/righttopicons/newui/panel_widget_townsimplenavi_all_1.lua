function PaGlobal_Widget_TownSimpleNavi_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_expand = UI.getChildControl(Panel_Widget_TownSimpleNavi_All, "Button_Expand")
  self._ui._stc_arrowLeft = UI.getChildControl(self._ui._btn_expand, "Static_ArrowLeft")
  self._ui._stc_arrowRight = UI.getChildControl(self._ui._btn_expand, "Static_ArrowRight")
  self._ui._stc_expandBg = UI.getChildControl(Panel_Widget_TownSimpleNavi_All, "Static_ExpandBg")
  local btn_iconTemp = UI.getChildControl(self._ui._stc_expandBg, "Button_001")
  btn_iconTemp:SetShow(false)
  self._iconButtonList = Array.new()
  local gapX, gapY = 5, 4
  for index = 1, CppEnums.SpawnType.eSpawnType_Count - 1 do
    local tempBtn = UI.cloneControl(btn_iconTemp, self._ui._stc_expandBg, "Button_NpcIcon_" .. tostring(index))
    local rowIndex = index % 2
    tempBtn:SetPosX(btn_iconTemp:GetPosX() - (btn_iconTemp:GetSizeX() + gapX) * ((index + rowIndex) / 2 - 1))
    tempBtn:SetPosY(btn_iconTemp:GetPosY() - (btn_iconTemp:GetSizeY() + gapY) * (rowIndex - 1))
    self._iconButtonList:push_back(tempBtn)
  end
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Widget_TownSimpleNavi_All:validate()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  self._ui._btn_expand:isValidate()
  self._ui._stc_arrowLeft:isValidate()
  self._ui._stc_arrowRight:isValidate()
  self._ui._stc_expandBg:isValidate()
end
function PaGlobal_Widget_TownSimpleNavi_All:registEventHandler()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_TownSimpleNavi_All_OnScreenResize")
  registerEvent("selfPlayer_regionChanged", "FromClient_Widget_TownSimpleNavi_All_RegionChanged")
  self._ui._btn_expand:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_TownSimpleNavi_All_Expand()")
end
function PaGlobal_Widget_TownSimpleNavi_All:resize()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  local radarGapX = 0
  if nil ~= FGlobal_Panel_Radar_GetSizeX then
    radarGapX = FGlobal_Panel_Radar_GetSizeX()
  end
  Panel_Widget_TownSimpleNavi_All:SetPosX(getScreenSizeX() - Panel_Widget_TownSimpleNavi_All:GetSizeX() - radarGapX - 5)
  local tempPanelGapY = 50
  Panel_Widget_TownSimpleNavi_All:SetPosY(tempPanelGapY)
end
function PaGlobal_Widget_TownSimpleNavi_All:prepareOpen()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  if true == self._isConsole then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if 1 ~= userType and 2 ~= userType then
    return
  end
  self:resize()
  local isNotExpand = not ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eExpandTownSimpleNavi)
  self:setExpand(isNotExpand)
  self:updateNpcNaviButton()
  self:open()
end
function PaGlobal_Widget_TownSimpleNavi_All:open()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  if nil ~= PaGlobalFunc_Widget_FunctionButton_GetShow and false == PaGlobalFunc_Widget_FunctionButton_GetShow() then
    return
  end
  Panel_Widget_TownSimpleNavi_All:SetShow(true)
  local showWidgetFunctionUiInfo = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
  if showWidgetFunctionUiInfo >= 0 then
    local isShowFunctionUi = 0 ~= showWidgetFunctionUiInfo
    Panel_Widget_TownSimpleNavi_All:SetShow(isShowFunctionUi)
  end
end
function PaGlobal_Widget_TownSimpleNavi_All:prepareClose()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  local isNotExpand = not self._ui._stc_expandBg:GetShow()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eExpandTownSimpleNavi, isNotExpand, CppEnums.VariableStorageType.eVariableStorageType_User)
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_Widget_TownSimpleNavi_All:close()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  Panel_Widget_TownSimpleNavi_All:SetShow(false)
end
function PaGlobal_Widget_TownSimpleNavi_All:setExpand(isExpand)
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  if nil == isExpand then
    isExpand = false
  end
  self._ui._stc_expandBg:SetShow(isExpand)
  if true == isExpand then
    self._ui._stc_arrowLeft:SetShow(false)
    self._ui._stc_arrowRight:SetShow(true)
  else
    self._ui._stc_arrowLeft:SetShow(true)
    self._ui._stc_arrowRight:SetShow(false)
  end
end
function PaGlobal_Widget_TownSimpleNavi_All:setNpcBtnTexture(icon, spawnType)
  if nil == icon or nil == spawnType then
    return
  end
  if nil == self._iconTextureData[spawnType] then
    return
  end
  local textureDir = self._iconTextureData[spawnType].dds
  local iconSize = self._iconTextureData[spawnType].size
  local color = self._iconTextureData[spawnType].color
  icon:SetSize(iconSize, iconSize)
  icon:ComputePos()
  icon:SetColor(color)
  icon:ChangeTextureInfoNameAsync(textureDir)
  local x1, y1, x2, y2 = setTextureUV_Func(icon, self._iconTextureData[spawnType].x1, self._iconTextureData[spawnType].y1, self._iconTextureData[spawnType].x2, self._iconTextureData[spawnType].y2)
  icon:getBaseTexture():setUV(x1, y1, x2, y2)
  icon:setRenderTexture(icon:getBaseTexture())
end
function PaGlobal_Widget_TownSimpleNavi_All:updateNpcNaviButton()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  for index = 1, #self._iconButtonList do
    if nil ~= self._iconButtonList[index] then
      self._iconButtonList[index]:addInputEvent("Mouse_LUp", "")
      self._iconButtonList[index]:addInputEvent("Mouse_RUp", "")
      self._iconButtonList[index]:SetShow(false)
    end
  end
  local curIndex = 1
  for index = 1, CppEnums.SpawnType.eSpawnType_Count - 1 do
    if nil ~= self._iconTextureData[index] then
      local spawnType
      if CppEnums.SpawnType.eSpawnType_TerritorySupply == index then
        if true == ToClient_IsContentsGroupOpen("22") then
          spawnType = index
        end
      elseif CppEnums.SpawnType.eSpawnType_TerritoryTrade == index then
        if true == ToClient_IsContentsGroupOpen("26") then
          spawnType = index
        end
      elseif CppEnums.SpawnType.eSpawnType_Instrument == index then
        if true == _ContentsGroup_InstrumentShop then
          spawnType = index
        end
      else
        spawnType = index
      end
      if nil ~= spawnType and nil ~= self._iconButtonList[curIndex] then
        local icon = UI.getChildControl(self._iconButtonList[curIndex], "Static_Icon")
        if nil ~= icon then
          self:setNpcBtnTexture(icon, index)
          self._iconButtonList[curIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_Widget_TownSimpleNavi_All_ShowNpcTypeTooltip(true," .. curIndex .. "," .. spawnType .. ")")
          self._iconButtonList[curIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_Widget_TownSimpleNavi_All_ShowNpcTypeTooltip(false)")
          self._iconButtonList[curIndex]:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_TownSimpleNavi_All_NaviStart(" .. spawnType .. ", false)")
          self._iconButtonList[curIndex]:addInputEvent("Mouse_RUp", "HandleEventLUp_Widget_TownSimpleNavi_All_NaviStart(" .. spawnType .. ", true)")
          self._iconButtonList[curIndex]:SetShow(true)
        end
        curIndex = curIndex + 1
      end
    end
  end
end
