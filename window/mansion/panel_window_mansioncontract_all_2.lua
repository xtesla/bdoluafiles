function HandleEventLUp_MansionContract_ClickContract()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  if nil == PaGlobal_MansionContract._householdNo then
    return
  end
  local self = PaGlobal_MansionContract
  local itemWhereType = 0
  local moneyValue = 0
  if true == self._ui._chk_inventory:IsCheck() then
    itemWhereType = CppEnums.ItemWhereType.eInventory
    moneyValue = self._inventoryMoney
  elseif true == self._ui._chk_warehouse:IsCheck() then
    itemWhereType = CppEnums.ItemWhereType.eWarehouse
    moneyValue = self._wareHouseMoney
  end
  if moneyValue < self._discountPayValue then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_SILVER"))
    return
  end
  local function doYes()
    ToClient_extensionMansionExpireTime(self._householdNo, self._contract_Period, itemWhereType)
    PaGlobal_MansionContract_Close()
  end
  local messagebox = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_CONFIRM"),
    functionYes = doYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messagebox)
end
function HandleEventLup_MansionContract_ClickMoneyWhereType(whereType)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  local self = PaGlobal_MansionContract
  if "Inventory" == whereType then
    self._ui._chk_inventory:SetCheck(true)
    self._ui._chk_warehouse:SetCheck(false)
  elseif "WareHouse" == whereType then
    self._ui._chk_inventory:SetCheck(false)
    self._ui._chk_warehouse:SetCheck(true)
  end
end
function HandleEventLup_MansionContract_ButtonDate()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  if true == PaGlobal_NumberPad_All_GetShow() then
    Panel_NumberPad_Close()
    return
  end
  Panel_NumberPad_Show(true, toInt64(0, 365), 0, PaGlobal_MansionContract_SetContractPeriod)
end
function HandleEventOnOut_MansionContract_ShowPriceTooltip(isShow)
  if nil == Panel_Window_Mansion_Contract_All or nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_MansionContract._ui._stc_price
  if nil == control then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRACTION_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CONTRACTION_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_MansionContract_SetContractPeriod(value64)
  if nil == PaGlobal_MansionContract then
    return
  end
  local value32 = Int64toInt32(value64)
  PaGlobal_MansionContract:setContractPeriod(value32)
end
function FromClient_ContractMansion(householdNo)
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
  if nil == householdNo then
    return
  end
  PaGlobal_MansionContract:prepareOpen(householdNo)
end
function FromClient_ContractMansionSuccess()
  local messagebox = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SYSMSG_DONE"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messagebox)
  PaGlobal_MansionContract_Close()
end
function PaGloabl_MansionContract_ShowAni()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
end
function PaGloabl_MansionContract_HideAni()
  if nil == Panel_Window_Mansion_Contract_All then
    return
  end
end
function PaGlobal_MansionContract_Close()
  if nil == PaGlobal_MansionContract then
    return
  end
  PaGlobal_MansionContract:prepareClose()
end
