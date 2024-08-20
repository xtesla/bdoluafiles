PaGlobal_SimpleInventory_SearchResult = {
  _ui = {
    _stc_titleArea = UI.getChildControl(Panel_Window_SimpleInventory_SearchResult, "Static_TitleArea"),
    _edit_control = UI.getChildControl(Panel_Window_SimpleInventory_SearchResult, "Edit_SearchText_PCUI_Import"),
    _check_sort = UI.getChildControl(Panel_Window_SimpleInventory_SearchResult, "CheckButton_ItemSort"),
    _list2_result = UI.getChildControl(Panel_Window_SimpleInventory_SearchResult, "List2_Search")
  },
  _ENUM_SIMPLE_TOOPTIP_TYPE = {_TOOPTIP_RESET = 0, _TOOPTIP_GROUPITEM = 1},
  _SIMPLE_TOOLTIP_DATA = {
    [0] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEARCHRESET"),
      desc = "",
      control = nil
    },
    [1] = {
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEARCH_RESULT_SAMEITEM"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SIMPLEINVENTORY_TOOLTIP_ITEMGROUPDESC"),
      control = nil
    }
  },
  _isSearchedItemGroup = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_SearchResult_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_SearchResult_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SimpleInventory_SearchResult_Init")
function FromClient_SimpleInventory_SearchResult_Init()
  PaGlobal_SimpleInventory_SearchResult:initialize()
end
