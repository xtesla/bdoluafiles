function PaGlobal_SimpleInventory_SearchResult_List2Update(content, key)
  local self = PaGlobal_SimpleInventory_SearchResult
  local index = Int64toInt32(key)
  local itemWrapper = ToClient_SimpleSearchItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  local txt_element = UI.getChildControl(content, "StaticText_SearchElement")
  local characterName = itemWrapper:getCharacterName()
  local itemEnchantKey = itemWrapper:getItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemSSW then
    return
  end
  local itemName = PaGlobalFunc_Util_GetItemGradeColorName(itemEnchantKey, false)
  txt_element:SetText(characterName .. " > " .. itemName)
  UI.setLimitTextAndAddTooltip(txt_element)
  txt_element:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:gotoSlot(" .. tostring(index) .. ")")
end
function PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(tooltipType, isShow)
  if nil == Panel_Window_SimpleInventory_SearchResult then
    return
  end
  TooltipSimple_Hide()
  if false == isShow then
    return
  end
  local tooltipData = PaGlobal_SimpleInventory_SearchResult._SIMPLE_TOOLTIP_DATA[tooltipType]
  if nil == tooltipData then
    return
  end
  if nil == tooltipData.control then
    return
  end
  TooltipSimple_Show(tooltipData.control, tooltipData.name, tooltipData.desc)
end
