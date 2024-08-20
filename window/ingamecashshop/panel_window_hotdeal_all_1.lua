function PaGlobal_Window_HotDeal_All:initialize()
  if nil == Panel_Window_HotDeal_All or true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_titleArea = UI.getChildControl(Panel_Window_HotDeal_All, "Static_TitleArea")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_titleArea, "StaticText_Title")
  self._ui._stc_backImage = UI.getChildControl(self._ui._stc_titleArea, "Static_BackImage")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  self._ui._stc_npcImageBg = UI.getChildControl(Panel_Window_HotDeal_All, "Static_NPCImage_BG")
  self._ui._stc_image = UI.getChildControl(self._ui._stc_npcImageBg, "Static_Image")
  self._ui._stc_itemCount = UI.getChildControl(self._ui._stc_npcImageBg, "Static_ItemCount")
  self._ui._txt_itemTitle = UI.getChildControl(self._ui._stc_itemCount, "StaticText_Title")
  self._ui._txt_countValue = UI.getChildControl(self._ui._stc_itemCount, "StaticText_Count_Value")
  self._ui._stc_clockBg = UI.getChildControl(self._ui._stc_npcImageBg, "Static_Clock_BG")
  self._ui._txt_hour1 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Time_1")
  self._ui._txt_hour2 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Time_2")
  self._ui._txt_min1 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Min_1")
  self._ui._txt_min2 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Min_2")
  self._ui._txt_sec1 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Sec_1")
  self._ui._txt_sec2 = UI.getChildControl(self._ui._stc_clockBg, "StaticText_Sec_2")
  self._ui._stc_productBg = UI.getChildControl(self._ui._stc_npcImageBg, "Static_Product_BG")
  self._ui._stc_itemSlot = UI.getChildControl(self._ui._stc_productBg, "Static_ItemSlot")
  self._ui._txt_itemName = UI.getChildControl(self._ui._stc_productBg, "StaticText_ItemName")
  self._ui._txt_totalDiscount = UI.getChildControl(self._ui._stc_productBg, "StaticText_Total_Discount")
  self._ui._txt_discountDirection = UI.getChildControl(self._ui._stc_productBg, "StaticText_DiscountDirection")
  self._ui._txt_totalPrice = UI.getChildControl(self._ui._stc_productBg, "StaticText_Total_Price")
  self._ui._stc_saleBg = UI.getChildControl(self._ui._stc_productBg, "Static_Sale_BG")
  self._ui._txt_saleValue = UI.getChildControl(self._ui._stc_saleBg, "StaticText_Sale_Value")
  self._ui._stc_productArea = UI.getChildControl(Panel_Window_HotDeal_All, "Static_ProductArea")
  self._ui._stc_itemSlotTemp = UI.getChildControl(self._ui._stc_productArea, "Static_ItemSlot_Temp")
  self._ui._txt_packageTitle = UI.getChildControl(self._ui._stc_productArea, "StaticText_Package_Title")
  self._ui._stc_bottomArea = UI.getChildControl(Panel_Window_HotDeal_All, "Static_BottomArea")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_bottomArea, "StaticText_1")
  self._ui._btn_buy = UI.getChildControl(Panel_Window_HotDeal_All, "Button_Buy")
  self:validate()
  self:registEventHandler()
  self._baseSubItemPosX = self._ui._stc_itemSlotTemp:GetPosX()
  self._subItemGapX = self._ui._stc_itemSlotTemp:GetSizeX() + 10
  if nil ~= self._ui._stc_itemSlot then
    local slot = {}
    slot.slotBg = self._ui._stc_itemSlot
    SlotItem.new(slot, "ItemSlot", 0, self._ui._stc_itemSlot, self._mainSlotConfig)
    slot:createChild()
    self._mainItemSlot = slot
  end
  for ii = 0, self._subItemMaxCount - 1 do
    local slot = {}
    slot.slotBg = UI.cloneControl(self._ui._stc_itemSlotTemp, self._ui._stc_productArea, "Static_ItemSlotBG_" .. ii)
    slot.slotBg:SetPosX(self._baseSubItemPosX + self._subItemGapX * ii)
    SlotItem.new(slot, "ItemSlot_" .. ii, ii, slot.slotBg, self._subSlotConfig)
    slot:createChild()
    slot.slotBg:SetShow(false)
    self._subItems[ii] = slot
  end
  self._ui._stc_itemSlotTemp:SetShow(false)
  self._initialize = true
