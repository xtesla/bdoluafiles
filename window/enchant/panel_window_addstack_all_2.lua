function PaGloabl_AddStack_All_Open(bgType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:prepareOpen(bgType)
end
function PaGloabl_AddStack_All_OpenSelectList(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:prepareOpenSelectList(itemType)
end
function PaGloabl_AddStack_All_CloseSelectList()
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:prepareCloseSelectList()
  PaGlobal_AddStack_All:update()
end
function HandleEventLUp_AddStack_All_ClickedItem(itemType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if true == PaGlobal_AddStack_All._ui._stc_subSelectBG:GetShow() then
    PaGloabl_AddStack_All_CloseSelectList()
  end
  PaGlobal_AddStack_All:clearControlText()
  PaGlobal_AddStack_All:clearCurrentSelectItem()
  PaGlobal_AddStack_All._currentItemType = itemType
  PaGlobal_AddStack_All._currentItemKey = PaGlobal_AddStack_All._STACK_ITEM_KEY[PaGlobal_AddStack_All._currentItemType]
  PaGlobal_AddStack_All._currentItemWhereType = PaGlobal_AddStack_All._ITEM_WHERETYPE[PaGlobal_AddStack_All._currentItemType]
  if PaGlobal_AddStack_All._currentItemType == PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_VALKS or PaGlobal_AddStack_All._currentItemType == PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_EVENT then
    PaGlobal_AddStack_All_ShowNumPadForValks()
  end
  PaGloabl_AddStack_All_ChangeInvenTab(PaGlobal_AddStack_All._currentItemWhereType)
  PaGlobal_AddStack_All:setCheckItemButton(itemType)
  PaGlobal_AddStack_All:setApplyButton()
  PaGloabl_AddStack_All_OpenSelectList(itemType)
end
function PaGloabl_AddStack_All_ChangeInvenTab(itemWhereType)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if CppEnums.ItemWhereType.eInventory == itemWhereType then
    if nil ~= PaGlobalFunc_Inventory_All_SelectNormalInventory then
      PaGlobalFunc_Inventory_All_SelectNormalInventory()
    end
  elseif CppEnums.ItemWhereType.eCashInventory == itemWhereType and nil ~= PaGlobalFunc_Inventory_All_SelectPearlInventory then
    PaGlobalFunc_Inventory_All_SelectPearlInventory()
  end
end
function PaGloabl_AddStack_All_close()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil ~= TooltipSimple_Hide then
    TooltipSimple_Hide()
  end
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  PaGlobal_AddStack_All_CloseValksNumberPad()
  PaGloabl_AddStack_All_CloseSelectList()
  PaGlobal_AddStack_All:prepareClose()
end
function PaGlobal_AddStack_All_closeByStep()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil ~= TooltipSimple_Hide then
    TooltipSimple_Hide()
  end
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  PaGlobal_AddStack_All_CloseValksNumberPad()
  if true == PaGlobal_AddStack_All._ui._stc_subSelectBG:GetShow() then
    PaGloabl_AddStack_All_CloseSelectList()
    return
  end
  PaGlobal_AddStack_All:prepareClose()
end
function PaGlobal_AddStack_All_UpdateSelectList(contents, key)
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  if PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON == PaGlobal_AddStack_All._currentItemType or PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO == PaGlobal_AddStack_All._currentItemType then
    PaGlobal_AddStack_All_UpdateItemToFailCountList_BlackStone(contents, key)
  elseif PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL == PaGlobal_AddStack_All._currentItemType then
    PaGlobal_AddStack_All_UpdateItemToFailCountList_ValksScroll(contents, key)
  elseif PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == PaGlobal_AddStack_All._currentItemType then
    PaGlobal_AddStack_All_UpdateItemToFailCountList_Consume(contents, key)
  end
end
function PaGlobal_AddStack_All_UpdateItemToFailCountList_BlackStone(contents, key)
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  if nil == contents then
    return
  end
  local idx = Int64toInt32(key)
  local itemButtonControl = UI.getChildControl(contents, "RadioButton_1")
  if nil == itemButtonControl then
    return
  end
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  if nil == itemSlotControl then
    return
  end
  local itemNameControl = UI.getChildControl(itemButtonControl, "StaticText_EquipName")
  if nil == itemNameControl then
    return
  end
  local stackCountControl = UI.getChildControl(itemButtonControl, "StaticText_Stack")
  if nil == stackCountControl then
    return
  end
  local blackStoneItemKey = ItemEnchantKey(PaGlobal_AddStack_All._currentItemKey)
  local itemToFailCountSSW = getItemToFailCountStaticStatus(blackStoneItemKey)
  if nil == itemToFailCountSSW then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(blackStoneItemKey)
  if nil == itemEnchantSSW then
    return
  end
  local itemCount = itemToFailCountSSW:getItemCount(idx)
  local stackCount = itemToFailCountSSW:getStackCount(idx)
  local itemGradeColor = ConvertFromGradeToColor(itemEnchantSSW:getGradeType())
  local itemName = itemEnchantSSW:getName() .. "x" .. tostring(itemCount)
  itemNameControl:SetText(itemName)
  itemNameControl:SetFontColor(itemGradeColor)
  stackCountControl:SetText("+" .. tostring(stackCount))
  local slot = {}
  SlotItem.reInclude(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, PaGlobal_AddStack_All._INVENTORY_SLOT_CONFIG)
  slot:clearItem()
  slot:setItemByStaticStatus(itemEnchantSSW, itemCount)
  slot.icon:addInputEvent("Mouse_On", "")
  slot.icon:addInputEvent("Mouse_Out", "")
  local currentItemCount = PaGlobal_AddStack_All:getItemCount(CppEnums.ItemWhereType.eInventory, PaGlobal_AddStack_All._currentItemKey)
  itemButtonControl:SetCheck(false)
  if itemCount > currentItemCount then
    itemButtonControl:SetMonoTone(true)
    itemButtonControl:SetIgnore(true)
  else
    itemButtonControl:SetMonoTone(false)
    itemButtonControl:SetIgnore(false)
    itemButtonControl:addInputEvent("Mouse_On", "HandleEventMOnOut_AddStack_All_SetKeyGuide(false)")
    itemButtonControl:addInputEvent("Mouse_Out", "HandleEventMOnOut_AddStack_All_SetKeyGuide(true)")
    itemButtonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_SelectListBlackStone(" .. tostring(idx) .. "," .. tostring(PaGlobal_AddStack_All._currentItemKey) .. ")")
    if true == _ContentsGroup_UsePadSnapping and true == PaGlobal_AddStack_All._listSnappingUpdate then
      PaGlobal_AddStack_All._listSnappingUpdate = false
      ToClient_padSnapChangeToTarget(itemButtonControl)
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    itemButtonControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
end
function PaGlobal_AddStack_All_UpdateItemToFailCountList_ValksScroll(contents, key)
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  if nil == contents then
    return
  end
  local itemEnchantKey = Int64toInt32(key)
  local itemButtonControl = UI.getChildControl(contents, "RadioButton_1")
  if nil == itemButtonControl then
    return
  end
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  if nil == itemSlotControl then
    return
  end
  local itemNameControl = UI.getChildControl(itemButtonControl, "StaticText_EquipName")
  if nil == itemNameControl then
    return
  end
  local stackCountControl = UI.getChildControl(itemButtonControl, "StaticText_Stack")
  if nil == stackCountControl then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey, 0))
  if nil == itemEnchantSSW then
    return
  end
  local valksName = itemEnchantSSW:getName()
  local stackCount = string.match(valksName, "%d[%d]*")
  itemNameControl:SetText(itemEnchantSSW:getName())
  stackCountControl:SetText("+" .. tostring(stackCount))
  local itemGradeColor = ConvertFromGradeToColor(itemEnchantSSW:getGradeType())
  itemNameControl:SetFontColor(itemGradeColor)
  local slot = {}
  SlotItem.reInclude(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, PaGlobal_AddStack_All._INVENTORY_SLOT_CONFIG)
  slot:clearItem()
  local itemCount = PaGlobal_AddStack_All:getItemCount(PaGlobal_AddStack_All._currentItemWhereType, itemEnchantKey)
  slot:setItemByStaticStatus(itemEnchantSSW, itemCount)
  slot.icon:addInputEvent("Mouse_On", "")
  slot.icon:addInputEvent("Mouse_Out", "")
  itemButtonControl:SetCheck(false)
  itemButtonControl:SetMonoTone(false)
  itemButtonControl:SetIgnore(false)
  itemButtonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_SelectListValksScroll(" .. tostring(itemEnchantKey) .. ")")
  itemButtonControl:addInputEvent("Mouse_On", "HandleEventMOnOut_AddStack_All_SetKeyGuide(false)")
  itemButtonControl:addInputEvent("Mouse_Out", "HandleEventMOnOut_AddStack_All_SetKeyGuide(true)")
  if true == _ContentsGroup_UsePadSnapping then
    itemButtonControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    if true == PaGlobal_AddStack_All._listSnappingUpdate then
      PaGlobal_AddStack_All._listSnappingUpdate = false
      ToClient_padSnapChangeToTarget(itemButtonControl)
    end
  end
end
function PaGlobal_AddStack_All_UpdateItemToFailCountList_Consume(contents, key)
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  if nil == contents then
    return
  end
  local slotNo = Int64toInt32(key)
  local itemButtonControl = UI.getChildControl(contents, "RadioButton_1")
  if nil == itemButtonControl then
    return
  end
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  if nil == itemSlotControl then
    return
  end
  local itemNameControl = UI.getChildControl(itemButtonControl, "StaticText_EquipName")
  if nil == itemNameControl then
    return
  end
  local stackCountControl = UI.getChildControl(itemButtonControl, "StaticText_Stack")
  if nil == stackCountControl then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getStaticStatus()
  if nil == itemEnchantSSW then
    return
  end
  local slot = {}
  SlotItem.reInclude(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, PaGlobal_AddStack_All._INVENTORY_SLOT_CONFIG)
  slot:clearItem()
  slot:setItem(itemWrapper)
  local stackCount = PaGlobal_AddStack_All:getConsumeStackCount(CppEnums.ItemWhereType.eInventory, slotNo)
  itemButtonControl:SetCheck(false)
  local itemName = PaGlobalFunc_Util_GetItemGradeColorName(itemEnchantSSW:get()._key, false)
  itemNameControl:SetTextMode(__eTextMode_LimitText)
  itemNameControl:SetText(itemName)
  stackCountControl:SetText("+" .. tostring(stackCount))
  itemButtonControl:SetMonoTone(false)
  itemButtonControl:SetIgnore(false)
  itemButtonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_AddStack_All_SelectListConsume(" .. tostring(slotNo) .. ")")
  if true == _ContentsGroup_UsePadSnapping then
    itemButtonControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_AddStack_All_ShowConsumeItemToolTip(" .. tostring(slotNo) .. ",true) ")
    itemButtonControl:addInputEvent("Mouse_On", "HandleEventMOnOut_AddStack_All_SetKeyGuide(true)")
    itemButtonControl:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowConsumeItemToolTip(" .. tostring(slotNo) .. ",false) ")
    if true == PaGlobal_AddStack_All._listSnappingUpdate then
      PaGlobal_AddStack_All._listSnappingUpdate = false
      ToClient_padSnapChangeToTarget(itemButtonControl)
    end
  else
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_AddStack_All_ShowConsumeItemToolTip(" .. tostring(slotNo) .. ",true) ")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_AddStack_All_ShowConsumeItemToolTip(" .. tostring(slotNo) .. ",false) ")
  end
