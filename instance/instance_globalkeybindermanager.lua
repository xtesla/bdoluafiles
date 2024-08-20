local IM = CppEnums.EProcessorInputMode
local VCK = CppEnums.VirtualKeyCode
local UIMode = Defines.UIMode
local _uiMode = UIMode.eUIMode_Default
local mouseKeyTable = {}
local isOnlyCombat = false
local escHandle = false
PaGlobal_GlobalKeyBinder = {
  _uiMode = {},
  curProcessedInputType = __eUiInputType_Undefined
}
function PaGlobal_GlobalKeyBinder:Init()
  local function checkCustomCondition_CommonWindow()
    local curMode = getInputMode()
    return curMode == IM.eProcessorInputMode_GameMode or curMode == IM.eProcessorInputMode_UiMode or curMode == IM.eProcessorInputMode_UiControlMode
  end
  local function checkCustomCondition_GameMode()
    return getInputMode() == IM.eProcessorInputMode_GameMode
  end
  local function checkCustomCondition_NotChattingMode()
    return getInputMode() ~= IM.eProcessorInputMode_ChattingInputMode
  end
  self:Register(UIMode.eUIMode_Default, self.Process_UIMode_CommonWindow, checkCustomCondition_CommonWindow)
  self:Register(UIMode.eUIMode_Default, self.Process_GameMode, checkCustomCondition_GameMode)
  self:Register(UIMode.eUIMode_Default, self.Process_UIMode_SkillkeyBinder, checkCustomCondition_CommonWindow)
  self:Register(UIMode.eUIMode_Default, self.Process_UiModeNotInput, checkCustomCondition_NotChattingMode)
  self:Register(UIMode.eUIMode_Default, self.Process_ChattingMacro)
  self:Register(UIMode.eUIMode_Default, self.Process_Default)
  self:Register(UIMode.eUIMode_DeadMessage, self.Process_UIMode_DeadMessage)
  self:Register(UIMode.eUIMode_PreventMoveNSkill, self.Process_UIMode_PreventMoveNSkill)
  self:Register(UIMode.eUIMode_GameExit, self.Process_UIMode_GameExit)
  self:Register(UIMode.eUIMode_KeyCustom_ActionKey, self.Process_UIMode_KeyCustom_ActionKey)
  self:Register(UIMode.eUIMode_KeyCustom_ActionPad, self.Process_UIMode_KeyCustom_ActionPad)
  self:Register(UIMode.eUIMode_KeyCustom_UiKey, self.Process_UIMode_KeyCustom_UiKey)
  self:Register(UIMode.eUIMode_KeyCustom_UiPad, self.Process_UIMode_KeyCustom_UiPad)
  self:Register(UIMode.eUIMode_KeyCustom_ActionPadFunc1, self.Process_UIMode_KeyCustom_ActionPadFunc1)
  self:Register(UIMode.eUIMode_KeyCustom_ActionPadFunc2, self.Process_UIMode_KeyCustom_ActionPadFunc2)
  self:Register(UIMode.eUIMode_PopupItem, self.Process_UIMode_PopupItem)
  self:Register(UIMode.eUIMode_EventNotify, self.Process_UIMode_EventNotify)
  self:Register(UIMode.eUIMode_SkillWindow, self.Process_UIMode_SkillWindow)
end
local checkScreenIsNotFading = function()
  if nil == PaGlobalFunc_FullScreenFade_IsFading then
    return true
  else
    return not PaGlobalFunc_FullScreenFade_IsFading()
  end
end
function PaGlobal_GlobalKeyBinder:Update(deltaTime)
  local curUIMode = GetUIMode()
  local rv
  self.curProcessedInputType = keyCustom_GetProcessedUiInputType()
  rv = self.Process_Normal(deltaTime)
  if true == rv then
    self:Clear()
    return
  end
  if getInputMode() == IM.eProcessorInputMode_ChattingInputMode then
    self.Process_ChattingInputMode(deltaTime)
    return
  end
  if UIMode.eUIMode_KeyCustom_ButtonShortcuts ~= GetUIMode() then
    local checkButtonShortcuts = ToClent_checkAndRunButtonShortcutsEvent()
    if true == checkButtonShortcuts then
      return
    end
  end
  if nil == self._uiMode[curUIMode] or nil == self._uiMode[curUIMode]._keyBinderData then
    self:Clear()
    return
  end
  if false == checkScreenIsNotFading() then
    return
  end
  local KeyBinder = self._uiMode[curUIMode]._keyBinderData
  for index in pairs(KeyBinder) do
    if true == KeyBinder[index]._CustomCondition() then
      KeyBinder[index]._ProcessFunc(deltaTime)
    end
  end
  self:Clear()
end
function PaGlobal_GlobalKeyBinder:Register(uiMode, func, customCondition)
  if nil == self._uiMode[uiMode] then
    self._uiMode[uiMode] = {}
  end
  if nil == self._uiMode[uiMode]._keyBinderData then
    self._uiMode[uiMode]._keyBinderData = {}
  end
  if customCondition == nil then
    function customCondition()
      return true
    end
  end
  local idx = #self._uiMode[uiMode]._keyBinderData + 1
  self._uiMode[uiMode]._keyBinderData[idx] = {_ProcessFunc = func, _CustomCondition = customCondition}
end
function PaGlobal_GlobalKeyBinder:Clear()
  mouseKeyTable = {}
  self.curProcessedInputType = __eUiInputType_Undefined
end
function GlobalKeyBinder_MouseKeyMap(uiInputType)
  mouseKeyTable[uiInputType] = true
  PaGlobal_GlobalKeyBinder:Update(0)
end
function GlobalKeyBinder_CheckKeyPressed(keyCode)
  return isKeyDown_Once(keyCode)
end
function SetUIMode(uiMode)
  if uiMode >= 0 and uiMode < UIMode.eUIMode_Count then
    _uiMode = uiMode
  end
end
function GetUIMode()
  return _uiMode
end
function PaGlobal_GlobalKeyBinder:CheckMouseDragEvent()
  if DragManager:isDragging() and GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_ESCAPE) then
    DragManager:clearInfo()
    Inventory_DropEscape()
    escHandle = true
  else
    escHandle = false
  end
end
function getEscHandle()
  return escHandle
end
function GlobalKeyBinder_CheckCustomKeyPressed(uiInputType)
  if uiInputType == __eUiInputType_Undefined then
    return false
  end
  return (PaGlobal_GlobalKeyBinder.curProcessedInputType == uiInputType or mouseKeyTable[uiInputType]) and not GlobalKeyBinder_CheckKeyPressed(VCK.KeyCode_MENU) and not isPhotoMode()
end
function FromClient_PerFrameGlobalKeyBinderUpdate(deltaTime)
  PaGlobal_GlobalKeyBinder:CheckMouseDragEvent()
  PaGlobal_GlobalKeyBinder:Update(deltaTime)
end
function GlobalKeyBinder_Null()
end
function FromClient_GlobalKeyBinderLoad()
  PaGlobal_GlobalKeyBinder:Init()
  registerEvent("EventGlobalKeyBinder", "FromClient_PerFrameGlobalKeyBinderUpdate")
end
registerEvent("FromClient_luaLoadComplete", "FromClient_GlobalKeyBinderLoad")
