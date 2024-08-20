local raceContentsEnable = ToClient_IsContentsGroupOpen("41")
local millitiaContentsEnable = ToClient_IsContentsGroupOpen("245")
local voiceChatContentsEnable = ToClient_IsContentsGroupOpen("75")
local millitiaContentsOpenEnable = false
local seasonContentsEnable = ToClient_IsContentsGroupOpen("1431")
local seasonRewardEffectNo, BlackSpiritPassEffectNo1, BlackSpiritPassEffectNo2, GrowthPassEffectNo
Widget_Function_Type = {
  FindNPC = 0,
  MovieToolTip = 1,
  SetVoice = 2,
  SiegeArea = 3,
  HorseRace = 4,
  Militia = 5,
  BusterCall = 6,
  SiegeWarCall = 7,
  PartySummon = 8,
  ReturnTown = 9,
  SummonElephant = 10,
  NationWar = 11,
  BattleRoyal = 12,
  Report = 13,
  OnAir = 14,
  BlackSpiritPass = 15,
  SiegeWarReturn = 16,
  TransferAccount = 17,
  TerritoryPoint = 18,
  GMQuizEvent = 19,
  GrowthPass = 20,
  Count = 21
}
local Panel_Widget_FunctionButton_info = {
  _pos = {buttonSpaceX = 8, buttonSizeX = 0},
  _button = {
    [Widget_Function_Type.FindNPC] = nil,
    [Widget_Function_Type.MovieToolTip] = nil,
    [Widget_Function_Type.SetVoice] = nil,
    [Widget_Function_Type.SiegeArea] = nil,
    [Widget_Function_Type.HorseRace] = nil,
    [Widget_Function_Type.Militia] = nil,
    [Widget_Function_Type.BusterCall] = nil,
    [Widget_Function_Type.SiegeWarCall] = nil,
    [Widget_Function_Type.PartySummon] = nil,
    [Widget_Function_Type.ReturnTown] = nil,
    [Widget_Function_Type.SummonElephant] = nil,
    [Widget_Function_Type.NationWar] = nil,
    [Widget_Function_Type.BattleRoyal] = nil,
    [Widget_Function_Type.Report] = nil,
    [Widget_Function_Type.OnAir] = nil,
    [Widget_Function_Type.BlackSpiritPass] = nil,
    [Widget_Function_Type.SiegeWarReturn] = nil,
    [Widget_Function_Type.TransferAccount] = nil,
    [Widget_Function_Type.TerritoryPoint] = nil,
    [Widget_Function_Type.GMQuizEvent] = nil,
    [Widget_Function_Type.GrowthPass] = nil
  },
  _buttonShow = {
    [Widget_Function_Type.FindNPC] = false,
    [Widget_Function_Type.MovieToolTip] = false,
    [Widget_Function_Type.SetVoice] = false,
    [Widget_Function_Type.SiegeArea] = false,
    [Widget_Function_Type.HorseRace] = false,
    [Widget_Function_Type.Militia] = false,
    [Widget_Function_Type.BusterCall] = false,
    [Widget_Function_Type.SiegeWarCall] = false,
    [Widget_Function_Type.PartySummon] = false,
    [Widget_Function_Type.ReturnTown] = false,
    [Widget_Function_Type.SummonElephant] = false,
    [Widget_Function_Type.NationWar] = false,
    [Widget_Function_Type.BattleRoyal] = false,
    [Widget_Function_Type.Report] = false,
    [Widget_Function_Type.OnAir] = false,
    [Widget_Function_Type.BlackSpiritPass] = false,
    [Widget_Function_Type.SiegeWarReturn] = false,
    [Widget_Function_Type.TransferAccount] = false,
    [Widget_Function_Type.TerritoryPoint] = false,
    [Widget_Function_Type.GMQuizEvent] = nil,
    [Widget_Function_Type.GrowthPass] = nil
  },
  _banner = {
    [Widget_Function_Type.TransferAccount] = nil
  },
  _isLeftTime = {
    [Widget_Function_Type.BusterCall] = false,
    [Widget_Function_Type.SiegeWarCall] = false,
    [Widget_Function_Type.PartySummon] = false,
    [Widget_Function_Type.ReturnTown] = false,
    [Widget_Function_Type.SiegeWarReturn] = false,
    [Widget_Function_Type.GMQuizEvent] = nil
  },
  _tooltip = {
    _name = {
      [Widget_Function_Type.BusterCall] = "",
      [Widget_Function_Type.SiegeWarCall] = "",
      [Widget_Function_Type.PartySummon] = "",
      [Widget_Function_Type.ReturnTown] = "",
      [Widget_Function_Type.SummonElephant] = "",
      [Widget_Function_Type.BattleRoyal] = "",
      [Widget_Function_Type.Report] = "",
      [Widget_Function_Type.SiegeWarReturn] = "",
      [Widget_Function_Type.TransferAccount] = "",
      [Widget_Function_Type.TerritoryPoint] = "",
      [Widget_Function_Type.GMQuizEvent] = nil
    },
    _desc = {
      [Widget_Function_Type.BusterCall] = "",
      [Widget_Function_Type.SiegeWarCall] = "",
      [Widget_Function_Type.PartySummon] = "",
      [Widget_Function_Type.ReturnTown] = "",
      [Widget_Function_Type.SummonElephant] = "",
      [Widget_Function_Type.BattleRoyal] = "",
      [Widget_Function_Type.Report] = "",
      [Widget_Function_Type.SiegeWarReturn] = "",
      [Widget_Function_Type.TransferAccount] = "",
      [Widget_Function_Type.TerritoryPoint] = "",
      [Widget_Function_Type.GMQuizEvent] = nil
    }
  },
  _battleRoyalIsOpen = false,
  _returnTownTimerKey = nil,
  _busterCallTimerKey = nil,
  _siegeWarCallTimerKey = nil,
  _partySummonTimerKey = nil,
  _isSeasonCharacter = false,
  _siegeWarReturnTimerKey = nil,
  _gmQuizTimerKey = nil
}
local elephantActorKey
local ToggleSiege = false
function Panel_Widget_FunctionButton_info:registEventHandler()
  for index = 0, Widget_Function_Type.Count - 1 do
    self._button[index]:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_FunctionButton_HandleOver(" .. index .. ")")
    self._button[index]:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_FunctionButton_HandleOut(" .. index .. ")")
    self._button[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_FunctionButton_HandleLClick(" .. index .. ")")
    self._button[index]:addInputEvent("Mouse_RUp", "PaGlobalFunc_Widget_FunctionButton_HandleRClick(" .. index .. ")")
  end
  self._button[Widget_Function_Type.FindNPC]:setButtonShortcuts("PANEL_SIMPLESHORTCUT_FIND_NPC")
  if true == _ContentsGroup_NegativeUserReport then
    self._button[Widget_Function_Type.Report]:setButtonShortcuts("PANEL_REPORT_BUTTON")
  end
end
function Panel_Widget_FunctionButton_info:registerMessageHandler()
  registerEvent("FromClient_ResponseBustCall", "FromClient_Widget_FunctionButton_ResponseBustCall")
  registerEvent("FromClient_ResponseTeleportToSiegeTent", "FromClient_Widget_FunctionButton_ResponseTeleportToSiegeTent")
  registerEvent("FromClient_ResponseTeleportFromSiegeTent", "FromClient_Widget_FunctionButton_ResponseTeleportFromSiegeTent")
  registerEvent("FromClient_BattleRoyaleIsOpen", "FromClient_Widget_FunctionButton_BattleRoyale_IsOpen")
  registerEvent("FromClient_ResponseUseCompass", "FromClient_Widget_FunctionButton_ResponseUseCompass")
  registerEvent("FromClient_ResponseUseReturnStone", "FromClient_Widget_FunctionButton_ResponseUseReturnStone")
  registerEvent("FromClient_ShowElephantBarn", "FromClient_ShowElephantBarn")
  registerEvent("FromClient_HideElephantBarn", "FromClient_HideElephantBarn")
  registerEvent("FromClient_OnAir", "FromClient_FunctionButton_OnAir")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_CheckBlackSpiritEffect")
  registerEvent("onScreenResize", "FromClient_Widget_FunctionButton_Resize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_Widget_FunctionButton_Resize")
  registerEvent("FromClient_GraduateSeason", "FromClient_GraduateSeason")
  registerEvent("FromClient_GuildPolicyEffectOn", "FromClient_GuildPolicyEffectOn")
  registerEvent("FromClient_Response_QuizGameStateAck", "FromClient_Response_QuizGameStateAck_BustCall")
  registerEvent("FromClient_notifyUpdateGrowthPassQuest", "FromCLient_PlayGrowthPassRewardEffect")
  registerEvent("FromClient_ClearGrowthPassQuest", "FromClient_CheckGrowthPassEffect")
  registerEvent("FromClient_GetGrowthPassCategoryTotalRewardItem", "FromClient_CheckGrowthPassEffect")
end
function Panel_Widget_FunctionButton_info:initialize()
  self:childControl()
  self:initValue()
  self:registerMessageHandler()
  self:registEventHandler()
  FromClient_CheckGrowthPassEffect()
end
function Panel_Widget_FunctionButton_info:initValue()
  millitiaContentsOpenEnable = ToClient_IsGrowStepOpen(__eGrowStep_militia)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    self._buttonShow[Widget_Function_Type.OnAir] = temporaryWrapper:isOnAir()
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._isSeasonCharacter = selfPlayer:get():isSeasonCharacter()
  end
end
function Panel_Widget_FunctionButton_info:unRenderPanel()
  if nil == Panel_Widget_Function then
    _PA_ASSERT_NAME(false, "Panel_MainQuest\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\234\185\128\234\183\188\236\154\176")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing)
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_Widget_Function:SetRenderAndEventHide(true)
  else
    Panel_Widget_Function:SetRenderAndEventHide(false)
  end
