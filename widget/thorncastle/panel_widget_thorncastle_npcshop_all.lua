PaGlobal_ThornCastle_NpcShop_All = {
  _ui = {
    stc_titleBG = nil,
    btn_close = nil,
    list2_itemList = nil,
    list2_content = nil,
    btn_radiocontent = nil,
    stc_itemSlot = nil,
    btn_radiocontent2 = nil,
    stc_itemSlot2 = nil,
    stc_silver = nil,
    btn_Inven = nil,
    txt_unit = nil,
    txt_point = nil,
    btn_buy = nil
  },
  showItemList = {},
  _slotConfig = {
    createIcon = true,
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _selectIndex = nil,
  _initialize = false,
  _MAX_ITEMLIST_COUNT = 10
}
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_NpcShop_All_1.lua")
runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_NpcShop_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_ThornCastle_NpcShop_All_Init")
function FromClient_PaGlobal_ThornCastle_NpcShop_All_Init()
  PaGlobal_ThornCastle_NpcShop_All:initialize()
end
