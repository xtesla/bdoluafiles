function PaGlobal_Event_Quiz:initialize()
  if true == PaGlobal_Event_Quiz._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_MainBG = UI.getChildControl(Panel_Event_Quiz, "StaticText_Main_BG")
  self._ui._txt_questionStr = UI.getChildControl(self._ui._stc_MainBG, "MultilineText_1")
  self._ui._stc_TimeBG = UI.getChildControl(Panel_Event_Quiz, "Static_Time_BG")
  self._ui._stc_AnswerBG = UI.getChildControl(Panel_Event_Quiz, "Static_OX_BG")
  self._ui._stc_O = UI.getChildControl(self._ui._stc_AnswerBG, "Static_O")
  self._ui._stc_O_select = UI.getChildControl(self._ui._stc_O, "StaticText_Select")
  self._ui._stc_X = UI.getChildControl(self._ui._stc_AnswerBG, "Static_X")
  self._ui._stc_X_select = UI.getChildControl(self._ui._stc_X, "StaticText_Select")
  self._ui._stc_Black_Normal = UI.getChildControl(self._ui._stc_AnswerBG, "Static_Black_Normal")
  self._ui._stc_Black_Select_O = UI.getChildControl(self._ui._stc_AnswerBG, "Static_Black_Select_O")
  self._ui._stc_Black_Select_X = UI.getChildControl(self._ui._stc_AnswerBG, "Static_Black_Select_X")
  self._ui._stc_ResultBG = UI.getChildControl(Panel_Event_Quiz, "Static_Result_BG")
  self._ui._txt_Answer = UI.getChildControl(self._ui._stc_ResultBG, "StaticText_Answer")
  self._ui._txt_AnswerStr = UI.getChildControl(self._ui._txt_Answer, "MultilineText_1")
  self._ui._stc_Icon_O = UI.getChildControl(self._ui._txt_Answer, "Static_O")
  self._ui._stc_Icon_X = UI.getChildControl(self._ui._txt_Answer, "Static_X")
  self._ui._stc_Correct = UI.getChildControl(self._ui._stc_ResultBG, "StaticText_Correct_BG")
  self._ui._stc_Correct_O = UI.getChildControl(self._ui._stc_Correct, "Static_Black_Answer_O")
  self._ui._stc_Correct_X = UI.getChildControl(self._ui._stc_Correct, "Static_Black_Anser_X")
  self._ui._stc_Wrong = UI.getChildControl(self._ui._stc_ResultBG, "StaticText_Wrong_BG")
  self._ui._stc_Wrong_O = UI.getChildControl(self._ui._stc_Wrong, "Static_Black_Answer_O")
  self._ui._stc_Wrong_X = UI.getChildControl(self._ui._stc_Wrong, "Static_Black_Anser_X")
  self._ui._progress_time = UI.getChildControl(self._ui._stc_TimeBG, "Progress2_1")
  local stc_desc = UI.getChildControl(Panel_Event_Quiz, "Static_DescBox")
  self._ui._txt_Desc = UI.getChildControl(stc_desc, "StaticText_Desc")
  local stc_TitleBg = UI.getChildControl(Panel_Event_Quiz, "StaticText_Title_BG")
  self._pc._btn_TitleClose = UI.getChildControl(stc_TitleBg, "Button_Close_PCUI")
  local stc_Pcui = UI.getChildControl(Panel_Event_Quiz, "Static_Button_BG_PCUI")
  self._pc._btn_Confirm = UI.getChildControl(stc_Pcui, "Button_Confirm")
  self._pc._btn_Close = UI.getChildControl(stc_Pcui, "Button_Close")
  self._console._stc_bottomKeyGuideBg = UI.getChildControl(Panel_Event_Quiz, "Static_BottomBg_ConsoleUI")
  local stc_FlipBg = UI.getChildControl(self._ui._stc_TimeBG, "Static_Flip_BG")
  for index = 1, 4 do
    self._ui._txt_TimerFront[index] = UI.getChildControl(stc_FlipBg, "StaticText_Front" .. index)
    self._ui._txt_TimerBack[index] = UI.getChildControl(stc_FlipBg, "StaticText_Back" .. index)
    self._ui._txt_TimerBack[index]:SetShow(false)
  end
  self:switchPlatform()
  self:registEventHandler()
  self:validate()
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_GMEVENT_DESC"))
  self._initialize = true
