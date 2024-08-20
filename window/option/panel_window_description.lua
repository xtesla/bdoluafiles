PaGlobal_Window_Description = {
  _ui = {
    _stc_TitleArea = nil,
    _txt_Title = nil,
    _btn_Close = nil,
    _stc_MainBG = nil,
    _stc_DescBG = nil,
    _txt_Desc = nil
  },
  _initailize = false
}
runLua("UI_Data/Script/Window/Option/Panel_Window_Description_1.lua")
runLua("UI_Data/Script/Window/Option/Panel_Window_Description_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Description_Init")
function FromClient_Window_Description_Init()
  PaGlobal_Window_Description:initialize()
end
