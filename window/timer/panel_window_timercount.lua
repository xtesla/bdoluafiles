PaGlobal_Window_TimerCount = {
  _ui = {
    _stc_TimeCount = nil,
    _txt_Time = nil,
    _txt_TimeCount = nil,
    _stc_GameOverBG = nil,
    _txt_GameOver = nil,
    _txt_CountDown = nil,
    _txt_Retire = nil
  },
  eTimeIndex = {second = 0, minute = 1},
  _isStartPlayer = false,
  _settingMin = 0,
  _settingSec = 0,
  _curTextUpdateTime = 0,
  _initailize = false
}
runLua("UI_Data/Script/Window/Timer/Panel_Window_TimerCount_1.lua")
runLua("UI_Data/Script/Window/Timer/Panel_Window_TimerCount_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_TimerCount_Init")
function FromClient_Window_TimerCount_Init()
  PaGlobal_Window_TimerCount:initialize()
end
