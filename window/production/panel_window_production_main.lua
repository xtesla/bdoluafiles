local PaGlobal_Production_Main = {
  _ui = {
    stc_LatterBoxTop = nil,
    stc_LatterBoxBottom = nil,
    txt_noticeText = nil
  },
  _originalTopSizeY = 0,
  _originalBottomSizeY = 0,
  _topSizeY = 0,
  _bottomSizeY = 0
}
local IgnoredAudioIdexTable = {
  {indexA = 1, indexB = 5},
  {indexA = 3, indexB = 2},
  {indexA = 3, indexB = 4},
  {indexA = 3, indexB = 7},
  {indexA = 3, indexB = 17},
  {indexA = 3, indexB = 18},
  {indexA = 4, indexB = 0},
  {indexA = 4, indexB = 1},
  {indexA = 4, indexB = 2},
  {indexA = 4, indexB = 3},
  {indexA = 8, indexB = 0},
  {indexA = 8, indexB = 1},
  {indexA = 15, indexB = 0},
  {indexA = 15, indexB = 1},
  {indexA = 15, indexB = 2},
  {indexA = 15, indexB = 3},
  {indexA = 15, indexB = 4},
  {indexA = 19, indexB = 0},
  {indexA = 19, indexB = 1},
  {indexA = 19, indexB = 2},
  {indexA = 19, indexB = 3},
  {indexA = 19, indexB = 4},
  {indexA = 19, indexB = 5},
  {indexA = 19, indexB = 6},
  {indexA = 19, indexB = 7},
  {indexA = 19, indexB = 8},
  {indexA = 19, indexB = 9},
  {indexA = 19, indexB = 12},
  {indexA = 19, indexB = 13},
  {indexA = 19, indexB = 14},
  {indexA = 19, indexB = 50},
  {indexA = 19, indexB = 51},
  {indexA = 22, indexB = 0},
  {indexA = 22, indexB = 1},
  {indexA = 22, indexB = 2},
  {indexA = 22, indexB = 3},
  {indexA = 22, indexB = 4},
  {indexA = 22, indexB = 5},
  {indexA = 22, indexB = 6},
  {indexA = 22, indexB = 7},
  {indexA = 22, indexB = 8},
  {indexA = 22, indexB = 9}
}
local offsetY = 10
function PaGlobal_Production_Main:initialize()
  if nil == Panel_Window_Production_Main then
    return
  end
  self._ui.stc_LatterBoxTop = UI.getChildControl(Panel_Window_Production_Main, "Static_Top")
  self._ui.stc_LatterBoxBottom = UI.getChildControl(Panel_Window_Production_Main, "Static_Bottom")
  self._ui.txt_noticeText = UI.getChildControl(Panel_Window_Production_Main, "MultilineText_NoticeText")
  self._originalTopSizeY = self._ui.stc_LatterBoxTop:GetSizeY()
  self._originalBottomSizeY = self._ui.stc_LatterBoxBottom:GetSizeY()
  self._ui.txt_noticeText:SetText("")
  PaGlobal_Production_Main_ReSizePanel()
  Panel_Window_Production_Main:RegisterUpdateFunc("Panel_OnlyPerframeUsedFunction")
end
function PaGlobal_Production_Main:startLetterBoxAnimation()
  if nil == Panel_Window_Production_Main then
    return
  end
  local screenY = getScreenSizeY()
  local top = self._ui.stc_LatterBoxTop:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  top:SetStartPosition(0, -self._topSizeY - offsetY)
  top:SetEndPosition(0, 0)
  self._ui.stc_LatterBoxTop:CalcUIAniPos(top)
  local bottom = self._ui.stc_LatterBoxBottom:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  bottom:SetStartPosition(0, screenY)
  bottom:SetEndPosition(0, screenY - self._bottomSizeY + offsetY)
  self._ui.stc_LatterBoxBottom:CalcUIAniPos(bottom)
