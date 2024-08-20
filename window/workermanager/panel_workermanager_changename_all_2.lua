function PaGlobalFunc_WorkerManagerChangeName_All_Open(workerIdx)
  PaGlobal_WorkerManagerChangeName_All:prepareOpen(workerIdx)
end
function PaGlobalFunc_WorkerManagerChangeName_All_Close()
  PaGlobal_WorkerManagerChangeName_All:prepareClose()
end
function PaGlobalFunc_WorkerManagerChangeName_All_GetShow()
  if nil == Panel_Window_WorkerManagerChangeName_All then
    return false
  end
  return Panel_Window_WorkerManagerChangeName_All:GetShow()
end
function PaGlobalFunc_WorkerManagerChangeName_All_Resize()
  PaGlobal_WorkerManagerChangeName_All:resize()
end
function PaGlobalFunc_WorkerManagerChangeName_All_KeyBoardEnd(str)
  if getGameServiceTypeServantNameLength() < string.len(str) then
    str = string.sub(str, 1, getGameServiceTypeServantNameLength())
  end
  PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname:SetEditText(str)
  ClearFocusEdit()
end
function HandleEventLUp_WorkerManagerChangeName_All_Apply()
  if nil == PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw then
    return
  end
  local workerNoRaw = PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw(PaGlobal_WorkerManagerChangeName_All._currentWorkerIdx)
  local workerWrapperLua = getWorkerWrapper(workerNoRaw)
  if nil == workerWrapperLua then
    return
  end
  local userInput = PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname:GetEditText()
  if nil == userInput or "" == userInput then
    return
  end
  workerWrapperLua:setNickName(userInput)
end
function HandleEventLUp_WorkerManagerChangeName_All_Reset()
  if nil == PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw then
    return
  end
  local workerNoRaw = PaGlobalFunc_WorkerManager_All_GetWorkerNoRaw(PaGlobal_WorkerManagerChangeName_All._currentWorkerIdx)
  local workerWrapperLua = getWorkerWrapper(workerNoRaw)
  if nil == workerWrapperLua then
    return
  end
  workerWrapperLua:clearNickName()
end
function HandleEventLUp_WorkerManagerChangeName_All_SetFocusEdit()
  if false == Panel_Window_WorkerManagerChangeName_All:GetShow() then
    return
  end
  PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname:SetMaxInput(getGameServiceTypeServantNameLength())
  SetFocusEdit(PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname)
  PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname:SetEditText(PaGlobal_WorkerManagerChangeName_All._ui.edit_nickname:GetEditText(), true)
end
function FromClient_WorkerManagerChangeName_All_ChangeSuccess(nickName)
  local message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKER_NAME_APPLY", "name", tostring(nickName))
  Proc_ShowMessage_Ack(message)
  PaGlobalFunc_WorkerManagerChangeName_All_Close()
end
function FromClient_WorkerManagerChangeName_All_ResetSuccess()
  local message = PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_NAME_RETURN_DEFAULT")
  Proc_ShowMessage_Ack(message)
  PaGlobalFunc_WorkerManagerChangeName_All_Close()
end
