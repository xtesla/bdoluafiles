function FromClient_WorldMapBarterInfo(panel, regionKey, existNormal, existSpecial)
  if nil == panel then
    return
  end
  local self = PaGlobal_WorldMapBarterInfo
  if true == existNormal and true == existSpecial then
    self:showAllBg(panel, regionKey)
  elseif true == existNormal and false == existSpecial then
    self:showNormalBg(panel, regionKey)
  else
    if false == existNormal and true == existSpecial then
      self:showSpecialBg(panel, regionKey)
    else
    end
  end
end
function PaGlobalFunc_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionKey = ToClient_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionWrapper = getRegionInfoWrapper(regionKey:get())
  if nil == regionWrapper then
    PaGlobalFunc_FindBarterItemByMarket(itemEnchantKeyRaw)
    return
  end
  ToCleint_gotoWorldmapPosition(regionWrapper:getPosition())
end
function PaGlobalFunc_FindBarterItemByMarket(itemEnchantKeyRaw)
  if false == _ContentsGroup_RenewBarter then
    return
  end
  local canRegister = ToClient_RequestBarterItemByTrade(itemEnchantKeyRaw)
  if true == canRegister then
    if true == PaGlobalFunc_MarketPlace_GetShow() then
      PaGlobalFunc_MarketPlace_Close()
    end
    PaGlobalFunc_ItemMarket_OpenbyBarter(itemEnchantKeyRaw)
  end
end
