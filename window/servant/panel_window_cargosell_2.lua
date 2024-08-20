function PaGlobal_CargoSell_Open(waypointKey)
  if nil == Panel_Window_CargoSell then
    return
  end
  if true == Panel_Window_CargoSell:GetShow() then
    return
  end
  PaGlobal_CargoSell:prepareOpen(waypointKey)
end
function PaGlobal_CargoSell_Close()
  if nil == Panel_Window_CargoSell then
    return
  end
  if false == Panel_Window_CargoSell:GetShow() then
    return
  end
  PaGlobal_CargoSell:prepareClose()
end
function PaGlobal_CargoSellList_CreateControlList2(content, key)
  local self = PaGlobal_CargoSell
  local index = Int64toInt32(key)
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return
  end
  local itemWrapper = ToClient_getCargoSellListItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local stc_slot = UI.getChildControl(content, "Static_Slot")
  local stc_slotBG = UI.getChildControl(stc_slot, "Static_SlotBG")
  local stc_slotIcon = UI.getChildControl(stc_slotBG, "Static_Icon")
  stc_slotIcon:SetIgnore(true)
  local slot = {}
  SlotItem.reInclude(slot, "CargosellItemListSlot_", 0, stc_slotIcon, PaGlobal_CargoSell._slotConfig)
  slot:clearItem()
  slot:setItem(itemWrapper)
  slot.icon:SetIgnore(true)
  local txt_name = UI.getChildControl(stc_slot, "StaticText_ItemName")
  local txt_price = UI.getChildControl(stc_slot, "StaticText_Price")
  txt_name:SetTextMode(__eTextMode_LimitText)
  txt_name:SetText(itemSSW:getName())
  PAGlobalFunc_SetItemTextColorForNewUI(txt_name, itemSSW)
  local totalPrice = itemSSW:get()._sellPriceToNpc_s64 * itemWrapper:getCount()
  txt_price:SetText(makeDotMoney(totalPrice))
  if true == PaGlobal_CargoSell._isConsole then
    stc_slot:addInputEvent("Mouse_LUp", "PaGlobal_CargoSell_PopListItem(" .. index .. ")")
  else
    stc_slot:addInputEvent("Mouse_RUp", "PaGlobal_CargoSell_PopListItem(" .. index .. ")")
  end
  if false == _ContentsGroup_RenewUI then
    stc_slot:addInputEvent("Mouse_On", "HandleEventMOn_PaGlobal_CargoSellList_IconOver(" .. index .. ")")
    stc_slot:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  else
    stc_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEvent_PaGlobal_CargoSell_ShowDetailTooltip(" .. index .. ")")
  end
end
function HandleEventLUp_CargoSell_CheckSort()
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(0, 0)
  local isSorted = false
  if true == PaGlobal_CargoSell._isConsole then
    isSorted = not PaGlobal_CargoSell._isSorted
  else
    isSorted = PaGlobal_CargoSell._ui._btn_itemsort:IsCheck()
  end
  PaGlobal_CargoSell._isSorted = isSorted
  PaGlobal_CargoSell._ui._btn_itemsort:SetCheck(isSorted)
  PaGlobal_CargoSell:update()
end
function HandleEventLUp_CargoSell_Sell()
  if PaGlobal_CargoSell._sellTotalPrice <= toInt64(0, 0) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemCountIsInvalid"))
    return
  end
  local CargoSellComfirm = function()
    ToCleint_SellCargoSellListItem()
  end
  local titleText = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local contentText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CARGOSELL_MESSAGE_DESC", "totalprice", makeDotMoney(PaGlobal_CargoSell._sellTotalPrice))
  local messageboxData = {
    title = titleText,
    content = contentText,
    functionApply = CargoSellComfirm,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEvent_PaGlobal_CargoSell_Scroll(isUp)
  local useStartSlot = 1
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return
  end
  local scrollPos = PaGlobal_CargoSell._ui._scroll_warehouse:GetControlPos()
  if true == isUp and 0 == scrollPos then
    return
  elseif false == isUp and 1 == scrollPos then
    return
  end
  local maxSize = warehouseWrapper:getMaxCount() - useStartSlot + 6
  PaGlobal_CargoSell._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_CargoSell._ui._scroll_warehouse, isUp, PaGlobal_CargoSell._config.slotRows, maxSize, PaGlobal_CargoSell._startSlotIndex, PaGlobal_CargoSell._config.slotCols)
  PaGlobal_CargoSell:update()
