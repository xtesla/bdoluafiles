function PaGloabl_Event_Quiz_Open()
  if nil == Panel_Event_Quiz then
    return
  end
  if PaGlobal_Event_Quiz._currentState == PaGlobal_Event_Quiz._state._default then
    PaGlobal_Event_Quiz:blackNormalSetting()
  end
  PaGlobal_Event_Quiz:prepareOpen()
  PaGloabl_Event_Quiz_Minimal_Close()
end
function PaGloabl_Event_Quiz_Close()
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:prepareClose()
  PaGloabl_Event_Quiz_Minimal_Open()
end
function FromClient_Event_Quiz_QuizGameQuestionUpdate(questionStr)
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:setQuestionString(questionStr)
  PaGloabl_Event_Quiz_Open()
end
function FromClient_Event_Quiz_Response_QuizGameTimerAck(endTime)
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:setTimer(endTime)
end
function PaGlobal_Event_Quiz_UpdateFrameEvent(deltaTime)
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:updateTimer(deltaTime)
end
function FromClient_Event_Quiz_QuizGameAnswerAck(myAnswer, quizAnswer)
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:showResult(myAnswer, quizAnswer)
  PaGloabl_Event_Quiz_Open()
end
function HandleEvent_LUp_Event_Quiz_SelectAnswer(selectAnswer)
  if nil == Panel_Event_Quiz then
    return
  end
  if __eQuizAnswerType_OX_O == selectAnswer then
    PaGlobal_Event_Quiz._ui._stc_O_select:SetShow(true)
    PaGlobal_Event_Quiz._ui._stc_X_select:SetShow(false)
    PaGlobal_Event_Quiz._ui._stc_Black_Normal:SetShow(false)
    PaGlobal_Event_Quiz._ui._stc_Black_Select_O:SetShow(true)
    PaGlobal_Event_Quiz._ui._stc_Black_Select_X:SetShow(false)
  elseif __eQuizAnswerType_OX_X == selectAnswer then
    PaGlobal_Event_Quiz._ui._stc_O_select:SetShow(false)
    PaGlobal_Event_Quiz._ui._stc_X_select:SetShow(true)
    PaGlobal_Event_Quiz._ui._stc_Black_Normal:SetShow(false)
    PaGlobal_Event_Quiz._ui._stc_Black_Select_O:SetShow(false)
    PaGlobal_Event_Quiz._ui._stc_Black_Select_X:SetShow(true)
  end
end
function HandleEvent_LUp_Event_Quiz_ConfirmAnswer()
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:confirmAnswer()
end
