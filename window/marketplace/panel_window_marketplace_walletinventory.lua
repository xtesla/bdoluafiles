local _panel = Panel_Window_MarketPlace_WalletInventory
local UI_color = Defines.Color
local MarketPlace_WalletInven = {
  _ui = {
    stc_Title = UI.getChildControl(_panel, "StaticText_Title"),
    stc_TopBg = UI.getChildControl(_panel, "Static_TopItemSortBG"),
    stc_WeightBg = UI.getChildControl(_panel, "Static_Texture_Weight_Background"),
    template_Slot = UI.getChildControl(_panel, "Template_Static_Slot"),
    template_LockSlot = UI.getChildControl(_panel, "Template_Static_LockSlot"),
    scroll_CashInven = UI.getChildControl(_panel, "Scroll_CashInven"),
    btn_Withdraw = UI.getChildControl(_panel, "Button_Withdraw"),
    stc_ScrollArea = UI.getChildControl(_panel, "Scroll_Area"),
    btn_goToMarket = UI.getChildControl(_panel, "Button_GoToMarket"),
    btn_goToWallet = UI.getChildControl(_panel, "Button_GoToWallet"),
    btn_goToWarehouse = UI.getChildControl(_panel, "Button_BacktoWarehouse"),
    txt_Money = UI.getChildControl(_panel, "StaticText_MoneyValue")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCash = true,
    createBagIcon = true,
    createEnduranceIcon = true,
    createCheckBox = true
  },
  _config = {
    slotCount = 64,
    slotCols = 8,
    slotRows = 0,
    slotStartX = 0,
    slotStartY = 0,
    slotGapX = 53,
    slotGapY = 53,
    maxItem = __eTMarketPlaceWalletInventorySlotNoMax
  },
  _slotWalletBgData = {},
  _slotWalletItemData = {},
  _startInvenSlotIndex = 0,
  _isAblePearlProduct = false,
  _moneySlot = 0,
  _filterText = "",
  _searchItemEffect = {},
  _searchItemEffectOff = {},
  _searchFilterAlpha = 0.5,
  _newItemEffectList = Array.new()
}
function PaGlobalFunc_MarketPlace_WalletInven_Init()
  local self = MarketPlace_WalletInven
  self:initData()
  self:initControl()
  self:initEvent()
  registerEvent("FromClient_responseBuyItemToWorldMarket", "FromClient_MarketPlace_WalletItem_BuyComplete")
end
function MarketPlace_WalletInven:initControl()
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Win_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_Title, "Button_Question")
  self._ui.checkBtn_PopUp = UI.getChildControl(self._ui.stc_Title, "CheckButton_PopUp")
  self._ui.btn_List = UI.getChildControl(self._ui.stc_TopBg, "RadioButton_List")
  self._ui.btn_Slot = UI.getChildControl(self._ui.stc_TopBg, "RadioButton_Slot")
  self._ui.txt_Capacity = UI.getChildControl(self._ui.stc_TopBg, "Static_Text_Capacity")
  local searchBg = UI.getChildControl(self._ui.stc_TopBg, "Static_Search_BG")
  self._ui.edit_Search = UI.getChildControl(searchBg, "Edit_GoodsName")
  self._ui.txt_DefaultSearchText = UI.getChildControl(searchBg, "StaticText_DefaultSearchText")
  self._ui.btn_searchReset = UI.getChildControl(searchBg, "Button_SearchReset")
  self._ui.progress_Weight = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Weight")
  self._ui.progress_Equipment = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Equipment")
  self._ui.progress_Money = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Money")
  self._ui.txt_Weight = UI.getChildControl(self._ui.stc_WeightBg, "StaticText_Weight")
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    slot.base = UI.createAndCopyBasePropertyControl(_panel, "Template_Static_Slot", _panel, "MarketWallet_Wallet_EmptySlot_" .. slotIdx)
    slot.lock = UI.createAndCopyBasePropertyControl(_panel, "Template_Static_LockSlot", _panel, "MarketWallet_Wallet_LockSlot_" .. slotIdx)
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    local lockGapX = slot.base:GetSizeX() / 2 - slot.lock:GetSizeX() / 2
    local lockGapY = slot.base:GetSizeY() / 2 - slot.lock:GetSizeY() / 2
    slot.base:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
    slot.base:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
    slot.lock:SetPosXY(slot.base:GetPosX() + lockGapX, slot.base:GetPosY() + lockGapY)
    slot.base:SetShow(true)
    slot.lock:SetShow(false)
    UIScroll.InputEventByControl(slot.base, "PaGlobalFunc_MarketPlace_WalletInven_Scroll")
    self._slotWalletBgData[slotIdx] = slot
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "WalletItem_" .. slotIdx, slotIdx, _panel, self._slotConfig)
    slot:createChild()
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 2)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 2)
    slot.icon:SetEnableDragAndDrop(false)
    slot.icon:SetAutoDisableTime(0.5)
    UIScroll.InputEventByControl(slot.icon, "PaGlobalFunc_MarketPlace_WalletInven_Scroll")
    self._slotWalletItemData[slotIdx] = slot
  end
