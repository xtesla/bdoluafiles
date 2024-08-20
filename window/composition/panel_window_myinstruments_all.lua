PaGlobal_MyInstruments_All = {
  _ui = {
    _btn_Close_PC = nil,
    _btn_WayPoint_Shop = nil,
    _frame = nil,
    _frame_contents = nil,
    _frame_contents_txt = nil,
    _frame_contents_icon = nil,
    _frame_contents_title = nil,
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
  _initialize = false
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MyInstrumentsInit")
function FromClient_MyInstrumentsInit()
  PaGlobal_MyInstruments_All:initialize()
end
