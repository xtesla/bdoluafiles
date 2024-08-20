function PaGlobal_ItemMoveSet_BasicItemFilter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  if nil == itemWrapper:getStaticStatus() then
    return true
  end
  if false == itemWrapper:getStaticStatus():isStackable() then
    return true
  end
  if true == itemWrapper:get():isVested() and false == itemWrapper:getStaticStatus():isUserVested() then
    return true
  end
  return false
end
function FromClient_ItemMoveSet_WarehouseUpdate()
  if nil == Panel_Window_Warehouse or false == Panel_Window_Warehouse:GetShow() then
    return
  end
  local self = PaGlobal_ItemMoveSet
  if 0 == self._fromItemCount then
    return
  end
  self._toItemCount = self._toItemCount + 1
  if self._toItemCount == self._fromItemCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_COMPLETE_WAREHOUSE"))
    self._fromItemCount = 0
    self._toItemCount = 0
  end
end
