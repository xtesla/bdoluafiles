function PaGlobalFunc_IngameCashShopMoonBlessing_All_Open()
  PaGlobal_IngameCashShopMoonBlessing_All:prepareOpen()
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
  PaGlobal_IngameCashShopMoonBlessing_All:prepareClose()
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_GetShow()
  if nil == Panel_IngameCashShop_MoonBlessing_All then
    return false
  end
  return Panel_IngameCashShop_MoonBlessing_All:GetShow()
end
function HandleEventLUp_IngameCashShopMoonBlessing_All_Close()
  PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
end
function HandleEventLUp_IngameCashShopMoonBlessing_All_Open()
  PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All._mileageDefaultKey)
  PaGlobal_IngameCashShopMoonBlessing_All:prepareOpen()
end
function HandleEvent_IngameCashShopMoonBlessing_All_ShowToolTip(contentIndex, slotIndex, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_IngameCashShop_MoonBlessing_All then
    return
  end
  local self = PaGlobal_IngameCashShopMoonBlessing_All
  local uiSlot = self._mileageSlots[self._nowMileageInfoKey][contentIndex][slotIndex]
  local slotIcon = uiSlot.icon
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(uiSlot._item))
  local name = itemStatic:getName()
  local desc = itemStatic:getDescription()
  if true == isShow then
    TooltipSimple_Show(slotIcon, name, desc)
  end
end
function HandleEvent_IngameCashShopMoonBlessing_All_ApplyReward(itemKey)
  if PaGlobal_IngameCashShopMoonBlessing_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_All:dayChange()
    return
  end
  if nil == PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey] then
    return
  end
  if PaGlobal_IngameCashShopMoonBlessing_All.CHALLENGE_STEP.REWARDED ~= PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey].nowStep then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All._nowConfirmKey = itemKey
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_MILEAGE_CONFIRM_MESSAGE")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_IngameCashShopMoonBlessing_All_ConfirmReward,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_ConfirmReward()
  local itemKey = PaGlobal_IngameCashShopMoonBlessing_All._nowConfirmKey
  if nil == PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey] then
    return
  end
  if PaGlobal_IngameCashShopMoonBlessing_All.CHALLENGE_STEP.REWARDED ~= PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey].nowStep then
    return
  end
  if true == _ContentsGroup_ChallengeReward then
    ToClient_requestChallengeReward(PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey]:getKey(), 0, 1)
  else
    ToClient_AcceptReward_ButtonClicked(PaGlobal_IngameCashShopMoonBlessing_All._mileageInfo[itemKey]:getKey(), 0)
  end
end
function HandleEvent_IngameCashShopMoonBlessing_All_MoveTab(moveDir)
  if nil == Panel_IngameCashShop_MoonBlessing_All or false == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All:moveTab(moveDir)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_OnResize()
  if nil == Panel_IngameCashShop_MoonBlessing_All then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All:resize()
end
function FromClient_IngameCashShopMoonBlessing_All_InventoryUpdate()
  PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_All._nowObtainedPearl ~= ToClient_GetCurrentPearlObtainedTotal() then
    PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All.MILEAGE_TYPE.CHARGED)
  elseif PaGlobal_IngameCashShopMoonBlessing_All._nowUsedPearl ~= ToClient_GetCurrentPearlUsedTotal() then
    PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All.MILEAGE_TYPE.CONSUMED)
  end
end
function FromClient_IngameCashShopMoonBlessing_All_NotifyCompleteBuyProduct()
  PaGlobal_IngameCashShopMoonBlessing_All._showPearlPrice = -1
  PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_All._nowUsedPearl ~= ToClient_GetCurrentPearlUsedTotal() then
    if PaGlobal_IngameCashShopMoonBlessing_All.MILEAGE_TYPE.CONSUMED == PaGlobal_IngameCashShopMoonBlessing_All._nowMileageInfoKey then
      PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All._nowMileageInfoKey, PaGlobal_IngameCashShopMoonBlessing_All._nowTabInfoKey)
    else
      PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All.MILEAGE_TYPE.CONSUMED)
    end
  else
    return
  end
  if true == PaGlobalFunc_IngameCashShopMoonBlessing_All_GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
  end
end
function FromClient_IngameCashShopMoonBlessing_All_UpdatePearlMileage()
  PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  if PaGlobal_IngameCashShopMoonBlessing_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_All:dayChange()
  end
end
function FromClient_IngameCashShopMoonBlessing_All_SelectRandomItem()
  PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
