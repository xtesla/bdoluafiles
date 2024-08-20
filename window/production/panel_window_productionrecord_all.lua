PaGlobal_ProductionRecord_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_Title = nil,
    btn_close = nil,
    txt_recordName = nil,
    txt_recordLength = nil,
    btn_endRecord = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionRecord_All_1.lua")
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionRecord_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ProductionRecord_All_Init")
function PaGlobal_ProductionRecord_All_Init()
  PaGlobal_ProductionRecord_All:initailze()
end
