PaGlobal_Worldmap_Grand_GuildColorList = {
  _ui = {_list2 = nil}
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_GuildColorList_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_GuildColorList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_Worldmap_Grand_GuildColorListInit")
function FromClient_luaLoadComplete_Worldmap_Grand_GuildColorListInit()
  PaGlobal_Worldmap_Grand_GuildColorList:initialize()
end
