function PaGloabl_Window_Wanted_Open()
  if nil == Panel_Window_Wanted then
    return
  end
  if false == _ContentsGroup_sheriff then
    return
  end
  PaGlobal_Window_Wanted:prepareOpen()
end
function PaGloabl_Window_Wanted_Close()
  if nil == Panel_Window_Wanted then
    return
  end
  PaGlobal_Window_Wanted:prepareClose()
end
function FromClient_UpdateWantedList()
  if nil == Panel_Window_Wanted and false == Panel_Window_Wanted:GetShow() then
    return
  end
  PaGlobal_Window_Wanted:update()
end
function PaGloabl_Window_Wanted_ShowToolTip(uiControl, name, desc)
  TooltipSimple_Show(uiControl, name, desc)
end
function FromClient_Window_Wanted_List2UpdateWanted(contents, key)
  if nil == Panel_Window_Wanted or nil == contents then
    return
  end
  local contentsBg = UI.getChildControl(contents, "Static_List_Temp")
  if nil == contentsBg then
    return
  end
  local index = Int64toInt32(key)
  local deadTimeControl = UI.getChildControl(contentsBg, "StaticText_C_Time")
  local deadRegionControl = UI.getChildControl(contentsBg, "StaticText_C_Region")
  local killerNameControl = UI.getChildControl(contentsBg, "StaticText_C_CharName")
  local btnWantedControl = UI.getChildControl(contentsBg, "Button_Wanted")
  if nil == deadTimeControl then
    return
  end
  if nil == deadRegionControl then
    return
  end
  if nil == killerNameControl then
    return
  end
  if nil == btnWantedControl then
    return
  end
  deadTimeControl:SetTextMode(__eTextMode_Limit_AutoWrap)
  deadRegionControl:SetTextMode(__eTextMode_Limit_AutoWrap)
  killerNameControl:SetTextMode(__eTextMode_Limit_AutoWrap)
  btnWantedControl:SetTextMode(__eTextMode_Limit_AutoWrap)
  btnWantedControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Wanted_OpenSetWanted(" .. index .. ")")
  local characterNo = ToClient_getBadPlayerCharacterNoByIndex(index)
  local userNickName = ToClient_getBadPlayerUserNickNameByIndex(index)
  local deadTime_s64 = ToClient_getBadPlayerDeadTimeByIndex(index)
  local killerName = ToClient_getBadPlayerCharacterNameByIndex(index)
  local regionName = ToClient_getBadPlayerRegionNameByIndex(index)
  PaGlobal_Window_Wanted._badPlayerInfo[index] = {
    _characterNo = characterNo,
    _userNickName = userNickName,
    _deadTime = deadTime_s64,
    _killerName = killerName,
    _regionName = regionName
  }
  local timeValue = PATime(deadTime_s64)
  local deadTimeString = timeValue:GetMonth() .. "/" .. timeValue:GetDay() .. " " .. timeValue:GetHour() .. ":" .. timeValue:GetMinute()
  deadTimeControl:SetText(deadTimeString)
  deadRegionControl:SetText(regionName)
  killerNameControl:SetText(userNickName .. "(" .. killerName .. ")")
  UI.setLimitTextAndAddTooltip(deadTimeControl)
  UI.setLimitTextAndAddTooltip(deadRegionControl)
  UI.setLimitTextAndAddTooltip(killerNameControl)
end
function HandleEventLUp_Window_Wanted_OpenSetWanted(index)
  if nil == Panel_Window_Wanted then
    return
  end
  if nil == PaGlobal_Window_Wanted_Set_Open then
    return
  end
  if nil == PaGlobal_Window_Wanted._badPlayerInfo[index] then
    return
  end
  local characterNo = PaGlobal_Window_Wanted._badPlayerInfo[index]._characterNo
  local killerName = PaGlobal_Window_Wanted._badPlayerInfo[index]._killerName
  local deadTime = PaGlobal_Window_Wanted._badPlayerInfo[index]._deadTime
  PaGlobal_Window_Wanted_Set_Open(characterNo, killerName, deadTime)
end
