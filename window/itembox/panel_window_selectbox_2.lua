function FromClient_useSelectBox(fromWhereType, fromSlotNo)
  local self = PaGlobal_SelectBox
  self:prepareOpen(fromWhereType, fromSlotNo)
end
function PaGlobal_SelectBox_List2Update(content, key)
  local self = PaGlobal_SelectBox
  local idx = Int64toInt32(key)
  local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, self._selectedType, idx)
  local itemCount = ToClient_selectBoxItemCount(self._selectBoxKey, self._selectedType, idx)
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if nil == itemSSW then
    return
  end
  local btn_template = UI.getChildControl(content, "RadioButton_ItemTemplete")
  btn_template:isValidate()
  btn_template:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:selectedItem(" .. tostring(self._selectedType) .. "," .. tostring(idx) .. ")")
  local stc_iconBG = UI.getChildControl(btn_template, "Static_Icon_BG")
  local stc_icon = UI.getChildControl(stc_iconBG, "Static_Icon")
  local txt_itemCount = UI.getChildControl(stc_iconBG, "StaticText_Count")
  stc_icon:SetShow(false)
  txt_itemCount:SetShow(false)
  local txt_itemName = UI.getChildControl(btn_template, "StaticText_ItemName")
  local stc_check = UI.getChildControl(btn_template, "Static_Check")
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "selectBoxItemSlot_", 0, stc_iconBG, PaGlobal_SelectBox._slotConfig)
  itemSlot:setItemByStaticStatus(itemSSW, itemCount)
  if true == self._isConsole then
    itemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_SelectBox:setSnappedList2Index(" .. idx .. ")")
  else
    itemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_SelectBox:showList2ItemTooltip(" .. idx .. ")")
    itemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_SelectBox:hideItemTooltip()")
    itemSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:selectedItem(" .. tostring(self._selectedType) .. "," .. tostring(idx) .. ")")
  end
  txt_itemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_itemName:SetText(itemSSW:getName())
  if true == txt_itemName:IsLimitText() then
    btn_template:addInputEvent("Mouse_On", "PaGlobalFunc_SelectBox_LimitedTextRewardItemNameTooltip(" .. idx .. ", true)")
    btn_template:addInputEvent("Mouse_Out", "PaGlobalFunc_SelectBox_LimitedTextRewardItemNameTooltip(" .. idx .. ", false)")
  end
  local isSelected = ToClient_getSelectBoxIndex(self._selectedType) == idx
  btn_template:SetCheck(isSelected)
  stc_check:SetShow(isSelected)
end
function PaGlobalFunc_SelectBox_LimitedTextRewardItemNameTooltip(index, isShow)
  if nil == index or nil == isShow then
    UI.ASSERT_NAME(false, "\237\140\140\235\157\188\235\175\184\237\132\176\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\152\184\236\182\156 \236\138\164\237\131\157\236\157\132 \237\153\149\236\157\184\237\149\180\236\132\156 \234\188\173 \236\136\152\236\160\149\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
  else
    local content = PaGlobal_SelectBox._ui._list2_items:GetContentByKey(index)
    if nil == content then
      UI.ASSERT_NAME(false, "index\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 \235\166\172\236\138\164\237\138\184 \236\149\132\236\157\180\237\133\156\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local itemKey = ToClient_selectBoxItemEnchantKey(PaGlobal_SelectBox._selectBoxKey, PaGlobal_SelectBox._selectedType, index)
    local itemSSW = getItemEnchantStaticStatus(itemKey)
    if nil == itemSSW then
      UI.ASSERT_NAME(false, "itemKey\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    TooltipSimple_Show(content, itemSSW:getName(), nil)
  end
end
function PaGlobal_ShowSelectBoxInfo_OnlyReadMode(cashProductNoRaw)
  if false == _ContentsGroup_SelectBox then
    return
  end
  if nil == PaGlobal_SelectBox then
    return
  end
  local self = PaGlobal_SelectBox
  if false == self._initialize then
    return
  end
  InGameShopBuy_Close()
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(cashProductNoRaw)
  if nil == cashProduct then
    return
  end
  local isFoundSelectBox = false
  local itemListCount = cashProduct:getItemListCount()
  for ii = 0, itemListCount - 1 do
    local item = cashProduct:getItemByIndex(ii)
    if __eContentsType_SelectBox == item:getContentsEventType() then
      self:setItemAndShow(item, true, nil, nil)
      isFoundSelectBox = true
      break
    end
  end
  if false == isFoundSelectBox then
    local subItemListCount = itemListCount + cashProduct:getSubItemListCount()
    for ii = itemListCount, subItemListCount - 1 do
      local item = cashProduct:getSubItemByIndex(ii - itemListCount)
      if __eContentsType_SelectBox == item:getContentsEventType() then
        self:setItemAndShow(item, true, nil, nil)
        return
      end
    end
  end
end
function PaGlobal_GetShowSelectBoxPanel()
  return Panel_Window_SelectBox:GetShow()
end
function PaGlobal_CloseSelectBoxPanel()
  if nil == PaGlobal_SelectBox then
    return
  end
  if false == PaGlobal_GetShowSelectBoxPanel() then
    return
  end
  PaGlobal_SelectBox:prepareClose()
end
