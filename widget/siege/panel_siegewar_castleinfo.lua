PaGlobal_SiegeWar_CastleInfo = {
  _ui = {
    _stc_castleInfoTemplate = nil,
    _stc_castleInfoList = {}
  },
  _HIT_ICON_TIME = 15000,
  _HIT_EFFECT_TIME = 3000,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_CastleInfo_1.lua")
runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_CastleInfo_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SiegeWarCastleInfoInit")
function FromClient_SiegeWarCastleInfoInit()
  PaGlobal_SiegeWar_CastleInfo:initialize()
end