end
function PaGlobal_AddStack_All_ApplyStack()
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  PaGloabl_AddStack_All_ChangeInvenTab(PaGlobal_AddStack_All._currentItemWhereType)
  PaGlobal_AddStack_All:ApplyStack()
end
function HandleEventLUp_AddStack_All_SelectListBlackStone(idx, itemKey)
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  PaGlobal_AddStack_All:clearControlText()
  if PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_WEAPON == PaGlobal_AddStack_All._currentItemType or PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_BLACKSTONE_ARMO == PaGlobal_AddStack_All._currentItemType then
    if nil ~= itemKey and 0 ~= itemKey then
      PaGlobal_AddStack_All._currentItemKey = itemKey
    end
    local itemToFailCountSSW = getItemToFailCountStaticStatus(ItemEnchantKey(PaGlobal_AddStack_All._currentItemKey, 0))
    if nil == itemToFailCountSSW then
      return
    end
    local itemCount = itemToFailCountSSW:getItemCount(idx)
    local stackCount = itemToFailCountSSW:getStackCount(idx)
    PaGlobal_AddStack_All._currentItemWhereType = PaGlobal_AddStack_All._ITEM_WHERETYPE[PaGlobal_AddStack_All._currentItemType]
    PaGlobal_AddStack_All._currentItemCount = itemCount
    PaGloabl_AddStack_All_ChangeInvenTab(PaGlobal_AddStack_All._currentItemWhereType)
    PaGlobal_AddStack_All:setStackRate(stackCount, 0)
  end
  PaGlobal_AddStack_All._ui._list2_selectList:moveTopIndex()
  PaGlobal_AddStack_All:setApplyButton()
  PaGlobal_AddStack_All:setCheckItemButton(PaGlobal_AddStack_All._currentItemType)
  PaGloabl_AddStack_All_CloseSelectList()
