PaGlobal_Arsha_Replay_Party_All = {
  _ui = {
    _leftTeam = {
      tc_mainBg = nil,
      stc_teamNameBg = nil,
      txt_teamName = nil,
      stc_memberTemplate = nil,
      stc_buffList = {}
    },
    _rightTeam = {
      stc_mainBg = nil,
      stc_teamNameBg = nil,
      txt_teamName = nil,
      stc_memberTemplate = nil,
      stc_buffList = {}
    }
  },
  _freeForAllTeamLimit = CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit,
  _freeForAllWinTeamLimit = CppEnums.CompetitionFreeForAll.eFreeForAllWinTeamLimit,
  _buffMaxCount = 4,
  _teamMember = {},
  _teamMemberUi = {},
  _isCreate = false,
  _isConsole = false,
  _initialize = false,
  _replayMemberUiOffsetY = 200,
  _isCreatePersonal = false,
  _leftScore = 0,
  _rightScore = 0,
  _isFinish = false
}
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Replay_Party_All_1.lua")
runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Replay_Party_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_Replay_Party_All_Init")
function FromClient_Arsha_Replay_Party_All_Init()
  PaGlobal_Arsha_Replay_Party_All:initialize()
end
