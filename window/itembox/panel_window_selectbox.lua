PaGlobal_SelectBox = {
  _ui = {
    _stc_titleBg = UI.getChildControl(Panel_Window_SelectBox, "Static_Title_BG"),
    _stc_category = UI.getChildControl(Panel_Window_SelectBox, "Static_CategoryName"),
    _stc_mainBg = UI.getChildControl(Panel_Window_SelectBox, "Static_Main_Bg_0"),
    _stc_selectedBg = UI.getChildControl(Panel_Window_SelectBox, "Static_Selected_BG"),
    _btn_ok = UI.getChildControl(Panel_Window_SelectBox, "Button_Confirm"),
    _btn_cancel = UI.getChildControl(Panel_Window_SelectBox, "Button_Cancel"),
    _stc_keyGuideBg = UI.getChildControl(Panel_Window_SelectBox, "StaticText_Keyguide_BG"),
    _stc_descBg = UI.getChildControl(Panel_Window_SelectBox, "Static_DescEdge_Import"),
    _stctxt_desc = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true,
    createEnchant = true,
    createCount = true
  },
  _cachedData = {
    _origin_selectedBg_SizeX = 0,
    _origin_selectedBg_SizeY = 0,
    _origin_mainBg_SizeX = 0,
    _origin_mainBg_SizeY = 0,
    _origin_panel_SizeX = 0,
    _origin_panel_SizeY = 0,
    _origin_cancelBtn_SpanX = 0,
    _origin_cancelBtn_SpanY = 0
  },
  _isCurrentMouseOnItemSlot = false,
  _isCurrentShowRewardMessageBox = false
}
runLua("UI_Data/Script/Window/ItemBox/Panel_Window_SelectBox_1.lua")
runLua("UI_Data/Script/Window/ItemBox/Panel_Window_SelectBox_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SelectBox_Init")
function FromClient_SelectBox_Init()
  PaGlobal_SelectBox:initialize()
end
