PaGlobal_CargoSell = {
  _ui = {
    _btn_close = nil,
    _stc_warehouseBg = nil,
    _txt_capacity = nil,
    _stc_itemSlotFrame = nil,
    _stc_itemSlotBg = nil,
    _stc_lockIcon = nil,
    _stc_multipleSelect = nil,
    _btn_itemsort = nil,
    _scroll_warehouse = nil,
    _list2_sell = nil,
    _list2_content = nil,
    _txt_emptyDesc = nil,
    _txt_sell_total_price = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuide_X = nil,
    _stc_keyGuide_Y = nil,
    _stc_keyGuide_A = nil,
    _stc_keyGuide_B = nil,
    _btn_sell = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCash = true,
    createBagIcon = true,
    createEnduranceIcon = true,
    createCheckBox = true,
    isTranslation = true
  },
  _config = {
    slotCount = 90,
    slotCols = 9,
    slotRows = 0,
    slotStartX = 5,
    slotStartY = 5,
    slotGapX = 51,
    slotGapY = 51
  },
  _blankSlots = Array.new(),
  _slots = Array.new(),
  _isConsole = false,
  _selectWaypointKey = nil,
  _startSlotIndex = 0,
  _consoleShowIndex = 0,
  _isSorted = nil,
  _sellTotalPrice = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Window_CargoSell_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_CargoSell_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CargoSellInit")
function FromClient_CargoSellInit()
  PaGlobal_CargoSell:initialize()
end
