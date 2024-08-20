PaGlobal_GrowthPass_Info = {
  _ui = {
    _stc_mainBg = UI.getChildControl(Panel_Window_GrowthPass_Info, "Static_SubBg"),
    _stc_questDescBg = nil,
    _stc_rewardGroup = nil,
    _stc_rewardBg = nil,
    _stc_questTitle = nil,
    _stc_questIconTexture = nil,
    _stc_questConditionText = nil,
    _stc_questDescText = nil,
    _itemSlot = nil,
    _questItemSlot = nil,
    _questItemNameText = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _cachedTargetControl = nil,
  _panelPos_gapX = 5,
  _rewardTitle_spanY = -25,
  _initialize = false
}
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_Info_1.lua")
runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_Info_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GrowthPassInfoInit")
function FromClient_GrowthPassInfoInit()
  PaGlobal_GrowthPass_Info:initialize()
end
