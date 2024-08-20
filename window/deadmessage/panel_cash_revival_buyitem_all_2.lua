function PaGlobal_Cash_Revival_BuyItem_All_Open(respawnType)
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._selectSpawnType = respawnType
  PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo = -1
  PaGlobal_Cash_Revival_BuyItem_All:prepareOpen()
end
function PaGlobal_Cash_Revival_BuyItem_All_Close()
  if nil == Panel_Cash_Revival_BuyItem_All or false == Panel_Cash_Revival_BuyItem_All:GetShow() then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All:prepareClose()
end
function PaGlobal_Cash_Revival_BuyItem_All_RadioReset()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  if false == PaGlobal_Cash_Revival_BuyItem_All._isConsole then
    return
  end
  for idx = 0, PaGlobal_Cash_Revival_BuyItem_All._itemUIMaxCount - 1 do
    local UiBase = PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[idx]
    UiBase.radioButton:SetCheck(false)
  end
end
function ToClient_Cash_Revival_BuyItem_All_Confirm_Do()
  deadMessage_Revival(PaGlobal_Cash_Revival_BuyItem_All._selectSpawnType, PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo].slotNo, PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo].itemWhereType, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  PaGlobal_Cash_Revival_BuyItem_All_Close()
end
function ToClient_Cash_Revival_BuyItem_All_CashRevivalBuy_Do()
  local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(getRevivalItem())
  ToClient_requestBuyItem(cPSSW:getNoRaw(), 1, cPSSW:getPrice(), CppEnums.BuyItemReqTrType.eBuyItemReqTrType_ImmediatelyUse, toInt64(0, -1), 0, 0)
end
function FromClient_Cash_Revival_BuyItem_All_OnScreenReSize()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  local scrSizeX = getOriginScreenSizeX()
  local scrSizeY = getOriginScreenSizeY()
  local panelSizeX = Panel_Cash_Revival_BuyItem_All:GetSizeX()
  local panelSizeY = Panel_Cash_Revival_BuyItem_All:GetSizeY()
  Panel_Cash_Revival_BuyItem_All:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_Cash_Revival_BuyItem_All:SetPosY(scrSizeY / 2 - panelSizeY / 2)
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_confirm_PC:ComputePos()
  PaGlobal_Cash_Revival_BuyItem_All._ui.btn_cancel_PC:ComputePos()
end
function FromClient_Cash_Revival_BuyItem_All_NotifyCacheRespawn()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo = 0
  PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData = {}
  local idx = 0
  if true == _ContentsGroup_FamilyInventory then
    for familyInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eFamilyInventory) - 1 do
      local familyInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eFamilyInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, familyInvenIdx)
      if familyInvenItem ~= nil then
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx] = {}
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].name = familyInvenItem:getStaticStatus():getName()
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].slotNo = familyInvenIdx
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].count = familyInvenItem:get():getCount_s64()
      end
    end
  end
  local cashInvenItem
  for cashInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
    cashInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, cashInvenIdx)
    if cashInvenItem ~= nil then
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx] = {}
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].name = cashInvenItem:getStaticStatus():getName()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].iconPath = cashInvenItem:getStaticStatus():getIconPath()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].slotNo = cashInvenIdx
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eCashInventory
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].count = cashInvenItem:get():getCount_s64()
    end
  end
  ToClient_Cash_Revival_BuyItem_All_Confirm_Do()
end
function HandleEventLUp_Cash_Revival_BuyItem_All_Confirm()
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  if PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_ITEMSELECT_TEXT"))
    return
  end
  local itemStaticStatusWrapper = getItemEnchantStaticStatus(PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo].itemKey)
  if nil == itemStaticStatusWrapper then
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_ThisItemApply", "cashItemName", itemStaticStatusWrapper:getName())
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_Cash_Revival_BuyItem_All_Confirm_Do,
    functionNo = PaGlobal_Cash_Revival_BuyItem_All_RadioReset,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Cash_Revival_BuyItem_All_SelectItem(itemId)
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo = itemId
  for idx = 0, PaGlobal_Cash_Revival_BuyItem_All._itemUIMaxCount - 1 do
    local UiBase = PaGlobal_Cash_Revival_BuyItem_All._itemUIPOOL[idx]
    UiBase.radioButton:SetCheck(false)
    if idx == itemId then
      UiBase.radioButton:SetCheck(true)
    end
  end
  if true == PaGlobal_Cash_Revival_BuyItem_All._isConsole then
    HandleEventLUp_Cash_Revival_BuyItem_All_Confirm()
  end
end
function HandleEventLUp_Cash_Revival_BuyItem_All_Apply_CashRevivalItem(respawnType)
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._selectSpawnType = respawnType
  PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo = 0
  PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData = {}
  local idx = 0
  if true == _ContentsGroup_FamilyInventory then
    for familyInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eFamilyInventory) - 1 do
      local familyInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eFamilyInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, familyInvenIdx)
      if familyInvenItem ~= nil then
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx] = {}
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemKey = familyInvenItem:get():getKey()
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].slotNo = familyInvenIdx
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
        PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].count = familyInvenItem:get():getCount_s64()
      end
    end
  end
  local cashInvenItem
  for cashInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
    cashInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, cashInvenIdx)
    if cashInvenItem ~= nil then
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx] = {}
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemKey = cashInvenItem:get():getKey()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].iconPath = cashInvenItem:getStaticStatus():getIconPath()
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].slotNo = cashInvenIdx
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eCashInventory
      PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[idx].count = cashInvenItem:get():getCount_s64()
    end
  end
  local itemStaticStatusWrapper = getItemEnchantStaticStatus(PaGlobal_Cash_Revival_BuyItem_All._cashRevivalData[PaGlobal_Cash_Revival_BuyItem_All._selectedItemNo].itemKey)
  if nil == itemStaticStatusWrapper then
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_ThisItemApply", "cashItemName", itemStaticStatusWrapper:getName())
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_Cash_Revival_BuyItem_All_Confirm_Do,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Cash_Revival_BuyItem_All_Buy_CashRevivalItem(respawnType)
  if nil == Panel_Cash_Revival_BuyItem_All then
    return
  end
  PaGlobal_Cash_Revival_BuyItem_All._selectSpawnType = respawnType
  local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(getRevivalItem())
  if nil == cPSSW then
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = PAGetStringParam2(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_RevialBuyPearl", "RevivalItemName", cPSSW:getName(), "PearlPrice", tostring(cPSSW:getPrice()))
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_Cash_Revival_BuyItem_All_CashRevivalBuy_Do,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
