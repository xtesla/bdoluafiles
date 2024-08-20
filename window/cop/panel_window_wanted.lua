PaGlobal_Window_Wanted = {
  _ui = {
    _stc_TitleBg = nil,
    _btn_Close = nil,
    _stc_listBg = nil,
    _list2_Wanted = nil,
    _scroll_listWanted = nil
  },
  _badPlayerInfo = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/Cop/Panel_Window_Wanted_1.lua")
runLua("UI_Data/Script/Window/Cop/Panel_Window_Wanted_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_WantedInit")
function FromClient_Window_WantedInit()
  PaGlobal_Window_Wanted:initialize()
end
