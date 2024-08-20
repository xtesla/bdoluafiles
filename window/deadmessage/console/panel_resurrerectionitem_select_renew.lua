Panel_Resurrection_ItemSelect:SetShow(false)
local resurrectionItem = {
  _ui = {
    _staticText_Title = UI.getChildControl(Panel_Resurrection_ItemSelect, "StaticText_Title"),
    _static_Inner = UI.getChildControl(Panel_Resurrection_ItemSelect, "Static_Inner"),
    _button_Item_Template = UI.getChildControl(Panel_Resurrection_ItemSelect, "Button_Item_Template"),
    _staticText_ItemSelectDesc1 = UI.getChildControl(Panel_Resurrection_ItemSelect, "StaticText_ItemSelectDesc1"),
    _staticText_ItemSelectDesc2 = UI.getChildControl(Panel_Resurrection_ItemSelect, "StaticText_ItemSelectDesc2")
  },
  _config = {
    _maxRowCount = 2,
    _maxItemCount = 6,
    _startPosX = 50,
    _slotConfig = {
      createIcon = true,
      createCount = true,
      createFamilyInvenotry = true
    },
    _buttonXPos = {
      [0] = 231,
      [1] = 181,
      [2] = 281,
      [3] = 131,
      [4] = 331,
      [5] = 381
    }
  },
  _selectItemNo = nil,
  _cashRivivalData = {},
  _cashRevivalCount = 0,
  _familyRevivalCount = 0,
  _itemSlot = {},
  _selectSpawnType
}
function resurrectionItem:initialize()
  self._ui._staticText_ItemSelectDesc1:SetTextMode(__eTextMode_AutoWrap)
  self._ui._staticText_ItemSelectDesc2:SetTextMode(__eTextMode_AutoWrap)
  self._ui._staticText_ItemSelectDesc1:SetText(self._ui._staticText_ItemSelectDesc1:GetText())
  self._ui._staticText_ItemSelectDesc2:SetText(self._ui._staticText_ItemSelectDesc2:GetText())
  self:createControl()
  self:resetData()
end
function resurrectionItem:createControl()
  for row = 0, self._config._maxRowCount - 1 do
    local yPosGap = 46
    for index = 0, self._config._maxItemCount - 1 do
      local slotIndex = row * self._config._maxItemCount + index
      local slotInfo = {}
      local productControl = UI.createControl(__ePAUIControl_Button, Panel_Resurrection_ItemSelect, "Button_Item_" .. slotIndex)
      CopyBaseProperty(self._ui._button_Item_Template, productControl)
      productControl:SetShow(false)
      productControl:SetIgnore(false)
      productControl:SetPosX(self._config._buttonXPos[index])
      productControl:SetPosY(productControl:GetPosY() + yPosGap * row)
      local itemSlot = {}
      SlotItem.new(itemSlot, "Item_Slot_" .. slotIndex, slotIndex, productControl, self._config._slotConfig)
      itemSlot:createChild()
      slotInfo.slot = productControl
      slotInfo.item = itemSlot
      slotInfo.item.icon:SetPosX(3)
      slotInfo.item.icon:SetPosY(3)
      self._itemSlot[slotIndex] = slotInfo
    end
  end
  self._ui._button_Item_Template:SetShow(false)
  Panel_Resurrection_ItemSelect:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ResurrerectionItem_BuyConfirm()")
end
function resurrectionItem:resetData()
  self._selectItemNo = 0
  self._cashRivivalData = {}
  self._cashRevivalCount = 0
  self._familyRevivalCount = 0
  self._selectSpawnType = 0
end
function PaGlobalFunc_ResurrerectionItem_TemporaryClose()
  resurrectionItem:temporaryClose()
end
function PaGlobalFunc_ResurrerectionItem_TemporaryOpen()
  resurrectionItem:temporaryOpen()
end
function resurrectionItem:temporaryClose()
  Panel_Resurrection_ItemSelect:SetShow(false)
end
function resurrectionItem:temporaryOpen()
  Panel_Resurrection_ItemSelect:SetShow(true)
end
function resurrectionItem:open()
  if true == Panel_Resurrection_ItemSelect:GetShow() then
    return
  end
  self:setPosition()
  Panel_Resurrection_ItemSelect:SetShow(true)
end
function PaGlobalFunc_ResurrerectionItem_Open(respawnType)
  resurrectionItem._selectSpawnType = respawnType
  resurrectionItem:update()
  resurrectionItem:open()
end
function resurrectionItem:close()
  if false == Panel_Resurrection_ItemSelect:GetShow() then
    return
  end
  Panel_Resurrection_ItemSelect:SetShow(false)
