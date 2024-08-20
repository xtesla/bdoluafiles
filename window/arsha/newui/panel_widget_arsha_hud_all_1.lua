function PaGlobal_Arsha_Hud_All:initialize()
  if true == PaGlobal_Arsha_Hud_All._initialize or nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  self._ui.stc_teamHud = UI.getChildControl(Panel_Widget_Arsha_Hud_All, "Static_TeamHud")
  self._ui.txt_teamTime = UI.getChildControl(self._ui.stc_teamHud, "StaticText_CenterTime")
  self._ui.txt_personalRound = UI.getChildControl(self._ui.stc_teamHud, "StaticText_Round")
  self._ui.txt_leftPoint = UI.getChildControl(self._ui.stc_teamHud, "StaticText_LeftPoint")
  self._ui.txt_rightPoint = UI.getChildControl(self._ui.stc_teamHud, "StaticText_RightPoint")
  self._ui.txt_leftTeam = UI.getChildControl(self._ui.stc_teamHud, "StaticText_LeftTeamName")
  self._ui.txt_rightTeam = UI.getChildControl(self._ui.stc_teamHud, "StaticText_RightTeamName")
  self._ui.stc_blueDotScore = UI.getChildControl(self._ui.stc_teamHud, "Static_BlueDotBG")
  self._ui.stc_redDotScore = UI.getChildControl(self._ui.stc_teamHud, "Static_RedDotBG")
  self._ui.stc_teamOneHud = UI.getChildControl(Panel_Widget_Arsha_Hud_All, "Static_TeamOneHud")
  self._ui.txt_teamOneTime = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_CenterTime")
  self._ui.txt_teamOnePersonalRound = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_Round")
  self._ui.txt_teamOnePersonalRound:SetText("1")
  self._ui.txt_teamOneLeftPoint = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_LeftPoint")
  self._ui.txt_teamOneLeftPoint:SetText("0")
  self._ui.txt_teamOneRightPoint = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_RightPoint")
  self._ui.txt_teamOneRightPoint:SetText("0")
  self._ui.txt_teamOneLeftTeamName = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_LeftTeamName")
  self._ui.txt_teamOneLeftTeamName:SetText("A")
  self._ui.txt_teamOneRightTeamName = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_RightTeamName")
  self._ui.txt_teamOneRightTeamName:SetText("B")
  self._ui.stc_teamOneBlueDotScore = UI.getChildControl(self._ui.stc_teamOneHud, "Static_BlueDotBG")
  self._ui.stc_teamOneRedDotScore = UI.getChildControl(self._ui.stc_teamOneHud, "Static_RedDotBG")
  self._ui.stc_teamOneBlueProgress = UI.getChildControl(self._ui.stc_teamOneHud, "Progress2_Blue")
  self._ui.txt_teamOneBlueHpPercent = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_Blue_HpPercent")
  self._ui.stc_teamOneRedProgress = UI.getChildControl(self._ui.stc_teamOneHud, "Progress2_Red")
  self._ui.txt_teamOneRedHpPercent = UI.getChildControl(self._ui.stc_teamOneHud, "StaticText_Red_HpPercent")
  self._ui.stc_aloneHud = UI.getChildControl(Panel_Widget_Arsha_Hud_All, "Static_AloneHud")
  self._ui.txt_aloneTime = UI.getChildControl(self._ui.stc_aloneHud, "StaticText_Time")
  self._ui.txt_lifeMember = UI.getChildControl(self._ui.stc_aloneHud, "StaticText_LifeMember")
  self._ui._scoreDot.blue[1] = self._ui.stc_blueDotScore
  self._ui._scoreDot.red[1] = self._ui.stc_redDotScore
  self._originTeamNameSpanSize = self._ui.txt_rightTeam:GetSpanSize()
  local _bluePosX = self._ui._scoreDot.blue[1]:GetPosX()
  local _redPosX = self._ui._scoreDot.red[1]:GetPosX()
  local gabX = 10
  for i = 2, self._scoreDotMaxCnt do
    self._ui._scoreDot.blue[i] = UI.cloneControl(self._ui.stc_blueDotScore, self._ui.stc_teamHud, "Static_BlueDotBG_" .. i)
    self._ui._scoreDot.blue[i]:SetPosX(_bluePosX + (i - 1) * (self._ui._scoreDot.blue[1]:GetSizeX() + gabX))
    self._ui._scoreDot.red[i] = UI.cloneControl(self._ui.stc_redDotScore, self._ui.stc_teamHud, "Static_RedDotBG" .. i)
    self._ui._scoreDot.red[i]:SetPosX(_redPosX - (i - 1) * (self._ui._scoreDot.blue[1]:GetSizeX() + gabX))
  end
  self._ui.stc_buff_list[1] = {}
  self._ui.stc_buff_list[2] = {}
  for ii = 1, self._buffMaxCount do
    self._ui.stc_buff_list[1][ii] = UI.getChildControl(self._ui.stc_teamOneHud, "Static_Red_Buff" .. ii)
    self._ui.stc_buff_list[2][ii] = UI.getChildControl(self._ui.stc_teamOneHud, "Static_Blue_Buff" .. ii)
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_Hud_All:validate()
  PaGlobal_Arsha_Hud_All:registEventHandler()
  PaGlobal_Arsha_Hud_All:swichPlatform(self._isConsole)
  PaGlobal_Arsha_Hud_All._initialize = true
  PaGlobal_Arsha_Hud_All:checkShow()
