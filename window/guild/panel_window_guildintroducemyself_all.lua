PaGlobal_GuildIntroduceMySelf_All = {
  _ui = {
    stc_titleArea = nil,
    btn_titleClose = nil,
    stc_mainArea = nil,
    btn_apply = nil,
    btn_close = nil,
    txt_edit = nil
  },
  _category = nil,
  _index = nil,
  _isSearchList = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildIntroduceMySelf_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildIntroduceMySelf_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_GuildIntroduceMySelf_All")
function FromClient_PaGlobal_GuildIntroduceMySelf_All()
  PaGlobal_GuildIntroduceMySelf_All:initialize()
end
