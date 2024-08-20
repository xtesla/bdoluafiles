PaGlobal_MiniGame_Tooltip = {
  _ui = {
    _txt_desc = UI.getChildControl(Panel_Widget_MiniGame_Tooltip, "StaticText_Handranking_Desc")
  },
  _refCount = 0,
  _diceCardListSizeX = 0,
  _diceCardListSizeY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_1.lua")
runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MiniGame_Tooltip_Init")
function FromClient_PaGlobal_MiniGame_Tooltip_Init()
  PaGlobal_MiniGame_Tooltip:initialize()
end
