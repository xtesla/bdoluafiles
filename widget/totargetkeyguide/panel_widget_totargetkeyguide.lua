PaGlobal_ToTargetKeyGuide = {
  _ui = {
    txt_MouseBody1 = nil,
    txt_MouseBody2 = nil,
    txt_M0_1 = nil,
    txt_M0_2 = nil,
    txt_M1_1 = nil,
    txt_M1_2 = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/ToTargetKeyGuide/Panel_Widget_ToTargetKeyGuide_1.lua")
runLua("UI_Data/Script/Widget/ToTargetKeyGuide/Panel_Widget_ToTargetKeyGuide_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_ToTargetKeyGuide_luaLoadComplete")
function PaGlobal_ToTargetKeyGuide_luaLoadComplete()
  PaGlobal_ToTargetKeyGuide:initialize()
end