end
function PaGlobal_Window_HotDeal_All:registEventHandler()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  Panel_Window_HotDeal_All:RegisterShowEventFunc(true, "PaGlobal_Window_HotDeal_All_ShowAni()")
  Panel_Window_HotDeal_All:RegisterShowEventFunc(false, "PaGlobal_Window_HotDeal_All_HideAni()")
  registerEvent("onScreenResize", "FromClient_Window_HotDeal_All_OnResize")
  registerEvent("FromClient_ChangeHotDealUIOpen", "FromClient_Window_HotDeal_All_SetShowHotDeal")
  registerEvent("FromClient_updateLimitedSalesProduct", "FromClient_Window_HotDeal_All_Update")
  self._ui._btn_buy:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_HotDeal_All_BuyItem()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_HotDeal_All_Close()")
  self._ui._btn_close:SetShow(not self._isConsole)
end
function PaGlobal_Window_HotDeal_All:prepareOpen()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  if false == _ContentsGroup_HotDeal_All then
    return
  end
  if false == self:update() then
    return
  end
  self:resize()
  self._curUpdateTime = 0
  self._curEffectTime = self._maxEffectTime
  self._isTimeTextRedColor = false
  self._lastReminedTime = 0
  Panel_Window_HotDeal_All:RegisterUpdateFunc("PaGlobal_Window_HotDeal_All_UpdatePerFrame")
  self:open()
end
function PaGlobal_Window_HotDeal_All:open()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  Panel_Window_HotDeal_All:SetShow(true, true)
end
function PaGlobal_Window_HotDeal_All:prepareClose()
  if nil == Panel_Window_HotDeal_All or false == Panel_Window_HotDeal_All:GetShow() then
    return
  end
  self:clear()
  Panel_Tooltip_Item_hideTooltip()
  if nil ~= FGlobal_CashShop_GoodsTooltipInfo_Close then
    FGlobal_CashShop_GoodsTooltipInfo_Close()
  end
  self:close()
end
function PaGlobal_Window_HotDeal_All:close()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  Panel_Window_HotDeal_All:SetShow(false, false)
end
function PaGlobal_Window_HotDeal_All:clear()
  if nil ~= Panel_Window_HotDeal_All then
    Panel_Window_HotDeal_All:ClearUpdateLuaFunc()
  end
  self._curUpdateTime = 0
  self._maxUpdateTime = 0
  self._productNoRaw = 0
  self._discountPrice_s64 = toInt64(0, 0)
  self._salesStartTime = toInt64(0, 0)
  self._salesEndTime = toInt64(0, 0)
