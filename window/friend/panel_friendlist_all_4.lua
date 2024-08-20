function PaGlobal_FriendRequest_All:prepareOpen()
  if nil == Panel_Friend_RequestList_All and true == _ContentsGroup_NewUI_Friend_All then
    return
  end
  if true == _ContentsGroup_Messenger then
    if false == Panel_FriendInfoList_All:GetShow() then
      return
    end
  elseif false == Panel_FriendList_All:GetShow() then
    return
  end
  PaGlobal_FriendRequest_All._selectFriendIndex = -1
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:SetCheck(false)
    PaGlobal_FriendRequest_All_SelectTabConsole()
  else
    PaGlobal_FriendRequest_All_SelectTab(true)
  end
  if true == _ContentsGroup_Messenger then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
  else
    PaGlobal_FriendList_All:hidePopupMenu()
  end
  PaGlobal_FriendRequest_All:open()
end
function PaGlobal_FriendRequest_All:open()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:SetShow(true)
end
function PaGlobal_FriendRequest_All:prepareClose()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_FriendRequest_All:close()
end
function PaGlobal_FriendRequest_All:close()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Panel_Friend_RequestList_All:SetShow(false)
end
function PaGlobal_FriendRequest_All:updateList()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  TooltipSimple_Hide()
  local listControl = PaGlobal_FriendRequest_All._ui.list2_requested
  listControl:getElementManager():clearKey()
  local friendCount = RequestFriends_getAddFriendCount()
  for friendIndex = 0, friendCount - 1 do
    local addFriendInfo = RequestFriends_getAddFriendAt(friendIndex)
    if nil ~= addFriendInfo then
      listControl:getElementManager():pushKey(toInt64(0, friendIndex))
    end
  end
  if friendCount > 0 then
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetIgnore(false)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetEnable(true)
  else
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetIgnore(true)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetEnable(false)
  end
  listControl = PaGlobal_FriendRequest_All._ui.list2_request
  listControl:getElementManager():clearKey()
  friendCount = ToClient_getRequestAddFriendCount()
  for friendIndex = 0, friendCount - 1 do
    local addFriendInfo = ToClient_getRequestAddFriendAt(friendIndex)
    if nil ~= addFriendInfo then
      listControl:getElementManager():pushKey(toInt64(0, friendIndex))
    end
  end
  if false == _ContentsGroup_RenewUI and false == _ContentsGroup_RemasterUI_Main_Alert then
    FGlobal_NewFriendAlertOff()
  end
  if true == _ContentsGroup_Messenger then
    PaGlobal_FriendInfoList_All_SetRequestNew()
  end
  if nil ~= Panel_Widget_Alert_info then
    FromClient_Widget_Alert_Update_NewFriendCount()
  end
end
function PaGlobal_FriendRequest_All_Close()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  PaGlobal_FriendRequest_All:prepareClose()
end
function PaGlobal_FriendRequest_All_Open(isUpdate)
  if nil == Panel_Friend_RequestList_All then
    return
  end
  if true == isUpdate then
    RequestFriendList_getAddFriendList()
  end
  if true == Panel_FriendList_Add_All:GetShow() then
    PaGlobal_AddFriend_All_Close()
  end
  if true == Panel_Friend_GroupRename_All:GetShow() then
    PaGlobal_Friend_GroupRename_All_Close()
  end
  if true == _ContentsGroup_Messenger then
    if PaGlobal_FriendInfoList_All._tab._pcFriendTab == PaGlobal_FriendInfoList_All._currentTab then
      PaGlobal_FriendRequest_All:prepareOpen()
    end
  elseif PaGlobal_FriendList_All._tab._pcFriendTab == PaGlobal_FriendList_All._currentTab then
    PaGlobal_FriendRequest_All:prepareOpen()
  end
end
function PaGlobal_FriendRequest_All_OpenToggle()
  if false == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Open(true)
  else
    PaGlobal_FriendRequest_All_Close()
  end
