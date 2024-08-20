Panel_Arsha_Replay_All:SetShow(false)
local ReplayHpIndexTable = Array.new()
local arshaReplayWidget = {
  _replayArea = UI.getChildControl(Panel_Arsha_Replay_All, "Static_ReplayArea"),
  _bookmarkCount = 0,
  _isFinishLoadReplay = false
}
arshaReplayWidget._playBar = UI.getChildControl(arshaReplayWidget._replayArea, "Slider_Playbar")
arshaReplayWidget._progressBarButton = UI.getChildControl(arshaReplayWidget._playBar, "Slider_1_Button")
arshaReplayWidget._playCheckBox = UI.getChildControl(arshaReplayWidget._replayArea, "Checkbox_Play")
arshaReplayWidget._stopButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Stop")
arshaReplayWidget._roundTime = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_RoundTime")
arshaReplayWidget._replayName = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayName")
arshaReplayWidget._replayState = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayState")
arshaReplayWidget._bookmarkBase = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_KillTimingShow")
arshaReplayWidget._bookmarkPool = Array.new()
arshaReplayWidget._bookmarkList = Array.new()
arshaReplayWidget._bookmarkTimeList = Array.new()
arshaReplayWidget._rightButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Right")
arshaReplayWidget._leftButton = UI.getChildControl(arshaReplayWidget._replayArea, "Button_Left")
arshaReplayWidget._replayRateText = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_ReplayRate")
arshaReplayWidget._slowPlayButton = UI.getChildControl(arshaReplayWidget._replayRateText, "Button_SlowPlay")
arshaReplayWidget._fastPlayButton = UI.getChildControl(arshaReplayWidget._replayRateText, "Button_FastPlay")
arshaReplayWidget._camDistText = UI.getChildControl(arshaReplayWidget._replayArea, "StaticText_CamDist")
arshaReplayWidget._camDistEditBox = UI.getChildControl(arshaReplayWidget._replayArea, "Edit_CamDist")
arshaReplayWidget._replayLength = 0
arshaReplayWidget._currentTime = 0
local ReplayState_Type = {RECORDING = 0, STOP_RECORDING = 1}
function ArshaReplayWidget_Init()
  local self = arshaReplayWidget
  self._bookmarkBase:SetShow(false)
  self._playBar:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._playBar:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ReadyReplayUseTime()")
  self._progressBarButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._progressBarButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayReplay()")
  self._progressBarButton:addInputEvent("Mouse_LPress", "ArshaReplayWidget_UpdateWhenClickSlideButton()")
  self._playCheckBox:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayOrPauseReplay()")
  self._playCheckBox:SetCheck(true)
  self._stopButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_StopReplay()")
  self._replayState:SetText("Stop Recording")
  self._rightButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._rightButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickRightOrLeftButton(5)")
  self._leftButton:addInputEvent("Mouse_LDown", "ArshaReplayWidget_PauseReplay()")
  self._leftButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ClickRightOrLeftButton(-5)")
  self._slowPlayButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_SetPlayRate(false)")
  self._fastPlayButton:addInputEvent("Mouse_LUp", "ArshaReplayWidget_SetPlayRate(true)")
  self._playBar:SetInterval(1000)
  self._camDistText:SetIgnore(false)
  self._camDistEditBox:SetShow(false)
  self._camDistText:addInputEvent("Mouse_LUp", "ArshaReplayWidget_EditBoxToggle()")
  self._camDistEditBox:addInputEvent("Mouse_LUp", "ArshaReplayWidget_ConfirmEditBox()")
  ArshaReplayWidgetClearHpColorIndex()
end
function ArshaReplayWidget_SetPlayRate(isAdd)
  ToClient_SetReplayRate(isAdd)
end
function ArshaReplayWidget_ReadyReplayUseTime()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ToClient_PlayReplay()
end
function ArshaReplayWidget_UpdateWhenClickSlideButton()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(false)
  local elepsedTime = math.ceil(self._replayLength * self._playBar:GetControlPos())
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ToClient_PlayReplay(true)
  ToClient_PauseReplay()
end
function ArshaReplayWidget_SetReplayName(replayName)
  local self = arshaReplayWidget
  self._replayName:SetText(replayName)
