PaGlobal_RandomQuestInfo_All = {
  _ui = {
    _txt_questTitle = nil,
    _txt_questDesc = nil,
    _stc_rewardGroupBg = nil,
    _stc_baseRewardBg = nil,
    _stc_baseMenuReward = nil,
    _baseRewardSlotBg = {},
    _baseRewardSlot = {},
    _stc_selectRewardBg = nil,
    _stc_selectMenuReward = nil,
    _selectRewardSlotBg = {},
    _selectRewardSlot = {},
    _txt_agrisPointInfo = nil
  },
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _MAX_BASE_REWARD = 12,
  _MAX_SELECT_REWARD = 6,
  _baseReward = {},
  _uiBackBaseReward = {},
  _listBaseRewardSlots = {},
  _selectReward = {},
  _uiBackSelectReward = {},
  _listSelectRewardSlots = {},
  _rewardTexturePathList = {
    [__eRewardExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardSkillExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExp.dds",
    [__eRewardExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/ExpGrade.dds",
    [__eRewardSkillExpGrade] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/SkillExpGrade.dds",
    [__eRewardLifeExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/EXP.dds",
    [__eRewardIntimacy] = "Icon/New_Icon/00000000_Special_Contributiveness.dds",
    [__eRewardKnowledge] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/00000000_know_icon.dds",
    [__eRewardCharacterStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardFamilyStat] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardFamilyStatPoint] = "Icon/New_Icon/03_ETC/03_Quest_Item/familystat_001.dds",
    [__eRewardSeasonReward] = "Icon/New_Icon/03_ETC/00750592.dds",
    [__eRewardExploreExp] = "Icon/New_Icon/03_ETC/12_DoApplyDirectlyItem/Explore.dds"
  },
  _rewardTypeStr = {
    [__eRewardExp] = "Exp",
    [__eRewardSkillExp] = "SkillExp",
    [__eRewardExpGrade] = "ExpGrade",
    [__eRewardSkillExpGrade] = "SkillExpGrade",
    [__eRewardLifeExp] = "ProductExp",
    [__eRewardIntimacy] = "Intimacy",
    [__eRewardKnowledge] = "Knowledge",
    [__eRewardCharacterStat] = "CharacterStat",
    [__eRewardFamilyStat] = "FamilyStat",
    [__eRewardFamilyStatPoint] = "FamilyStatPoint",
    [__eRewardSeasonReward] = "SeasonReward",
    [__eRewardExploreExp] = "ExploreExp"
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Widget_RandomQuestInfo_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Widget_RandomQuestInfo_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RandomQuestInfo_All_Init")
function FromClient_RandomQuestInfo_All_Init()
  PaGlobal_RandomQuestInfo_All:initialize()
end
