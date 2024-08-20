local mainPanel = Panel_Window_MarketPlace_Main
local manageBg = UI.getChildControl(mainPanel, "Static_ManageMentBg")
local myInvenBg = UI.getChildControl(manageBg, "Static_RightBg")
local _panel = myInvenBg
local UI_color = Defines.Color
local MarketPlace_MyInven = {
  _ui = {
    btn_NormalInven = UI.getChildControl(_panel, "RadioButton_Inven"),
    btn_CashInven = UI.getChildControl(_panel, "RadioButton_PearlInven"),
    btn_WareHouse = UI.getChildControl(_panel, "RadioButton_WareHouse"),
    stc_ButtonGroup = UI.getChildControl(_panel, "Static_ButtonGroup"),
    stc_ItemListGroup = UI.getChildControl(_panel, "Static_ItemListGroup"),
    stc_keyguideLT = UI.getChildControl(_panel, "Button_1"),
    stc_keyguideRT = UI.getChildControl(_panel, "Button_2"),
    btn_AConsoleUI = UI.getChildControl(_panel, "Button_A_ConsoleUI"),
    txt_Weight = UI.getChildControl(_panel, "StaticText_WeightIcon")
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
  _moneyType = {inven = 0, wareHouse = 1},
  _slotInvenBgData = {},
  _slotInvenItemData = {},
  _startInvenSlotIndex = 0,
  _isAblePearlProduct = false,
  _moneySlot = 0,
  _ENUM_INVENTYPE = {
    Inventory = 1,
    Pearl = 2,
    Warehouse = 3,
    Count = 4
  },
  _ENUM_INVENTYPE_TO_CPPENUM = {
    [1] = CppEnums.ItemWhereType.eInventory,
    [2] = CppEnums.ItemWhereType.eCashInventory,
    [3] = CppEnums.ItemWhereType.eWarehouse
  },
  _tabControl = {},
  _usingTabCount = 2,
  _currentTab = 1,
  _currentInvenType = 0,
  _isWareHouseCheck = false,
  _currnetSlotIdx = 0,
  _currentSlotNo = -1
}
function PaGlobalFunc_MarketPlace_GetWareHouseCheck()
  local self = MarketPlace_MyInven
  return self._isWareHouseCheck
end
function PaGlobalFunc_MarketPlace_MyInven_Init()
  local self = MarketPlace_MyInven
  self:initControl()
  self:initEvent()
end
function MarketPlace_MyInven:initControl()
  self._ui.template_Slot = UI.getChildControl(self._ui.stc_ItemListGroup, "Template_Static_Slot")
  self._ui.scroll_ItemSlot = UI.getChildControl(self._ui.stc_ItemListGroup, "Scroll_ItemSlot")
  self._ui.btn_IevenDeposit = UI.getChildControl(self._ui.stc_ButtonGroup, "Button_Money")
  self._ui.btn_WareHouseDeposit = UI.getChildControl(self._ui.stc_ButtonGroup, "Button_Money2")
  self._ui.txt_InvenMoneyValue = UI.getChildControl(self._ui.btn_IevenDeposit, "StaticText_InvenMoneyValue")
  self._ui.txt_WareHouseMoneyValue = UI.getChildControl(self._ui.btn_WareHouseDeposit, "StaticText_WarehouseMoneyValue")
  self._tabControl = {
    [self._ENUM_INVENTYPE.Inventory] = self._ui.btn_NormalInven,
    [self._ENUM_INVENTYPE.Pearl] = self._ui.btn_CashInven,
    [self._ENUM_INVENTYPE.Warehouse] = self._ui.btn_WareHouse
  }
  self:setUsingTab()
  self:initData()
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    slot.base = UI.createAndCopyBasePropertyControl(self._ui.stc_ItemListGroup, "Template_Static_Slot", self._ui.stc_ItemListGroup, "MarketWallet_Inventory_EmptySlot_" .. slotIdx)
    slot.lock = UI.createAndCopyBasePropertyControl(self._ui.stc_ItemListGroup, "Template_Static_LockSlot", self._ui.stc_ItemListGroup, "MarketWallet_Inventory_LockSlot_" .. slotIdx)
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    local lockGapX = slot.base:GetSizeX() / 2 - slot.lock:GetSizeX() / 2
    local lockGapY = slot.base:GetSizeY() / 2 - slot.lock:GetSizeY() / 2
    slot.base:SetPosX(self._config.slotStartX + self._config.slotGapX * column)
    slot.base:SetPosY(self._config.slotStartY + self._config.slotGapY * row)
    slot.lock:SetPosXY(slot.base:GetPosX() + lockGapX, slot.base:GetPosY() + lockGapY)
    slot.base:SetShow(true)
    slot.lock:SetShow(false)
    if slotIdx < self._config.slotCols then
      slot.base:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobalFunc_MarketPlace_MyInven_Scroll(true)")
    end
    if slotIdx >= self._config.slotCount - self._config.slotCols and slotIdx < self._config.slotCount then
      slot.base:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobalFunc_MarketPlace_MyInven_Scroll(false)")
    end
    UIScroll.InputEventByControl(slot.base, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
    self._slotInvenBgData[slotIdx] = slot
  end
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "MyInventoryItem_" .. slotIdx, slotIdx, self._ui.stc_ItemListGroup, self._slotConfig)
    slot:createChild()
    local row = math.floor(slotIdx / self._config.slotCols)
    local column = slotIdx % self._config.slotCols
    slot.icon:SetPosX(self._config.slotStartX + self._config.slotGapX * column + 2)
    slot.icon:SetPosY(self._config.slotStartY + self._config.slotGapY * row + 2)
    slot.icon:SetEnableDragAndDrop(false)
    slot.icon:SetAutoDisableTime(0.5)
    if slotIdx < self._config.slotCols then
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobalFunc_MarketPlace_MyInven_Scroll(true)")
    end
    if slotIdx >= self._config.slotCount - self._config.slotCols and slotIdx < self._config.slotCount then
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobalFunc_MarketPlace_MyInven_Scroll(false)")
    end
    UIScroll.InputEventByControl(slot.icon, "PaGlobalFunc_MarketPlace_MyInven_Scroll")
    self._slotInvenItemData[slotIdx] = slot
  end
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
  self._ui.btn_IevenDeposit:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlaceConsole_SelectManageWalletBG(true, true)")
  self._ui.btn_IevenDeposit:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_Console_SelectMoneyType(" .. self._moneyType.inven .. ")")
  self._ui.btn_WareHouseDeposit:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlaceConsole_SelectManageWalletBG(true, true)")
  self._ui.btn_WareHouseDeposit:addInputEvent("Mouse_LUp", "PaGlobalFunc_MarketPlace_Console_SelectMoneyType(" .. self._moneyType.wareHouse .. ")")
end
function MarketPlace_MyInven:changeTab(isUp)
  if nil == Panel_Window_MarketPlace_Main then
    return
  end
  local changeTab = 1
  if true == isUp then
    changeTab = self._currentTab + 1
  else
    changeTab = self._currentTab - 1
  end
  if changeTab > self._usingTabCount then
    changeTab = 1
  elseif changeTab < 1 then
    changeTab = self._usingTabCount
  end
  self:selectTab(changeTab)
end
function MarketPlace_MyInven:selectTab(idx)
  if nil == Panel_Window_MarketPlace_Main then
    return
  end
  if idx > self._usingTabCount then
    return
  end
  self._ui.scroll_ItemSlot:SetControlPos(0)
  self._startInvenSlotIndex = 0
  self._currentTab = idx
  local invenType = self._ENUM_INVENTYPE_TO_CPPENUM[self._currentTab]
  if nil == invenType then
    self._currentTab = 1
    self._currentInvenType = CppEnums.ItemWhereType.eInventory
    return
  else
    self._currentInvenType = invenType
  end
  for ii = 1, self._ENUM_INVENTYPE.Count - 1 do
    if nil ~= self._tabControl[ii] then
      if ii == self._currentTab then
        self._tabControl[ii]:SetFontColor(Defines.Color.C_FFFFFFFF)
        self._tabControl[ii]:SetCheck(true)
      else
        self._tabControl[ii]:SetFontColor(Defines.Color.C_FF9397A7)
        self._tabControl[ii]:SetCheck(false)
      end
    end
  end
  self:updateInventory()
  if nil ~= PaGlobalFunc_FloatingTooltip_Close then
    PaGlobalFunc_FloatingTooltip_Close()
  end
  if nil ~= PaGlobalFunc_TooltipInfo_Close then
    PaGlobalFunc_TooltipInfo_Close()
  end
  _AudioPostEvent_SystemUiForXBOX(51, 7)
end
function PaGlobalFunc_MarketPlace_Console_SelectMoneyType(moneyType)
  local self = MarketPlace_MyInven
  if self._moneyType.inven == moneyType then
    self._isWareHouseCheck = false
  elseif self._moneyType.wareHouse == moneyType then
    self._isWareHouseCheck = true
  end
  InputMRUp_MarketWallet_RegisterMoney()
end
function PaGlobalFunc_MarketPlace_Console_SelectCashTab()
  local self = MarketPlace_MyInven
  self._ui.btn_CashInven:SetCheck(true)
  self._ui.btn_NormalInven:SetCheck(false)
  PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eCashInventory)
  self._ui.btn_CashInven:SetFontColor(Defines.Color.C_FFFFFFFF)
  self._ui.btn_NormalInven:SetFontColor(Defines.Color.C_FF9397A7)
