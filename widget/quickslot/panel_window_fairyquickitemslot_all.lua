PaGlobal_FairyQuickItemSlot_All = {
  _ui = {
    stc_titleBG = nil,
    txt_Title = nil,
    btn_close = nil,
    stc_blackBG = nil,
    stc_slotArea = nil,
    stc_slotTemplate = nil,
    stc_descBG = nil,
    txt_desc = nil,
    btn_useAll = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideY = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil
  },
  _slotBg = {},
  _slot = {},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _rowMaxSlotCount = 4,
  _slotMaxCount = 10,
  _emptySlotIndex = -1,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/QuickSlot/Panel_Window_FairyQuickItemSlot_All_1.lua")
runLua("UI_Data/Script/Widget/QuickSlot/Panel_Window_FairyQuickItemSlot_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_FairyQuickItemSlot_All_Init")
function FromClient_FairyQuickItemSlot_All_Init()
  PaGlobal_FairyQuickItemSlot_All:initialize()
end
