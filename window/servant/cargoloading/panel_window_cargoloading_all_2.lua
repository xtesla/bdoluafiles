function HandleEventScroll_CargoLoading_WarehouseScroll(isUp)
  Panel_Tooltip_Item_hideTooltip()
  local slotCols = PaGlobal_CargoLoading:getSlotCols(PaGlobal_CargoLoading._eSlotType.inventory)
  local useStartSlot = PaGlobal_CargoLoading._startSlot_warehouse
  local maxSize = PaGlobal_CargoLoading._maxCount_warehouse - useStartSlot
  local remain = maxSize % slotCols
  if remain > 0 then
    maxSize = maxSize + (slotCols - remain)
  end
  PaGlobal_CargoLoading._startSlotIndex_warehouse = UIScroll.ScrollEvent(PaGlobal_CargoLoading._ui._scroll_warehouse, isUp, PaGlobal_CargoLoading._config.slotRows_w, maxSize, PaGlobal_CargoLoading._startSlotIndex_warehouse, slotCols)
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function HandleEventScroll_CargoLoading_ServantScroll(isUp)
  Panel_Tooltip_Item_hideTooltip()
  local slotCols = PaGlobal_CargoLoading:getSlotCols(PaGlobal_CargoLoading._eSlotType.servant)
  local useStartSlot = PaGlobal_CargoLoading._startSlot_ship
  local maxSize = PaGlobal_CargoLoading._maxCount_ship - useStartSlot
  local remain = maxSize % slotCols
  if remain > 0 then
    maxSize = maxSize + (slotCols - remain)
  end
  PaGlobal_CargoLoading._startSlotIndex_ship = UIScroll.ScrollEvent(PaGlobal_CargoLoading._ui._scroll_ship, isUp, PaGlobal_CargoLoading._config.slotRows_s, maxSize, PaGlobal_CargoLoading._startSlotIndex_ship, slotCols)
  PaGlobal_CargoLoading:updateServantSlot()
end
function HandleEventMOn_CargoLoading_SetPadScrollEvent(type)
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "")
  Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "")
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if PaGlobal_CargoLoading._eSlotType.inventory == type then
    Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_CargoLoading_WarehouseScroll(true)")
    Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_CargoLoading_WarehouseScroll(false)")
  elseif PaGlobal_CargoLoading._eSlotType.servant == type then
    Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_CargoLoading_ServantScroll(true)")
    Panel_Window_CargoLoading_ALL:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_CargoLoading_ServantScroll(false)")
  end
end
function HandleEventMOn_CargoLoading_IconOver(type, index)
  local slot = PaGlobal_CargoLoading._slots[type][index]
  if nil == slot or nil == slot.slotNo then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    HandleEventMOn_CargoLoading_SetPadScrollEvent(type)
  end
  if PaGlobal_CargoLoading._eSlotType.inventory == type then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slot.slotNo)
      if nil == itemWrapper then
        return
      end
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
      if nil == warehouseWrapper then
        return
      end
      local itemWrapper = warehouseWrapper:getItem(slot.slotNo)
      if nil == itemWrapper then
        return
      end
    end
    if true == _ContentsGroup_RenewUI then
      if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
        return
      end
      local itemWrapper = PaGlobal_CargoLoadding_GetTooltipWareHouseItem(index)
      if nil == itemWrapper then
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      if true == PaGlobal_CargoLoading._isConsole and true == Panel_Tooltup_Item_isShow() then
        Panel_Tooltip_Item_hideTooltip()
        return
      end
      Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingWarehouse", true)
    end
  elseif PaGlobal_CargoLoading._eSlotType.servant == type then
    local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_CargoLoading._servantActorKey, slot.slotNo)
    if nil == itemWrapper then
      return
    end
    if true == _ContentsGroup_RenewUI then
      if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
        return
      end
      local itemWrapper = PaGlobal_CargoLoading_GetTooltipServantItem(index)
      if nil == itemWrapper then
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      if true == PaGlobal_CargoLoading._isConsole and true == Panel_Tooltup_Item_isShow() then
        Panel_Tooltip_Item_hideTooltip()
        return
      end
      Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingServant", true)
    end
  end
  if PaGlobal_CargoLoading._slotNilEffect[index] then
    slot.icon:EraseEffect(PaGlobal_CargoLoading._slotNilEffect[index])
  end
  PaGlobal_CargoLoading._slotNilEffect[index] = slot.icon:AddEffect("UI_Inventory_EmptySlot", false, -1.5, -1.5)