end
function Panel_Widget_FunctionButton_info:resize()
  local SizeX = Panel_Widget_Function:GetSizeX()
  local RadarPosX = FGlobal_Panel_Radar_GetPosX()
  local screenSizeY = getScreenSizeY()
  local screenSizeX = getScreenSizeX()
  Panel_Widget_Function:SetPosX(RadarPosX - SizeX)
  Panel_Widget_Function:SetPosY(0)
end
function Panel_Widget_FunctionButton_info:childControl()
  self._button[Widget_Function_Type.FindNPC] = UI.getChildControl(Panel_Widget_Function, "Button_FindNavi")
  self._button[Widget_Function_Type.MovieToolTip] = UI.getChildControl(Panel_Widget_Function, "Button_MovieTooltip")
  self._button[Widget_Function_Type.SetVoice] = UI.getChildControl(Panel_Widget_Function, "Button_SetState")
  self._button[Widget_Function_Type.SiegeArea] = UI.getChildControl(Panel_Widget_Function, "Button_VillageSiegeArea")
  self._button[Widget_Function_Type.HorseRace] = UI.getChildControl(Panel_Widget_Function, "Button_HorseRace")
  self._button[Widget_Function_Type.Militia] = UI.getChildControl(Panel_Widget_Function, "Button_Militia")
  self._button[Widget_Function_Type.BusterCall] = UI.getChildControl(Panel_Widget_Function, "Button_BusterCall")
  self._button[Widget_Function_Type.SiegeWarCall] = UI.getChildControl(Panel_Widget_Function, "Button_SiegeWarCall")
  self._button[Widget_Function_Type.PartySummon] = UI.getChildControl(Panel_Widget_Function, "Button_PartySummon")
  self._button[Widget_Function_Type.ReturnTown] = UI.getChildControl(Panel_Widget_Function, "Button_ReturnTown")
  self._button[Widget_Function_Type.SummonElephant] = UI.getChildControl(Panel_Widget_Function, "Button_SummonElephant")
  self._button[Widget_Function_Type.NationWar] = UI.getChildControl(Panel_Widget_Function, "Button_NationWar")
  self._button[Widget_Function_Type.BattleRoyal] = UI.getChildControl(Panel_Widget_Function, "Button_BattleRoyal")
  self._button[Widget_Function_Type.Report] = UI.getChildControl(Panel_Widget_Function, "Button_Report")
  self._button[Widget_Function_Type.OnAir] = UI.getChildControl(Panel_Widget_Function, "Button_OnAir")
  self._button[Widget_Function_Type.BlackSpiritPass] = UI.getChildControl(Panel_Widget_Function, "Button_BlackSpiritPass")
  self._button[Widget_Function_Type.SiegeWarReturn] = UI.getChildControl(Panel_Widget_Function, "Button_SiegeWarReturn")
  self._button[Widget_Function_Type.TransferAccount] = UI.getChildControl(Panel_Widget_Function, "Button_NAtransfer")
  self._button[Widget_Function_Type.TerritoryPoint] = UI.getChildControl(Panel_Widget_Function, "Button_TerritoryPoints")
  self._button[Widget_Function_Type.GMQuizEvent] = UI.getChildControl(Panel_Widget_Function, "Button_GMEvent")
  self._button[Widget_Function_Type.GrowthPass] = UI.getChildControl(Panel_Widget_Function, "Button_GrowthPass")
  self._pos.buttonSizeX = self._button[Widget_Function_Type.FindNPC]:GetSizeX()
  self._banner[Widget_Function_Type.TransferAccount] = UI.getChildControl(Panel_Widget_Function, "Static_NAtransferBanner")
end
function Panel_Widget_FunctionButton_info:updateAllButton()
  for index = 0, Widget_Function_Type.Count - 1 do
    self:checkButton(index)
  end
  local spanPosX = 0
  for index = 0, Widget_Function_Type.Count - 1 do
    if nil ~= self._buttonShow[index] then
      self._button[index]:SetShow(self._buttonShow[index])
      if true == self._buttonShow[index] then
        self._button[index]:SetSpanSize(spanPosX, 0)
        spanPosX = spanPosX + 40
        self:updateButton(index)
      end
    end
  end
