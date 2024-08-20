function PaGlobal_HopeGaugeOnOff:initialize()
  if true == PaGlobal_HopeGaugeOnOff._initialize then
    return
  end
  local infoUI = self._ui
  infoUI._stc_slot = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Static_Slot")
  infoUI._btn_off = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Button_Off")
  infoUI._btn_1set = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Button_1set")
  infoUI._btn_2set = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Button_2set")
  infoUI._btn_charge = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Button_Charge")
  infoUI._stc_effect = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Static_Lotate")
  infoUI._stc_off = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Static_Off")
  infoUI._stc_1set = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Static_1set")
  infoUI._stc_2set = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "Static_2set")
  infoUI._txt_time = UI.getChildControl(Panel_Widget_HopeGaugeOnOff, "StaticText_Time")
  infoUI._btn_list[self._BTN_TYPE.OFF] = infoUI._btn_off
  infoUI._btn_list[self._BTN_TYPE.SET_1] = infoUI._btn_1set
  infoUI._btn_list[self._BTN_TYPE.SET_2] = infoUI._btn_2set
  self._config._aniSpeed = 0.15
  self._config._aniDistance = infoUI._btn_off:GetSizeX()
  self._config._aniBeginPosX[self._BTN_TYPE.OFF] = infoUI._btn_off:GetPosX() + 45
  self._config._aniBeginPosX[self._BTN_TYPE.SET_1] = infoUI._btn_1set:GetPosX() + 20
  self._config._aniBeginPosX[self._BTN_TYPE.SET_2] = infoUI._btn_2set:GetPosX() - 10
  self._config._aniBeginPosY[self._BTN_TYPE.OFF] = infoUI._btn_off:GetPosY() + 25
  self._config._aniBeginPosY[self._BTN_TYPE.SET_1] = infoUI._btn_1set:GetPosY() + 40
  self._config._aniBeginPosY[self._BTN_TYPE.SET_2] = infoUI._btn_2set:GetPosY() + 45
  self._config._aniEndPosX[self._BTN_TYPE.OFF] = infoUI._btn_off:GetPosX()
  self._config._aniEndPosX[self._BTN_TYPE.SET_1] = infoUI._btn_1set:GetPosX()
  self._config._aniEndPosX[self._BTN_TYPE.SET_2] = infoUI._btn_2set:GetPosX()
  self._config._aniEndPosY[self._BTN_TYPE.OFF] = infoUI._btn_off:GetPosY()
  self._config._aniEndPosY[self._BTN_TYPE.SET_1] = infoUI._btn_1set:GetPosY()
  self._config._aniEndPosY[self._BTN_TYPE.SET_2] = infoUI._btn_2set:GetPosY()
  infoUI._btn_off:SetShow(false)
  infoUI._btn_1set:SetShow(false)
  infoUI._btn_2set:SetShow(false)
  infoUI._btn_charge:SetShow(false)
  Panel_Widget_HopeGaugeOnOff:SetChildIndex(infoUI._stc_slot, 9999)
  PaGlobal_HopeGaugeOnOff:registEventHandler()
  PaGlobal_HopeGaugeOnOff:validate()
  PaGlobal_HopeGaugeOnOff._initialize = true
