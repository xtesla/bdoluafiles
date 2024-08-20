PaGlobal_MansionRank_All = {
  _ui = {
    stc_titleBg = nil,
    btn_close = nil,
    stc_tabBg = nil,
    rdo_tabList = {},
    stc_selectLine = nil,
    stc_rankTitleBg = nil,
    txt_titleRank = nil,
    txt_titleName = nil,
    txt_titleGuild = nil,
    txt_titlePoint = nil,
    list2_Ranking = nil
  },
  _ui_console = {stc_keyGuideLT = nil, stc_keyGuideRT = nil},
  _rankType = {
    SERVER = 0,
    FRIEND = 1,
    GUILD = 2,
    WORLD = 3,
    COUNT = 4
  },
  _currentTab = 0,
  _mansionKey = 3814,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionRank_All_1.lua")
runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionRank_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MansionRank_All_Init")
function FromClient_MansionRank_All_Init()
  PaGlobal_MansionRank_All:initialize()
end
