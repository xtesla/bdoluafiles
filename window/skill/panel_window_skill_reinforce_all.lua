PaGlobal_SkillReinforce_All = {
  _ui = {
    stc_TitleBg = nil,
    btn_Exit = nil,
    btn_Help = nil,
    stc_SkillReinforceBg = nil,
    stc_SkillReinforceArea = nil,
    stc_Circle = nil,
    stc_CircleEffect = nil,
    stc_CirclurProgress = nil,
    stc_CircleSkillSlotBg = nil,
    stc_CircleSkillIcon = nil,
    stc_CircleSkillIconOff = nil,
    stc_CircleSkillIconOn = nil,
    btn_ReinforceBtn = nil,
    stc_SkillSelectArea = nil,
    txt_SelectSkillTitle = nil,
    btn_SelectSkillBtn = nil,
    stc_SelectSkillIcon = nil,
    txt_SelectSkillName = nil,
    txt_SelectSkillInfo = nil,
    stc_SelectSkillPlus = nil,
    txt_SelectSkill = nil,
    stc_EffectSelectArea = nil,
    txt_SelectEffectTitle = nil,
    btn_SelectEffectbtn1 = nil,
    txt_Effect1 = nil,
    txt_SelectEffect1 = nil,
    stc_SelectPlus1 = nil,
    btn_SelectEffectbtn2 = nil,
    txt_Effect2 = nil,
    txt_SelectEffect2 = nil,
    stc_SelectPlus2 = nil,
    stc_SelectSkillMain = nil,
    stc_SelectSkillTitleArea = nil,
    btn_SelectSkillExit = nil,
    stc_SelectSkillArea = nil,
    list_SkillList = nil,
    content_Skill = nil,
    stc_SelectEffectMain = nil,
    stc_SelectEffectTitle = nil,
    btn_SelectEffectExit = nil,
    stc_SelectEffectArea = nil,
    list_OptionList = nil,
    txt_InfoArea = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_keyGuideClose = nil,
    stc_keyGuideSelect = nil,
    stc_keyGuideChangeSkill = nil,
    stc_keyGuideDetail = nil
  },
  _currentSkillNo = nil,
  _currentSkillIndex = nil,
  _currentOptionIndex1 = nil,
  _currentOptionIndex2 = nil,
  _haveOptionIndex = nil,
  _beforeSkillIndex = nil,
  _isFirstChangeOption = nil,
  _isStartAwaken = false,
  _isEndCircular = false,
  _currentTimer = 0,
  _currentRate = 0,
  _endCircular = 0,
  _endTime = 0,
  _deltaTime = 0,
  _tmpValue = 0,
  _isCompleteCircular = false,
  _inSkillIndex = nil,
  _skillListData = {},
  _type = -1,
  _isAddOption = false,
  eSelectButtonType = {
    selectSkill = 0,
    skillList = 1,
    skillOption = 2,
    skillOptionList = 3
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Reinforce_All_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Reinforce_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Skill_Reinforce_All_Init")
registerEvent("FromClient_SuccessSkillAwaken", "FromClient_SuccessSkillReinforceAll")
registerEvent("FromClient_ChangeSkillAwakeningBitFlag", "FromClient_SuccessSkillReinforceAll")
registerEvent("FromClient_ChangeAwakenSkill", "FromClient_SuccessSkillReinforceAll")
function FromClient_Skill_Reinforce_All_Init()
  PaGlobal_SkillReinforce_All:initialize()
end
