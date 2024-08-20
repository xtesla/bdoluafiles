PaGlobal_GuildWarInfo_All = {
  _ui = {
    stc_NoOccupantBg = nil,
    stc_LeftGuild_Bg = nil,
    stc_RightGuild_Bg_2 = nil,
    stc_RightGuild_Bg_4 = nil,
    stc_RightGuild_Bg_list = nil,
    stc_TabBg = nil,
    btn_Territory = {},
    stc_SelectLine = nil,
    stc_FinishBg = nil,
    txt_Finish_Desc = nil,
    txt_Result_Desc = nil,
    btn_Reload = nil,
    txt_Title = nil,
    btn_Small = nil,
    btn_Close = nil,
    stc_KeyGuide = nil,
    btn_Rank = nil,
    btn_RankIcon = nil,
    stc_Score_No1 = nil,
    stc_Score_No2 = nil,
    stc_Score_LeftScore = nil,
    stc_Score_LeftScore_No2 = nil,
    stc_Score_LeftScore_No3 = nil,
    stc_SiegeGuildList = nil,
    stc_GuildList = nil,
    stc_GuildList_No1 = nil
  },
  _isSiegeBeing = false,
  _selectedTerritoryKey = 0,
  _defenceGuildInfo = nil,
  _offenceGuildInfo_2 = {},
  _offenceGuildInfo_4 = {},
  _offenceGuildInfo_list = nil,
  _offenceGuildListInfo = {},
  _defenceGuildNo = nil,
  _offenceGuildNoList = {},
  _defenceGuildIndex = 999,
  _reloadTimer = 0,
  _MAXTERRITORYCOUNT = 5,
  _isRankOpen = false,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfo_All_1.lua")
runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWarInfo_All_Init")
function FromClient_GuildWarInfo_All_Init()
  PaGlobal_GuildWarInfo_All:initialize()
end
