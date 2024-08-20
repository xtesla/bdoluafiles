PaGlobal_StaminaAutoRun = {
  _ui = {chk_AutoRun = nil},
  _isAutoMove = false,
  _isTradeMove = false,
  _autoMoveCheckTime = 1,
  _autoMoveElapsedTime = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_StaminaAutoRun_Init")
function FromClient_StaminaAutoRun_Init()
  PaGlobal_StaminaAutoRun:initialize()
end
function PaGlobal_StaminaAutoRun:initialize()
  if true == PaGlobal_StaminaAutoRun._initialize or nil == Panel_Widget_StaminaAutoRun then
    return
  end
  self._ui.chk_AutoRun = UI.getChildControl(Panel_Widget_StaminaAutoRun, "CheckButton_AutoRun")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_StaminaAutoRun:validate()
  PaGlobal_StaminaAutoRun:registEventHandler()
  PaGlobal_StaminaAutoRun:swichPlatform(self._isConsole)
  FromClient_StaminaAutoRun_InventoryUpdate()
  PaGlobal_StaminaAutoRun._initialize = true
end
function PaGlobal_StaminaAutoRun:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_StaminaAutoRun:prepareOpen()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  if true == Panel_Widget_StaminaAutoRun:GetShow() then
    return
  end
  if false == self._isAutoMove and false == self._isTradeMove then
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local isDriver = selfProxy:get():isVehicleDriver()
  if true == isDriver then
    return
  end
  if true == self._isAutoMove then
    Panel_Widget_StaminaAutoRun:RegisterUpdateFunc("PaGlobalFunc_StaminaAutoRun_UpdateFrame")
  end
  local savedAutoRunCheck = false
  if nil ~= ToClient_getGameUIManagerWrapper() then
    savedAutoRunCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eStaminaAutoRun)
  end
  self._ui.chk_AutoRun:SetCheck(savedAutoRunCheck)
  ToClient_SetCanMoveFast(savedAutoRunCheck)
  PaGlobal_StaminaAutoRun:open()
  PaGlobal_StaminaAutoRun:resize()
end
function PaGlobal_StaminaAutoRun:dataclear()
  self._ui.chk_AutoRun:SetCheck(false)
  self._isAutoMove = false
  self._isTradeMove = false
  ToClient_SetCanMoveFast(false)
end
function PaGlobal_StaminaAutoRun:open()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  Panel_Widget_StaminaAutoRun:SetShow(true)
end
function PaGlobal_StaminaAutoRun:prepareClose()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  if true == self._isAutoMove or true == self._isTradeMove then
    return
  end
  Panel_Widget_StaminaAutoRun:ClearUpdateLuaFunc()
  self:dataclear()
  PaGlobal_StaminaAutoRun:close()
end
function PaGlobal_StaminaAutoRun:close()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  Panel_Widget_StaminaAutoRun:SetShow(false)
end
function PaGlobalFunc_StaminaAutoRun_UpdateFrame(deltaTime)
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  PaGlobal_StaminaAutoRun._autoMoveElapsedTime = PaGlobal_StaminaAutoRun._autoMoveElapsedTime + deltaTime
  if PaGlobal_StaminaAutoRun._autoMoveElapsedTime <= PaGlobal_StaminaAutoRun._autoMoveCheckTime then
    return
  end
  PaGlobal_StaminaAutoRun._autoMoveElapsedTime = 0
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local isAutoRunVariable = selfPlayerWrapper:getVariable("IsAutoRun")
  if 0 == isAutoRunVariable then
    PaGlobal_StaminaAutoRun._isAutoMove = false
    PaGlobalFunc_StaminaAutoRun_Close()
  end
end
function PaGlobalFunc_StaminaAutoRun_OpenCheckAutoMove()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  if true == isDoingAction("AUTO_RUN") then
    PaGlobal_StaminaAutoRun._isAutoMove = true
    PaGlobalFunc_StaminaAutoRun_Open()
  end
end
function PaGlobal_StaminaAutoRun:registEventHandler()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  registerEvent("FromClient_InventoryUpdate", "FromClient_StaminaAutoRun_InventoryUpdate")
  registerEvent("onScreenResize", "FromClient_StaminaAutoRun_ResetPosition")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_StaminaAutoRun_ResetPosition")
  self._ui.chk_AutoRun:addInputEvent("Mouse_LUp", "HandleEventLUp_StaminaAutoRun_AutoCheck()")
end
function PaGlobal_StaminaAutoRun:validate()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  self._ui.chk_AutoRun:isValidate()
end
function PaGlobal_StaminaAutoRun:resize()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  if nil == Panel_Stamina then
    Panel_Widget_StaminaAutoRun:ComputePos()
    return
  end
  local posX = Panel_Stamina:GetPosX()
  local posY = Panel_Stamina:GetPosY() + Panel_Widget_StaminaAutoRun:GetSizeY() + 5
  Panel_Widget_StaminaAutoRun:SetPosX(posX)
  Panel_Widget_StaminaAutoRun:SetPosY(posY)
end
function PaGlobalFunc_StaminaAutoRun_Open()
  PaGlobal_StaminaAutoRun:prepareOpen()
end
function PaGlobalFunc_StaminaAutoRun_Close()
  PaGlobal_StaminaAutoRun:prepareClose()
end
function HandleEventLUp_StaminaAutoRun_AutoCheck()
  if nil == Panel_Widget_StaminaAutoRun then
    return
  end
  local isChkAutoRun = PaGlobal_StaminaAutoRun._ui.chk_AutoRun:IsCheck()
  ToClient_SetCanMoveFast(isChkAutoRun)
  if nil ~= ToClient_getGameUIManagerWrapper() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eStaminaAutoRun, isChkAutoRun, CppEnums.VariableStorageType.eVariableStorageType_Character)
  end
end
function FromClient_StaminaAutoRun_InventoryUpdate()
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  if toInt64(0, 0) < selfProxy:get():getInventory():getTradeItemCount() then
    PaGlobal_StaminaAutoRun._isTradeMove = true
    PaGlobalFunc_StaminaAutoRun_Open()
  else
    PaGlobal_StaminaAutoRun._isTradeMove = false
    PaGlobalFunc_StaminaAutoRun_Close()
  end
end
function FromClient_StaminaAutoRun_ResetPosition()
  PaGlobal_StaminaAutoRun:resize()
end
