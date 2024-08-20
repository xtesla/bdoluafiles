PaGlobal_ExpirationPeriodItem = {
  _ui = {
    _btn_close = UI.getChildControl(Panel_Window_ExpirationPeriodItem, "Button_Exit"),
    _btn_check = UI.getChildControl(Panel_Window_ExpirationPeriodItem, "Button_Check"),
    _btn_TodayNotShow = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ExpirationPeriodItem_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ExpirationPeriodItem_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExpirationPeriodItem_Init")
function FromClient_ExpirationPeriodItem_Init()
  PaGlobal_ExpirationPeriodItem:initialize()
end
