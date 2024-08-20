function PaGlobal_MiniGame_Gradient_All_Open()
  if nil == Panel_Minigame_Gradient_All then
    return
  end
  PaGlobal_MiniGame_Gradient_All:prepareOpen()
end
function PaGlobal_MiniGame_Gradient_All_Close()
  if nil == Panel_Minigame_Gradient_All or false == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_Gradient_All:prepareClose()
end
function PaGlobal_MiniGame_Gradient_All_GetShow()
  if nil == Panel_Minigame_Gradient_All then
    return false
  end
  return Panel_Minigame_Gradient_All:GetShow()
end
function PaGlobal_MiniGame_Gradient_All_GaugeMove(isLeft)
  if nil == Panel_Minigame_Gradient_All or false == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  local speedWeight = PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMinWeight
  if PaGlobal_MiniGame_Gradient_All._lastClickTime < PaGlobal_MiniGame_Gradient_All._sequenceClickTimeSpan then
    speedWeight = Util.Math.Lerp(PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMaxWeight, PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMinWeight, PaGlobal_MiniGame_Gradient_All._lastClickTime / PaGlobal_MiniGame_Gradient_All._sequenceClickTimeSpan)
    PaGlobal_MiniGame_Gradient_All._lastClickDirection = PaGlobal_MiniGame_Gradient_All._clickDirection.None
  end
  if true == isLeft then
    PaGlobal_MiniGame_Gradient_All._lastClickDirection = PaGlobal_MiniGame_Gradient_All._clickDirection.Left
    PaGlobal_MiniGame_Gradient_All._currentSpeed = PaGlobal_MiniGame_Gradient_All._currentSpeed - speedWeight
    if false == PaGlobal_MiniGame_Gradient_All._isConsole then
      PaGlobal_MiniGame_Gradient_All._ui.stc_mouseButton_L:ResetVertexAni()
      PaGlobal_MiniGame_Gradient_All._ui.stc_mouseButton_L:SetVertexAniRun("Ani_Color_Left", true)
    end
  else
    PaGlobal_MiniGame_Gradient_All._lastClickDirection = PaGlobal_MiniGame_Gradient_All._clickDirection.Right
    PaGlobal_MiniGame_Gradient_All._currentSpeed = PaGlobal_MiniGame_Gradient_All._currentSpeed + speedWeight
    if false == PaGlobal_MiniGame_Gradient_All._isConsole then
      PaGlobal_MiniGame_Gradient_All._ui.stc_mouseButton_R:ResetVertexAni()
      PaGlobal_MiniGame_Gradient_All._ui.stc_mouseButton_R:SetVertexAniRun("Ani_Color_Right", true)
    end
  end
  PaGlobal_MiniGame_Gradient_All._lastClickTime = 0
end
function PaGlobal_MiniGame_Gradient_All_HideHallowinIcon()
  PaGlobal_MiniGame_Gradient_All._ui.stc_Icon:SetShow(true)
  PaGlobal_MiniGame_Gradient_All._ui.stc_HallowinIcon:SetShow(false)
end
function PaGlobal_MiniGame_Gradient_All_StartGame()
  if true == PaGlobal_MiniGame_Gradient_All._isConsole then
    math.randomseed(getTickCount32())
  else
    math.randomseed(os.time())
  end
  local speed = math.random()
  PaGlobal_MiniGame_Gradient_All._currentSpeed = (speed - 0.5) / 4
  local centerPos = Panel_Minigame_Gradient_All:GetSizeX() / 2 - PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar:GetSizeX() / 2
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBar:SetPosX(centerPos)
  PaGlobal_MiniGame_Gradient_All._lastClickDirection = PaGlobal_MiniGame_Gradient_All._clickDirection.None
  PaGlobal_MiniGame_Gradient_All._lastClickTime = 0
  PaGlobal_MiniGame_Gradient_All._currentPos = 0.5
  local isHallowin = FGlobal_isPlaying_CartHallowin()
  PaGlobal_MiniGame_Gradient_All._ui.stc_Icon:SetShow(not isHallowin)
  PaGlobal_MiniGame_Gradient_All._ui.stc_HallowinIcon:SetShow(isHallowin)
  if true == FGlobal_isPlaying_CartRace() then
    PaGlobal_MiniGame_Gradient_All._sequenceClickTimeSpan = 0.5
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMaxWeight = 1.45
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMinWeight = 0.85
    PaGlobal_MiniGame_Gradient_All._speedWeight = 8
  elseif true == isHallowin then
    PaGlobal_MiniGame_Gradient_All._sequenceClickTimeSpan = 0.45
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMaxWeight = 0.65
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMinWeight = 0.25
    PaGlobal_MiniGame_Gradient_All._speedWeight = 1
  else
    PaGlobal_MiniGame_Gradient_All._sequenceClickTimeSpan = 1
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMaxWeight = 0.35
    PaGlobal_MiniGame_Gradient_All._ClickTimeSpanMinWeight = 0.15
    PaGlobal_MiniGame_Gradient_All._speedWeight = 1
  end
  PaGlobal_MiniGame_Gradient_All_Open()