end
function HandleEventMOut_CargoLoading_IconOut(type, index)
  if PaGlobal_CargoLoading._eSlotType.inventory == type then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingWarehouse", false)
  elseif PaGlobal_CargoLoading._eSlotType.servant == type then
    Panel_Tooltip_Item_Show_GeneralNormal(index, "CargoLoadingServant", false)
  end
end
function HandleEventMLUp_CargoLoading_Close()
  PaGlobal_CargoLoading:prepareClose()
end
function HandleEventMLUp_CargoLoading_CheckSort()
  local isSorted = PaGlobal_CargoLoading._ui._chk_sortButton:IsCheck()
  ToClient_SetSortedWarehouse(isSorted)
  ToClient_SetSortedInventory(isSorted)
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function HandleEventMLUp_CargoLoading_UpdateMySlot(_eMySlot)
  PaGlobal_CargoLoading._currentMySlotType = _eMySlot
  PaGlobal_CargoLoading:initSlotInfo_warehouse()
  PaGlobal_CargoLoading:initSlotInfo_ship()
  PaGlobal_CargoLoading:updateMyInventorySlot()
  PaGlobal_CargoLoading:repositionSelectLine()
end
function HandleEventPad_CargoLoading_UpdateSlot(isRight)
  if nil ~= PaGlobalFunc_Util_IsSnappedPanel and false == PaGlobalFunc_Util_IsSnappedPanel(Panel_Window_CargoLoading_ALL) then
    return
  end
  if true == isRight then
    PaGlobal_CargoLoading._currentSelectedTab = PaGlobal_CargoLoading._currentSelectedTab + 1
  else
    PaGlobal_CargoLoading._currentSelectedTab = PaGlobal_CargoLoading._currentSelectedTab - 1
  end
  if PaGlobal_CargoLoading._currentSelectedTab < 0 then
    PaGlobal_CargoLoading._currentSelectedTab = PaGlobal_CargoLoading._eMySlot.myWarehouse
  elseif PaGlobal_CargoLoading._eMySlot.myWarehouse < PaGlobal_CargoLoading._currentSelectedTab then
    PaGlobal_CargoLoading._currentSelectedTab = PaGlobal_CargoLoading._eMySlot.myInven
  end
  if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentSelectedTab then
    PaGlobal_CargoLoading._ui._rdo_MyBag:SetCheck(true)
    PaGlobal_CargoLoading._ui._rdo_myWarehouse:SetCheck(false)
  else
    PaGlobal_CargoLoading._ui._rdo_MyBag:SetCheck(false)
    PaGlobal_CargoLoading._ui._rdo_myWarehouse:SetCheck(true)
  end
  HandleEventMLUp_CargoLoading_UpdateMySlot(PaGlobal_CargoLoading._currentSelectedTab)