end
function PaGlobal_FriendRequest_All_SetBasicPos()
  if true == _ContentsGroup_Messenger then
    Panel_Friend_RequestList_All:SetPosX(Panel_FriendInfoList_All:GetPosX() - Panel_Friend_RequestList_All:GetSizeX() - 10)
    Panel_Friend_RequestList_All:SetPosY(Panel_FriendInfoList_All:GetPosY())
  else
    Panel_Friend_RequestList_All:SetPosX(Panel_FriendList_All:GetPosX() - Panel_Friend_RequestList_All:GetSizeX() - 10)
    Panel_Friend_RequestList_All:SetPosY(Panel_FriendList_All:GetPosY())
  end
end
function PaGlobal_FriendRequested_All_List2EventControlCreate(control, key64)
  local index = Int64toInt32(key64)
  local addFriendInfo = RequestFriends_getAddFriendAt(index)
  if nil == addFriendInfo then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_BG")
  local btn_Ok = UI.getChildControl(control, "Button_Apply_PCUI")
  local btn_Refuse = UI.getChildControl(control, "Button_Dismiss_PCUI")
  local name = UI.getChildControl(control, "StaticText_Name")
  stc_BG:addInputEvent("Mouse_On", "PaGlobal_FriendRequest_All_Select(" .. index .. ")")
  if true == _ContentsGroup_UsePadSnapping then
    btn_Ok:SetShow(false)
    btn_Refuse:SetShow(false)
    control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_FriendRequest_All_RefuseFriend(" .. index .. ")")
    control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_FriendRequest_All_AcceptFriend(" .. index .. ")")
  else
    btn_Ok:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_AcceptFriend(" .. index .. ")")
    btn_Refuse:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_RefuseFriend(" .. index .. ")")
    btn_Ok:addInputEvent("Mouse_On", "HandleEventOnOut_FriendRequest_All_RequestedShowSimpleTooltip(" .. index .. "," .. "true" .. "," .. "0" .. ")")
    btn_Refuse:addInputEvent("Mouse_On", "HandleEventOnOut_FriendRequest_All_RequestedShowSimpleTooltip(" .. index .. "," .. "true" .. "," .. "1" .. ")")
    btn_Ok:addInputEvent("Mouse_Out", "HandleEventOnOut_FriendRequest_All_RequestedShowSimpleTooltip(" .. index .. "," .. "false" .. "," .. "0" .. ")")
    btn_Refuse:addInputEvent("Mouse_Out", "HandleEventOnOut_FriendRequest_All_RequestedShowSimpleTooltip(" .. index .. "," .. "false" .. "," .. "1" .. ")")
  end
  name:SetText(addFriendInfo:getName())
  PaGlobal_FriendRequest_All._ui.requestedList[index] = control
end
function PaGlobal_FriendRequest_All_List2EventControlCreate(control, key64)
  local index = Int64toInt32(key64)
  local addFriendInfo = ToClient_getRequestAddFriendAt(index)
  if nil == addFriendInfo then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_BG")
  local name = UI.getChildControl(control, "StaticText_Name")
  local date = UI.getChildControl(control, "StaticText_Date")
  local btn_Refuse = UI.getChildControl(control, "Button_Dismiss_PCUI")
  stc_BG:addInputEvent("Mouse_On", "PaGlobal_FriendRequest_All_Select(" .. index .. ")")
  if true == _ContentsGroup_UsePadSnapping then
    btn_Refuse:SetShow(false)
    control:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_FriendRequest_All_DeleteAddFriend(" .. index .. ")")
  else
    btn_Refuse:addInputEvent("Mouse_LUp", "PaGlobal_FriendRequest_All_DeleteAddFriend(" .. index .. ")")
    btn_Refuse:addInputEvent("Mouse_On", "HandleEventOnOut_FriendRequest_All_RequestShowSimpleTooltip(" .. index .. "," .. "true" .. "," .. "1" .. ")")
    btn_Refuse:addInputEvent("Mouse_Out", "HandleEventOnOut_FriendRequest_All_RequestShowSimpleTooltip(" .. index .. "," .. "false" .. "," .. "1" .. ")")
  end
  name:SetText(addFriendInfo:getName())
  name:SetShow(true)
  date:SetShow(false)
  PaGlobal_FriendRequest_All._ui.requestList[index] = control