end
function FromClient_IngameCashShopMoonBlessing_All_ChallengeReward_UpdateText()
  PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All._nowMileageInfoKey, PaGlobal_IngameCashShopMoonBlessing_All._nowTabInfoKey)
end
function FromClient_IngameCashShopMoonBlessing_All_AttendanceTimer()
  if PaGlobal_IngameCashShopMoonBlessing_All._nowDay ~= ToClient_GetToday() then
    PaGlobal_IngameCashShopMoonBlessing_All._nowDay = ToClient_GetToday()
    PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
    PaGlobal_IngameCashShopMoonBlessing_All:dayChange()
  end
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_Update(mileageType)
  if nil == mileageType then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All:update(mileageType)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_Type_Update(tabIndex)
  if nil == tabIndex then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All:update(PaGlobal_IngameCashShopMoonBlessing_All._nowMileageInfoKey, tabIndex)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_ListCreate(content, key)
  if nil == Panel_IngameCashShop_MoonBlessing_All then
    return
  end
  PaGlobal_IngameCashShopMoonBlessing_All:listCreate(content, key)
end
function PaGlobal_CashMileage_IsOpenCheck()
  local self = PaGlobal_IngameCashShopMoonBlessing_All
  if false == _ContentsGroup_PearlShopMoonBlessingUIOnOff then
    return false
  end
  if true == _ContentsGroup_PearlShopMileage then
    local tempCnt = 0
    tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetProgressPearlObtainedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlObtainedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetProgressPearlObtainedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlObtainedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetRewardedPearlObtainedCount(self.CHALLENGE_TYPE.DAILY)
    tempCnt = tempCnt + ToClient_GetProgressPearlObtainedCount(self.CHALLENGE_TYPE.DAILY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlObtainedCount(self.CHALLENGE_TYPE.DAILY)
    tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetProgressPearlUsedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlUsedCount(self.CHALLENGE_TYPE.MONTHLY)
    tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetProgressPearlUsedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlUsedCount(self.CHALLENGE_TYPE.WEEKLY)
    tempCnt = tempCnt + ToClient_GetRewardedPearlUsedCount(self.CHALLENGE_TYPE.DAILY)
    tempCnt = tempCnt + ToClient_GetProgressPearlUsedCount(self.CHALLENGE_TYPE.DAILY)
    tempCnt = tempCnt + ToClient_GetCompletedPearlUsedCount(self.CHALLENGE_TYPE.DAILY)
    if tempCnt > 0 then
      return true
    end
  end
  return false
end
function PaGlobal_CashMileage_ChangeConsumePearl(pearlValue)
  if false == PaGlobal_IngameCashShopMoonBlessing_All._isConsole then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_OnResize()
  end
  local self = PaGlobal_IngameCashShopMoonBlessing_All
  self._showPearlPrice = Int64toInt32(pearlValue)
  if self.MILEAGE_TYPE.CONSUMED == self._nowMileageInfoKey then
    PaGlobal_IngameCashShopMoonBlessing_All:update(self._nowMileageInfoKey, self._nowTabInfoKey)
  else
    PaGlobal_IngameCashShopMoonBlessing_All:update(self.MILEAGE_TYPE.CONSUMED)
  end
  if false == PaGlobalFunc_IngameCashShopMoonBlessing_All_GetShow() then
    PaGlobal_IngameCashShopMoonBlessing_All:prepareOpen()
  end
  local moveKey = self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED]:getIndexByKey(toInt64(0, self._nowProgressKeyGroup[self.MILEAGE_TYPE.CONSUMED]))
  self._ui._list2_mileage[self.MILEAGE_TYPE.CONSUMED]:moveIndex(moveKey)
end
function PaGlobalFunc_IngameCashShopMoonBlessing_All_CheckMileageRewarded()
  local totalCnt = 0
  if false == _ContentsGroup_NewUI_MoonBlessing_All then
    return totalCnt
  end
  if Defines.UIMode.eUIMode_ItemMarket == GetUIMode() then
    return totalCnt
  end
  totalCnt = PaGlobal_IngameCashShopMoonBlessing_All:checkMileageRewarded()
  return totalCnt
end
function HandleEventLUp_RequestPearlUsedReset()
  local self = PaGlobal_IngameCashShopMoonBlessing_All
  ToClient_ResetPearlUsedChallenge(self._currentTabGroupChallengeKey)
end
function FromClient_PearlUsedResetSuccessNotify()
  PaGlobalFunc_IngameCashShopMoonBlessing_All_Update(PaGlobal_IngameCashShopMoonBlessing_All.MILEAGE_TYPE.CONSUMED)
  PaGlobalFunc_IngameCashShopMoonBlessing_All_Open()
end
