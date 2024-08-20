PaGlobal_Dye_Palette_All = {
  _ui = {
    btn_TabList = {},
    stc_Line = nil,
    txt_SelectedMaterialName = nil,
    stc_All_Mine_BG = nil,
    stc_slotBG = nil,
    stc_Mix_BG = nil,
    stc_slotList = {},
    txt_MixInfo = nil,
    stc_SelectedAmpule = nil,
    txt_SelectedAmpuleName = nil,
    stc_ScrollArea = nil,
    scroll = nil,
    scrollBtn = nil
  },
  _ui_pc = {
    btn_Close = nil,
    btn_Help = nil,
    btn_Withdraw = nil,
    btn_MixColor = nil
  },
  _ui_console = {
    stc_Console_KeyGuide = nil,
    stc_KeyGuideLB = nil,
    stc_KeyGuideRB = nil,
    stc_KeyGuideLT = nil,
    stc_KeyGuideRT = nil,
    stc_KeyGuideBG = nil,
    txt_KeyGuidePaletteA = nil,
    txt_KeyGuideMixA = nil,
    txt_KeyGuideB = nil
  },
  config = {
    maxSlotColsCount = 10,
    maxSlotRowsCount = 6,
    startPosX = 15,
    startPosY = 0,
    cellSpan = 3,
    selectedTabIdx = 0,
    selectedCategoryIdx = 0,
    selectedColorIdx = nil,
    scrollStartIdx = 0,
    colorTotalRows = 0
  },
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = true
  },
  _TAB_TYPE = {
    ALL = 0,
    MINE = 1,
    MIX = 2,
    COUNT = 3
  },
  slot = {},
  _materialCount = 8,
  _rdo_Material = {},
  _materialName = {},
  _mixSlotCount = 3,
  _initialize = false
}
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Dye_Palette_All_1.lua")
runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Dye_Palette_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Dye_PaletteInit")
function FromClient_Dye_PaletteInit()
  PaGlobal_Dye_Palette_All:initialize()
end