end
function PaGlobal_Arsha_Hud_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_Arsha_Hud_All:checkShow()
  if true == PaGlobal_Arsha_Hud_All:checkTeamNo() then
    return
  end
  PaGlobalFunc_Arsha_Hud_All_Open()
end
function PaGlobal_Arsha_Hud_All:prepareOpen()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  if false == PaGlobal_Arsha_Hud_All._initialize then
    return
  end
  PaGlobal_Arsha_Hud_All:update()
  PaGlobal_Arsha_Hud_All:resize()
end
function PaGlobal_Arsha_Hud_All:open()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  Panel_Widget_Arsha_Hud_All:SetShow(true)
end
function PaGlobal_Arsha_Hud_All:prepareClose()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  PaGlobal_Arsha_Hud_All:close()
end
function PaGlobal_Arsha_Hud_All:close()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  Panel_Widget_Arsha_Hud_All:SetShow(false)
end
function PaGlobal_Arsha_Hud_All:update()
  if false == ToClient_IsMyselfInArena() then
    PaGlobal_Arsha_Hud_All:close()
    return
  end
  for ii = 1, self._buffMaxCount do
    self._ui.stc_buff_list[1][ii]:SetShow(false)
    self._ui.stc_buff_list[2][ii]:SetShow(false)
  end
  local isTeam = ToClient_GetMyTeamNo()
  self._ui.txt_leftPoint:SetShow(true)
  self._ui.txt_rightPoint:SetShow(true)
  local state_match = ToClient_CompetitionMatchType()
  local state_fight = ToClient_CompetitionFightState()
  self.matchType = state_match
  if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == state_fight then
    self:changeMatchType()
    PaGlobal_Arsha_Hud_All:open()
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Done == state_fight then
    self:changeMatchType()
    PaGlobal_Arsha_Hud_All:open()
  elseif CppEnums.CompetitionFightState.eCompetitionFightState_Wait == state_fight then
    self:changeMatchType()
    PaGlobal_Arsha_Hud_All:open()
  else
    if true == ToClient_IsMyselfInArena() then
      PaGlobal_Arsha_Hud_All:open()
    else
      PaGlobal_Arsha_Hud_All:close()
    end
    self:changeMatchType()
  end
  PaGlobal_Arsha_Hud_All:setTeamInfo()
  local option = getArshaPvpOption()
  local time = convertSecondsToClockTime(ToClient_CompetitionMatchTimeLimit())
  self._ui.txt_teamTime:SetText(time)
  self._ui.txt_aloneTime:SetText(time)
