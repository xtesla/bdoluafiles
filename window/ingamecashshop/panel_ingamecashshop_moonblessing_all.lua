PaGlobal_IngameCashShopMoonBlessing_All = {
  _ui = {
    stc_titleBg = nil,
    stc_radioBg = nil,
    rdo_montly = nil,
    rdo_weekly = nil,
    rdo_daily = nil,
    stc_selectLine = nil,
    stc_tabBg = nil,
    rdo_charged = nil,
    rdo_consumed = nil,
    txt_nochallenge = nil,
    stc_centerBg = nil,
    _chargedGroup = {
      stc_bg = nil,
      stc_rdoBg = nil,
      rdo_montly = nil,
      rdo_weekly = nil,
      rdo_daily = nil
    },
    _consumedGroup = {
      stc_bg = nil,
      stc_rdoBg = nil,
      rdo_montly = nil,
      rdo_weekly = nil,
      rdo_daily = nil
    },
    txt_resetInfo = nil,
    txt_periodInfo = nil,
    txt_alertInfo = nil,
    _contentsGroup = {},
    _mileageTabBtnGroup = {},
    _tabTypeBtnGroup = {},
    _list2_mileage = {},
    _radioTabGroup = {},
    _stc_resetArea = nil,
    _stc_resetDescEdge = nil,
    _stc_resetDesc = nil,
    _btn_reset = nil
  },
  _ui_pc = {btn_close = nil},
  _ui_console = {
    stc_rdoLB = nil,
    stc_rdoRB = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideX = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil
  },
  MILEAGE_TYPE = {CHARGED = 0, CONSUMED = 1},
  CHALLENGE_TYPE = {
    NONE = 0,
    IMMEDIATELY = 1,
    DAILY = 2,
    CUMULATEDMINUTE = 3,
    WEEKLY = 4,
    MONTHLY = 5,
    COUNT = 6
  },
  CHALLENGE_STEP = {
    PROGRESS = 0,
    REWARDED = 1,
    COMPLETED = 2
  },
  PERIOD_INFO = {
    [0] = "",
    [1] = "",
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_MILEAGE_DAILY_PERIODINFO"),
    [3] = "",
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_MILEAGE_WEEKLY_PERIODINFO"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_MILEAGE_MONTHLY_PERIODINFO"),
    [6] = ""
  },
  _mileageDefaultType = {
    [0] = -1,
    [1] = -1
  },
  _saveSize = {panelY = 0, centerBgY = 0},
  _mileageSlots = {
    [0] = {},
    [1] = {}
  },
  _nowProgressKeyGroup = {
    [0] = -1,
    [1] = -1
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _tabIndexForConsole = {},
  _tabShowCnt = 0,
  _nowObtainedPearl = 0,
  _nowUsedPearl = 0,
  _nowMileageInfoKey = -1,
  _nowTabInfoKey = -1,
  _nowConfirmKey = -1,
  _mileageDefaultKey = 0,
  _mileageInfo = {},
  _mileageInfoCnt = 0,
  _maxSlotCnt = 7,
  _showPearlPrice = -1,
  _nowDay = ToClient_GetToday(),
  _nowTabShowCnt = 0,
  _typeBtnCnt = 0,
  _tabBtnGroup = nil,
  _currentTabIndexForConsole = 1,
  _currentTabGroupChallengeKey = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_IngameCashShopMoonBlessing_All_Init")
function FromClient_IngameCashShopMoonBlessing_All_Init()
  PaGlobal_IngameCashShopMoonBlessing_All:initialize()
end
