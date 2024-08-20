PaGlobal_CreateCrew_All = {
  _ui = {
    stc_titleBG = nil,
    btn_question = nil,
    btn_close = nil,
    stc_descBG = nil,
    txt_desc = nil,
    btn_confirm = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuideA = nil,
    stc_KeyGuideB = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CreateCrew_All_1.lua")
runLua("UI_Data/Script/Window/CrewBattle/Panel_Window_CreateCrew_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_CreateCrew_All_Init")
function FromClient_PaGlobal_CreateCrew_All_Init()
  PaGlobal_CreateCrew_All:initialize()
end