end
function HandleEventRUp_PaGlobal_CargoSell_ShowDetailTooltip(index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return
  end
  local slot = PaGlobal_CargoSell._slots[index]
  local itemWrapper = warehouseWrapper:getItem(slot.slotNo)
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "CargoSell")
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function HandleEvent_PaGlobal_CargoSell_ShowDetailTooltip(index)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = ToClient_getCargoSellListItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  if nil ~= itemWrapper then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "CargoSell")
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function PaGlobal_CargoSell_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobal_CargoSell_GetItem)
end
function PaGlobal_CargoSell_GetItem(slotNo)
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  if nil == warehouseWrapper then
    return nil
  end
  return (warehouseWrapper:getItem(slotNo))
end
function HandleEventRUp_PaGlobal_CargoSell_Item(index)
  local slotNo = PaGlobal_CargoSell._slots[index].slotNo
  if nil == slotNo then
    return
  end
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  Panel_NumberPad_Close()
  if false == itemSSW:get():isCargoSellPossible() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemCantSellItem"))
    return
  end
  Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobal_CargoSell_ToCargoSellList)
end
function PaGlobal_CargoSell_ToCargoSellList(s64_count, slotNo)
  ToClient_PushCargoSellListItem(s64_count, slotNo)
end
function PaGlobal_CargoSell_PopListItem(index)
  ToClient_PopCargoSellWareHouse(index)
end
function HandleEventMOn_PaGlobal_CargoSell_IconOver(index)
  local slotNo = PaGlobal_CargoSell._slots[index].slotNo
  if nil == slotNo then
    return
  end
  if nil == PaGlobal_CargoSell._slots[index].icon then
    return
  end
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil ~= itemWrapper then
    Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), PaGlobal_CargoSell._slots[index].icon, true, false)
  end
end
function HandleEventConsoleMouseOn_PaGlobal_CargoSell_IconOver(index, isShow)
  if false == isShow then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local slotNo = PaGlobal_CargoSell._slots[index].slotNo
  if nil == slotNo then
    return
  end
  if nil == PaGlobal_CargoSell._slots[index].icon then
    return
  end
  local warehouseWrapper = ToClient_getCargoSellWareHouse()
  local itemWrapper = warehouseWrapper:getItem(slotNo)
  if nil ~= itemWrapper then
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper:getStaticStatus(), Defines.TooltipTargetType.Item, PaGlobal_CargoSell._slots[index].icon, "WareHouse")
  end
end
function HandleEventMOn_PaGlobal_CargoSellList_IconOver(index)
  local itemWrapper = ToClient_getCargoSellListItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  local content = PaGlobal_CargoSell._ui._list2_sell:GetContentByKey(index)
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), content, true, false)
  if true == PaGlobal_CargoSell._isConsole then
    PaGlobal_CargoSell._consoleShowIndex = index
  end
end
function HandleEventMOut_PaGlobal_CargoSell_IconOut(index)
  Panel_Tooltip_Item_hideTooltip()
end
function FromClient_PaGlobal_CargoSell_Update()
  PaGlobal_CargoSell:update()
  if true == _ContentsGroup_RenewUI then
    if true == PaGlobalFunc_FloatingTooltip_GetShow() then
      PaGlobalFunc_FloatingTooltip_Close()
    end
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    end
  end
end
function FromClient_CargoSellComplete()
  PaGlobal_CargoSell_Close()
  PaGlobal_Warehouse_All_OpenPanelFromDialog()
  if nil ~= PaGlobal_WareHouse_All then
    PaGlobal_WareHouse_All:setInventoryItemMoveEvent(true)
  end
end
function PaGlobalFunc_CargoSell_SilverChange(itemCount)
  if nil == Panel_Window_CargoSell or false == Panel_Window_CargoSell:GetShow() then
    return
  end
  if itemCount >= toInt64(0, 0) and itemCount < toInt64(0, 1000000) then
    audioPostEvent_SystemUi(6, 3)
  elseif itemCount >= toInt64(0, 1000000) and itemCount < toInt64(0, 10000000) then
    audioPostEvent_SystemUi(6, 5)
  elseif itemCount >= toInt64(0, 10000000) and itemCount < toInt64(0, 50000000) then
    audioPostEvent_SystemUi(6, 6)
  elseif itemCount >= toInt64(0, 50000000) and itemCount < toInt64(0, 200000000) then
    audioPostEvent_SystemUi(6, 7)
  elseif itemCount >= toInt64(0, 200000000) and itemCount < toInt64(0, 500000000) then
    audioPostEvent_SystemUi(6, 8)
  else
    audioPostEvent_SystemUi(6, 9)
  end
end
function PaGlobal_CargoSell_ShowAni()
  if nil == Panel_Window_CargoSell then
    return
  end
end
function PaGlobal_CargoSell_HideAni()
  if nil == Panel_Window_CargoSell then
    return
  end
end
