PaGlobal_IngameCashshop_GuildGiveaway = {
  _ui = {
    txt_RewardCount = nil,
    txt_Time = nil,
    stc_MainReward = nil,
    txt_SubTitle = nil,
    txt_UserName = nil,
    txt_DescBox = nil,
    stc_Deco = nil,
    stc_TimeBg = nil,
    txt_SubText = nil,
    txt_NoPresent = nil,
    stc_ItemSlot = nil,
    stc_smallDeco = nil,
    stc_smallCount = nil,
    stc_smallTimeBg = nil,
    txt_smallTime = nil,
    stc_smallmainSlot = nil
  },
  _ui_pc = {btn_Close = nil, btn_GetItem = nil},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _selectItemSlot = {},
  _curTime = 0,
  _selectItemIndex = -1,
  _timeEndPosX = 0,
  _timePosX = 0,
  _timeSizeX = 0,
  _isNotifyBuyer = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GuildGiveaway_All_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GuildGiveaway_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_IngameCashShop_GuildGiveaway_Init")
function FromClient_IngameCashShop_GuildGiveaway_Init()
  PaGlobal_IngameCashshop_GuildGiveaway:initialize()
end
