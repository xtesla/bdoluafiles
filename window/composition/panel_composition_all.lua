PaGlobal_Composition_All = {
  _ui = {
    _txt_titleBar = nil,
    _stc_decoration = nil,
    _btn_close = nil,
    _btn_refresh = nil,
    _btn_small = nil,
    _btn_big = nil,
    _webControl = nil
  },
  _eScreenMode = {eScreenModeWindow = 0, eScreenModeFull = 1},
  _web_basicPos = {x = 10, y = 61},
  _web_size = {},
  _panel_size = {},
  _initialize = false,
  _musicIndex = nil,
  _fullScreenMode = nil,
  _tempSaveTimer = 60,
  _updateTempSaveTime = 0
}
runLua("UI_Data/Script/Window/Composition/Panel_Composition_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Composition_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Composition_All_Init")
function FromClient_Composition_All_Init()
  PaGlobal_Composition_All:initialize()
end
