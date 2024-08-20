PaGlobal_Worldmap_TentInfo_All = {
  _ui = {
    txt_RemainTime = nil,
    txt_SeedInfo = nil,
    txt_Percent = nil
  },
  config = {
    startPosY = 40,
    cellSpan = 3,
    panelSizeY = 0,
    slotSizeY = 0
  },
  slot = {},
  _maxHarvestCount = 0,
  _selectTentActorKey = nil,
  _selectTentID = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_TentInfo_All_1.lua")
runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_TentInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Worldmap_TentInfo_All_Init")
function FromClient_Worldmap_TentInfo_All_Init()
  PaGlobal_Worldmap_TentInfo_All:initialize()
end