end
function PaGlobal_HopeGaugeOnOff:registEventHandler()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  registerEvent("onScreenResize", "FromClient_HopeGauge_OnScreenResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_HopeGauge_OnScreenResize")
  registerEvent("FromClient_updateItemCollectionTimer", "FromClient_updateItemCollectionTimer")
  registerEvent("FromClient_updateItemCollectionPoint", "FromClient_HopeGaugeOnOff_updateHopePoint")
  registerEvent("FromClient_updateItemCollectionGrade", "FromClient_HopeGaugeOnOff_updateHopeGrade")
  registerEvent("onScreenResize", "FromCLient_HopeGaugeOnOff_changeScreen")
  registerEvent("FromClient_HopeGagePointIsFull", "FromClient_HopeGauge_PointIsFull")
  local infoUI = self._ui
  infoUI._btn_charge:addInputEvent("Mouse_LUp", "HandleEventLUp_HopeGaugeOnOff_ChargeOpen()")
  infoUI._btn_charge:addInputEvent("Mouse_On", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(true," .. self._tooltip._charge .. ")")
  infoUI._btn_charge:addInputEvent("Mouse_Out", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)")
  Panel_Widget_HopeGaugeOnOff:addInputEvent("Mouse_On", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(true," .. self._tooltip._slot .. ")")
  Panel_Widget_HopeGaugeOnOff:addInputEvent("Mouse_Out", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)")
  Panel_Widget_HopeGaugeOnOff:addInputEvent("Mouse_LUp", "PaGlobal_HopeGaugeOnOff:TogglePold()")
  Panel_Widget_HopeGaugeOnOff:addInputEvent("Mouse_RUp", "HandleEventRUp_HopeGaugeOnOff_Close()")
  infoUI._btn_off:addInputEvent("Mouse_LUp", "HandleEventLUp_HopeGaugeOnOff_ApplyItemScroll(0)")
  infoUI._btn_1set:addInputEvent("Mouse_LUp", "HandleEventLUp_HopeGaugeOnOff_ApplyItemScroll(1)")
  infoUI._btn_2set:addInputEvent("Mouse_LUp", "HandleEventLUp_HopeGaugeOnOff_ApplyItemScroll(2)")
  infoUI._btn_off:setButtonShortcuts("PANEL_SIMPLESHORTCUT_ITEMCOLLECTIONOFF")
  infoUI._btn_1set:setButtonShortcuts("PANEL_SIMPLESHORTCUT_ITEMCOLLECTION1")
  infoUI._btn_2set:setButtonShortcuts("PANEL_SIMPLESHORTCUT_ITEMCOLLECTION2")
  infoUI._btn_off:addInputEvent("Mouse_On", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(true," .. self._tooltip._off .. ")")
  infoUI._btn_1set:addInputEvent("Mouse_On", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(true," .. self._tooltip._1set .. ")")
  infoUI._btn_2set:addInputEvent("Mouse_On", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(true," .. self._tooltip._2set .. ")")
  infoUI._btn_off:addInputEvent("Mouse_Out", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)")
  infoUI._btn_1set:addInputEvent("Mouse_Out", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)")
  infoUI._btn_2set:addInputEvent("Mouse_Out", "HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)")
end
function PaGlobal_HopeGaugeOnOff:prepareOpen()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  local infoUI = self._ui
  infoUI._stc_slot:EraseAllEffect()
  infoUI._stc_slot:AddEffect("fUI_HopeGauge_On_01A", false, 0, 0)
  PaGlobal_HopeGaugeOnOff:updatePos()
  PaGlobal_HopeGaugeOnOff:update()
  ToClient_setItemCollectionScrollUiOn(true)
  PaGlobal_HopeGaugeOnOff:open()
end
function PaGlobal_HopeGaugeOnOff:open()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  Panel_Widget_HopeGaugeOnOff:SetShow(true)
end
function PaGlobal_HopeGaugeOnOff:prepareClose(isForce)
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  if (nil == isForce or false == isForce) and 0 ~= ToClient_AppliedHopeDrop() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_CLOSE_FAIL_DESC"))
    return
  end
  ToClient_setItemCollectionScrollUiOn(false)
  HandleEventOnOUt_HopeGaugeOnOff_SimpleTooltips(false)
  PaGlobal_HopeGaugeOnOff._isOver = false
  PaGlobal_HopeGauge_Close()
  PaGlobal_HopeGaugeOnOff:close()
end
function PaGlobal_HopeGaugeOnOff:close()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  Panel_Widget_HopeGaugeOnOff:SetShow(false)
end
function PaGlobal_HopeGaugeOnOff:updatePos()
  if false == self._initialize then
    return
  end
  self:initPos()
end
function PaGlobal_HopeGaugeOnOff:ChangeTexture(idx)
  local infoUI = self._ui
  local config = self._config
  infoUI._stc_off:SetShow(false)
  infoUI._stc_1set:SetShow(false)
  infoUI._stc_2set:SetShow(false)
  infoUI._btn_off:setRenderTexture(infoUI._btn_off:getBaseTexture())
  infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getBaseTexture())
  infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getBaseTexture())
  if 1 == idx then
    infoUI._stc_1set:SetShow(true)
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getClickTexture())
  elseif 2 == idx then
    infoUI._stc_2set:SetShow(true)
    infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getClickTexture())
  else
    infoUI._stc_off:SetShow(true)
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getClickTexture())
  end
  if 0 ~= idx then
    infoUI._stc_effect:SetShow(true)
  else
    infoUI._stc_effect:SetShow(false)
  end
