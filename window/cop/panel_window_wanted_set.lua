PaGlobal_Window_Wanted_Set = {
  _ui = {
    _stc_mainBg = nil,
    _stc_currentValueText = nil,
    _stc_titleBg = nil,
    _btn_Close = nil,
    _edit_Count = nil,
    _edit_Cost = nil,
    _btn_Count = nil,
    _btn_Cost = nil,
    _btn_Wanted = nil,
    _stc_DescBg = nil,
    _stc_Desc = nil
  },
  _wantedCharacterNo = toInt64(0, 0),
  _wantedName = "",
  _wantedCount = 0,
  _wantedCost = toUint64(0, 0),
  _totalCost = toUint64(0, 0),
  _deadTime = toInt64(0, 0),
  _MAXWANTEDCOUNT = ToClient_getMaxWantedCount(),
  _MAXWANTEDCOST = ToClient_getMaxWantedCost(),
  _MINWANTEDCOST = ToClient_getMinWantedCost(),
  _currentWantedString = "",
  _initialize = false
}
runLua("UI_Data/Script/Window/Cop/Panel_Window_Wanted_Set_1.lua")
runLua("UI_Data/Script/Window/Cop/Panel_Window_Wanted_Set_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_WantedSetInit")
function FromClient_Window_WantedSetInit()
  PaGlobal_Window_Wanted_Set:initialize()
end
