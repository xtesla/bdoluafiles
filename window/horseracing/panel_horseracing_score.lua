PaGlobal_HorseRacing_Score = {
  _ui = {
    stc_RankingList = nil,
    stc_rankerListBG = nil,
    stc_rankerList = {},
    stc_retireList = {},
    stc_retire = nil,
    btn_exit = nil,
    stc_exitConsole = nil
  },
  _slotConfig = {
    createIcon = false,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createCash = false,
    createOriginalForDuel = true
  },
  _maxPlayer = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Score_1.lua")
runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Score_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_ScoreInit")
function FromClient_HorseRacing_ScoreInit()
  PaGlobal_HorseRacing_Score:initialize()
end
