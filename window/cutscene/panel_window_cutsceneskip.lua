PaGlobal_CutSceneSkip = {
  _ui = {
    _stc_territoryArea = UI.getChildControl(Panel_Window_CutSceneSkip, "Static_TerritoryArea"),
    _txt_title = UI.getChildControl(Panel_Window_CutSceneSkip, "StaticText_Title"),
    _stc_textArea = UI.getChildControl(Panel_Window_CutSceneSkip, "Static_TextArea"),
    _txt_subDesc = UI.getChildControl(Panel_Window_CutSceneSkip, "StaticText_SubTitle"),
    _btn_skip = UI.getChildControl(Panel_Window_CutSceneSkip, "Button_Skip"),
    _btn_close = UI.getChildControl(Panel_Window_CutSceneSkip, "Button_Close")
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneSkip_1.lua")
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneSkip_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CutSceneSkip_Init")
function FromClient_CutSceneSkip_Init()
  PaGlobal_CutSceneSkip:initialize()
end
