function PaGlobalFunc_Window_HotDeal_All_Open()
  PaGlobal_Window_HotDeal_All:prepareOpen()
end
function PaGlobalFunc_Window_HotDeal_All_Close()
  PaGlobal_Window_HotDeal_All:prepareClose()
end
function PaGlobalFunc_Window_HotDeal_All_GetShow()
  if nil == Panel_Window_HotDeal_All then
    return false
  end
  return Panel_Window_HotDeal_All:GetShow()
end
function HandleEventOnOut_Window_HotDeal_All_MainItemShowToolTip(isShow)
  if nil == FGlobal_CashShop_GoodsTooltipInfo_Open or nil == FGlobal_CashShop_GoodsTooltipInfo_Close then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    FGlobal_CashShop_GoodsTooltipInfo_Close()
    return
  end
  local ingameCashMall = getIngameCashMall()
  if nil == ingameCashMall then
    return
  end
  local cashProduct = ingameCashMall:getCashProductStaticStatusByProductNoRaw(PaGlobal_Window_HotDeal_All._productNoRaw)
  if nil == cashProduct then
    return
  end
  if nil == PaGlobal_Window_HotDeal_All._mainItemSlot or nil == PaGlobal_Window_HotDeal_All._mainItemSlot.icon then
    return
  end
  FGlobal_CashShop_GoodsTooltipInfo_Open(PaGlobal_Window_HotDeal_All._productNoRaw, PaGlobal_Window_HotDeal_All._mainItemSlot.icon, false)
end
function HandleEventOnOut_Window_HotDeal_All_SubItemShowToolTip(isShow, slotIndex, itemKey)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    FGlobal_CashShop_GoodsTooltipInfo_Close()
    return
  end
  if nil == Panel_Window_HotDeal_All then
    return
  end
  if nil == slotIndex then
    return
  end
  local slot = PaGlobal_Window_HotDeal_All._subItems[slotIndex]
  if nil == slot or nil == slot.icon then
    return
  end
  local slotControl = slot.icon
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, slotControl, true, false, nil)
end
function HandleEventLUp_Window_HotDeal_All_BuyItem()
  PaGlobal_Window_HotDeal_All:buyConfirm()
end
function PaGlobal_Window_HotDeal_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_HotDeal_All then
    return
  end
  if nil == PaGlobal_Window_HotDeal_All._salesEndTime then
    return
  end
  if PaGlobal_Window_HotDeal_All._maxEffectTime <= PaGlobal_Window_HotDeal_All._curEffectTime then
    PaGlobal_Window_HotDeal_All._isTimeTextRedColor = true
  else
    PaGlobal_Window_HotDeal_All._curEffectTime = PaGlobal_Window_HotDeal_All._curEffectTime + deltaTime
  end
  PaGlobal_Window_HotDeal_All._curUpdateTime = PaGlobal_Window_HotDeal_All._curUpdateTime + deltaTime
  if PaGlobal_Window_HotDeal_All._curUpdateTime < PaGlobal_Window_HotDeal_All._maxUpdateTime then
    return
  end
  PaGlobal_Window_HotDeal_All._curUpdateTime = 0
  local limitedSalesProductCount = ToClient_getLimitedSalesProductCount()
  if limitedSalesProductCount <= 0 then
    PaGlobalFunc_Window_HotDeal_All_Close()
  end
  local reminedTime = PaGlobal_Window_HotDeal_All:updateReminedTime()
  if reminedTime <= 0 then
    PaGlobalFunc_Window_HotDeal_All_Close()
  end
end
function PaGlobal_Window_HotDeal_All_ShowAni()
  Panel_Window_HotDeal_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_HotDeal_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_HotDeal_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_HotDeal_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_HotDeal_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_HotDeal_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_HotDeal_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobal_Window_HotDeal_All_HideAni()
  Panel_Window_HotDeal_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_HotDeal_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_Window_HotDeal_All_SetShowHotDeal(isShow)
  if nil == isShow or false == isShow then
    if true == PaGlobalFunc_Window_HotDeal_All_GetShow() then
      PaGlobal_Window_HotDeal_All:prepareClose()
    end
  elseif false == PaGlobalFunc_Window_HotDeal_All_GetShow() then
    PaGlobal_Window_HotDeal_All:prepareOpen()
  end
end
function FromClient_Window_HotDeal_All_Update()
  if false == PaGlobalFunc_Window_HotDeal_All_GetShow() then
    return
  end
  PaGlobal_Window_HotDeal_All:prepareOpen()
end
function FromClient_Window_HotDeal_All_OnResize()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  PaGlobal_Window_HotDeal_All:resize()
end
