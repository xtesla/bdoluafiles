PaGlobal_Guild_NoneGuild = {
  _ui = {
    _btn_close = nil,
    _categoryType = nil,
    _stc_selectLine = nil,
    _stc_LBIcon = nil,
    _stc_RBIcon = nil,
    _btn_refresh = nil,
    _edit_Search = nil,
    _list2_guildList = nil,
    _txt_search = nil,
    _btn_search = nil,
    _stc_edge = nil,
    _btn_applyJoin = nil,
    _btn_guildInfo = nil,
    _btn_applyJoinList = nil,
    _btn_recommend = nil,
    _txt_sort_name = nil,
    _txt_sort_membercount = nil,
    _stc_descBG = nil,
    _txt_desc = nil,
    _txt_noSelectGuild = nil
  },
  _selectedIndex = 0,
  _guildSlotIndex = -1,
  _isApplyListOpen = false,
  _listGuildNameOriginPosX = 0,
  _isSearchList = false,
  _searchIndex = {},
  _lastOrder = nil,
  _nameSort = true,
  _membercountSort = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_NoneGuild_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_NoneGuild_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildNoneGuild_Init")
function FromClient_GuildNoneGuild_Init()
  PaGlobal_Guild_NoneGuild:init()
end
