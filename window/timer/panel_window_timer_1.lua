function PaGlobal_Window_Timer:initialize()
  if nil == Panel_Timer_Set or true == self._initailize then
    return
  end
  self._ui._stc_TitleArea = UI.getChildControl(Panel_Timer_Set, "Static_TitleArea")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleArea, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleArea, "Button_Close")
  self._ui._stc_MainBG = UI.getChildControl(Panel_Timer_Set, "Static_MainBG")
  self._ui._txt_Minute = UI.getChildControl(Panel_Timer_Set, "StaticText_Minute")
  self._ui._txt_Second = UI.getChildControl(Panel_Timer_Set, "StaticText_Second")
  self._ui._btn_Start = UI.getChildControl(Panel_Timer_Set, "Button_Start")
  self._ui._edit_Minute = UI.getChildControl(Panel_Timer_Set, "Edit_Minute")
  self._ui._edit_Second = UI.getChildControl(Panel_Timer_Set, "Edit_Second")
  self:validate()
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_Window_Timer:registerEventHandler()
  registerEvent("onScreenResize", "FromClient_Window_Timer_OnScreenResize")
  registerEvent("FromClient_openEventStopwatch", "FromClient_Window_Timer_OpenEventStopwatch")
  self._ui._edit_Second:SetNumberMode(true)
  self._ui._edit_Second:RegistAllKeyEvent("PaGlobalFunc_Window_Timer_UpdateTimeEdit()")
  self._ui._edit_Second:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Timer_SetTime(" .. self.eTimeIndex.second .. ")")
  self._ui._edit_Second:RegistReturnKeyEvent("PaGlobalFunc_Window_Timer_SetTimer(" .. self.eTimeIndex.second .. ")")
  self._ui._edit_Minute:SetNumberMode(true)
  self._ui._edit_Minute:RegistAllKeyEvent("PaGlobalFunc_Window_Timer_UpdateTimeEdit()")
  self._ui._edit_Minute:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Timer_SetTime(" .. self.eTimeIndex.minute .. ")")
  self._ui._edit_Minute:RegistReturnKeyEvent("PaGlobalFunc_Window_Timer_SetTimer(" .. self.eTimeIndex.minute .. ")")
  self._ui._btn_Start:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_Timer_Confirm()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Timer_Close()")
end
function PaGlobal_Window_Timer:setTimeText(time)
  local minute = math.floor(time / 60)
  local second = math.floor(time % 60)
  self._ui._txt_Minute:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", tostring(minute)))
  self._ui._txt_Second:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(second)))
  self._ui._edit_Minute:SetEditText("")
  self._ui._edit_Second:SetEditText("")
end
function PaGlobal_Window_Timer:clear()
  self._settingSec = 0
  self._settingMin = 0
  self._isSetMin = false
  self._isSetSec = false
  self:setTimeText(0)
end
function PaGlobal_Window_Timer:prepareOpen()
  if nil == Panel_Timer_Set or true == Panel_Timer_Set:GetShow() then
    return
  end
  if false == ToClient_SelfPlayerIsGM() then
    return
  end
  self:clear()
  self:open()
end
function PaGlobal_Window_Timer:open()
  if nil == Panel_Timer_Set then
    return
  end
  Panel_Timer_Set:SetShow(true)
end
function PaGlobal_Window_Timer:prepareClose()
  if nil == Panel_Timer_Set or false == Panel_Timer_Set:GetShow() then
    return
  end
  self:close()
end
function PaGlobal_Window_Timer:close()
  if nil == Panel_Timer_Set then
    return
  end
  Panel_Timer_Set:SetShow(false)
end
function PaGlobal_Window_Timer:validate()
  if nil == Panel_Timer_Set then
    return
  end
  self._ui._stc_TitleArea:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_MainBG:isValidate()
  self._ui._txt_Minute:isValidate()
  self._ui._txt_Second:isValidate()
  self._ui._btn_Start:isValidate()
  self._ui._edit_Minute:isValidate()
  self._ui._edit_Second:isValidate()
end
