PaGlobal_RentInstanceField_List = {
  _ui = {
    _stc_titleBG = UI.getChildControl(Panel_RentInstanceField_List, "Static_TitleBG"),
    _stc_mainBG = UI.getChildControl(Panel_RentInstanceField_List, "Static_MainBG")
  },
  _fromTime = 0,
  _toTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_List_1.lua")
runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_List_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RentInstanceField_List_Init")
function FromClient_RentInstanceField_List_Init()
  PaGlobal_RentInstanceField_List:initialize()
end
