PaGlobal_HorseRacing_Gear = {
  _ui = {
    progress_gear = {},
    stc_gearCount = {},
    stc_gearNow = nil,
    stc_gearPointer = nil,
    progress_hp = nil,
    progress_mp = nil,
    stc_gearEffect = nil,
    stc_gearPointerEffect = nil,
    stc_mpEffect = nil,
    stc_maxMp = nil,
    txt_mpKeyGuide = nil,
    txt_gearKeyGuide = nil
  },
  _gearPointShowLev = 0,
  _curLev = 0,
  _changeLev = 0,
  _changeRate = 0,
  _maxGearCount = 6,
  _lastUpdateTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Gear_1.lua")
runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Gear_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_GearInit")
function FromClient_HorseRacing_GearInit()
  PaGlobal_HorseRacing_Gear:initialize()
end