end
function MarketPlace_WalletInven:initEvent()
  UIScroll.InputEvent(self._ui.scroll_CashInven, "PaGlobalFunc_MarketPlace_WalletInven_Scroll")
  UIScroll.InputEventByControl(self._ui.stc_ScrollArea, "PaGlobalFunc_MarketPlace_WalletInven_Scroll")
  self._ui.btn_Withdraw:addInputEvent("Mouse_LUp", "InputMRUp_MarketWallet_WithdrawMoney()")
  self._ui.btn_Withdraw:addInputEvent("Mouse_On", "MarketWallet_WithdrawMoney_TooltipShow()")
  self._ui.btn_Withdraw:addInputEvent("Mouse_Out", "MarketWallet_WithdrawMoney_TooltipHide()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_WalletInven_Close()")
  self._ui.btn_goToMarket:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_OpenbyMaid(1)")
  self._ui.btn_goToWallet:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemMarket_OpenbyMaid(2)")
  if _ContentsGroup_NewUI_WareHouse_All then
    self._ui.btn_goToWarehouse:addInputEvent("Mouse_LUp", "PaGlobal_Warehouse_All_OpenPanelFromDialog()")
  else
    self._ui.btn_goToWarehouse:addInputEvent("Mouse_LUp", "Warehouse_OpenPanelFromDialog()")
  end
  self._ui.btn_goToMarket:addInputEvent("Mouse_On", "MarketWallet_ShortCutSetting_TooltipShow(true, 1)")
  self._ui.btn_goToMarket:addInputEvent("Mouse_Out", "MarketWallet_ShortCutSetting_TooltipShow()")
  self._ui.btn_goToWallet:addInputEvent("Mouse_On", "MarketWallet_ShortCutSetting_TooltipShow(true, 2)")
  self._ui.btn_goToWallet:addInputEvent("Mouse_Out", "MarketWallet_ShortCutSetting_TooltipShow()")
  self._ui.btn_goToMarket:setButtonShortcuts("PANEL_MARKETPLACE_SHORTCUT_OPEN")
  self._ui.btn_goToWallet:setButtonShortcuts("PANEL_MARKETPLACE_SHORTCUT_BAGOPEN")
  self._ui.edit_Search:addInputEvent("Mouse_LDown", "PaGlobalFunc_MarketPlace_WalletInven_SetFocusSearchText()")
  self._ui.edit_Search:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_WalletInven_SetFocusSearchText()")
  self._ui.edit_Search:RegistReturnKeyEvent("PaGlobalFunc_MarketPlace_WalletInven_SearchItem()")
  self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearch()")
  self._ui.btn_searchReset:addInputEvent("Mouse_On", "HandleEventOnOut_MarketPlace_WalletInven_SearchResetTooltip(true)")
  self._ui.btn_searchReset:addInputEvent("Mouse_Out", "HandleEventOnOut_MarketPlace_WalletInven_SearchResetTooltip(false)")
