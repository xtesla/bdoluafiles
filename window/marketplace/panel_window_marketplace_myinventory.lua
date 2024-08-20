local _panel = Panel_Window_MarketPlace_MyInventory
local UI_color = Defines.Color
local MarketPlace_MyInven = {
  _ui = {
    stc_Title = UI.getChildControl(_panel, "StaticText_Title"),
    stc_TopBg = UI.getChildControl(_panel, "Static_TopItemSortBG"),
    btn_NormalInven = UI.getChildControl(_panel, "RadioButton_NormalInventory"),
    btn_CashInven = UI.getChildControl(_panel, "RadioButton_CashInventory"),
    btn_WareHouseInven = UI.getChildControl(_panel, "RadioButton_WareHouseInventory"),
    stc_WeightBg = UI.getChildControl(_panel, "Static_Texture_Weight_Background"),
    template_Slot = UI.getChildControl(_panel, "Template_Static_Slot"),
    template_LockSlot = UI.getChildControl(_panel, "Template_Static_LockSlot"),
    btn_Deposit = UI.getChildControl(_panel, "Button_Deposit"),
    scroll_CashInven = UI.getChildControl(_panel, "Scroll_CashInven"),
    stc_ScrollArea = UI.getChildControl(_panel, "Scroll_Area"),
    btn_WareHouseMoney = UI.getChildControl(_panel, "RadioButton_WareHouseMoney"),
    btn_MyInvenMoney = UI.getChildControl(_panel, "RadioButton_MyInvenMoney")
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
    slotGapY = 53
  },
  _slotInvenBgData = {},
  _slotInvenItemData = {},
  _newItemData = nil,
  _startInvenSlotIndex = 0,
  _isAblePearlProduct = false,
  _moneySlot = 0,
  _currentInvenType = 0,
  _currentRegionKey = 0,
  _filterText = "",
  _searchItemEffect = {},
  _searchItemEffectOff = {},
  _searchFilterAlpha = 0.5
}
function PaGlobalFunc_MarketPlace_GetWareHouseCheck()
  local self = MarketPlace_MyInven
  return self._currentInvenType == CppEnums.ItemWhereType.eWarehouse
end
function PaGlobalFunc_MarketPlace_MyInven_Init()
  local self = MarketPlace_MyInven
  self:initData()
  self:initControl()
  self:initEvent()
