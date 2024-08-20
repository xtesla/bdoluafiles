PaGlobal_ChangeSeasonCharacter_All = {
  _ui = {
    stc_titleBG = nil,
    btn_stickerUI = nil,
    btn_close = nil,
    stc_topBG = nil,
    leftSlot = nil,
    rightSlot = nil,
    btn_change = nil,
    stc_midBG = nil,
    stc_slotTemplate = nil,
    characterList = {},
    scroll_charList = nil,
    stc_descBG = nil,
    txt_desc = nil,
    stc_keyGuideBG = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideLBRB = nil,
    stc_keyGuideY = nil
  },
  _selectedCharacterIndex = -1,
  _pageIndex = 0,
  _charSlotColumnCount = 6,
  _maxCharacterCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_ChangeSeasonCharacter_All_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_ChangeSeasonCharacter_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_ChangeSeasonCharacter_All_Init")
function FromClient_luaLoadComplete_ChangeSeasonCharacter_All_Init()
  PaGlobal_ChangeSeasonCharacter_All:initialize()
end
