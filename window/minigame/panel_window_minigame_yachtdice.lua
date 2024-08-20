PaGlobal_MiniGame_YachtDice = {
  _ui = {
    _stc_titleBG = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_TitleArea_Import"),
    _stc_leftBG = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_LeftArea"),
    _stc_rightBG = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_RightArea"),
    _stc_consoleKeyGuideBG = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_KeyGuide_ConsoleUI")
  },
  __eYachtPlayerType_Me = 0,
  __eYachtPlayerType_You = 1,
  __eYachtPlayerType_Count = 2,
  _symbolString = {
    [__eYachtSymbol_Spade] = "Space",
    [__eYachtSymbol_Dia] = "Diamonds",
    [__eYachtSymbol_Heart] = "Heart",
    [__eYachtSymbol_Clover] = "Clover"
  },
  _startTime = 0,
  _endTime = 0,
  _delayTime = 0,
  _rollCardList = {},
  _drawCardList = {},
  _drawCardCount = 0,
  _drawIndex = nil,
  _isDrawCard = nil,
  _fieldCardKeepIndex = nil,
  _npcActionEventTime = 0,
  _npcActionEventMaxTime = 0,
  _isUpdateNpcEvent = false,
  _turnRemainTime = 0,
  _isTimeOutEffectShow = true,
  _soundTime = 0,
  _renderEventType = {
    None = 0,
    DrawFieldCard = 1,
    BeforeGameStart = 2,
    ChangeTurn = 3,
    Keep = 4
  },
  _currentRenderEventType = nil,
  _isEventStartHandRank = false,
  _eventHandRankTime = 0,
  _isTotalScoreEffectShow = false,
  _isTimeOut = false,
  _isConsole = false,
  _selectedKeepCardIndex = nil,
  _selectedCheckHandIndex = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_YachtDice_Init")
function FromClient_PaGlobal_MiniGame_YachtDice_Init()
  PaGlobal_MiniGame_YachtDice:initialize()
end
