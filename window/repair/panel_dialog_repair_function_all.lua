PaGlobal_RepairFunc_All = {
  _eType = {_dialog = 0, _camp = 1},
  _ui = {
    radio_btn = {},
    stc_selectLine = nil,
    stc_cursor = nil
  },
  _ui_console = {
    stc_iconLB = nil,
    stc_iconRB = nil,
    stc_iconA = nil
  },
  _otherPanel = {
    _uiRepairMessageBG = nil,
    _uiRepairInven = nil,
    _uiRepairWareHouse = nil,
    _uiRepairInvenMoney = nil,
    _uiRepairWareHouseMoney = nil,
    _repairMessag = nil,
    _repairMessageJP = nil
  },
  _uiRepairInvenMoneyTextSizeX = 0,
  _uiRepairWareHouseMoneyTextSizeX = 0,
  _uiRepairTextSizeX = 0,
  _uiRepairValueDefaultSpanX = 0,
  _BTN_ENUM = {
    GUILD = 1,
    SHIP = 2,
    HORSE = 3,
    MAXENDURANCE = 4,
    EQUIPMENT = 5,
    INVENTORYALL = 6,
    INVENTORY = 7,
    EXIT = 8
  },
  _BTN_COUNT = 8,
  _resultMsg_ShowTime = 0,
  _luckyRepairMSG = {},
  _repairWhereType = 0,
  _repairSlotNo = 0,
  _isCamping = false,
  _eRepairType = 0,
  _isContentsEnable = ToClient_IsContentsGroupOpen("36"),
  _isConsole = false,
  _initialize = false,
  _btnTable = {},
  _funcTable = {},
  _funcButtonCount = 1,
  _currentTabIndex = 1,
  _equipmentIndex = -1,
  _slotNoIdToString = {
    [__eEquipSlotNoRightHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [__eEquipSlotNoLeftHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [__eEquipSlotNoSubTool] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
    [__eEquipSlotNoChest] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [__eEquipSlotNoGlove] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [__eEquipSlotNoBoots] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [__eEquipSlotNoHelm] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [__eEquipSlotNoNecklace] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [__eEquipSlotNoRing1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoRing2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoEaring1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoEaring2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoBelt] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [__eEquipSlotNoLantern] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
    [__eEquipSlotNoAvatarChest] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
    [__eEquipSlotNoAvatarGlove] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
    [__eEquipSlotNoAvatarBoots] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
    [__eEquipSlotNoAvatarHelm] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
    [__eEquipSlotNoAvatarWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
    [__eEquipSlotNoAvatarSubWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
    [__eEquipSlotNoAvatarUnderwear] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
    [__eEquipSlotNoFaceDecoration1] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HEAD"),
    [__eEquipSlotNoFaceDecoration2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_EYES"),
    [__eEquipSlotNoFaceDecoration3] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MOUSE"),
    [__eEquipSlotNoAlchemyStone] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [__eEquipSlotNoAvatarAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon"),
    [__eEquipSlotNoQuestBook] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_QUESTBOOK")
  }
}
runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All_1.lua")
runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RepairFunc_All_Init")
function FromClient_RepairFunc_All_Init()
  PaGlobal_RepairFunc_All:initialize()
end