end
function PaGlobal_MiniGame_Gradient_All_EndGame()
  PaGlobal_MiniGame_Gradient_All_HideHallowinIcon()
  PaGlobal_MiniGame_Gradient_All_Close()
end
function PaGlobal_MiniGame_Gradient_All_GaugeBarMoveCalc(fDeltaTime)
  PaGlobal_MiniGame_Gradient_All._lastClickTime = PaGlobal_MiniGame_Gradient_All._lastClickTime + fDeltaTime
  local currentPos = PaGlobal_MiniGame_Gradient_All._currentPos + PaGlobal_MiniGame_Gradient_All._currentSpeed * fDeltaTime
  if currentPos < 0 then
    currentPos = 0
    getSelfPlayer():get():SetMiniGameResult(0)
  elseif currentPos > 1 then
    currentPos = 1
    getSelfPlayer():get():SetMiniGameResult(3)
  end
  if currentPos < 0.25 or currentPos > 0.75 then
    if false == PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad:GetShow() then
      audioPostEvent_SystemUi(11, 2)
      _AudioPostEvent_SystemUiForXBOX(11, 2)
      PaGlobal_MiniGame_Gradient_All:showBadResultAni()
      if currentPos < 0.25 then
        getSelfPlayer():get():SetMiniGameResult(1)
      else
        getSelfPlayer():get():SetMiniGameResult(2)
      end
    end
  elseif false == PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood:GetShow() then
    audioPostEvent_SystemUi(11, 1)
    _AudioPostEvent_SystemUiForXBOX(11, 1)
    getSelfPlayer():get():SetMiniGameResult(4)
    PaGlobal_MiniGame_Gradient_All:showGoodResultAni()
  end
  PaGlobal_MiniGame_Gradient_All._currentPos = currentPos
  PaGlobal_MiniGame_Gradient_All._currentSpeed = PaGlobal_MiniGame_Gradient_All._currentSpeed - (0.5 - currentPos) * PaGlobal_MiniGame_Gradient_All._speedWeight * fDeltaTime
  PaGlobal_MiniGame_Gradient_All:setCurrentPosIcon()
end
function FromClient_Minigame_Gradient_All_OnScreenSize()
  if nil == Panel_Minigame_Gradient_All or false == Panel_Minigame_Gradient_All:GetShow() then
    return
  end
  Panel_Minigame_Gradient_All:ComputePos()
  PaGlobal_MiniGame_Gradient_All._ui.stc_gaugeBG:ComputePos()
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultGood:ComputePos()
  PaGlobal_MiniGame_Gradient_All._ui.stc_resultBad:ComputePos()
end
function FromClient_Minigame_Gradient_All_KeyPress(keyType)
  if false == PaGlobal_MiniGame_Gradient_All.isGradientPlay then
    return
  end
  if true == PaGlobal_MiniGame_Gradient_All._isConsole then
    if __eQuickTimeEventPadType_LT == keyType then
      PaGlobal_MiniGame_Gradient_All_GaugeMove(true)
    elseif __eQuickTimeEventPadType_RT == keyType then
      PaGlobal_MiniGame_Gradient_All_GaugeMove(false)
    end
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M0 == keyType then
    PaGlobal_MiniGame_Gradient_All_GaugeMove(true)
  elseif CppEnums.MiniGameKeyType.MiniGameKeyType_M1 == keyType then
    PaGlobal_MiniGame_Gradient_All_GaugeMove(false)
  end
end