end
function HandleEventLUp_AddStack_All_SelectListValksScroll(itemKey)
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:clearControlText()
  if PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_VALKS_SCROLL == PaGlobal_AddStack_All._currentItemType then
    if nil ~= itemKey and 0 ~= itemKey then
      PaGlobal_AddStack_All._currentItemKey = itemKey
    end
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, 0))
    if nil == itemEnchantSSW then
      return
    end
    local valksName = itemEnchantSSW:getName()
    local stackCount = ToClient_GetConvertEnchantFailCountByKey(ItemEnchantKey(itemKey, 0))
    PaGlobal_AddStack_All._currentItemWhereType = PaGlobal_AddStack_All._ITEM_WHERETYPE[PaGlobal_AddStack_All._currentItemType]
    PaGlobal_AddStack_All._currentItemCount = 1
    PaGloabl_AddStack_All_ChangeInvenTab(PaGlobal_AddStack_All._currentItemWhereType)
    PaGlobal_AddStack_All:setStackRate(stackCount, 0)
  end
  PaGlobal_AddStack_All._ui._list2_selectList:moveTopIndex()
  PaGlobal_AddStack_All:setApplyButton()
  PaGlobal_AddStack_All:setCheckItemButton(PaGlobal_AddStack_All._currentItemType)
  PaGloabl_AddStack_All_CloseSelectList()
