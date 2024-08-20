PaGlobal_House_InstallationSiege_All = {
  _ui = {
    _stc_backGround = nil,
    _txt_titleText = nil,
    _stc_itemKit = nil,
    _stc_iconKit = nil,
    _txt_itemKitName = nil,
    _txt_itemKitCount = nil,
    _edit_searchBox = nil,
    _txt_searchIcon = nil,
    _stc_tentListBg = nil,
    _list2_tentList = nil,
    _btn_cancel = nil,
    _stc_consoleKeyBG = nil,
    _keyGuideBgList = {}
  },
  _eKeyType = {
    KEY_RS_CLICK = 1,
    KEY_RS_UPDOWN = 2,
    KEY_RS_LEFTRIGHT = 3,
    KEY_RS = 4,
    KEY_LS = 5,
    KEY_LB_RB = 6,
    KEY_LT_RT = 7,
    KEY_Y = 8,
    KEY_X = 9,
    KEY_A = 10,
    KEY_B = 11,
    COUNT = 12
  },
  _keyGuideString = {
    SELECT = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"),
    BUILD = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_BUILD"),
    INSTALL = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_INSTALL"),
    MOVE_BUILD = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_MOVE"),
    CHANGE_WIDTH = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_WIDTH"),
    CHANGE_HEIGHT = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHT"),
    ZOOM_INOUT = PAGetString(Defines.StringSheet_RESOURCE, "HOUSING_TXT_HELPZOOM"),
    CHANGE_CAMMODE = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_CAMMODE"),
    ZOOM_INOUTANDHEIGHT = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INSTALLMODE_KEYGUIDE_OBJECT_CHANGE_HEIGHTMODE")
  },
  _eModeState = {
    NONE = 0,
    TRANSLATION = 1,
    DETAIL = 2,
    WATINGCONFIRM = 3,
    COUNT = 4
  },
  _dataCount = 0,
  _radioBtnSlot = {},
  _itemEnchantKey = nil,
  _currentSelectedIndex = nil,
  _baseItemListBgSizeY = 0,
  _baseItemListSizeY = 0,
  _baseKeyGuideSpanGapX = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Siege_All_1.lua")
runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Siege_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_House_InstallationSiege_All_Init")
function FromClient_House_InstallationSiege_All_Init()
  PaGlobal_House_InstallationSiege_All:initialize()
end
