function PaGlobal_BarterInfoSearch_Special:init()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuideBG:SetShow(true == self._isConsole)
  self._ui._keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_B_Consoleui")
  self._ui._keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuide_Y_Consoleui")
  local keyGuide = {
    self._ui._keyGuide_Y,
    self._ui._keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._btn_close = UI.getChildControl(self._ui._titleBg, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Special:close()")
  self._ui._btn_close:SetShow(false == self._isConsole)
  if true == self._isConsole then
    Panel_Window_Barter_Search_Special:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_BarterInfoSearch_Special:close()")
    Panel_Window_Barter_Search_Special:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_BarterInfoSearch_Special:requestGiveUpSpecialBarter()")
  else
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Special:close()")
    self._ui._btn_giveUp:addInputEvent("Mouse_LUp", "PaGlobal_BarterInfoSearch_Special:requestGiveUpSpecialBarter()")
  end
  self._ui._btn_cancel:SetShow(false == self._isConsole)
  self._ui._btn_giveUp:SetShow(false == self._isConsole)
  local slot = {}
  local slotBg = UI.getChildControl(self._ui._mainBg, "Static_MyItemBG")
  local itemSlotBg = UI.getChildControl(slotBg, "Static_ItemSlot")
  SlotItem.new(slot, "FromItemIcon", 0, itemSlotBg, self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(0)
  slot.icon:SetPosY(0)
  slot.icon:SetShow(true)
  if false == self._isConsole then
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch_Special:itemTooltipShow(0)")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch_Special:itemTooltipHide()")
  end
  self._ui._fromSlot = slot
  self._ui._txt_fromItemName = UI.getChildControl(self._ui._mainBg, "StaticText_MyItemName")
  slot = {}
  slotBg = UI.getChildControl(self._ui._mainBg, "Static_TakeItemBG")
  itemSlotBg = UI.getChildControl(slotBg, "Static_ItemSlot")
  SlotItem.new(slot, "ToItemIcon", 0, itemSlotBg, self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(0)
  slot.icon:SetPosY(0)
  slot.icon:SetShow(true)
  if false == self._isConsole then
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_BarterInfoSearch_Special:itemTooltipShow(1)")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_BarterInfoSearch_Special:itemTooltipHide()")
  end
  self._ui._toSlot = slot
  self._ui._txt_toItemName = UI.getChildControl(self._ui._mainBg, "StaticText_TakeItemName")
  Panel_Window_Barter_Search_Special:ignorePadSnapMoveToOtherPanel()
  self:resizePanel()
end
function PaGlobal_BarterInfoSearch_Special:resizePanel()
  local panelSizeX = Panel_Window_Barter_Search_Special:GetSizeX()
  local panelSizeY = Panel_Window_Barter_Search_Special:GetSizeY()
  local btnSizeY = self._ui._btn_cancel:GetSizeY()
  if true == self._isConsole then
    Panel_Window_Barter_Search_Special:SetSize(panelSizeX, panelSizeY - btnSizeY)
  else
    Panel_Window_Barter_Search_Special:SetSize(panelSizeX, panelSizeY)
  end
  self._ui._stc_keyGuideBG:SetPosY(Panel_Window_Barter_Search_Special:GetSizeY())
  Panel_Window_Barter_Search_Special:ComputePos()
end
function PaGlobal_BarterInfoSearch_Special:open()
  if false == _ContentsGroup_Barter then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local isPremiumUser = selfPlayerWrapper:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  if false == isPremiumUser then
    return
  end
  local info = ToClient_specialBarterWrapper()
  if nil == info then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSpecialBarterInfoNotExist"))
    return
  end
  local itemSSW = getItemEnchantStaticStatus(info:getFromItemEnchantKey())
  if nil ~= itemSSW then
    local itemCount = info:getFromItemCount()
    self._ui._fromSlot:setItemByStaticStatus(itemSSW, itemCount)
    self._ui._txt_fromItemName:SetText(itemSSW:getName())
  end
  itemSSW = getItemEnchantStaticStatus(info:getToItemEnchantKey())
  if nil ~= itemSSW then
    local itemCount = info:getToItemCount()
    self._ui._toSlot:setItemByStaticStatus(itemSSW, itemCount)
    self._ui._txt_toItemName:SetText(itemSSW:getName())
  end
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:push(Panel_Window_Barter_Search_Special, true)
  else
    Panel_Window_Barter_Search_Special:SetShow(true)
  end
end
function PaGlobal_BarterInfoSearch_Special:close()
  if true == ToClient_WorldMapIsShow() then
    WorldMapPopupManager:popWantPanel(Panel_Window_Barter_Search_Special)
  else
    Panel_Window_Barter_Search_Special:SetShow(false)
  end
  self:itemTooltipHide()
end
function PaGlobal_BarterInfoSearch_Special:requestGiveUpSpecialBarter()
  local function MessageBox_SkipFunc()
    ToClient_giveUpSpecialBarter(nil)
    self:close()
  end
  local msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SPECIALTITLE")
  local msgDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_BARTER_GIVEUPSPECIALBARTER")
  local messageBoxData = {
    title = msgTitle,
    content = msgDesc,
    functionYes = MessageBox_SkipFunc,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_BarterInfoSearch_Special:itemTooltipShow(type)
  local info = ToClient_specialBarterWrapper()
  if nil == info then
    return
  end
  local itemSSW, control
  if 0 == type then
    itemSSW = getItemEnchantStaticStatus(info:getFromItemEnchantKey())
    control = self._ui._fromSlot.icon
  else
    itemSSW = getItemEnchantStaticStatus(info:getToItemEnchantKey())
    control = self._ui._toSlot.icon
  end
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_BarterInfoSearch_Special:itemTooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
