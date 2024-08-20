PaGlobal_Event_Quiz_Minimal = {
  _ui = {
    _progress_Bg = nil,
    _progressBar = nil,
    _stc_wait = nil,
    _stc_ing = nil,
    _stc_openQuize = nil
  },
  _state = {
    _default = 0,
    _quiz = 1,
    _result = 2
  },
  _currentState = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_Minimal_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_Minimal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Event_Quiz_MinimalInit")
function FromClient_Event_Quiz_MinimalInit()
  PaGlobal_Event_Quiz_Minimal:initialize()
end
