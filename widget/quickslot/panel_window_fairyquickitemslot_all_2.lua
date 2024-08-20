function PaGlobalFunc_FairyQuickItemSlot_All_Open()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  PaGlobal_FairyQuickItemSlot_All:prepareOpen()
end
function PaGlobalFunc_FairyQuickItemSlot_All_Close()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  PaGlobal_FairyQuickItemSlot_All:prepareClose()
end
function PaGlobalFunc_FairyQuickItemSlot_All_UseAllItem()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  ToClient_UseFairyQuickItemSlotAll()
end
function FromClient_FairyQuickItemSlot_All_RefreshFairyQuickItemSlot()
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  if false == Panel_Window_FairyQuickItemSlot_All:GetShow() then
    return
  end
  PaGlobal_FairyQuickItemSlot_All:update()
end
function PaGloablFunc_FairyQuickItemSlot_All_SetFilter(slotNo, itemWrapper, count, inventoryType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return true
  end
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return true
  end
  if true == itemSSW:get():isItemSkill() then
    return false
  end
  return true
end
function HandleEventRUp_FairyQuickItemSlot_All_InvenRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == itemWrapper then
    return
  end
  if -1 == PaGlobal_FairyQuickItemSlot_All._emptySlotIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GACHA_ROULETTE_EMPTYSLOT"))
    return
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemKey = itemWrapper:get():getKey():getItemKey()
  ToClient_SetFairyQuickItemSlot(PaGlobal_FairyQuickItemSlot_All._emptySlotIndex, itemKey, whereType, slotNo)
end
function HandleEventRUp_FairyQuickItemSlot_All_SlotRClick(slotIndex)
  if nil == Panel_Window_FairyQuickItemSlot_All then
    return
  end
  ToClient_ClearFairyQuickItemSlot(slotIndex)
  if true == PaGlobal_FairyQuickItemSlot_All._isConsole then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_FairyQuickItemSlot_All_ShowItemTooltip(isShow, index, itemKey)
  if true == PaGlobal_FairyQuickItemSlot_All._isConsole then
    if nil ~= PaGlobalFunc_FloatingTooltip_GetShow and true == PaGlobalFunc_FloatingTooltip_GetShow() then
      PaGlobalFunc_FloatingTooltip_Close()
      return
    end
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil == itemStatic then
      PaGlobalFunc_FloatingTooltip_Close()
      return
    end
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, PaGlobal_FairyQuickItemSlot_All._slot[index].icon)
  else
    if false == isShow then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil == itemStatic then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(itemStatic, PaGlobal_FairyQuickItemSlot_All._slot[index].icon, true)
  end
end
