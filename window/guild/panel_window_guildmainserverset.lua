PaGlobal_GuildMainServerSet = {
  _ui = {
    stc_titleBg = nil,
    btn_close = nil,
    stc_selectBg = nil,
    list2_serverList = nil,
    stc_descBg = nil,
    txt_desc = nil,
    stc_keyGuideBG = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil
  }
}
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildMainServerSet_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildMainServerSet_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildMainServerSet_Init")
function FromClient_GuildMainServerSet_Init()
  PaGlobal_GuildMainServerSet:initialize()
end
