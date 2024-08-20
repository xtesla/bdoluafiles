PaGlobal_GuildReward_All = {
  _ui = {
    stc_No_Itemlog = nil,
    _List2 = nil,
    _Content = nil,
    _scroll_List2Vertical = nil,
    stc_ItemLog = nil,
    stc_TotalRewardKistory = nil,
    stc_No_WidgetItemlog = nil,
    _LogFrame = nil,
    _LogContent = nil,
    _scroll_Frame1Vertical = nil,
    _txt_dateTitleTemplate = nil,
    _stc_itemLogTemplate = nil
  },
  _ui_pc = {btn_Exit = nil},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _logTable = {},
  _itemLogControl = {},
  _COL_SLOT_COUNT = 8,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildReward_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildReward_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildReward_All_Init")
function FromClient_GuildReward_All_Init()
  PaGlobal_GuildReward_All:initialize()
end
