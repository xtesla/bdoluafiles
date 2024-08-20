PaGlobal_SelectInstruments_All = {
  _ui = {
    _btn_Close_PC = nil,
    _btn_Close = nil,
    _btn_WayPoint_Shop = nil,
    _frame = nil,
    _frame_content = nil,
    _frame_content_btn = nil,
    _frame_content_txt = nil,
    _frame_content_title = nil,
    _frame_vertical = nil,
    _frame_vertical_ctrl = nil,
    _frame_horizontal = nil,
    _btn_Confirm = nil
  },
  _titleTable = {},
  _controlTable = {},
  _AdvancedTextTable = {
    "AUDIO_MIDI_TAB_NOVICE",
    "AUDIO_MIDI_TAB_ADVANCED"
  },
  _selectMusicIndex = -1,
  _selectTrackIndex = -1,
  _initialize = false
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_SelectInstruments_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_SelectInstruments_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SelectInstruments")
function FromClient_SelectInstruments()
  PaGlobal_SelectInstruments_All:initialize()
end