end
function PaGlobal_Production_Main:endLetterBoxAnimation()
  if nil == Panel_Window_Production_Main then
    return
  end
  local screenY = getScreenSizeY()
  local top = self._ui.stc_LatterBoxTop:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  top:SetStartPosition(0, 0)
  top:SetEndPosition(0, -self._topSizeY - offsetY)
  self._ui.stc_LatterBoxTop:CalcUIAniPos(top)
  local bottom = self._ui.stc_LatterBoxBottom:addMoveAnimation(0, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  bottom:SetStartPosition(0, screenY - self._bottomSizeY + offsetY)
  bottom:SetEndPosition(0, screenY)
  self._ui.stc_LatterBoxBottom:CalcUIAniPos(bottom)
end
function PaGlobal_Production_Main_PerFrameUpdate()
  if nil == Panel_Window_Production_Main then
    return
  end
end
function FromClient_Production_Main_Init()
  if nil == Panel_Window_Production_Main then
    return
  end
  PaGlobal_Production_Main:initialize()
end
function FromClient_Production_Main_StartProduction()
  if nil == Panel_Window_Production_Main then
    return
  end
  Panel_Window_Production_Main:SetShow(true)
  PaGlobal_Production_Main:startLetterBoxAnimation()
  Panel_Widget_NewTutorial_Key:SetShow(false)
  Panel_Widget_NewTutorial_Quest:SetShow(false)
  Panel_Widget_NewTutorial_SkillGuide:SetShow(false)
end
function FromClient_Production_Main_EndProduction()
  if nil == Panel_Window_Production_Main then
    return
  end
  if true == Panel_Window_Production_Main:GetShow() then
    PaGlobal_Production_Main:endLetterBoxAnimation()
  end
  Panel_Widget_NewTutorial_Key:SetShow(false)
  Panel_Widget_NewTutorial_Quest:SetShow(false)
  Panel_Widget_NewTutorial_SkillGuide:SetShow(false)
  PaGlobal_Production_Tutorial_Main_Open()
end
function FromClient_Production_AudioPostEvent(AudioIndexA, AudioIndexB)
  if nil == Panel_Window_Production_Main then
    return
  end
  local doIgnore = false
  for key, value in pairs(IgnoredAudioIdexTable) do
    if value.indexA == AudioIndexA and value.indexB == AudioIndexB then
      doIgnore = true
      return
    end
  end
  if false == doIgnore then
    AudioPostEvent_SystemUi_ForProductionXXXXX(AudioIndexA, AudioIndexB)
  end
  return
end
function FromClient_readyPlayerControlModeInCutscene(noticeText, readyControl)
  if nil == PaGlobal_Production_Main then
    return
  end
  local self = PaGlobal_Production_Main
  if true == readyControl then
    self._ui.txt_noticeText:SetText(noticeText)
  else
    self._ui.txt_noticeText:SetText("")
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Production_Main_Init")
registerEvent("FromClient_startProduction", "FromClient_Production_Main_StartProduction")
registerEvent("FromClient_endProduction", "FromClient_Production_Main_EndProduction")
registerEvent("FromClient_readyPlayerControlModeInCutscene", "FromClient_readyPlayerControlModeInCutscene")
registerEvent("onScreenResize", "PaGlobal_Production_Main_ReSizePanel")
function PaGlobal_Production_Main_OpenLetterBox()
  if nil == Panel_Window_Production_Main then
    return
  end
  Panel_Window_Production_Main:SetShow(true)
end
function PaGlobal_Production_Main_CloseLetterBox()
  if nil == Panel_Window_Production_Main then
    return
  end
  Panel_Window_Production_Main:SetShow(false)
end
function PaGlobal_Production_Main_ReSizePanel()
  if nil == PaGlobal_Production_Main then
    return
  end
  local self = PaGlobal_Production_Main
  local resolutionScreenX = getResolutionSizeX()
  local resolutionScreenY = getResolutionSizeY()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local lateY = screenY / resolutionScreenY
  Panel_Window_Production_Main:SetSize(screenX, screenY)
  Panel_Window_Production_Main:SetPosX(0)
  Panel_Window_Production_Main:SetPosY(0)
  Panel_Window_Production_Main:ComputePos()
  self._topSizeY = self._originalTopSizeY * lateY
  self._bottomSizeY = self._originalBottomSizeY * lateY
  if nil ~= self._ui.stc_LatterBoxTop then
    self._ui.stc_LatterBoxTop:SetSize(screenX, self._topSizeY)
    self._ui.stc_LatterBoxTop:SetPosX(0)
    self._ui.stc_LatterBoxTop:SetPosY(0)
  end
  if nil ~= self._ui.stc_LatterBoxBottom then
    self._ui.stc_LatterBoxBottom:SetSize(screenX, self._bottomSizeY)
    self._ui.stc_LatterBoxBottom:SetPosX(0)
  end
  if nil ~= self._ui.txt_noticeText then
    self._ui.txt_noticeText:SetText("")
    self._ui.txt_noticeText:SetSize(screenX, self._ui.txt_noticeText:GetSizeY())
    self._ui.txt_noticeText:ComputePos()
  end
  Panel_Window_Production_Main:SetShow(false)
end
