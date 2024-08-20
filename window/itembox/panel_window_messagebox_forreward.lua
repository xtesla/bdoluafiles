PaGlobal_MessageBox_ForReward = {
  _ui = {
    _txt_title = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Static_Text_Title"),
    _btn_apply = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Button_Apply"),
    _btn_cancel = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Button_Cancel"),
    _btn_close = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Button_Close"),
    _stc_keyGuideBg = UI.getChildControl(Panel_Window_MessageBox_ForReward, "Static_BottomBg_ConsoleUI")
  },
  _functionYes = nil,
  _functionNo = nil
}
runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_ForReward_1.lua")
runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_ForReward_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MessageBox_ForReward_Init")
function FromClient_MessageBox_ForReward_Init()
  PaGlobal_MessageBox_ForReward:initialize()
end