end
function PaGlobalFunc_MarketPlace_Console_SelectInvenTab()
  local self = MarketPlace_MyInven
  self._ui.btn_CashInven:SetCheck(false)
  self._ui.btn_NormalInven:SetCheck(true)
  PaGlobalFunc_MarketPlace_SelectTab(CppEnums.ItemWhereType.eInventory)
  self._ui.btn_CashInven:SetFontColor(Defines.Color.C_FF9397A7)
  self._ui.btn_NormalInven:SetFontColor(Defines.Color.C_FFFFFFFF)
end
function PaGlobalFunc_MarketPlace_Console_SelectTab(isUp)
  if nil == Panel_Window_MarketPlace_Main then
    return
  end
  MarketPlace_MyInven:changeTab(isUp)
end
function PaGlobalFunc_MarketPlace_MyInven_CheckMoney()
  local self = MarketPlace_MyInven
  self:updateInventory()
end
function PaGlobalFunc_MarketPlace_MyInven_CheckSort()
  local self = MarketPlace_MyInven
  self:updateInventory()
end
function PaGlobalFunc_MarketPlace_MyInven_Scroll(isUp)
  local self = MarketPlace_MyInven
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Panel_Window_MarketPlace_MyInventory")
    return
  end
  local useStartSlot = __eTInventorySlotNoUseStart
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(self._currentInvenType)
  local maxSize = inventory:sizeXXX() - useStartSlot
  local prevSlotIndex = self._startInvenSlotIndex
  self._startInvenSlotIndex = UIScroll.ScrollEvent(self._ui.scroll_ItemSlot, isUp, self._config.slotRows, maxSize, self._startInvenSlotIndex, self._config.slotCols)
  if prevSlotIndex == 0 and self._startInvenSlotIndex == 0 then
    return
  end
  ToClient_padSnapIgnoreGroupMove()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobalFunc_TooltipInfo_Close()
  self:updateInventory()
  PaGlobalFunc_MarketPlace_MyInven_ShowToolTip(self._currentInvenType, self._currentSlotNo, self._currnetSlotIdx)
