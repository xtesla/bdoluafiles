PaGlobal_Guild_Point = {
  _ui = {
    stc_title = nil,
    btn_close = nil,
    stc_leftArea = nil,
    stc_circleArea = nil,
    stc_progress = nil,
    txt_guildPoint = nil,
    txt_guildPointTotal = nil,
    txt_guildPointExp = nil,
    txt_state = nil,
    stc_mouseGuide = nil,
    stc_guildArea = nil,
    stc_guildIconBg = nil,
    stc_guildIcon = nil,
    txt_guildName = nil,
    txt_guildLeaderName = nil,
    txt_voteValue = nil,
    txt_noGuild = nil,
    btn_timeLog = nil,
    btn_vote = nil,
    txt_voteBtnName = nil,
    btn_voteRefresh = nil,
    txt_territoryName = nil,
    frame_Skill = nil,
    btn_territory = {},
    list2 = nil,
    list2_content = nil,
    txt_noPolicy = nil,
    stc_resultBG = nil,
    txt_resultTerritoryName = nil,
    txt_resultVote = nil,
    stc_rankList = {}
  },
  slotConfig = {
    createIcon = true,
    createEffect = true,
    createFG = true,
    createFGDisabled = true,
    createFG_Passive = true,
    createLevel = true,
    createLearnButton = true,
    createCooltime = true,
    createCooltimeText = true,
    template = {}
  },
  config = {
    slotStartX = 10,
    slotStartY = 6,
    slotGapX = 42,
    slotGapY = 42,
    emptyGapX = 22,
    emptyGapY = 18
  },
  _direction = {
    [0] = {_col = -1, _row = 0},
    [1] = {_col = 1, _row = 0},
    [2] = {_col = 0, _row = -1},
    [3] = {_col = 0, _row = 1}
  },
  slots = {},
  skillNoSlot = {},
  template_guideLine = {},
  guideLineTable = {},
  territoryIndex = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4
  },
  _selectTerritoryKey = 3,
  _guildPolicyTimeType = __eGuildPolicyTimeType_Count,
  _isApplicationTime = false,
  _contentSize = 0,
  _ACTIVE_POLICY_INVEST_TYPE = 100,
  _MAX_RANK = 5,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Guild_Point_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Guild_Point_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_Point")
function FromClient_Guild_Point()
  PaGlobal_Guild_Point:initialize()
end
