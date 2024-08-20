function PaGlobal_Event_QuizGM:initialize()
  if true == PaGlobal_Event_QuizGM._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBG = UI.getChildControl(Panel_Event_QuizGM, "StaticText_Title_BG")
  self._ui._btn_Close = UI.getChildControl(titleBG, "Button_Close")
  self._ui._stc_MainBG = UI.getChildControl(Panel_Event_QuizGM, "StaticText_Main_BG")
  self._ui._edit_question = UI.getChildControl(self._ui._stc_MainBG, "MultilineEdit_1")
  self._ui._edit_question:SetMaxInput(500)
  self._ui._edit_question:SetMaxEditLine(5)
  self._ui._edit_question:SetTextMode(__eTextMode_AutoWrap)
  local stc_answerGroup = UI.getChildControl(Panel_Event_QuizGM, "Static_TemplateRadioBtnGroup")
  self._ui._rdo_answer_O = UI.getChildControl(stc_answerGroup, "RadioButton_O")
  self._ui._rdo_answer_X = UI.getChildControl(stc_answerGroup, "RadioButton_X")
  self._ui._btn_sendQuestion = UI.getChildControl(Panel_Event_QuizGM, "Button_Confirm")
  self._ui._btn_answerPick = UI.getChildControl(Panel_Event_QuizGM, "Button_AnswerPick")
  self._ui._btn_answerConfirm = UI.getChildControl(Panel_Event_QuizGM, "Button_AnswerConfirm")
  self._ui._btn_kickFail = UI.getChildControl(Panel_Event_QuizGM, "Button_KickFail")
  self._ui._btn_endGame = UI.getChildControl(Panel_Event_QuizGM, "Button_End")
  self._ui._btn_enterDisable = UI.getChildControl(Panel_Event_QuizGM, "Button_EnterDisable")
  self._ui._btn_setTimer = UI.getChildControl(Panel_Event_QuizGM, "Button_Timer")
  self._ui._txt_SetTimer = UI.getChildControl(Panel_Event_QuizGM, "StaticText_Timer")
  self._ui._edit_Timer = UI.getChildControl(self._ui._txt_SetTimer, "MultiLineEdit_Timer")
  self._ui._edit_Timer:SetMaxInput(2)
  self._ui._edit_Timer:SetEditText("--")
  self._ui._edit_Timer:SetMaxEditLine(1)
  self._ui._edit_Timer:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_CurTimer = UI.getChildControl(Panel_Event_QuizGM, "StaticText_Cur_Timer")
  self._ui._txt_playerCount = UI.getChildControl(Panel_Event_QuizGM, "StaticText_PlayerCount")
  self._ui._btn_invalidity = UI.getChildControl(Panel_Event_QuizGM, "Button_Invalidity")
  self:registEventHandler()
  self:validate()
  self:registMarkUI()
  self._initialize = true
end
function PaGlobal_Event_QuizGM:registEventHandler()
  if nil == Panel_Event_QuizGM then
    return
  end
  registerEvent("FromClient_Response_QuizGameOperation", "FromClient_Response_QuizGameOperationSuccess")
  registerEvent("FromClient_Response_QuizGameTimerAck", "FromClient_Response_QuizGM_QuizGameTimerAck")
  registerEvent("FromClient_ShowQuizGameGMUI", "FromClient_ShowQuizGameGMUI_OnOff")
  if true == self._isConsole then
    self._ui._btn_Close:SetShow(false)
    self._ui._edit_question:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Event_QuizGM_QuestionSetFocusEdit()")
    self._ui._edit_question:setXboxVirtualKeyBoardEndEvent("HandleKeyEvent_Event_QuizGM_QuestionKeyBoardEndEvent")
    self._ui._edit_Timer:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Event_QuizGM_TimeSetFocusEdit()")
    self._ui._edit_Timer:setXboxVirtualKeyBoardEndEvent("HandleKeyEvent_Event_QuizGM_TimeKeyBoardEndEvent")
  else
    self._ui._btn_Close:SetShow(true)
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Event_QuizGM_Close()")
  end
  self._ui._rdo_answer_O:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_SetAnswerType(" .. self.eQuizAnswerType.eQuizAnswerType_OX_O .. ")")
  self._ui._rdo_answer_X:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_SetAnswerType(" .. self.eQuizAnswerType.eQuizAnswerType_OX_X .. ")")
  self._ui._btn_sendQuestion:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_SendQuestion()")
  self._ui._btn_answerPick:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_SetAnswer .. ")")
  self._ui._btn_answerConfirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_CheckAnswer .. ")")
  self._ui._btn_kickFail:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_KickPlayer .. ")")
  self._ui._btn_endGame:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_EndQuizGame .. ")")
  self._ui._btn_enterDisable:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_SetEnterAble .. "," .. 0 .. ")")
  self._ui._btn_setTimer:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_SetTimer .. ")")
  self._ui._btn_invalidity:addInputEvent("Mouse_LUp", "HandleEventLUp_Event_QuizGM_RequestOperation(" .. self.eQuizGameOperationType.eQuizGameOperationType_Invalidity .. ")")