end
function HandleEventMRUp_CargoLoading_SlotRClick(eSlotType, slotIndex)
  local actorKeyRaw = PaGlobal_CargoLoading._servantActorKey
  local vehicleActor = getVehicleActor(actorKeyRaw)
  if nil == vehicleActor then
    return
  end
  PaGlobal_CargoLoading._clickedSlotType = eSlotType
  local slots = PaGlobal_CargoLoading._slots[eSlotType]
  if nil == slots[slotIndex].slotNo then
    return
  end
  Panel_NumberPad_Close()
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slots[slotIndex].slotNo, CppEnums.MoveItemToType.Type_ShipWarehouse, actorKeyRaw, true)
  Panel_Tooltip_Item_hideTooltip()
  local itemWrapper = PaGlobal_CargoLoading_GetMoveItem(slots[slotIndex].slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function FromClient_CargoLoading_UpdateMyInventorySlot()
  if false == Panel_Window_CargoLoading_ALL:GetShow() then
    return
  end
  PaGlobal_CargoLoading:updateMyInventorySlot()
end
function FromClient_CargoLoading_UpdateServantinven()
  PaGlobal_CargoLoading:updateServantSlot()
end
function FromClient_CargoLoading_Resize()
  PaGlobal_CargoLoading:resize()
end
function PaGlobal_CargoLoading_GetMoveItem(slotNo)
  if nil == slotNo then
    return nil
  end
  local itemWrapper
  if PaGlobal_CargoLoading._eSlotType.inventory == PaGlobal_CargoLoading._clickedSlotType then
    if PaGlobal_CargoLoading._eMySlot.myInven == PaGlobal_CargoLoading._currentMySlotType then
      return getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    elseif PaGlobal_CargoLoading._eMySlot.myWarehouse == PaGlobal_CargoLoading._currentMySlotType then
      local warehouseWrapper = PaGlobal_CargoLoading:getWarehouse()
      if nil == warehouseWrapper then
        return nil
      end
      return warehouseWrapper:getItem(slotNo)
    end
  elseif PaGlobal_CargoLoading._eSlotType.servant == PaGlobal_CargoLoading._clickedSlotType then
    return getServantInventoryItemBySlotNo(PaGlobal_CargoLoading._servantActorKey, slotNo)
  end
end
function PaGlobal_CargoLoading_PopToSomewhere(s64_count, slotNo)
  if s64_count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_CargoLoading_requestPopToInventory)
  else
    PaGlobal_CargoLoading_requestPopToInventory(s64_count, slotNo)
  end
end
function HandleEventMLUp_CargoLoading_ToggleBarterInfo()
  if false == _ContentsGroup_RenewUI then
    HandleEventMLUp_CargoLoading_ToggleBarterInfoForPC()
  else
    HandleEventMLUp_CargoLoading_ToggleBarterInfoForConsole()
  end
end
function HandleEventMLUp_CargoLoading_ToggleBarterInfoForPC()
  if true == PaGlobal_CargoLoading._isConsole then
    HandleEventMLUp_CargoLoading_Close()
  end
  if true == Panel_Window_Barter_Search:IsShow() then
    PaGlobal_BarterInfoSearch:close()
  else
    PaGlobal_BarterInfoSearch:open()
  end
end
function HandleEventMLUp_CargoLoading_ToggleBarterInfoForConsole()
  if nil == Panel_Window_CargoLoading_ALL or nil == Panel_Window_Barter_Search then
    return
  end
  if false == _ContentsGroup_RenewUI then
    return
  end
  PaGlobalFunc_CargoLoading_SetBarterInfoKeyGuide(false)
  PaGlobal_BarterInfoSearch:open()
end
function PaGlobalFunc_CargoLoading_SetBarterInfoKeyGuide(isShow)
  if nil == Panel_Window_CargoLoading_ALL then
    return
  end
  if false == _ContentsGroup_RenewUI then
    return
  end
  PaGlobal_CargoLoading._ui._stc_keyGuideRSClick:SetShow(isShow)
  PaGlobal_CargoLoading:alignKeyGuide()
end
function HandleEventMOn_CargoLoading_SimpleTooltip()
  local self = PaGlobal_CargoLoading
  TooltipSimple_Show(self._ui._btn_barterInfo, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTERINFO_TITLE"), "")
end
function HandleEventMOut_CargoLoading_SimpleTooltip()
  TooltipSimple_Hide()
end
function PaGlobal_CargoLoading_BasicItemFilter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedItem then
    return true
  end
  local isOriginalForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == isOriginalForDuel then
    return true
  end
  return false
end
