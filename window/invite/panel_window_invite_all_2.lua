function PaGlobalFunc_Invite_All_Open(type)
  PaGlobal_Invite_All:prepareOpen(type)
end
function PaGlobalFunc_Invite_All_Close()
  PaGlobal_Invite_All:prepareClose()
end
function PaGlobal_Invite_All_CheckCurrentUiEdit_All(targetUI)
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_Invite_All._ui.edit_name:GetKey()
end
function PaGlobal_Invite_All_VirtualKeyEnd(str)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_Invite_All._ui.edit_name:SetEditText(str, true)
  ClearFocusEdit()
end
function PaGlobal_Invite_All_SetFocusEdit()
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_Invite_All._ui.edit_name)
  PaGlobal_Invite_All._ui.edit_name:SetEditText(PaGlobal_Invite_All._ui.edit_name:GetEditText(), true)
end
function PaGlobal_Invite_All_SendInvite()
  if true == MessageBox.isPopUp() then
    return
  end
  local name = PaGlobal_Invite_All._ui.edit_name:GetEditText()
  if "" == name then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DETECTPLAYER_ERRORMSG_PLAYERNAME_NIL"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    PaGlobalFunc_Invite_All_Close()
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local confirmFunction
  local messageTitle = ""
  local messageContent = ""
  local sendCrewInviteRequest = function()
    ToClient_RequestInviteCrew(PaGlobal_Invite_All._ui.edit_name:GetEditText(), PaGlobal_Invite_All._isFamilyName)
    PaGlobalFunc_Invite_All_Close()
  end
  local sendRentInstanceFieldInviteRequest = function()
    ToClient_requestInviteUserInRentInstanceField(PaGlobal_Invite_All._ui.edit_name:GetEditText(), PaGlobal_Invite_All._isFamilyName)
    PaGlobalFunc_Invite_All_Close()
  end
  UI.ASSERT_NAME(2 == PaGlobal_Invite_All._type.Count, "\236\131\136\235\161\156\236\154\180 \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\154\176\236\160\149\235\172\180")
  if PaGlobal_Invite_All._type.Crew == PaGlobal_Invite_All._openType then
    confirmFunction = sendCrewInviteRequest
    messageTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_INVITE_TITLE")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_INVITE_CONFIRM", "characterName", tostring(name))
  elseif PaGlobal_Invite_All._type.RentInstanceField == PaGlobal_Invite_All._openType then
    confirmFunction = sendRentInstanceFieldInviteRequest
    messageTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALSERVER_OPTION_TITLE")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_INVITE_CONFIRM", "characterName", tostring(name))
  end
  if "" == messageTitle or "" == messageContent or nil == confirmFunction then
    PaGlobalFunc_Invite_All_Close()
    return
  end
  local messageBoxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = confirmFunction,
    functionNo = PaGlobal_Invite_All_SetFocusEdit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  ClearFocusEdit()
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Invite_All_ChangeNicknameMode()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_Invite_All._isFamilyName = PaGlobal_Invite_All._ui.chk_familyName:IsCheck()
  else
    PaGlobal_Invite_All._isFamilyName = not PaGlobal_Invite_All._isFamilyName
  end
  PaGlobal_Invite_All:updateTab()
end
function FromClient_Invite_All_Resize()
  if nil == Panel_Window_Invite_All then
    return
  end
  Panel_Window_Invite_All:ComputePos()
end
