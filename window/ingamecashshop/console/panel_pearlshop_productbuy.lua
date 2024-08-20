local pearlShopProductBuy = {
  _init = false,
  _panel = Panel_PearlShop_ProductBuy,
  _productNoRaw = 0,
  _amount = 1,
  _ui = {
    TopBg = nil,
    BtmBg = nil,
    _mainBG = nil,
    _moneyBG = nil,
    _titleControl = nil,
    _descControl = nil,
    _subItemSlotTemplateControl = nil,
    _itemSlotBgControl = nil,
    _amountControl = nil,
    _pearlControl = nil,
    _mileageControl = nil,
    _silverControl = nil,
    _pearlOriginControl = nil,
    _mileageOriginControl = nil,
    _rdoMoneyByMe = nil,
    _rdoMoneyByWareHouse = nil,
    _txtSilverInInven = nil,
    _txtSilverInWarehouse = nil,
    _subItemSlotControlListSize = 16,
    _subItemSlotControlListCountPerLine = 8,
    _subItemSlotControlList = {},
    _bottomControl = nil
  },
  _titleSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _subSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _slotGapX = 7,
  _mainSlot = nil,
  _slotList = {},
  _keyGuideAlign = {},
  _selectedCouponIdx = nil,
  _isAvailableCoupon = false,
  _isPayInSilverWarehouse = false,
  _price = 0,
  _isOpenMoonBlessing = false
}
local territoryKeyToWaypointKey = {
  [0] = 1,
  [1] = 301,
  [2] = 601,
  [3] = 1101,
  [4] = 1301,
  [6] = 1623,
  [5] = 1395,
  [7] = 1649,
  [8] = 1691
}
function pearlShopProductBuy:initialize()
  if self._init then
    return
  end
  self._init = true
  self._ui.TopBg = UI.getChildControl(self._panel, "Static_TopBg")
  self._ui.BtmBg = UI.getChildControl(self._panel, "Static_BtmBg")
  local mainBgControl = UI.getChildControl(self._panel, "Static_MainBG")
  self._ui._titleControl = UI.getChildControl(mainBgControl, "StaticText_ProductName")
  self._ui._descControl = UI.getChildControl(mainBgControl, "StaticText_ProductDesc")
  self._ui._descControl:SetTextMode(__eTextMode_AutoWrap)
  self._ui.line3 = UI.getChildControl(mainBgControl, "Static_HorizontalLine3")
  self._ui.line4 = UI.getChildControl(mainBgControl, "Static_HorizontalLine4")
  self._ui.line5 = UI.getChildControl(mainBgControl, "Static_HorizontalLine5")
  self._ui._itemSlotBgControl = UI.getChildControl(mainBgControl, "Static_MainItemSlotBg")
  self._ui._mainBG = mainBgControl
  self._ui._moneyBG = UI.getChildControl(self._panel, "Static_MoneyBG")
  local slot = {}
  SlotItem.new(slot, "MainSlot", 0, self._ui._itemSlotBgControl, self._titleSlotConfig)
  slot:createChild()
  self._mainSlot = slot
  self._ui._subItemSlotTemplateControl = UI.getChildControl(mainBgControl, "Static_SubItemSlotBg")
  self._ui._subItemSlotTemplateControl:SetShow(false)
  for i = 0, self._ui._subItemSlotControlListSize - 1 do
    local subItemSlotControl = UI.cloneControl(self._ui._subItemSlotTemplateControl, self._panel, "Static_SubItemSlot" .. i)
    self._ui._subItemSlotControlList[i] = subItemSlotControl
    local slot = {}
    SlotItem.new(slot, "Slot" .. i, i, subItemSlotControl, self._subSlotConfig)
    slot:createChild()
    self._slotList[i] = slot
  end
  self._ui._leftButtonControl = UI.getChildControl(mainBgControl, "Static_Left")
  self._ui._rightButtonControl = UI.getChildControl(mainBgControl, "Static_Right")
  self._ui._couponControl = UI.getChildControl(mainBgControl, "StaticText_Coupon")
  self._ui._couponControl:SetTextMode(__eTextMode_LimitText)
  self._ui._amountControl = UI.getChildControl(mainBgControl, "StaticText_Count")
  self._ui._pearlControl = UI.getChildControl(mainBgControl, "StaticText_Pearl")
  self._ui._mileageControl = UI.getChildControl(mainBgControl, "StaticText_Mileage")
  self._ui._silverControl = UI.getChildControl(mainBgControl, "StaticText_Silver")
  self._ui._pearlOriginControl = UI.getChildControl(mainBgControl, "StaticText_PearlOrigin")
  self._ui._mileageOriginControl = UI.getChildControl(mainBgControl, "StaticText_MileageOrigin")
  self._ui._pearlOriginControl:SetLineRender(true)
  self._ui._mileageOriginControl:SetLineRender(true)
  self._ui._rdoMoneyByMe = UI.getChildControl(self._ui._moneyBG, "RadioButton_Me")
  self._ui._rdoMoneyByWareHouse = UI.getChildControl(self._ui._moneyBG, "RadioButton_All")
  self._ui._txtSilverInInven = UI.getChildControl(self._ui._rdoMoneyByMe, "StaticText_SilverInInven")
  self._ui._txtSilverInWarehouse = UI.getChildControl(self._ui._rdoMoneyByWareHouse, "StaticText_SilverInStorage")
  self._ui._rdoMoneyByMe:SetCheck(false == self._isPayInSilverWarehouse)
  self._ui._rdoMoneyByWareHouse:SetCheck(self._isPayInSilverWarehouse)
  self._ui._rdoMoneyByMe:addInputEvent("Mouse_On", "HandleEventOn_PearlShop_SilverPay(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui._rdoMoneyByWareHouse:addInputEvent("Mouse_On", "HandleEventOn_PearlShop_SilverPay(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
  self._ui._couponTitle = UI.getChildControl(mainBgControl, "StaticText_CouponTitle")
  self._ui._countTitle = UI.getChildControl(mainBgControl, "StaticText_CountTitle")
  self._ui._priceTitle = UI.getChildControl(mainBgControl, "StaticText_PriceTitle")
  self._ui._txt_CouponBG = UI.getChildControl(self._ui._couponControl, "StaticText_SelectCoupon")
  self._ui._list2_Coupon = UI.getChildControl(self._ui._txt_CouponBG, "List2_Coupon")
  self._ui._list2_Coupon:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PearlShopProductBuy_CreateCouponList")
  self._ui._list2_Coupon:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._bottomControl = UI.getChildControl(self._panel, "Static_BottomSite")
  self._ui._bottomKeyGuideA = UI.getChildControl(self._ui._bottomControl, "StaticText_Confirm_ConsoleUI")
  self._ui._bottomKeyGuideB = UI.getChildControl(self._ui._bottomControl, "StaticText_XboxClose_ConsoleUI")
  self._ui._bottomKeyGuideY = UI.getChildControl(self._ui._bottomControl, "StaticText_Coupon_ConsoleUI")
  self._keyGuideAlign = {
    self._ui._bottomKeyGuideY,
    self._ui._bottomKeyGuideA,
    self._ui._bottomKeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._keyGuideAlign, self._ui._bottomControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui._bottomKeyGuideY:SetShow(false)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_PearlShopProductBuyDown()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_PearlShopProductBuyUp()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PearlShopProductBuyBuy()")
  self._panel:ignorePadSnapMoveToOtherPanel()
end
function PaGlobalFunc_PearlShopProductBuyCheckShow()
  return pearlShopProductBuy:checkShow()
end
function pearlShopProductBuy:checkShow()
  return self._panel:GetShow()
end
function PaGlobalFunc_PearlShopProductBuyBack()
  pearlShopProductBuy:back()
end
function pearlShopProductBuy:back()
  self:close()
end
function PaGlobalFunc_PearlShopProductBuyUp()
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  pearlShopProductBuy:changeAmount(1)
end
function PaGlobalFunc_PearlShopProductBuyDown()
  _AudioPostEvent_SystemUiForXBOX(51, 4)
  pearlShopProductBuy:changeAmount(-1)
end
function pearlShopProductBuy:cashProductMaxCountByPrice(cashProduct)
  if nil == cashProduct then
    return Defines.s64_const.s64_0
  end
  local priceType = cashProduct:getProductPriceType()
  local currentMoney = Defines.s64_const.s64_0
  if __ePriceType_Cash == priceType then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local selfProxy = selfPlayer:get()
      if nil ~= selfProxy then
        currentMoney = selfProxy:getCash()
      end
    end
  elseif __ePriceType_Pearl == priceType then
    local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
    if nil ~= pearlItemWrapper then
      currentMoney = pearlItemWrapper:get():getCount_s64()
    end
  elseif __ePriceType_Sliver == priceType then
    if true == self._ui._rdoMoneyByMe:IsCheck() then
      local selfPlayer = getSelfPlayer()
      if nil ~= selfPlayer then
        local selfProxy = selfPlayer:get()
        if nil ~= selfProxy then
          currentMoney = selfProxy:getInventory():getMoney_s64()
        end
      end
    else
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
      local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
      local warehouseWrapper = warehouse_get(waypointKey)
      if nil ~= warehouseWrapper then
        currentMoney = warehouseWrapper:getMoney_s64()
      end
    end
  elseif __ePriceType_Mileage == priceType then
    local mileageItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
    if nil ~= mileageItemWrapper then
      currentMoney = mileageItemWrapper:get():getCount_s64()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MATHCLASS"))
    return Defines.s64_const.s64_0
  end
  if Defines.s64_const.s64_0 == currentMoney then
    return Defines.s64_const.s64_0
  end
  local price = cashProduct:getPrice()
  if Defines.s64_const.s64_0 == price then
    return Defines.s64_const.s64_0
  end
  local maxCountPerPrice = currentMoney / price
  return maxCountPerPrice
end
function pearlShopProductBuy:changeAmount(diff)
  local amount = self._amount + diff
  if amount <= 0 then
    return
  end
  local productInfo = self:getProductInfo()
  if nil == productInfo then
    return
  end
  if diff > 0 then
    if false == getIngameCashMall():checkCashItemBuyMaxCount(self._productNoRaw, toInt64(0, amount)) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_OVER20"))
      return
    end
    local maxBuyCount = self:cashProductMaxCountByPrice(productInfo)
    local limitCount = productInfo:getCashPurchaseCount()
    if limitCount > 0 then
      local mylimitCount = getIngameCashMall():getRemainingLimitCount(self._productNoRaw)
      if mylimitCount <= self._amount then
        return
      end
      if maxBuyCount > toInt64(0, mylimitCount) then
        maxBuyCount = toInt64(0, mylimitCount)
      end
    end
    if amount <= Int64toInt32(maxBuyCount) then
      self._amount = amount
    end
  else
    self._amount = amount
  end
  if nil ~= self._selectedCouponIdx then
    self._selectedCouponIdx = nil
  end
  self:update()
end
function pearlShopProductBuy:open(productInfo)
  if not productInfo then
    return
  end
  self._productNoRaw = productInfo:getNoRaw()
  self._amount = 1
  self._selectedCouponIdx = nil
  self:update()
  _AudioPostEvent_SystemUiForXBOX(8, 14)
  self._panel:SetShow(true)
  if true == _ContentsGroup_NewUI_MoonBlessing_All and true == _ContentsGroup_PearlShopMileage then
    if true == self._isOpenMoonBlessing then
      PaGlobalFunc_IngameCashShopMoonBlessing_All_OnResize()
    else
      HandleEventLUp_IngameCashShopMoonBlessing_All_Close()
    end
    ToClient_padSnapSetTargetPanel(self._panel)
  end
end
function pearlShopProductBuy:getProductInfo()
  if self._productNoRaw then
    return getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  end
end
function PaGlobalFunc_PearlShopProductBuyOpen(productInfo)
  pearlShopProductBuy:open(productInfo)
end
function PaGlobalFunc_PearlShopProductBuyBuy()
  local self = pearlShopProductBuy
  local function SnapReturn()
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  if false == self._ui._txt_CouponBG:GetShow() then
    if true == self._isAvailableCoupon and nil == self._selectedCouponIdx then
      local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_ALERTCOUPON")
      local messageBoxData = {
        title = messageBoxtitle,
        content = messageBoxMemo,
        functionYes = PaGlobalFunc_PearlShopProductBuyYes,
        functionNo = SnapReturn,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, "middle")
      return
    else
      self:buy()
    end
  end
end
function PaGlobalFunc_PearlShopProductBuyYes()
  pearlShopProductBuy:buy()
end
function PaGlobalFunc_PearlShop_OpenStore()
  if true == isGameServiceTypeConsole() then
    if true == ToClient_isPS4() then
      ToClient_openPS4Store()
    else
      ToClient_XboxShowStore()
    end
  end
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:checkHavePearl(cashProduct)
  local function SnapReturn()
    ToClient_padSnapSetTargetPanel(self._panel)
  end
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  local pearl = Defines.s64_const.s64_0
  if nil ~= pearlItemWrapper then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  local price = self._price
  if pearl >= price then
    return true
  end
  local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_TITLE")
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_DESC")
  local messageBoxData = {
    title = messageBoxtitle,
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_PearlShop_OpenStore,
    functionNo = SnapReturn,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return false
end
function pearlShopProductBuy:buy()
  local productInfo = self:getProductInfo()
  if not productInfo then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local couponKey = 0
  local couponNo = toInt64(0, -1)
  if nil ~= self._selectedCouponIdx then
    local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
    if nil ~= couponWrapper then
      couponKey = couponWrapper:getCouponKey()
      couponNo = couponWrapper:getCouponNo()
    end
  end
  if __ePriceType_Pearl == productInfo:getProductPriceType() and false == self:checkHavePearl(cashProduct) then
    return
  end
  local haveMileage, haveCash = InGameShop_UpdateCash()
  local haveMoney = toInt64(0, 0)
  local wareType = CppEnums.ItemWhereType.eInventory
  local count = self._ui._amountControl:GetText()
  local isEnoughMoney = false
  if __ePriceType_Pearl == productInfo:getProductPriceType() then
    isEnoughMoney = haveCash >= cashProduct:getPrice() * toInt64(0, count)
  elseif __ePriceType_Mileage == productInfo:getProductPriceType() then
    isEnoughMoney = haveMileage >= cashProduct:getPrice() * toInt64(0, count)
  elseif __ePriceType_Sliver == productInfo:getProductPriceType() then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
    local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
    local warehouseWrapper = warehouse_get(waypointKey)
    local silverInInventory = getSelfPlayer():get():getInventory():getMoney_s64()
    local silverInWarehouse = toInt64(0, 0)
    if nil ~= warehouseWrapper then
      silverInWarehouse = warehouseWrapper:getMoney_s64()
    end
    if true == self._ui._rdoMoneyByMe:IsCheck() then
      haveMoney = silverInInventory
    else
      haveMoney = silverInWarehouse
      wareType = CppEnums.ItemWhereType.eWarehouse
    end
    isEnoughMoney = haveMoney >= cashProduct:getPrice() * toInt64(0, count)
  else
    isEnoughMoney = true
  end
  if isEnoughMoney then
    _AudioPostEvent_SystemUiForXBOX(16, 0)
  else
    _AudioPostEvent_SystemUiForXBOX(16, 1)
  end
  self:close()
  ToClient_requestBuyItem(productInfo:getNoRaw(), count, productInfo:getPrice(), false, couponNo, couponKey, 0, wareType, true)
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:close()
  if true == self._ui._txt_CouponBG:GetShow() then
    self:couponListClsoe()
    return
  end
  if true == _ContentsGroup_PearlShopMileage and true == _ContentsGroup_NewUI_MoonBlessing_All and true == self._panel:GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
  end
  self._price = 0
  self._isOpenMoonBlessing = false
  PaGlobalFunc_PearlShopSetBKeyGuide()
  self._panel:SetShow(false)
end
function PaGlobalFunc_PearlShopProductBuyClose()
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  pearlShopProductBuy:close()
end
function pearlShopProductBuy:addItemSlotControlList(count)
  for i = self._ui._subItemSlotControlListSize, count do
    local subItemSlotControl = UI.cloneControl(self._ui._subItemSlotTemplateControl, self._panel, "Static_SubItemSlot" .. i)
    self._ui._subItemSlotControlList[i] = subItemSlotControl
    local slot = {}
    SlotItem.new(slot, "Slot" .. i, i, subItemSlotControl, self._subSlotConfig)
    slot:createChild()
    self._slotList[i] = slot
  end
  self._ui._subItemSlotControlListSize = count
end
function pearlShopProductBuy:update(applyCoupon)
  local productInfo = self:getProductInfo()
  if not productInfo then
    return
  end
  self._isAvailableCoupon = false
  if nil ~= productInfo:getItemByIndex(0) then
    self._mainSlot:setItemByStaticStatus(productInfo:getItemByIndex(0))
    self._mainSlot.icon:SetShow(true)
  else
    self._mainSlot.icon:SetShow(false)
  end
  self._ui._titleControl:SetTextMode(__eTextMode_AutoWrap)
  self._ui._titleControl:SetText(productInfo:getDisplayName())
  local itemListCount = productInfo:getItemListCount()
  local additionalSubItemCount = productInfo:getSubItemListCount()
  local totalItemListCount = itemListCount + additionalSubItemCount
  local firstPosX = 50
  if totalItemListCount > self._ui._subItemSlotControlListSize then
    self:addItemSlotControlList(totalItemListCount)
  end
  local desc = ""
  for i = 0, self._ui._subItemSlotControlListSize - 1 do
    local control = self._ui._subItemSlotControlList[i]
    control:SetPosX(firstPosX + (self._ui._subItemSlotTemplateControl:GetSizeX() + 10) * (i % self._ui._subItemSlotControlListCountPerLine))
    control:SetPosY(255 + math.floor(i / self._ui._subItemSlotControlListCountPerLine) * 54)
    local showFlag = i < itemListCount
    control:SetShow(showFlag)
    if showFlag then
      local itemInfo = productInfo:getItemByIndex(i)
      local itemCount = productInfo:getItemCountByIndex(i)
      if nil ~= itemInfo then
        self._slotList[i]:setItemByStaticStatus(itemInfo, itemCount)
        if 1 < Int64toInt32(itemCount) then
          desc = desc .. "-" .. " " .. itemInfo:getName() .. " x" .. Int64toInt32(itemCount) .. "\n"
        else
          desc = desc .. "-" .. " " .. itemInfo:getName() .. "\n"
        end
      end
    end
  end
  for i = 0, additionalSubItemCount - 1 do
    local control = self._ui._subItemSlotControlList[i + itemListCount]
    local subItemInfo = productInfo:getSubItemByIndex(i)
    local subItemCount = productInfo:getSubItemCountByIndex(i)
    if nil ~= subItemInfo then
      self._slotList[i + itemListCount]:setItemByStaticStatus(subItemInfo, subItemCount)
      control:SetShow(true)
      if 1 < Int64toInt32(subItemCount) then
        desc = desc .. "-" .. " " .. subItemInfo:getName() .. " x" .. Int64toInt32(subItemCount) .. "\n"
      else
        desc = desc .. "-" .. " " .. subItemInfo:getName() .. "\n"
      end
    end
  end
  if true == productInfo:isChooseCash() then
    local checklist
    if nil ~= PaGlobalFunc_PearlShopGetChooseProductList then
      checklist = PaGlobalFunc_PearlShopGetChooseProductList()
    end
    if nil ~= checklist then
      local validChooseCashProduct = productInfo:chooseCashCount()
      local chooseCount = 0
      local indexList = {}
      for ll = 0, validChooseCashProduct - 1 do
        if nil ~= checklist[ll] and checklist[ll] > 0 then
          indexList[chooseCount] = {
            [0] = ll,
            [1] = checklist[ll]
          }
          chooseCount = chooseCount + 1
        end
      end
      local prevTotalCount = 0
      for jj = 0, chooseCount - 1 do
        local chooseIndex = indexList[jj][0]
        if nil ~= chooseIndex then
          local chooseCashProduct = productInfo:getChooseCashByIndex(chooseIndex)
          local chooseItemListCount = chooseCashProduct:getItemListCount()
          prevTotalCount = totalItemListCount
          totalItemListCount = totalItemListCount + chooseItemListCount
          if totalItemListCount > self._ui._subItemSlotControlListSize then
            self:addItemSlotControlList(totalItemListCount)
          end
          for ii = 0, chooseItemListCount - 1 do
            local slotNo = prevTotalCount + ii
            local control = self._ui._subItemSlotControlList[slotNo]
            local chooseItemInfo = chooseCashProduct:getItemByIndex(ii)
            local chooseItemCount = chooseCashProduct:getItemCountByIndex(ii)
            if nil ~= chooseItemInfo and nil ~= chooseItemCount then
              chooseItemCount = chooseItemCount * toInt64(0, indexList[jj][1])
              if nil ~= self._slotList[slotNo] and nil ~= control then
                self._slotList[slotNo]:setItemByStaticStatus(chooseItemInfo, chooseItemCount)
                control:SetShow(true)
              end
              if 1 < Int64toInt32(chooseItemCount) then
                desc = desc .. "-" .. " " .. chooseItemInfo:getName() .. " x" .. Int64toInt32(chooseItemCount) .. "\n"
              else
                desc = desc .. "-" .. " " .. chooseItemInfo:getName() .. "\n"
              end
            end
          end
        end
      end
    end
  end
  if true == productInfo:isDisplayCashProductPolicy() then
    local policyDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_RELAUNCH")
    desc = desc .. [[

<PAColor0xFFF26A6A>]] .. policyDesc .. "<PAOldColor>"
  end
  self._ui._descControl:SetText(desc)
  local addSize = self._ui._descControl:GetTextSizeY() + 54 * math.floor(totalItemListCount / self._ui._subItemSlotControlListCountPerLine)
  local addPosY = 54 * math.floor((totalItemListCount - 1) / self._ui._subItemSlotControlListCountPerLine)
  if addSize > 20 then
    self._panel:SetSize(512, 572 + addSize)
    self._ui.TopBg:SetSize(472, 256 + addSize)
    self._ui._descControl:SetSize(390, addSize + 10)
    self._ui._descControl:SetPosY(235 + addPosY)
    self._ui.BtmBg:SetPosY(self._ui.TopBg:GetPosY() + self._ui.TopBg:GetSizeY() + 10)
    self._ui._mainBG:SetSize(502, 400 + addSize)
  else
    self._panel:SetSize(512, 664)
    self._ui._descControl:SetSize(390, 20)
    self._ui._descControl:SetPosY(235 + addPosY)
    self._ui._mainBG:SetSize(502, 450)
    self._ui.BtmBg:ComputePos()
  end
  self._ui._bottomControl:ComputePos()
  self._ui.line5:SetPosY(self._ui.BtmBg:GetPosY() + 20)
  self._ui.line4:SetPosY(self._ui.line5:GetPosY() - 50)
  self._ui.line3:SetPosY(self._ui.line4:GetPosY() + 50)
  self._ui._couponTitle:SetPosY(self._ui.line4:GetPosY() - 30)
  self._ui._couponControl:SetPosY(self._ui.line4:GetPosY() - 35)
  self._ui._leftButtonControl:SetPosY(self._ui.line4:GetPosY() + 18)
  self._ui._rightButtonControl:SetPosY(self._ui.line4:GetPosY() + 18)
  self._ui._amountControl:SetPosY(self._ui.line4:GetPosY() + 10)
  self._ui._countTitle:SetPosY(self._ui.line4:GetPosY() + 12)
  self._ui._pearlControl:SetPosY(self._ui.line3:GetPosY() + 15)
  self._ui._mileageControl:SetPosY(self._ui.line3:GetPosY() + 14)
  self._ui._silverControl:SetPosY(self._ui.line3:GetPosY() + 15)
  self._ui._priceTitle:SetPosY(self._ui.line3:GetPosY() + 14)
  self._ui._amountControl:SetText(tostring(self._amount))
  local usableCouponCount = self:couponListUpdate()
  if usableCouponCount > 0 then
    self._ui._bottomKeyGuideY:SetShow(true)
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PearlShopProductBuy_ShowCouponList()")
    self._ui._couponControl:SetFontColor(Defines.Color.C_FFEEEEEE)
    if nil == self._selectedCouponIdx then
      self._ui._couponControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PEARLSHOP_CANUSECOUPON", "couponcount", usableCouponCount))
    else
      local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
      local couponName = couponWrapper:getCouponName()
      self._ui._couponControl:SetText(couponName)
    end
  else
    self._ui._couponControl:SetFontColor(Defines.Color.C_FF76747D)
    self._ui._couponControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PEARLSHOP_NOCOUPON"))
    self._ui._bottomKeyGuideY:SetShow(false)
    self._panel:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  self._isOpenMoonBlessing = false
  self._price = toInt64(0, self._amount) * productInfo:getPrice()
  local priceStr = makeDotMoney(self._price)
  local rightgapX = 40
  self._ui._moneyBG:SetShow(false)
  self._ui._silverControl:SetShow(false)
  self._ui._mileageControl:SetShow(false)
  if nil == applyCoupon or false == applyCoupon then
    self._ui._pearlOriginControl:SetShow(false)
    if __ePriceType_Pearl == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(true)
      self._ui._mileageControl:SetShow(false)
      self._ui._silverControl:SetShow(false)
      self._ui._pearlControl:SetText(priceStr)
      local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
      self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    elseif __ePriceType_Mileage == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(false)
      self._ui._mileageControl:SetShow(true)
      self._ui._silverControl:SetShow(false)
      self._ui._mileageControl:SetText(priceStr)
      local sizeX = self._ui._mileageControl:GetSizeX() + self._ui._mileageControl:GetTextSizeX() + rightgapX
      self._ui._mileageControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    elseif __ePriceType_Sliver == productInfo:getProductPriceType() then
      self._ui._pearlControl:SetShow(false)
      self._ui._mileageControl:SetShow(false)
      self._ui._silverControl:SetShow(true)
      self._ui._silverControl:SetText(priceStr)
      local sizeX = self._ui._silverControl:GetSizeX() + self._ui._silverControl:GetTextSizeX() + rightgapX
      self._ui._silverControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
      local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
      local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
      local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
      local warehouseWrapper = warehouse_get(waypointKey)
      local silverInInventory = getSelfPlayer():get():getInventory():getMoney_s64()
      local silverInWarehouse = toInt64(0, 0)
      if nil ~= warehouseWrapper then
        silverInWarehouse = warehouseWrapper:getMoney_s64()
      end
      self._ui._txtSilverInInven:SetText(makeDotMoney(silverInInventory))
      self._ui._txtSilverInWarehouse:SetText(makeDotMoney(silverInWarehouse))
      self._ui._moneyBG:SetShow(true)
      self._panel:SetSize(self._panel:GetSizeX(), self._panel:GetSizeY() + self._ui._moneyBG:GetSizeY())
      self._ui._moneyBG:ComputePos()
      self._ui._bottomControl:ComputePos()
    end
  else
    local couponWrapper = ToClient_GetCouponInfoWrapper(self._selectedCouponIdx)
    if nil == couponWrapper then
      return
    end
    local couponName = couponWrapper:getCouponName()
    local couponDiscountRate = couponWrapper:getCouponDisCountRate()
    local couponDiscountPearl = couponWrapper:getCouponDisCountPearl()
    local couponState = couponWrapper:getCouponState()
    local couponCategoryCheck = couponWrapper:checkCategory(productInfo:getMainCategory(), productInfo:getMiddleCategory(), productInfo:getSmallCategory())
    local couponMaxDiscount = couponWrapper:getCouponMaxDisCountPearl()
    local couponMinProductPearl = couponWrapper:getCouponMinProductPearl()
    local isDiscountPearl = couponWrapper:isDisCountPearl()
    if false == couponCategoryCheck then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_UNABLECOUPON"))
      self._ui._pearlControl:SetShow(true)
      self._ui._pearlControl:SetText(priceStr)
      self._ui._pearlOriginControl:SetShow(false)
      local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
      self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
      return
    end
    local couponDiscountValue
    if false == isDiscountPearl then
      self._ui._amountControl:SetText(1)
      couponDiscountValue = productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
      if couponMaxDiscount > toInt64(0, 0) then
        if couponMaxDiscount < couponDiscountValue then
          self._price = productInfo:getPrice() - couponMaxDiscount
          self._ui._pearlControl:SetText(tostring(self._price))
          Proc_ShowMessage_Ack(tostring(couponName) .. PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_LIMITMAXSALE"))
        else
          self._price = productInfo:getPrice() - productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
          self._ui._pearlControl:SetText(tostring(self._price))
        end
      else
        self._price = productInfo:getPrice() - productInfo:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
        self._ui._pearlControl:SetText(tostring(self._price))
      end
    else
      local productPrice = productInfo:getPrice() * toInt64(0, self.savedProductCount)
      couponDiscountValue = productPrice - couponDiscountPearl
      if couponDiscountValue <= toInt64(0, 0) then
        couponDiscountValue = ToClient_MinCashProductPriceCoupon()
      end
      self._price = couponDiscountValue
      self._ui._pearlControl:SetText(tostring(couponDiscountValue))
    end
    self._ui._pearlOriginControl:SetShow(true)
    self._ui._pearlControl:SetShow(true)
    self._ui._pearlOriginControl:SetText(makeDotMoney(productInfo:getPrice()))
    local sizeX = self._ui._pearlControl:GetSizeX() + self._ui._pearlControl:GetTextSizeX() + rightgapX
    self._ui._pearlControl:SetPosX(self._ui.BtmBg:GetSizeX() - sizeX)
    local posX = self._ui._pearlControl:GetPosX() - self._ui._pearlOriginControl:GetTextSizeX() - rightgapX
    self._ui._pearlOriginControl:SetPosX(posX)
    self._ui._pearlOriginControl:SetPosY(self._ui._pearlControl:GetPosY())
  end
  if __ePriceType_Pearl == productInfo:getProductPriceType() then
    self._isOpenMoonBlessing = true
  end
  if true == self._isOpenMoonBlessing and true == _ContentsGroup_PearlShopMileage and true == _ContentsGroup_NewUI_MoonBlessing_All then
    PaGlobal_CashMileage_ChangeConsumePearl(self._price)
  end
end
function pearlShopProductBuy:changePlatformSpecKey()
end
function FromClient_PearlShopProductBuyInit()
  pearlShopProductBuy:initialize()
end
function pearlShopProductBuy:couponListClsoe()
  self._ui._bottomKeyGuideY:SetShow(true)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "PaGlobalFunc_PearlShopProductBuyDown()")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobalFunc_PearlShopProductBuyUp()")
  self._ui._txt_CouponBG:SetShow(false)
end
function pearlShopProductBuy:couponListUpdate()
  local count = ToClient_GetCouponInfoCount()
  local cashProduct
  local main = -1
  local middle = -1
  local small = -1
  local productNoRaw = self._productNoRaw
  local tcount = 0
  if nil ~= productNoRaw then
    cashProduct = self:getProductInfo()
    main = cashProduct:getMainCategory()
    middle = cashProduct:getMiddleCategory()
    small = cashProduct:getSmallCategory()
  else
    return 0
  end
  if __ePriceType_Pearl ~= cashProduct:getProductPriceType() then
    return 0
  end
  self._ui._list2_Coupon:getElementManager():clearKey()
  for i = 0, count - 1 do
    local couponWrapper = ToClient_GetCouponInfoWrapper(i)
    if 0 == couponWrapper:getCouponState() then
      if nil == cashProduct then
        tcount = tcount + 1
        self._ui._list2_Coupon:getElementManager():pushKey(toInt64(0, i))
      else
        cashProductPrice = cashProduct:getPrice() * toInt64(0, productCount)
        local isDiscountPearl = couponWrapper:isDisCountPearl()
        local minProductPearl = 0
        if isDiscountPearl then
          minProductPearl = couponWrapper:getCouponMinProductPearl()
          if 1 == minProductPearl then
            isDiscountPearl = false
          elseif minProductPearl <= cashProductPrice then
            isDiscountPearl = false
          end
        end
        if true == couponWrapper:checkCategory(main, middle, small) and false == isDiscountPearl then
          tcount = tcount + 1
          self._ui._list2_Coupon:getElementManager():pushKey(toInt64(0, i))
        end
      end
    end
  end
  if tcount > 0 then
    self._isAvailableCoupon = true
  end
  return tcount
end
function PaGlobalFunc_PearlShopProductBuy_ShowCouponList()
  local self = pearlShopProductBuy
  self._ui._bottomKeyGuideY:SetShow(false)
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "")
  self._panel:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
  self._ui._txt_CouponBG:SetShow(true)
  local gabX = 20
  if nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
    self._ui._txt_CouponBG:SetSpanSize(self._panel:GetSizeX() - gabX, self._ui._txt_CouponBG:GetSpanSize().y)
  else
    self._ui._txt_CouponBG:SetSpanSize(-1 * self._ui._txt_CouponBG:GetSizeX() - gabX * 2, self._ui._txt_CouponBG:GetSpanSize().y)
  end
  self:couponListUpdate()
  ToClient_padSnapSetTargetGroup(self._ui._list2_Coupon)
end
function PaGlobalFunc_PearlShopProductBuy_CreateCouponList(control, key64)
  local self = pearlShopProductBuy
  local idx = Int64toInt32(key64)
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  local couponWrapper = ToClient_GetCouponInfoWrapper(idx)
  if nil ~= couponWrapper then
    local couponName = couponWrapper:getCouponName()
    local couponKey = couponWrapper:getCouponKey()
    local couponState = couponWrapper:getCouponState()
    local couponExpirationDate = couponWrapper:getExpirationDateTime()
    local couponRate = couponWrapper:getCouponDisCountRate()
    local couponPearl = couponWrapper:getCouponDisCountPearl()
    local couponMaxDiscount = couponWrapper:getCouponMaxDisCountPearl()
    local couponCategory = couponWrapper:getCouponCategoryExpression()
    local isDiscountPearl = couponWrapper:isDisCountPearl()
    btn_Coupon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PearlShopProductBuy_ApplyCoupon(" .. idx .. ")")
    btn_Coupon:addInputEvent("Mouse_On", "PaGlobalFunc_PearlShopProductBuy_FocusOn(" .. idx .. ")")
    btn_Coupon:addInputEvent("Mouse_Out", "PaGlobalFunc_PearlShopProductBuy_FocusOut(" .. idx .. ")")
    txt_Title:SetTextMode(__eTextMode_LimitText)
    txt_Title:SetText(couponName)
    if false == isDiscountPearl then
      txt_Rate:SetText(couponRate / 10000 .. "%")
    else
      txt_Rate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_COUPON_COUPONPEARL", "couponPearl", tostring(couponPearl)))
    end
  end
end
function PaGlobalFunc_PearlShopProductBuy_ApplyCoupon(couponIndex)
  local self = pearlShopProductBuy
  self._selectedCouponIdx = couponIndex
  self:couponListClsoe()
  self:update(true)
  PaGlobalFunc_PearlShopProductBuy_FocusOut(couponIndex)
end
function PaGlobalFunc_PearlShopProductBuy_FocusOn(couponIndex)
  local self = pearlShopProductBuy
  local control = self._ui._list2_Coupon:GetContentByKey(toInt64(0, couponIndex))
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  txt_Title:SetFontColor(Defines.Color.C_FFEEEEEE)
  txt_Rate:SetFontColor(Defines.Color.C_FFFFD691)
end
function PaGlobalFunc_PearlShopProductBuy_FocusOut(couponIndex)
  local self = pearlShopProductBuy
  local control = self._ui._list2_Coupon:GetContentByKey(toInt64(0, couponIndex))
  local btn_Coupon = UI.getChildControl(control, "Button_Coupon")
  local txt_Title = UI.getChildControl(btn_Coupon, "StaticText_CouponName")
  local txt_Rate = UI.getChildControl(btn_Coupon, "StaticText_CouponRate")
  txt_Title:SetFontColor(Defines.Color.C_FFB2B9D4)
  txt_Rate:SetFontColor(Defines.Color.C_FFB2B9D4)
  btn_Coupon:setRenderTexture(btn_Coupon:getBaseTexture())
end
function HandleEventOn_PearlShop_SilverPay(whereType)
  if CppEnums.ItemWhereType.eInventory == whereType then
    pearlShopProductBuy._ui._rdoMoneyByMe:SetCheck(true)
    pearlShopProductBuy._ui._rdoMoneyByWareHouse:SetCheck(false)
    self._isPayInSilverWarehouse = false
  elseif CppEnums.ItemWhereType.eWarehouse == whereType then
    pearlShopProductBuy._ui._rdoMoneyByMe:SetCheck(false)
    pearlShopProductBuy._ui._rdoMoneyByWareHouse:SetCheck(true)
    self._isPayInSilverWarehouse = true
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PearlShopProductBuyInit")
