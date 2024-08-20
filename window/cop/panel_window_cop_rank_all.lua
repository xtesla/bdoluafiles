PaGlobal_Cop_Rank = {
  _ui = {btn_close = nil}
}
runLua("UI_Data/Script/Window/Cop/Panel_Window_Cop_Rank_All_1.lua")
runLua("UI_Data/Script/Window/Cop/Panel_Window_Cop_Rank_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InitializeCopRank")
function FromClient_InitializeCopRank()
  PaGlobal_Cop_Rank:initialize()
end
