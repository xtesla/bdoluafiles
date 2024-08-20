PaGlobal_Event_Quiz = {
  _ui = {
    _stc_MainBG = nil,
    _txt_questionStr = nil,
    _stc_TimeBG = nil,
    _stc_AnswerBG = nil,
    _stc_ResultBG = nil,
    _txt_Answer = nil,
    _txt_AnswerStr = nil,
    _stc_Correct = nil,
    _stc_Correct_O = nil,
    _stc_Correct_X = nil,
    _stc_Icon_O = nil,
    _stc_Wrong = nil,
    _stc_Wrong_O = nil,
    _stc_Wrong_X = nil,
    _stc_Icon_X = nil,
    _stc_O = nil,
    _stc_O_select = nil,
    _stc_X = nil,
    _stc_X_select = nil,
    _stc_Black_Normal = nil,
    _stc_Black_Select_O = nil,
    _stc_Black_Select_X = nil,
    _stc_Desc = nil,
    _txt_TimerFront = {},
    _txt_TimerBack = {}
  },
  _pc = {
    _btn_TitleClose = nil,
    _btn_Confirm = nil,
    _btn_Close = nil
  },
  _console = {_stc_bottomKeyGuideBg = nil},
  _state = {
    _default = 0,
    _quiz = 1,
    _result = 2
  },
  _isTimerStart = false,
  _elapsedTime = 0,
  _endTime = 0,
  _timeNumUpdateTime = 0,
  _speedSizeUp = 0,
  _speed = 50,
  _nextTimerSizeY = 0,
  _currentState = 0,
  _isConfirm = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Event_Quiz_Init")
function FromClient_PaGlobal_Event_Quiz_Init()
  PaGlobal_Event_Quiz:initialize()
end
