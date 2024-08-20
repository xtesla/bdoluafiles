PaGlobal_Worldmap_Grand_NodeNavigation = {
  _ui = {
    _fromSearchEditBox = nil,
    _fromSearchBoxDefaultText = nil,
    _fromSearchResult = nil,
    _fromScroll = nil,
    _toSearchEditBox = nil,
    _toSearchBoxDefaultText = nil,
    _toSearchResult = nil,
    _toScroll = nil,
    _selectedCount = nil,
    _needExplorationPoint = nil,
    _isPossibleRemoteInvestment = nil,
    _needWP = nil,
    _emptyDesc = nil,
    _closeBtn = nil,
    _preViewBtn = nil,
    _clearBtn = nil,
    _connectAllBtn = nil,
    _findModeCheckBox = nil
  },
  _searchResultMaxCount = 5,
  _searchResultCount = 0,
  _scrollStartSlotIndex = 0,
  _fromSearchResultSlotPool = {},
  _toSearchResultSlotPool = {},
  _lastClickedEditBox = "",
  _initialize = false
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_NodeNavigation_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_NodeNavigation_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WorldMap_NodeNavigation_Init")
function FromClient_luaLoadComplete_WorldMap_NodeNavigation_Init()
  PaGlobal_Worldmap_Grand_NodeNavigation:initialize()
end
