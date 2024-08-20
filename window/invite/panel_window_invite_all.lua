PaGlobal_Invite_All = {
  _ui = {
    txt_title = nil,
    btn_close = nil,
    txt_desc = nil,
    stc_subBG = nil,
    chk_familyName = nil,
    rdo_familyName = nil,
    rdo_characterName = nil,
    edit_name = nil,
    btn_confirm = nil,
    btn_cancel = nil,
    stc_keyGuideLB = nil,
    stc_keyGuideRB = nil,
    stc_keyGuideX = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuideA = nil,
    stc_KeyGuideB = nil
  },
  _type = {
    Crew = 0,
    RentInstanceField = 1,
    Count = 2
  },
  _openType = 0,
  _isFamilyName = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Invite/Panel_Window_Invite_All_1.lua")
runLua("UI_Data/Script/Window/Invite/Panel_Window_Invite_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Invite_All_Init")
function FromClient_PaGlobal_Invite_All_Init()
  PaGlobal_Invite_All:initialize()
end
