PaGlobal_WorldMap_StableList = {
  _ui = {
    _stc_titleBg = nil,
    _stc_title = nil,
    _btn_close = nil,
    _btn_question = nil,
    _stc_leftBg = nil,
    _list2_region = nil,
    _stc_notAvaliable = nil,
    _stc_marketValue = nil,
    _stc_kingdomMoneyValue = nil,
    _stc_pageBg = nil,
    _stc_pageValue = nil,
    _btn_leftPC = nil,
    _btn_rightPC = nil,
    _btn_reload = nil,
    _stc_SkillTooltip = nil,
    _servantSlot = {},
    _console = {
      _btn_leftConsole = nil,
      _btn_rightConsole = nil,
      _stc_sortdBgConsole = nil,
      _stc_sortTitle = nil,
      _stc_sortValue = nil,
      _stc_KeyGuide_LTX = nil,
      _stc_KeyGuide_RS = nil,
      _stc_KeyGuide_B = nil,
      _stc_KeyGuide_Y_Tooltip = nil,
      _stc_Bottom_KeyGuides = nil
    },
    _keyguides = {}
  },
  _SEPARATORNUMBER = 100000,
  _MAXSLOTCOUNT = 4,
  _string_ServantTier = {},
  _sexFilterString = {},
  _territoryInfoList = {},
  _regionInfoList = {},
  _areaNameList = {},
  _isContentsStallionEnable = ToClient_IsContentsGroupOpen("243"),
  _isContentsNineTierEnable = ToClient_IsContentsGroupOpen("80"),
  _isContentsEightTierEnable = ToClient_IsContentsGroupOpen("29"),
  _totalSellPrice = nil,
  _totalMarketPrice = nil,
  _skillNameBaseSpanSizeX = 0,
  _TOWNSLOTINDEX = -1,
  _curTargetSnapIndex = 0,
  _currentSelectTerritoryKey = nil,
  _currentSelectRegionKey = nil,
  _currentSlotPage = 0,
  _currentMaxPage = 0,
  _currentSelectSlot = -1,
  _selectServantIndex = 0,
  _selectSkillIndex = 0,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_StableList_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_StableList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_StableListInit")
function FromClient_WorldMap_StableListInit()
  PaGlobal_WorldMap_StableList:initialize()
end
