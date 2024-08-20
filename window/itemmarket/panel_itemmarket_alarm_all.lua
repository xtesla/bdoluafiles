PaGlobal_ItemMarketAlarm = {
  _ui = {
    _stc_itemIcon = nil,
    _txt_itemName = nil,
    _txt_itemRegistTime = nil,
    _btn_confirm = nil,
    _btn_cancel = nil
  },
  _consoleSizeY = 0,
  _defaultSizeY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_Alarm_All_1.lua")
runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_Alarm_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ItemMarketAlarmInit")
function FromClient_ItemMarketAlarmInit()
  PaGlobal_ItemMarketAlarm:initialize()
end
