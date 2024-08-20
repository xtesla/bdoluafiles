PaGlobal_ServantTransferBackwardList_All = {
  _ui = {
    _stc_ListTitle = nil,
    _btn_Close_PC = nil,
    _list2_Servant = nil
  },
  _currentRegionKey = nil,
  _currentTitle = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferBackwordList_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferBackwordList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantTransferBackwardList_All_Init")
function FromClient_ServantTransferBackwardList_All_Init()
  PaGlobal_ServantTransferBackwardList_All:initialize()
end