end
function MarketWallet_WithdrawMoney_TooltipShow()
  local uiControl = MarketPlace_WalletInven._ui.btn_Withdraw
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WITHDRAWMONEY_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WITHDRAWMONEY_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function MarketWallet_ShortCutSetting_TooltipShow(isShow, index)
  if nil == isShow then
    TooltipSimple_Hide()
    return
  end
  local self = MarketPlace_WalletInven
  local uiControl, name, desc
  if 1 == index then
    uiControl = self._ui.btn_goToMarket
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_GO_BUY")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MARKETPLACE_WALLETINVENTORY_PURCHASETOOLTIPDESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    TooltipSimple_Show(uiControl, name, desc)
  elseif 2 == index then
    uiControl = self._ui.btn_goToWallet
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_GO_SELL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MARKETPLACE_WALLETINVENTORY_SELLTOOLTIPDESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function MarketWallet_WithdrawMoney_TooltipHide()
  TooltipSimple_Hide()
end
function MarketPlace_WalletInven:initData()
  self._isAblePearlProduct = requestCanRegisterPearlItemOnMarket()
  self._moneySlot = getMoneySlotNo()
  self._config.slotRows = self._config.slotCount / self._config.slotCols
  self._maxSlotRow = math.floor((self._config.slotCount - 1) / self._config.slotCols)
  self._config.slotStartX = self._ui.template_Slot:GetPosX()
  self._config.slotStartY = self._ui.template_Slot:GetPosY()
end
function PaGlobalFunc_MarketPlace_WalletInven_SetFocusSearchText()
  SetFocusEdit(MarketPlace_WalletInven._ui.edit_Search)
  MarketPlace_WalletInven._ui.txt_DefaultSearchText:SetShow(false)
end
function PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearchText()
  ClearFocusEdit()
  MarketPlace_WalletInven._ui.edit_Search:SetEditText("")
  MarketPlace_WalletInven._filterText = ""
  MarketPlace_WalletInven._ui.txt_DefaultSearchText:SetShow(true)
  MarketPlace_WalletInven._ui.btn_searchReset:SetShow(false)
  TooltipSimple_Hide()
  MarketPlace_WalletInven._searchItemEffectOff = {}
end
function PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearch()
  PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearchText()
  MarketPlace_WalletInven:findSearchItem(true)
end
function PaGlobalFunc_MarketPlace_WalletInven_SearchItem()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  MarketPlace_WalletInven._filterText = MarketPlace_WalletInven._ui.edit_Search:GetEditText()
  local isReScanSearch = MarketPlace_WalletInven:findSearchItem(true)
  if true == isReScanSearch then
    MarketPlace_WalletInven:reScanSearchItem()
  end
end
function MarketPlace_WalletInven:findSearchItem(isSearch)
  local isEmptyText = nil == self._filterText or "" == self._filterText or self._filterText:len() <= 0
  if false == isSearch and true == isEmptyText then
    return false
  end
  local walletItemCount = getWorldMarketMyWalletListCount()
  if true == isSearch then
    self._searchItemEffectOff = {}
    if true == isEmptyText then
      self._ui.txt_DefaultSearchText:SetShow(true)
      self._ui.btn_searchReset:SetShow(false)
      TooltipSimple_Hide()
    else
      self._ui.btn_searchReset:SetShow(true)
    end
  end
  local isSearchFind = false
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotWalletItemData[slotIdx]
    if nil ~= slot and nil ~= slot.icon and nil ~= slot.slotNo then
      if true == isSearch then
        slot.icon:EraseAllEffect()
      end
      if true == isEmptyText then
        if true == isSearch and false == slot.isEmpty then
          slot.icon:SetAlpha(1)
        end
      elseif walletItemCount > slot.slotNo then
        local isEffectOn = false
        if nil == self._searchItemEffectOff[slot.slotNo] then
          local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slot.slotNo)
          if nil ~= itemMyWalletInfo then
            local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
            if nil ~= itemWrapper then
              local itemName = itemWrapper:getName()
              if true == stringSearch(itemName, self._filterText) then
                isEffectOn = true
              end
            end
          end
        end
        if true == isEffectOn then
          self._searchItemEffect[slot.slotNo] = slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
          slot.icon:SetAlpha(1)
          isSearchFind = true
        elseif true == self._searchItemEffectOff[slot.slotNo] then
          slot.icon:SetAlpha(1)
          isSearchFind = true
        else
          self._searchItemEffectOff[slot.slotNo] = false
          if false == slot.isEmpty then
            slot.icon:SetAlpha(self._searchFilterAlpha)
          end
        end
      end
    end
  end
  if true == isSearch and false == isEmptyText and false == isSearchFind then
    return true
  end
  return false
