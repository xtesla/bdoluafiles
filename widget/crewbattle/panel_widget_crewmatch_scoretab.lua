PaGlobal_CrewMatch_ScoreTab = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_ScoreTab_1.lua")
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_ScoreTab_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CrewMatch_ScoreTab_Init")
function FromClient_CrewMatch_ScoreTab_Init()
  PaGlobal_CrewMatch_ScoreTab:initialize()
end
