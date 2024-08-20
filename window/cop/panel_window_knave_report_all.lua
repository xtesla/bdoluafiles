PaGlobal_Knave_Report = {
  _ui = {
    list2 = nil,
    btn_Close = nil,
    stc_descBG = nil,
    stc_desc = nil,
    stc_notarget = nil,
    btn_cancel = nil,
    btn_report = nil
  },
  _reportIndex = -1
}
runLua("UI_Data/Script/Window/Cop/Panel_Window_Knave_Report_All_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ContentsKnaveReport")
function FromClient_ContentsKnaveReport()
  PaGlobal_Knave_Report:initialize()
end