end
function PaGlobal_Arsha_Hud_All:updateTimerWidget()
  local updateTimer = function(control)
    local warTime = ToClient_CompetitionRemainMatchTime()
    if warTime > 0 then
      control:SetText(convertSecondsToClockTime(warTime))
    else
      control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
    end
  end
  if self.matchType == CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round then
    updateTimer(self._ui.txt_teamTime)
  elseif self.matchType == CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll then
    updateTimer(self._ui.txt_aloneTime)
  elseif self.matchType == CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal then
    updateTimer(self._ui.txt_teamTime)
  end
  Panel_Widget_Arsha_Hud_All:ComputePos()
end
function PaGlobal_Arsha_Hud_All:setTimeForReplay(currentTime)
  if false == ToClient_IsMyselfInArena() then
    PaGlobal_Arsha_Hud_All:close()
    return
  end
  local time = convertSecondsToClockTime(currentTime)
  self._ui.txt_teamTime:SetText(time)
  self._ui.txt_aloneTime:SetText(time)
  self._ui.txt_teamOneTime:SetText(time)
end
function PaGlobal_Arsha_Hud_All:setScoreForReplay(teamNum, scoreValue)
  if false == ToClient_IsMyselfInArena() then
    PaGlobal_Arsha_Hud_All:close()
    return
  end
  if 0 == teamNum then
    self._ui.txt_leftPoint:SetText(scoreValue)
    self._ui.txt_teamOneLeftPoint:SetText(scoreValue)
  else
    self._ui.txt_rightPoint:SetText(scoreValue)
    self._ui.txt_teamOneRightPoint:SetText(scoreValue)
  end
end
function PaGlobal_Arsha_Hud_All:checkTeamNo()
  if -2 == ToClient_GetMyTeamNo() then
    PaGlobalFunc_Arsha_Hud_All_Hide()
    return true
  end
  return false
end
function PaGlobal_Arsha_Hud_All:changeMatchType()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  self._ui.stc_teamHud:SetShow(false)
  self._ui.stc_aloneHud:SetShow(false)
  self._ui.stc_teamOneHud:SetShow(false)
  local state_match = ToClient_CompetitionMatchType()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == state_match then
    self._ui.stc_teamHud:SetShow(true)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == state_match then
    self._ui.stc_aloneHud:SetShow(true)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == state_match then
    local isReplayMode = ToClient_IsPlayingReplay()
    if true == isReplayMode then
      self._ui.stc_teamOneHud:SetShow(true)
    else
      self._ui.stc_teamHud:SetShow(true)
    end
  end
