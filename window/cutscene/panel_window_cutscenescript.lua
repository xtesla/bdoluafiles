PaGlobal_CutSceneScript = {
  _ui = {
    _stc_textArea = UI.getChildControl(Panel_Window_CutSceneScript, "Static_TextArea"),
    _stc_skipAnno = UI.getChildControl(Panel_Window_CutSceneScript, "StaticText_SkipAnno"),
    _stc_keyPress = UI.getChildControl(Panel_Window_CutSceneScript, "Static_CircleProgress_PressBG")
  },
  _tickCount = 0,
  _scriptCurrentIdx = 0,
  _scriptMaxCount = 0,
  _skipState = {
    Press_Any_Key = 0,
    Press_R_Key = 1,
    End = 2
  },
  _currentSkipState = 0,
  _keyPressTime = 0,
  _keyPressMaxTime = 2,
  _joyPadKey = {
    __eJoyPadInputType_LeftStick_Up,
    __eJoyPadInputType_LeftStick_Down,
    __eJoyPadInputType_LeftStick_Left,
    __eJoyPadInputType_LeftStick_Right,
    __eJoyPadInputType_RightStick_Up,
    __eJoyPadInputType_RightStick_Down,
    __eJoyPadInputType_RightStick_Left,
    __eJoyPadInputType_RightStick_Right,
    __eJoyPadInputType_LeftTrigger,
    __eJoyPadInputType_RightTrigger,
    __eJoyPadInputType_DPad_Up,
    __eJoyPadInputType_DPad_Down,
    __eJoyPadInputType_DPad_Left,
    __eJoyPadInputType_DPad_Right,
    __eJoyPadInputType_Start,
    __eJoyPadInputType_Back,
    __eJoyPadInputType_LeftThumb,
    __eJoyPadInputType_RightThumb,
    __eJoyPadInputType_LeftShoulder,
    __eJoyPadInputType_RightShoulder,
    __eJoyPadInputType_A,
    __eJoyPadInputType_B,
    __eJoyPadInputType_X,
    __eJoyPadInputType_Y
  },
  _prevUIMode = Defines.UIMode.eUIMode_Default,
  _initialize = false
}
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneScript_1.lua")
runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneScript_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CutSceneScript_Init")
function FromClient_CutSceneScript_Init()
  PaGlobal_CutSceneScript:initialize()
end