end
function PaGlobalFunc_ResurrerectionItem_Close()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  resurrectionItem:close()
end
function resurrectionItem:update()
  for index = 0, self._config._maxItemCount * self._config._maxRowCount - 1 do
    self._itemSlot[index].slot:SetShow(false)
    self._itemSlot[index].item.icon:SetShow(false)
    self._itemSlot[index].item.count:SetShow(false)
    self._itemSlot[index].item.familyInvenIcon:SetShow(false)
  end
  resurrectionItem:updateItemInfo()
  local slotCount = self._cashRevivalCount
  if slotCount > self._config._maxItemCount then
    slotCount = self._config._maxItemCount
  end
  local isOdd = slotCount % 2
  local xgap = 0
  if 0 == isOdd then
    xgap = 25
  end
  for index = 0, slotCount - 1 do
    self._itemSlot[index].item.icon:ChangeTextureInfoName(self._cashRivivalData[index].icon)
    self._itemSlot[index].item.icon:SetShow(true)
    self._itemSlot[index].item.count:SetShow(true)
    self._itemSlot[index].item.count:SetText(tostring(self._cashRivivalData[index].count))
    self._itemSlot[index].item.familyInvenIcon:SetShow(CppEnums.ItemWhereType.eFamilyInventory == self._cashRivivalData[index].itemWhereType)
    self._itemSlot[index].slot:SetShow(true)
    self._itemSlot[index].slot:addInputEvent("Mouse_On", "PaGlobalFunc_ResurrectionItem_SelectItem(" .. index .. ")")
    self._itemSlot[index].slot:SetPosX(self._config._buttonXPos[index] + xgap)
  end
  if true == _ContentsGroup_FamilyInventory then
    slotCount = self._familyRevivalCount
    if slotCount > self._config._maxItemCount then
      slotCount = self._config._maxItemCount
    end
    isOdd = slotCount % 2
    if 0 == isOdd then
      xgap = 25
    else
      xgap = 0
    end
    for index = 0, slotCount - 1 do
      local dataIndex = self._cashRevivalCount + index
      local slotIndex = self._config._maxItemCount + index
      self._itemSlot[slotIndex].item.icon:ChangeTextureInfoName(self._cashRivivalData[dataIndex].icon)
      self._itemSlot[slotIndex].item.icon:SetShow(true)
      self._itemSlot[slotIndex].item.count:SetShow(true)
      self._itemSlot[slotIndex].item.count:SetText(tostring(self._cashRivivalData[dataIndex].count))
      self._itemSlot[slotIndex].item.familyInvenIcon:SetShow(CppEnums.ItemWhereType.eFamilyInventory == self._cashRivivalData[dataIndex].itemWhereType)
      self._itemSlot[slotIndex].slot:SetShow(true)
      self._itemSlot[slotIndex].slot:addInputEvent("Mouse_On", "PaGlobalFunc_ResurrectionItem_SelectItem(" .. dataIndex .. ")")
      self._itemSlot[slotIndex].slot:SetPosX(self._config._buttonXPos[index] + xgap)
    end
  end
end
function resurrectionItem:setPosition()
  local scrSizeX = getOriginScreenSizeX()
  local scrSizeY = getOriginScreenSizeY()
  local panelSizeX = Panel_Resurrection_ItemSelect:GetSizeX()
  local panelSizeY = Panel_Resurrection_ItemSelect:GetSizeY()
  Panel_Resurrection_ItemSelect:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_Resurrection_ItemSelect:SetPosY(scrSizeY / 2 - panelSizeY / 2)
end
function resurrectionItem:selectItem(index)
  self._selectItemNo = index
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, getInventoryItemByType(self._cashRivivalData[index].itemWhereType, self._cashRivivalData[index].slotNo), Defines.TooltipTargetType.Item, 0)
end
function PaGlobalFunc_ResurrectionItem_SelectItem(index)
  resurrectionItem:selectItem(index)
end
function resurrectionItem:updateItemInfo()
  local idx = 0
  self._selectItemNo = 0
  self._cashRivivalData = {}
  self._familyRevivalCount = 0
  self._cashRevivalCount = 0
  local cashRevivalData = self._cashRivivalData
  local cashItemCount = 0
  for cashInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
    local cashInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, cashInvenIdx)
    if cashInvenItem ~= nil then
      cashRevivalData[idx] = {}
      cashRevivalData[idx].name = cashInvenItem:getStaticStatus():getName()
      cashRevivalData[idx].slotNo = cashInvenIdx
      cashRevivalData[idx].itemWhereType = CppEnums.ItemWhereType.eCashInventory
      cashRevivalData[idx].count = cashInvenItem:get():getCount_s64()
      cashRevivalData[idx].icon = "icon/" .. cashInvenItem:getStaticStatus():getIconPath()
      self._cashRevivalCount = self._cashRevivalCount + 1
      idx = idx + 1
    end
    cashInvenIdx = cashInvenIdx + 1
  end
  if true == _ContentsGroup_FamilyInventory then
    for familyInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eFamilyInventory) - 1 do
      local familyInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eFamilyInventory, CppEnums.ItemProductCategory.eItemProductCategory_Revival, familyInvenIdx)
      if familyInvenItem ~= nil then
        self._cashRivivalData[idx] = {}
        self._cashRivivalData[idx].name = familyInvenItem:getStaticStatus():getName()
        self._cashRivivalData[idx].slotNo = familyInvenIdx
        self._cashRivivalData[idx].itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
        self._cashRivivalData[idx].count = familyInvenItem:get():getCount_s64()
        self._cashRivivalData[idx].icon = "icon/" .. familyInvenItem:getStaticStatus():getIconPath()
        self._familyRevivalCount = self._familyRevivalCount + 1
        idx = idx + 1
      end
    end
  end
