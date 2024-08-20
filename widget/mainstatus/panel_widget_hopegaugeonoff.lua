PaGlobal_HopeGaugeOnOff = {
  _ui = {
    _stc_slot = nil,
    _btn_open = nil,
    _btn_off = nil,
    _btn_1set = nil,
    _btn_2set = nil,
    _btn_charge = nil,
    _stc_effect = nil,
    _stc_off = nil,
    _stc_1set = nil,
    _stc_2set = nil,
    _txt_time = nil,
    _stc_mainBg = nil,
    _btn_list = {}
  },
  _config = {
    _aniStartPosX = 0,
    _aniStartPosY = 0,
    _aniSpeed = 0,
    _aniDistance = 0,
    _aniBeginPosX = {},
    _aniBeginPosY = {},
    _aniEndPosX = {},
    _aniEndPosY = {},
    _textureUV = {
      [0] = {
        1,
        102,
        71,
        172
      },
      {
        72,
        102,
        142,
        172
      },
      {
        143,
        102,
        213,
        172
      }
    }
  },
  _BTN_TYPE = {
    OFF = 0,
    SET_1 = 1,
    SET_2 = 2,
    COUNT = 3
  },
  _tooltip = {
    _charge = 0,
    _1set = 1,
    _2set = 2,
    _off = 3,
    _slot = 4
  },
  _isPold = true,
  _isOver = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff_1.lua")
runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HopeGaugeOnOffInit")
function FromClient_HopeGaugeOnOffInit()
  PaGlobal_HopeGaugeOnOff:initialize()
  if 0 ~= ToClient_AppliedHopeDrop() or true == ToClient_getItemCollectionScrollUiOn() then
    PaGlobal_HopeGaugeOnOff:prepareOpen()
  end
end