end
function PaGlobalFunc_MarketPlace_MyInven_Update()
  local self = MarketPlace_MyInven
  self:updateInventory()
end
function PaGlobalFunc_MarketPlace_SelectTab(tabIdx)
  local self = MarketPlace_MyInven
  self._currentInvenType = tabIdx
  self:updateInventory()
end
function PaGlobalFunc_MarketPlace_GetMyInvenTab()
  local self = MarketPlace_MyInven
  return self._currentInvenType
end
function PaGlobalFunc_MarketPlace_MyInven_GetMoney()
  local self = MarketPlace_MyInven
  local moneyValue = 0
  if false == self._ui.checkBtn_WareHouseMoney:IsCheck() then
    moneyValue = getSelfPlayer():get():getInventory():getMoney_s64()
  else
    moneyValue = warehouse_moneyFromNpcShop_s64()
  end
  return moneyValue
end
function PaGlobalFunc_MarketPlace_MyInven_ItemComparer(ii, jj)
  return Global_ItemComparer(ii, jj, getInventoryItemByType, PaGlobalFunc_MarketPlace_GetMyInvenTab())
end
function MarketPlace_MyInven:updateInventory()
  Panel_Tooltip_Item_hideTooltip()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local invenUseSize = selfPlayer:getInventorySlotCount(CppEnums.ItemWhereType.eInventory ~= self._currentInvenType)
  local useStartSlot = __eTInventorySlotNoUseStart
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(self._currentInvenType)
  local invenMaxSize = inventory:sizeXXX()
  local freeCount = inventory:getFreeCount()
  local slotNoList = Array.new()
  local warehouseWrapper
  if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
    warehouseWrapper = self:getWarehouseWrapper()
    if nil == warehouseWrapper then
      return
    end
    invenUseSize = warehouseWrapper:getUseMaxCount()
    useStartSlot = __eTInventorySlotNoMileage
    invenMaxSize = warehouseWrapper:getMaxCount()
    freeCount = warehouseWrapper:getFreeCount()
  end
  slotNoList:fill(useStartSlot, invenMaxSize - 1)
  local sortList = Array.new()
  sortList:fill(useStartSlot, invenUseSize - 1)
  if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
    sortList:quicksort(PaGlobalFunc_MarketPlace_MyInven_WarehouseComparer)
  else
    sortList:quicksort(PaGlobalFunc_MarketPlace_MyInven_ItemComparer)
  end
  for ii = 1, invenUseSize - 2 do
    slotNoList[ii] = sortList[ii]
  end
  local invenCapacity = invenUseSize - useStartSlot
  self._currentSlotNo = -1
  for slotIdx = 0, self._config.slotCount - 1 do
    local slot = self._slotInvenItemData[slotIdx]
    local slotBg = self._slotInvenBgData[slotIdx]
    local slotNo = slotNoList[slotIdx + 1 + self._startInvenSlotIndex]
    slot:clearItem()
    slot.slotNo = slotNo
    slot.icon:EraseAllEffect()
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlaceConsole_SelectManageWalletBG(true, false)")
    slot.icon:addInputEvent("Mouse_Out", "")
    slot.icon:addInputEvent("Mouse_LUp", "")
    slot.icon:addInputEvent("Mouse_RUp", "")
    if invenCapacity > slotIdx + self._startInvenSlotIndex then
      local itemWrapper = getInventoryItemByType(self._currentInvenType, slotNo)
      if CppEnums.ItemWhereType.eWarehouse == self._currentInvenType then
        itemWrapper = warehouseWrapper:getItem(slotNo)
      end
      if nil ~= itemWrapper then
        slot:setItem(itemWrapper, slotNo)
        slot.isEmpty = false
        local isFiltered = self:marketFilter(slotNo, itemWrapper, self._currentInvenType)
        slot.icon:SetMonoTone(isFiltered)
        if true == isFiltered then
          slot.icon:SetAlpha(0.5)
        else
          slot.icon:addInputEvent("Mouse_LUp", "InputMRUp_MarketWallet_MoveInvenToWallet(" .. slotNo .. ")")
          slot.icon:SetAlpha(1)
        end
        slot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_MarketPlace_MyInven_ViewDetailToolTip(" .. self._currentInvenType .. "," .. slotNo .. ",true)")
        local isSoulCollector = itemWrapper:isSoulCollector()
        local isCurrentSoulCount = itemWrapper:getSoulCollectorCount()
        local isMaxSoulCount = itemWrapper:getSoulCollectorMaxCount()
        local itemIconPath = itemWrapper:getStaticStatus():getIconPath()
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
      end
      slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_MarketPlace_MyInven_ShowToolTip(" .. self._currentInvenType .. "," .. slotNo .. "," .. slotIdx .. ")")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_FloatingTooltip_Close()")
      slotBg.lock:SetShow(false)
    else
      slotBg.lock:SetShow(true)
    end
    if slotIdx == self._currnetSlotIdx then
      self._currentSlotNo = slotNo
    end
  end
  local moneyValue, moneyTitle
  moneyTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY")
  moneyValue = makeDotMoney(getSelfPlayer():get():getInventory():getMoney_s64())
  self._ui.txt_InvenMoneyValue:SetText(moneyValue)
  moneyTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKET_ICON_MONEY2")
  if true == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
    moneyValue = makeDotMoney(PaGlobalFunc_MarketPlace_GetWareHouseMoneyFromMaid())
  else
    moneyValue = makeDotMoney(warehouse_moneyFromNpcShop_s64())
  end
  self._ui.txt_WareHouseMoneyValue:SetText(moneyValue)
  local normalInventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local _const = Defines.s64_const
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local s64_moneyWeight = normalInventory:getMoneyWeight_s64()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight_div = s64_allWeight / _const.s64_100
  local s64_maxWeight_div = s64_maxWeight / _const.s64_100
  local str_AllWeight = string.format("%.1f", Int64toInt32(s64_allWeight_div) / 100)
  local str_MaxWeight = string.format("%.0f", Int64toInt32(s64_maxWeight_div) / 100)
  self._ui.txt_Weight:SetText(str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  UIScroll.SetButtonSize(self._ui.scroll_ItemSlot, self._config.slotCount, invenMaxSize - useStartSlot)
end
function MarketPlace_MyInven:marketFilter(slotNo, itemWrapper, invenWhereType)
  if nil == itemWrapper then
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
  PaGlobalFunc_MarketPlaceConsole_SelectManageWalletBG(true, true)
  PaGlobalFunc_FloatingTooltip_Close()
  local self = MarketPlace_MyInven
  self._currnetSlotIdx = slotIdx
  local slot = self._slotInvenItemData[slotIdx]
  local itemWrapper
  if CppEnums.ItemWhereType.eWarehouse == whereType then
    itemWrapper = PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem(slotNo)
  else
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if nil == slot then
    return
  end
  if nil == itemWrapper then
    return
  end
  PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper:getStaticStatus(), Defines.TooltipTargetType.Item, self._slotInvenItemData[slotIdx].base)