end
function Panel_Widget_FunctionButton_info:updateAllButtonPos()
  local basePosXRight = Panel_Widget_Function:GetSizeX() - self._pos.buttonSizeX - self._pos.buttonSpaceX
  for index = 0, Widget_Function_Type.Count - 1 do
    if nil ~= self._buttonShow[index] and true == self._buttonShow[index] then
      self._button[index]:SetPosX(basePosXRight)
      basePosXRight = basePosXRight - self._pos.buttonSizeX - self._pos.buttonSpaceX
    end
  end
end
function Panel_Widget_FunctionButton_info:checkButton(functionType)
  local eCountryType = CppEnums.CountryType
  if functionType == Widget_Function_Type.FindNPC then
    self._buttonShow[functionType] = true
  elseif functionType == Widget_Function_Type.MovieToolTip then
    self._buttonShow[functionType] = false == isGameTypeKR2()
  elseif functionType == Widget_Function_Type.SetVoice then
    self._buttonShow[functionType] = voiceChatContentsEnable
  elseif functionType == Widget_Function_Type.SiegeArea then
    self._buttonShow[functionType] = true
  elseif functionType == Widget_Function_Type.HorseRace then
    if true == _ContentsGroup_InstanceHorseRacing then
      self._buttonShow[functionType] = _ContentsGroup_InstanceHorseRacing
    else
      self._buttonShow[functionType] = raceContentsEnable
    end
  elseif functionType == Widget_Function_Type.Militia then
    self._buttonShow[functionType] = true == millitiaContentsOpenEnable and true == millitiaContentsEnable
  elseif functionType == Widget_Function_Type.BusterCall then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.SiegeWarCall then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.PartySummon then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.ReturnTown then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.SummonElephant then
    self._buttonShow[functionType] = nil ~= elephantActorKey
  elseif functionType == Widget_Function_Type.NationWar then
    self._buttonShow[functionType] = _ContentsGroup_NationSiege
  elseif functionType == Widget_Function_Type.BattleRoyal then
    self._buttonShow[functionType] = self._battleRoyalIsOpen
  elseif functionType == Widget_Function_Type.Report then
    local gameServiceType = getGameServiceType()
    self._buttonShow[functionType] = false
  elseif functionType == Widget_Function_Type.BlackSpiritPass then
    self._buttonShow[functionType] = true == seasonContentsEnable and true == self._isSeasonCharacter
  elseif functionType == Widget_Function_Type.SiegeWarReturn then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.TransferAccount then
    self._buttonShow[functionType] = _ContentsGroup_TransferEventBuff
  elseif functionType == Widget_Function_Type.TerritoryPoint then
    self._buttonShow[functionType] = _ContentsGroup_GuildPoint
  elseif functionType == Widget_Function_Type.GMQuizEvent then
    self._buttonShow[functionType] = self._isLeftTime[functionType]
  elseif functionType == Widget_Function_Type.GrowthPass then
    self._buttonShow[functionType] = true == _ContentsGroup_GrowthPass and false == self._isSeasonCharacter
  end
end
function Panel_Widget_FunctionButton_info:updateButton(functionType)
  if functionType == Widget_Function_Type.FindNPC then
  elseif functionType == Widget_Function_Type.MovieToolTip then
  elseif functionType == Widget_Function_Type.SetVoice then
    local isMicOn = ToClient_isVoiceChatMic()
    local isHeadphoneOn = ToClient_isVoiceChatListen()
    local voiceControl = self._button[functionType]
    local mic = UI.getChildControl(voiceControl, "Static_Mic")
    local headphone = UI.getChildControl(voiceControl, "Static_Headphone")
    if nil ~= mic and nil ~= headphone then
      if isMicOn then
        mic:SetShow(true)
      else
        mic:SetShow(false)
      end
      if isHeadphoneOn then
        headphone:SetShow(true)
      else
        headphone:SetShow(false)
      end
    end
  elseif functionType == Widget_Function_Type.SiegeArea then
  elseif functionType == Widget_Function_Type.HorseRace then
  elseif functionType == Widget_Function_Type.Militia then
  elseif functionType == Widget_Function_Type.BusterCall then
  elseif functionType == Widget_Function_Type.SiegeWarCall then
  elseif functionType == Widget_Function_Type.PartySummon then
  elseif functionType == Widget_Function_Type.ReturnTown then
  elseif functionType == Widget_Function_Type.SummonElephant then
  elseif functionType == Widget_Function_Type.BlackSpiritPass then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local level = selfPlayer:get():getLevel()
      if level <= 50 then
        if nil == BlackSpiritPassEffectNo1 then
          BlackSpiritPassEffectNo1 = self._button[functionType]:AddEffect("fUI_BlackSpirit_Pass_Icon_Cast_02A", true, 0, 0)
        end
        if nil == BlackSpiritPassEffectNo2 then
          BlackSpiritPassEffectNo2 = self._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_02A", true, 0, 0)
        end
      elseif true == PaGlobal_BlackspiritPass_IsThereAnyReward() then
        if nil == seasonRewardEffectNo then
          seasonRewardEffectNo = self._button[functionType]:AddEffect("fUI_BlackSpirit_Pass_Icon_01A", true, 0, 0)
        end
      elseif nil ~= seasonRewardEffectNo then
        self._button[functionType]:EraseEffect(seasonRewardEffectNo)
        seasonRewardEffectNo = nil
      end
    end
  elseif functionType == Widget_Function_Type.SiegeWarReturn then
  elseif functionType == Widget_Function_Type.TransferAccount then
  elseif functionType == Widget_Function_Type.TerritoryPoint then
  end
