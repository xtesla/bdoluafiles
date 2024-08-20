function PaGlobal_FriendMessangerFloatingAlert_All:createMessanger(messangerIdstr)
  local miniMessanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiCount = nil,
    _uiBig = nil,
    _uiRecentMessage = nil,
    _uiMessage = nil,
    _openRoomId = nil,
    _alertIndex = nil
  }
  function miniMessanger:initialize(messangerIdstr)
    miniMessanger:createPanel(messangerIdstr)
    miniMessanger:prepareControl(messangerIdstr)
  end
  function miniMessanger:clear()
    UI.deletePanel(miniMessanger._mainPanel:GetID())
    miniMessanger._mainPanel = nil
    miniMessanger._openRoomId = nil
    miniMessanger._alertIndex = nil
  end
  function miniMessanger:createPanel(messangerIdstr)
    local newName = "Panel_FriendMiniMessangerAlert" .. messangerIdstr
    miniMessanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel)
    miniMessanger._mainPanel:SetDragAll(true)
  end
  function miniMessanger:prepareControl(messangerIdstr)
    local titleBar = UI.getChildControl(Panel_Widget_Friends_FloatingAlert, "Static_Top")
    local recentMessage = UI.getChildControl(Panel_Widget_Friends_FloatingAlert, "Static_RecentMessage")
    miniMessanger._uiTitleBg = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel, "Static_Top", 0)
    miniMessanger._uiName = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Name", 0)
    miniMessanger._uiName:SetText(" ")
    miniMessanger._uiClose = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Close", 0)
    miniMessanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_CloseMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Count", 0)
    miniMessanger._uiBig = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Big", 0)
    miniMessanger._uiRecentMessage = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel, "Static_RecentMessage", 0)
    miniMessanger._uiMessage = miniMessanger:createControl(__ePAUIControl_StaticText, recentMessage, miniMessanger._uiRecentMessage, "StaticText_1", 0)
    miniMessanger._uiTitleBg:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiRecentMessage:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiBig:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._alertIndex = tonumber(messangerIdstr)
  end
  function miniMessanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  miniMessanger:initialize(messangerIdstr)
  return miniMessanger
end
function FriendMessangerFloatingAlert_Update(messangerIdstr, alertIndex, friendName, message)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  miniMessanger._uiName:SetText(" ")
  local messageCount = messengerInfo:getNoneReadMessageCount()
  if nil == message or "" == message then
    miniMessanger._uiName:SetText(friendName)
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
    return
  end
  miniMessanger._uiName:SetText(friendName)
  miniMessanger._uiMessage:SetText(message)
  if messageCount > 0 then
    miniMessanger._uiCount:SetShow(true)
    miniMessanger._uiCount:SetText(tostring(messageCount))
    if messageCount >= 100 then
      miniMessanger._uiCount:SetText("99+")
    end
  else
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
  end
  miniMessanger._openRoomId = messangerId_s64
end
function FriendMessangerFloatingAlert_OpenMessanger(messangerId, friendUserNo, message)
  if false == ToClient_RoadToggleEffectNotice() then
    return
  end
  local isMessangerOpen = FriendMessanger_IsOpenMessanger(messangerId)
  local isFriendListMessangerOpen = PaGlobalFunc_FriendInfoList_All_IsFriendInfoMessangerOpen(messangerId)
  if true == isMessangerOpen or true == isFriendListMessangerOpen then
    return
  end
  local messengerInfo = ToClient_GetMessengerInfo(messangerId)
  if nil == messengerInfo then
    return
  end
  if false == messengerInfo:getAlarmIsOn() then
    return
  end
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] then
      PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] = PaGlobal_FriendMessangerFloatingAlert_All:createMessanger(tostring(i))
    end
  end
  local messangerIdstr = tostring(messangerId)
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] and nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId and PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId == messangerId then
      FriendMessangerFloatingAlert_Update(messangerIdstr, i, friendInfo:getName(), message)
      return
    end
  end
  local messangerIndex
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] and nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId then
      messangerIndex = i
      break
    end
  end
  if nil == messangerIndex then
    messangerIndex = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1
  end
  for i = messangerIndex, 0, -1 do
    if 0 == messangerIndex then
      local control = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[0]
      FriendMessangerFloatingAlert_OpenAnimation(control._mainPanel, 0, 0.3, PaGlobal_FriendMessangerFloatingAlert_All._messangerPosY[0] + control._mainPanel:GetSizeY(), 0, control._mainPanel:GetSizeY())
    else
      FriendMessangerFloatingAlert_ChangeMessangerAlert(i, i - 1, true)
    end
  end
  FriendMessangerFloatingAlert_Update(messangerIdstr, 0, friendInfo:getName(), message)
