PaGlobal_GuildHouse_Auction_Detail_All = {
  _ui = {
    stc_subFrameBg = nil,
    stc_descBg = nil,
    stc_desc = nil,
    stc_image = nil
  },
  _ui_pc = {btn_close = nil, btn_bid = nil},
  _ui_console = {
    stc_bottom = nil,
    stc_cancel = nil,
    stc_apply = nil
  },
  _initialize = false,
  _isConsole = false,
  _houseTabType = nil,
  _houseIndex = nil,
  _sizeY = {
    CONSOLE_PANEL = 605,
    PC_PANEL = 665,
    CONSOLE_BG = 555,
    PC_BG = 615,
    DESC_BG = 0
  },
  _subFrameBgSizeY = 0,
  _panelSizeY = 0
}
runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Detail_All_1.lua")
runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Detail_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildHouse_Auction_Detail_AllInit")
function FromClient_GuildHouse_Auction_Detail_AllInit()
  PaGlobal_GuildHouse_Auction_Detail_All:initialize()
end