end
function MarketPlace_MyInven:initControl()
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Win_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_Title, "Button_Question")
  self._ui.checkBtn_PopUp = UI.getChildControl(self._ui.stc_Title, "CheckButton_PopUp")
  self._ui.checkBtn_ItemSort = UI.getChildControl(self._ui.stc_TopBg, "CheckButton_ItemSort")
  self._ui.txt_Capacity = UI.getChildControl(self._ui.stc_TopBg, "Static_Text_Capacity")
  local searchBg = UI.getChildControl(self._ui.stc_TopBg, "Static_Search_BG")
  self._ui.edit_Search = UI.getChildControl(searchBg, "Edit_GoodsName")
  self._ui.txt_DefaultSearchText = UI.getChildControl(searchBg, "StaticText_DefaultSearchText")
  self._ui.btn_searchReset = UI.getChildControl(searchBg, "Button_SearchReset")
  self._ui.progress_Weight = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Weight")
  self._ui.progress_Equipment = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Equipment")
  self._ui.progress_Money = UI.getChildControl(self._ui.stc_WeightBg, "Progress2_Money")
  self._ui.txt_MoneyTitle = UI.getChildControl(self._ui.btn_Deposit, "StaticText_MoneyTitle")
  self._ui.txt_MoneyValue = UI.getChildControl(self._ui.btn_Deposit, "StaticText_MoneyValue")
  self._ui.txt_Weight = UI.getChildControl(self._ui.stc_WeightBg, "StaticText_Weight")
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    slot.base = UI.createAndCopyBasePropertyControl(_panel, "Template_Static_Slot", _panel, "MarketWallet_Inventory_EmptySlot_" .. slotIdx)
    slot.lock = UI.createAndCopyBasePropertyControl(_panel, "Template_Static_LockSlot", _panel, "MarketWallet_Inventory_LockSlot_" .. slotIdx)
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    local lockGapX = slot.base:GetSizeX() / 2 - slot.lock:GetSizeX() / 2
    local lockGapY = slot.base:GetSizeY() / 2 - slot.lock:GetSizeY() / 2
    slot.base:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
    slot.base:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
    slot.lock:SetPosXY(slot.base:GetPosX() + lockGapX, slot.base:GetPosY() + lockGapY)
    slot.base:SetShow(true)
    slot.lock:SetShow(false)
    UIScroll.InputEventByControl(slot.base, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
    self._slotInvenBgData[slotIdx] = slot
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "MyInventoryItem_" .. slotIdx, slotIdx, _panel, self._slotConfig)
    slot:createChild()
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 2)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 2)
    slot.icon:SetEnableDragAndDrop(false)
    slot.icon:SetAutoDisableTime(0.5)
    UIScroll.InputEventByControl(slot.icon, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
    self._slotInvenItemData[slotIdx] = slot
  end
  self._ui.checkBtn_ItemSort:SetText(self._ui.checkBtn_ItemSort:GetText())
  self._ui.checkBtn_ItemSort:SetEnableArea(0, 0, self._ui.checkBtn_ItemSort:GetSizeX() + self._ui.checkBtn_ItemSort:GetTextSizeX() + 10, 25)
end
function MarketPlace_MyInven:initData()
  self._isAblePearlProduct = requestCanRegisterPearlItemOnMarket()
  self._moneySlot = getMoneySlotNo()
  self._config.slotRows = self._config.slotCount / self._config.slotCols
  self._maxSlotRow = math.floor((self._config.slotCount - 1) / self._config.slotCols)
  self._config.slotStartX = self._ui.template_Slot:GetPosX()
  self._config.slotStartY = self._ui.template_Slot:GetPosY()
end
function MarketPlace_MyInven:initEvent()
  UIScroll.InputEvent(self._ui.scroll_CashInven, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
  UIScroll.InputEventByControl(self._ui.stc_ScrollArea, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
  self._ui.checkBtn_ItemSort:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_MyInven_CheckSort()")
  self._ui.btn_Deposit:addInputEvent("Mouse_LUp", "InputMRUp_MarketWallet_RegisterMoney()")
  self._ui.btn_Deposit:addInputEvent("Mouse_On", "MarketWallet_DepositMoney_TooltipShow()")
  self._ui.btn_Deposit:addInputEvent("Mouse_Out", "MarketWallet_DepositMoney_TooltipHide()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_MyInven_Close()")
  self._ui.btn_NormalInven:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_SelectTab(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui.btn_CashInven:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_SelectTab(" .. CppEnums.ItemWhereType.eCashInventory .. ")")
  self._ui.btn_WareHouseInven:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_SelectTab(" .. CppEnums.ItemWhereType.eWarehouse .. ")")
  self._ui.edit_Search:addInputEvent("Mouse_LDown", "PaGlobalFunc_MarketPlace_SetFocusSearchText()")
  self._ui.edit_Search:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_SetFocusSearchText()")
  self._ui.edit_Search:RegistReturnKeyEvent("PaGlobalFunc_MarketPlace_SearchItem()")
  self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_MyInven_ClearFocusSearch()")
  self._ui.btn_searchReset:addInputEvent("Mouse_On", "HandleEventOnOut_MarketPlace_MyInven_SearchResetTooltip(true)")
  self._ui.btn_searchReset:addInputEvent("Mouse_Out", "HandleEventOnOut_MarketPlace_MyInven_SearchResetTooltip(false)")
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_MarketPlace_MyInven_Update")
  registerEvent("FromClient_requestPopFromMarketWallet", "FromClient_MarketPlace_MyInven_PopItem")
end
function MarketWallet_DepositMoney_TooltipShow()
  local uiControl = MarketPlace_MyInven._ui.btn_Deposit
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_DEPOSITMONEY_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_DEPOSITMONEY_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function MarketWallet_DepositMoney_TooltipHide()
  TooltipSimple_Hide()
end
function PaGlobalFunc_MarketPlace_MyInven_CheckMoney()
  local self = MarketPlace_MyInven
  self:update()
end
function PaGlobalFunc_MarketPlace_MyInven_CheckSort()
  local self = MarketPlace_MyInven
  local isSortChecked = MarketPlace_MyInven._ui.checkBtn_ItemSort:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eMarketPlaceInventorySort, isSortChecked, CppEnums.VariableStorageType.eVariableStorageType_User)
  MarketPlace_MyInven:deleteNewItemEffect()
  self:update()
end
function PaGlobalFunc_MarketPlace_SetFocusSearchText()
  SetFocusEdit(MarketPlace_MyInven._ui.edit_Search)
  MarketPlace_MyInven._ui.txt_DefaultSearchText:SetShow(false)
end
function PaGlobalFunc_MarketPlace_ClearFocusSearchText()
  ClearFocusEdit()
  MarketPlace_MyInven._ui.edit_Search:SetEditText("")
  MarketPlace_MyInven._filterText = ""
  MarketPlace_MyInven._ui.txt_DefaultSearchText:SetShow(true)
  MarketPlace_MyInven._ui.btn_searchReset:SetShow(false)
  TooltipSimple_Hide()
  MarketPlace_MyInven._searchItemEffectOff = {}
end
function PaGlobalFunc_MarketPlace_MyInven_ClearFocusSearch()
  PaGlobalFunc_MarketPlace_ClearFocusSearchText()
  MarketPlace_MyInven:findSearchItem(true)
end
function PaGlobalFunc_MarketPlace_SearchItem()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  MarketPlace_MyInven._filterText = MarketPlace_MyInven._ui.edit_Search:GetEditText()
  local isReScanSearch = MarketPlace_MyInven:findSearchItem(true)
  if true == isReScanSearch then
    MarketPlace_MyInven:reScanSearchItem()
  end
end
function MarketPlace_MyInven:findSearchItem(isSearch)
  local isEmptyText = nil == self._filterText or "" == self._filterText or self._filterText:len() <= 0
  if false == isSearch and true == isEmptyText then
    return false
  end
  local invenCapacity = 0
  local warehouseWrapper
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
  if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
    warehouseWrapper = warehouse_get(getCurrentWaypointKey())
    if nil == warehouseWrapper then
      return false
    end
    local useStartSlot = 1
    local useMaxCount = warehouseWrapper:getUseMaxCount()
    invenCapacity = useMaxCount - useStartSlot
  else
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return false
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return false
    end
    local invenUseSize = selfPlayer:getInventorySlotCount(CppEnums.ItemWhereType.eInventory ~= self._currentInvenType)
    local useStartSlot = __eTInventorySlotNoUseStart
    invenCapacity = invenUseSize - useStartSlot
  end
  local isSearchFind = false
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotInvenItemData[slotIdx]
    if nil ~= slot and nil ~= slot.icon and nil ~= slot.slotNo then
      if true == isSearch then
        slot.icon:EraseAllEffect()
        if true == isEmptyText then
          local itemWrapper
          if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
            itemWrapper = warehouseWrapper:getItem(slot.slotNo)
          else
            itemWrapper = getInventoryItemByType(self._currentInvenType, slot.slotNo)
          end
          if nil ~= itemWrapper and false == self:marketFilter(slot.slotNo, itemWrapper, self._currentInvenType) then
            slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
            slot.icon:SetAlpha(1)
          end
        end
      end
      if false == isEmptyText and invenCapacity > slotIdx + self._startInvenSlotIndex then
        local isEffectOn = false
        local isFiltered = false
        if nil == self._searchItemEffectOff[slot.slotNo] then
          local itemWrapper
          if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
            itemWrapper = warehouseWrapper:getItem(slot.slotNo)
          else
            itemWrapper = getInventoryItemByType(self._currentInvenType, slot.slotNo)
          end
          if nil ~= itemWrapper then
            isFiltered = self:marketFilter(slot.slotNo, itemWrapper, self._currentInvenType)
            local itemSSW = itemWrapper:getStaticStatus()
            if false == isFiltered and nil ~= itemSSW then
              local itemName = itemSSW:getName()
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
            if true == isFiltered then
              slot.icon:SetAlpha(0.5)
            else
              slot.icon:SetAlpha(self._searchFilterAlpha)
            end
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
function MarketPlace_MyInven:reScanSearchItem()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local useStartSlot = 0
  local invenUseSize = 0
  local invenMaxSize = 0
  local warehouseWrapper, sortFunc
  if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
    warehouseWrapper = warehouse_get(getCurrentWaypointKey())
    if nil == warehouseWrapper then
      return
    end
    invenUseSize = warehouseWrapper:getUseMaxCount()
    useStartSlot = 1
    invenMaxSize = warehouseWrapper:getMaxCount() - useStartSlot
    sortFunc = PaGlobalFunc_MarketPlace_MyInven_WarehouseComparer
  else
    local inventory = selfPlayer:getInventoryByType(self._currentInvenType)
    if nil == inventory then
      return
    end
    local isCashInven = CppEnums.ItemWhereType.eInventory ~= self._currentInvenType
    invenUseSize = selfPlayer:getInventorySlotCount(isCashInven)
    useStartSlot = __eTInventorySlotNoUseStart
    invenMaxSize = inventory:sizeXXX() - useStartSlot
    sortFunc = PaGlobalFunc_MarketPlace_MyInven_ItemComparer
  end
  local invenCapacity = invenUseSize - useStartSlot
  local intervalSlotIndex = invenMaxSize - self._config.slotCount
  local isSearchFind = false
  local startSlot = 0
  local minSlotIndex = self._config.slotCount - self._config.slotCols * 4
  local maxSlotIndex = intervalSlotIndex + self._config.slotCols * 3
  local isSorted = self._ui.checkBtn_ItemSort:IsCheck()
  local slotNoList = Array.new()
  if true == isSorted then
    slotNoList:fill(useStartSlot, invenMaxSize - 1)
    local sortList = Array.new()
    sortList:fill(useStartSlot, invenUseSize - 1)
    sortList:quicksort(sortFunc)
    for ii = 1, invenUseSize - useStartSlot do
      slotNoList[ii] = sortList[ii]
    end
  end
  for ii = useStartSlot, invenCapacity - 1 do
    local slotNo = ii
    if true == isSorted then
      slotNo = slotNoList[ii + 1]
    end
    if nil ~= slotNo then
      local itemWrapper
      if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
        itemWrapper = warehouseWrapper:getItem(slotNo)
      else
        itemWrapper = getInventoryItemByType(self._currentInvenType, slotNo)
      end
      if nil ~= itemWrapper and false == self:marketFilter(slotNo, itemWrapper, self._currentInvenType) then
        local itemSSW = itemWrapper:getStaticStatus()
        if nil ~= itemSSW then
          local itemName = itemSSW:getName()
          if true == stringSearch(itemName, self._filterText) then
            if minSlotIndex >= ii then
              startSlot = 0
            elseif maxSlotIndex < ii then
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
  end
  if true == isSearchFind then
    local curSlotIndex = startSlot / self._config.slotCols
    local maxSlotIndex = intervalSlotIndex / self._config.slotCols
    local scrollPos = math.max(math.min(curSlotIndex / maxSlotIndex, 1), 0)
    self._ui.scroll_CashInven:SetControlPos(scrollPos)
    self._startInvenSlotIndex = startSlot
    PaGlobalFunc_MarketPlace_MyInven_Update()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
  end
end
function HandleEventOnOut_MarketPlace_MyInven_SearchResetTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl = MarketPlace_MyInven._ui.btn_searchReset
  if nil == uiControl then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEARCHRESET")
  local desc = ""
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobalFunc_MarketPlace_MyInven_Scroll(isUp)
  local self = MarketPlace_MyInven
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Panel_Window_MarketPlace_MyInventory")
    return
  end
  if true == PaGlobal_TutorialPhase_IsTutorial() then
    return
  end
  local useStartSlot = __eTInventorySlotNoUseStart
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(self._currentInvenType)
  local maxSize = inventory:sizeXXX() - useStartSlot
  local prevSlotIndex = self._startInvenSlotIndex
  self._startInvenSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_CashInven, isUp, self._config.slotRows, maxSize, self._startInvenSlotIndex, self._config.slotCols)
  local intervalSlotIndex = 128
  if prevSlotIndex == 0 and self._startInvenSlotIndex == 0 or prevSlotIndex == intervalSlotIndex and self._startInvenSlotIndex == intervalSlotIndex then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  MarketPlace_MyInven:deleteNewItemEffect()
  self:update()
end
function PaGlobalFunc_MarketPlace_MyInven_Update()
  if false == _panel:GetShow() then
    return
  end
  local self = MarketPlace_MyInven
  self:update()
  self:findSearchItem(true)
end
function PaGlobalFunc_MarketPlace_SelectTab(tabIdx)
  local self = MarketPlace_MyInven
  self._currentInvenType = tabIdx
  self._ui.btn_NormalInven:SetCheck(tabIdx == CppEnums.ItemWhereType.eInventory)
  self._ui.btn_CashInven:SetCheck(tabIdx == CppEnums.ItemWhereType.eCashInventory)
  self._ui.btn_WareHouseInven:SetCheck(tabIdx == CppEnums.ItemWhereType.eWarehouse)
  self._ui.scroll_CashInven:SetControlPos(0)
  self._startInvenSlotIndex = 0
  if tabIdx == CppEnums.ItemWhereType.eWarehouse then
    self:setForWareHouse()
    self._ui.stc_WeightBg:SetShow(false)
  else
    self._ui.stc_WeightBg:SetShow(true)
  end
  PaGlobalFunc_MarketPlace_ClearFocusSearchText()
  self:update()
end
function MarketPlace_MyInven:setForWareHouse()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    _PA_ASSERT(false, "\236\167\128\236\151\173 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Panel_Window_MarketPlaceWallet")
    return
  end
  local myAffiliatedTownRegionKey = regionInfo:getAffiliatedTownRegionKey()
  local regionInfoWrapper = getRegionInfoWrapper(myAffiliatedTownRegionKey)
  if ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) == false then
    local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
    if newRegionInfo == nil then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WALLETMANAGER_NO_REGION_WAREHOUSE"))
      return
    end
    myAffiliatedTownRegionKey = newRegionInfo:getRegionKey()
    if 0 == myAffiliatedTownRegionKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_WALLETMANAGER_NO_REGION_WAREHOUSE"))
      return
    end
  end
  self._currentRegionKey = myAffiliatedTownRegionKey
end
function PaGlobalFunc_MarketPlace_GetMyInvenTab()
  local self = MarketPlace_MyInven
  return self._currentInvenType
end
function PaGlobalFunc_MarketPlace_MyInven_GetMoney()
  local self = MarketPlace_MyInven
  local moneyValue = 0
  if false == PaGlobalFunc_MarketPlace_GetWareHouseCheck() then
    moneyValue = getSelfPlayer():get():getInventory():getMoney_s64()
  else
    moneyValue = warehouse_moneyFromNpcShop_s64()
  end
  return moneyValue
end
function PaGlobalFunc_MarketPlace_MyInven_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, getInventoryItemByType, PaGlobalFunc_MarketPlace_GetMyInvenTab())
end
function PaGlobalFunc_MarketPlace_MyInven_WarehouseComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem)
end
function PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem(slotNo)
  local warehouseWrapper = warehouse_get(getCurrentWaypointKey())
  if nil == warehouseWrapper then
    return nil
  end
  return (warehouseWrapper:getItem(slotNo))
