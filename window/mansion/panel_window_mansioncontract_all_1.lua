function PaGlobal_MansionContract:initialize()
  if true == PaGlobal_MansionContract._initialize then
    return
  end
  PaGlobal_MansionContract._ui._stc_name = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_To")
  PaGlobal_MansionContract._ui._btn_date = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Date")
  PaGlobal_MansionContract._ui._stc_price = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price")
  PaGlobal_MansionContract._ui._stc_priceValue = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price_Value")
  PaGlobal_MansionContract._ui._stc_discount = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Price_Sale")
  PaGlobal_MansionContract._ui._chk_inventory = UI.getChildControl(Panel_Window_Mansion_Contract_All, "CheckButton_Silver_Inven")
  PaGlobal_MansionContract._ui._stc_inventoryMoney = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Silver_Inven_Value")
  PaGlobal_MansionContract._ui._chk_warehouse = UI.getChildControl(Panel_Window_Mansion_Contract_All, "CheckButton_Silver_Warehouse")
  PaGlobal_MansionContract._ui._stc_warehouseMoney = UI.getChildControl(Panel_Window_Mansion_Contract_All, "StaticText_Silver_Warehouse_Value")
  PaGlobal_MansionContract._ui._btn_contract = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Contract")
  PaGlobal_MansionContract._ui._btn_cancle = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Button_Cancle")
  PaGlobal_MansionContract._ui._frm_mansion = UI.getChildControl(Panel_Window_Mansion_Contract_All, "Frame_Mansion")
  PaGlobal_MansionContract._ui._frm_content = UI.getChildControl(PaGlobal_MansionContract._ui._frm_mansion, "Frame_1_Content")
  PaGlobal_MansionContract._ui._stc_content = UI.getChildControl(PaGlobal_MansionContract._ui._frm_content, "StaticText_Contents")
  PaGlobal_MansionContract:registEventHandler()
  PaGlobal_MansionContract:validate()
  PaGlobal_MansionContract._ui._stc_content:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_MansionContract._ui._stc_content:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MANSION_CONTRACTION_DESC"))
  local gapY = 20
  local textSizeY = PaGlobal_MansionContract._ui._stc_content:GetTextSizeY() + gapY
  PaGlobal_MansionContract._ui._frm_content:SetSize(PaGlobal_MansionContract._ui._frm_content:GetSizeX(), textSizeY)
  PaGlobal_MansionContract._ui._stc_content:SetSize(PaGlobal_MansionContract._ui._stc_content:GetSizeX(), textSizeY)
  PaGlobal_MansionContract._ui._frm_mansion:UpdateContentScroll()
  PaGlobal_MansionContract._ui._frm_mansion:UpdateContentPos()
  PaGlobal_MansionContract._initialize = true
end
function PaGlobal_MansionContract:registEventHandler()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  PaGlobal_MansionContract._ui._stc_price:addInputEvent("Mouse_On", "HandleEventOnOut_MansionContract_ShowPriceTooltip(true)")
  PaGlobal_MansionContract._ui._stc_price:addInputEvent("Mouse_Out", "HandleEventOnOut_MansionContract_ShowPriceTooltip(false)")
  PaGlobal_MansionContract._ui._btn_contract:addInputEvent("Mouse_LUp", "HandleEventLUp_MansionContract_ClickContract()")
  PaGlobal_MansionContract._ui._chk_inventory:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ClickMoneyWhereType('Inventory')")
  PaGlobal_MansionContract._ui._chk_warehouse:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ClickMoneyWhereType('WareHouse')")
  PaGlobal_MansionContract._ui._btn_date:addInputEvent("Mouse_LUp", "HandleEventLup_MansionContract_ButtonDate()")
  PaGlobal_MansionContract._ui._btn_cancle:addInputEvent("Mouse_LUp", "PaGlobal_MansionContract_Close()")
  registerEvent("FromClient_ContractMansion", "FromClient_ContractMansion")
  registerEvent("FromClient_ContractMansionSuccess", "FromClient_ContractMansionSuccess")
