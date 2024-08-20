function PaGlobalFunc_Window_Timer_Open()
  if nil == Panel_Timer_Set or true == Panel_Timer_Set:GetShow() then
    return
  end
  if false == ToClient_SelfPlayerIsGM() then
    return
  end
  PaGlobal_Window_Timer:prepareOpen()
end
function PaGlobalFunc_Window_Timer_Close()
  if nil == Panel_Timer_Set or false == Panel_Timer_Set:GetShow() then
    return
  end
  PaGlobal_Window_Timer:prepareClose()
end
function PaGlobalFunc_Window_Timer_UpdateTimeEdit()
  PaGlobal_Window_Timer._ui._edit_Second:SetEditText(PaGlobal_Window_Timer._ui._edit_Second:GetEditText())
  PaGlobal_Window_Timer._ui._edit_Minute:SetEditText(PaGlobal_Window_Timer._ui._edit_Minute:GetEditText())
end
function PaGlobalFunc_Window_Timer_SetTimer(timeIndex)
  if PaGlobal_Window_Timer.eTimeIndex.second == timeIndex then
    PaGlobal_Window_Timer._settingSec = PaGlobal_Window_Timer._ui._edit_Second:GetEditNumber()
    if PaGlobal_Window_Timer._settingSec < 0 then
      PaGlobal_Window_Timer._settingSec = 0
    elseif PaGlobal_Window_Timer._settingSec >= 60 then
      PaGlobal_Window_Timer._settingSec = 59
    end
    PaGlobal_Window_Timer._isSetSec = true
  elseif PaGlobal_Window_Timer.eTimeIndex.minute == timeIndex then
    PaGlobal_Window_Timer._settingMin = PaGlobal_Window_Timer._ui._edit_Minute:GetEditNumber()
    PaGlobal_Window_Timer._isSetMin = true
  end
  local time = PaGlobal_Window_Timer._settingSec + PaGlobal_Window_Timer._settingMin * 60
  PaGlobal_Window_Timer:setTimeText(time)
end
function HandleEventLUp_Window_Timer_Confirm()
  if nil == Panel_Timer_Set or false == Panel_Timer_Set:GetShow() then
    return
  end
  if true == ToClient_SelfPlayerIsGM() then
    local stopwatchTime = PaGlobal_Window_Timer._settingMin * 60 + PaGlobal_Window_Timer._settingSec
    if 0 == stopwatchTime or false == PaGlobal_Window_Timer._isSetMin or false == PaGlobal_Window_Timer._isSetSec then
      return
    end
    ToClient_setEventStopwatch(true, stopwatchTime)
    PaGlobalFunc_Window_Timer_Close()
  end
end
function HandleEventLUp_Window_Timer_SetTime(timeIndex)
  if PaGlobal_Window_Timer.eTimeIndex.second == timeIndex then
    SetFocusEdit(PaGlobal_Window_Timer._ui._edit_Second)
    if false == PaGlobal_Window_Timer._ui._edit_Second:GetFocusEdit() and (nil ~= GetFocusEdit() or false == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_RETURN)) then
      PaGlobal_Window_Timer._ui._edit_Second:SetEditText("")
    end
  elseif PaGlobal_Window_Timer.eTimeIndex.minute == timeIndex then
    SetFocusEdit(PaGlobal_Window_Timer._ui._edit_Minute)
    if false == PaGlobal_Window_Timer._ui._edit_Minute:GetFocusEdit() and (nil ~= GetFocusEdit() or false == GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_RETURN)) then
      PaGlobal_Window_Timer._ui._edit_Minute:SetEditText("")
    end
  end
end
function FromClient_Window_Timer_OpenEventStopwatch()
  if nil == Panel_Timer_Set or true == Panel_Timer_Set:GetShow() then
    return
  end
  PaGlobalFunc_Window_Timer_Open()
end
function FromClient_Window_Timer_OnScreenResize()
  if nil == Panel_Timer_Set then
    return
  end
  Panel_Timer_Set:ComputePos()
end
