PaGlobal_Widget_GoldenBell = {
  _ui = {
    _stc_bg = nil,
    _stc_desc = nil,
    _stc_goldenBellIcon = nil,
    _stc_good = nil,
    _stc_lefTime = nil
  },
  _currentCheerUpCount = 0,
  _MAX_CHEERUP_COUNT = ToClient_GetMaxCheerUpCount(),
  _TYPE = {_BELL = 0, _WHISTLE = 1},
  _UV_ICON = {
    [0] = {
      x1 = 1,
      y1 = 225,
      x2 = 51,
      y2 = 275
    },
    [1] = {
      x1 = 1,
      y1 = 276,
      x2 = 51,
      y2 = 326
    }
  },
  _originPanelSizeY = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_GoldenBell_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_GoldenBell_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_GoldenBellInit")
function FromClient_Widget_GoldenBellInit()
  PaGlobal_Widget_GoldenBell:initialize()
end
