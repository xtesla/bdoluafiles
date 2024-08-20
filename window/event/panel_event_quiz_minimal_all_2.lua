function PaGloabl_Event_Quiz_Minimal_Open()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:prepareOpen()
end
function PaGloabl_Event_Quiz_Minimal_Close()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:prepareClose()
end
function PaGloabl_Event_Quiz_Minimal_OXQuizExit()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  local OXQuizExit = function()
    ToClient_RequestQuizGameJoinOrUnJoin(false)
    PaGlobal_Event_Quiz_Minimal:prepareClose()
  end
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local contentText = PAGetString(Defines.StringSheet_GAME, "LUA_OXQUIZ_UNJOIN")
  local messageboxData = {
    title = titleText,
    content = contentText,
    functionApply = OXQuizExit,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGloabl_Event_Quiz_Minimal_UpdateTimer(percent)
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:updateTimer(percent)
end
function PaGloabl_Event_Quiz_Minimal_SetEndTimer()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:setEndTimer()
end
function PaGlobal_Event_Quiz_Minimal_UpdateFrameEvent(deltaTime)
  if true == keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_WeaponInOut) and nil ~= Panel_Event_Quiz and false == Panel_Event_Quiz:GetShow() then
    PaGloabl_Event_Quiz_Open()
  end
end
function FromClient_Event_Quiz_Minimal_LoadFieldCompleteAck()
  if true == ToClient_IsJoinQuizGame() then
    PaGlobal_Event_Quiz_Minimal._currentState = PaGlobal_Event_Quiz_Minimal._state._default
    PaGloabl_Event_Quiz_Minimal_Open()
  else
    PaGloabl_Event_Quiz_Minimal_Close()
  end
end
function FromClient_Event_Quiz_Minimal_QuizGameQuestionUpdate(questionStr)
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  if "" == questionStr then
    PaGlobal_Event_Quiz_Minimal._currentState = PaGlobal_Event_Quiz_Minimal._state._default
  else
    PaGlobal_Event_Quiz_Minimal._currentState = PaGlobal_Event_Quiz_Minimal._state._quiz
  end
  PaGlobal_Event_Quiz_Minimal:update()
end
function FromClient_Event_Quiz_Minimal_Response_QuizGameTimerAck(endTime)
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:setStartTimer()
end
function FromClient_Event_Quiz_Minimal_QuizGameAnswerAck(myAnswer, quizAnswer)
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal._currentState = PaGlobal_Event_Quiz_Minimal._state._result
  PaGlobal_Event_Quiz_Minimal:update()
end
