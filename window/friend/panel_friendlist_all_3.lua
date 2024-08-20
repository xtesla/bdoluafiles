function PaGlobal_AddFriend_All:prepareOpen()
  if nil == Panel_FriendList_Add_All then
    return
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobal_AddFriend_All_SetFocusEdit()
  end
  PaGlobal_AddFriend_All._ui.edit_Name:SetEditText("", true)
  PaGlobal_AddFriend_All:updateDesc()
  if true == _ContentsGroup_Messenger then
    PaGlobal_FriendInfoList_All:hidePopupMenu()
  else
    PaGlobal_FriendList_All:hidePopupMenu()
  end
  if true == Panel_Friend_GroupRename_All:GetShow() then
    PaGlobal_Friend_GroupRename_All_Close()
  end
  if true == Panel_Friend_RequestList_All:GetShow() then
    PaGlobal_FriendRequest_All_Close()
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobal_AddFriend_All_ChangeNicknameMode()
  end
  PaGlobal_AddFriend_All:open()
end
function PaGlobal_AddFriend_All:open()
  if nil == Panel_FriendList_Add_All then
    return
  end
  Panel_FriendList_Add_All:SetShow(true)
end
function PaGlobal_AddFriend_All:prepareClose()
  if nil == Panel_FriendList_Add_All then
    return
  end
  CheckChattingInput()
  ClearFocusEdit()
  PaGlobal_AddFriend_All:close()
end
function PaGlobal_AddFriend_All:close()
  if nil == Panel_FriendList_Add_All then
    return
  end
  Panel_FriendList_Add_All:SetShow(false)
end
function PaGlobal_AddFriend_All:updateDesc()
  if PaGlobal_AddFriend_All._isFamilyName then
    PaGlobal_AddFriend_All._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDFRIEND_DESC_FAMILYNAME"))
  else
    PaGlobal_AddFriend_All._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDFRIEND_DESC"))
  end
end
function PaGlobal_AddFriend_All_Close()
  if nil == Panel_FriendList_Add_All then
    return
  end
  PaGlobal_AddFriend_All:prepareClose()
end
function PaGlobal_AddFriend_All_Open()
  if nil == Panel_FriendList_Add_All then
    return
  end
  PaGlobal_AddFriend_All:prepareOpen()
end
function PaGlobal_AddFriend_All_CheckCurrentUiEdit_All(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_AddFriend_All._ui.edit_Name:GetKey()
end
function PaGlobal_AddFriend_All_EnterAddFriend(str)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_AddFriend_All._ui.edit_Name:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobal_AddFriend_All_SetFocusEdit()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_AddFriend_All._ui.edit_Name)
  PaGlobal_AddFriend_All._ui.edit_Name:SetEditText(PaGlobal_AddFriend_All._ui.edit_Name:GetEditText(), true)
end
function PaGlobal_AddFriend_All_SendAddFriend()
  if true == MessageBox.isPopUp() then
    return
  end
  local friendStr = PaGlobal_AddFriend_All._ui.edit_Name:GetEditText()
  if "" == friendStr then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DETECTPLAYER_ERRORMSG_PLAYERNAME_NIL"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    PaGlobal_AddFriend_All_Close()
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local sendFriendRequest = function()
    requestFriendList_addFriend(PaGlobal_AddFriend_All._ui.edit_Name:GetEditText(), not PaGlobal_AddFriend_All._isFamilyName)
    PaGlobal_AddFriend_All:prepareClose()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_TEXT_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_XBOX_FRIEND_ADD_ALERT", "characterName", tostring(friendStr)),
    functionYes = sendFriendRequest,
    functionNo = PaGlobal_AddFriend_All_SetFocusEdit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  ClearFocusEdit()
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_AddFriend_All_ChangeNicknameMode()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_AddFriend_All._isFamilyName = 1 == ToClient_getChatNameType()
  else
    PaGlobal_AddFriend_All._isFamilyName = not PaGlobal_AddFriend_All._isFamilyName
  end
  PaGlobal_AddFriend_All:updateDesc()
end
function PaGlobal_AddFriend_All_ChangeNicknameModeConsole()
  PaGlobal_AddFriend_All._isFamilyName = not PaGlobal_AddFriend_All._isFamilyName
  PaGlobal_AddFriend_All:updateDesc()
end