end
function resurrectionItem:cashRevivalConfirm()
  local ItemData = self._cashRivivalData[self._selectItemNo]
  if nil ~= ItemData then
    deadMessage_Revival(self._selectSpawnType, ItemData.slotNo, ItemData.itemWhereType, getSelfPlayer():getRegionKey(), false, toInt64(0, 0))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(StringSheet_GAME, "LUA_DEADMESSAGE_GET_ITEM_RESURRECTION", "revivalitemCount", 0))
  end
  self:close()
end
function resurrectionItem:applyItem(respawnType)
  self._selectSpawnType = respawnType
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = ""
  local idx = 0
  self._selectItemNo = 0
  self._cashRivivalData = {}
  self:updateItemInfo()
  local itemData = self._cashRivivalData[self._selectItemNo]
  msgContent = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_ThisItemApply", "cashItemName", itemData.name)
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_CashRevivalBuy_Confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  resurrectionItem:temporaryClose()
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_ResurrerectionItem_ApplyItem(respawnType)
  resurrectionItem:applyItem(respawnType)
end
function resurrectionItem:buyItem(respawnType)
  self._selectSpawnType = respawnType
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = ""
  local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(getRevivalItem())
  msgContent = PAGetStringParam2(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_RevialBuyPearl", "RevivalItemName", cPSSW:getName(), "PearlPrice", tostring(cPSSW:getPrice()))
  local ToClient_BuyCashRevival = function()
    local cPSSW = ToClient_GetCashProductStaticStatusWrapperByKeyRaw(getRevivalItem())
    ToClient_requestBuyItem(cPSSW:getNoRaw(), 1, cPSSW:getPrice(), CppEnums.BuyItemReqTrType.eBuyItemReqTrType_ImmediatelyUse, toInt64(0, -1), 0, 0)
  end
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_BuyCashRevival,
    functionNo = PaGlobalFunc_ResurrerectionItem_TemporaryOpen,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  PaGlobalFunc_ResurrerectionItem_TemporaryClose()
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_ResurrerectionItem_buyItem(respawnType)
  resurrectionItem:buyItem(respawnType)
end
function resurrectionItem:BuyConfirm()
  if nil == self._selectItemNo or self._selectItemNo < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMARKET_REGISTITEM_ITEMSELECT_TEXT"))
    return
  end
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "EXCHANGE_TEXT_STATE_FINAL_CHECK")
  local msgContent = ""
  local ItemData = self._cashRivivalData[self._selectItemNo]
  msgContent = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Cash_Revival_BuyItem_Confirm_ThisItemApply", "cashItemName", ItemData.name)
  local messageboxData = {
    title = msgTitle,
    content = msgContent,
    functionYes = ToClient_CashRevivalBuy_Confirm,
    functionNo = PaGlobalFunc_ResurrerectionItem_TemporaryOpen,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  PaGlobalFunc_ResurrerectionItem_TemporaryClose()
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_ResurrerectionItem_BuyConfirm()
  resurrectionItem:BuyConfirm()
end
function PaGlobalFunc_ResurrerectionItem_GetShow()
  return Panel_Resurrection_ItemSelect:GetShow()
end
function ToClient_CashRevivalBuy_Confirm()
  resurrectionItem:cashRevivalConfirm()
end
function resurrectionItem:notifyCacheRespawn()
  self:updateItemInfo()
  ToClient_CashRevivalBuy_Confirm()
end
function FromClient_NotifyCacheRespawn()
  resurrectionItem:notifyCacheRespawn()
end
function FromClient_luaLoadComplete_ResurrectionItem()
  resurrectionItem:initialize()
end
function resurrectionItem:registEventHandler()
  registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_ResurrectionItem")
  registerEvent("FromClient_NotifyCacheRespawn", "FromClient_NotifyCacheRespawn")
end
resurrectionItem:registEventHandler()
