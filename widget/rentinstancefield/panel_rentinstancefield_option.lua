PaGlobal_RentInstanceField_Option = {
  _ui = {
    _stc_titleBG = UI.getChildControl(Panel_RentInstanceField_Option, "Static_TitleBG"),
    _stc_mainBG = UI.getChildControl(Panel_RentInstanceField_Option, "Static_MainBG"),
    _btn_invite = UI.getChildControl(Panel_RentInstanceField_Option, "Button_Invite"),
    _btn_cancel = UI.getChildControl(Panel_RentInstanceField_Option, "Button_Close")
  },
  _userInfoList = {},
  _hostUserNo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Option_1.lua")
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Option_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RentInstanceField_Option_Init")
function FromClient_RentInstanceField_Option_Init()
  PaGlobal_RentInstanceField_Option:initialize()
end