end
function Panel_Widget_FunctionButton_info:handleLClick(functionType)
  if functionType == Widget_Function_Type.FindNPC then
    if _ContentsGroup_NewUI_NpcNavi_All then
      PaGlobal_NpcNavi_All_ShowToggle()
    else
      NpcNavi_ShowToggle()
    end
  elseif functionType == Widget_Function_Type.MovieToolTip then
    PaGlobal_MovieGuide_Web:Open()
  elseif functionType == Widget_Function_Type.SetVoice then
    if true == _ContentsGroup_NewUI_SetVoiceChat_All then
      PaGlobalFunc_SetVoiceChat_All_Toggle()
    else
      FGlobal_SetVoiceChat_Toggle()
    end
  elseif functionType == Widget_Function_Type.SiegeArea then
    ToggleSiege = not ToggleSiege
    ToClient_toggleVillageSiegeArea(ToggleSiege)
    self._button[functionType]:EraseAllEffect()
    if ToggleSiege then
      self._button[functionType]:AddEffect("UI_VillageSiegeArea_01A", true, 0, 0)
    end
  elseif functionType == Widget_Function_Type.HorseRace then
    if true == _ContentsGroup_InstanceHorseRacing then
      HandleEventLUp_HorseRacingEnter_Toggle()
    else
      PaGlobalFunc_RaceInfo_Toggle()
    end
  elseif functionType == Widget_Function_Type.Militia then
    FGlobal_MercenaryOpen()
  elseif functionType == Widget_Function_Type.BusterCall then
    ToClient_RequestTeleportGuildBustCall()
  elseif functionType == Widget_Function_Type.SiegeWarCall then
    ToClient_RequestTeleportToSiegeTentCall()
  elseif functionType == Widget_Function_Type.PartySummon then
    local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
    local playerActorKey = getSelfPlayer():getActorKey()
    if partyActorKey == playerActorKey then
      return
    end
    local remainTime_s64 = ToClient_GetLeftUsableTeleportCompassTime()
    local remainTime = Int64toInt32(remainTime_s64)
    if remainTime > 0 then
      if IsSelfPlayerWaitAction() then
        ToClient_RequestTeleportPosUseCompass()
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
      end
    end
  elseif functionType == Widget_Function_Type.ReturnTown then
    local remainTime_s64 = ToClient_GetLeftReturnStoneTime()
    local remainTime = Int64toInt32(remainTime_s64)
    local returnPos3D = ToClient_GetPosUseReturnStone()
    local regionInfo = getRegionInfoByPosition(returnPos3D)
    if remainTime > 0 then
      if IsSelfPlayerWaitAction() then
        ToClient_RequestTeleportPosUseReturnStone()
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
      end
    end
  elseif functionType == Widget_Function_Type.SummonElephant then
    if nil == elephantActorKey then
      return
    end
    ToClient_RequestSummonElephantFromSiegeBuilding(elephantActorKey)
  elseif functionType == Widget_Function_Type.NationWar then
    PaGlobal_Panel_Window_NationSiege_ShowToggle()
  elseif functionType == Widget_Function_Type.BattleRoyal then
    local messageBoxTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_ENTERLOBBY")
    local messageBoxContent = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_BEFORE_LOBBY")
    local messageBoxFunctionYes = function()
      if false == IsSelfPlayerWaitAction() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEROYAL_WAITACTION_ALERT"))
        return
      end
      ToClient_RequestBattleRoyaleJoinToAnotherChannel()
      if true == ToClient_IsBattleRoyaleOpenState() and nil ~= PaGlobal_FadeOutOpen then
        PaGlobal_FadeOutOpen()
      end
    end
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxContent,
      functionYes = messageBoxFunctionYes,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif functionType == Widget_Function_Type.Report then
    PaGloabl_ReportAll_Open()
  elseif functionType == Widget_Function_Type.OnAir then
    if true == isGameTypeKorea() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesertkr")
    elseif true == isGameTypeJapan() then
      ToClient_OpenChargeWebPage("https://www.youtube.com/channel/UCnQmApFtw4rwkE0Xlo9oMCg")
    elseif true == isGameTypeRussia() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesert_ru")
    elseif true == isGameTypeEnglish() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/BlackDesertGame")
    elseif true == isGameTypeTaiwan() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesert_tw_official")
    elseif true == isGameTypeTH() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesert_th")
    elseif true == isGameTypeID() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesert_sea")
    elseif true == isGameTypeTR() then
      ToClient_OpenChargeWebPage("https://www.twitch.tv/blackdesert_tr")
    end
  elseif functionType == Widget_Function_Type.BlackSpiritPass then
    PaGlobal_BlackspiritPass_Open()
  elseif functionType == Widget_Function_Type.SiegeWarReturn then
    ToClient_RequestTeleportFromSiegeTentReturn()
  elseif functionType == Widget_Function_Type.TransferAccount then
    if nil ~= PaGlobal_TransferPage_Open then
      PaGlobal_TransferPage_Open()
    end
  elseif functionType == Widget_Function_Type.TerritoryPoint then
    if nil ~= Panel_Guild_Point then
      Panel_Widget_FunctionButton_info._button[Widget_Function_Type.TerritoryPoint]:EraseAllEffect()
      ToClient_ShowGuildPolicy()
    end
  elseif functionType == Widget_Function_Type.GMQuizEvent then
    if true == _ContentsGroup_QuizEvent then
      ToClient_RequestQuizGameJoinOrUnJoin(true)
    end
  elseif functionType == Widget_Function_Type.GrowthPass and true == _ContentsGroup_GrowthPass then
    if true == PaGlobalFunc_GrowthPass_IsShow() then
      PaGlobalFunc_GrowthPass_Close()
    else
      PaGlobalFunc_GrowthPass_Open()
    end
  end
end
function Panel_Widget_FunctionButton_info:handleRClick(functionType)
  if functionType == Widget_Function_Type.FindNPC then
  elseif functionType == Widget_Function_Type.MovieToolTip then
  elseif functionType == Widget_Function_Type.SetVoice then
  elseif functionType == Widget_Function_Type.SiegeArea then
  elseif functionType == Widget_Function_Type.HorseRace then
  elseif functionType == Widget_Function_Type.Militia then
  elseif functionType == Widget_Function_Type.BusterCall then
  elseif functionType == Widget_Function_Type.SiegeWarCall then
  elseif functionType == Widget_Function_Type.PartySummon then
  elseif functionType == Widget_Function_Type.ReturnTown then
  elseif functionType == Widget_Function_Type.SummonElephant then
  elseif functionType == Widget_Function_Type.NationWar then
    PaGlobal_NationSiegeBoard_Open()
  elseif functionType == Widget_Function_Type.SiegeWarReturn then
  elseif functionType == Widget_Function_Type.TransferAccount then
  elseif functionType == Widget_Function_Type.TerritoryPoint then
  elseif functionType == Widget_Function_Type.GMQuizEvent then
  end
