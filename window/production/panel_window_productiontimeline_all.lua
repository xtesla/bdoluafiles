PaGlobal_ProductionTimeline = {
  _ui = {
    stc_panelBG = nil,
    txt_title = nil,
    check_popup = nil,
    btn_close = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionTimeline_All_1.lua")
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionTimeline_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ProductionTimelineInit")
function FromClient_ProductionTimelineInit()
  PaGlobal_ProductionTimeline:initialize()
end
