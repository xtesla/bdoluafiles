function PaGlobalFunc_GrowPath_PointShop_Close()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_GrowthPass_PointShop:prepareClose()
end
function PaGlobalFunc_GrowPath_PointShop_Show()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  PaGlobal_GrowthPass_PointShop:prepareOpen()
end
function PaGlobalFunc_GrowPath_PointShop_OnClickedBuyButton()
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  local self = PaGlobal_GrowthPass_PointShop
  if nil == self._currentSelectedItemKey then
    return
  end
  ToClient_requestBuyGrowthPassPointShopItem(self._currentSelectedItemKey)
end
function PaGlobalFunc_GrowthPass_ShowPointShopItemTooltip(index, pointShopItemKeyRaw, isShow)
  if nil == Panel_Window_GrowthPass_PointShop then
    return
  end
  if true == isShow then
    local shopItemKey = GrowthPassPointShopItemKey(pointShopItemKeyRaw)
    local shopItemSSW = ToClient_getGrowthPassPointShopItemWrapper(shopItemKey)
    if nil ~= shopItemSSW then
      local itemSSW = shopItemSSW:getItemWrapper()
      if nil ~= itemSSW then
        Panel_Tooltip_Item_Show(itemSSW, PaGlobal_GrowthPass_PointShop._ui._itemList[index].itemSlot.icon, true, false)
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