end
function Panel_Widget_FunctionButton_info:handleOver(functionType)
  local name = ""
  local desc = ""
  local uiControl = self._button[functionType]
  local showToolTip = false
  local showBanner = false
  local bannerControl
  if functionType == Widget_Function_Type.FindNPC then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NPCNAVI_NPCNAVITEXT")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_CAMP_REMOTE_BUTTON_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif functionType == Widget_Function_Type.MovieToolTip then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MOVIEGUIDE_TITLE")
    desc = ""
  elseif functionType == Widget_Function_Type.SetVoice then
    showToolTip = true
    local changeString = function(isOn)
      local returnValue = ""
      if true == isOn then
        returnValue = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_TOOLTIP_ISON")
      else
        returnValue = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_TOOLTIP_ISOFF")
      end
      return returnValue
    end
    local isMicOn = changeString(ToClient_isVoiceChatMic())
    local isHeadphoneOn = changeString(ToClient_isVoiceChatListen())
    name = PAGetString(Defines.StringSheet_GAME, "LUA_VOICECHAT_TOOLTIP_TITLE")
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_VOICECHAT_TOOLTIP_DESC", "mic", isMicOn, "speaker", isHeadphoneOn)
  elseif functionType == Widget_Function_Type.SiegeArea then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESEIGE_AREABUTTON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESEIGE_AREABUTTON_DESC")
  elseif functionType == Widget_Function_Type.HorseRace then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTRACE_INFO")
    desc = ""
  elseif functionType == Widget_Function_Type.Militia then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MERCENARY_TITLE")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MERCENARY_TOPDESC")
  elseif functionType == Widget_Function_Type.BusterCall then
    PaGlobalFunc_Widget_FunctionButton_Check_GuildBusterCall()
    showToolTip = true
    name = self._tooltip._name[Widget_Function_Type.BusterCall]
    desc = self._tooltip._desc[Widget_Function_Type.BusterCall]
  elseif functionType == Widget_Function_Type.SiegeWarCall then
    PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()
    showToolTip = true
    name = self._tooltip._name[Widget_Function_Type.SiegeWarCall]
    desc = self._tooltip._desc[Widget_Function_Type.SiegeWarCall]
  elseif functionType == Widget_Function_Type.PartySummon then
    PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
    showToolTip = true
    name = self._tooltip._name[Widget_Function_Type.PartySummon]
    desc = self._tooltip._desc[Widget_Function_Type.PartySummon]
  elseif functionType == Widget_Function_Type.ReturnTown then
    PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
    showToolTip = true
    name = self._tooltip._name[Widget_Function_Type.ReturnTown]
    desc = self._tooltip._desc[Widget_Function_Type.ReturnTown]
  elseif functionType == Widget_Function_Type.SummonElephant then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONELEPHANT_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SUMMONELEPHANT_TOOLTIP_DESC")
  elseif functionType == Widget_Function_Type.NationWar then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_ICON_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_ICON_TOOLTIP_DESC")
    if true == ToClient_isBeingNationSiege() then
      desc = desc .. PAGetString(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_ICON_TOOLTIP_DESC_RCLICK")
    end
  elseif functionType == Widget_Function_Type.BattleRoyal then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_BATTLEROYAL")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_BATTLEROYAL_FUNCTIONBUTTON_DESC")
  elseif functionType == Widget_Function_Type.Report then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_REPORT_BUTTON")
    desc = PAGetStringSymNo(3038419446) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif functionType == Widget_Function_Type.OnAir then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FUNCTIONBUTTON_TOOLTIP_ONAIRTITLE")
    if true == isGameTypeKorea() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FUNCTIONBUTTON_TOOLTIP_ONAIRDESC")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FUNCTIONBUTTON_TOOLTIP_ONAIRDESC_NO_KR")
    end
  elseif functionType == Widget_Function_Type.BlackSpiritPass then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITPASS_TOOLTIP_TITLE")
    desc = PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
  elseif functionType == Widget_Function_Type.SiegeWarReturn then
    PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarReturn()
    showToolTip = true
    name = self._tooltip._name[Widget_Function_Type.SiegeWarReturn]
    desc = self._tooltip._desc[Widget_Function_Type.SiegeWarReturn]
  elseif functionType == Widget_Function_Type.TransferAccount then
    showBanner = true
    bannerControl = self._banner[Widget_Function_Type.TransferAccount]
  elseif functionType == Widget_Function_Type.TerritoryPoint then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_POLICY_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_POLICY_TOOLTIP_DESC")
  elseif functionType == Widget_Function_Type.GMQuizEvent then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_QUIZ_BUSTCALL_TOOLTIP_TITLE")
    local remainTime = ToClient_GetRemainQuizBustCallTime()
    if remainTime < 0 then
      remainTime = 0
    end
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUIZ_BUSTCALL_TOOLTIP_DESC", "remainTime", convertSecondsToClockTime(remainTime))
  elseif functionType == Widget_Function_Type.GrowthPass then
    showToolTip = true
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_GROWTHPASS_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_GROWTHPASS_DESC")
  end
  if true == showToolTip then
    if nil ~= uiControl then
      registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
      TooltipSimple_Show(uiControl, name, desc)
    end
  elseif true == showBanner and nil ~= bannerControl then
    bannerControl:SetShow(true)
    local showAni = bannerControl:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
    showAni:SetStartColor(Defines.Color.C_00FFFFFF)
    showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
    showAni:SetDisableWhileAni(true)
  end
end
function Panel_Widget_FunctionButton_info:open()
  Panel_Widget_Function:SetShow(true)
  if 0 <= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_Widget_Function:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
end
function Panel_Widget_FunctionButton_info:close()
  if 0 <= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    local isNowShow = 0 ~= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_WidgetFunction, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    Panel_Widget_Function:SetShow(isNowShow)
  end
end
function PaGlobalFunc_Widget_FunctionButton_GetShow()
  return Panel_Widget_Function:GetShow()
end
function PaGlobalFunc_Widget_FunctionButton_Open()
  local self = Panel_Widget_FunctionButton_info
  self:open()
end
function PaGlobalFunc_Widget_FunctionButton_Close()
  local self = Panel_Widget_FunctionButton_info
  self:close()
end
function PaGlobalFunc_Widget_FunctionButton_Show()
  local self = Panel_Widget_FunctionButton_info
  self:updateAllButton()
  self:open()
end
function PaGlobalFunc_Widget_FunctionButton_Exit()
  local self = Panel_Widget_FunctionButton_info
  self:close()
end
function PaGlobalFunc_Widget_FunctionButton_HandleOver(functionType)
  local self = Panel_Widget_FunctionButton_info
  self:handleOver(functionType)
end
function PaGlobalFunc_Widget_FunctionButton_HandleLClick(functionType)
  local self = Panel_Widget_FunctionButton_info
  self:handleLClick(functionType)
end
function PaGlobalFunc_Widget_FunctionButton_HandleRClick(functionType)
  local self = Panel_Widget_FunctionButton_info
  self:handleRClick(functionType)
end
function PaGlobalFunc_Widget_FunctionButton_HandleUpdate(functionType)
  local self = Panel_Widget_FunctionButton_info
  self:updateButton(functionType)
end
function PaGlobalFunc_Widget_FunctionButton_HandleOut(functionType)
  local bannerControl
  if functionType == Widget_Function_Type.TransferAccount then
    bannerControl = Panel_Widget_FunctionButton_info._banner[Widget_Function_Type.TransferAccount]
  end
  if nil == bannerControl then
    TooltipSimple_Hide()
  else
    local hideAni = bannerControl:addColorAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
    hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
    hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
    hideAni:SetHideAtEnd(true)
    hideAni:SetDisableWhileAni(true)
  end
end
function PaGlobalFunc_Widget_FunctionButton_Control(functionType)
  local self = Panel_Widget_FunctionButton_info
  if nil ~= self._button[functionType] then
    return self._button[functionType]
  end
