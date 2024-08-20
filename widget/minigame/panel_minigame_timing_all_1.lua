function PaGlobal_MiniGame_Timing_All:initialize()
  if nil == Panel_MiniGame_Timing_All or true == PaGlobal_MiniGame_Timing_All._initialize then
    return
  end
  PaGlobal_MiniGame_Timing_All._ui.stc_timingBG = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_Timing_BG")
  PaGlobal_MiniGame_Timing_All._ui.progress_timing = UI.getChildControl(Panel_MiniGame_Timing_All, "Progress2_Timing")
  PaGlobal_MiniGame_Timing_All._ui.stc_timingProgress_head = UI.getChildControl(PaGlobal_MiniGame_Timing_All._ui.progress_timing, "Progress2_1_Timing_Head")
  PaGlobal_MiniGame_Timing_All._ui.stc_timing = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_Timing")
  PaGlobal_MiniGame_Timing_All._ui.stc_arrow = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_Arrows")
  PaGlobal_MiniGame_Timing_All._ui.stc_spacebar = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_SpaceBar")
  PaGlobal_MiniGame_Timing_All._ui.txt_spacebarText = UI.getChildControl(PaGlobal_MiniGame_Timing_All._ui.stc_spacebar, "StaticText_KeyBind")
  PaGlobal_MiniGame_Timing_All._ui.stc_keyguideA = UI.getChildControl(Panel_MiniGame_Timing_All, "StaticText_A_ConsoleUI")
  PaGlobal_MiniGame_Timing_All._ui.txt_purposeText = UI.getChildControl(Panel_MiniGame_Timing_All, "StaticText_Purpose")
  PaGlobal_MiniGame_Timing_All._ui.stc_resultGood = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_Result_Good")
  PaGlobal_MiniGame_Timing_All._ui.stc_resultBad = UI.getChildControl(Panel_MiniGame_Timing_All, "Static_Result_Bad")
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText = UI.getChildControl(Panel_MiniGame_Timing_All, "StaticText_ResultTxt")
  PaGlobal_MiniGame_Timing_All._ui.stc_horseIcon = UI.getChildControl(PaGlobal_MiniGame_Timing_All._ui.stc_arrow, "Static_IconHorse")
  PaGlobal_MiniGame_Timing_All._ui.stc_jumpIcon = UI.getChildControl(PaGlobal_MiniGame_Timing_All._ui.stc_arrow, "Static_IconMedic")
  PaGlobal_MiniGame_Timing_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_MiniGame_Timing_All._ui.stc_spacebar:SetShow(not self._isConsole)
  PaGlobal_MiniGame_Timing_All._ui.stc_keyguideA:SetShow(self._isConsole)
  PaGlobal_MiniGame_Timing_All:registerEventHandler()
  PaGlobal_MiniGame_Timing_All:validate()
  PaGlobal_MiniGame_Timing_All._initialize = true
end
function PaGlobal_MiniGame_Timing_All:registerEventHandler()
  if nil == Panel_MiniGame_Timing_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_Timing_All_OnScreenSize")
  if true == PaGlobal_MiniGame_Timing_All._isConsole then
    registerEvent("EventActionMiniGamePadDownOnce", "FromClient_Minigame_Timing_All_Freeze")
  end
end
function PaGlobal_MiniGame_Timing_All:prepareOpen()
  if nil == Panel_MiniGame_Timing_All then
    return
  end
  if true == PaGlobal_MiniGame_Timing_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetClose()
    PaGlobal_MiniGame_Timing_All._isGameStart = true
  end
  Panel_MiniGame_Timing_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  PaGlobal_MiniGame_Timing_All._ui.stc_spacebar:SetShow(not self._isConsole)
  PaGlobal_MiniGame_Timing_All._ui.stc_keyguideA:SetShow(self._isConsole)
  PaGlobal_MiniGame_Timing_All:open()
end
function PaGlobal_MiniGame_Timing_All:open()
  if nil == Panel_MiniGame_Timing_All or true == Panel_MiniGame_Timing_All:GetShow() then
    return
  end
  Panel_MiniGame_Timing_All:SetShow(true)
end
function PaGlobal_MiniGame_Timing_All:prepareClose()
  if nil == Panel_MiniGame_Timing_All or false == Panel_MiniGame_Timing_All:GetShow() then
    return
  end
  if true == PaGlobal_MiniGame_Timing_All._isConsole then
    PaGlobal_ConsoleQuickMenu:widgetOpen()
    PaGlobal_MiniGame_Timing_All._isGameStart = false
  end
  Panel_MiniGame_Timing_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_Timing_All:close()
