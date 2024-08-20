function PaGlobal_CutSceneScript:initialize()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_GroupCamera
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_CutSceneScript_Awake)
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_textArea, "MultilineText_1")
  self._ui._pg_keyPressTime = UI.getChildControl(self._ui._stc_keyPress, "CircularProgress_Press")
  self._ui._pg_keyPressTime:SetSmoothMode(true)
  local stc_key_pc = UI.getChildControl(self._ui._stc_keyPress, "Static_InteractionKey_R")
  local stc_key_console = UI.getChildControl(self._ui._stc_keyPress, "Static_InteractionKey")
  if true == _ContentsGroup_UsePadSnapping then
    stc_key_pc:SetShow(false)
    stc_key_console:SetShow(true)
  else
    stc_key_pc:SetShow(true)
    stc_key_console:SetShow(false)
  end
  self:validate()
  self:registerEvent()
  self:resizePanel()
  self._initialize = true
end
function PaGlobal_CutSceneScript:clear()
  self._tickCount = getTickCount32()
  self._scriptCurrentIdx = 0
  self._scriptMaxCount = 0
  self._ui._txt_desc:SetText("")
  self._ui._stc_skipAnno:SetShow(false)
  self._ui._stc_keyPress:SetShow(false)
  self._currentSkipState = self._skipState.Press_Any_Key
  self._ui._pg_keyPressTime:SetCurrentControlPos(0)
  self._keyPressTime = 0
end
function PaGlobal_CutSceneScript:prepareOpen()
  self:open()
end
function PaGlobal_CutSceneScript:open()
  if false == self._initialize then
    return
  end
  self:clear()
  self._scriptMaxCount = ToClient_groupCameraScriptSize()
  local skipWrapper = ToClient_groupCameraSkipWrapper()
  if nil == skipWrapper then
    self._currentSkipState = self._skipState.End
  end
  self._renderMode:set()
  if self._scriptMaxCount > 0 then
    Panel_Window_CutSceneScript:RegisterUpdateFunc("PaGlobal_CutSceneScript_UpdatePerFrame")
  end
  Panel_Window_CutSceneScript:SetShow(true)
  if Defines.UIMode.eUIMode_Default == self._prevUIMode or Defines.UIMode.eUIMode_GroupCamera == self._prevUIMode then
    self._prevUIMode = GetUIMode()
  end
  if true == ToClient_IsDevelopment() then
    if false == ToClient_isProductionModifyMode() then
      SetUIMode(Defines.UIMode.eUIMode_GroupCamera)
    end
  else
    SetUIMode(Defines.UIMode.eUIMode_GroupCamera)
  end
end
function PaGlobal_CutSceneScript:prepareClose()
  self:close()
end
function PaGlobal_CutSceneScript:close()
  if nil == Panel_Window_CutSceneScript or false == Panel_Window_CutSceneScript:GetShow() then
    return
  end
  self._renderMode:reset()
  Panel_Window_CutSceneScript:ClearUpdateLuaFunc()
  Panel_Window_CutSceneScript:SetShow(false)
  local uiMode = Defines.UIMode.eUIMode_Default
  if Defines.UIMode.eUIMode_Default ~= self._prevUIMode and Defines.UIMode.eUIMode_GroupCamera ~= self._prevUIMode then
    uiMode = self._prevUIMode
    self._prevUIMode = Defines.UIMode.eUIMode_Default
  end
  if true == ToClient_IsDevelopment() then
    if false == ToClient_isProductionModifyMode() then
      SetUIMode(uiMode)
    end
  else
    SetUIMode(uiMode)
  end
end
function PaGlobal_CutSceneScript:validate()
  self._ui._stc_textArea:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_skipAnno:isValidate()
  self._ui._stc_keyPress:isValidate()
  self._ui._pg_keyPressTime:isValidate()
end
function PaGlobal_CutSceneScript:registerEvent()
  registerEvent("FromClient_startCutSceneGroupCamera", "FromClient_startCutSceneGroupCamera")
end
function PaGlobal_CutSceneScript:resizePanel()
  Panel_Window_CutSceneScript:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_CutSceneScript:ComputePosAllChild()
end
function PaGlobal_CutSceneScript:isKeyDown_Once()
  if true == _ContentsGroup_UsePadSnapping then
    for key, value in pairs(self._joyPadKey) do
      if true == isPadDown(value) then
        return true
      end
    end
  else
    for key, value in pairs(CppEnums.VirtualKeyCode) do
      if true == isKeyDown_Once(value) then
        return true
      end
    end
  end
  return false
end
function PaGlobal_CutSceneScript:keyPressReset()
  self._currentSkipState = self._skipState.Press_Any_Key
  self._ui._pg_keyPressTime:SetCurrentControlPos(0)
  self._keyPressTime = 0
end