end
function PaGlobal_Arsha_Hud_All:setTeamInfo()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  local team = ""
  local teamA = 0
  local teamB = 0
  local teamA_Info, teamB_Info
  local teamA_Name = ""
  local teamB_Name = ""
  self:changeMatchType()
  teamA = ToClient_GetRoundTeamScore(1)
  teamB = ToClient_GetRoundTeamScore(2)
  local state_match = ToClient_CompetitionMatchType()
  local state_fight = ToClient_CompetitionFightState()
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == state_match then
    teamA_Info = ToClient_GetTeamListAt(0)
    teamB_Info = ToClient_GetTeamListAt(1)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == state_match then
    teamA_Info = ToClient_GetArshaTeamInfo(1)
    teamB_Info = ToClient_GetArshaTeamInfo(2)
  end
  if nil ~= teamA_Info and nil ~= teamB_Info then
    teamA_Name = teamA_Info:getTeamName()
    teamB_Name = teamB_Info:getTeamName()
  end
  if "" == teamA_Name or "" == teamB_Name then
    teamA_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_A")
    teamB_Name = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_TEAM_B")
  end
  self._ui.txt_leftPoint:SetShow(true)
  self._ui.txt_rightPoint:SetShow(true)
  self._ui.txt_personalRound:SetShow(false)
  if CppEnums.CompetitionMatchType.eCompetitionMatchMode_Round == state_match then
    self._ui.txt_leftTeam:SetText(teamA_Name)
    self._ui.txt_rightTeam:SetText(teamB_Name)
    self._ui.txt_leftPoint:SetText(teamA)
    self._ui.txt_rightPoint:SetText(teamB)
    local targetScore = ToClient_GetTargetScore()
    PaGlobal_Arsha_Hud_All:showTargetScoreDot(targetScore, teamA, teamB)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_FreeForAll == state_match then
    self._ui.txt_leftPoint:SetShow(false)
    self._ui.txt_rightPoint:SetShow(false)
    local targetScore = ToClient_GetTargetScore()
    self._ui.txt_lifeMember:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_ARSHA_HUD_LIFEMEMBER", "targetScore", targetScore))
    PaGlobal_Arsha_Hud_All:showTargetScoreDot(nil)
  elseif CppEnums.CompetitionMatchType.eCompetitionMatchMode_Personal == state_match then
    self._ui.txt_leftTeam:SetText(teamA_Name)
    self._ui.txt_rightTeam:SetText(teamB_Name)
    if CppEnums.CompetitionFightState.eCompetitionFightState_Done == state_fight then
      self._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
      self._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
    else
      local isReplayMode = ToClient_IsPlayingReplay()
      if true == isReplayMode then
        if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == state_fight then
          self._ui.txt_leftPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", 1))
          self._ui.txt_rightPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", 1))
        else
          self._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
          self._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
        end
      elseif nil ~= teamA_Info and nil ~= teamB_Info then
        local teamAAliveCount = teamA_Info:getAliveAttendCount()
        local teamBAliveCount = teamB_Info:getAliveAttendCount()
        self._ui.txt_leftPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", teamAAliveCount))
        self._ui.txt_rightPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", teamBAliveCount))
      else
        self._ui.txt_leftPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
        self._ui.txt_rightPoint:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING"))
      end
    end
    local currentRound = ToClient_GetCurrentRound()
    if currentRound <= 0 then
      currentRound = 1
    end
    self._ui.txt_personalRound:SetShow(true)
    self._ui.txt_personalRound:SetText(tostring(currentRound))
    PaGlobal_Arsha_Hud_All:showTargetScoreDot(nil)
  end
  PaGlobal_Arsha_Hud_All:alignTeamName()
end
function PaGlobal_Arsha_Hud_All:showTargetScoreDot(targetScore, teamAScore, teamBScore)
  for ii = 1, self._scoreDotMaxCnt do
    self._ui._scoreDot.blue[ii]:SetShow(false)
    self._ui._scoreDot.red[ii]:SetShow(false)
    local blueIcon = UI.getChildControl(self._ui._scoreDot.blue[ii], "Static_Icon")
    blueIcon:SetShow(false)
    local redIcon = UI.getChildControl(self._ui._scoreDot.red[ii], "Static_Icon")
    redIcon:SetShow(false)
  end
  if nil == targetScore or targetScore <= 1 then
    return
  end
  for ii = 1, targetScore do
    if nil == self._ui._scoreDot.blue[ii] then
    end
    if nil == self._ui._scoreDot.red[ii] then
    end
    self._ui._scoreDot.blue[ii]:SetShow(true)
    self._ui._scoreDot.red[ii]:SetShow(true)
    if ii <= teamBScore then
      local blueIcon = UI.getChildControl(self._ui._scoreDot.blue[ii], "Static_Icon")
      blueIcon:SetShow(true)
    end
    if ii <= teamAScore then
      local redIcon = UI.getChildControl(self._ui._scoreDot.red[ii], "Static_Icon")
      redIcon:SetShow(true)
    end
  end
end
function PaGlobal_Arsha_Hud_All:alignTeamName()
  local maxLength = math.max(self._ui.txt_leftPoint:GetTextSizeX(), self._ui.txt_rightPoint:GetTextSizeX()) + 5
  local spanSizeX = math.max(self._originTeamNameSpanSize.x, self._ui.txt_rightPoint:GetSpanSize().x + maxLength)
  self._ui.txt_leftTeam:SetSpanSize(-spanSizeX * 1.3, self._originTeamNameSpanSize.y)
  self._ui.txt_rightTeam:SetSpanSize(spanSizeX * 1.3, self._originTeamNameSpanSize.y)
