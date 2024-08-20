PaGlobal_ArousalTutorial_UiHeadlineMessage = {
  _ui = {
    _purposeText = UI.getChildControl(Panel_ArousalTutorial, "StaticText_Purpose"),
    _nextStep_1 = UI.getChildControl(Panel_ArousalTutorial, "StaticText_Step_1"),
    _nextStep_2 = UI.getChildControl(Panel_ArousalTutorial, "StaticText_Step_2"),
    _nextStep_3 = UI.getChildControl(Panel_ArousalTutorial, "StaticText_Step_3"),
    _nextStep_4 = UI.getChildControl(Panel_ArousalTutorial, "StaticText_Step_4"),
    _nextArrow_0 = UI.getChildControl(Panel_ArousalTutorial, "Static_NextArrow_0"),
    _nextArrow_1 = UI.getChildControl(Panel_ArousalTutorial, "Static_NextArrow_1"),
    _nextArrow_2 = UI.getChildControl(Panel_ArousalTutorial, "Static_NextArrow_2"),
    _clearStep_1 = UI.getChildControl(Panel_ArousalTutorial, "Static_Clear_Step1"),
    _clearStep_2 = UI.getChildControl(Panel_ArousalTutorial, "Static_Clear_Step2"),
    _clearStep_3 = UI.getChildControl(Panel_ArousalTutorial, "Static_Clear_Step3"),
    _clearStep_4 = UI.getChildControl(Panel_ArousalTutorial, "Static_Clear_Step4"),
    _mainBG = UI.getChildControl(Panel_ArousalTutorial, "Static_MainBG"),
    _descBox = UI.getChildControl(Panel_ArousalTutorial, "Static_DescBox"),
    _command = nil,
    _commentBox = UI.getChildControl(Panel_ArousalTutorial, "Static_CommentBox"),
    _comment = nil
  }
}
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_ArousalTutorial_UiHeadlineMessage")
function FromClient_luaLoadComplete_ArousalTutorial_UiHeadlineMessage()
  PaGlobal_ArousalTutorial_UiHeadlineMessage:initialize()
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:initialize()
  self._ui._command = UI.getChildControl(self._ui._descBox, "StaticText_Command")
  self._ui._comment = UI.getChildControl(self._ui._commentBox, "StaticText_Comment")
  if true == _ContentsGroup_RenewUI then
    self._ui._command:SetTextMode(__eTextMode_AutoWrap)
    self._ui._commentBox:SetSpanSize(self._ui._commentBox:GetSpanSize().x, self._ui._commentBox:GetSpanSize().y - 5)
    self._ui._commentBox:ComputePos()
  end
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setPurposeText(string)
  if nil == string then
    self._ui._purposeText:SetText("")
  else
    self._ui._purposeText:SetText(string)
  end
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setShow(key, isShow)
  self._ui[key]:SetShow(isShow)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setAlpha(key, value)
  self._ui[key]:SetAlpha(value)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:addEffect(key, effectName, isLoop, posX, posY)
  self._ui[key]:AddEffect(effectName, isLoop, posX, posY)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setShowAll(isShow)
  for key, value in pairs(self._ui) do
    value:SetShow(isShow)
  end
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setAlphaAll(value)
  for key, value in pairs(self._ui) do
    value:SetAlpha(value)
  end
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:setTextPurposeText(text)
  self._ui._purposeText:SetText(text)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:mainBGShow()
  self._ui._mainBG:SetShow(true)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:computePosAll()
  self._ui._purposeText:ComputePos()
  self._ui._nextStep_1:ComputePos()
  self._ui._nextStep_2:ComputePos()
  self._ui._nextStep_3:ComputePos()
  self._ui._nextStep_4:ComputePos()
  self._ui._nextArrow_0:ComputePos()
  self._ui._nextArrow_1:ComputePos()
  self._ui._nextArrow_2:ComputePos()
  self._ui._clearStep_1:ComputePos()
  self._ui._clearStep_2:ComputePos()
  self._ui._clearStep_3:ComputePos()
  self._ui._clearStep_4:ComputePos()
  self._ui._mainBG:ComputePos()
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:resetShowAll()
  self:computePosAll()
  self._ui._nextStep_1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_STEP1"))
  self._ui._nextStep_2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_STEP2"))
  self._ui._nextStep_3:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_STEP3"))
  self._ui._nextStep_4:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_STEP4"))
  self._ui._nextStep_1:SetTextMode(__eTextMode_AutoWrap)
  self._ui._nextStep_2:SetTextMode(__eTextMode_AutoWrap)
  self._ui._nextStep_3:SetTextMode(__eTextMode_AutoWrap)
  self._ui._nextStep_4:SetTextMode(__eTextMode_AutoWrap)
  self._ui._mainBG:SetSize(1000, 150)
  self._ui._nextStep_1:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_2:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_3:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_4:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_0:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_1:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_2:SetColor(Defines.Color.C_FFFFFFFF)
  self:setShowAll(true)
  self._ui._clearStep_1:SetShow(false)
  self._ui._clearStep_2:SetShow(false)
  self._ui._clearStep_3:SetShow(false)
  self._ui._clearStep_4:SetShow(false)
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:addClearStepEffect(clearCount)
  PaGlobal_TutorialUiManager:getUiHeadlineMessage()._ui._purposeText:AddEffect("fUI_Gauge_BigWhite", false, 0, 0)
  local uiClearStepKey, uiNextStepKey, uiNextArrow
  if 1 == clearCount then
    uiClearStepKey = "_clearStep_1"
    uiNextStepKey = "_nextStep_1"
    uiNextArrow = "_nextArrow_0"
  elseif 2 == clearCount then
    uiClearStepKey = "_clearStep_2"
    uiNextStepKey = "_nextStep_2"
    uiNextArrow = "_nextArrow_1"
  elseif 3 == clearCount then
    uiClearStepKey = "_clearStep_3"
    uiNextStepKey = "_nextStep_3"
    uiNextArrow = "_nextArrow_2"
  elseif 4 == clearCount then
    uiClearStepKey = "_clearStep_4"
    uiNextStepKey = "_nextStep_4"
    uiNextArrow = nil
  end
  self._ui[uiNextStepKey]:SetFontColor(Defines.Color.C_FFB5FF6D)
  self._ui[uiClearStepKey]:SetShow(true)
  self._ui[uiClearStepKey]:AddEffect("fUI_Light", false, 0, 0)
  self._ui[uiClearStepKey]:AddEffect("UI_Check01", false, -2, 0)
  self._ui[uiClearStepKey]:AddEffect("fL_CheckSpark01", false, -2, 0)
  if nil ~= uiNextArrow then
    self._ui[uiNextArrow]:SetColor(Defines.Color.C_FFB5FF6D)
  end
end
function PaGlobal_ArousalTutorial_UiHeadlineMessage:resetClearStepEffect()
  self:computePosAll()
  self._ui._nextStep_1:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_2:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_3:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextStep_4:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_0:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_1:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui._nextArrow_2:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui._clearStep_1:EraseAllEffect()
  self._ui._clearStep_2:EraseAllEffect()
  self._ui._clearStep_3:EraseAllEffect()
  self._ui._clearStep_4:EraseAllEffect()
  self._ui._clearStep_1:SetShow(false)
  self._ui._clearStep_2:SetShow(false)
  self._ui._clearStep_3:SetShow(false)
  self._ui._clearStep_4:SetShow(false)
end
