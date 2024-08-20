PaGlobal_Window_FairyRateDesc = {
  _ui = {
    _btn_Close_top = nil,
    _btn_Close_bottom = nil,
    _stc_KeyGuide_ConsoleUI = nil,
    _frame_1 = nil,
    _frame_1_Content = nil,
    _txt_Desc = nil,
    _frame_scroll = nil,
    _txt_B_ConsoleUI = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyRateDesc_1.lua")
runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyRateDesc_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_FairyRateDescInit")
function FromClient_Window_FairyRateDescInit()
  PaGlobal_Window_FairyRateDesc:initialize()
end
