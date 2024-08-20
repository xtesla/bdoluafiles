PaGlobal_DeleteMaxEnchanterName = {
  _ui = {
    stc_TitleBg = nil,
    btn_Close = nil,
    list2_Item = nil,
    list2_Content = nil,
    btn_NameDelete = nil,
    stc_SelectItemArea = nil,
    stc_CarveSealImage = nil,
    stc_Slot = nil,
    stc_RemoveItemArea = nil,
    stc_RemoveItemSlot = nil,
    txt_RemoveItemName = nil,
    txt_RemoveItemValue = nil,
    txt_Name = nil
  },
  _baseTexture = nil,
  _fromInventoryType = nil,
  _fromInventorySlotNo = nil,
  _fromItemKey = nil,
  _fromItemName = nil,
  _fromItemIconPath = nil,
  _toInventoryType = nil,
  _toInventorySlotNo = nil,
  _selectIndex = 0,
  _viewSlotNo = {},
  _slotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true,
    createDuplicatedForDuel = true,
    createOriginalForDuel = true
  },
  _isProcessEffect = false,
  _effectTime = 1,
  _currentProcess = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName_1.lua")
runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_DeleteMaxEnchanterName")
function FromClient_PaGlobal_DeleteMaxEnchanterName()
  PaGlobal_DeleteMaxEnchanterName:initialize()
end
