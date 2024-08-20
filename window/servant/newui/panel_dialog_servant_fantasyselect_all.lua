PaGlobal_Servant_FantasySelect_All = {
  _ui = {
    _stc_Title = nil,
    _txt_Title = nil,
    _btn_Question = nil,
    _btn_Close = nil,
    _stc_Bg = nil,
    _btn_Select = nil,
    _btn_Cancel = nil,
    _list2_Servant = nil,
    _list2_Content = nil,
    _list2_Btn_List = nil,
    _list2_Image = nil,
    _list2_GenderIcon = nil,
    _list2_ServantName = nil,
    _txt_NoHorse = nil,
    _stc_Bottom_KeyGuide = nil,
    _stc_KeyGuide_Y = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil
  },
  _servantDataTable = {},
  _selectServantData = nil,
  _isMale = false,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Servant_FantasySelect_All_Init")
function FromClient_Servant_FantasySelect_All_Init()
  PaGlobal_Servant_FantasySelect_All:initialize()
end