end
function FriendMessangerFloatingAlert_CloseMessanger(alertIndexstr)
  local alertIndex = tonumber(alertIndexstr)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local isCheck = false
  for i = alertIndex, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    local topAlertControl = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i + 1]
    if nil ~= topAlertControl and nil ~= topAlertControl._openRoomId then
      FriendMessangerFloatingAlert_ChangeMessangerAlert(i, i + 1, false)
      topAlertControl._openRoomId = nil
      topAlertControl._mainPanel:SetShow(false)
      topAlertControl._mainPanel:SetSpanSize(0, -control:GetSizeY())
      isCheck = true
    end
  end
  if true == isCheck then
    return
  end
  ToClient_pushCloseMessageList(miniMessanger._openRoomId)
  miniMessanger._openRoomId = nil
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger._mainPanel:SetSpanSize(0, -control:GetSizeY())
end
function FriendMessangerFloatingAlert_OpenMainMessanger(alertIndexstr)
  local alertIndex = tonumber(alertIndexstr)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local messangerIdstr = tostring(miniMessanger._openRoomId)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(miniMessanger._openRoomId)
  FriendMessangerFloatingAlert_CloseMessanger(alertIndexstr)
  if toInt64(0, 0) ~= friendUserNo then
    PaGlobal_FriendInfoList_Show_All()
    FromClient_FriendInfoListOpenMessangerInFriendList(tonumber64(messangerIdstr))
    FromClient_FriendInfoList_All_FriendMessangerUpdate(tostring(messangerIdstr), true)
  end
  ToClient_pushCloseMessageList(miniMessanger._openRoomId)
end
function FriendMessangerFloatingAlert_OpenAnimation(control, startTime, endTime, startYPos, deltaX, deltaY)
  if nil == control or nil == startTime or nil == endTime or nil == deltaX or nil == deltaY then
    return
  end
  control:SetShow(true)
  control:ComputePos()
  local pos = {
    x = control:GetPosX(),
    y = control:GetPosY()
  }
  local moveAni = control:addMoveAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(pos.x, startYPos)
  moveAni:SetEndPosition(pos.x, startYPos - deltaY)
end
function FriendMessangerFloatingAlert_ChangeMessangerAlert(targetIndex, index, isUp)
  if nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[targetIndex] or nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[index] then
    return
  end
  local miniMessanger_1 = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[targetIndex]
  local miniMessanger_2 = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[index]
  miniMessanger_1._uiCount:SetText(miniMessanger_2._uiCount:GetText())
  miniMessanger_1._uiName:SetText(miniMessanger_2._uiName:GetText())
  miniMessanger_1._uiMessage:SetText(miniMessanger_2._uiMessage:GetText())
  miniMessanger_1._openRoomId = miniMessanger_2._openRoomId
  local deltaY = miniMessanger_2._mainPanel:GetSizeY()
  local startY = PaGlobal_FriendMessangerFloatingAlert_All._messangerPosY[index]
  if false == isUp then
    deltaY = -deltaY
  end
  FriendMessangerFloatingAlert_OpenAnimation(miniMessanger_1._mainPanel, 0, 0.3, startY, 0, deltaY)
end
function FromClient_FriendMessangerAlarmLoad(listSize)
  if nil == listSize then
    return
  end
  for i = 0, listSize - 1 do
    local alertInfo = ToClient_getMessengerAlertInfo(i)
    if nil ~= alertInfo then
      local messengerInfo = ToClient_GetMessengerInfo(alertInfo:getMessengerNo())
      if nil ~= messengerInfo then
        local message = messengerInfo:lastMessage()
        if nil ~= message then
          FriendMessangerFloatingAlert_OpenMessanger(alertInfo:getMessengerNo(), message:getUserNo(), message:getContent())
        end
      end
    end
  end
end
