PaGlobal_Widget_CrewMatch_Count = {
  _ui = {
    stc_count = {}
  },
  _initialize = false,
  _currentCount = 10,
  _updateCurrentTime = 1
}
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_Count_1.lua")
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_Count_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CrewMatchCountInit")
function FromClient_CrewMatchCountInit()
  PaGlobal_Widget_CrewMatch_Count:initialize()
end