end
function ArshaReplayWidget_ClickRightOrLeftButton(addTime)
  local self = arshaReplayWidget
  local elepsedTime = math.ceil(self._replayLength * self._playBar:GetControlPos())
  elepsedTime = elepsedTime + addTime * 1000
  if elepsedTime < 0 then
    elepsedTime = 0
  end
  if elepsedTime > self._replayLength then
    elepsedTime = self._replayLength
  end
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playBar:SetControlPos(elepsedTime / self._replayLength * 100)
  ToClient_ReadyReplayUseTime(self._playBar:GetControlPos())
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ArshaReplayWidget_PlayReplay()
end
function ArshaReplayWidget_PlayOrPauseReplay(isHotKey)
  local self = arshaReplayWidget
  if nil ~= isHotKey then
    if true == self._playCheckBox:IsCheck() then
      self._playCheckBox:SetCheck(false)
    else
      self._playCheckBox:SetCheck(true)
    end
  end
  if true == self._playCheckBox:IsCheck() then
    ArshaReplayWidget_PlayReplay()
  else
    ArshaReplayWidget_PauseReplay()
  end
end
function ArshaReplayWidget_PlayReplay()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  ToClient_PlayReplay()
end
function ArshaReplayWidget_PauseReplay()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(false)
  ToClient_PauseReplay()