end
function PaGlobalFunc_Widget_FunctionButton_ShowBlackspiritReopenGuideEffect()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local level = selfPlayer:get():getLevel()
  if level >= 50 then
    return
  end
  local functionType = Widget_Function_Type.BlackSpiritPass
  Panel_Widget_FunctionButton_info._button[functionType]:AddEffect("fUI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
  Panel_Widget_FunctionButton_info._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
end
function FGlobal_GetPersonalIconPosX()
  return Panel_Widget_Function:GetPosX()
end
function FGlobal_GetPersonalIconPosY()
  return Panel_Widget_Function:GetPosY()
end
function FGlobal_GetPersonalIconSizeX()
  return Panel_Widget_Function:GetSizeX()
end
function FGlobal_GetPersonalIconSizeY()
  return Panel_Widget_Function:GetSizeY()
end
function FromClient_Widget_FunctionButton_Init()
  local self = Panel_Widget_FunctionButton_info
  self:initialize()
  PaGlobalFunc_Widget_FunctionButton_Show()
  PaGlobalFunc_Widget_FunctionButton_Check_GuildBusterCall()
  PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()
  PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  PaGlobalFunc_Widget_FunctionButton_BattleRoyale_ReloadOpen()
  PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarReturn()
  FromClient_Response_QuizGameStateAck_BustCall(__eQuizGameState_BustCall)
end
function FromClient_Widget_FunctionButton_Resize()
  local self = Panel_Widget_FunctionButton_info
  self:resize()
end
function FromClient_Widget_FunctionButton_ResponseBustCall(sendType)
  local self = Panel_Widget_FunctionButton_info
  if 0 == sendType then
    self._isLeftTime[Widget_Function_Type.BusterCall] = true
    self._busterCallTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall, 600000, false, 0)
  else
    self._isLeftTime[Widget_Function_Type.BusterCall] = false
  end
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.BusterCall] = false
  self._busterCallTimerKey = nil
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_GuildBusterCall()
  local self = Panel_Widget_FunctionButton_info
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetGuildBustCallPos())
  if nil == regionInfoWrapper then
    self._isLeftTime[Widget_Function_Type.BusterCall] = false
    self:updateAllButton()
    return
  end
  local leftTime = Int64toInt32(getLeftSecond_TTime64(ToClient_GetGuildBustCallTime()))
  if leftTime > 0 then
    if nil == self._busterCallTimerKey then
      self._busterCallTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_GuildBusterCall, leftTime * 1000, false, 0)
    end
    self._isLeftTime[Widget_Function_Type.BusterCall] = true
    self:updateAllButton()
  else
    self._isLeftTime[Widget_Function_Type.BusterCall] = false
    self:updateAllButton()
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetGuildBustCallTime()
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_NAME")
  local desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
  self._tooltip._name[Widget_Function_Type.BusterCall] = name
  self._tooltip._desc[Widget_Function_Type.BusterCall] = desc
end
function FromClient_Widget_FunctionButton_BattleRoyale_IsOpen(isOn)
  if false == _ContentsGroup_RedDesert then
    return
  end
  local self = Panel_Widget_FunctionButton_info
  local bool = isOn
  self._battleRoyalIsOpen = bool
  self:updateAllButton()
  if true == isOn then
    PaGlobal_BottomBanner_Open()
  end
end
function PaGlobalFunc_Widget_FunctionButton_BattleRoyale_ReloadOpen()
  if false == _ContentsGroup_RedDesert then
    return
  end
  local self = Panel_Widget_FunctionButton_info
  local isBattleRoyaleOpen = ToClient_IsBattleRoyaleOpenState()
  self._battleRoyalIsOpen = isBattleRoyaleOpen
  self:updateAllButton()
end
function FromClient_Widget_FunctionButton_ResponseTeleportToSiegeTent(sendType, isVolunteer)
  local self = Panel_Widget_FunctionButton_info
  if 0 == sendType then
    self._isLeftTime[Widget_Function_Type.SiegeWarCall] = true
    self._siegeWarCallTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall, 600000, false, 0)
  else
    self._isLeftTime[Widget_Function_Type.SiegeWarCall] = false
  end
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.SiegeWarCall] = false
  self._siegeWarCallTimerKey = nil
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarCall()
  local self = Panel_Widget_FunctionButton_info
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportToSiegeTentPos())
  if nil == regionInfoWrapper then
    self._isLeftTime[Widget_Function_Type.SiegeWarCall] = false
    self:updateAllButton()
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildNo = selfPlayer:getGuildNo_s64()
  if true == selfPlayer:isGuildAllianceMember() then
    guildNo = selfPlayer:getGuildAllianceNo_s64()
  end
  local tentCount = ToClient_getCurrnetBuildingCount(guildNo)
  if true == _ContentsGroup_ConquestSiege and 1 == tentCount then
    local householdNo = ToClient_getHouseholdNoAtIndex(guildNo, 0)
    if 0 ~= householdNo then
      local buildingInfo = ToClient_getBuildingInfoByHouseholdNo(householdNo)
      if nil ~= buildingInfo then
        if true == ToClient_IsVillageSiegeBeing() then
          buildingRegionKey = buildingInfo:getBuildingRegionKey()
        else
          buildingRegionKey = buildingInfo:getAffiliatedRegionKey()
        end
        local regionInfo = getRegionInfoByRegionKey(buildingRegionKey)
        local regionName = ""
        if nil ~= regionInfo then
          areaName = regionInfo:getAreaName()
        end
      end
    end
  end
  local usableTime64 = ToClient_GetTeleportToSiegeTentTime()
  local leftTime = 0
  if nil ~= usableTime64 then
    leftTime = Int64toInt32(getLeftSecond_TTime64(usableTime64))
  end
  if leftTime > 0 then
    if nil == self._siegeWarCallTimerKey then
      self._siegeWarCallTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarCall, leftTime * 1000, false, 0)
    end
    self._isLeftTime[Widget_Function_Type.SiegeWarCall] = true
    self:updateAllButton()
  else
    self._isLeftTime[Widget_Function_Type.SiegeWarCall] = false
    self:updateAllButton()
    return
  end
  local selfProxy = getSelfPlayer()
  if nil ~= selfProxy then
    if selfProxy:get():isVolunteer() then
      descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC2", "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    elseif false == _ContentsGroup_ConquestSiege then
      descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    elseif tentCount > 1 then
      descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC_NEW", "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    else
      descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    end
  end
  local name, desc = PAGetString(Defines.StringSheet_GAME, "LUA_WARCALL_TOOLTIP_NAME"), descStr
  self._tooltip._name[Widget_Function_Type.SiegeWarCall] = name
  self._tooltip._desc[Widget_Function_Type.SiegeWarCall] = desc