end
function PaGlobal_FriendRequest_All_AcceptFriend(index)
  if ToClient_isAddFriendAllowed() then
    requestFriendList_acceptFriend(index)
    if true == _ContentsGroup_Messenger then
      PaGlobal_FriendInfoList_All._groupListData._selectedGroupIndex = nil
      PaGlobal_FriendInfoList_All._friendListData._selectedFriendIndex = nil
      PaGlobal_FriendInfoList_All._friendListData._selectedFriendUserNo = nil
      PaGlobal_FriendInfoList_All._listMoveIndex = nil
    else
      PaGlobal_FriendList_All._groupListData._selectedGroupIndex = nil
      PaGlobal_FriendList_All._friendListData._selectedFriendIndex = nil
      PaGlobal_FriendList_All._listMoveIndex = nil
    end
    PaGlobal_FriendRequest_All:updateList()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    ToClient_showPrivilegeError()
  end
end
function PaGlobal_FriendRequest_All_RefuseFriend(index)
  requestFriendList_refuseFriend(index)
  PaGlobal_FriendRequest_All:updateList()
end
function PaGlobal_FriendRequest_All_DeleteAddFriend(index)
  if nil == index then
    return
  end
  Toclient_requestDeleteAddFriend(index)
  PaGlobal_FriendRequest_All:updateList()
end
function PaGlobal_FriendRequest_All_Select(index)
  PaGlobal_FriendRequest_All._selectFriendIndex = index
end
function FromClient_FriendRequest_All_UpdateAddFriends()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  PaGlobal_FriendRequest_All:updateList()
  if 0 < RequestFriends_getAddFriendCount() then
    PaGlobal_FriendRequest_All_Open(false)
  end
end
function PaGlobal_FriendRequest_All_SelectTab(isRecieved)
  if true == isRecieved then
    PaGlobal_FriendRequest_All._ui.list2_requested:SetShow(true)
    PaGlobal_FriendRequest_All._ui.list2_request:SetShow(false)
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:SetCheck(true)
    PaGlobal_FriendRequest_All._ui.rdo_SendList:SetCheck(false)
    PaGlobal_FriendRequest_All._ui.stc_selectBar:SetPosX(PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:GetPosX() + PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:GetSizeX() * 0.5 - PaGlobal_FriendRequest_All._ui.stc_selectBar:GetSizeX() * 0.5)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetShow(true)
    PaGlobal_FriendRequest_All._selectFriendIndex = -1
  else
    PaGlobal_FriendRequest_All._ui.list2_requested:SetShow(false)
    PaGlobal_FriendRequest_All._ui.list2_request:SetShow(true)
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:SetCheck(false)
    PaGlobal_FriendRequest_All._ui.rdo_SendList:SetCheck(true)
    PaGlobal_FriendRequest_All._ui.stc_selectBar:SetPosX(PaGlobal_FriendRequest_All._ui.rdo_SendList:GetPosX() + PaGlobal_FriendRequest_All._ui.rdo_SendList:GetSizeX() * 0.5 - PaGlobal_FriendRequest_All._ui.stc_selectBar:GetSizeX() * 0.5)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetShow(false)
    PaGlobal_FriendRequest_All._selectFriendIndex = -1
  end
  if true == isRecieved then
    local friendCount = RequestFriends_getAddFriendCount()
    if friendCount >= 0 then
      PaGlobal_FriendRequest_All._ui.stc_noRequest:SetShow(false)
    else
      PaGlobal_FriendRequest_All._ui.stc_noRequest:SetShow(true)
    end
  end
  PaGlobal_FriendRequest_All:updateList()
