function HandleEventLUp_HopeGauge_ChargeOpen()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge:ChargeOpen(true)
end
function HandleClicked_SelectFeedItem(idx)
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge:selectFeedItem(idx)
end
function HandleEventLUp_HopeGauge_ChargeScroll(isAll)
  PaGlobal_HopeGauge:ChargeScroll(isAll)
end
function HandleEventOn_HopeGause_IconTooltip(slotIndex)
  local feedItem = ToClient_getItemCollectionScrollByIndex(slotIndex)
  if nil == feedItem then
    return
  end
  Panel_Tooltip_Item_Show(feedItem:getStaticStatus(), PaGlobal_HopeGauge._ui._static_ItemSlots[slotIndex]._button, true, false)
end
function HandleEventOut_HopeGause_IconTooltip()
  Panel_Tooltip_Item_hideTooltip()
end
function FromClient_HopeGauge_updateHopePoint()
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge:update()
end
function FromClient_HopeGauge_updateHopeGrade()
end
function FromClient_HopeGauge_InventoryUpdate()
  PaGlobal_HopeGauge:update()
end
function PaGloabl_HopeGauge_ShowAni()
  if nil == Panel_Widget_HopeGauge then
    return
  end
end
function PaGloabl_HopeGauge_HideAni()
  if nil == Panel_Widget_HopeGauge then
    return
  end
end
function PaGlobal_HopeGauge_Close()
  PaGlobal_HopeGauge:prepareClose()
end
function PaGlobal_HopeGauge_BuffToggle()
  ToClient_ApplyItemCollectionScroll(0, true)
end
registerEvent("FromClient_updateItemCollectionPoint", "FromClient_HopeGauge_updateHopePoint")
registerEvent("FromClient_updateItemCollectionGrade", "FromClient_HopeGauge_updateHopeGrade")
registerEvent("FromClient_InventoryUpdate", "FromClient_HopeGauge_InventoryUpdate")
