PaGlobal_MiniGame_YachtDice_Result = {
  _ui = {
    _stc_win = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Static_Title_Win"),
    _stc_lose = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Static_Title_Lose"),
    _stc_tie = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Static_Title_Tie"),
    _stc_reward = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Static_Reward"),
    _btn_exit = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Button_EXIT"),
    _btn_retry = UI.getChildControl(Panel_Widget_MiniGame_YachtDice_Result, "Button_Retry")
  },
  _hostPoint = 0,
  _acceptorPoint = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_YachtDice_Result_Init")
function FromClient_PaGlobal_MiniGame_YachtDice_Result_Init()
  PaGlobal_MiniGame_YachtDice_Result:initialize()
end