end
function PaGlobal_Arsha_Hud_All:setReplayMode(isReplayMode)
  if false == ToClient_IsMyselfInArena() then
    PaGlobal_Arsha_Hud_All:close()
    return
  end
  if true == isReplayMode then
    self._ui.stc_teamHud:SetShow(false)
    self._ui.stc_teamOneHud:SetShow(true)
  else
    self._ui.stc_teamHud:SetShow(true)
    self._ui.stc_teamOneHud:SetShow(false)
  end
end
function PaGlobal_Arsha_Hud_All:settingPersonalForReplay(teamNo, actorKey)
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  if nil ~= playerActorProxyWrapper then
    self._ui.txt_teamOnePersonalRound:SetShow(true)
    self._ui.txt_teamOnePersonalRound:SetText("1")
    local userLevel = playerActorProxyWrapper:get():getLevel()
    local userName = playerActorProxyWrapper:getUserNickname()
    if 0 == ToClient_getChatNameType() then
      userName = playerActorProxyWrapper:getName()
    else
      userName = playerActorProxyWrapper:getUserNickname()
    end
    local hpPercent = 100
    local strHpPercent = string.format("%.2f", hpPercent) .. "%"
    if 1 == teamNo then
      self._ui.txt_teamOneLeftPoint:SetShow(true)
      self._ui.txt_teamOneLeftPoint:SetText("0")
      self._ui.txt_teamOneLeftTeamName:SetShow(true)
      self._ui.txt_teamOneLeftTeamName:SetText(userName)
      self._ui.stc_teamOneRedProgress:SetShow(true)
      self._ui.stc_teamOneRedProgress:SetProgressRate(hpPercent)
      self._ui.txt_teamOneRedHpPercent:SetShow(true)
      self._ui.txt_teamOneRedHpPercent:SetText(strHpPercent)
    elseif 2 == teamNo then
      self._ui.txt_teamOneRightPoint:SetShow(true)
      self._ui.txt_teamOneRightPoint:SetText("0")
      self._ui.txt_teamOneRightTeamName:SetShow(true)
      self._ui.txt_teamOneRightTeamName:SetText(userName)
      self._ui.stc_teamOneBlueProgress:SetShow(true)
      self._ui.stc_teamOneBlueProgress:SetProgressRate(hpPercent)
      self._ui.txt_teamOneBlueHpPercent:SetShow(true)
      self._ui.txt_teamOneBlueHpPercent:SetText(strHpPercent)
    end
  end
end
function PaGlobal_Arsha_Hud_All:updateUserHp_PersonalForReplay(teamNo, actorKey)
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  if nil ~= playerActorProxyWrapper then
    local getHP = playerActorProxyWrapper:get():getHp()
    local getMaxHP = playerActorProxyWrapper:get():getMaxHp()
    local strHpPercent
    if getHP > 0 and getMaxHP > 0 then
      hpPercent = getHP / getMaxHP * 100
      strHpPercent = string.format("%.2f", hpPercent) .. "%"
    end
    if 0 == getHP then
      hpPercent = 0
      strHpPercent = "0%"
    end
    if 1 == teamNo then
      self._ui.stc_teamOneRedProgress:SetProgressRate(hpPercent)
      self._ui.txt_teamOneRedHpPercent:SetText(strHpPercent)
      if 0 >= hpPercent then
        self._ui.txt_teamOneLeftTeamName:SetFontColor(Defines.Color.C_FFC4BEBE)
      else
        self._ui.txt_teamOneLeftTeamName:SetFontColor(Defines.Color.C_FFFFEDD4)
      end
    elseif 2 == teamNo then
      self._ui.stc_teamOneBlueProgress:SetProgressRate(hpPercent)
      self._ui.txt_teamOneBlueHpPercent:SetText(strHpPercent)
      if 0 >= hpPercent then
        self._ui.txt_teamOneRightTeamName:SetFontColor(Defines.Color.C_FFC4BEBE)
      else
        self._ui.txt_teamOneRightTeamName:SetFontColor(Defines.Color.C_FFFFEDD4)
      end
    end
  end
