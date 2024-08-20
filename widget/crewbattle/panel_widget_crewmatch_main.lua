PaGlobal_CrewMatch_Main = {
  _ui = {
    _stc_mainBG = UI.getChildControl(Panel_Widget_CrewMatch_Main, "Static_MainBG")
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_Main_1.lua")
runLua("UI_Data/Script/Widget/CrewBattle/Panel_Widget_CrewMatch_Main_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CrewMatch_Main_Init")
function FromClient_CrewMatch_Main_Init()
  PaGlobal_CrewMatch_Main:initialize()
end
