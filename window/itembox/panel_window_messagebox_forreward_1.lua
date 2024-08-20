function PaGlobal_MessageBox_ForReward:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuideBg:SetShow(true == self._isConsole)
  local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  stc_keyGuide_A:SetShow(true == self._isConsole)
  stc_keyGuide_B:SetShow(true == self._isConsole)
  self._ui._btn_apply:SetShow(false == self._isConsole)
  self._ui._btn_cancel:SetShow(false == self._isConsole)
  self._ui._btn_close:SetShow(false == self._isConsole)
  local descBg = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Static_Text_BG")
  self._ui._txt_content = UI.getChildControl(descBg, "StaticText_Content")
  if true == self._isConsole then
    local tempBtnGroup = {stc_keyGuide_A, stc_keyGuide_B}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MessageBox_ForReward:clear()
  self._ui._txt_content:SetText("")
  _functionYes = nil
  _functionNo = nil
end
function PaGlobal_MessageBox_ForReward:prepareOpen(msgData)
  self:open(msgData)
end
function PaGlobal_MessageBox_ForReward:open(msgData)
  if false == self._initialize then
    return
  end
  if nil == msgData then
    return
  end
  self:clear()
  self._ui._txt_content:SetText(tostring(msgData.content))
  self._functionYes = msgData.functionYes
  self._functionNo = msgData.functionNo
  Panel_Window_MessageBox_ForReward:SetShow(true)
end
function PaGlobal_MessageBox_ForReward:prepareClose()
  if nil ~= self._functionNo then
    self._functionNo()
  end
  self:clear()
  self:close()
end
function PaGlobal_MessageBox_ForReward:close()
  Panel_Window_MessageBox_ForReward:SetShow(false)
end
function PaGlobal_MessageBox_ForReward:validate()
  self._ui._txt_title:isValidate()
  self._ui._btn_apply:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_MessageBox_ForReward:registerEvent()
  if true == self._isConsole then
    Panel_Window_MessageBox_ForReward:ignorePadSnapMoveToOtherPanel()
    Panel_Window_MessageBox_ForReward:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_MessageBox_ForReward:apply()")
    Panel_Window_MessageBox_ForReward:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_MessageBox_ForReward:cancel()")
  else
    self._ui._btn_apply:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_ForReward:apply()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_ForReward:cancel()")
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MessageBox_ForReward:prepareClose()")
  end
end
function PaGlobal_MessageBox_ForReward:apply()
  if nil ~= self._functionYes then
    self._functionYes()
  end
  self:prepareClose()
end
function PaGlobal_MessageBox_ForReward:cancel()
  if nil ~= self._functionNo then
    self._functionNo()
  end
  self:prepareClose()
end