end
function PaGlobal_HopeGaugeOnOff:ChangeSlotTexture(idx)
  local infoUI = self._ui
  local config = self._config
  infoUI._stc_off:SetShow(false)
  infoUI._stc_1set:SetShow(false)
  infoUI._stc_2set:SetShow(false)
  if 1 == idx then
    infoUI._stc_1set:SetShow(true)
  elseif 2 == idx then
    infoUI._stc_2set:SetShow(true)
  else
    infoUI._stc_off:SetShow(true)
  end
  if 0 ~= idx then
    infoUI._stc_effect:SetShow(true)
  else
    infoUI._stc_effect:SetShow(false)
  end
end
function PaGlobal_HopeGaugeOnOff:ChangeButtonTexture()
  local infoUI = self._ui
  local config = self._config
  if true == self._isOver then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  local grade = selfPlayer:get():getItemCollectionScrollGrade()
  infoUI._btn_off:setRenderTexture(infoUI._btn_off:getBaseTexture())
  infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getBaseTexture())
  infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getBaseTexture())
  if 1 == grade then
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getClickTexture())
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getClickTexture())
  elseif 2 == grade then
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getClickTexture())
    infoUI._btn_1set:setRenderTexture(infoUI._btn_1set:getClickTexture())
    infoUI._btn_2set:setRenderTexture(infoUI._btn_2set:getClickTexture())
  else
    infoUI._btn_off:setRenderTexture(infoUI._btn_off:getClickTexture())
  end
end
function PaGlobal_HopeGaugeOnOff:initPos()
  local targetPanel = Panel_Radar
  local inventoryType, itemWrapper
  if nil ~= Panel_WorldMiniMap and true == Panel_WorldMiniMap:GetShow() then
    targetPanel = Panel_WorldMiniMap
  end
  if nil ~= self.slotNo then
    inventoryType = Inventory_GetCurrentInventoryType()
    itemWrapper = getInventoryItemByType(inventoryType, self.slotNo)
  end
  self._isPold = true
  local infoUI = self._ui
  infoUI._btn_off:SetShow(false)
  infoUI._btn_1set:SetShow(false)
  infoUI._btn_2set:SetShow(false)
  infoUI._btn_charge:SetShow(true)
end
function PaGlobal_HopeGaugeOnOff:update()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  if false == self._initialize then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  local grade = selfPlayer:get():getItemCollectionScrollGrade()
  local infoUI = self._ui
  self:ChangeButtonTexture()
  self:ChangeSlotTexture(grade)
  local alertPoint = ToClient_getHopeGaugeAlert()
  if point < alertPoint and 0 ~= grade then
    infoUI._stc_slot:EraseAllEffect()
    infoUI._stc_slot:AddEffect("fUI_HopeGauge_01A", true, 0, 0)
  elseif 0 == grade then
    infoUI._stc_slot:EraseAllEffect()
  else
    infoUI._stc_slot:EraseAllEffect()
  end
  infoUI._txt_time:SetText(Util.Time.timeFormatting(point))
end
function PaGlobal_HopeGaugeOnOff:validate()
  if nil == Panel_Widget_HopeGaugeOnOff then
    return
  end
  local infoUI = self._ui
  infoUI._btn_charge:isValidate()
  infoUI._stc_slot:isValidate()
  infoUI._btn_off:isValidate()
  infoUI._btn_1set:isValidate()
  infoUI._btn_2set:isValidate()
  infoUI._stc_effect:isValidate()
  infoUI._stc_off:isValidate()
  infoUI._stc_1set:isValidate()
  infoUI._stc_2set:isValidate()
end
function PaGlobal_HopeGaugeOnOff:TogglePold()
  local infoUI = self._ui
  if true == self._isPold then
    infoUI._btn_off:SetShow(true)
    infoUI._btn_1set:SetShow(true)
    infoUI._btn_2set:SetShow(true)
    infoUI._btn_charge:SetShow(true)
    self._isPold = false
    self:ShowUnPoldAni()
  else
    self:ShowPoldAni()
    PaGlobal_HopeGauge_Close()
    self._isPold = true
  end
