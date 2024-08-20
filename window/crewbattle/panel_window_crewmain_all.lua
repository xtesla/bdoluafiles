PaGlobal_CrewMain_All = {
  _ui = {
    stc_mainBG = nil,
    stc_titleBG = nil,
    btn_close = nil,
    stc_crewInfoBG = nil,
    txt_crewName = nil,
    txt_crewMasterName = nil,
    edit_comment = nil,
    btn_saveNotice = nil,
    btn_destroyCrew = nil,
    txt_winRate = nil,
    txt_gameRecord = nil,
    stc_crewMemberBG = nil,
    txt_currentMemberCount = nil,
    txt_maxMemberCount = nil,
    list2_crewMember = nil,
    stc_entryBG = nil,
    stc_entryListBG = nil,
    stc_entrySlotTemplate = nil,
    txt_currentEntryMemberCount = nil,
    txt_maxEntryMemberCount = nil,
    entryMemberList = {},
    btn_inviteCrewMember = nil,
    btn_startMatch = nil,
    stc_subMenuBG = nil,
    btn_whisper = nil,
    btn_inviteParty = nil,
    btn_changeMaster = nil,
    btn_disjoin = nil,
    btn_kick = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuideY = nil,
    stc_KeyGuideX = nil,
    stc_KeyGuideA = nil,
    stc_KeyGuideB = nil,
    stc_KeyGuideLTY = nil,
    stc_KeyGuideLS = nil,
    stc_KeyGuideRS = nil
  },
  _subMenuIndex = {
    WHISPER = 0,
    INVITEPARTY = 1,
    CHANGEMASTER = 2,
    DISJOIN = 3,
    KICKMEMBER = 4
  },
  _maxEntryCount = 10,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CrewMain_All_1.lua")
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CrewMain_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_CrewMain_All_Init")
function FromClient_PaGlobal_CrewMain_All_Init()
  PaGlobal_CrewMain_All:initialize()
end
