PaGlobal_Window_Timer = {
  _ui = {
    _stc_TitleArea = nil,
    _txt_Title = nil,
    _btn_Close = nil,
    _stc_MainBG = nil,
    _txt_Minute = nil,
    _txt_Second = nil,
    _btn_Start = nil,
    _edit_Minute = nil,
    _edit_Second = nil
  },
  eTimeIndex = {second = 0, minute = 1},
  _isStart = false,
  _settingMin = 0,
  _settingSec = 0,
  _isSetMin = false,
  _isSetSec = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Timer/Panel_Window_Timer_1.lua")
runLua("UI_Data/Script/Window/Timer/Panel_Window_Timer_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Timer_All_Init")
function FromClient_Window_Timer_All_Init()
  PaGlobal_Window_Timer:initialize()
end
