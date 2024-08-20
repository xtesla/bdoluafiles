function PaGlobal_ItemMoveSet:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuide:SetShow(true == self._isConsole)
  self._ui._keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_Y_ConsoleUI")
  self._ui._keyGuide_B = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_B_ConsoleUI")
  self._ui._keyGuide_A = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A_ConsoleUI")
  self._ui._keyGuide_X = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X_ConsoleUI")
  self._ui._keyGuide_Y:SetShow(true == self._isConsole)
  self._ui._keyGuide_B:SetShow(true == self._isConsole)
  self._ui._keyGuide_A:SetShow(true == self._isConsole)
  self._ui._keyGuide_X:SetShow(true == self._isConsole)
  local keyGuide = {
    self._ui._keyGuide_Y,
    self._ui._keyGuide_A,
    self._ui._keyGuide_X,
    self._ui._keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._btn_apply:SetShow(false == self._isConsole)
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_Desc, "StaticText_Desc")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOMOVE_BOTTOMDESC"))
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._ui._txt_desc:GetTextSizeY())
  self._ui._stc_Desc:SetSize(self._ui._stc_Desc:GetSizeX(), self._ui._txt_desc:GetTextSizeY() + 20)
  self._ui._stc_Desc:ComputePosAllChild()
  if false == self:createControl() then
    return
  end
  self:validate()
  self:registerEvent()
  _PA_ASSERT(#self._itemSlots == #self._cacheTypeList, "Size\234\176\128 \235\139\164\235\165\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164.")
  self._initialize = true
end
function PaGlobal_ItemMoveSet:clear()
  for ii = 0, #self._keyList do
    local slot = self._keyList[ii]
    slot.control:SetCheck(false)
  end
  self._fromItemCount = 0
  self._toItemCount = 0
end
function PaGlobal_ItemMoveSet:prepareOpen()
  self:open()
end
function PaGlobal_ItemMoveSet:open()
  if false == _ContentsGroup_ItemMove then
    return
  end
  if false == self._initialize then
    return
  end
  self:clear()
  ToClient_loadExceptionMoveItemKey()
  local exceptionKeyList = ToClient_getExceptionMoveItemKeyList()
  if nil ~= exceptionKeyList then
    for ii = 0, #exceptionKeyList do
      local key = exceptionKeyList[ii]
      local control = self:findControl(key:get())
      if nil ~= control then
        control:SetCheck(true)
      end
    end
  end
  for ii = 0, #self._cacheTypeList do
    local number = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(self._cacheTypeList[ii])
    local key = ItemEnchantKey(number)
    local itemSSW = getItemEnchantStaticStatus(key)
    local slot = self._itemSlots[ii]
    slot:clearItem()
    if nil ~= itemSSW then
      slot:setItemByStaticStatus(itemSSW)
      slot.btn_add:SetShow(false)
      slot.icon:SetShow(true)
      slot.itemKey = key:getItemKey()
    else
      slot.btn_add:SetShow(true)
      slot.icon:SetShow(false)
      slot.itemKey = 0
    end
  end
  self:changeInventoryItemSlotRUpEvent(true)
  Panel_Window_ItemMoveSet:SetShow(true)
  if nil ~= Panel_Window_ServantInventory and true == Panel_Window_ServantInventory:GetShow() then
    ServantInventory_Close()
  end
  PaGlobal_WareHouse_All:prepareClose()
  Inventory_SetFunctor(PaGlobal_ItemMoveSet_BasicItemFilter, FGlobal_PopupMoveItem_InitByInventory, PaGlobal_Warehouse_All_Close, nil)
  if false == self._isConsole then
    PaGlobal_Inventory_All:setIgnoreMoveItemButton(true)
  end
  PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
end
function PaGlobal_ItemMoveSet:prepareClose(isShowWarehouse)
  self:close(isShowWarehouse)
end
function PaGlobal_ItemMoveSet:close(isShowWarehouse)
  self:changeInventoryItemSlotRUpEvent(false)
  Panel_Window_ItemMoveSet:SetShow(false)
  if true == isShowWarehouse then
    FromClient_DialogFunctionClick_Contents_Warehouse()
  end
  if false == self._isConsole then
    PaGlobal_Inventory_All:setIgnoreMoveItemButton(false)
  end
  PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
end
function PaGlobal_ItemMoveSet:validate()
  self._ui._stc_titleBg:isValidate()
  self._ui._stc_selectBg:isValidate()
  self._ui._btn_apply:isValidate()
  self._ui._stc_Desc:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_ItemMoveSet:registerEvent()
  if true == self._isConsole then
    Panel_Window_ItemMoveSet:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ItemMoveSet:apply()")
    Panel_Window_ItemMoveSet:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_ItemMoveSet:prepareClose(true)")
  else
    self._ui._btn_apply:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:apply()")
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:prepareClose(true)")
  end
  registerEvent("FromClient_WarehouseUpdate", "FromClient_ItemMoveSet_WarehouseUpdate")
end
function PaGlobal_ItemMoveSet:createControl()
  local keyCount = ToClient_getItemMoveKeyCount()
  if 0 == keyCount then
    return false
  end
  local parent = self._ui._stc_selectBg
  local stc_line = UI.getChildControl(parent, "Static_HorizonLine")
  local baseControl = UI.getChildControl(parent, "BaseCheckBox")
  local baseItemControl = UI.getChildControl(parent, "Static_Slot_Temp")
  local btnSizeY = baseControl:GetSizeY()
  local slotSizeX = baseItemControl:GetSizeX()
  local slotSizeY = baseItemControl:GetSizeY()
  parent:SetSize(parent:GetSizeX(), 5 + (btnSizeY + 5) * keyCount + (15 + slotSizeY * 2) + stc_line:GetSizeY())
  local applyBtnSizeY = 0
  if false == self._isConsole then
    applyBtnSizeY = self._ui._btn_apply:GetSizeY()
  end
  local panelSizeY = self._ui._stc_titleBg:GetSizeY() + parent:GetSizeY() + applyBtnSizeY + self._ui._stc_Desc:GetSizeY() + 30
  Panel_Window_ItemMoveSet:SetSize(Panel_Window_ItemMoveSet:GetSizeX(), panelSizeY)
  Panel_Window_ItemMoveSet:ComputePosAllChild()
  self._ui._stc_Desc:SetPosY(parent:GetPosY() + parent:GetSizeY() + 10)
  local posY = 0
  self._keyList = {}
  for ii = 0, keyCount - 1 do
    local slot = {keyRaw = 0, control = nil}
    local key = ToClient_getItemMoveKeyByIndex(ii)
    _PA_ASSERT(key:isDefined(), "ItemMoveKey\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.")
    posY = 5 + (btnSizeY + 5) * ii
    slot.keyRaw = key:get()
    control = UI.cloneControl(baseControl, parent, "CheckBox_" .. tostring(ii))
    control:SetShow(true)
    control:SetPosY(posY)
    control:SetText(ToClient_getMoveItemFilterName(slot.keyRaw))
    control:SetCheck(false)
    slot.control = control
    self._keyList[ii] = slot
  end
  posY = posY + btnSizeY + 5
  stc_line:SetPosY(posY)
  local slotCount = #self._cacheTypeList + 1
  local half = math.floor(slotCount / 2)
  local initPosX = (parent:GetSizeX() - (slotSizeX * half + 5 * (half - 1))) / 2
  local initPosY = posY + 5
  self._itemSlots = {}
  for ii = 0, slotCount - 1 do
    local col = ii % half
    local row = math.floor(ii / half)
    local slot = {
      parent = nil,
      btn_add = nil,
      itemKey = 0
    }
    slot.parent = UI.cloneControl(baseItemControl, parent, "ItemSlotBG_" .. tostring(ii))
    slot.parent:SetShow(true)
    slot.parent:SetPosX(initPosX + (slotSizeX + 5) * col)
    slot.parent:SetPosY(initPosY + (slotSizeY + 5) * row)
    slot.btn_add = UI.getChildControl(slot.parent, "Static_Add")
    SlotItem.new(slot, "ItemSlot", ii, slot.parent, self._slotConfig)
    slot:createChild()
    slot.icon:SetPosX(0)
    slot.icon:SetPosY(0)
    if true == self._isConsole then
      slot.parent:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ItemMoveSet:gotoInventorySlot(" .. ii .. ")")
      slot.parent:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ItemMoveSet:clearItemSlot(" .. ii .. ")")
    else
      slot.parent:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:showNak(" .. ii .. ")")
      slot.btn_add:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:showNak(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_ItemMoveSet:clearItemSlot(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_On", "PaGlobal_ItemMoveSet:showItemTooltip(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobal_ItemMoveSet:hideItemTooltip()")
    end
    self._itemSlots[ii] = slot
  end
  UI.deleteControl(baseControl)
  UI.deleteControl(baseItemControl)
  return true
end
function PaGlobal_ItemMoveSet:apply()
  for ii = 0, #self._keyList do
    local slot = self._keyList[ii]
    if true == slot.control:IsCheck() then
      ToClient_insertExceptionMoveItemKey(slot.keyRaw)
    else
      ToClient_deleteExceptionMoveItemKey(slot.keyRaw)
    end
  end
  ToClient_saveExceptionMoveItemKey()
  for ii = 0, #self._itemSlots do
    local slot = self._itemSlots[ii]
    local cacheType = self._cacheTypeList[ii]
    local number = slot.itemKey
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(cacheType, number, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  self:prepareClose(true)
end
function PaGlobal_ItemMoveSet:findControl(keyRaw)
  for ii = 0, #self._keyList do
    local slot = self._keyList[ii]
    if slot.keyRaw == keyRaw then
      return slot.control
    end
  end
  return nil
end
function PaGlobal_ItemMoveSet:changeInventoryItemSlotRUpEvent(isChange)
  if true == self._isConsole then
    PaGlobal_InventoryInfo_ChangeInventoryItemSlotRUpEvent(isChange)
  else
    PaGlobal_Inventory_All_ChangeInventoryItemSlotRUpEvent(isChange)
  end
end
function PaGlobal_ItemMoveSet:setExceptionItemKey(whereType, slotNo)
  local addIndex = self:nextAddIndex()
  if -1 == addIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MOVEITEM_ERR_ALL_SET"))
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  if false == itemSSW:isStackable() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MOVEITEM_ERR_REDUPLICATION"))
    return
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if false == self:checkItemKey(itemKey) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MOVEITEM_ERR_ALREADY_SET"))
    return
  end
  local slot = self._itemSlots[addIndex]
  slot:setItemByStaticStatus(itemSSW)
  slot.btn_add:SetShow(false)
  slot.icon:SetShow(true)
  slot.itemKey = itemKey
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Window_ItemMoveSet)
    ToClient_padSnapChangeToTarget(slot.parent)
  end
end
function PaGlobal_ItemMoveSet:clearItemSlot(index)
  local slot = self._itemSlots[index]
  slot:clearItem()
  slot.btn_add:SetShow(true)
  slot.icon:SetShow(false)
  slot.itemKey = 0
  self:hideItemTooltip()
end
function PaGlobal_ItemMoveSet:nextAddIndex()
  for ii = 0, #self._itemSlots do
    local slot = self._itemSlots[ii]
    if true == slot.btn_add:GetShow() and false == slot.icon:GetShow() then
      return ii
    end
  end
  return -1
end
function PaGlobal_ItemMoveSet:checkItemKey(itemKey)
  for ii = 0, #self._itemSlots do
    local slot = self._itemSlots[ii]
    if itemKey == slot.itemKey then
      return false
    end
  end
  return true
end
function PaGlobal_ItemMoveSet:gotoInventorySlot(index)
  if false == self._isConsole then
    return
  end
  local slot = self._itemSlots[index]
  if nil == slot or false == slot.btn_add:GetShow() then
    return
  end
  PaGlobal_InventoryInfo_GotoSnappingItemSlotBG()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_SELECT_ITEM"))
end
function PaGlobal_ItemMoveSet:showNak(index)
  local slot = self._itemSlots[index]
  if nil == slot or false == slot.btn_add:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_RCLICK"))
end
function PaGlobal_ItemMoveSet:showItemTooltip(index)
  local slot = self._itemSlots[index]
  if nil == slot or 0 == slot.itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot.itemKey))
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, slot.icon, true, false)
end
function PaGlobal_ItemMoveSet:hideItemTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