end
function PaGlobalFunc_MarketPlace_MyInven_ViewDetailToolTip(whereType, slotNo, isShow)
  local self = MarketPlace_MyInven
  if true == isShow then
    local itemWrapper
    if CppEnums.ItemWhereType.eWarehouse == whereType then
      itemWrapper = PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem(slotNo)
    else
      itemWrapper = getInventoryItemByType(whereType, slotNo)
    end
    if nil ~= itemWrapper then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      PaGlobalFunc_FloatingTooltip_Close()
    end
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_MarketPlaceConsole_SetInvenKeyGuide(isShow)
  local self = MarketPlace_MyInven
  self._ui.btn_AConsoleUI:SetShow(isShow)
end
function PaGlobalFunc_MarketPlace_MyInven_Open()
  local self = MarketPlace_MyInven
  self._ui.scroll_ItemSlot:SetControlPos(0)
  self._startInvenSlotIndex = 0
  self:setUsingTab()
  self:open()
  MarketPlace_MyInven:selectTab(1)
end
function PaGlobalFunc_MarketPlace_MyInven_Close()
  local self = MarketPlace_MyInven
  self:close()
  PaGlobalFunc_ItemMarket_SearchResultClose()
end
function MarketPlace_MyInven:open()
  _panel:SetShow(true)
