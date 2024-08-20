function PaGlobal_DeleteMaxEnchanterName_Close()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:prepareClose()
end
function PaGlobal_DeleteMaxEnchanterName_GetShow()
  if nil == Panel_DeleteMaxEnchanterName then
    return false
  end
  return Panel_DeleteMaxEnchanterName:GetShow()
end
function HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Exit()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:prepareClose()
end
function HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Button()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:doDeleteName()
end
function HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipShow(index)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  local slotdata = PaGlobal_DeleteMaxEnchanterName._viewSlotNo[index]
  if nil == slotdata then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventoryBag, slotdata)
  local control = PaGlobal_DeleteMaxEnchanterName._ui.list2_Item:GetContentByKey(toInt64(0, index))
  if nil == itemWrapper or nil == control then
    return
  end
  local itemSlot = UI.getChildControl(control, "Static_ItemSlotBg")
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), itemSlot, true, false)
end
function HandleEventOn_PaGlobal_DeleteMaxEnchanterName_RemoveItemTooltipHide()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_DeleteMaxEnchanterName._fromInventoryType, PaGlobal_DeleteMaxEnchanterName._fromInventorySlotNo)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper:getStaticStatus(), PaGlobal_DeleteMaxEnchanterName._ui.stc_RemoveItemSlot, true, false)
end
function HandleEventOn_PaGlobal_DeleteMaxEnchanterName_TooltipHide()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventLUp_PaGlobal_DeleteMaxEnchanterName_Select(index)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:selectItem(index)
end
function PaGlobal_DeleteMaxEnchanterName_CreateListControl(control, key)
  PaGlobal_DeleteMaxEnchanterName:createList(control, key)
end
function PaGlobal_DeleteMaxEnchanterName_UpdateProcess(deltaTime)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:effect(deltaTime)
end
function FromClient_DeleteEnchanterName_Show(fromWhereType, fromSlotNo)
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:prepareOpen(fromWhereType, fromSlotNo)
  InventoryWindow_Close()
end
function FromClient_FinishDeleteEnchanterName()
  if nil == Panel_DeleteMaxEnchanterName then
    return
  end
  PaGlobal_DeleteMaxEnchanterName:prepareInitialize()
  PaGlobal_DeleteMaxEnchanterName:update()
end