end
function MarketPlace_MyInven:update()
  if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
    self:updateWareHouseInventory()
  else
    self:updateInventory()
  end
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local moneyValue, moneyTitle
  if false == PaGlobalFunc_MarketPlace_GetWareHouseCheck() then
    moneyTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_MYINVENTORY_HAS_INVEN_MONEY")
    moneyValue = makeDotMoney(selfPlayer:getInventory():getMoney_s64())
  else
    moneyTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_MYINVENTORY_HAS_WAREHOUSE_MONEY")
    if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
      moneyValue = makeDotMoney(PaGlobalFunc_MarketPlace_GetWareHouseMoneyFromMaid())
    else
      moneyValue = makeDotMoney(warehouse_moneyFromNpcShop_s64())
    end
  end
  self._ui.txt_MoneyTitle:SetText(moneyTitle)
  self._ui.txt_MoneyValue:SetText(moneyValue)
  local normalInventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local _const = Defines.s64_const
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local s64_moneyWeight = normalInventory:getMoneyWeight_s64()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight_div = s64_allWeight / _const.s64_100
  local s64_maxWeight_div = s64_maxWeight / _const.s64_100
  local str_AllWeight = makeWeightString(s64_allWeight, 1)
  local str_MaxWeight = makeWeightString(s64_maxWeight, 0)
  if Int64toInt32(s64_allWeight) <= Int64toInt32(s64_maxWeight) then
    self._ui.progress_Money:SetProgressRate(Int64toInt32(s64_moneyWeight / s64_maxWeight_div))
    self._ui.progress_Weight:SetProgressRate(Int64toInt32(s64_allWeight / s64_maxWeight_div))
  else
    self._ui.progress_Money:SetProgressRate(Int64toInt32(s64_moneyWeight / s64_allWeight_div))
    self._ui.progress_Weight:SetProgressRate(Int64toInt32(s64_allWeight / s64_allWeight_div))
  end
  self._ui.txt_Weight:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
