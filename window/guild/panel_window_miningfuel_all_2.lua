function HandleEventRUp_MiningFuel_All_SetInvenRclick(slotNo, itemWrapper, count_s64, inventoryType)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  local doInsertFuel = function(count_s64, slotNo)
    ToClient_requestGuildDrillInsertFuel(PaGlobal_MiningFuel_All._actorKeyRaw, slotNo, count_s64)
  end
  if count_s64 > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count_s64, slotNo, doInsertFuel)
  else
    ToClient_requestGuildDrillInsertFuel(PaGlobal_MiningFuel_All._actorKeyRaw, slotNo, count_s64)
  end
end
function HandleEventLUp_MiningFuel_All_GetReward()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  ToClient_requestReceiveGuildDrillReward(PaGlobal_MiningFuel_All._actorKeyRaw)
end
function HandleEventLUp_MiningFuel_All_ItemToolTip(isShow, itemEnchantKey, index)
  if nil == isShow or nil == itemEnchantKey or nil == index then
    return
  end
  if true == isShow then
    local uiControl = PaGlobal_MiningFuel_All._fuelSlot[index].icon
    local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
    if nil == itemEnchantSSW then
      return
    end
    Panel_Tooltip_Item_Show(itemEnchantSSW, uiControl, true)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_MiningFuel_All_Open(actorKeyRaw)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All:prepareOpen(actorKeyRaw)
end
function PaGlobal_MiningFuel_All_Close()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All:prepareClose()
end
function PaGlobal_MiningFuel_All_LoadGuildDrillInfo(actorKeyRaw)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  if true == Panel_Guild_MiningFuel_All:GetShow() then
    return
  end
  ToClient_loadGuildDrilFuelList(actorKeyRaw)
end
function PaGlobal_MiningFuel_All_SetInvenFilter(slotNo, itemWrapper)
  local actorProxyWrapper = getActor(PaGlobal_MiningFuel_All._actorKeyRaw)
  if nil == actorProxyWrapper then
    return false
  end
  if nil == itemWrapper then
    return false
  end
  local isFilter = not ToClient_isFuel(actorProxyWrapper:getCharacterKeyRaw(), itemWrapper:get():getKey())
  return isFilter
end
function PaGlobal_MiningFuel_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All:updatePerFrame(deltaTime)
end
function FromClient_MiningFuel_All_Open(actorKeyRaw)
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All_Open(actorKeyRaw)
end
function FromClient_MiningFuel_All_FuelUpdate()
  if nil == Panel_Guild_MiningFuel_All then
    return
  end
  PaGlobal_MiningFuel_All:fuelUpdate()
end
