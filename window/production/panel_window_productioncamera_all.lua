PaGlobal_ProductionCamera_All = {
  _ui = {
    stc_TitleBg = nil,
    txt_Title = nil,
    stc_SubBg = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    edit_GroupName = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionCamera_All_1.lua")
runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionCamera_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ProductionCamera_All_Init")
function PaGlobal_ProductionCamera_All_Init()
  PaGlobal_ProductionCamera_All:initailze()
end