end
function MarketPlace_MyInven:updateInventory()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local invenUseSize = selfPlayer:getInventorySlotCount(CppEnums.ItemWhereType.eInventory ~= self._currentInvenType)
  local useStartSlot = __eTInventorySlotNoUseStart
  local inventory = selfPlayer:getInventoryByType(self._currentInvenType)
  local invenMaxSize = inventory:sizeXXX()
  local freeCount = inventory:getFreeCount()
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, invenMaxSize - 1)
  if true == self._ui.checkBtn_ItemSort:IsCheck() then
    local sortList = Array.new()
    sortList:fill(useStartSlot, invenUseSize - 1)
    sortList:quicksort(PaGlobalFunc_MarketPlace_MyInven_ItemComparer)
    for ii = 1, invenUseSize - 2 do
      slotNoList[ii] = sortList[ii]
    end
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slotBg = self._slotInvenBgData[slotIdx]
    if nil ~= slotBg then
      slotBg.base:EraseAllEffect()
    end
  end
  local invenCapacity = invenUseSize - useStartSlot
  self._ui.txt_Capacity:SetText(tostring(invenUseSize - freeCount - useStartSlot) .. "/" .. tostring(invenUseSize - useStartSlot))
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotInvenItemData[slotIdx]
    local slotBg = self._slotInvenBgData[slotIdx]
    local slotNo = slotNoList[slotIdx + 1 + self._startInvenSlotIndex]
    slot:clearItem()
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    slot.icon:addInputEvent("Mouse_RUp", "")
    if invenCapacity > slotIdx + self._startInvenSlotIndex then
      local itemWrapper = getInventoryItemByType(self._currentInvenType, slotNo)
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo)
        slot.isEmpty = false
        local isFiltered = self:marketFilter(slotNo, itemWrapper, self._currentInvenType)
        slot.icon:SetMonoTone(isFiltered)
        slot.icon:SetIgnore(isFiltered)
        slot.icon:EraseAllEffect()
        if true == isFiltered then
          slot.icon:SetAlpha(0.5)
        else
          slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          if false == PaGlobal_TutorialPhase_IsTutorial() then
            slot.icon:addInputEvent("Mouse_RUp", "InputMRUp_MarketWallet_MoveInvenToWallet(" .. slotNo .. ")")
          end
          slot.icon:SetAlpha(1)
        end
        if false == PaGlobal_TutorialPhase_IsTutorial() then
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_MyInven_ShowToolTip(" .. self._currentInvenType .. "," .. slotNo .. "," .. slotIdx .. ")")
          slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        end
        local isSoulCollector = itemWrapper:isSoulCollector()
        local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
        local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
        local itemSSW = itemWrapper:getStaticStatus()
        if nil ~= itemSSW then
          local itemIconPath = itemSSW:getIconPath()
          if isSoulCollector then
            slot.icon:ChangeTextureInfoName("icon/" .. itemIconPath)
            if 0 == isCurrentSoulCount then
              slot.icon:ChangeTextureInfoName("icon/" .. itemIconPath)
            end
            if isCurrentSoulCount > 0 then
              slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
            end
            if isCurrentSoulCount == isMaxSoulCount then
              slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
            end
            local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
            slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
            slot.icon:setRenderTexture(slot.icon:getBaseTexture())
          end
          if false == isFiltered and nil ~= self._filterText and 0 < self._filterText:len() then
            slot.icon:EraseAllEffect()
            local itemName = itemSSW:getName()
            if true == stringSearch(itemName, self._filterText) then
              if nil == self._searchItemEffectOff[slot.slotNo] then
                self._searchItemEffect[slot.slotNo] = slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
              end
            else
              slot.icon:SetAlpha(self._searchFilterAlpha)
            end
          end
          local itemKey = itemSSW:get()._key
          if nil ~= self._newItemData and self._newItemData._whereType == self._currentInvenType and nil == self._newItemData._slotNo and nil ~= self._newItemData._itemKey and self._newItemData._itemKey == itemKey:get() then
            self._newItemData._slotNo = slotIdx
          end
        end
      else
        slot.isEmpty = true
      end
      slotBg.lock:SetShow(false)
    else
      slotBg.lock:SetShow(true)
    end
  end
  MarketPlace_MyInven:applyNewItemEffect(false)
  UIScroll.SetButtonSize(self._ui.scroll_CashInven, self._config.slotCount, invenMaxSize - useStartSlot)
