PaGlobal_Warcall_Castle = {
  _ui = {
    _stc_BG = nil,
    _list_castle = nil,
    _btn_closeX = nil,
    _btn_confirm = nil,
    _btn_close = nil
  },
  _teleportRegionKey = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_Warcall_Castle_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_Warcall_Castle_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WarcallCastleInit")
function FromClient_WarcallCastleInit()
  PaGlobal_Warcall_Castle:initialize()
end
