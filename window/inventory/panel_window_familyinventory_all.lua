PaGlobal_FamilyInventory_All = {
  _ui = {
    _chkSort = nil,
    _stcCapacity = nil,
    _stc_scrollArea = nil,
    _scroll = nil,
    _btnBuyWeight = nil,
    _progressWeight = nil,
    _stcWeight = nil,
    _stcWeightIcon = nil,
    _chkMove = nil
  },
  _maxSlotCount = 0,
  _showStartSlot = 0,
  _showSlotCount = 0,
  _slotCols = 8,
  _slotsBG = nil,
  _slots = nil,
  _capacity = nil,
  _tooltipSlotNo = nil,
  _showBuyWeight = true,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_FamilyInventory_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_FamilyInventory_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FamilyInventory_All_Init")
function FromClient_FamilyInventory_All_Init()
  PaGlobal_FamilyInventory_All:initialize()
end
function moveFamilyInventoryItem(fromslot, toSlot)
  inventory_swapItem(25, fromslot, toSlot)
end
function registFamilyInvenotryItem()
  quickSlot_RegistItem(0, 25, 3)
end
