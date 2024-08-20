PaGlobal_MansionContract = {
  _ui = {
    _stc_name = nil,
    _btn_date = nil,
    _stc_price = nil,
    _stc_priceValue = nil,
    _stc_discount = nil,
    _chk_inventory = nil,
    _stc_inventoryMoney = nil,
    _chk_warehouse = nil,
    _stc_warehouseMoney = nil,
    _btn_contract = nil,
    _btn_cancle = nil,
    _frm_mansion = nil,
    _frm_content = nil,
    _stc_content = nil
  },
  _householdNo = nil,
  _contract_Period = 0,
  _inventoryMoney = 0,
  _wareHouseMoney = 0,
  _payValue = 0,
  _discountPayValue = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionContract_All_1.lua")
runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionContract_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_MansionContract_Init")
function PaGlobal_MansionContract_Init()
  PaGlobal_MansionContract:initialize()
end