end
function MarketPlace_MyInven:updateWareHouseInventory()
  local warehouseWrapper = warehouse_get(getCurrentWaypointKey())
  if nil == warehouseWrapper then
    return
  end
  local useStartSlot = 1
  local itemCount = warehouseWrapper:getSize()
  local useMaxCount = warehouseWrapper:getUseMaxCount()
  local freeCount = warehouseWrapper:getFreeCount()
  local money_s64 = warehouseWrapper:getMoney_s64()
  local maxCount = warehouseWrapper:getMaxCount()
  local invenCapacity = useMaxCount - useStartSlot
  self._ui.txt_Capacity:SetText(tostring(useMaxCount - freeCount - useStartSlot) .. "/" .. tostring(useMaxCount - useStartSlot))
  local slotNoList = Array.new()
  slotNoList:fill(useStartSlot, maxCount - 1)
  if true == self._ui.checkBtn_ItemSort:IsCheck() then
    local sortList = Array.new()
    sortList:fill(useStartSlot, useMaxCount - 1)
    sortList:quicksort(PaGlobalFunc_MarketPlace_MyInven_WarehouseComparer)
    for ii = 1, useMaxCount - 1 do
      slotNoList[ii] = sortList[ii]
    end
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slotBg = self._slotInvenBgData[slotIdx]
    if nil ~= slotBg then
      slotBg.base:EraseAllEffect()
    end
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotInvenItemData[slotIdx]
    local slotBg = self._slotInvenBgData[slotIdx]
    local slotNo = slotNoList[slotIdx + 1 + self._startInvenSlotIndex]
    slot:clearItem()
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    slot.icon:addInputEvent("Mouse_RUp", "")
    local itemExist = false
    local itemWrapper = warehouseWrapper:getItem(slotNo)
    if invenCapacity > slotIdx + self._startInvenSlotIndex then
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo, nil, warehouseWrapper)
        slot.isEmpty = false
        local isFiltered = self:marketFilter(slotNo, itemWrapper, self._currentInvenType)
        slot.icon:SetMonoTone(isFiltered)
        slot.icon:SetIgnore(isFiltered)
        slot.icon:EraseAllEffect()
        if true == isFiltered then
          slot.icon:SetAlpha(0.5)
        else
          slot.icon:AddEffect("UI_Inventory_Filtering", true, 0, 0)
          if false == PaGlobal_TutorialPhase_IsTutorial() then
            slot.icon:addInputEvent("Mouse_RUp", "InputMRUp_MarketWallet_MoveInvenToWallet(" .. slotNo .. ")")
          end
          slot.icon:SetAlpha(1)
        end
        if false == PaGlobal_TutorialPhase_IsTutorial() then
          slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_MyInven_ShowToolTip(" .. self._currentInvenType .. "," .. slotNo .. "," .. slotIdx .. ")")
          slot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
        end
        local isSoulCollector = itemWrapper:isSoulCollector()
        local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
        local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
        local itemSSW = itemWrapper:getStaticStatus()
        if nil ~= itemSSW then
          local itemIconPath = itemSSW:getIconPath()
          if isSoulCollector then
            slot.icon:ChangeTextureInfoName("icon/" .. itemIconPath)
            if 0 == isCurrentSoulCount then
              slot.icon:ChangeTextureInfoName("icon/" .. itemIconPath)
            end
            if isCurrentSoulCount > 0 then
              slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_1.dds")
            end
            if isCurrentSoulCount == isMaxSoulCount then
              slot.icon:ChangeTextureInfoName("New_UI_Common_forLua/ExceptionIcon/00040351_2.dds")
            end
            local x1, y1, x2, y2 = setTextureUV_Func(slot.icon, 0, 0, 42, 42)
            slot.icon:getBaseTexture():setUV(x1, y1, x2, y2)
            slot.icon:setRenderTexture(slot.icon:getBaseTexture())
          end
          if nil ~= self._filterText and 0 < self._filterText:len() then
            slot.icon:EraseAllEffect()
            if nil == self._searchItemEffectOff[slot.slotNo] or false == self._searchItemEffectOff[slot.slotNo] then
              local itemName = itemSSW:getName()
              if true == stringSearch(itemName, self._filterText) then
                self._searchItemEffect[slot.slotNo] = slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
              end
            end
          end
          local itemKey = itemSSW:get()._key
          slotBg.base:EraseAllEffect()
          if nil ~= self._newItemData and self._newItemData._whereType == self._currentInvenType and nil == self._newItemData._slotNo and nil ~= self._newItemData._itemKey and self._newItemData._itemKey == itemKey:get() then
            self._newItemData._slotNo = slotIdx
          end
        end
      else
        slot.isEmpty = true
      end
      slotBg.lock:SetShow(false)
    else
      slotBg.lock:SetShow(true)
    end
  end
  MarketPlace_MyInven:applyNewItemEffect(true)
