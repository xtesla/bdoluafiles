function FromClient_UpdateNotifyExpirationPeriodItemList()
  PaGlobal_ExpirationPeriodItem:prepareOpen()
end
function PaGlobalFunc_ExpirationPeriodItem_List2Update(content, key)
  local idx = Int64toInt32(key)
  local wrapper = ToClient_getNotifyExpirationPeriodItemWrapper(idx)
  if nil == wrapper then
    return
  end
  local stc_slot = UI.getChildControl(content, "Static_Slot")
  local icon_item = UI.getChildControl(stc_slot, "Static_ItemIcon")
  local txt_itemName = UI.getChildControl(stc_slot, "StaticText_ItemName")
  local txt_leftTime = UI.getChildControl(stc_slot, "StaticText_ReminTime")
  local itemSSW = getItemEnchantStaticStatus(wrapper:getEnchantKey())
  if nil ~= itemSSW then
    icon_item:ChangeTextureInfoName("Icon/" .. itemSSW:getIconPath())
    txt_itemName:SetText(itemSSW:getName())
    UI.setLimitTextAndAddTooltip(txt_itemName, "", itemSSW:getName())
  end
  txt_leftTime:SetText(convertStringFromDatetime(wrapper:getLeftTime()))
end
