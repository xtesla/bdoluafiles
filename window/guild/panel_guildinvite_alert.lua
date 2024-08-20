PaGlobal_GuildInviteAlert = {
  _ui = {btn_Alert = nil, txt_count = nil},
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_GuildInvite_Alert_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_GuildInvite_Alert_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildSimpleInvite_Alert")
function FromClient_GuildSimpleInvite_Alert()
  PaGlobal_GuildInviteAlert:initialize()
end