end
function PaGlobal_Window_HotDeal_All:update()
  if nil == Panel_Window_HotDeal_All then
    return false
  end
  local limitedSalesProduct = ToClient_getStartLimitedSalesProduct()
  if nil == limitedSalesProduct then
    return false
  end
  local ingameCashMall = getIngameCashMall()
  if nil == ingameCashMall then
    return false
  end
  local productNoRaw = limitedSalesProduct:getCashProductNoRaw()
  local cashProduct = ingameCashMall:getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if nil == cashProduct then
    return false
  end
  local currentTime = getServerUtc64()
  local startTime = limitedSalesProduct:getSalesStartPeriodDate()
  local endTime = limitedSalesProduct:getSalesEndPeriodDate()
  if currentTime < startTime or currentTime >= endTime then
    return false
  end
  if self._productNoRaw ~= productNoRaw then
    self._productNoRaw = productNoRaw
    if nil ~= self._mainItemSlot then
      local itemEnchantSS = cashProduct:getItemByIndex(0)
      local itemCount = cashProduct:getItemCountByIndex(0)
      if nil ~= itemEnchantSS and nil ~= itemEnchantSS:get() and itemCount > toInt64(0, 0) then
        self._mainItemSlot:setItemByStaticStatus(itemEnchantSS, itemCount)
        self._mainItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Window_HotDeal_All_MainItemShowToolTip(true)")
        self._mainItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Window_HotDeal_All_MainItemShowToolTip(false)")
        self._mainItemSlot.slotBg:SetShow(true)
      else
        self._mainItemSlot:clearItem()
        self._mainItemSlot.slotBg:SetShow(false)
      end
    end
    self._ui._txt_itemName:SetText(cashProduct:getDisplayName())
    local basePrice = cashProduct:getPrice()
    self._ui._txt_totalDiscount:SetText(makeDotMoney(basePrice))
    self._discountPrice_s64 = limitedSalesProduct:getDiscountPrice()
    self._ui._txt_totalPrice:SetText(makeDotMoney(self._discountPrice_s64))
    local discountValue = 0
    if toInt64(0, 0) ~= basePrice then
      local discountPrice_s32 = Int64toInt32(self._discountPrice_s64)
      local basePrice_s32 = Int64toInt32(basePrice)
      discountValue = math.floor((basePrice_s32 - discountPrice_s32) / basePrice_s32 * 100)
    end
    self._ui._txt_saleValue:SetText(tostring(discountValue) .. "%")
    local itemListCount = cashProduct:getItemListCount()
    for ii = 0, self._subItemMaxCount do
      local slot = self._subItems[ii]
      if nil ~= slot then
        local isShowSlot = false
        if ii < itemListCount then
          local itemEnchantSS = cashProduct:getItemByIndex(ii)
          local itemCount = cashProduct:getItemCountByIndex(ii)
          if nil ~= itemEnchantSS and nil ~= itemEnchantSS:get() and itemCount > toInt64(0, 0) then
            slot:setItemByStaticStatus(itemEnchantSS, itemCount)
            slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Window_HotDeal_All_SubItemShowToolTip(true," .. ii .. "," .. itemEnchantSS:get()._key:getItemKey() .. ")")
            slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Window_HotDeal_All_SubItemShowToolTip(false)")
            isShowSlot = true
          end
        end
        if false == isShowSlot then
          slot:clearItem()
        end
        slot.slotBg:SetShow(isShowSlot)
      end
    end
    self._salesStartTime = limitedSalesProduct:getSalesStartPeriodDate()
    self._salesEndTime = endTime
    self:updateReminedTime()
  end
  local isLimitedCount = limitedSalesProduct:isLimitedCount()
  if true == isLimitedCount then
    local maxLimitCount = limitedSalesProduct:getMaxCount()
    local limitCount = limitedSalesProduct:getRemainedCount()
    self._ui._txt_countValue:SetText(limitCount .. "/" .. maxLimitCount)
    self._ui._txt_countValue:SetPosX(self._ui._txt_itemTitle:GetPosX() + self._ui._txt_itemTitle:GetTextSizeX() + 5)
    self._ui._txt_countValue:SetShow(true)
  else
    self._ui._txt_countValue:SetShow(false)
  end
  local descString = ""
  local limitType = cashProduct:getCashPurchaseLimitType()
  if CppEnums.CashPurchaseLimitType.None ~= limitType then
    local limitCount = cashProduct:getCashPurchaseCount()
    local mylimitCount = ingameCashMall:getRemainingLimitCount(self._productNoRaw)
    local typeString = ""
    if CppEnums.CashPurchaseLimitType.AtCharacter == limitType then
      typeString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_CHARACTER")
    elseif CppEnums.CashPurchaseLimitType.AtAccount == limitType then
      typeString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_FAMILY")
    end
    descString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOTDEAL_DESC", "typeString", typeString, "limitCount", limitCount, "mylimitCount", mylimitCount)
  end
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(descString)
  return true
end
function PaGlobal_Window_HotDeal_All:updateReminedTime()
  local currentTime = getServerUtc64()
  local reminedTime = Int64toInt32(self._salesEndTime - currentTime)
  if reminedTime > 0 then
    local hour = reminedTime / 3600
    local min = reminedTime % 3600 / 60
    local sec = reminedTime % 3600 % 60
    local hour_text1 = tostring(math.floor(hour / 10))
    local hour_text2 = tostring(math.floor(hour % 10))
    local min_text1 = tostring(math.floor(min / 10))
    local min_text2 = tostring(math.floor(min % 10))
    local sec_text1 = tostring(math.floor(sec / 10))
    local sec_text2 = tostring(math.floor(sec % 10))
    if reminedTime < 60 then
      if self._lastReminedTime ~= reminedTime then
        self._isTimeTextRedColor = false
        self._curEffectTime = 0
        self._lastReminedTime = reminedTime
      elseif true == self._isTimeTextRedColor then
        hour_text1 = "<PAColor0xffb82929>" .. hour_text1 .. "<PAOldColor>"
        hour_text2 = "<PAColor0xffb82929>" .. hour_text2 .. "<PAOldColor>"
        min_text1 = "<PAColor0xffb82929>" .. min_text1 .. "<PAOldColor>"
        min_text2 = "<PAColor0xffb82929>" .. min_text2 .. "<PAOldColor>"
        sec_text1 = "<PAColor0xffb82929>" .. sec_text1 .. "<PAOldColor>"
        sec_text2 = "<PAColor0xffb82929>" .. sec_text2 .. "<PAOldColor>"
      end
    else
      self._isTimeTextRedColor = false
    end
    self._ui._txt_hour1:SetText(hour_text1)
    self._ui._txt_hour2:SetText(hour_text2)
    self._ui._txt_min1:SetText(min_text1)
    self._ui._txt_min2:SetText(min_text2)
    self._ui._txt_sec1:SetText(sec_text1)
    self._ui._txt_sec2:SetText(sec_text2)
  else
    self._ui._txt_hour1:SetText("0")
    self._ui._txt_hour2:SetText("0")
    self._ui._txt_min1:SetText("0")
    self._ui._txt_min2:SetText("0")
    self._ui._txt_sec1:SetText("0")
    self._ui._txt_sec2:SetText("0")
  end
  return reminedTime