end
function PaGlobal_MiniGame_Timing_All:close()
  if nil == Panel_MiniGame_Timing_All or false == Panel_MiniGame_Timing_All:GetShow() then
    return
  end
  Panel_MiniGame_Timing_All:SetShow(false)
end
function PaGlobal_MiniGame_Timing_All:setCurrentPosIcon()
  local startPos = PaGlobal_MiniGame_Timing_All._ui.stc_timingBG:GetPosY() - PaGlobal_MiniGame_Timing_All._ui.stc_arrow:GetSizeY() / 2
  local endPos = startPos + PaGlobal_MiniGame_Timing_All._ui.stc_timingBG:GetSizeY()
  local controlPos = Util.Math.Lerp(startPos, endPos, 1 - PaGlobal_MiniGame_Timing_All._currentProgressValue)
  PaGlobal_MiniGame_Timing_All._ui.stc_arrow:SetPosY(controlPos)
end
function PaGlobal_MiniGame_Timing_All:playingUpdate(deltaTime)
  if PaGlobal_MiniGame_Timing_All._isUpTiming then
    PaGlobal_MiniGame_Timing_All._currentTimingValue = PaGlobal_MiniGame_Timing_All._currentTimingValue + deltaTime * PaGlobal_MiniGame_Timing_All._timing_Speed
    if PaGlobal_MiniGame_Timing_All._currentTimingValue > 1 then
      PaGlobal_MiniGame_Timing_All._currentTimingValue = 2 - PaGlobal_MiniGame_Timing_All._currentTimingValue
      PaGlobal_MiniGame_Timing_All._isUpTiming = false
    end
  else
    PaGlobal_MiniGame_Timing_All._currentTimingValue = PaGlobal_MiniGame_Timing_All._currentTimingValue - deltaTime * PaGlobal_MiniGame_Timing_All._timing_Speed
    if PaGlobal_MiniGame_Timing_All._currentTimingValue < 0 then
      PaGlobal_MiniGame_Timing_All._currentTimingValue = -PaGlobal_MiniGame_Timing_All._currentTimingValue
      PaGlobal_MiniGame_Timing_All._isUpTiming = true
    end
  end
  if PaGlobal_MiniGame_Timing_All._isUpProgress then
    PaGlobal_MiniGame_Timing_All._sumTime = PaGlobal_MiniGame_Timing_All._sumTime + deltaTime * PaGlobal_MiniGame_Timing_All._progressBar_SpeedPerSec
    if 1 < PaGlobal_MiniGame_Timing_All._sumTime then
      PaGlobal_MiniGame_Timing_All._sumTime = 1
      PaGlobal_MiniGame_Timing_All._isUpProgress = false
    end
  else
    PaGlobal_MiniGame_Timing_All._sumTime = PaGlobal_MiniGame_Timing_All._sumTime - deltaTime * PaGlobal_MiniGame_Timing_All._progressBar_SpeedPerSec
    if 0 >= PaGlobal_MiniGame_Timing_All._sumTime then
      PaGlobal_MiniGame_Timing_All._sumTime = 0
      PaGlobal_MiniGame_Timing_All._isUpProgress = true
      audioPostEvent_SystemUi(11, 2)
      _AudioPostEvent_SystemUiForXBOX(11, 2)
      PaGlobal_MiniGame_Timing_All:endAnimation(PaGlobal_MiniGame_Timing_All._ui.txt_resultText, PaGlobal_MiniGame_Timing_All._ui.stc_resultBad, Defines.Color.C_FFF26A6A, PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_ROPE_FAILED"), "Bad")
      PaGlobal_MiniGame_Timing_All._playMode = 2
      PaGlobal_MiniGame_Timing_All._sumTime = 0
      PaGlobal_MiniGame_Timing_All._isWin = false
      getSelfPlayer():get():SetMiniGameResult(1)
    end
  end
  PaGlobal_MiniGame_Timing_All._currentProgressValue = PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._progressBar_speedValue3
  PaGlobal_MiniGame_Timing_All._currentProgressValue = PaGlobal_MiniGame_Timing_All._currentProgressValue + PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._progressBar_speedValue2
  PaGlobal_MiniGame_Timing_All._currentProgressValue = PaGlobal_MiniGame_Timing_All._currentProgressValue + PaGlobal_MiniGame_Timing_All._sumTime * PaGlobal_MiniGame_Timing_All._progressBar_speedValue1
  if 1 <= PaGlobal_MiniGame_Timing_All._currentProgressValue then
    PaGlobal_MiniGame_Timing_All._currentProgressValue = 1
  elseif 0 >= PaGlobal_MiniGame_Timing_All._currentProgressValue then
    PaGlobal_MiniGame_Timing_All._currentProgressValue = 0
  end
  PaGlobal_MiniGame_Timing_All:timingUpdate(deltaTime)
  PaGlobal_MiniGame_Timing_All:progressUpdate(deltaTime)
end
function PaGlobal_MiniGame_Timing_All:timingUpdate(deltaTime)
  local sizeY = PaGlobal_MiniGame_Timing_All._ui.progress_timing:GetSizeY() * (PaGlobal_MiniGame_Timing_All._timing_min + (PaGlobal_MiniGame_Timing_All._timing_max - PaGlobal_MiniGame_Timing_All._timing_min) * PaGlobal_MiniGame_Timing_All._currentTimingValue)
  PaGlobal_MiniGame_Timing_All._ui.stc_timing:SetSize(PaGlobal_MiniGame_Timing_All._ui.stc_timing:GetSizeX(), sizeY)
  local percent = 1 - PaGlobal_MiniGame_Timing_All._timing_Middle
  PaGlobal_MiniGame_Timing_All._ui.stc_timing:SetPosY(percent * PaGlobal_MiniGame_Timing_All._ui.progress_timing:GetSizeY() - sizeY / 2)
  PaGlobal_MiniGame_Timing_All._ui.stc_spacebar:SetPosY(percent * PaGlobal_MiniGame_Timing_All._ui.progress_timing:GetSizeY() - PaGlobal_MiniGame_Timing_All._ui.stc_spacebar:GetSizeY() / 2)
end
function PaGlobal_MiniGame_Timing_All:progressUpdate(deltaTime)
  PaGlobal_MiniGame_Timing_All._ui.progress_timing:SetProgressRate(PaGlobal_MiniGame_Timing_All._currentProgressValue * 100)
  PaGlobal_MiniGame_Timing_All._ui.progress_timing:SetCurrentProgressRate(PaGlobal_MiniGame_Timing_All._currentProgressValue * 100)
  PaGlobal_MiniGame_Timing_All:setCurrentPosIcon()
end
function PaGlobal_MiniGame_Timing_All:endTimeUpdate(deltaTime)
  PaGlobal_MiniGame_Timing_All._sumTime = PaGlobal_MiniGame_Timing_All._sumTime + deltaTime
  if PaGlobal_MiniGame_Timing_All._endAnimationTime <= PaGlobal_MiniGame_Timing_All._sumTime then
    PaGlobal_MiniGame_Timing_All:endUI()
    PaGlobal_MiniGame_Timing_All._playMode = 3
  end
end
function PaGlobal_MiniGame_Timing_All:endUI()
  if PaGlobal_MiniGame_Timing_All._isWin then
    getSelfPlayer():get():SetMiniGameResult(2)
  else
    getSelfPlayer():get():SetMiniGameResult(3)
  end
  PaGlobal_MiniGame_Timing_All_EndGame()
end
function PaGlobal_MiniGame_Timing_All:endAnimation(controlText, controlResult, color, text, aniText)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:ResetVertexAni()
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Color_empty", true)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Color_1", true)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Scale_0", true)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Scale_1", true)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Scale_End", true)
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:SetVertexAniRun("Ani_Color_End", true)
  controlText:SetShow(true)
  controlText:SetText(text)
  controlText:SetFontColor(color)
  controlResult:SetShow(true)
  controlResult:ResetVertexAni()
  controlResult:SetVertexAniRun(aniText .. "_Ani", true)
  controlResult:SetVertexAniRun(aniText .. "_ScaleAni", true)
end
function PaGlobal_MiniGame_Timing_All:validate()
  if nil == Panel_MiniGame_Timing_All then
    return
  end
  PaGlobal_MiniGame_Timing_All._ui.stc_timingBG:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.progress_timing:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.stc_timing:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.stc_arrow:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.stc_spacebar:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.txt_purposeText:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.stc_resultGood:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.stc_resultBad:isValidate()
  PaGlobal_MiniGame_Timing_All._ui.txt_resultText:isValidate()
end
