PaGlobal_HorseRacing_HelpIcon = {
  _ui = {_btn_keyGuide = nil, _btn_help = nil},
  _isInitialized = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_HelpIconInit")
function FromClient_HorseRacing_KeyGuideInit()
  PaGlobal_HorseRacing_HelpIcon:initialize()
end
function PaGlobal_HorseRacing_HelpIcon:initialize()
  local btn_area = UI.getChildControl(Panel_HorseRacing_HelpIcon, "Static_ButtonArea")
  btn_area:SetIgnore(true)
  self._ui._btn_keyGuide = UI.getChildControl(btn_area, "Static_KeyGuide_Button")
  self._ui._btn_help = UI.getChildControl(btn_area, "Static_HelpButton")
  self:registEventHandler()
  local state = ToClient_getHorseRacingState()
  self:updateState(state)
end
function PaGlobal_HorseRacing_HelpIcon:registEventHandler()
  registerEvent("FromClient_HorseRacing_UpdateAck", "FromClient_HorseRacing_HelpIcon_Update")
  registerEvent("onScreenResize", "FromClient_HorseRacing_HelpIcon_ReSizePanel")
  self._ui._btn_keyGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_KeyGuide_Open()")
  self._ui._btn_help:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_Help_Open()")
end
function PaGlobal_HorseRacing_HelpIcon:validate()
  self._ui._btn_keyGuide:isValidate()
  self._ui._btn_help:isValidate()
end
function PaGlobal_HorseRacing_HelpIcon:prepareOpen()
  if false == _ContentsGroup_InstanceHorseRacing or false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    self:prepareClose()
    return
  end
  PaGlobal_HorseRacing_HelpIcon:open()
end
function PaGlobal_HorseRacing_HelpIcon:open()
  Panel_HorseRacing_HelpIcon:SetShow(true)
end
function PaGlobal_HorseRacing_HelpIcon:prepareClose()
  self:close()
end
function PaGlobal_HorseRacing_HelpIcon:close()
  Panel_HorseRacing_HelpIcon:SetShow(false)
end
function PaGlobal_HorseRacing_HelpIcon:updateState(state)
  if false == _ContentsGroup_InstanceHorseRacing or false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  PaGlobal_HorseRacing_HelpIcon:open()
  if __eHorseRacing_WaitTime == state then
    self._ui._btn_help:SetShow(true)
  elseif __eHorseRacing_Result == state then
    self._ui._btn_help:SetShow(false)
    self._ui._btn_keyGuide:SetShow(false)
    PaGlobal_HorseRacing_KeyGuide_Close()
  else
    self._ui._btn_help:SetShow(false)
  end
end
function FromClient_HorseRacing_HelpIcon_ReSizePanel()
  Panel_HorseRacing_HelpIcon:ComputePosAllChild()
end
function FromClient_HorseRacing_HelpIcon_Update(state)
  PaGlobal_HorseRacing_HelpIcon:updateState(state)
end
function HandleEventLUp_HorseRacing_KeyGuide_Open()
  if true == Panel_HorseRacing_KeyGuide:GetShow() then
    PaGlobal_HorseRacing_KeyGuide_Close()
  else
    PaGlobal_HorseRacing_KeyGuide_Open()
  end
end
function HandleEventLUp_HorseRacing_Help_Open()
  Panel_WebHelper_ShowToggle("HorseRace")
end