end
function MarketPlace_WalletInven:reScanSearchItem()
  local isSearchFind = false
  local intervalSlotIndex = self._config.maxItem - self._config.slotCount
  local startSlot = 0
  local minSlotIndex = self._config.slotCount - self._config.slotCols * 4
  local maxSlotIndex = intervalSlotIndex + self._config.slotCols * 3
  local walletItemCount = getWorldMarketMyWalletListCount()
  for ii = 0, walletItemCount - 1 do
    local slotNo = ii
    local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotNo)
    if nil ~= itemMyWalletInfo then
      local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
      if nil ~= itemWrapper then
        local itemName = itemWrapper:getName()
        if true == stringSearch(itemName, self._filterText) then
          if ii <= minSlotIndex then
            startSlot = 0
          elseif ii > maxSlotIndex then
            startSlot = intervalSlotIndex
          else
            startSlot = math.floor((ii - self._config.slotCols * 3) / self._config.slotCols) * self._config.slotCols
          end
          isSearchFind = true
          break
        end
      end
    end
  end
  if true == isSearchFind then
    local curSlotIndex = startSlot / self._config.slotCols
    local maxSlotIndex = intervalSlotIndex / self._config.slotCols
    local scrollPos = math.max(math.min(curSlotIndex / maxSlotIndex, 1), 0)
    self._ui.scroll_CashInven:SetControlPos(scrollPos)
    self._startInvenSlotIndex = startSlot
    PaGlobalFunc_MarketPlace_WalletInven_Update()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
  end
end
function HandleEventOnOut_MarketPlace_WalletInven_SearchResetTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl = MarketPlace_WalletInven._ui.btn_searchReset
  if nil == uiControl then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEARCHRESET")
  local desc = ""
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobalFunc_MarketPlace_WalletInven_Scroll(isUp)
  local self = MarketPlace_WalletInven
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : MarketWallet")
    return
  end
  if true == PaGlobal_TutorialPhase_IsTutorial() then
    return
  end
  self._startInvenSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_CashInven, isUp, self._config.slotRows, self._config.maxItem, self._startInvenSlotIndex, self._config.slotCols)
  Panel_Tooltip_Item_hideTooltip()
  if nil ~= self._newItemEffectList and nil ~= self._slotWalletBgData then
    for idx = 1, #self._newItemEffectList do
      if nil ~= self._newItemEffectList[idx] and nil ~= self._newItemEffectList[idx].slotNo and self._newItemEffectList[idx].slotNo == slotIdx then
        if nil ~= self._newItemEffectList[idx].effectId and nil ~= self._slotWalletBgData[slotIdx] then
          self._slotWalletBgData[slotIdx].base:EraseEffect(self._newItemEffectList[idx].effectId)
        end
        self._newItemEffectList[idx].slotNo = nil
        self._newItemEffectList[idx].itemKey = nil
        self._newItemEffectList[idx].effectId = nil
        break
      end
    end
  end
  self:updateWallet()
end
function FromClient_MarketPlace_WalletItem_BuyComplete(silverInfo, TItemEnchantKey)
  if false == Panel_Window_MarketPlace_Main:GetShow() and false == Panel_Window_MarketPlace_WalletInventory:GetShow() and false == Panel_Window_MarketPlace_BuyManagement:GetShow() then
    return
  end
  local tempTable = {
    slotNo = nil,
    itemKey = TItemEnchantKey,
    effectId = nil
  }
  MarketPlace_WalletInven._newItemEffectList:push_back(tempTable)
end
function PaGlobalFunc_MarketPlace_WalletInven_RefreshEffectTable()
  local self = MarketPlace_WalletInven
  if 2 <= #self._newItemEffectList then
    local tempArray = Array.new()
    for idx = 1, #self._newItemEffectList do
      if nil ~= self._newItemEffectList[idx].itemKey and nil ~= self._newItemEffectList[idx].effectId and nil ~= self._newItemEffectList[idx].slotNo then
        local tempTable = {
          slotNo = nil,
          itemKey = TItemEnchantKey,
          effectId = nil
        }
        tempTable.slotNo = self._newItemEffectList[idx].slotNo
        tempTable.itemKey = self._newItemEffectList[idx].itemKey
        tempTable.effectId = self._newItemEffectList[idx].effectId
        tempArray:push_back(tempTable)
      end
    end
    self._newItemEffectList = tempArray
  end