end
function PaGlobal_HopeGaugeOnOff:ShowUnPoldAni()
  local infoUI = self._ui
  local config = self._config
  infoUI._btn_off:SetPosX(config._aniBeginPosX[self._BTN_TYPE.OFF])
  infoUI._btn_off:SetPosY(config._aniBeginPosY[self._BTN_TYPE.OFF])
  infoUI._btn_1set:SetPosX(config._aniBeginPosX[self._BTN_TYPE.SET_1])
  infoUI._btn_1set:SetPosY(config._aniBeginPosY[self._BTN_TYPE.SET_1])
  infoUI._btn_2set:SetPosX(config._aniBeginPosX[self._BTN_TYPE.SET_2])
  infoUI._btn_2set:SetPosY(config._aniBeginPosY[self._BTN_TYPE.SET_2])
  local offAni = infoUI._btn_off:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  offAni:SetStartPosition(config._aniBeginPosX[self._BTN_TYPE.OFF], config._aniBeginPosY[self._BTN_TYPE.OFF])
  offAni:SetEndPosition(config._aniEndPosX[self._BTN_TYPE.OFF], config._aniEndPosY[self._BTN_TYPE.OFF])
  offAni.IsChangeChild = true
  infoUI._btn_off:CalcUIAniPos(offAni)
  local set1Ani = infoUI._btn_1set:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  set1Ani:SetStartPosition(config._aniBeginPosX[self._BTN_TYPE.SET_1], config._aniBeginPosY[self._BTN_TYPE.SET_1])
  set1Ani:SetEndPosition(config._aniEndPosX[self._BTN_TYPE.SET_1], config._aniEndPosY[self._BTN_TYPE.SET_1])
  set1Ani.IsChangeChild = true
  infoUI._btn_off:CalcUIAniPos(set1Ani)
  local set2Ani = infoUI._btn_2set:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  set2Ani:SetStartPosition(config._aniBeginPosX[self._BTN_TYPE.SET_2], config._aniBeginPosY[self._BTN_TYPE.SET_2])
  set2Ani:SetEndPosition(config._aniEndPosX[self._BTN_TYPE.SET_2], config._aniEndPosY[self._BTN_TYPE.SET_2])
  set2Ani.IsChangeChild = true
  infoUI._btn_2set:CalcUIAniPos(set2Ani)
end
function PaGlobal_HopeGaugeOnOff:ShowPoldAni()
  local infoUI = self._ui
  local config = self._config
  local offAni = infoUI._btn_off:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  offAni:SetStartPosition(config._aniEndPosX[self._BTN_TYPE.OFF], config._aniEndPosY[self._BTN_TYPE.OFF])
  offAni:SetEndPosition(config._aniBeginPosX[self._BTN_TYPE.OFF], config._aniBeginPosY[self._BTN_TYPE.OFF])
  offAni:SetHideAtEnd(true)
  offAni.IsChangeChild = true
  infoUI._btn_off:CalcUIAniPos(offAni)
  local set1Ani = infoUI._btn_1set:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  set1Ani:SetStartPosition(config._aniEndPosX[self._BTN_TYPE.SET_1], config._aniEndPosY[self._BTN_TYPE.SET_1])
  set1Ani:SetEndPosition(config._aniBeginPosX[self._BTN_TYPE.SET_1], config._aniBeginPosY[self._BTN_TYPE.SET_1])
  set1Ani:SetHideAtEnd(true)
  set1Ani.IsChangeChild = true
  infoUI._btn_off:CalcUIAniPos(set1Ani)
  local set2Ani = infoUI._btn_2set:addMoveAnimation(0, config._aniSpeed, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  set2Ani:SetStartPosition(config._aniEndPosX[self._BTN_TYPE.SET_2], config._aniEndPosY[self._BTN_TYPE.SET_2])
  set2Ani:SetEndPosition(config._aniBeginPosX[self._BTN_TYPE.SET_1], config._aniBeginPosY[self._BTN_TYPE.SET_1])
  set2Ani:SetHideAtEnd(true)
  set2Ani.IsChangeChild = true
  infoUI._btn_2set:CalcUIAniPos(set2Ani)
end
