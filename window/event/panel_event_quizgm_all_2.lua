function PaGlobal_Event_QuizGM_Close()
  if nil == Panel_Event_QuizGM then
    return
  end
  PaGlobal_Event_QuizGM:prepareClose()
end
function PaGlobal_Event_QuizGM_UpdateFrameEvent(deltaTime)
  if nil == Panel_Event_QuizGM then
    return
  end
  PaGlobal_Event_QuizGM:updateTimer(deltaTime)
end
function HandleEventLUp_Event_QuizGM_SendQuestion()
  if nil == Panel_Event_QuizGM then
    return
  end
  local self = PaGlobal_Event_QuizGM
  local function MessgeBox_Yes()
    local question = self._ui._edit_question:GetEditText()
    ToClient_RequestQuizGameOperation(self.eQuizGameOperationType.eQuizGameOperationType_NotifyQuestion, 0, question)
  end
  local operationName = PaGlobal_Event_QuizGM:getOperationName(self.eQuizGameOperationType.eQuizGameOperationType_NotifyQuestion)
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUIZGAME_OPERATION_PARAM1", "operationName", operationName)
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxData = {
    title = messageTitle,
    content = messageBoxMemo,
    functionYes = MessgeBox_Yes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, _ContentsGroup_UsePadSnapping)
end
function HandleEventLUp_Event_QuizGM_RequestOperation(operationType, operationParam)
  if nil == Panel_Event_QuizGM then
    return
  end
  local selectParam, operationParamForStr = PaGlobal_Event_QuizGM:getOperationParamAndStr(operationType)
  local function MessgeBox_Yes()
    ToClient_RequestQuizGameOperation(operationType, selectParam, "")
  end
  local operationName = PaGlobal_Event_QuizGM:getOperationName(operationType)
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxMemo = ""
  if "" == operationParamForStr then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUIZGAME_OPERATION_PARAM1", "operationName", operationName)
  else
    messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_QUIZGAME_OPERATION_PARAM2", "operationName", operationName, "operationParam", operationParamForStr)
  end
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local messageBoxData = {
    title = messageTitle,
    content = messageBoxMemo,
    functionYes = MessgeBox_Yes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, nil, _ContentsGroup_UsePadSnapping)
end
function HandleEventLUp_Event_QuizGM_SetAnswerType(answerType)
  if nil == Panel_Event_QuizGM then
    return
  end
  PaGlobal_Event_QuizGM._answerType = answerType
end
function HandleEventLUp_Event_QuizGM_QuestionSetFocusEdit()
  SetFocusEdit(PaGlobal_Event_QuizGM._ui._edit_question)
  PaGlobal_Event_QuizGM._ui._edit_question:SetEditText("")
  PaGlobal_Event_QuizGM._ui._edit_question:SetText("")
end
function HandleKeyEvent_Event_QuizGM_QuestionKeyBoardEndEvent(str)
  if nil ~= str then
    PaGlobal_Event_QuizGM._ui._edit_question:SetEditText(str)
  end
  ClearFocusEdit()
end
function HandleEventLUp_Event_QuizGM_TimeSetFocusEdit()
  SetFocusEdit(PaGlobal_Event_QuizGM._ui._edit_Timer)
  PaGlobal_Event_QuizGM._ui._edit_Timer:SetEditText("")
  PaGlobal_Event_QuizGM._ui._edit_Timer:SetText("")
end
function HandleKeyEvent_Event_QuizGM_TimeKeyBoardEndEvent(str)
  if nil ~= str then
    PaGlobal_Event_QuizGM._ui._edit_Timer:SetEditText(str)
  end
  ClearFocusEdit()
end
function FromClient_Response_QuizGameOperationSuccess(operationType, operationParam)
  PaGlobal_Event_QuizGM:markButtonUI(operationType)
  if PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_KickPlayer == operationType then
    PaGlobal_Event_QuizGM:clearData()
  elseif PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_Invalidity == operationType then
    PaGlobal_Event_QuizGM:clearData()
  elseif PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_SyncPlayerCount == operationType then
    PaGlobal_Event_QuizGM:setPlayerCount(operationParam)
  elseif PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_SetTimer == operationType then
    PaGlobal_Event_QuizGM:setTimer(operationParam)
  elseif PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_SetEnterAble == operationType then
    local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_DISABLE_ENTER")
    local messageBoxData = {
      title = messageTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = nil,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, nil, nil, _ContentsGroup_UsePadSnapping)
  elseif PaGlobal_Event_QuizGM.eQuizGameOperationType.eQuizGameOperationType_EndQuizGame == operationType then
    local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_END_GAME")
    local messageBoxData = {
      title = messageTitle,
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = nil,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, nil, nil, _ContentsGroup_UsePadSnapping)
  end
end
function FromClient_Response_QuizGM_QuizGameTimerAck(timeValue)
  if nil == Panel_Event_QuizGM then
    return
  end
  PaGlobal_Event_QuizGM:setTimer(timeValue)
end
function FromClient_ShowQuizGameGMUI_OnOff(isOpenParam)
  if nil == Panel_Event_QuizGM then
    return
  end
  if true == isOpenParam then
    PaGlobal_Event_QuizGM:prepareOpen()
  else
    PaGlobal_Event_QuizGM:prepareClose()
  end
end
