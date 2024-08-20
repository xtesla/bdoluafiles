PaGlobal_SiegeWar_AngerGage = {
  _ui = {
    _stc_angry = nil,
    _progress_Angry = nil,
    _txt_Percent = nil,
    _stc_Effect = nil
  },
  _isPlayingEffect = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_AngerGage_1.lua")
runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_AngerGage_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SiegeWarAngerGageInit")
function FromClient_SiegeWarAngerGageInit()
  PaGlobal_SiegeWar_AngerGage:initialize()
end