end
function PaGlobal_FriendRequest_All_SelectTabConsole()
  if false == PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:IsCheck() then
    PaGlobal_FriendRequest_All._ui.list2_requested:SetShow(true)
    PaGlobal_FriendRequest_All._ui.list2_request:SetShow(false)
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:SetCheck(true)
    PaGlobal_FriendRequest_All._ui.rdo_SendList:SetCheck(false)
    PaGlobal_FriendRequest_All._ui.stc_selectBar:SetPosX(PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:GetPosX() + PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:GetSizeX() * 0.5 - PaGlobal_FriendRequest_All._ui.stc_selectBar:GetSizeX() * 0.5)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetShow(false)
    PaGlobal_FriendRequest_All._selectFriendIndex = -1
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_A:SetShow(true)
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_LS:SetShow(true)
    Panel_Friend_RequestList_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_FriendRequest_All_RefuseAllAddFriend()")
  else
    PaGlobal_FriendRequest_All._ui.list2_requested:SetShow(false)
    PaGlobal_FriendRequest_All._ui.list2_request:SetShow(true)
    PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:SetCheck(false)
    PaGlobal_FriendRequest_All._ui.rdo_SendList:SetCheck(true)
    PaGlobal_FriendRequest_All._ui.stc_selectBar:SetPosX(PaGlobal_FriendRequest_All._ui.rdo_SendList:GetPosX() + PaGlobal_FriendRequest_All._ui.rdo_SendList:GetSizeX() * 0.5 - PaGlobal_FriendRequest_All._ui.stc_selectBar:GetSizeX() * 0.5)
    PaGlobal_FriendRequest_All._ui.btn_RefuseAll:SetShow(false)
    PaGlobal_FriendRequest_All._selectFriendIndex = -1
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_A:SetShow(false)
    PaGlobal_FriendRequest_All._ui.stc_keyGuide_LS:SetShow(false)
    Panel_Friend_RequestList_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
  end
  if true == PaGlobal_FriendRequest_All._ui.rdo_ReceiveList:IsCheck() then
    local friendCount = RequestFriends_getAddFriendCount()
    if friendCount >= 0 then
      PaGlobal_FriendRequest_All._ui.stc_noRequest:SetShow(false)
    else
      PaGlobal_FriendRequest_All._ui.stc_noRequest:SetShow(true)
    end
  end
  PaGlobal_FriendRequest_All:updateList()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_FriendRequest_All._keyGuides, PaGlobal_FriendRequest_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function HandleEventOnOut_FriendRequest_All_RequestedShowSimpleTooltip(idx, isShow, tipType)
  if false == isShow or nil == tipType or nil == idx then
    TooltipSimple_Hide()
    return
  end
  local parentControl = PaGlobal_FriendRequest_All._ui.requestedList[idx]
  if nil == parentControl then
    return
  end
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDS_ADD_ACCEPT")
    desc = ""
    control = UI.getChildControl(parentControl, "Button_Apply_PCUI")
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FRIENDS_ADD_REJECT")
    desc = ""
    control = UI.getChildControl(parentControl, "Button_Dismiss_PCUI")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_FriendRequest_All_RequestShowSimpleTooltip(idx, isShow, tipType)
  if false == isShow or nil == tipType or nil == idx then
    TooltipSimple_Hide()
    return
  end
  local parentControl = PaGlobal_FriendRequest_All._ui.requestList[idx]
  if nil == parentControl then
    return
  end
  local name, desc, control
  if 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_CANCLE")
    desc = ""
    control = UI.getChildControl(parentControl, "Button_Dismiss_PCUI")
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_FriendRequest_All_RefuseAllAddFriend()
  if nil == Panel_Friend_RequestList_All then
    return
  end
  Toclient_requestRefuseAllAddFriend()
end