end
function PaGlobal_Window_HotDeal_All:buyConfirm()
  if nil == Panel_Window_HotDeal_All or false == Panel_Window_HotDeal_All:GetShow() then
    return
  end
  if false == _ContentsGroup_HotDeal_All then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local ingameCashMall = getIngameCashMall()
  if nil == ingameCashMall then
    return
  end
  local cashProduct = ingameCashMall:getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local count = 1
  local limitType = cashProduct:getCashPurchaseLimitType()
  if CppEnums.CashPurchaseLimitType.None ~= limitType and count > ingameCashMall:getRemainingLimitCount(self._productNoRaw) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_PURCHASELIMIT"))
    return
  end
  if true == PaGlobal_Window_HotDeal_All:checkHaveMeaning(cashProduct, count) then
    return
  end
  local addmathClassString = ""
  local isMatchedClass = false
  if nil ~= PaGlobalFunc_IngameCashShop_isActualUsableClass then
    isMatchedClass = PaGlobalFunc_IngameCashShop_isActualUsableClass(cashProduct)
  end
  if false == isMatchedClass then
    addmathClassString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MATHCLASS")
  end
  local messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_REALBUY", "addmathClassString", addmathClassString, "getName", cashProduct:getName(), "count", count)
  local productCategory = cashProduct:getMainCategory()
  if CppEnums.CashProductCategory.eCashProductCategory_Pearl == productCategory then
    messageBoxMemo = messageBoxMemo .. PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_PURCHASELIMIT")
  end
  local function confirmDo()
    audioPostEvent_SystemUi(16, 0)
    _AudioPostEvent_SystemUiForXBOX(16, 0)
    local productNoRaw = self._productNoRaw
    local couponNo = toInt64(0, -1)
    local couponKey = 0
    local price = self._discountPrice_s64
    local isImmediatelyUse = CppEnums.BuyItemReqTrType.eBuyItemReqTrType_None
    local pearlStampCount = 0
    local fromWhereType = CppEnums.ItemWhereType.eCount
    if true == cashProduct:isMoneyPrice() then
      if IngameCashShop_StartTerritory ~= selfPlayerCurrentTerritory() then
        local messageBoxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT"),
          content = PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_TERRITORY_CHANGED"),
          functionApply = InGameShop_Close,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
      end
      fromWhereType = CppEnums.ItemWhereType.eInventory
    end
    ToClient_requestBuyItem(productNoRaw, count, price, isImmediatelyUse, couponNo, couponKey, pearlStampCount, fromWhereType, true, true)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT"),
    content = messageBoxMemo,
    functionYes = confirmDo,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Window_HotDeal_All:checkHaveMeaning(cashProduct, itemCount)
  if nil == Panel_Window_HotDeal_All or false == Panel_Window_HotDeal_All:GetShow() then
    return false
  end
  if false == _ContentsGroup_HotDeal_All then
    return false
  end
  if nil == cashProduct or itemCount <= 0 then
    return false
  end
  local productPriceType = cashProduct:getProductPriceType()
  local myMoney = Defines.s64_const.s64_0
  local price = Defines.s64_const.s64_0
  local productCategory = 0
  local messageTitle, messageDesc
  local isSilver = false
  if __ePriceType_Cash == productPriceType then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return false
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return false
    end
    myMoney = selfPlayer:getCash()
    price = cashProduct:getOriginalPrice()
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYCASHMEGBOX_TITLE")
    messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYCASHMEGBOX_DESC")
    productCategory = 0
  elseif __ePriceType_Pearl == productPriceType then
    local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
    if nil == pearlItemWrapper then
      return false
    end
    local pearlItem = pearlItemWrapper:get()
    if nil == pearlItem then
      return false
    end
    myMoney = pearlItemWrapper:get():getCount_s64()
    if nil ~= self._discountPrice_s64 and Defines.s64_const.s64_0 < self._discountPrice_s64 then
      price = self._discountPrice_s64
    else
      price = cashProduct:getProductPrice()
    end
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_TITLE")
    messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_DESC")
    productCategory = CppEnums.CashProductCategory.eCashProductCategory_Pearl
  elseif __ePriceType_Sliver == productPriceType then
    myMoney = InGameShopBuy_GetSliver()
    price = cashProduct:getProductPrice()
    isSilver = true
  else
    return false
  end
  price = price * toInt64(0, itemCount)
  if myMoney < price then
    if true == cashProduct:isApplyDiscount() and myMoney >= cashProduct:getDiscountPrice() then
      return false
    end
    if true == isSilver then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEMANAGEMENT_ACK_MAKEBOOK"))
    else
      local function MessgeBox_Yes()
        GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
        if 0 == productCategory then
          InGameShop_BuyDaumCash()
        else
          local goCategory = PaGlobal_InGameShop_GetTabIndex(CppEnums.CashProductCategory.eCashProductCategory_Pearl)
          PaGlobal_InGameShop_GoToTab(goCategory)
          InGameShop_TabEvent(goCategory)
        end
        InGameShopDetailInfo_Close()
        InGameShopBuy_Close(true)
      end
      local messageBoxData = {
        title = messageTitle,
        content = messageDesc,
        functionYes = MessgeBox_Yes,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    return true
  end
  return false
end
function PaGlobal_Window_HotDeal_All:resize()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  local priceGapX = 10
  local baseSpanSizeX = 70
  local addSpanSizeX = self._ui._txt_totalDiscount:GetSizeX() + self._ui._txt_totalDiscount:GetTextSizeX()
  self._ui._txt_discountDirection:SetSpanSize(baseSpanSizeX + addSpanSizeX + priceGapX, self._ui._txt_discountDirection:GetSpanSize().y)
  addSpanSizeX = addSpanSizeX + self._ui._txt_discountDirection:GetSizeX()
  self._ui._txt_totalPrice:SetSpanSize(baseSpanSizeX + addSpanSizeX + priceGapX * 2, self._ui._txt_totalPrice:GetSpanSize().y)
  addSpanSizeX = addSpanSizeX + self._ui._txt_totalPrice:GetTextSizeX()
  self._ui._stc_saleBg:SetSpanSize(baseSpanSizeX + addSpanSizeX + priceGapX * 3, self._ui._stc_saleBg:GetSpanSize().y)
  self._ui._txt_countValue:SetSpanSize(self._ui._txt_itemTitle:GetTextSizeX() + 15, self._ui._txt_countValue:GetSpanSize().y)
end
function PaGlobal_Window_HotDeal_All:validate()
  if nil == Panel_Window_HotDeal_All then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._stc_backImage:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_npcImageBg:isValidate()
  self._ui._stc_image:isValidate()
  self._ui._stc_itemCount:isValidate()
  self._ui._txt_itemTitle:isValidate()
  self._ui._txt_countValue:isValidate()
  self._ui._stc_clockBg:isValidate()
  self._ui._txt_hour1:isValidate()
  self._ui._txt_hour2:isValidate()
  self._ui._txt_min1:isValidate()
  self._ui._txt_min2:isValidate()
  self._ui._txt_sec1:isValidate()
  self._ui._txt_sec2:isValidate()
  self._ui._stc_productBg:isValidate()
  self._ui._stc_itemSlot:isValidate()
  self._ui._txt_itemName:isValidate()
  self._ui._txt_totalDiscount:isValidate()
  self._ui._txt_discountDirection:isValidate()
  self._ui._txt_totalPrice:isValidate()
  self._ui._stc_saleBg:isValidate()
  self._ui._txt_saleValue:isValidate()
  self._ui._stc_productArea:isValidate()
  self._ui._stc_itemSlotTemp:isValidate()
  self._ui._txt_packageTitle:isValidate()
  self._ui._stc_bottomArea:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_buy:isValidate()
end
