PaGlobal_DescBox_ItemCopy = {
  _ui = {
    _frame1 = nil,
    _frame_content1 = nil,
    _frame_scroll = nil,
    _txt_Desc = nil,
    _btn_winClose = nil,
    _btn_function = nil,
    _stc_KeyGuide_ConsoleUI = nil,
    _txt_KeyGuide_Close = nil
  },
  _isConsole = false
}
function FromClient_DescBoxItemCopyInit()
  local self = PaGlobal_DescBox_ItemCopy
  self:init()
end
runLua("UI_Data/Script/Window/Inventory/Panel_Window_DescBox_ItemCopy_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_DescBox_ItemCopy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DescBoxItemCopyInit")
