function PaGlobal_FriendMessangerFloating_All:createMessanger(messangerIdstr, userName, friendUserNo)
  local miniMessanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiCount = nil,
    _uiBig = nil,
    _uiRecentMessage = nil,
    _uiMessage = nil,
    _friendUserNo = nil
  }
  function miniMessanger:initialize(messangerIdstr, userName, friendUserNo)
    miniMessanger:createPanel(messangerIdstr)
    miniMessanger:prepareControl(messangerIdstr, userName)
    miniMessanger._friendUserNo = friendUserNo
  end
  function miniMessanger:clear()
    UI.deletePanel(miniMessanger._mainPanel:GetID())
    miniMessanger._mainPanel = nil
    miniMessanger._friendUserNo = nil
  end
  function miniMessanger:createPanel(messangerIdstr)
    local newName = "Panel_FriendMiniMessanger" .. messangerIdstr
    miniMessanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Widget_Friends_Floating, miniMessanger._mainPanel)
    miniMessanger._mainPanel:SetDragAll(true)
    miniMessanger._mainPanel:SetShow(true)
  end
  function miniMessanger:prepareControl(messangerIdstr, userName)
    local titleBar = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_Top")
    local recentMessage = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_RecentMessage")
    miniMessanger._uiTitleBg = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_Floating, miniMessanger._mainPanel, "Static_Top", 0)
    miniMessanger._uiName = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Name", 0)
    miniMessanger._uiName:SetText(userName)
    miniMessanger._uiClose = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Close", 0)
    miniMessanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessangerFloating_CloseMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Count", 0)
    miniMessanger._uiBig = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Big", 0)
    miniMessanger._uiBig:addInputEvent("Mouse_LUp", "FriendMessangerFloating_OpenBigMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiRecentMessage = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_Floating, miniMessanger._mainPanel, "Static_RecentMessage", 0)
    miniMessanger._uiMessage = miniMessanger:createControl(__ePAUIControl_StaticText, recentMessage, miniMessanger._uiRecentMessage, "StaticText_1", 0)
  end
  function miniMessanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  miniMessanger:initialize(messangerIdstr, userName, friendUserNo)
  return miniMessanger
end
function FriendMessangerFloating_Update(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local message = messengerInfo:lastMessage()
  local messageCount = messengerInfo:getNoneReadMessageCount()
  if nil == message or "" == message then
    miniMessanger._uiMessage:SetText(" ")
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
    return
  end
  miniMessanger._uiMessage:SetText(message:getContent())
  if messageCount > 0 then
    miniMessanger._uiCount:SetShow(true)
    miniMessanger._uiCount:SetText(tostring(messageCount))
  else
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
  end
end
function FriendMessangerFloating_OpenMessanger(messangerId, friendUserNo)
  local messangerIdstr = tostring(messangerId)
  local friendUserNostr = tostring(friendUserNo)
  FriendMessanger_Close(messangerIdstr)
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local userName = friendInfo:getName()
  if nil == PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] then
    PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = PaGlobal_FriendMessangerFloating_All:createMessanger(messangerIdstr, userName, tonumber64(friendUserNostr))
  end
  FriendMessangerFloating_Update(messangerIdstr)
end
function FriendMessangerFloating_CloseMessanger(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger:clear()
  PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = nil
end
function FriendMessangerFloating_OpenBigMessanger(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  local friendUserNo = miniMessanger._friendUserNo
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger:clear()
  PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = nil
  FromClient_FriendInfoListOpenMessanger(messangerIdstr, friendUserNo)
  FromClient_FriendInfoList_All_FriendMessangerUpdate(tostring(messangerIdstr), true)
end
function FromClient_FriendMessangerFloatingUpdate(messangerId)
  local messangerIdstr = tostring(messangerId)
  FriendMessangerFloating_Update(messangerIdstr)
end
