PaGlobal_Login_All = {
  _ui = {
    _stc_webUI = nil,
    _stc_bi = nil,
    _btn_login = nil,
    _btn_exit = nil,
    _btn_option = nil,
    _btn_changeAccount = nil,
    _edit_id = nil,
    _txt_inputID = nil,
    _stc_blackLine = nil,
    _stc_pearlabyssCI = nil,
    _stc_daumCI = nil,
    _vedeo_loginMovie = nil
  },
  _currentMovieIndex = 1,
  _movieURL = {
    "coui://UI_Movie/01_sliced.webm",
    "coui://UI_Movie/04_sliced.webm",
    "coui://UI_Movie/05_sliced.webm"
  },
  _moviePath = {
    "UI_Movie/O_01.bk2",
    "UI_Movie/O_02.bk2",
    "UI_Movie/O_03.bk2"
  },
  _movieOrder = {
    1,
    2,
    3
  },
  _imageBG = {},
  _imageUpdateTime = 0,
  _isScope = true,
  _currentImageIndex = 1,
  _isNormalBI = true,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_Login_All_1.lua")
runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_Login_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_Login_All_Init")
function FromClient_Login_All_Init()
  PaGlobal_Login_All:initialize()
end
