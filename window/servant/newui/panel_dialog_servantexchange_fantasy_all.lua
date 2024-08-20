PaGlobal_ServantExchange_Fantasy_All = {
  _ui = {
    _stc_Title = nil,
    _txt_Title = nil,
    _btn_Question_PC = nil,
    _btn_Close_PC = nil,
    _btn_Exchange_PC = nil,
    _stc_Bg = nil,
    _stc_Exchange_Bg = nil,
    _txt_TopDesc = nil,
    _txt_RateCount = nil,
    _stc_ItemSlotBg = nil,
    _stc_ItemIcon = nil,
    _stc_LeftBg = nil,
    _btn_LeftSelect = nil,
    _stc_LeftPlus = nil,
    _stc_LeftMale = nil,
    _stc_LeftImage = nil,
    _stc_LeftGenderIcon = nil,
    _txt_LeftName = nil,
    _stc_RightBg = nil,
    _btn_RightSelect = nil,
    _stc_RightPlus = nil,
    _stc_RightMale = nil,
    _stc_RightImage = nil,
    _stc_RightGenderIcon = nil,
    _txt_RightName = nil,
    _edit_Naming = nil,
    _stc_Pencil = nil,
    _stc_DescBG = nil,
    _txt_Desc = nil,
    _stc_Bottom_KeyGuide = nil,
    _stc_KeyGuide_Y = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil,
    _stc_KeyGuide_X = nil
  },
  _needItemInfo = {_needItemSlotNo = -1, _needItemCount = 0},
  _servantNo_Left = nil,
  _servantNo_Right = nil,
  _servantNo_Result = nil,
  _resultCharacterKey = nil,
  _isFantasyMixDoing = false,
  _elapsedTime = 0,
  _effectType = 0,
  _fantasyMixNakData = {
    _setData = false,
    _notifyType = nil,
    _playerName = nil,
    _fromName = nil,
    _iconPath = nil,
    _param1 = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _itemSlot = nil,
  _isConsole = false,
  _initailize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantExchange_Fantasy_All_Init")
function FromClient_ServantExchange_Fantasy_All_Init()
  PaGlobal_ServantExchange_Fantasy_All:initialize()
end
