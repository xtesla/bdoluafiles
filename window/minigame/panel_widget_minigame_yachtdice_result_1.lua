function PaGlobal_MiniGame_YachtDice_Result:initialize()
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MiniGame_YachtDice_Result:clear()
  self._ui._stc_win:SetShow(false)
  self._ui._stc_lose:SetShow(false)
  self._ui._stc_tie:SetShow(false)
  self._ui._stc_win:EraseAllEffect()
  self._ui._stc_lose:EraseAllEffect()
  self._ui._stc_tie:EraseAllEffect()
  self._hostPoint = 0
  self._acceptorPoint = 0
end
function PaGlobal_MiniGame_YachtDice_Result:prepareOpen(hostPoint, acceptorPoint)
  self:open(hostPoint, acceptorPoint)
end
function PaGlobal_MiniGame_YachtDice_Result:open(hostPoint, acceptorPoint)
  if false == self._initialize then
    return
  end
  self:clear()
  if hostPoint < acceptorPoint then
    self._ui._stc_lose:SetShow(true)
    self._ui._stc_lose:AddEffect("fUI_Mini_Game_07A", true, 0, 0)
    audioPostEvent_SystemUi(11, 121)
  elseif acceptorPoint < hostPoint then
    self._ui._stc_win:SetShow(true)
    self._ui._stc_win:AddEffect("fUI_Mini_Game_08A", true, 0, 0)
    audioPostEvent_SystemUi(11, 120)
  else
    self._ui._stc_tie:SetShow(true)
    self._ui._stc_tie:AddEffect("fUI_Mini_Game_08A", true, 0, 0)
    audioPostEvent_SystemUi(11, 121)
  end
  self._hostPoint = hostPoint
  self._acceptorPoint = acceptorPoint
  PaGlobal_MiniGame_YachtDice:endGame()
  Panel_Widget_MiniGame_YachtDice_Result:SetShow(true)
end
function PaGlobal_MiniGame_YachtDice_Result:prepareClose()
  self:close()
end
function PaGlobal_MiniGame_YachtDice_Result:close()
  Panel_Widget_MiniGame_YachtDice_Result:SetShow(false)
end
function PaGlobal_MiniGame_YachtDice_Result:validate()
  self._ui._stc_win:isValidate()
  self._ui._stc_lose:isValidate()
  self._ui._stc_tie:isValidate()
  self._ui._stc_reward:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._btn_retry:isValidate()
end
function PaGlobal_MiniGame_YachtDice_Result:registerEvent()
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:prepareClose()")
  self._ui._btn_retry:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice_Result:retry()")
  registerEvent("FromClient_responseYachtDiceGameStop", "FromClient_responseYachtDiceGameStop")
end
function PaGlobal_MiniGame_YachtDice_Result:retry()
  self:prepareClose()
  FromClient_DialogFunctionClick_Contents_YachtDice()
end
