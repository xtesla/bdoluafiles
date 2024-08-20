PaGlobal_House_InstallationMode_KeyGuide_All = {
  _ui = {
    _stc_commandBg = nil,
    _txt_speedWheelDesc = nil,
    _stc_showCommandBg = nil,
    _btn_showCommand = nil
  },
  _keyGuideBgList = {},
  _eKeyType = {
    ROTATE_LEFT = 1,
    ROTATE_RIGHT = 2,
    SLOW_ROTATE_LEFT = 3,
    SLOW_ROTATE_RIGHT = 4,
    WHEEL = 5,
    SPEED_WHEEL = 6,
    CAMERA_UP = 7,
    CAMERA_DOWN = 8,
    INSTALL = 9,
    INSTALL_CANCEL = 10,
    COUNT = 11
  },
  _eModeState = {
    none = 0,
    translation = 1,
    detail = 2,
    watingConfirm = 3,
    count = 4
  },
  _curModeState = 0,
  _basePanelSizeX = 0,
  _baseCommandBgSizeX = 0,
  _baseKeyPosY = 0,
  _baseKeyPosYGap = 30,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_KeyGuide_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_KeyGuide_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_House_InstallationMode_KeyGuide_All_Init")
function FromClient_House_InstallationMode_KeyGuide_All_Init()
  PaGlobal_House_InstallationMode_KeyGuide_All:initialize()
end
