PaGlobal_HopeGauge = {
  _ui = {
    _btn_Close = nil,
    _btn_ChargeOne = nil,
    _btn_ChargeAll = nil,
    _stc_itemIcon = nil,
    _static_ItemSlots = {}
  },
  _config = {
    _slotConfig = {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createCash = true
    },
    _feedStaticItemCount = 5,
    _startX = 10,
    _startY = 50,
    _gapX = 50,
    _gapY = 40,
    _col = 5,
    _row = 2,
    _checkX = 10,
    _checkY = 5
  },
  _selectItemIndex = -1,
  _selectedCount = 0,
  _selectedPoint = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGauge_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGauge_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HopeGaugeInit")
function FromClient_HopeGaugeInit()
  PaGlobal_HopeGauge:initialize()
end
