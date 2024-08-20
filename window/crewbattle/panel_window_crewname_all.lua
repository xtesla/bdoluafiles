PaGlobal_CrewName_All = {
  _ui = {
    btn_close = nil,
    stc_nameBg = nil,
    edit_crewName = nil,
    stc_keyGuideX = nil,
    stc_textICon = nil,
    btn_checkDuplicate = nil,
    stc_descBG = nil,
    txt_desc = nil,
    btn_confirm = nil,
    btn_cancel = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuideY = nil,
    stc_KeyGuideA = nil,
    stc_KeyGuideB = nil
  },
  _isValidCrewName = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CrewName_All_1.lua")
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CrewName_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_CrewName_All_Init")
function FromClient_PaGlobal_CrewName_All_Init()
  PaGlobal_CrewName_All:initialize()
end
