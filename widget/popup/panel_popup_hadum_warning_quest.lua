PaGlobal_HadumWarning_Quest = {
  _ui = {
    stc_InfoArea = nil,
    btn_TodayNotShow = nil,
    btn_Yes = nil
  },
  _openFlag = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_Quest_1.lua")
runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_Quest_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_HadumWarning_Quest")
function FromClient_PaGlobal_HadumWarning_Quest()
  PaGlobal_HadumWarning_Quest:initialize()
end
