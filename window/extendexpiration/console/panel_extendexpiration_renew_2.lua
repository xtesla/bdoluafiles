function PaGlobalFunc_ExtendExpiration_Renew_Open(materialWhereType, materialSlotNo)
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  PaGlobal_ExtendExpiration_Renew:prepareOpen(materialWhereType, materialSlotNo)
end
function PaGlobalFunc_ExtendExpiration_Renew_Close()
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  PaGlobal_ExtendExpiration_Renew:prepareClose()
end
function PaGlobalFunc_ExtendExpiration_Renew_RequestExtendExpiration()
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  if true == PaGlobal_ExtendExpiration_Renew.config.isSetItem then
    local targetWhereType = PaGlobal_ExtendExpiration_Renew.config.targetWhereType
    local targetSlotNo = PaGlobal_ExtendExpiration_Renew.config.targetSlotNo
    local materialWhereType = PaGlobal_ExtendExpiration_Renew.config.materialWhereType
    local materialSlotNo = PaGlobal_ExtendExpiration_Renew.config.materialSlotNo
    local materialCount = PaGlobal_ExtendExpiration_Renew.config.materialCount
    ToClient_ExtendExpirationPeriod(targetWhereType, targetSlotNo, materialWhereType, materialSlotNo, materialCount)
    PaGlobal_ExtendExpiration_Renew._ui._static_Effect:EraseAllEffect()
    PaGlobal_ExtendExpiration_Renew:prepareClose()
  end
end
function PaGlobalFunc_ExtendExpiration_Renew_Inventory_Filter(slotNo, itemWrapper, currentWhereType)
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  if nil == itemWrapper then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return false
  end
  local isExtendedExpiration = itemSSW:isExtendedExpirationPeriod()
  local extendExpirationType = itemSSW:getExtendExpirationPeriodType()
  local isMatchType = PaGlobal_ExtendExpiration_Renew.config.materialExtendExpirationType == extendExpirationType
  if true == isExtendedExpiration and true == isMatchType then
    return false
  else
    return true
  end
end
function FromClient_ClickedExtendExpirationPeriodMaterial(materialWhereType, materialSlotNo)
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  PaGlobalFunc_ExtendExpiration_Renew_Open(materialWhereType, materialSlotNo)
end
function HandlePadEventLUp_ExtendExpiration_Renew_UnSetItem()
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  PaGlobal_ExtendExpiration_Renew.config.targetWhereType = 0
  PaGlobal_ExtendExpiration_Renew.config.targetSlotNo = 0
  PaGlobal_ExtendExpiration_Renew.config.isSetItem = false
  PaGlobal_ExtendExpiration_Renew._ui.item:clearItem()
  Inventory_SetFunctor(PaGlobalFunc_ExtendExpiration_Renew_Inventory_Filter, PaGlobalFunc_ExtendExpiration_Renew_Inventory_Rclick, PaGlobalFunc_ExtendExpiration_Renew_Close, nil)
end
function FromClient_SucceedExtendedExpirationPeriod(targetWhereType, targetSlotNo)
  if nil == Panel_ExtendExpiration_Renew then
    return false
  end
  local targetItemWrapper = getInventoryItemByType(targetWhereType, targetSlotNo)
  if nil == targetItemWrapper then
    return
  end
  local itemSS = targetItemWrapper:getStaticStatus()
  if nil == itemSS then
    return
  end
  local targetItemName = itemSS:getName()
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXTENDEXPIRATION_SUCCEEDEXTENDPERIOD", "name", targetItemName))
end
function PaGlobalFunc_ExtendExpiration_Renew_Inventory_Rclick(slotNo, itemWrapper, count_s64, inventoryType)
  PaGlobal_ExtendExpiration_Renew.config.targetWhereType = inventoryType
  PaGlobal_ExtendExpiration_Renew.config.targetSlotNo = slotNo
  local materialItemWrapper = getInventoryItemByType(PaGlobal_ExtendExpiration_Renew.config.materialWhereType, PaGlobal_ExtendExpiration_Renew.config.materialSlotNo)
  if nil == materialItemWrapper then
    return
  end
  local materialItemSSW = materialItemWrapper:getStaticStatus()
  if nil == materialItemSSW then
    return
  end
  local materialItem = materialItemWrapper:get()
  if nil == materialItem then
    return
  end
  local materialItemEnchantKey = ItemEnchantKey(materialItem:getKey():get())
  local targetItemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == targetItemWrapper then
    return
  end
  PaGlobal_ExtendExpiration_Renew.config.materialMaxCount = targetItemWrapper:getMaxUsableExtendedExpirationMaterialCount(materialItemEnchantKey)
  local funcYes = function()
    local itemWrapper = getInventoryItemByType(PaGlobal_ExtendExpiration_Renew.config.targetWhereType, PaGlobal_ExtendExpiration_Renew.config.targetSlotNo)
    if nil == itemWrapper then
      return
    end
    PaGlobal_ExtendExpiration_Renew._ui.item:setItem(itemWrapper)
    PaGlobal_ExtendExpiration_Renew.config.isSetItem = true
  end
  local isOverExtendedExpiration = targetItemWrapper:isOverExtendedExpirationPeriod(materialItemEnchantKey, PaGlobal_ExtendExpiration_Renew.config.materialMaxCount)
  if true == isOverExtendedExpiration then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_EXTENDEXPIRATION_DONT_OVERPERIOD")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = funcYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    funcYes()
  end
end
