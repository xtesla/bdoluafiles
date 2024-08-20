function PaGlobal_RandowShop_All:initialize()
  if true == PaGlobal_RandowShop_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:randomMoneyCheckUpdate()
  self._panelSizeY = Panel_Window_RandomShop_All:GetSizeY()
  PaGlobal_RandowShop_All:registEventHandler()
  PaGlobal_RandowShop_All:validate()
  PaGlobal_RandowShop_All._initialize = true
end
function PaGlobal_RandowShop_All:controlAll_Init()
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_RandomShop_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_RandomShop_All, "Static_MainArea")
  self._ui.stc_imageArea = UI.getChildControl(self._ui.stc_mainBg, "Static_BigImage")
  self._ui.stc_itemSlot = UI.getChildControl(self._ui.stc_imageArea, "Static_ItemSlot")
  self._ui.stc_reserveIcon = UI.getChildControl(self._ui.stc_imageArea, "Static_ReserveIcon")
  self._ui.stc_infoArea = UI.getChildControl(self._ui.stc_mainBg, "Static_InfoArea")
  self._ui.txt_money = UI.getChildControl(self._ui.stc_infoArea, "StaticText_Money")
  self._ui.txt_myWp = UI.getChildControl(self._ui.stc_mainBg, "StaticText_MyWp")
  self._ui.txt_myWp:SetShow(true)
  self._ui.txt_itemName = UI.getChildControl(self._ui.stc_mainBg, "StaticText_ItemName")
  self._ui.mtxt_reserveTime = UI.getChildControl(self._ui.stc_mainBg, "MultilineText_ReserveTime")
  self._ui.stc_selectMoneyBg = UI.getChildControl(Panel_Window_RandomShop_All, "Static_SelectMoneyArea")
  self._ui.radio_inven = UI.getChildControl(self._ui.stc_selectMoneyBg, "RadioButton_Inven")
  self._ui.txt_invenMoney = UI.getChildControl(self._ui.radio_inven, "StaticText_MoneyValue")
  self._ui.radio_warehouse = UI.getChildControl(self._ui.stc_selectMoneyBg, "RadioButton_Warehouse")
  self._ui.txt_warehouseMoney = UI.getChildControl(self._ui.radio_warehouse, "StaticText_MoneyValue")
end
function PaGlobal_RandowShop_All:controlPc_Init()
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.btn_question:SetShow(false)
  self._ui_pc.stc_buttonAreaBg = UI.getChildControl(Panel_Window_RandomShop_All, "Static_ButtonArea")
  self._ui_pc.btn_reserve = UI.getChildControl(self._ui_pc.stc_buttonAreaBg, "Button_Reserve")
  self._ui_pc.btn_other = UI.getChildControl(self._ui_pc.stc_buttonAreaBg, "Button_OtherItem")
  self._ui_pc.btn_buy = UI.getChildControl(self._ui_pc.stc_buttonAreaBg, "Button_BuyItem")
end
function PaGlobal_RandowShop_All:controlConsole_Init()
  self._ui_console.stc_guideAreaBg = UI.getChildControl(Panel_Window_RandomShop_All, "Static_ButtonAreaConsole")
  self._ui_console.btn_guideOther = UI.getChildControl(self._ui_console.stc_guideAreaBg, "Button_OtherItem")
  self._ui_console.btn_guideReserve = UI.getChildControl(self._ui_console.stc_guideAreaBg, "Button_Reservation")
  self._ui_console.btn_guideBuy = UI.getChildControl(self._ui_console.stc_guideAreaBg, "Button_BuyItem")
  self._ui_console.btn_guideBack = UI.getChildControl(self._ui_console.stc_guideAreaBg, "Button_Back")
  self._ui_console.btn_guideDetail = UI.getChildControl(self._ui_console.stc_guideAreaBg, "Button_ViewDetail")
end
function PaGlobal_RandowShop_All:setControl()
  if true == self._isConsole then
    Panel_Window_RandomShop_All:ignorePadSnapMoveToOtherPanel()
    Panel_Window_RandomShop_All:SetSize(Panel_Window_RandomShop_All:GetSizeX(), self._panelSizeY - self._ui_pc.stc_buttonAreaBg:GetSizeY() - 4)
    Panel_Window_RandomShop_All:ComputePos()
    Panel_Window_RandomShop_All:SetPosY(Panel_Window_RandomShop_All:GetPosY() - 100)
    self._ui.btn_close:SetShow(false)
    self._ui_pc.stc_buttonAreaBg:SetShow(false)
    self._ui_console.stc_guideAreaBg:ComputePos()
    self._ui_console.stc_guideAreaBg:SetShow(true)
    self:setKeyGuide()
  else
    self._ui_pc.stc_buttonAreaBg:SetShow(true)
  end
