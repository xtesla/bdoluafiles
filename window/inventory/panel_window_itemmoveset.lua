PaGlobal_ItemMoveSet = {
  _ui = {
    _stc_titleBg = UI.getChildControl(Panel_Window_ItemMoveSet, "Static_TitleArea"),
    _stc_selectBg = UI.getChildControl(Panel_Window_ItemMoveSet, "Static_SelectBG"),
    _btn_apply = UI.getChildControl(Panel_Window_ItemMoveSet, "Button_Update"),
    _stc_Desc = UI.getChildControl(Panel_Window_ItemMoveSet, "Static_DescEdge_Import"),
    _stc_keyGuide = UI.getChildControl(Panel_Window_ItemMoveSet, "Static_KeyGuide_ConsoleUI")
  },
  _cacheTypeList = {
    [0] = __eItemMoveKey_0,
    __eItemMoveKey_1,
    __eItemMoveKey_2,
    __eItemMoveKey_3,
    __eItemMoveKey_4,
    __eItemMoveKey_5,
    __eItemMoveKey_6,
    __eItemMoveKey_7,
    __eItemMoveKey_8,
    __eItemMoveKey_9
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true
  },
  _fromItemCount = 0,
  _toItemCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ItemMoveSet_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ItemMoveSet_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ItemMoveSet_Init")
function FromClient_ItemMoveSet_Init()
  PaGlobal_ItemMoveSet:initialize()
end