end
function PaGlobalFunc_MarketPlace_WalletInven_Update()
  local self = MarketPlace_WalletInven
  self:updateWallet()
  self:findSearchItem(true)
end
function MarketPlace_WalletInven:updateWallet()
  Panel_Tooltip_Item_hideTooltip()
  local currentWeight = getWorldMarketCurrentWeight()
  local maxWeight = getWorldMarketMaxWeight() + getWorldMarketAddWeight() + PaGlobalFunc_WorldMarket_GetAddWeightByBuff()
  local silverInfo = getWorldMarketSilverInfo()
  local _const = Defines.s64_const
  local s64_allWeight = toInt64(0, currentWeight)
  local s64_maxWeight = toInt64(0, maxWeight)
  local s64_allWeight_div = s64_allWeight
  local s64_maxWeight_div = s64_maxWeight
  local str_AllWeight = string.format("%.1f", Int64toInt32(s64_allWeight_div) / 10)
  local str_MaxWeight = string.format("%.0f", Int64toInt32(s64_maxWeight_div) / 10)
  local allWeight = makeWeightString(toInt64(0, currentWeight * 1000), 1)
  local maxWeight = makeWeightString(toInt64(0, maxWeight * 1000), 0)
  self._ui.txt_Money:SetText(makeDotMoney(silverInfo:getItemCount()))
  self._ui.txt_Weight:SetText(allWeight .. " / " .. maxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_VOLUME_VT"))
  self._ui.progress_Weight:SetProgressRate(Int64toInt32(str_AllWeight * 100 / str_MaxWeight))
  local slotNoList = Array.new()
  local walletItemCount = getWorldMarketMyWalletListCount()
  slotNoList:fill(0, self._config.maxItem)
  local usedSlotCount = 0
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotWalletItemData[slotIdx]
    local slotBg = self._slotWalletBgData[slotIdx]
    local slotNo = slotIdx + self._startInvenSlotIndex
    slot:clearItem()
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    slot.icon:addInputEvent("Mouse_RUp", "")
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    if walletItemCount > slotNo then
      local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotNo)
      local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
      if nil ~= itemWrapper then
        usedSlotCount = usedSlotCount + 1
        local s64_inventoryItemCount = itemMyWalletInfo:getItemCount()
        local isSealed = itemMyWalletInfo:isSealed()
        slot:setItemByStaticStatus(itemWrapper, s64_inventoryItemCount, -1, false, nil, false, 0, 0, nil, true, isSealed)
        slot.isEmpty = false
        if false == PaGlobal_TutorialPhase_IsTutorial() then
          slot.icon:addInputEvent("Mouse_RUp", "InputMRUp_MarketWallet_MoveWalletToInven(" .. slotNo .. ")")
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_WalletInven_ShowToolTip(" .. slotNo .. "," .. slotIdx .. ")")
          slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        end
        slot.icon:SetAlpha(1)
        local itemName = itemWrapper:getName()
        if nil ~= self._filterText and 0 < self._filterText:len() then
          slot.icon:EraseAllEffect()
          if true == stringSearch(itemName, self._filterText) then
            if nil == self._searchItemEffectOff[slot.slotNo] then
              self._searchItemEffect[slot.slotNo] = slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
            end
          else
            slot.icon:SetAlpha(self._searchFilterAlpha)
          end
        end
        local itemKey = itemMyWalletInfo:getEnchantKey():get()
        slotBg.base:EraseAllEffect()
        if nil ~= self._newItemEffectList then
          for idx = 1, #self._newItemEffectList do
            if nil ~= self._newItemEffectList[idx] and nil ~= self._newItemEffectList[idx].itemKey and self._newItemEffectList[idx].itemKey == itemKey then
              self._newItemEffectList[idx].slotNo = slotIdx
              self._newItemEffectList[idx].effectId = slotBg.base:AddEffect("fUI_NewItem02", true, 0, 0)
            end
          end
        end
      else
        slot.isEmpty = true
      end
    else
      slot.isEmpty = true
    end
    slotBg.lock:SetShow(false)
  end
  self._ui.txt_Capacity:SetText("")
  UIScroll.SetButtonSize(self._ui.scroll_CashInven, self._config.slotCount, self._config.maxItem)
