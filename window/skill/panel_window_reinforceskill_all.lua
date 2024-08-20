PaGlobal_ReinforceSkill_All = {
  _ui = {
    stc_titleBg = nil,
    btn_Help = nil,
    btn_Exit = nil,
    stc_NormalSkillBG = nil,
    txt_NormalSkill = nil,
    stc_NormalSkillList = nil,
    stc_SpecialSkillBg = nil,
    txt_SpecialSkill = nil,
    stc_SpecialSkillList = nil,
    txt_NoSkill = nil,
    stc_InfoBg = nil,
    txt_Info = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_keyGuideSelect = nil,
    stc_keyGuideClose = nil,
    stc_keyGuideReinforce = nil,
    stc_keyGuideDetail = nil
  },
  _reinforceNormalSkillViewCount = 3,
  _reinforceSpecialSkillViewCount = 3,
  _reinforceMaxSkillViewCount = 6,
  _reinforceNormalSkillControl = {},
  _reinforceSpecialSkillControl = {},
  _normalSkillReinforceAbleLevel = {
    [0] = 50,
    52,
    54
  },
  _specialSkillReinforceAbleLevel = {
    [0] = 56,
    58,
    60
  },
  _totalSkillReinforceAbleLevel = {
    [0] = 50,
    52,
    54,
    56,
    58,
    60
  },
  _effectIndex = -1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_ReinforceSkill_All_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_ReinforceSkill_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ReinforceSkill_All_Init")
function FromClient_ReinforceSkill_All_Init()
  PaGlobal_ReinforceSkill_All:initialize()
end