end
function MarketPlace_MyInven:marketFilter(slotNo, itemWrapper, invenWhereType)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return true
  end
  local isOriginalForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == isOriginalForDuel then
    return true
  end
  local isAble = requestIsRegisterItemForItemMarket(itemWrapper:get():getKey())
  local itemBindType = itemWrapper:getStaticStatus():get()._vestedType:getItemKey()
  local isVested = itemWrapper:get():isVested()
  local isPersonalTrade = itemWrapper:getStaticStatus():isPersonalTrade()
  if isUsePcExchangeInLocalizingValue() then
    local isFilter = isVested and isPersonalTrade
    if isFilter then
      return isFilter
    end
  end
  if true == isAble then
    if ToClient_Inventory_CheckItemLock(slotNo, invenWhereType) then
      isAble = false
    else
      isAble = true
    end
  end
  if 2 == itemBindType then
    if true ~= itemWrapper:get():isVested() and isAble then
      isAble = true
    else
      isAble = false
    end
  end
  if itemWrapper:isCash() then
    if false == isAble and false == self._isAblePearlProduct then
      isAble = false
    else
      isAble = isAble and self._isAblePearlProduct
    end
  end
  return not isAble
end
function PaGlobalFunc_MarketPlace_MyInven_ShowToolTip(whereType, slotNo, slotIdx)
  local self = MarketPlace_MyInven
  local slot = self._slotInvenItemData[slotIdx]
  if nil == slot then
    return
  end
  if nil ~= self._searchItemEffect[slotNo] then
    self._searchItemEffectOff[slotNo] = true
    slot.icon:EraseEffect(self._searchItemEffect[slotNo])
    self._searchItemEffect[slotNo] = nil
  end
  local self = MarketPlace_MyInven
  if nil ~= self._newItemData and nil ~= self._newItemData._effectId and nil ~= self._newItemData._slotNo and nil ~= self._slotInvenBgData then
    local savedSlotBgIdx = self._newItemData._slotNo
    if nil ~= self._slotInvenBgData[savedSlotBgIdx] and savedSlotBgIdx == slotIdx then
      local slotBg = self._slotInvenBgData[savedSlotBgIdx]
      slotBg.base:EraseEffect(self._newItemData._effectId)
      self._newItemData = nil
    end
  end
  local itemWrapper
  if whereType == CppEnums.ItemWhereType.eWarehouse then
    local warehouseWrapper = warehouse_get(getCurrentWaypointKey())
    if nil == warehouseWrapper then
      return
    end
    itemWrapper = warehouseWrapper:getItem(slotNo)
  else
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, _panel, false, true, nil, nil, nil, slotNo)
end
function PaGlobalFunc_MarketPlace_MyInven_Open(isWaretype)
  local self = MarketPlace_MyInven
  self._ui.scroll_CashInven:SetControlPos(0)
  self._startInvenSlotIndex = 0
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = _panel:GetSizeX()
  local panelSizeY = _panel:GetSizeY()
  _panel:SetPosX(scrSizeX / 2 - panelSizeX / 2 - panelSizeX / 2)
  _panel:SetPosY(scrSizeY / 2 - panelSizeY / 2)
  if _panel:GetPosY() < 10 then
    _panel:SetPosY(10)
  end
  local isSortChecked = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eMarketPlaceInventorySort)
  self._ui.checkBtn_ItemSort:SetCheck(isSortChecked)
  PaGlobalFunc_MarketPlace_ClearFocusSearchText()
  self:open()
  if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
    self._ui.btn_WareHouseInven:SetShow(false)
  else
    self._ui.btn_WareHouseInven:SetShow(true)
  end
  if CppEnums.ItemWhereType.eWarehouse == isWaretype then
    PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eWarehouse)
    if _ContentsGroup_NewUI_WareHouse_All then
      if nil ~= Panel_Window_ServantInventory and true == Panel_Window_ServantInventory:GetShow() then
        ServantInventory_Close()
      end
      PaGlobal_Warehouse_All_Close()
    else
      Warehouse_Close()
    end
    PaGlobalFunc_MarketPlace_WalletInven_HideButton(true)
  else
    PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eInventory)
    PaGlobalFunc_MarketPlace_WalletInven_HideButton(false)
  end