end
function PaGlobal_Event_QuizGM:prepareOpen()
  if nil == Panel_Event_QuizGM then
    return
  end
  Panel_Event_QuizGM:RegisterUpdateFunc("PaGlobal_Event_QuizGM_UpdateFrameEvent")
  if self.eQuizAnswerType.eQuizAnswerType_OX_O == self._answerType then
    self._ui._rdo_answer_O:SetCheck(true)
  elseif self.eQuizAnswerType.eQuizAnswerType_OX_X == self._answerType then
    self._ui._rdo_answer_X:SetCheck(true)
  end
  PaGlobal_Event_QuizGM:open()
end
function PaGlobal_Event_QuizGM:open()
  if nil == Panel_Event_QuizGM then
    return
  end
  Panel_Event_QuizGM:SetShow(true)
end
function PaGlobal_Event_QuizGM:prepareClose()
  if nil == Panel_Event_QuizGM then
    return
  end
  self:clearData()
  Panel_Event_QuizGM:ClearUpdateLuaFunc()
  PaGlobal_Event_QuizGM:close()
end
function PaGlobal_Event_QuizGM:close()
  if nil == Panel_Event_QuizGM then
    return
  end
  Panel_Event_QuizGM:SetShow(false)
end
function PaGlobal_Event_QuizGM:validate()
  if nil == Panel_Event_QuizGM then
    return
  end
  self._ui._stc_MainBG:isValidate()
  self._ui._edit_question:isValidate()
  self._ui._rdo_answer_O:isValidate()
  self._ui._rdo_answer_X:isValidate()
  self._ui._btn_sendQuestion:isValidate()
  self._ui._btn_answerPick:isValidate()
  self._ui._btn_answerConfirm:isValidate()
  self._ui._btn_kickFail:isValidate()
  self._ui._btn_endGame:isValidate()
  self._ui._btn_enterDisable:isValidate()
  self._ui._btn_setTimer:isValidate()
  self._ui._txt_SetTimer:isValidate()
  self._ui._edit_Timer:isValidate()
  self._ui._txt_CurTimer:isValidate()
end
function PaGlobal_Event_QuizGM:clearData()
  if nil == Panel_Event_QuizGM then
    return
  end
  self._ui._edit_question:SetEditText("")
  self._ui._rdo_answer_O:SetCheck(false)
  self._ui._rdo_answer_X:SetCheck(false)
  self._ui._txt_SetTimer:SetText("")
  self._ui._txt_CurTimer:SetText("")
  self._elapsedTime = 0
  self._endTime = 0
  for idx = 0, #self._markButtonUI do
    if nil ~= self._markButtonUI[idx] then
      self._markButtonUI[idx]:SetColor(Defines.Color.C_FFFFFFFF)
    end
  end
end
function PaGlobal_Event_QuizGM:setTimer(endTime)
  if nil == Panel_Event_QuizGM then
    return
  end
  self._endTime = endTime
  self._elapsedTime = endTime
end
function PaGlobal_Event_QuizGM:updateTimer(deltaTime)
  if nil == Panel_Event_QuizGM then
    return
  end
  if 0 < self._elapsedTime then
    self._elapsedTime = self._elapsedTime - deltaTime
    if self._endTime ~= 0 then
      local timeStr = string.format("%d", self._elapsedTime)
      self._ui._txt_CurTimer:SetText(timeStr)
    end
  else
    self._elapsedTime = 0
    self._endTime = 0
    self._ui._txt_CurTimer:SetText("--")
  end
  self._syncPlayerElapsedTime = self._syncPlayerElapsedTime + deltaTime
  if self._syncPlayerElapsedTime > 5 then
    self._syncPlayerElapsedTime = 0
    ToClient_RequestQuizGameOperation(self.eQuizGameOperationType.eQuizGameOperationType_SyncPlayerCount, 0, "")
  end
