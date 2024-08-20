function PaGlobalFunc_Window_TimerCount_Open()
  if nil == Panel_Window_TimerCount or true == Panel_Window_TimerCount:GetShow() then
    return
  end
  if false == ToClient_SelfPlayerIsGM() then
    return
  end
  PaGlobal_Window_TimerCount:prepareOpen()
end
function PaGlobalFunc_Window_TimerCount_Close()
  if nil == Panel_Window_TimerCount or false == Panel_Window_TimerCount:GetShow() then
    return
  end
  PaGlobal_Window_TimerCount:prepareClose()
end
function PaGlobalFunc_Window_TimerCount_UpdateStopwatch(deltaTime)
  PaGlobal_Window_TimerCount._curTextUpdateTime = PaGlobal_Window_TimerCount._curTextUpdateTime + deltaTime
  if PaGlobal_Window_TimerCount._curTextUpdateTime > 0.3 then
    local stopwatchTime = Int64toInt32(ToClient_getStopwatchTime())
    if stopwatchTime <= 0 then
      stopwatchTime = 0
      if true == PaGlobal_Window_TimerCount._isStartPlayer then
        ToClient_setEventStopwatch(false, 0)
      end
      PaGlobalFunc_Window_TimerCount_Close()
    else
      PaGlobal_Window_TimerCount:setTimeText(stopwatchTime)
    end
    PaGlobal_Window_TimerCount._curTextUpdateTime = 0
  end
end
function FromClient_Window_TimerCount_SetEventStopwatch(isStart)
  local nakString
  if true == isStart then
    nakString = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTTIMER_START")
    if true == ToClient_SelfPlayerIsGM() then
      PaGlobalFunc_Window_TimerCount_Open()
      PaGlobal_Window_TimerCount._curTextUpdateTime = 0.3
      PaGlobal_Window_TimerCount._isStartPlayer = ToClient_isStopwatchStartPlayer()
      Panel_Window_TimerCount:RegisterUpdateFunc("PaGlobalFunc_Window_TimerCount_UpdateStopwatch")
    end
  else
    nakString = PAGetString(Defines.StringSheet_GAME, "LUA_EVENTTIMER_END")
  end
  if nil ~= nakString then
    local msg = {
      main = nakString,
      sub = "",
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(msg, 3, 3)
  end
end
function FromClient_Window_TimerCount_OnScreenResize()
  if nil == Panel_Window_TimerCount then
    return
  end
  Panel_Window_TimerCount:ComputePos()
end