end
function PaGlobalFunc_MarketPlace_WalletInven_ShowToolTip(slotNo, slotIdx)
  local self = MarketPlace_WalletInven
  if nil == slotNo then
    return
  end
  local slot = self._slotWalletItemData[slotIdx]
  if nil == slot then
    return
  end
  if nil ~= self._searchItemEffect[slotNo] then
    self._searchItemEffectOff[slotNo] = true
    slot.icon:EraseEffect(self._searchItemEffect[slotNo])
    self._searchItemEffect[slotNo] = nil
  end
  if nil ~= self._newItemEffectList and nil ~= self._slotWalletBgData then
    for idx = 1, #self._newItemEffectList do
      if nil ~= self._newItemEffectList[idx] and nil ~= self._newItemEffectList[idx].slotNo and self._newItemEffectList[idx].slotNo == slotIdx then
        if nil ~= self._newItemEffectList[idx].effectId and nil ~= self._slotWalletBgData[slotIdx] then
          self._slotWalletBgData[slotIdx].base:EraseEffect(self._newItemEffectList[idx].effectId)
        end
        self._newItemEffectList[idx].slotNo = nil
        self._newItemEffectList[idx].itemKey = nil
        self._newItemEffectList[idx].effectId = nil
        break
      end
    end
    PaGlobalFunc_MarketPlace_WalletInven_RefreshEffectTable()
  end
  local itemMyWalletInfo = getWorldMarketMyWalletListByIdx(slotNo)
  if nil == itemMyWalletInfo then
    return
  end
  local itemWrapper = itemMyWalletInfo:getItemEnchantStaticStatusWrapper()
  if nil == itemWrapper then
    return
  end
  PaGlobalFunc_MarketPlace_ShowToolTip(itemWrapper, _panel, false)
end
function PaGlobalFunc_MarketPlace_WalletInven_HideButton(isShow)
  if nil == isShow then
    return
  end
  local self = MarketPlace_WalletInven
  self._ui.btn_goToWarehouse:SetShow(isShow)
end
function PaGlobalFunc_MarketPlace_WalletInven_Open()
  local self = MarketPlace_WalletInven
  self:open()
  self._ui.scroll_CashInven:SetControlPos(0)
  self._startInvenSlotIndex = 0
  if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() or true == PaGlobalFunc_MarketPlace_IsOpenFromDialog() then
    self._ui.btn_goToMarket:SetShow(true)
    self._ui.btn_goToWallet:SetShow(true)
  else
    self._ui.btn_goToMarket:SetShow(false)
    self._ui.btn_goToWallet:SetShow(false)
  end
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = _panel:GetSizeX()
  local panelSizeY = _panel:GetSizeY()
  _panel:SetPosX(scrSizeX / 2 - panelSizeX / 2 + panelSizeX / 2)
  _panel:SetPosY(scrSizeY / 2 - panelSizeY / 2)
  if _panel:GetPosY() < 10 then
    _panel:SetPosY(10)
  end
  PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearchText()
  self:updateWallet()
end
function PaGlobalFunc_MarketPlace_WalletInven_Close()
  local self = MarketPlace_WalletInven
  if false == PaGlobalFunc_MarketPlace_WalletInven_GetShow() then
    return
  end
  PaGlobalFunc_MarketPlace_WalletInven_ClearFocusSearchText()
  self:close()
  if false == PaGlobalFunc_MarketPlace_MyInven_GetShow() then
    PaGlobalFunc_MarketWallet_Close()
  end
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Window_MarketPlace_Function and false == Panel_Window_MarketPlace_Function:GetShow() and nil ~= Panel_Window_MarketPlace_MyInventory and false == Panel_Window_MarketPlace_MyInventory:GetShow() then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
end
function MarketPlace_WalletInven:open()
  _panel:SetShow(true)
end
function MarketPlace_WalletInven:close()
  _panel:SetShow(false)
end
function PaGlobalFunc_MarketPlace_WalletInven_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_MarketPlace_WalletInven_GetPanel()
  return _panel
end
