PaGlobal_BarterInfoSearch = {
  _ui = {
    _titleBar = UI.getChildControl(Panel_Window_Barter_Search, "Static_TitleBg"),
    _searchBar = UI.getChildControl(Panel_Window_Barter_Search, "Static_SearchOptionBG"),
    _mainBg = UI.getChildControl(Panel_Window_Barter_Search, "Static_MainBg"),
    _timeBar = UI.getChildControl(Panel_Window_Barter_Search, "StaticText_RefreshTime"),
    _txt_NotFind = UI.getChildControl(Panel_Window_Barter_Search, "StaticText_NoItem"),
    _stc_specialInfoBG = UI.getChildControl(Panel_Window_Barter_Search, "Static_SpecialBarterBG"),
    _txt_noticeDesc = UI.getChildControl(Panel_Window_Barter_Search, "StaticText_NoticeDesc"),
    _stc_noticeBg = UI.getChildControl(Panel_Window_Barter_Search, "Static_NoticeDescBg"),
    _chk_hideComplete = UI.getChildControl(Panel_Window_Barter_Search, "CheckButton_1"),
    _stc_keyGuideBG = UI.getChildControl(Panel_Window_Barter_Search, "Static_KeyGuide_ConsoleUI")
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  },
  _itemGradeColor = {
    [__eItemGradeNormal] = Defines.Color.C_FFC4C4C4,
    [__eItemGradeMagic] = Defines.Color.C_FF83A543,
    [__eItemGradeRare] = Defines.Color.C_FF438DCC,
    [__eItemGradeUnique] = Defines.Color.C_FFF5BA3A,
    [__eItemGradeEpic] = Defines.Color.C_FFD05D48,
    [__eItemGradeTypeCount] = Defines.Color.C_FFC4C4C4
  },
  _itemGradeText = {
    [__eItemGradeNormal] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_NORMAL"),
    [__eItemGradeMagic] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_GREEN"),
    [__eItemGradeRare] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_BLUE"),
    [__eItemGradeUnique] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_YELLOW"),
    [__eItemGradeEpic] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_ORANGE"),
    [__eItemGradeTypeCount] = PAGetString(Defines.StringSheet_RESOURCE, "UI_GENERAL_ITEMGRADE_TOTAL")
  },
  _valueLimitText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_COUNT_FILTER_3")
  },
  _categoryText = {
    [__eBarterCategory_NormalToLevel1] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_1"),
    [__eBarterCategory_Level1ToLevel2] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_2"),
    [__eBarterCategory_Level2ToLevel3] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_3"),
    [__eBarterCategory_Level3ToLevel4] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_4"),
    [__eBarterCategory_Level4ToLevel5] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_5"),
    [__eBarterCategory_NormalBarter] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_6"),
    [__eBarterCategory_CrowCoin] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_7"),
    [__eBarterCategory_Count] = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_NEW_FILTER_8")
  },
  _selectFilterIndex = nil,
  _selectValueLimitIndex = nil,
  _selectCategoryIndex = nil,
  _selectToItemCountFilter = 0,
  _updateCurrentTime = 0,
  _updatePastTime = 0,
  _originalKeyGuideBgSize = 0,
  _originalPanelPosY = 0,
  _specailBG_DefaultSizeX = nil,
  _isInit = false
}
function FromClient_BarterInfoSearchInit()
  local self = PaGlobal_BarterInfoSearch
  self:init()
end
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_1.lua")
runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BarterInfoSearchInit")
registerEvent("FromClient_RefreshBarterList", "FromClient_BarterInfoSearch_RefreshBarterList")
registerEvent("FromClient_RefreshSpecialBarterInfo", "FromClient_BarterInfoSearch_RefreshSpecialBarter")
registerEvent("FromClient_AddBarterExchangeCount", "FromClient_BarterInfoSearch_AddBarterExchangeCount")