end
function FromClient_Widget_FunctionButton_ResponseTeleportFromSiegeTent(sendType)
  local self = Panel_Widget_FunctionButton_info
  if 0 == sendType then
    self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = true
    self._siegeWarReturnTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarReturn, 600000, false, 0)
  else
    self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = false
  end
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarReturn()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = false
  self._siegeWarReturnTimerKey = nil
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_SiegeWarReturn()
  local self = Panel_Widget_FunctionButton_info
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByPosition(ToClient_GetTeleportFromSiegeTentPos())
  if nil == regionInfoWrapper then
    self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = false
    self:updateAllButton()
    return
  end
  local areaName = regionInfoWrapper:getAreaName()
  local usableTime64 = ToClient_GetTeleportFromSiegeTentTime()
  local leftTime = 0
  if nil ~= usableTime64 then
    leftTime = Int64toInt32(getLeftSecond_TTime64(usableTime64))
  end
  if leftTime > 0 then
    if nil == self._siegeWarCallTimerKey then
      self._siegeWarReturnTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_SiegeWarReturn, leftTime * 1000, false, 0)
    end
    self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = true
    self:updateAllButton()
  else
    self._isLeftTime[Widget_Function_Type.SiegeWarReturn] = false
    self:updateAllButton()
    return
  end
  local selfProxy = getSelfPlayer()
  if nil ~= selfProxy then
    if selfProxy:get():isVolunteer() then
      descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC2", "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    else
      descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_BUSTERCALL_TOOLTIP_DESC", "areaName", areaName, "time", convertStringFromDatetime(getLeftSecond_TTime64(usableTime64)))
    end
  end
  local name, desc = PAGetString(Defines.StringSheet_GAME, "LUA_WARRETURN_TOOLTIP_NAME"), descStr
  self._tooltip._name[Widget_Function_Type.SiegeWarReturn] = name
  self._tooltip._desc[Widget_Function_Type.SiegeWarReturn] = desc
end
function FromClient_Widget_FunctionButton_ResponseUseCompass()
  _PA_LOG("\236\160\149\237\131\156\234\179\164", "\236\157\180\235\178\164\237\138\184\234\176\128 \235\147\164\236\150\180\236\152\164\234\179\160 \236\158\136\235\138\148 \234\178\131\236\157\184\234\176\128\236\154\148????????")
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.PartySummon] = false
  PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  self:updateAllButton()
  local partyName = ""
  partyName = ToClient_GetCharacterNameUseCompass()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local msg = ""
  if partyActorKey == playerActorKey then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_COMPASS_MESSAGE_1")
  else
    msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPASS_MESSAGE_2", "partyName", partyName)
  end
  Proc_ShowMessage_Ack(msg)
  self._partySummonTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_PartySummon, 600000, false, 0)
end
function PaGlobalFunc_Widget_FunctionButton_Close_PartySummon()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.PartySummon] = false
  self._partySummonTimerKey = nil
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_PartySummon()
  local self = Panel_Widget_FunctionButton_info
  local partyName = ToClient_GetCharacterNameUseCompass()
  local partyActorKey = ToClient_GetCharacterActorKeyRawUseCompass()
  local playerActorKey = getSelfPlayer():getActorKey()
  local descStr = ""
  local usableTime64 = ToClient_GetLeftUsableTeleportCompassTime()
  local remainTime = Int64toInt32(usableTime64)
  if remainTime > 0 then
    if nil == self._partySummonTimerKey then
      self._partySummonTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_PartySummon, remainTime * 1000, false, 0)
    end
    self._isLeftTime[Widget_Function_Type.PartySummon] = true
    self:updateAllButton()
  else
    self._isLeftTime[Widget_Function_Type.PartySummon] = false
    self:updateAllButton()
    return
  end
  if partyActorKey == playerActorKey then
    descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPASS_DESC_1", "remainTime", convertStringFromDatetime(usableTime64))
  else
    descStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_COMPASS_DESC_2", "partyName", partyName, "partyName1", partyName, "remainTime", convertStringFromDatetime(usableTime64))
  end
  local name, desc = PAGetString(Defines.StringSheet_GAME, "LUA_COMPASS_NAME"), descStr
  self._tooltip._name[Widget_Function_Type.PartySummon] = name
  self._tooltip._desc[Widget_Function_Type.PartySummon] = desc
end
function FromClient_Widget_FunctionButton_ResponseUseReturnStone()
  local self = Panel_Widget_FunctionButton_info
  local pos3D = ToClient_GetPosUseReturnStone()
  ToClient_DeleteNaviGuideByGroup(0)
  worldmapNavigatorStart(pos3D, NavigationGuideParam(), false, false)
  PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  self:updateAllButton()
  self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown, 1800000, false, 0)
end
function PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.ReturnTown] = false
  self._returnTownTimerKey = nil
  self:updateAllButton()
end
function PaGlobalFunc_Widget_FunctionButton_Check_ReturnTown()
  local self = Panel_Widget_FunctionButton_info
  local returnPos3D = ToClient_GetPosUseReturnStone()
  local regionInfo = getRegionInfoByPosition(returnPos3D)
  local regionName = ""
  if nil ~= regionInfo then
    regionName = regionInfo:getAreaName()
  end
  local returnTownRegionKey = ToClient_GetReturnStoneTownRegionKey()
  local usableTime64 = ToClient_GetLeftReturnStoneTime()
  local remainTime = Int64toInt32(usableTime64)
  if remainTime > 0 then
    if nil == self._returnTownTimerKey then
      self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown, remainTime * 1000, false, 0)
    end
    self._isLeftTime[Widget_Function_Type.ReturnTown] = true
    self:updateAllButton()
  else
    self._isLeftTime[Widget_Function_Type.ReturnTown] = false
    self:updateAllButton()
    return
  end
  local descStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_RETURNSTONE_DESC", "regionName", regionName, "remainTime", convertStringFromDatetime(usableTime64))
  local name, desc = PAGetString(Defines.StringSheet_GAME, "LUA_RETURNSTONE_NAME"), descStr
  self._tooltip._name[Widget_Function_Type.ReturnTown] = name
  self._tooltip._desc[Widget_Function_Type.ReturnTown] = desc
end
function FromClient_ShowElephantBarn(actorKey)
  local self = Panel_Widget_FunctionButton_info
  elephantActorKey = actorKey
  self:updateAllButton()
end
function FromClient_HideElephantBarn()
  local self = Panel_Widget_FunctionButton_info
  elephantActorKey = nil
  self:updateAllButton()
end
function FromClient_FunctionButton_OnAir(isOnAir)
  Panel_Widget_FunctionButton_info._buttonShow[Widget_Function_Type.OnAir] = isOnAir
  Panel_Widget_FunctionButton_info:updateAllButton()
end
function FGlobal_FunctionButton_NationSiegeIcon_StartAni()
  local self = Panel_Widget_FunctionButton_info
  if nil ~= self._button[Widget_Function_Type.NationWar] then
    self._button[Widget_Function_Type.NationWar]:SetVertexAniRun("Ani_Color_New", true)
  end
