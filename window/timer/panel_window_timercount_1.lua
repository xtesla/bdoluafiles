function PaGlobal_Window_TimerCount:initialize()
  if nil == Panel_Window_TimerCount or true == self._initailize then
    return
  end
  self._ui._stc_TimeCount = UI.getChildControl(Panel_Window_TimerCount, "Static_TimeCount")
  self._ui._txt_Time = UI.getChildControl(self._ui._stc_TimeCount, "StaticText_Time")
  self._ui._txt_TimeCount = UI.getChildControl(self._ui._stc_TimeCount, "StaticText_TimeCount")
  self._ui._stc_GameOverBG = UI.getChildControl(self._ui._stc_TimeCount, "Static_GameOverBG")
  self._ui._txt_GameOver = UI.getChildControl(self._ui._stc_GameOverBG, "StaticText_GameOver")
  self._ui._txt_CountDown = UI.getChildControl(self._ui._stc_GameOverBG, "StaticText_CountDown")
  self._ui._txt_Retire = UI.getChildControl(self._ui._stc_GameOverBG, "StaticText_Retire")
  self:validate()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_Window_TimerCount:registerEventHandler()
  registerEvent("onScreenResize", "FromClient_Window_TimerCount_OnScreenResize")
  registerEvent("FromClient_setEventStopwatch", "FromClient_Window_TimerCount_SetEventStopwatch")
end
function PaGlobal_Window_TimerCount:setTimeText(time)
  local minute = math.floor(time / 60)
  local second = math.floor(time % 60)
  self._ui._txt_TimeCount:SetText(string.format("%02d", minute) .. ":" .. string.format("%02d", second))
end
function PaGlobal_Window_TimerCount:clear()
  self._isStartPlayer = false
  self._curTextUpdateTime = 0
  self:setTimeText(0)
  if nil ~= Panel_Window_TimerCount then
    Panel_Window_TimerCount:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Window_TimerCount:prepareOpen()
  if nil == Panel_Window_TimerCount or true == Panel_Window_TimerCount:GetShow() then
    return
  end
  if false == ToClient_SelfPlayerIsGM() then
    return
  end
  self:clear()
  self:open()
end
function PaGlobal_Window_TimerCount:open()
  if nil == Panel_Window_TimerCount then
    return
  end
  Panel_Window_TimerCount:SetShow(true)
end
function PaGlobal_Window_TimerCount:prepareClose()
  if nil == Panel_Window_TimerCount or false == Panel_Window_TimerCount:GetShow() then
    return
  end
  self:clear()
  self:close()
end
function PaGlobal_Window_TimerCount:close()
  if nil == Panel_Window_TimerCount then
    return
  end
  Panel_Window_TimerCount:SetShow(false)
end
function PaGlobal_Window_TimerCount:validate()
  if nil == Panel_Window_TimerCount then
    return
  end
  self._ui._stc_TimeCount:isValidate()
  self._ui._txt_Time:isValidate()
  self._ui._txt_TimeCount:isValidate()
  self._ui._stc_GameOverBG:isValidate()
  self._ui._txt_GameOver:isValidate()
  self._ui._txt_CountDown:isValidate()
  self._ui._txt_Retire:isValidate()
end
