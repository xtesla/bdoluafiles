PaGlobal_MusicBoard_All = {
  _ui = {
    _stc_topGroupBg = nil,
    _checkBox_Filter = {},
    _stc_FilterBg = nil,
    _radio_InstrumentType = {},
    _list2 = nil,
    _btn_Composition = nil,
    _btn_Album = nil,
    _btn_Option = nil,
    _btn_Close = nil,
    _btn_BottomClose = nil,
    _btn_Ready = nil,
    _btn_Refuse = nil,
    _btn_MyInstruments = nil,
    _txt_GradeValue = nil,
    _stc_gradeTitle = nil,
    _edit_search = nil,
    _btn_search = nil,
    _btn_searchReset = nil,
    _stc_searchConsole = nil,
    _subGroup_bg = nil,
    _btn_Share = nil,
    _btn_Delete = nil,
    _btn_Edit = nil,
    _stc_list = nil,
    _stc_instrumentTitle = nil
  },
  _isOpenTrack = {},
  _subMenuStartPosY = 0,
  _musicIndex = -1,
  _trackIndex = -1,
  _etcMusicIndex = -1,
  _instrumentTrackListSize = 0,
  _instrumentShowCount = 6,
  _current_InstrumentType = 0,
  _isResemble = false,
  _initialize = false,
  _controlCount = 10,
  _searchString = nil
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicBoard_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicBoard_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MusicBoard_All_Init")
function FromClient_MusicBoard_All_Init()
  PaGlobal_MusicBoard_All:initialize()
end
