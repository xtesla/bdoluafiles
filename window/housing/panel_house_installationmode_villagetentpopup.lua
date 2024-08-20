Panel_House_InstallationMode_VillageTent:SetShow(false)
Panel_House_InstallationMode_VillageTent:setMaskingChild(true)
Panel_House_InstallationMode_VillageTent:ActiveMouseEventEffect(true)
Panel_House_InstallationMode_VillageTent:setGlassBackground(true)
local bg = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Static_VillageTentBG")
local btnClose = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Button_CloseIcon")
local btnApply = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Button_Apply")
local templateDay = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_DayTemplate")
local templateRegion = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_RegionTemplate")
local joinDesc = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_VillageTent_JoinDesc")
local bottomBg = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Static_NoticeBg")
local bottomDesc = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_NoticeDesc")
bottomDesc:SetTextMode(__eTextMode_AutoWrap)
bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_VILLAGETENTPOPUP_DESC"))
local regionInfoWrapper = {}
local dayControl = {}
local dayCount = 0
local UI_VT = CppEnums.VillageSiegeType
joinDesc:SetTextMode(__eTextMode_AutoWrap)
btnClose:addInputEvent("Mouse_LUp", "VillageTent_Close()")
btnApply:addInputEvent("Mouse_LUp", "VillageTent_SetRegion()")
templateDay:SetShow(false)
templateRegion:SetShow(false)
local posY = templateDay:GetPosY()
local textGap = 25
local maxCount = 7
local dayString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY")
}
local dayStringShort = {
  [UI_VT.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SUNDAY"),
  [UI_VT.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_MONDAY"),
  [UI_VT.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_TUESDAY"),
  [UI_VT.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_WEDNESDAY"),
  [UI_VT.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_THURSDAY"),
  [UI_VT.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_FRIDAY"),
  [UI_VT.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SATURDAY")
}
function VillageTent_Init()
  dayControl = {}
  local temp = {}
  for index = 0, maxCount - 1 do
    dayControl[index] = {}
    temp[index] = {}
    temp[index]._day = UI.createControl(__ePAUIControl_StaticText, Panel_House_InstallationMode_VillageTent, "StaticText_Day_" .. index)
    CopyBaseProperty(templateDay, temp[index]._day)
    temp[index]._day:SetPosY(posY + index * textGap)
    temp[index]._day:SetShow(false)
    temp[index]._regionName = UI.createControl(__ePAUIControl_StaticText, Panel_House_InstallationMode_VillageTent, "StaticText_RegionName_" .. index)
    CopyBaseProperty(templateRegion, temp[index]._regionName)
    temp[index]._regionName:SetPosY(posY + index * textGap)
    temp[index]._regionName:SetShow(false)
    dayControl[index] = temp[index]
  end
end
function FGlobal_VillageTent_SelectPopup()
  local position = housing_getInstallationPos()
  local count = housing_getInstallableSiegeKeyList(position)
  if true == _ContentsGroup_ConquestSiege then
    local regionWrapper = housing_getInstallableSiegeRegionInfo(0)
    local msgBoxDesc = ""
    local dayStr = ""
    local time = 0
    if nil ~= regionWrapper then
      local territoryKey = regionWrapper:getTerritoryKeyRaw()
      local today = ToClient_GetDayOfWeek()
      for ii = 0, UI_VT.eVillageSiegeType_Count - 1 do
        local findDay = ii + today
        if findDay >= UI_VT.eVillageSiegeType_Count then
          findDay = findDay % UI_VT.eVillageSiegeType_Count
        end
        if true == ToClient_checkSiegeDayByRawKey(territoryKey, findDay) then
          dayStr = dayStringShort[findDay]
          time = ToClinet_getSiegeStartTimeByDayOfWeek(findDay)
          time = time % 24
          break
        end
      end
    end
    msgBoxDesc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_POPUP_LOCALSIEGE_BUILDCASTLE_DESC", "territory", regionWrapper:getTerritoryName(), "region", regionWrapper:getAreaName(), "date", dayStr, "time", time)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VILLAGETENT_TITLE"),
      content = msgBoxDesc,
      functionYes = VillageTent_SetRegion,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if Panel_House_InstallationMode_VillageTent:GetShow() then
    return
  end
  dayCount = count
  Panel_House_InstallationMode_VillageTent:SetShow(true)
  VillageTent_ChangeFontColor(7)
  VillageTent_SetText(count)
end
function VillageTent_SetText(count)
  if true == _ContentsGroup_ConquestSiege then
    return
  end
  local gradeString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_LOW_LEVEL"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_MIDDLE_LEVEL"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_HIGH_LEVEL")
  }
  local position = housing_getInstallationPos()
  local warDay = ToClient_GetCurrentInstallableTentDayOfWeek(position)
  local currentDayIndex = -1
  for index = 0, maxCount - 1 do
    if index < count then
      regionInfoWrapper[index] = housing_getInstallableSiegeRegionInfo(index)
      local day = regionInfoWrapper[index]:getVillageSiegeType()
      local regionName = regionInfoWrapper[index]:getAreaName()
      local taxLevel = regionInfoWrapper[index]:get():getVillageTaxLevel()
      local tempString = ""
      if true == _ContentsGroup_SeigeSeason5 then
        if _ContentsGroup_NewSiegeRule then
          tempString = "LUA_NODEGRADE_"
        else
          tempString = "LUA_NODEGRADE2_"
        end
        tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxLevel))
        if 0 == taxLevel then
          local grade = regionInfoWrapper[index]:getSiegeOptionTypeByRegion()
          tempString = tempString .. " " .. gradeString[grade]
        end
        dayControl[index]._regionName:SetText(regionName .. "(" .. tempString .. ")")
      else
        if 0 == taxLevel then
          tempString = PAGetString(Defines.StringSheet_GAME, "LUA_TAX_GRADE_ZERO")
        elseif 1 == taxLevel then
          tempString = "I"
        elseif 2 == taxLevel then
          tempString = "II"
        elseif 3 == taxLevel then
          tempString = "III"
        end
        dayControl[index]._regionName:SetText(regionName .. "(" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGETENT_GRADE", "index", tempString) .. ")")
      end
      dayControl[index]._day:SetText(dayString[day])
      dayControl[index]._day:SetShow(true)
      dayControl[index]._regionName:SetShow(true)
      if warDay == day then
        currentDayIndex = index
      end
    else
      dayControl[index]._day:SetShow(false)
      dayControl[index]._regionName:SetShow(false)
    end
  end
  if currentDayIndex >= 0 then
    VillageTent_ChangeFontColor(currentDayIndex)
    joinDesc:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SETDESC", "day", dayControl[currentDayIndex]._day:GetText(), "regionName", dayControl[currentDayIndex]._regionName:GetText()))
    joinDesc:SetShow(true)
  else
    joinDesc:SetShow(false)
  end
  VillageTent_SetSize(count)
end
function VillageTent_SetSize(count)
  bg:SetSize(bg:GetSizeX(), 70 + (count - 1) * textGap)
  joinDesc:SetPosY(dayControl[count - 1]._day:GetPosY() + 45)
  bottomDesc:SetPosY(joinDesc:GetPosY() + joinDesc:GetTextSizeY() + 15)
  bottomBg:SetSize(bottomBg:GetSizeX(), bottomDesc:GetTextSizeY() + 15)
  Panel_House_InstallationMode_VillageTent:SetSize(Panel_House_InstallationMode_VillageTent:GetSizeX(), joinDesc:GetPosY() + joinDesc:GetTextSizeY() + bottomBg:GetSizeY() + 70)
  bottomBg:ComputePos()
  btnApply:ComputePos()
end
function VillageTent_ChangeFontColor(index)
  for ii = 0, dayCount - 1 do
    if ii == index then
      dayControl[ii]._day:SetFontColor(Defines.Color.C_FFFFCE22)
      dayControl[ii]._regionName:SetFontColor(Defines.Color.C_FFFFCE22)
      dayCheck = true
    else
      dayControl[ii]._day:SetFontColor(Defines.Color.C_FFC4BEBE)
      dayControl[ii]._regionName:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
  end
end
function VillageTent_SetRegion()
  local position = housing_getInstallationPos()
  if false == _ContentsGroup_ConquestSiege then
    local currentDay = ToClient_GetCurrentInstallableTentDayOfWeek(position)
    for ii = 0, dayCount - 1 do
      local regionInfoWrapper = housing_getInstallableSiegeRegionInfo(ii)
      local day = regionInfoWrapper:getVillageSiegeType()
      if currentDay == day then
        local regionKeyRaw = regionInfoWrapper:get()._regionKey:get()
        if ToClient_IsVillageSiegeInThisWeek(regionKeyRaw) then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_VILLAGETENTPOPUP_LASTWEEK"))
        else
          housing_InstallObject(regionKeyRaw)
          if true == _ContentsGroup_NewUI_InstallMode_All then
            PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
          else
            FGlobal_HouseInstallationControl_Close()
          end
          if true == _ContentsGroup_NewUI_InstallMode_All then
            PaGlobal_House_Installation_All_Close()
          else
            FGlobal_House_InstallationMode_Close()
          end
        end
      end
    end
  else
    local countOfSiege = ToClient_getJoinableSiegeCount(position)
    local regionKeyRaw = ToClient_getJoinableSiegeKeyAt(position, 0)
    housing_InstallObject(regionKeyRaw)
    if true == _ContentsGroup_NewUI_InstallMode_All then
      PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
      PaGlobal_House_Installation_All_Close()
    else
      FGlobal_HouseInstallationControl_Close()
      FGlobal_House_InstallationMode_Close()
    end
  end
end
function VillageTent_Close()
  Panel_House_InstallationMode_VillageTent:SetShow(false)
end
VillageTent_Init()
