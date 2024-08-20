PaGlobal_RentInstanceField_Time = {
  _ui = {
    _stc_timeBG = UI.getChildControl(Panel_RentInstanceField_Time, "Static_TimeCount"),
    _stc_memberBG = UI.getChildControl(Panel_RentInstanceField_Time, "Static_MemberCount")
  },
  _toTime = 0,
  _fromTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Time_1.lua")
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Time_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RentInstanceField_Time_Init")
function FromClient_RentInstanceField_Time_Init()
  PaGlobal_RentInstanceField_Time:initialize()
end
