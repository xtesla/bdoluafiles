PaGlobal_MiniGame_Tooltip_MyDeck = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_Tooltip_MyDeck_Init")
function FromClient_PaGlobal_MiniGame_Tooltip_MyDeck_Init()
  PaGlobal_MiniGame_Tooltip_MyDeck:initialize()
end