end
function PaGlobal_RandowShop_All:setKeyGuide()
  local keyGuideList = {
    self._ui_console.btn_guideReserve,
    self._ui_console.btn_guideDetail,
    self._ui_console.btn_guideOther,
    self._ui_console.btn_guideBuy,
    self._ui_console.btn_guideBack
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_guideAreaBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_RandowShop_All:prepareOpen(slotNo, priceRate)
  if nil == Panel_Window_RandomShop_All then
    return
  end
  PaGlobal_RandowShop_All:resize()
  PaGlobal_RandowShop_All:setControl()
  PaGlobal_RandowShop_All:update(slotNo, priceRate)
  PaGlobal_RandowShop_All:open()
end
function PaGlobal_RandowShop_All:open()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  Panel_Window_RandomShop_All:SetShow(true)
end
function PaGlobal_RandowShop_All:prepareClose()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  PaGlobal_RandowShop_All:close()
end
function PaGlobal_RandowShop_All:close()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  Panel_Window_RandomShop_All:SetShow(false)
end
function PaGlobal_RandowShop_All:update(slotNo, priceRate)
  if nil == Panel_Window_RandomShop_All then
    return
  end
  self._priceRate = priceRate
  local sellCount = npcShop_getBuyCount()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  for ii = 0, sellCount - 1 do
    local itemWrapper = npcShop_getItemBuy(ii)
    local shopItem = itemWrapper:get()
    if slotNo == shopItem.shopSlotNo then
      self._selectSlotNo = shopItem.shopSlotNo
      local itemRandomSS = itemWrapper:getStaticStatus()
      if nil ~= itemRandomSS then
        local itemIconPath = itemRandomSS:getIconPath()
        self._ui.stc_itemSlot:ChangeTextureInfoName("Icon/" .. itemIconPath)
        if true == self._isConsole then
          Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_RandomShop_All_ItemTooltip(" .. ii .. "," .. slotNo .. ")")
        else
          self._ui.stc_itemSlot:addInputEvent("Mouse_On", "HandleEventOn_RandomShop_All_ItemTooltip(" .. ii .. "," .. slotNo .. ")")
        end
        local price = shopItem:getPriceCalculateRate(priceRate)
        self._randomShopItemPrice = price
        self._ui.txt_money:SetText(makeDotMoney(price))
        self._ui.txt_itemName:SetText(itemRandomSS:getName())
        PAGlobalFunc_SetItemTextColorForNewUI(self._ui.txt_itemName, itemRandomSS)
      end
    end
  end
  local useWp = 0
  if 12 == self._shopTypeNum then
    useWp = ToClient_getRandomShopConsumWp()
    if 44672 == dialog_getTalkNpcKey() then
      self._ui_pc.btn_reserve:SetIgnore(true)
      self._ui_pc.btn_reserve:SetMonoTone(true)
      self._ui_console.btn_guideReserve:SetShow(false)
    else
      self._ui_pc.btn_reserve:SetIgnore(false)
      self._ui_pc.btn_reserve:SetMonoTone(false)
      self._ui_console.btn_guideReserve:SetShow(true)
    end
  elseif 13 == self._shopTypeNum then
    useWp = 10
    self._ui_pc.btn_reserve:SetIgnore(true)
    self._ui_pc.btn_reserve:SetMonoTone(true)
    self._ui_console.btn_guideReserve:SetShow(false)
  end
  if true == ToClient_IsRandomShopKeepItem() and 12 == self._shopTypeNum then
    PaGlobalFunc_RandomShop_All_ReserveAni(true)
  else
    PaGlobalFunc_RandomShop_All_ReserveAni(false)
  end
  local myWp = selfPlayer:getWp()
  self._ui.txt_myWp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RANDOMSHOP_ALL_MYWP", "myWp", tostring(myWp)))
  if useWp > myWp then
    self._ui_pc.btn_other:SetIgnore(true)
    self._ui_pc.btn_other:SetMonoTone(true)
  elseif true == ToClient_isReSelectRandomShopItem() then
    self._ui_pc.btn_other:SetIgnore(false)
    self._ui_pc.btn_other:SetMonoTone(false)
  else
    self._ui_pc.btn_other:SetIgnore(true)
    self._ui_pc.btn_other:SetMonoTone(true)
  end
  if 12 == self._shopTypeNum and true == ToClient_IsRandomShopKeepItem() and 44672 == dialog_getTalkNpcKey() then
    self._ui_pc.btn_other:SetIgnore(true)
    self._ui_pc.btn_other:SetMonoTone(true)
    self._ui_pc.btn_buy:SetIgnore(true)
    self._ui_pc.btn_buy:SetMonoTone(true)
  else
    self._ui_pc.btn_buy:SetIgnore(false)
    self._ui_pc.btn_buy:SetMonoTone(false)
  end
  self:setKeyGuide()
  self:moneyUpdate()
end
function PaGlobal_RandowShop_All:randomMoneyCheckUpdate()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if true == ToClient_HasWareHouseFromNpc() then
    if toInt64(0, 0) == warehouse_moneyFromNpcShop_s64() then
      self._ui.radio_inven:SetCheck(true)
      self._ui.radio_warehouse:SetCheck(false)
    else
      self._ui.radio_inven:SetCheck(false)
      self._ui.radio_warehouse:SetCheck(true)
    end
  else
    self._ui.radio_inven:SetCheck(true)
    self._ui.radio_warehouse:SetCheck(false)
  end
end
function PaGlobal_RandowShop_All:moneyUpdate()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if false == PaGlobal_RandowShop_All._initialize then
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  if nil == regionInfo then
    return
  end
  local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
  if territoryKeyRaw > #self._territoryKeyToWaypointKey or territoryKeyRaw < 0 then
    return
  end
  local silverInInventory = getSelfPlayer():get():getInventory():getMoney_s64()
  local silverInWarehouse = toInt64(0, 0)
  local waypointKey = self._territoryKeyToWaypointKey[territoryKeyRaw]
  local warehouseWrapper = warehouse_get(waypointKey)
  if nil ~= warehouseWrapper then
    silverInWarehouse = warehouseWrapper:getMoney_s64()
  end
  self._ui.txt_invenMoney:SetText(makeDotMoney(silverInInventory))
  self._ui.txt_warehouseMoney:SetText(makeDotMoney(silverInWarehouse))
end
function PaGlobal_RandowShop_All:validate()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.stc_imageArea:isValidate()
  self._ui.stc_itemSlot:isValidate()
  self._ui.stc_reserveIcon:isValidate()
  self._ui.stc_infoArea:isValidate()
  self._ui.txt_money:isValidate()
  self._ui.txt_myWp:isValidate()
  self._ui.txt_itemName:isValidate()
  self._ui.mtxt_reserveTime:isValidate()
  self._ui.stc_selectMoneyBg:isValidate()
  self._ui.radio_inven:isValidate()
  self._ui.txt_invenMoney:isValidate()
  self._ui.radio_warehouse:isValidate()
  self._ui.txt_warehouseMoney:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.stc_buttonAreaBg:isValidate()
  self._ui_pc.btn_reserve:isValidate()
  self._ui_pc.btn_other:isValidate()
  self._ui_pc.btn_buy:isValidate()
  self._ui_console.stc_guideAreaBg:isValidate()
  self._ui_console.btn_guideOther:isValidate()
  self._ui_console.btn_guideReserve:isValidate()
  self._ui_console.btn_guideBuy:isValidate()
  self._ui_console.btn_guideBack:isValidate()
end
function PaGlobal_RandowShop_All:registEventHandler()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  registerEvent("FromClient_UpdateRandomShopKeepTime", "FromClient_RandomShop_All_UpdateRandomShopKeepTime")
  registerEvent("FromClient_NotifyRandomShop", "FromClient_RandomShop_All_NotifyRandomShop")
  registerEvent("FromClient_EventRandomShopShow", "FromClient_RandomShop_All_EventRandomShopShow")
  registerEvent("EventWarehouseUpdate", "FromClient_RandomShop_All_MoneyUpdate")
  registerEvent("FromClient_WpChanged", "FromClient_RandomShop_All_WpChanged")
  registerEvent("selfPlayer_regionChanged", "FromClient_RandomShop_All_RegionUpdate")
  if true == self._isConsole then
    Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_RandomShop_All_BuyItem()")
    Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_RandomShop_All_ReserveKeepItem()")
    Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_RandomShop_All_OtherItemShow()")
    Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEventOn_RandomShop_All_SetPayment()")
    Panel_Window_RandomShop_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEventOn_RandomShop_All_SetPayment()")
  else
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RandomShop_All_Close()")
    self._ui.stc_itemSlot:addInputEvent("Mouse_Out", "HandleEventOut_RandomShop_All_ItemTooltipHide()")
    self._ui_pc.btn_other:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomShop_All_OtherItemShow()")
    self._ui_pc.btn_buy:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomShop_All_BuyItem()")
    self._ui_pc.btn_reserve:addInputEvent("Mouse_LUp", "HandleEventLUp_RandomShop_All_ReserveKeepItem()")
  end
end
function PaGlobal_RandowShop_All:resize()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  Panel_Window_RandomShop_All:ComputePos()
  self._ui.stc_mainBg:ComputePos()
  self._ui.stc_imageArea:ComputePos()
  self._ui.stc_infoArea:ComputePos()
  self._ui.txt_myWp:ComputePos()
  self._ui.txt_itemName:ComputePos()
  self._ui.mtxt_reserveTime:ComputePos()
  self._ui.stc_selectMoneyBg:ComputePos()
  self._ui_pc.btn_close:ComputePos()
  self._ui_pc.btn_question:ComputePos()
  self._ui_pc.stc_buttonAreaBg:ComputePos()
  self._ui_pc.btn_reserve:ComputePos()
  self._ui_pc.btn_other:ComputePos()
  self._ui_pc.btn_buy:ComputePos()
end
