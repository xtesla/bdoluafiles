PaGlobal_Guild_InviteList = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    stc_listArea = nil,
    stc_list2 = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Guild_INviteList_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Guild_INviteList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Guild_InviteList")
function FromClient_PaGlobal_Guild_InviteList()
  PaGlobal_Guild_InviteList:initialize()
end
