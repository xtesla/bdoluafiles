PaGloabal_SkillPresetMemo = {
  _ui = {
    stc_titleBg = nil,
    txt_title = nil,
    btn_close = nil,
    stc_mainBg = nil,
    btn_write = nil,
    btn_reset = nil,
    edit_memo = nil,
    stc_keyGuideBg = nil,
    stc_keyGuide_A = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_X = nil,
    stc_keyGuide_Y = nil
  },
  _selectSlotNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPresetMemo_1.lua")
runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPresetMemo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillPresetMemo_Init")
function FromClient_SkillPresetMemo_Init()
  PaGloabal_SkillPresetMemo:initialize()
end
