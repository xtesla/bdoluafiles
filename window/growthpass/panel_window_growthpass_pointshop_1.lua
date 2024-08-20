function PaGlobal_GrowthPass_PointShop:initialize()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  self:registEventHandler()
  self:initializeControl()
  self:initializeShop()
  self:validate()
  self._initialize = true
end
function PaGlobal_GrowthPass_PointShop:registEventHandler()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
end
function PaGlobal_GrowthPass_PointShop:initializeControl()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  self._ui._btn_buy:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowPath_PointShop_OnClickedBuyButton()")
  self._ui._item_frame = UI.getChildControl(self._ui._stc_item_bg, "PointShop_Frame")
  self._ui._item_frame_content = UI.getChildControl(self._ui._item_frame, "PointShop_Frame_Content")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title_bg, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowPath_PointShop_Close()")
end
function PaGlobal_GrowthPass_PointShop:initializeShop()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  local originalItemWrapTemplate = UI.getChildControl(self._ui._item_frame_content, "Static_Item_Wrap")
  self._totalItemCount = ToClient_getGrowthPassPointShopItemTotalCount()
  self._ui._itemList = {}
  local itemWrapControlSizeX = originalItemWrapTemplate:GetSizeX()
  local itemWrapControlSizeY = originalItemWrapTemplate:GetSizeY()
  local position_x = 0
  local position_y = 0
  for index = 0, self._totalItemCount - 1 do
    local pointShopItemKey = ToClient_getGrowthPassPointShopItemKey(index)
    local pointShopSSW = ToClient_getGrowthPassPointShopItemWrapper(pointShopItemKey)
    if nil ~= pointShopSSW then
      local shopItemData = {
        shopItemKey = pointShopItemKey,
        itemWrapControl = nil,
        itemButton = nil,
        itemSlotParent = nil,
        itemSlot = nil,
        itemPrice = nil,
        itemName = nil,
        itemPurchaseCount = nil
      }
      local shopItemButtonName = "PointShopItem_Clone_" .. tostring(index)
      shopItemData.itemWrapControl = UI.cloneControl(originalItemWrapTemplate, self._ui._item_frame_content, shopItemButtonName)
      shopItemData.itemButton = UI.getChildControl(shopItemData.itemWrapControl, "RadioButton_ItemBox")
      shopItemData.itemSlotParent = UI.getChildControl(shopItemData.itemButton, "Static_ItemSlot")
      local itemPriceParent = UI.getChildControl(shopItemData.itemButton, "StaticText_Price")
      shopItemData.itemPrice = UI.getChildControl(itemPriceParent, "StaticText_1")
      shopItemData.itemName = UI.getChildControl(shopItemData.itemButton, "StaticText_Item_Main")
      shopItemData.itemPurchaseCount = UI.getChildControl(shopItemData.itemButton, "StaticText_Num")
      local tempSlot = {}
      SlotItem.new(tempSlot, "PointShop_Item_Icon_" .. tostring(index), index, shopItemData.itemSlotParent, self._slotConfig)
      tempSlot:createChild()
      tempSlot.icon:SetSize(42, 42)
      tempSlot.icon:SetPosX(0)
      tempSlot.icon:SetPosY(0)
      tempSlot.icon:SetHorizonCenter()
      tempSlot.icon:SetVerticalMiddle()
      tempSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowPointShopItemTooltip(" .. tostring(index) .. "," .. tostring(pointShopItemKey:get()) .. ", true)")
      tempSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_ShowPointShopItemTooltip(" .. tostring(index) .. "," .. tostring(pointShopItemKey:get()) .. ", false)")
      tempSlot:clearItem()
      tempSlot:setItemByStaticStatus(pointShopSSW:getItemWrapper(), pointShopSSW:getItemCount())
      shopItemData.itemSlot = tempSlot
      shopItemData.itemName:SetTextMode(__eTextMode_LimitText)
      shopItemData.itemName:SetText(pointShopSSW:getItemWrapper():getName())
      if index % 2 == 0 then
        position_x = 0
        position_y = index / 2 * itemWrapControlSizeY
      else
        position_x = itemWrapControlSizeX
      end
      shopItemData.itemWrapControl:SetPosX(position_x)
      shopItemData.itemWrapControl:SetPosY(position_y)
      self._ui._itemList[index] = shopItemData
    end
  end
  local vScroll = self._ui._item_frame:GetVScroll()
  if self._ui._item_frame:GetSizeY() < self._ui._item_frame_content:GetSizeY() then
    vScroll:SetShow(true)
  else
    vScroll:SetShow(false)
  end
  UI.deleteControl(originalItemWrapTemplate)
end
function PaGlobal_GrowthPass_PointShop:initFrame()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  self._currentSelectedItemKey = nil
  for index = 0, self._totalItemCount - 1 do
    local shopItemData = self._ui._itemList[index]
    if nil ~= shopItemData then
      shopItemData.itemButton:SetCheck(false)
    end
  end
  local vScroll = self._ui._item_frame:GetVScroll()
  if true == vScroll:GetShow() then
    vScroll:SetControlPos(0)
  end
  self._ui._item_frame:UpdateContentPos()
end
function PaGlobal_GrowthPass_PointShop:updatePoint()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  local currentGrowthPassPoint = ToClient_getGrowthPassCurrentPoint()
  self._ui._stc_current_point:SetText(tostring(currentGrowthPassPoint))
end
function PaGlobal_GrowthPass_PointShop:updateItemShop()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
end
function PaGlobal_GrowthPass_PointShop:prepareOpen()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  do return end
  do break end
  self:initFrame()
  self:updatePoint()
  self:updateItemShop()
  PaGlobal_GrowthPass_PointShop:open()
end
function PaGlobal_GrowthPass_PointShop:open()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  Panel_Window_GrowthPass_PointShop:SetShow(true)
end
function PaGlobal_GrowthPass_PointShop:prepareClose()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  PaGlobal_GrowthPass_PointShop:close()
end
function PaGlobal_GrowthPass_PointShop:close()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  Panel_Window_GrowthPass_PointShop:SetShow(false)
end
function PaGlobal_GrowthPass_PointShop:validate()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  self._ui._btn_close:isValidate()
end
