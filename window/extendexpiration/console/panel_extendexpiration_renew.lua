PaGlobal_ExtendExpiration_Renew = {
  _ui = {
    _txt_Guide = nil,
    _static_Effect = nil,
    _static_materialSlot = nil,
    _static_Slot = nil,
    _desc = nil,
    material = {},
    item = {}
  },
  config = {
    materialWhereType = 0,
    materialSlotNo = 0,
    materialCount = toInt64(0, 0),
    materialMaxCount = toInt64(0, 0),
    materialExtendExpirationType = 0,
    targetWhereType = 0,
    targetSlotNo = 0,
    isSetItem = false,
    extendExpirationDo = false
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createExpiration = true
  },
  materialSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createExpiration = false
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/ExtendExpiration/Console/Panel_ExtendExpiration_Renew_1.lua")
runLua("UI_Data/Script/Window/ExtendExpiration/Console/Panel_ExtendExpiration_Renew_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExtendExpiration_RenewInit")
function FromClient_ExtendExpiration_RenewInit()
  PaGlobal_ExtendExpiration_Renew:initialize()
end