end
function FGlobal_FunctionButton_NationSiegeIcon_StopAni()
  local self = Panel_Widget_FunctionButton_info
  if nil ~= self._button[Widget_Function_Type.NationWar] then
    self._button[Widget_Function_Type.NationWar]:SetVertexAniRun("Ani_Color_New", false)
    self._button[Widget_Function_Type.NationWar]:SetColor(Defines.Color.C_FFFFFFFF)
  end
end
local summonPartyCheck = function()
  local leftTime = Int64toInt32(ToClient_GetLeftUsableTeleportCompassTime())
  if leftTime <= 0 then
    PaGlobalFunc_Widget_FunctionButton_Close_PartySummon()
  end
end
function FGlobal_SummonPartyCheck()
  summonPartyCheck()
end
local returnStoneCheck = function()
  local leftTime = Int64toInt32(ToClient_GetLeftReturnStoneTime())
  if leftTime <= 0 then
    PaGlobalFunc_Widget_FunctionButton_Close_ReturnTown()
  end
end
function FGlobal_ReturnStoneCheck()
  returnStoneCheck()
end
function FromClient_CheckBlackSpiritEffect()
  local self = Panel_Widget_FunctionButton_info
  if false == seasonContentsEnable or false == self._isSeasonCharacter then
    return
  end
  local functionType = Widget_Function_Type.BlackSpiritPass
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local level = selfPlayer:get():getLevel()
    if level <= 50 then
      if nil == BlackSpiritPassEffectNo1 then
        BlackSpiritPassEffectNo1 = Panel_Widget_FunctionButton_info._button[functionType]:AddEffect("fUI_BlackSpirit_Pass_Icon_Cast_02A", true, 0, 0)
      end
      if nil == BlackSpiritPassEffectNo2 then
        BlackSpiritPassEffectNo2 = Panel_Widget_FunctionButton_info._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_02A", true, 0, 0)
      end
    else
      if nil ~= BlackSpiritPassEffectNo1 then
        Panel_Widget_FunctionButton_info._button[functionType]:EraseEffect(BlackSpiritPassEffectNo1)
        BlackSpiritPassEffectNo1 = nil
      end
      if nil ~= BlackSpiritPassEffectNo2 then
        Panel_Widget_FunctionButton_info._button[functionType]:EraseEffect(BlackSpiritPassEffectNo2)
        BlackSpiritPassEffectNo2 = nil
      end
      if true == PaGlobal_BlackspiritPass_IsThereAnyReward() then
        if nil == seasonRewardEffectNo then
          seasonRewardEffectNo = Panel_Widget_FunctionButton_info._button[functionType]:AddEffect("fUI_BlackSpirit_Pass_Icon_01A", true, 0, 0)
        end
      elseif nil ~= seasonRewardEffectNo then
        Panel_Widget_FunctionButton_info._button[functionType]:EraseEffect(seasonRewardEffectNo)
        seasonRewardEffectNo = nil
      end
    end
  end
end
function FromCLient_PlayGrowthPassRewardEffect()
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local self = Panel_Widget_FunctionButton_info
  if true == self._isSeasonCharacter then
    return
  end
  local functionType = Widget_Function_Type.GrowthPass
  self._button[functionType]:EraseAllEffect()
  self._button[functionType]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_01A", false, 0, 0)
  GrowthPassEffectNo = nil
  FromClient_CheckGrowthPassEffect()
end
function FromClient_CheckGrowthPassEffect()
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local self = Panel_Widget_FunctionButton_info
  if true == self._isSeasonCharacter then
    return
  end
  local isGetableAnyRewardItem = ToClient_checkGetableAnyRewardItemForGrowthPass()
  ProcessGrowthPassIconEffect(isGetableAnyRewardItem)
end
function ProcessGrowthPassIconEffect(isActiveEffect)
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local self = Panel_Widget_FunctionButton_info
  if true == self._isSeasonCharacter then
    return
  end
  local functionType = Widget_Function_Type.GrowthPass
  if true == isActiveEffect then
    if nil == GrowthPassEffectNo then
      GrowthPassEffectNo = self._button[functionType]:AddEffect("fUI_GrowthPassIcon_01A", true, 0, 0)
    end
  elseif nil ~= GrowthPassEffectNo then
    self._button[functionType]:EraseEffect(GrowthPassEffectNo)
    GrowthPassEffectNo = nil
  end
end
function FromClient_GraduateSeason()
  local self = Panel_Widget_FunctionButton_info
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._isSeasonCharacter = selfPlayer:get():isSeasonCharacter()
  end
  self:updateAllButton()
end
function FromClient_GuildPolicyEffectOn()
  Panel_Widget_FunctionButton_info._button[Widget_Function_Type.TerritoryPoint]:EraseAllEffect()
  Panel_Widget_FunctionButton_info._button[Widget_Function_Type.TerritoryPoint]:AddEffect("fUI_GuildPolicy_Icon_01A", true, 0, 0)
  if nil ~= Panel_IngameCashShop and false == Panel_IngameCashShop:GetShow() then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POLICY_TOOLTIP_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_POLICY_TOOLTIP_DESC")
    TooltipSimple_Show(Panel_Widget_FunctionButton_info._button[Widget_Function_Type.TerritoryPoint], name, desc)
    if nil ~= Panel_Tooltip_SimpleText then
      Panel_Tooltip_SimpleText:SetPosX(Panel_Widget_Function:GetPosX() + Panel_Widget_FunctionButton_info._button[Widget_Function_Type.TerritoryPoint]:GetPosX())
      Panel_Tooltip_SimpleText:SetPosY(Panel_Widget_Function:GetPosY() + Panel_Tooltip_SimpleText:GetSizeY() / 2)
    end
  end
end
function FromClient_Response_QuizGameStateAck_BustCall(quizStateType)
  if __eQuizGameState_BustCall == quizStateType then
    if true == ToClient_IsJoinQuizGame() then
      return
    end
    local self = Panel_Widget_FunctionButton_info
    local remainTime = ToClient_GetRemainQuizBustCallTime()
    if remainTime > 0 then
      if nil == self._returnTownTimerKey then
        self._returnTownTimerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_FunctionButton_Close_GMQuizEvent, remainTime * 1000, false, 0)
      end
      self._isLeftTime[Widget_Function_Type.GMQuizEvent] = true
      self:updateAllButton()
    else
      self._isLeftTime[Widget_Function_Type.GMQuizEvent] = false
      self:updateAllButton()
    end
    local descStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_QUIZ_BUSTCALL_TOOLTIP_DESC", "remainTime", convertSecondsToClockTime(remainTime))
    self._tooltip._desc[Widget_Function_Type.GMQuizEvent] = descStr
  end
end
function PaGlobalFunc_Widget_FunctionButton_Close_GMQuizEvent()
  local self = Panel_Widget_FunctionButton_info
  self._isLeftTime[Widget_Function_Type.GMQuizEvent] = false
  self._gmQuizTimerKey = nil
  self:updateAllButton()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_FunctionButton_Init")
