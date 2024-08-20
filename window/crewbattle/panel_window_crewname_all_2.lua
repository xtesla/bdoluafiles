function PaGlobalFunc_CrewName_All_Open()
  PaGlobal_CrewName_All:prepareOpen()
end
function PaGlobalFunc_CrewName_All_Close()
  PaGlobal_CrewName_All:prepareClose()
end
function PaGlobalFunc_CrewName_All_SetFocus()
  ClearFocusEdit()
  SetFocusEdit(PaGlobal_CrewName_All._ui.edit_crewName)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  PaGlobal_CrewName_All._ui.edit_crewName:SetEditText(PaGlobal_CrewName_All._ui.edit_crewName:GetEditText(), true)
end
function PaGlobalFunc_CrewName_All_VirtualKeyBoardEnd(str)
  if nil ~= str then
    ClearFocusEdit()
    PaGlobal_CrewName_All._ui.edit_crewName:SetEditText(str)
  end
end
function HandleEventLUp_CrewName_All_CheckDuplication()
  if nil == Panel_Window_CrewName_All then
    return
  end
  local userInput = PaGlobal_CrewName_All._ui.edit_crewName:GetEditText()
  if "" == userInput then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_CREATE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_CREATE_NAME"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_CheckOverlapChangeName(userInput, __eNameChangeType_CrewName, true)
end
function HandleEventLUp_CrewName_All_ClickedConfirm()
  local crewName = PaGlobal_CrewName_All._ui.edit_crewName:GetEditText()
  if nil == crewName or "" == crewName then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CREW_CREATE_NAME"))
    ClearFocusEdit()
    return
  end
  if false == PaGlobal_CrewName_All._isValidCrewName then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_CREATE_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_CHECK_ALARM"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local function requestCreateCrew()
    ToClient_RequestCreateCrew(crewName)
    ClearFocusEdit()
    PaGlobal_CreateClan_All_Close()
  end
  local refuseCreateCrew = function()
    ClearFocusEdit()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_CREATE_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_CREATE_CONFIRM", "name", crewName),
    functionYes = requestCreateCrew,
    functionNo = refuseCreateCrew,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_CrewName_All_Resize()
  if nil == Panel_Window_CrewName_All then
    return
  end
  Panel_Window_CrewName_All:ComputePosAllChild()
end
function FromClient_CrewName_All_NotifyChangeNameResult(type, isCreate, isPossible)
  if nil == Panel_Window_CrewName_All then
    return
  end
  if __eNameChangeType_CrewName ~= type or false == isCreate then
    return
  end
  local messageBoxMemo = ""
  if true == isPossible then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_CREATE_NAME_POSSIBLE")
    PaGlobal_CrewName_All._isValidCrewName = true
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_CREW_CREATE_NAME_IMPOSSIBLE")
    PaGlobal_CrewName_All._isValidCrewName = false
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CREW_CREATE_TITLE"),
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_CrewName_All_ResponseCreateCrew()
  PaGlobalFunc_CrewName_All_Close()
end