end
function ArshaReplayWidget_StopReplay()
  local self = arshaReplayWidget
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  ToClient_StopReplay()
end
function ArshaReplayWidget_LoadReplay(replayLength)
  local self = arshaReplayWidget
  local prevReplayLength = self._replayLength
  self._replayLength = Uint64toUint32(replayLength)
  if 0 == prevReplayLength then
    self._playBar:SetControlPos(0)
    self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  else
    local elepsedTimePercent = self._currentTime / Uint64toUint32(replayLength / toUint64(0, 1000)) * 100
    self._playBar:SetControlPos(elepsedTimePercent)
    self._roundTime:SetText(convertMilliSecondsToClockTime(self._currentTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  end
  if false == self._isFinishLoadReplay then
    if false == ToClient_IsProductionReplay() then
      Panel_Arsha_Replay_All:SetShow(true)
      PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
    end
    self._isFinishLoadReplay = true
  end
end
function ArshaReplayWidget_EndReplay()
  local self = arshaReplayWidget
  self._isFinishLoadReplay = false
  PaGlobalFunc_MainStatus_UpdateHP()
  PaGlobalFunc_MainStatus_UpdateMP()
  Panel_Arsha_Replay_All:SetShow(false)
  self._replayLength = 0
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  self._currentTime = 0
  ArshaReplayWidgetClearHpColorIndex()
end
function ArshaReplayWidget_SetReplayProgressBar(elepsedTimePercent)
  local self = arshaReplayWidget
  if nil == self._replayLength then
    return
  end
  local elepsedTime = math.ceil(self._replayLength * elepsedTimePercent / 100)
  self._currentTime = elepsedTime
  self._roundTime:SetText(convertMilliSecondsToClockTime(elepsedTime) .. "/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playBar:SetControlPos(elepsedTimePercent)
end
function ArshaReplayWidget_SetChangePlayButton()
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
end
function ArshaReplayWidget_OffNotReplayUI()
  if true == ToClient_IsProductionReplay() then
    return
  end
  local self = arshaReplayWidget
  PaGlobal_Prepare_Replay()
  PaGlobal_UIModify:applyDefaultSet(false, true)
  Panel_QuickSlot:SetShow(false)
  Panel_PvpMode:SetShow(false)
  Panel_Adrenallin:SetShow(false)
  Panel_MainStatus_User_Bar:SetShow(false)
  Panel_MainStatus_Remaster:SetShow(false)
  Panel_Widget_AreaOfHadum:SetShow(false)
  self._playCheckBox:SetCheck(false)
  PaGlobal_Menu_Remake:prepareClose()
  Panel_Menu_Close()
  setRenderCrossHair(false)
  SetUIMode(Defines.UIMode.eUIMode_Arsha_Replay)
  Panel_CommandGuide:SetShow(false)
  Panel_Stamina_HideAni()
  Panel_ClassResource_SetShow(false)
  Panel_Radar_NightAlert:SetShow(false)
  PaGlobalFunc_UseTab_Show(0, false)
  PaGlobalFunc_UseTab_Show(1, false)
  PaGlobalFunc_UseTab_Show(2, false)
  if true == _ContentsGroup_NewUI_Arsha_All then
    PaGlobalFunc_Arsha_Party_All_Close()
  else
    CompetitionGameTeamUI_Close()
  end
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if true == selfPlayer:isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(false)
    else
      Panel_Widget_Party:SetShow(false)
    end
  end
  PaGlobalFunc_Arsha_Hud_All_setReplayMode(true)
  if nil ~= Panel_SkillCooltime then
    Panel_SkillCooltime:SetShow(false)
  end
  Panel_CashShopAlert:ActiveMouseEventEffect(false)
  Panel_CashShopAlert:setGlassBackground(false)
  Panel_CashShopAlert:SetShow(false)
  Panel_CommonGameScreenUI:SetShow(false)
end
function ArshaReplayWidget_OnNotReplayUI()
  if true == ToClient_IsProductionReplay() then
    return
  end
  local self = arshaReplayWidget
  self._replayLength = 0
  self._roundTime:SetText("00:00:00/" .. convertMilliSecondsToClockTime(self._replayLength))
  self._playCheckBox:SetCheck(false)
  self._playBar:SetControlPos(0)
  self._currentTime = 0
  Panel_QuickSlot:SetShow(true)
  setRenderCrossHair(true)
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_ClassResource_SetShow(true)
  if true == _ContentsGroup_NewUI_Arsha_All then
    PaGlobalFunc_Arsha_Party_All_Open()
  else
    CompetitionGameTeamUI_Open()
  end
  HandleEventLUp_ApplyPresetInfo(3, false)
  local selfPlayer = getSelfPlayer()
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if true == selfPlayer:isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(true)
    else
      Panel_Widget_Party:SetShow(true)
    end
  end
  PaGlobalFunc_Arsha_Replay_Party_All_Close()
  PaGlobalFunc_Arsha_Hud_All_setReplayMode(false)
  if nil ~= Panel_SkillCooltime then
    Panel_SkillCooltime:SetShow(true)
  end
  Panel_CashShopAlert:ActiveMouseEventEffect(true)
  Panel_CashShopAlert:setGlassBackground(true)
  Panel_CashShopAlert:SetShow(false)
  Panel_CommonGameScreenUI:SetShow(true)
  PaGlobal_Menu_Remake:prepareClose()
end
function ArshaReplayWidget_SetReplayRate(replayRate)
  local self = arshaReplayWidget
  self._replayRateText:SetText("X " .. string.format("%.2f", replayRate))
end
function ArshaReplayWidget_SetHpUI(isOnUI)
end
function ArshaReplayWidget_ClearBookmark()
  local self = arshaReplayWidget
  while 0 < self._bookmarkList:length() do
    local bookmark = self._bookmarkList:pop_back()
    bookmark:SetShow(false)
    self._bookmarkPool:push_back(bookmark)
  end
  self._bookmarkTimeList = Array.new()
end
function ArshaReplayWidget_SetBookmark(bookmarkPercent)
  local self = arshaReplayWidget
  local barButtonSize = arshaReplayWidget._progressBarButton:GetSizeX()
  local startPos = self._playBar:GetPosX() + barButtonSize / 2
  local addPos = (self._playBar:GetSizeX() - barButtonSize) * bookmarkPercent
  local bookmark = ArshaReplayWidget_GetBookMark()
  bookmark:SetSize(self._bookmarkBase:GetSizeX(), self._bookmarkBase:GetSizeY())
  bookmark:SetPosX(startPos + addPos - self._bookmarkBase:GetSizeX() / 2)
  bookmark:SetShow(true)
  bookmark:addInputEvent("Mouse_LUp", "ArshaReplayWidget_PlayBookMark(" .. bookmarkPercent .. ")")
  bookmark:SetText(tostring(self._bookmarkList:length()))
  self._bookmarkTimeList:push_back(bookmarkPercent)
end
function ArshaReplayWidget_PlayBookMark(bookmarkTime)
  local self = arshaReplayWidget
  self._playCheckBox:SetCheck(true)
  ToClient_ReadyReplayUseTime(bookmarkTime)
  PaGlobalFunc_Arsha_Replay_Party_All_clearIsFinish()
  ToClient_PlayReplay()
end
function ArshaReplayWidget_PlayBookMarkHotKey(bookmarkIndex)
  local self = arshaReplayWidget
  if bookmarkIndex > self._bookmarkTimeList:length() then
    return
  end
  ArshaReplayWidget_PlayBookMark(self._bookmarkTimeList[bookmarkIndex])
end
function ArshaReplayWidget_GetBookMark()
  local self = arshaReplayWidget
  local bookmark
  if 0 < self._bookmarkPool:length() then
    bookmark = self._bookmarkPool:pop_back()
  else
    bookmark = ArshaReplayWidget_CreateNewBookmark()
  end
  self._bookmarkList:push_back(bookmark)
  return bookmark
end
function ArshaReplayWidget_CreateNewBookmark()
  local self = arshaReplayWidget
  local bookmark = UI.createControl(__ePAUIControl_StaticText, self._replayArea, "Bookmark" .. tostring(self._bookmarkCount))
  self._bookmarkCount = self._bookmarkCount + 1
  CopyBaseProperty(self._bookmarkBase, bookmark)
  bookmark:SetSize(self._bookmarkBase:GetSizeX(), self._bookmarkBase:GetSizeY())
  bookmark:SetPosX(self._bookmarkBase:GetPosX())
  bookmark:SetShow(true)
  return bookmark
end
function ArshaReplayWidget_ToggleShowReplayUI()
  if true == Panel_Arsha_Replay_All:IsShow() or false == ToClient_IsPlayingReplay() then
    Panel_Arsha_Replay_All:SetShow(false)
  else
    Panel_Arsha_Replay_All:SetShow(true)
  end
end
function ArshaReplayWidget_SetReplayState(replayState)
  local self = arshaReplayWidget
  if ReplayState_Type.STOP_RECORDING == replayState then
    self._replayState:SetText("Stop Recording")
  else
    self._replayState:SetText("Recording")
  end
end
function ArshaReplayWidgetClearHpColorIndex()
  ReplayHpIndexTable = Array.new()
  for i = 1, 5 do
    ReplayHpIndexTable[i] = 0
  end
end
function PaGlobalFunc_Arsha_Party_All_Get_Hp_Color_Index(teamNo)
  for i = 1, 5 do
    if 0 == ReplayHpIndexTable[i] or teamNo == ReplayHpIndexTable[i] then
      ReplayHpIndexTable[i] = teamNo
      return i
    end
  end
  return 5
end
function ArshaReplayWidget_EditBoxToggle()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  if true == self._camDistEditBox:GetShow() then
    ArshaReplayWidget_CloseCamDistEditBox()
  else
    ArshaReplayWidget_OpenCamDistEditBox()
  end
end
function ArshaReplayWidget_ConfirmEditBox()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  local timeString = self._camDistEditBox:GetText()
  self._camDistEditBox:SetEditText("")
  local dist = tonumber(timeString)
  ToClient_setCamDistFromCharacterForReplay(dist)
  ArshaReplayWidget_CloseCamDistEditBox()
end
function ArshaReplayWidget_SetCamDistText(camDist)
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  self._camDistText:SetText(tostring(camDist))
end
function ArshaReplayWidget_OpenCamDistEditBox()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  self._camDistText:SetShow(false)
  self._camDistEditBox:SetShow(true)
end
function ArshaReplayWidget_CloseCamDistEditBox()
  if nil == Panel_Arsha_Replay_All then
    return
  end
  if nil == arshaReplayWidget then
    return
  end
  self = arshaReplayWidget
  self._camDistText:SetShow(true)
  self._camDistEditBox:SetShow(false)
end
ArshaReplayWidget_Init()
registerEvent("FromClient_LoadReplay", "ArshaReplayWidget_LoadReplay")
registerEvent("FromClient_EndReplay", "ArshaReplayWidget_EndReplay")
registerEvent("FromClient_SetReplayProgressBar", "ArshaReplayWidget_SetReplayProgressBar")
registerEvent("FromClient_SetChangePlayButton", "ArshaReplayWidget_SetChangePlayButton")
registerEvent("FromClient_OffNotReplayUI", "ArshaReplayWidget_OffNotReplayUI")
registerEvent("FromClient_OnNotReplayUI", "ArshaReplayWidget_OnNotReplayUI")
registerEvent("FromClient_SetReplayRate", "ArshaReplayWidget_SetReplayRate")
registerEvent("FromClient_SetHpUI", "ArshaReplayWidget_SetHpUI")
registerEvent("FromClient_ClearBookmark", "ArshaReplayWidget_ClearBookmark")
registerEvent("FromClient_SetBookmark", "ArshaReplayWidget_SetBookmark")
registerEvent("FromClient_SetReplayName", "ArshaReplayWidget_SetReplayName")
registerEvent("FromClient_SetReplayState", "ArshaReplayWidget_SetReplayState")
registerEvent("FromClient_SetCamDistFromCharacter", "ArshaReplayWidget_SetCamDistText")