end
function MarketPlace_MyInven:close()
  if nil == Panel_Window_MarketPlace_Main then
    return
  end
  MarketPlace_MyInven._usingTabCount = 2
  MarketPlace_MyInven._currentTab = 1
  MarketPlace_MyInven._currentInvenType = 0
  _panel:SetShow(false)
end
function PaGlobalFunc_MarketPlace_MyInven_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_MarketPlace_MyInven_WarehouseComparer(ii, jj)
  return Global_ItemComparer(ii, jj, PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem)
end
function PaGlobalFunc_MarketPlace_MyInven_Warehouse_GetItem(slotNo)
  if nil == Panel_Window_MarketPlace_Main then
    return nil
  end
  local warehouseWrapper = MarketPlace_MyInven:getWarehouseWrapper()
  if nil == warehouseWrapper then
    return nil
  end
  return (warehouseWrapper:getItem(slotNo))
end
function PaGlobalFunc_MarketPlace_MyInven_isWarehouse()
  if nil == Panel_Window_MarketPlace_Main then
    return false
  end
  return MarketPlace_MyInven._currentInvenType == CppEnums.ItemWhereType.eWarehouse
end
function MarketPlace_MyInven:setUsingTab()
  if nil == Panel_Window_MarketPlace_Main then
    return
  end
  if true == PaGlobalFunc_MarketPlace_IsOpenFromDialog() and false == PaGlobalFunc_MarketPlace_IsOpenFromWorldMap() and false == PaGlobalFunc_MarketPlace_IsOpenByMaid() then
    self._usingTabCount = self._ENUM_INVENTYPE.Warehouse
  else
    self._usingTabCount = self._ENUM_INVENTYPE.Pearl
  end
  local warehouseWrapper = self:getWarehouseWrapper()
  if nil == warehouseWrapper then
    self._usingTabCount = self._ENUM_INVENTYPE.Pearl
  end
  local tabSizeX = self._ui.btn_NormalInven:GetSizeX()
  local startPosX = self._ui.stc_keyguideLT:GetPosX() + self._ui.stc_keyguideLT:GetSizeX()
  local endPosX = self._ui.stc_keyguideRT:GetPosX()
  local totalSizeX = endPosX - startPosX
  local paddingCount = self._usingTabCount + 1
  if paddingCount <= 0 then
    _PA_ASSERT(false, "\234\177\176\235\158\152\236\134\140 \234\176\128\235\176\169 \237\131\173\236\157\152 paddingCount\234\176\128 0\235\179\180\235\139\164 \236\158\145\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    return
  end
  local paddingTotalSize = totalSizeX - self._usingTabCount * tabSizeX
  local paddingSizeX = paddingTotalSize / paddingCount
  if paddingTotalSize < 0 then
    _PA_ASSERT(false, "\236\130\172\236\154\169\237\149\152\235\160\164\235\138\148 \234\177\176\235\158\152\236\134\140 \234\176\128\235\176\169 \237\131\173\236\157\152 \234\176\175\236\136\152\234\176\128 \235\132\136\235\172\180 \235\167\142\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
    return
  end
  local nexStartPosX = startPosX
  for ii = 1, self._ENUM_INVENTYPE.Count - 1 do
    if nil ~= self._tabControl[ii] then
      if ii > self._usingTabCount then
        self._tabControl[ii]:SetShow(false)
      else
        self._tabControl[ii]:SetShow(true)
        self._tabControl[ii]:SetPosX(nexStartPosX + paddingSizeX)
        nexStartPosX = self._tabControl[ii]:GetPosX() + tabSizeX
      end
    end
  end
end
function PaGlobalFunc_MarketPlace_MyInven_GetWareHouseWrapper()
  if nil == Panel_Window_MarketPlace_Main then
    return nil
  end
  return MarketPlace_MyInven:getWarehouseWrapper()
end
function MarketPlace_MyInven:getWarehouseWrapper()
  if nil == Panel_Window_MarketPlace_Main then
    return nil
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return nil
  end
  local currentPos = selfPlayer:getPosition()
  if 0 == currentPos then
    return nil
  end
  local regionInfo = getRegionInfoByPosition(currentPos)
  if nil == regionInfo then
    return nil
  end
  local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
  if nil == regionInfoWrapper then
    return nil
  end
  local plantWayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
  local regionKey = regionInfoWrapper:getRegionKey()
  if false == ToClient_IsAccessibleRegionKey(regionKey) then
    plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
    if 0 == plantWayKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CANTFIND_WAREHOUSE_INTERRITORY"))
      return nil
    end
  end
  return warehouse_get(plantWayKey)
end