end
function PaGlobal_Event_Quiz:switchPlatform()
  if true == self._isConsole then
    self._console._stc_bottomKeyGuideBg:SetShow(true)
    local keyGuideConfirm = UI.getChildControl(self._console._stc_bottomKeyGuideBg, "StaticText_ReceiveAll_ConsoleUI")
    local keyGuideSelect = UI.getChildControl(self._console._stc_bottomKeyGuideBg, "Button_A_ConsoleUI")
    local keyGuideClose = UI.getChildControl(self._console._stc_bottomKeyGuideBg, "Button_B_ConsoleUI")
    local tempBtnGroup = {
      keyGuideConfirm,
      keyGuideSelect,
      keyGuideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._console._stc_bottomKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._pc._btn_TitleClose:SetShow(false)
    self._pc._btn_Confirm:SetShow(false)
    self._pc._btn_Close:SetShow(false)
  else
    self._console._stc_bottomKeyGuideBg:SetShow(false)
    self._pc._btn_TitleClose:SetShow(true)
    self._pc._btn_Confirm:SetShow(true)
    self._pc._btn_Close:SetShow(true)
  end
end
function PaGlobal_Event_Quiz:registEventHandler()
  if nil == Panel_Event_Quiz then
    return
  end
  registerEvent("FromClient_Response_QuizGameQuestionAck", "FromClient_Event_Quiz_QuizGameQuestionUpdate")
  registerEvent("FromClient_Response_QuizGameTimerAck", "FromClient_Event_Quiz_Response_QuizGameTimerAck")
  registerEvent("FromClient_Response_QuizGameAnswerAck", "FromClient_Event_Quiz_QuizGameAnswerAck")
  if true == self._isConsole then
    Panel_Event_Quiz:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEvent_LUp_Event_Quiz_ConfirmAnswer()")
  else
    self._pc._btn_TitleClose:addInputEvent("Mouse_LUp", "PaGloabl_Event_Quiz_Close()")
    self._pc._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_Event_Quiz_Close()")
    self._pc._btn_Confirm:addInputEvent("Mouse_LUp", "HandleEvent_LUp_Event_Quiz_ConfirmAnswer()")
  end
end
function PaGlobal_Event_Quiz:prepareOpen()
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:open()
end
function PaGlobal_Event_Quiz:open()
  if nil == Panel_Event_Quiz then
    return
  end
  Panel_Event_Quiz:SetShow(true)
end
function PaGlobal_Event_Quiz:prepareClose()
  if nil == Panel_Event_Quiz then
    return
  end
  PaGlobal_Event_Quiz:close()
end
function PaGlobal_Event_Quiz:close()
  if nil == Panel_Event_Quiz then
    return
  end
  Panel_Event_Quiz:SetShow(false)
end
function PaGlobal_Event_Quiz:setQuestionString(questionStr)
  if nil == Panel_Event_Quiz then
    return
  end
  if "" == questionStr then
    PaGlobal_Event_Quiz:blackNormalSetting()
    PaGlobal_Event_Quiz:timerNumSet(0)
    self._isTimerStart = false
    return
  end
  self._currentState = self._state._quiz
  self._ui._stc_MainBG:SetShow(true)
  self._ui._stc_TimeBG:SetShow(true)
  self._ui._stc_AnswerBG:SetShow(true)
  self._ui._stc_ResultBG:SetShow(false)
  self._ui._txt_questionStr:SetText(questionStr)
  self._ui._stc_O_select:SetShow(false)
  self._ui._stc_X_select:SetShow(false)
  self._pc._btn_Confirm:SetEnable(true)
  self._isConfirm = false
  PaGlobal_Event_Quiz:timerNumSet(0)
  self._ui._stc_O:addInputEvent("Mouse_LUp", "HandleEvent_LUp_Event_Quiz_SelectAnswer(" .. 1 .. ")")
  self._ui._stc_X:addInputEvent("Mouse_LUp", "HandleEvent_LUp_Event_Quiz_SelectAnswer(" .. 2 .. ")")
end
function PaGlobal_Event_Quiz:setTimer(endTime)
  if nil == Panel_Event_Quiz then
    return
  end
  if endTime <= 0 then
    return
  end
  self._endTime = endTime
  self._elapsedTime = endTime
  self._isTimerStart = true
end
function PaGlobal_Event_Quiz:updateTimer(deltaTime)
  if nil == Panel_Event_Quiz then
    return
  end
  if false == self._isTimerStart and 0 == self._endTime then
    return
  end
  if true == self._isTimerStart then
    self._elapsedTime = self._elapsedTime - deltaTime
    local percent = self._elapsedTime / self._endTime * 100
    if self._endTime ~= 0 then
      self._ui._progress_time:SetProgressRate(percent)
    end
    PaGloabl_Event_Quiz_Minimal_UpdateTimer(percent)
    self._timeNumUpdateTime = self._timeNumUpdateTime + deltaTime
    if self._timeNumUpdateTime >= 1 then
      self._timeNumUpdateTime = 0
      PaGlobal_Event_Quiz:timerNumSet(self._elapsedTime)
    end
    if 0 >= self._elapsedTime then
      PaGlobal_Event_Quiz:timerNumSet(self._elapsedTime)
      self._isTimerStart = false
    end
  else
    self._elapsedTime = 0
    self._endTime = 0
    self._ui._progress_time:SetProgressRate(0)
    PaGloabl_Event_Quiz_Minimal_SetEndTimer()
    if false == self._isConfirm then
      PaGlobal_Event_Quiz:confirmAnswer()
    end
  end
end
function PaGlobal_Event_Quiz:showResult(myAnswer, quizAnswer)
  if nil == Panel_Event_Quiz then
    return
  end
  self._currentState = self._state._result
  self._ui._stc_MainBG:SetShow(false)
  self._ui._stc_TimeBG:SetShow(false)
  self._ui._stc_AnswerBG:SetShow(false)
  self._ui._stc_ResultBG:SetShow(true)
  self._ui._stc_Correct_O:SetShow(false)
  self._ui._stc_Correct_X:SetShow(false)
  self._ui._stc_Wrong_O:SetShow(false)
  self._ui._stc_Wrong_X:SetShow(false)
  if myAnswer == quizAnswer then
    if __eQuizAnswerType_OX_O == myAnswer then
      self._ui._stc_Correct_O:SetShow(true)
    else
      self._ui._stc_Correct_X:SetShow(true)
    end
    self._ui._stc_Correct:SetShow(true)
    self._ui._stc_O_select:SetShow(true)
    self._ui._stc_Icon_O:SetShow(true)
    self._ui._stc_Wrong:SetShow(false)
    self._ui._stc_X_select:SetShow(false)
    self._ui._stc_Icon_X:SetShow(false)
    self._ui._txt_AnswerStr:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_OXQUIZ_O"))
  else
    if __eQuizAnswerType_OX_O == myAnswer then
      self._ui._stc_Wrong_O:SetShow(true)
    else
      self._ui._stc_Wrong_X:SetShow(true)
    end
    self._ui._stc_Correct:SetShow(false)
    self._ui._stc_O_select:SetShow(false)
    self._ui._stc_Icon_O:SetShow(false)
    self._ui._stc_Wrong:SetShow(true)
    self._ui._stc_X_select:SetShow(true)
    self._ui._stc_Icon_X:SetShow(true)
    self._ui._txt_AnswerStr:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_OXQUIZ_X"))
  end
end
function PaGlobal_Event_Quiz:blackNormalSetting()
  if nil == Panel_Event_Quiz then
    return
  end
  self._ui._stc_MainBG:SetShow(true)
  self._ui._stc_TimeBG:SetShow(true)
  self._ui._stc_AnswerBG:SetShow(true)
  self._pc._btn_Confirm:SetEnable(true)
  self._ui._stc_ResultBG:SetShow(false)
  self._ui._stc_Black_Normal:SetShow(true)
  self._ui._stc_Black_Select_O:SetShow(false)
  self._ui._stc_Black_Select_X:SetShow(false)
  self._ui._stc_O_select:SetShow(false)
  self._ui._stc_X_select:SetShow(false)
  self._ui._stc_O:addInputEvent("Mouse_LUp", "")
  self._ui._stc_X:addInputEvent("Mouse_LUp", "")
  self._ui._txt_questionStr:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_OXQUIZ_READY"))
  PaGlobal_Event_Quiz:timerNumSet(0)
  self._isConfirm = true
end
function PaGlobal_Event_Quiz:confirmAnswer()
  if nil == Panel_Event_Quiz then
    return
  end
  if true == self._isConfirm then
    return
  end
  local selectAnswer = __eQuizAnswerType_OX_None
  if true == PaGlobal_Event_Quiz._ui._stc_O_select:GetShow() then
    selectAnswer = __eQuizAnswerType_OX_O
  elseif true == PaGlobal_Event_Quiz._ui._stc_X_select:GetShow() then
    selectAnswer = __eQuizAnswerType_OX_X
  end
  if __eQuizAnswerType_OX_None == selectAnswer then
    return
  end
  local isSuccess = ToClient_DoQuizAction(selectAnswer)
  ToClient_SetRestrictAction(isSuccess)
  self._ui._stc_O:addInputEvent("Mouse_LUp", "")
  self._ui._stc_X:addInputEvent("Mouse_LUp", "")
  self._pc._btn_Confirm:SetEnable(false)
  self._isConfirm = true
end
function PaGlobal_Event_Quiz:timerNumSet(elapsedTime)
  if nil == Panel_Event_Quiz then
    return
  end
  if elapsedTime < 0 then
    elapsedTime = 0
  end
  local time = math.floor(elapsedTime)
  local num_1 = 0
  local num_2 = 0
  local num_3 = 0
  local num_4 = 0
  num_1 = math.floor(time / 600)
  time = time - 60 * num_1 * 10
  num_2 = math.floor(time / 60)
  time = time - 60 * num_2
  num_3 = math.floor(time / 10)
  time = time - 10 * num_3
  num_4 = time
  self._ui._txt_TimerFront[1]:SetText(tostring(num_1))
  self._ui._txt_TimerFront[2]:SetText(tostring(num_2))
  self._ui._txt_TimerFront[3]:SetText(tostring(num_3))
  self._ui._txt_TimerFront[4]:SetText(tostring(num_4))
end
function PaGlobal_Event_Quiz:validate()
  if nil == Panel_Event_Quiz then
    return
  end
  self._ui._stc_MainBG:isValidate()
  self._ui._txt_questionStr:isValidate()
  self._ui._stc_TimeBG:isValidate()
  self._ui._stc_AnswerBG:isValidate()
  self._ui._stc_ResultBG:isValidate()
  self._ui._txt_Answer:isValidate()
  self._ui._stc_Correct:isValidate()
  self._ui._stc_Wrong:isValidate()
  self._ui._stc_O:isValidate()
  self._ui._stc_X:isValidate()
end