end
function PaGlobalFunc_MarketPlace_MyInven_Close()
  local self = MarketPlace_MyInven
  if true == Panel_Window_MarketPlace_TutorialSelect:GetShow() then
    PaGlobal_MarketPlaceTutorialSelect:prepareClose()
    return
  end
  if false == PaGlobalFunc_MarketPlace_MyInven_GetShow() then
    return
  end
  PaGlobalFunc_MarketPlace_ClearFocusSearchText()
  self:close()
  if true == _ContentsGroup_NewUI_Dialog_All and nil ~= Panel_Window_MarketPlace_Function and false == Panel_Window_MarketPlace_Function:GetShow() and nil ~= Panel_Window_MarketPlace_WalletInventory and false == Panel_Window_MarketPlace_WalletInventory:GetShow() then
    PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  end
  if false == PaGlobalFunc_MarketPlace_WalletInven_GetShow() then
    PaGlobalFunc_MarketWallet_Close()
  end
end
function MarketPlace_MyInven:open()
  _panel:SetShow(true)
end
function MarketPlace_MyInven:close()
  _panel:SetShow(false)
end
function PaGlobalFunc_MarketPlace_MyInven_GetShow()
  return _panel:GetShow()
end
function PaGlobal_MarketPlace_MyInven_GetPanel()
  return _panel
