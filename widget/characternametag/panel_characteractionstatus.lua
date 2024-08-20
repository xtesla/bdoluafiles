PaGlobal_CharacterActionStatus = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterActionStatus_1.lua")
runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterActionStatus_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterActionStatusInit")
function FromClient_CharacterActionStatusInit()
  PaGlobal_CharacterActionStatus:initialize()
end