end
function HandleEventLUp_AddStack_All_SelectListConsume(slotNo)
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All:clearControlText()
  if PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == PaGlobal_AddStack_All._currentItemType then
    PaGlobal_AddStack_All._currentItemSlotNo = slotNo
    PaGlobal_AddStack_All._currentItemWhereType = PaGlobal_AddStack_All._ITEM_WHERETYPE[PaGlobal_AddStack_All._currentItemType]
    PaGloabl_AddStack_All_ChangeInvenTab(PaGlobal_AddStack_All._currentItemWhereType)
    PaGlobal_AddStack_All:setConsumeStack()
  end
  PaGlobal_AddStack_All._ui._list2_selectList:moveTopIndex()
  PaGlobal_AddStack_All:setApplyButton()
  PaGlobal_AddStack_All:setCheckItemButton(PaGlobal_AddStack_All._currentItemType)
  PaGloabl_AddStack_All_CloseSelectList()
end
function PaGlobal_AddStack_All_SetNumpadValksItemCount(inputNum)
  if nil == Panel_Window_AddStack_All then
    return
  end
  PaGlobal_AddStack_All._currentItemCount = Int64toInt32(inputNum)
  PaGlobal_AddStack_All:setStackRate(0, PaGlobal_AddStack_All._currentItemCount)
  PaGlobal_AddStack_All._ui._stc_stackValue:SetShow(true)
  PaGlobal_AddStack_All._ui._stc_stackValue:SetText("+" .. tostring(PaGlobal_AddStack_All._currentItemCount))
  PaGlobal_AddStack_All:setApplyButton()
