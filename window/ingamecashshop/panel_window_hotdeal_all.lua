PaGlobal_Window_HotDeal_All = {
  _ui = {
    _stc_titleArea = nil,
    _txt_title = nil,
    _stc_backImage = nil,
    _btn_close = nil,
    _stc_npcImageBg = nil,
    _stc_image = nil,
    _stc_itemCount = nil,
    _txt_itemTitle = nil,
    _txt_countValue = nil,
    _stc_clockBg = nil,
    _txt_hour1 = nil,
    _txt_hour2 = nil,
    _txt_min1 = nil,
    _txt_min2 = nil,
    _txt_sec1 = nil,
    _txt_sec2 = nil,
    _stc_productBg = nil,
    _stc_itemSlot = nil,
    _txt_itemName = nil,
    _txt_totalDiscount = nil,
    _txt_discountDirection = nil,
    _txt_totalPrice = nil,
    _stc_saleBg = nil,
    _txt_saleValue = nil,
    _stc_productArea = nil,
    _stc_itemSlotTemp = nil,
    _txt_packageTitle = nil,
    _stc_bottomArea = nil,
    _txt_desc = nil,
    _btn_buy = nil
  },
  _mainSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true
  },
  _subSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _mainItemSlot = nil,
  _subItemMaxCount = 10,
  _subItems = {},
  _baseSubItemPosX = 0,
  _subItemGapX = 10,
  _productNoRaw = 0,
  _discountPrice_s64 = nil,
  _salesStartTime = nil,
  _salesEndTime = nil,
  _curUpdateTime = 0,
  _maxUpdateTime = 0.25,
  _curEffectTime = 0,
  _maxEffectTime = 0.5,
  _isTimeTextRedColor = false,
  _lastReminedTime = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/IngameCashShop/Panel_Window_HotDeal_All_1.lua")
runLua("UI_Data/Script/Window/IngameCashShop/Panel_Window_HotDeal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_HotDeal_All_Init")
function FromClient_Window_HotDeal_All_Init()
  PaGlobal_Window_HotDeal_All:initialize()
end
