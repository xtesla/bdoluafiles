PaGlobal_GuildWareHouseHistory = {
  _ui = {
    _topBg = nil,
    _mainBg = nil,
    _stc_descBg = nil,
    _txt_desc = nil,
    _stc_keyGuide = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = false
  }
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildWareHouseHistory_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildWareHouseHistory_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildWareHouseHistoryInit")
function FromClient_GuildWareHouseHistoryInit()
  local self = PaGlobal_GuildWareHouseHistory
  self:init()
end