end
function MarketPlace_MyInven:deleteNewItemEffect()
  if nil ~= self._newItemData and nil ~= self._newItemData._effectId and nil ~= self._newItemData._slotNo and nil ~= self._slotInvenBgData then
    local savedSlotBgIdx = self._newItemData._slotNo
    if nil ~= self._slotInvenBgData[savedSlotBgIdx] then
      local slotBg = self._slotInvenBgData[savedSlotBgIdx]
      slotBg.base:EraseAllEffect()
      self._newItemData = nil
    end
  end
end
function MarketPlace_MyInven:applyNewItemEffect(isWareHouse)
  if nil ~= self._newItemData and self._newItemData._whereType == self._currentInvenType and nil ~= self._newItemData._slotNo then
    local savedSlotBgIdx = self._newItemData._slotNo
    if nil ~= self._newItemData._itemKey and nil ~= self._slotInvenBgData[savedSlotBgIdx] and nil ~= self._slotInvenItemData[savedSlotBgIdx] then
      if false == self._slotInvenItemData[savedSlotBgIdx].isEmpty then
        local itemWrapper
        if true == isWareHouse then
          local warehouseWrapper = warehouse_get(getCurrentWaypointKey())
          if nil == warehouseWrapper then
            return
          end
          itemWrapper = warehouseWrapper:getItem(self._slotInvenItemData[savedSlotBgIdx].slotNo)
        else
          itemWrapper = getInventoryItemByType(self._currentInvenType, self._slotInvenItemData[savedSlotBgIdx].slotNo)
        end
        if nil == itemWrapper then
          return
        end
        local itemSSW = itemWrapper:getStaticStatus()
        if nil == itemSSW then
          return
        end
        local itemKey = itemSSW:get()._key
        if self._newItemData._itemKey == itemKey:get() then
          self._newItemData._effectId = self._slotInvenBgData[savedSlotBgIdx].base:AddEffect("fUI_NewItem02", true, 0, 0)
        else
          self._slotInvenBgData[savedSlotBgIdx].base:EraseEffect()
        end
      else
        self._slotInvenBgData[savedSlotBgIdx].base:EraseEffect()
      end
    end
  end
end
function FromClient_MarketPlace_MyInven_PopItem(itemKey64, enchantLevel64, whereType)
  local TItemKey = tonumber(tostring(itemKey64))
  local TEnchantLevel = tonumber(tostring(enchantLevel64))
  local itemEnchantKey = ItemEnchantKey()
  itemEnchantKey:set(TItemKey, TEnchantLevel)
  if false == itemEnchantKey:isDefined() then
    return
  end
  MarketPlace_MyInven:deleteNewItemEffect()
  local tempTable = {
    _itemKey = itemEnchantKey:get(),
    _whereType = whereType,
    _effectId = nil,
    _slotNo = nil
  }
  if tempTable._whereType == CppEnums.ItemWhereType.eInventory then
    local itemStaticStatusWrapper = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemStaticStatusWrapper then
      local itemSimplySSW = itemStaticStatusWrapper:get()
      if nil ~= itemSimplySSW then
        local isCash = itemSimplySSW:isCash()
        if true == isCash then
          tempTable._whereType = CppEnums.ItemWhereType.eCashInventory
        end
      end
    end
  end
  MarketPlace_MyInven._newItemData = tempTable
end
