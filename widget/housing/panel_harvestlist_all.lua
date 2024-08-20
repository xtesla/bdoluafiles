PaGlobal_HarvestList_All = {
  _ui = {stc_InfoArea = nil},
  config = {startPosY = 0, cellSpan = 3},
  _ui_pc = {btn_Exit = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideY = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  slot = {},
  _maxTentCount = 10,
  _selectInfoIndex = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Housing/Panel_HarvestList_All_1.lua")
runLua("UI_Data/Script/Widget/Housing/Panel_HarvestList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClientHarvestList_All_Init")
function FromClientHarvestList_All_Init()
  PaGlobal_HarvestList_All:initialize()
end