end
function PaGlobal_MansionContract:prepareOpen(houseHoldNo)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  self._householdNo = houseHoldNo
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  warehouse_requestInfoByCurrentRegionMainTown()
  self._ui._stc_name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_TO", "name", selfPlayer:getUserNickname()))
  self._ui._chk_inventory:SetCheck(true)
  self._ui._chk_warehouse:SetCheck(false)
  self._inventoryMoney = getSelfPlayer():get():getInventory():getMoney_s64()
  self._wareHouseMoney = warehouse_moneyByCurrentRegionMainTown_s64()
  self._ui._stc_warehouseMoney:SetText(makeDotMoney(self._wareHouseMoney))
  self._ui._stc_inventoryMoney:SetText(makeDotMoney(self._inventoryMoney))
  self:setContractPeriod(30)
  PaGlobal_MansionContract:open()
end
function PaGlobal_MansionContract:open()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  Panel_Window_Mansion_Contract_All:SetShow(true)
end
function PaGlobal_MansionContract:prepareClose()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  self._householdNo = nil
  self._contract_Period = 0
  self._inventoryMoney = 0
  self._wareHouseMoney = 0
  self._payValue = 0
  self._discountPayValue = 0
  TooltipSimple_Hide()
  PaGlobal_MansionContract:close()
end
function PaGlobal_MansionContract:close()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  Panel_Window_Mansion_Contract_All:SetShow(false)
end
function PaGlobal_MansionContract:update()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
end
function PaGlobal_MansionContract:setContractPeriod(value)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  if value <= 0 or value > 365 then
    return
  end
  self._payValue = toInt64(0, value) * ToClient_GetMansionPricePerDay()
  self._discountPayValue = ToClient_GetMansionContractDiscountPrice(value, self._payValue)
  self._contract_Period = value
  self._ui._stc_price:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_PRICE"))
  local priceSpanGapX = self._ui._stc_price:GetSpanSize().x + self._ui._stc_price:GetSizeX() + self._ui._stc_price:GetTextSizeX() + 13
  self._ui._stc_priceValue:SetText(makeDotMoney(self._payValue))
  self._ui._stc_priceValue:SetSpanSize(priceSpanGapX, self._ui._stc_price:GetSpanSize().y)
  self._ui._btn_date:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MANSION_CONTRACTION_DATE", "date", value))
  if self._payValue == self._discountPayValue then
    self._ui._stc_priceValue:SetLineRender(false)
    self._ui._stc_discount:SetShow(false)
  else
    self._ui._stc_priceValue:SetLineRender(true)
    self._ui._stc_discount:SetText(makeDotMoney(self._discountPayValue))
    self._ui._stc_discount:SetShow(true)
    self._ui._stc_discount:SetSpanSize(priceSpanGapX + self._ui._stc_priceValue:GetTextSizeX() + 15, self._ui._stc_price:GetSpanSize().y)
  end
end
function PaGlobal_MansionContract:validate()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  PaGlobal_MansionContract._ui._stc_name:isValidate()
  PaGlobal_MansionContract._ui._btn_date:isValidate()
  PaGlobal_MansionContract._ui._stc_price:isValidate()
  PaGlobal_MansionContract._ui._stc_priceValue:isValidate()
  PaGlobal_MansionContract._ui._stc_discount:isValidate()
  PaGlobal_MansionContract._ui._chk_inventory:isValidate()
  PaGlobal_MansionContract._ui._stc_inventoryMoney:isValidate()
  PaGlobal_MansionContract._ui._chk_warehouse:isValidate()
  PaGlobal_MansionContract._ui._stc_warehouseMoney:isValidate()
  PaGlobal_MansionContract._ui._btn_contract:isValidate()
  PaGlobal_MansionContract._ui._btn_cancle:isValidate()
  PaGlobal_MansionContract._ui._frm_mansion:isValidate()
  PaGlobal_MansionContract._ui._frm_content:isValidate()
  PaGlobal_MansionContract._ui._stc_content:isValidate()
end
