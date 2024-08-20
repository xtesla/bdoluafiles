function FromClient_responseYachtDiceGameStart()
  local self = PaGlobal_MiniGame_YachtDice
  if false == self:initHandRankList() then
    return
  end
  self:updateRecordInfo()
  self:updatePoint()
  self:updateRollCount()
  self._ui._stc_msgPhase:SetShow(false)
  self._ui._stc_keyGuideBG:SetShow(true)
  self._isStartGame = true
  if true == self._isConsole then
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_MiniGame_YachtDice:doRoll()")
  else
    self._ui._btn_roll:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:doRoll()")
  end
  self:eventStartHandRank(false)
end
function FromClient_responseYachtDiceGameKeepCard(index, isKeep)
  PaGlobal_MiniGame_YachtDice:updateKeepCard(index, isKeep)
end
function FromClient_responseYachtDiceGameRoll()
  local self = PaGlobal_MiniGame_YachtDice
  self:updateFieldCard()
  self:updateRollCount()
  self:updateRollCardList()
end
function FromClient_responseYachtDiceGameCheckHand(key, isSelf, point)
  local self = PaGlobal_MiniGame_YachtDice
  self:updateCheckHandEffect(key, isSelf, point)
  self:updatePoint()
  self:updateTotalPoint()
end
function FromClient_responseYachtDiceGameUpdateTurn()
  local self = PaGlobal_MiniGame_YachtDice
  self:clearRenderValue()
  self:hideAllFieldCard()
  self:updatePoint()
  self:updateTurnBG()
  self:updateRollCount()
  self:eventStartChangeTurn()
end
function FromClient_showYachtDiceGameUI()
  PaGlobal_MiniGame_YachtDice:prepareOpen()
end
function FromClient_responseYachtDiceGameNPCDataList(isPlayerTimeOut)
  local self = PaGlobal_MiniGame_YachtDice
  self:clearRenderValue()
  self._isTimeOut = isPlayerTimeOut
  self:hideAllFieldCard()
  self:updatePoint()
  self:updateTurnBG()
  self:loadCompleteNpcAction()
end
function PaGlobalFunc_MiniGame_YachtDice_Update(deltaTime)
  local self = PaGlobal_MiniGame_YachtDice
  self:renderEventHandRank(deltaTime)
  self:renderEventBeforeGameStart(deltaTime)
  self:renderEventDrawFieldCard(deltaTime)
  self:renderEventChangeTurn(deltaTime)
  self:renderEventKeep(deltaTime)
  self:updateNpcActionEvent(deltaTime)
  self:updateTimer(deltaTime)
  self:updateKeyInput(deltaTime)
end
function PaGlobalFunc_MiniGame_YachtDice_ForceHide()
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  if false == Panel_Window_MiniGame_YachtDice:GetShow() then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:prepareClose()
end
