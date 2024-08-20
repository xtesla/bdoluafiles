PaGlobal_MiningFuel_All = {
  _ui = {
    stc_Fuel_BG = nil,
    stc_Progress_BG = nil,
    txt_ProgressValue = nil,
    sliderProgress = nil,
    stc_Pole = nil,
    stc_Hammer = nil,
    stc_Effect = nil
  },
  _ui_pc = {btn_Exit = nil, btn_Reward = nil},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _fuelSlotMaxCount = 5,
  _fuelSlot = {},
  _actorKeyRaw = nil,
  _state = __eFuelInsertObjectState_None,
  _fuelCount = 0,
  _isAnimationPlay = false,
  _isUp = true,
  _hammerBasePosY = 0,
  _hammerLimitPosY = 0,
  _effectIsShow = false,
  _effectTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_MiningFuel_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_MiningFuel_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiningFuel_All_Init")
function FromClient_MiningFuel_All_Init()
  PaGlobal_MiningFuel_All:initialize()
end
