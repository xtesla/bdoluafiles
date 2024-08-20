PaGlobal_Event_QuizGM = {
  _ui = {
    _btn_Close = nil,
    _stc_MainBG = nil,
    _edit_question = nil,
    _rdo_answer_O = nil,
    _rdo_answer_X = nil,
    _btn_sendQuestion = nil,
    _btn_answerPick = nil,
    _btn_answerConfirm = nil,
    _btn_kickFail = nil,
    _btn_endGame = nil,
    _btn_enterDisable = nil,
    _btn_setTimer = nil,
    _txt_SetTimer = nil,
    _edit_Timer = nil,
    _txt_CurTimer = nil,
    _txt_playerCount = nil,
    _btn_setPlayerCount = nil,
    _btn_invalidity = nil
  },
  _markButtonUI = {},
  _operationNames = {},
  eQuizAnswerType = {
    eQuizAnswerType_None = 0,
    eQuizAnswerType_OX_O = 1,
    eQuizAnswerType_OX_X = 2
  },
  eQuizGameOperationType = {
    eQuizGameOperationType_NotifyQuestion = 0,
    eQuizGameOperationType_SetAnswer = 1,
    eQuizGameOperationType_CheckAnswer = 2,
    eQuizGameOperationType_SetTimer = 3,
    eQuizGameOperationType_KickPlayer = 4,
    eQuizGameOperationType_EndQuizGame = 5,
    eQuizGameOperationType_SetEnterAble = 6,
    eQuizGameOperationType_SetPlayerCount = 7,
    eQuizGameOperationType_Invalidity = 8,
    eQuizGameOperationType_SyncPlayerCount = 9,
    eQuizGameOperationType_Count = 10
  },
  _elapsedTime = 0,
  _endTime = 0,
  _answerType = 1,
  _syncPlayerElapsedTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_QuizGM_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_QuizGM_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Event_QuizGM_Init")
function FromClient_PaGlobal_Event_QuizGM_Init()
  PaGlobal_Event_QuizGM:initialize()
end
