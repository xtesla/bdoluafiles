PaGlobal_GrowthPass_PointShop = {
  _ui = {
    _stc_title_bg = UI.getChildControl(Panel_Window_GrowthPass_PointShop, "Static_Title_Bg"),
    _stc_item_bg = UI.getChildControl(Panel_Window_GrowthPass_PointShop, "Static_Item_Bg"),
    _stc_current_point = UI.getChildControl(Panel_Window_GrowthPass_PointShop, "StaticText_Point"),
    _btn_buy = UI.getChildControl(Panel_Window_GrowthPass_PointShop, "Button_Buy"),
    _item_frame = nil,
    _item_frame_content = nil,
    _btn_close = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _totalItemCount = 0,
  _currentSelectedItemKey = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_PointShop_1.lua")
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_PointShop_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GrowthPassPointShopInit")
function FromClient_GrowthPassPointShopInit()
  PaGlobal_GrowthPass_PointShop:initialize()
end
