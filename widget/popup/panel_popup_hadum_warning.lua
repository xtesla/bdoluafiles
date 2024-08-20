PaGlobal_Popup_HadumWarning = {
  _ui = {btn_Yes = nil, btn_No = nil},
  _selectServerNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_1.lua")
runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_PaGlobal_Popup_HadumWarning")
function FromClient_PaGlobal_Popup_HadumWarning()
  PaGlobal_Popup_HadumWarning:initialize()
end
