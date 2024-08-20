PaGlobal_ColorPalette_All = {
  _ui = {
    btn_close = nil,
    stc_title = nil,
    stc_paletteBG = nil,
    stc_brightBG = nil,
    stc_palette = nil,
    stc_bright = nil,
    stc_paletteCursor = nil,
    stc_brightSlider = nil,
    txt_textInfoR = nil,
    txt_textInfoG = nil,
    txt_textInfoB = nil,
    edit_numberR = nil,
    edit_numberG = nil,
    edit_numberB = nil,
    brightLevel = {}
  },
  _colorValue = {
    hue = nil,
    saturation = nil,
    bright = nil,
    red = nil,
    green = nil,
    blue = nil
  },
  _callerInfo = {
    classType = nil,
    paramType = nil,
    paramIndex = nil
  },
  _config = {brightLevelCount = 20, notUsedYet = -1},
  _rgbType = {
    red = 0,
    green = 1,
    blue = 2
  },
  _palettePanelType = {hueSaturation = 0, lightness = 1},
  _lastAppliedRGBPerPartList = {},
  _isRGBChanged = false,
  _isPanelPressed = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All_1.lua")
runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ColorPalette_All_Init")
function FromClient_ColorPalette_All_Init()
  PaGlobal_ColorPalette_All:initialize()
end