end
function PaGlobal_AddStack_All_ShowMessageBoxForFailCountCheck()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_VALKS_NOUSE")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_4"),
    content = messageBoxMemo,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_AddStack_All_CheckAndShowFailCountMessageBox()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return
  end
  local currentFailCount = enchantInfo:ToClient_getFailCount()
  if currentFailCount > 0 then
    PaGlobal_AddStack_All_ShowMessageBoxForFailCountCheck()
  end
end
function PaGlobal_AddStack_All_ShowNumPadForValks()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local currentUsableValksCount = PaGlobal_AddStack_All:getValksUsableCount()
  if currentUsableValksCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEnchantStackCountItemCantUse"))
    return
  end
  local currentItemCount = PaGlobal_AddStack_All:getItemCount(PaGlobal_AddStack_All._currentItemWhereType, PaGlobal_AddStack_All._currentItemKey)
  currentUsableValksCount = math.min(currentUsableValksCount, currentItemCount)
  Panel_NumberPad_Show(true, toInt64(0, currentUsableValksCount), nil, PaGlobal_AddStack_All_SetNumpadValksItemCount)
end
function PaGlobal_AddStack_All_UpdateItemCount()
  if nil == Panel_Window_AddStack_All or false == Panel_Window_AddStack_All:GetShow() then
    return
  end
  PaGlobal_AddStack_All:updateItemCount()
end
function PaGlobal_AddStack_All_ShowNoUseValksNakMessage()
  if nil == Panel_Window_AddStack_All then
    return
  end
  local currentUsableValksCount = PaGlobal_AddStack_All:getValksUsableCount()
  if currentUsableValksCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEnchantStackCountItemCantUse"))
  end
  return
end
function PaGlobal_AddStack_All_CloseValksNumberPad()
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil ~= PaGlobal_NumberPad_All_GetShow and nil ~= Panel_NumberPad_Close and true == PaGlobal_NumberPad_All_GetShow() then
    Panel_NumberPad_Close()
  end
end
function HandleEventMOnOut_AddStack_All_SetKeyGuide(isShow)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  PaGlobal_AddStack_All._ui._stc_keyGuideX:SetShow(isShow)
  PaGlobal_AddStack_All:setKeyGuideAlign()
end
function PaGlobal_AddStack_All_ShowItemDetail(itemType, isShow)
  if nil == Panel_Window_AddStack_All then
    return
  end
  if nil ~= TooltipSimple_Hide then
    TooltipSimple_Hide()
  end
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isShow then
    return
  end
  local control = Panel_Window_AddStack_All
  if PaGlobal_AddStack_All._STACK_ITEM_TYPE._ITEM_TYPE_CONSUME == itemType then
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_CONSUME")
    local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_EATENCHANT_DESCRIPTION_FORSTACK")
    TooltipSimple_Show(control, name, desc)
  else
    local itemKeyRaw = PaGlobal_AddStack_All._STACK_ITEM_KEY[itemType]
    if nil == itemKeyRaw then
      return
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKeyRaw))
    if nil == itemSSW then
      return
    end
    if true == _ContentsGroup_RenewUI_Tooltip then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    else
      Panel_Tooltip_Item_Show(itemSSW, control, true)
    end
  end
end
function PaGlobal_AddStack_All_ShowConsumeItemToolTip(slotNo, isShow)
  if nil == Panel_Window_AddStack_All then
    return
  end
  HandleEventMOnOut_AddStack_All_SetKeyGuide(true)
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isShow then
    return
  end
  local control = PaGlobal_AddStack_All._ui._stc_subSelectBG
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true)
  end
end
