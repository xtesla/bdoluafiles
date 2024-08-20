PaGlobal_Widget_HotDeal_All = {
  _ui = {
    _btn_deal = nil,
    _stc_image = nil,
    _txt_title = nil,
    _stc_timeBg = nil,
    _txt_time = nil,
    _stc_clockIcon = nil
  },
  _salesStartTime = nil,
  _salesEndTime = nil,
  _curUpdateTime = 0,
  _maxUpdateTime = 0.25,
  _curEffectTime = 0,
  _maxEffectTime = 0.5,
  _isTimeTextRedColor = false,
  _lastReminedTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_Widget_HotDeal_All_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_Widget_HotDeal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_HotDeal_All_Init")
function FromClient_Widget_HotDeal_All_Init()
  PaGlobal_Widget_HotDeal_All:initialize()
end