end
function PaGlobal_Event_QuizGM:setPlayerCount(playerCount)
  if nil == Panel_Event_QuizGM then
    return
  end
  local str = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_JOINMEMBER_TITLE")
  self._ui._txt_playerCount:SetText(str .. " : " .. tostring(playerCount))
end
function PaGlobal_Event_QuizGM:registMarkUI()
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_NotifyQuestion] = self._ui._btn_sendQuestion
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_SetAnswer] = self._ui._btn_answerPick
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_CheckAnswer] = self._ui._btn_answerConfirm
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_SetTimer] = self._ui._btn_setTimer
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_KickPlayer] = self._ui._btn_kickFail
  self._markButtonUI[self.eQuizGameOperationType.eQuizGameOperationType_EndQuizGame] = self._ui._btn_endGame
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_NotifyQuestion] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_NOTIFY_QUESTION")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_SetAnswer] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_PICK_ANSWER")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_CheckAnswer] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_CONFIRM_ANSWER")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_SetTimer] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_NOTIFY_TIMER")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_KickPlayer] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_KICK_FAIL")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_EndQuizGame] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_END_GAME")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_SetEnterAble] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_DISABLE_ENTER")
  self._operationNames[self.eQuizGameOperationType.eQuizGameOperationType_Invalidity] = PAGetString(Defines.StringSheet_RESOURCE, "LUA_QUIZGM_INVALIDITY_ROUND")
end
function PaGlobal_Event_QuizGM:markButtonUI(operationType)
  if nil == Panel_Event_QuizGM then
    return
  end
  if nil == operationType then
    return
  end
  local control = self._markButtonUI[operationType]
  if nil == control then
    return
  end
  control:SetColor(Defines.Color.C_FFFFD46D)
end
function PaGlobal_Event_QuizGM:getOperationName(operationType)
  if nil == Panel_Event_QuizGM then
    return ""
  end
  if nil == operationType then
    return ""
  end
  local operationName = self._operationNames[operationType]
  if nil == operationName then
    return ""
  end
  return operationName
end
function PaGlobal_Event_QuizGM:getOperationParamAndStr(operationType)
  if nil == Panel_Event_QuizGM then
    return 0, ""
  end
  local operationParam = 0
  local operationStr = ""
  if self.eQuizGameOperationType.eQuizGameOperationType_SetAnswer == operationType then
    operationParam = self._answerType
    if self.eQuizAnswerType.eQuizAnswerType_OX_O == operationParam then
      operationStr = "O"
    elseif self.eQuizAnswerType.eQuizAnswerType_OX_X == operationParam then
      operationStr = "X"
    end
  elseif self.eQuizGameOperationType.eQuizGameOperationType_SetTimer == operationType then
    local timeStr = self._ui._edit_Timer:GetEditText()
    local timeValue = tonumber(timeStr)
    if nil == timeValue then
      _PA_ASSERT(false, "\236\136\171\236\158\144\235\167\140 \235\132\163\236\150\180\236\163\188\236\132\184\236\154\148!!")
      return 0, ""
    end
    operationParam = timeValue
    operationStr = timeStr
  elseif self.eQuizGameOperationType.eQuizGameOperationType_SetPlayerCount == operationType then
    local playerCountStr = self._ui._edit_playerCount:GetEditText()
    local playerCount = tonumber(playerCountStr)
    if nil == playerCount then
      _PA_ASSERT(false, "\236\136\171\236\158\144\235\167\140 \235\132\163\236\150\180\236\163\188\236\132\184\236\154\148!!")
      return 0, ""
    end
    operationParam = playerCount
    operationStr = tostring(playerCount)
  elseif self.eQuizGameOperationType.eQuizGameOperationType_SetEnterAble == operationType then
    operationParam = 0
    operationStr = ""
  end
  return operationParam, operationStr
end