end
function PaGlobal_Arsha_Hud_All:setShowBuffForPersonal(isShow, teamNo, buffIndex, iconPath)
  if nil == self._ui.stc_buff_list[teamNo][buffIndex] then
    return
  end
  if false == isShow then
    self._ui.stc_buff_list[teamNo][buffIndex]:SetShow(false)
    return
  end
  self._ui.stc_buff_list[teamNo][buffIndex]:ChangeTextureInfoName(iconPath)
  self._ui.stc_buff_list[teamNo][buffIndex]:SetShow(true)
end
function PaGlobal_Arsha_Hud_All:registEventHandler()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Arsha_Hud_All_OnScreenResize")
  registerEvent("FromClient_UpdateFightState", "FromClient_Arsha_Hud_All_UpdateFightState")
  registerEvent("FromClient_UpdateTeamScore", "FromClient_Arsha_Hud_All_UpdateTeamScore")
  registerEvent("FromClient_UpdatePersonalMatchAliveAttendCount", "FromClient_Arsha_Hud_All_UpdatePersonalMatchAliveAttendCount")
  registerEvent("FromClient_FirstMatchStart", "FromClient_Arsha_Hud_All_ScoreReset")
  registerEvent("FromClient_WaitTimeAlert", "FromClient_Arsha_Hud_All_WaitTimeAlert")
  registerEvent("FromClient_ArshaTeamMasterOut", "FromClient_Arsha_Hud_All_TeamMasterOut")
  registerEvent("FromClient_ArshaDebuff", "FromClient_Arsha_Hud_All_Debuff")
  registerEvent("FromClient_ArshaPersonalMatchDebuff", "FromClient_Arsha_Hud_All_PersonalMatchDebuff")
  registerEvent("FromClient_ReplayArshaLimitTime", "FromClient_ReplayArshaLimitTime")
  registerEvent("FromClient_UpdateTeamScoreForReplay", "FromClient_Arsha_Hud_All_UpdateTeamScoreForReplay")
  Panel_Widget_Arsha_Hud_All:RegisterUpdateFunc("PaGlobalFunc_Arsha_Hud_All_UpdateFrame")
end
function PaGlobal_Arsha_Hud_All:validate()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
  self._ui.stc_teamHud:isValidate()
  self._ui.txt_teamTime:isValidate()
  self._ui.txt_personalRound:isValidate()
  self._ui.txt_leftPoint:isValidate()
  self._ui.txt_rightPoint:isValidate()
  self._ui.txt_leftTeam:isValidate()
  self._ui.txt_rightTeam:isValidate()
  self._ui.stc_blueDotScore:isValidate()
  self._ui.stc_redDotScore:isValidate()
  self._ui.stc_aloneHud:isValidate()
  self._ui.txt_aloneTime:isValidate()
  self._ui.txt_lifeMember:isValidate()
  self._ui.stc_teamOneHud:isValidate()
  self._ui.txt_teamOneTime:isValidate()
  self._ui.txt_teamOnePersonalRound:isValidate()
  self._ui.txt_teamOneLeftPoint:isValidate()
  self._ui.txt_teamOneRightPoint:isValidate()
  self._ui.txt_teamOneLeftTeamName:isValidate()
  self._ui.txt_teamOneRightTeamName:isValidate()
  self._ui.stc_teamOneBlueDotScore:isValidate()
  self._ui.stc_teamOneRedDotScore:isValidate()
  self._ui.stc_teamOneBlueProgress:isValidate()
  self._ui.txt_teamOneBlueHpPercent:isValidate()
  self._ui.stc_teamOneRedProgress:isValidate()
  self._ui.txt_teamOneRedHpPercent:isValidate()
  for ii = 1, self._buffMaxCount do
    self._ui.stc_buff_list[1][ii]:isValidate()
    self._ui.stc_buff_list[2][ii]:isValidate()
  end
end
function PaGlobal_Arsha_Hud_All:resize()
  if nil == Panel_Widget_Arsha_Hud_All then
    return
  end
end
