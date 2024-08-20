function PaGlobal_Event_Quiz_Minimal:initialize()
  if true == PaGlobal_Event_Quiz_Minimal._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._progress_Bg = UI.getChildControl(Panel_Event_Quiz_Minimal, "Static_Progress_BG")
  self._ui._progressBar = UI.getChildControl(Panel_Event_Quiz_Minimal, "CircularProgress_1")
  self._ui._stc_wait = UI.getChildControl(Panel_Event_Quiz_Minimal, "Static_Black_Wait")
  self._ui._stc_ing = UI.getChildControl(Panel_Event_Quiz_Minimal, "Static_Black_ING")
  self._ui._stc_openQuize = UI.getChildControl(Panel_Event_Quiz_Minimal, "StaticText_WindowOpen_ConsoleUI")
  PaGlobal_Event_Quiz_Minimal:registEventHandler()
  if true == self._isConsole then
    self._ui._stc_openQuize:SetShow(true)
  else
    self._ui._stc_openQuize:SetShow(false)
  end
  PaGlobal_Event_Quiz_Minimal:validate()
  PaGlobal_Event_Quiz_Minimal._initialize = true
end
function PaGlobal_Event_Quiz_Minimal:registEventHandler()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  self._ui._progress_Bg:addInputEvent("Mouse_LUp", "PaGloabl_Event_Quiz_Open()")
  registerEvent("selfPlayer_regionChanged", "FromClient_Event_Quiz_Minimal_LoadFieldCompleteAck")
  registerEvent("FromClient_Response_QuizGameQuestionAck", "FromClient_Event_Quiz_Minimal_QuizGameQuestionUpdate")
  registerEvent("FromClient_Response_QuizGameTimerAck", "FromClient_Event_Quiz_Minimal_Response_QuizGameTimerAck")
  registerEvent("FromClient_Response_QuizGameAnswerAck", "FromClient_Event_Quiz_Minimal_QuizGameAnswerAck")
end
function PaGlobal_Event_Quiz_Minimal:prepareOpen()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:update()
  PaGlobal_Event_Quiz_Minimal:open()
end
function PaGlobal_Event_Quiz_Minimal:open()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  Panel_Event_Quiz_Minimal:SetShow(true)
end
function PaGlobal_Event_Quiz_Minimal:prepareClose()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  PaGlobal_Event_Quiz_Minimal:close()
end
function PaGlobal_Event_Quiz_Minimal:close()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  Panel_Event_Quiz_Minimal:SetShow(false)
end
function PaGlobal_Event_Quiz_Minimal:update()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  if self._state._quiz == self._currentState then
    self._ui._stc_wait:SetShow(false)
    self._ui._stc_ing:SetShow(true)
  else
    self._ui._stc_wait:SetShow(true)
    self._ui._stc_ing:SetShow(false)
  end
end
function PaGlobal_Event_Quiz_Minimal:setStartTimer()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  self._ui._progressBar:SetProgressRate(0)
  self._ui._progressBar:SetShow(true)
end
function PaGlobal_Event_Quiz_Minimal:setEndTimer()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  self._ui._progressBar:SetProgressRate(0)
  self._ui._progressBar:SetShow(false)
end
function PaGlobal_Event_Quiz_Minimal:updateTimer(percent)
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
  self._ui._progressBar:SetProgressRate(100 - percent)
end
function PaGlobal_Event_Quiz_Minimal:validate()
  if nil == Panel_Event_Quiz_Minimal then
    return
  end
end
