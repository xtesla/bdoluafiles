function PaGlobal_GuildWarInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.stc_NoOccupantBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_NoOccupantBg")
  self._ui.stc_LeftGuild_Bg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_LeftGuild")
  self._ui.stc_RightGuild_Bg_2 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_RightGuildx2_Bg")
  self._ui.stc_RightGuild_Bg_4 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_RightGuildx4_Bg")
  self._ui.stc_RightGuild_Bg_list = UI.getChildControl(Panel_GuildWarInfo_All, "List2_RightGuild5OverList")
  self._ui.txt_Title = UI.getChildControl(Panel_GuildWarInfo_All, "StaticText_Title")
  self._ui.btn_Small = UI.getChildControl(self._ui.txt_Title, "Button_Small")
  self._ui.btn_Close = UI.getChildControl(self._ui.txt_Title, "Button_Close")
  self._ui.btn_Reload = UI.getChildControl(Panel_GuildWarInfo_All, "Button_Reload")
  self._ui.stc_TabBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_TabBg")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_TabBg, "Static_SelectLine")
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    self._ui.btn_Territory[index] = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Territory_" .. tostring(index))
  end
  self._ui.stc_FinishBg = UI.getChildControl(Panel_GuildWarInfo_All, "Static_FinishBg")
  self._ui.txt_Finish_Desc = UI.getChildControl(self._ui.stc_FinishBg, "StaticText_FinishText")
  self._ui.txt_Result_Desc = UI.getChildControl(self._ui.stc_FinishBg, "StaticText_ResulfText")
  self._ui.btn_Rank = UI.getChildControl(Panel_GuildWarInfo_All, "Button_Rank")
  self._ui.btn_RankIcon = UI.getChildControl(self._ui.btn_Rank, "Static_Icon")
  self._ui.stc_Score_No1 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_3and2Team_No1")
  self._ui.stc_Score_No2 = UI.getChildControl(Panel_GuildWarInfo_All, "Static_2Team_No2")
  self._ui.stc_Score_LeftScore = UI.getChildControl(Panel_GuildWarInfo_All, "Static_Left2Guild")
  self._ui.stc_Score_LeftScore_No2 = UI.getChildControl(self._ui.stc_Score_LeftScore, "Static_3Team_No2")
  self._ui.stc_Score_LeftScore_No3 = UI.getChildControl(self._ui.stc_Score_LeftScore, "Static_3Team_No3")
  self._ui.stc_SiegeGuildList = UI.getChildControl(Panel_GuildWarInfo_All, "Static_SiegeGuildList")
  self._ui.stc_GuildList = UI.getChildControl(self._ui.stc_SiegeGuildList, "List2_GuildList")
  self._ui.stc_GuildList_No1 = UI.getChildControl(self._ui.stc_SiegeGuildList, "Static_3TeamMore_No1")
  self._ui.stc_GuildList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarInfo_All_UpdateSecondRoundRankList")
  self._ui.stc_GuildList:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == _ContentsGroup_SiegeSecondScore then
    self._ui.btn_Rank:SetShow(not self._isConsole)
  end
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_GuildWarInfo_All, "Static_KeyGuideGroup")
  self:initConsole()
  self:initGuild()
  self:registEventHandler()
  self:validate()
  self:buttonInit()
  self._initialize = true
end
function PaGlobal_GuildWarInfo_All:initConsole()
  if false == self._isConsole then
    return
  end
  local stc_KeyGuideLB = UI.getChildControl(self._ui.stc_TabBg, "Static_KeyGuideLB")
  local stc_KeyGuideRB = UI.getChildControl(self._ui.stc_TabBg, "Static_KeyGuideRB")
  local txt_IconGuide = UI.getChildControl(Panel_GuildWarInfo_All, "StaticText_BigAndSmallGuide")
  stc_KeyGuideLB:SetShow(self._isConsole)
  stc_KeyGuideRB:SetShow(self._isConsole)
  self._ui.stc_KeyGuide:SetShow(self._isConsole)
  txt_IconGuide:SetShow(not self._isConsole)
  self._ui.btn_Close:SetShow(not self._isConsole)
  self._ui.btn_Small:SetShow(not self._isConsole)
  self._ui.btn_Reload:SetShow(not self._isConsole)
  self._ui.btn_Rank:SetShow(not self._isConsole)
  self:setKeyGuide()
end
function PaGlobal_GuildWarInfo_All:setKeyGuide()
  local txt_KeyGuideY = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideY")
  local txt_KeyGuideX = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideX")
  local txt_KeyGuideA = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideA")
  local txt_KeyGuideB = UI.getChildControl(self._ui.stc_KeyGuide, "StaticText_KeyGuideB")
  local keyGuides = {
    txt_KeyGuideY,
    txt_KeyGuideX,
    txt_KeyGuideA,
    txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_GuildWarInfo_All:registEventHandler()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarInfo_All_Close()")
  self._ui.btn_Small:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowSmallWindowTooltip(true)")
  self._ui.btn_Small:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowSmallWindowTooltip(false)")
  self._ui.btn_Small:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenSmallWindow()")
  self._ui.btn_Reload:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowRefreshTooltip(true)")
  self._ui.btn_Reload:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowRefreshTooltip(false)")
  self._ui.btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_Reload()")
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    if true == ToClient_isStartMajorSiege(index) then
      self._ui.btn_Territory[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_SelectTab(" .. index .. ")")
    end
  end
  self._ui.btn_Rank:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_SecondRoundRankToggle()")
  self._ui.btn_Rank:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowRankTooltip(true)")
  self._ui.btn_Rank:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowRankTooltip(false)")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_GuildWarInfo_All_ChangeTabConsole(-1)")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_GuildWarInfo_All_ChangeTabConsole(1)")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_GuildWarInfo_All_Reload()")
  Panel_GuildWarInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildWarInfo_All_SecondRoundRankToggle()")
  registerEvent("Event_SiegeScoreUpdateData", "FromClient_GuildWarInfo_All_UpdateScoreData")
  Panel_GuildWarInfo_All:RegisterUpdateFunc("PaGlobalFunc_GuildWarInfo_All_UpdatePerFrameFunc")
  registerEvent("FromClient_LoadSiegeSecondRoundScoreList", "FromClient_GuildWarInfo_All_LoadSiegeSecondRoundScoreList")
end
function PaGlobal_GuildWarInfo_All:prepareOpen(territoryKey)
  if nil == Panel_GuildWarInfo_All then
    return
  end
  PaGlobal_GuildWarInfo_All:secondRoundRankClose()
  local territoryIndex = 0
  if nil == territoryKey then
    territoryIndex = 0
  end
  if false == ToClient_isStartMajorSiege(territoryIndex) then
    territoryKey = self:getIndexNextIndex(territoryIndex, true)
  end
  if nil ~= Panel_Window_GuildWarInfoSmall_All and true == PaGlobalFunc_GuildWarInfoSmall_All_GetShow() then
    PaGlobalFunc_GuildWarInfoSmall_All_Close()
  end
  if nil ~= territoryKey then
    self._selectedTerritoryKey = territoryKey
  end
  if nil ~= self._ui.btn_Territory[self._selectedTerritoryKey] then
    self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(true)
    self._ui.stc_SelectLine:SetPosX(self._ui.btn_Territory[self._selectedTerritoryKey]:GetPosX() + self._ui.btn_Territory[self._selectedTerritoryKey]:GetSizeX() / 2 - self._ui.stc_SelectLine:GetSizeX() / 2)
  end
  ToClient_RequestSiegeScore(self._selectedTerritoryKey)
  self:updateBasicInfo()
  self._isRankOpen = false
  self:open()
end
function PaGlobal_GuildWarInfo_All:open()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  Panel_GuildWarInfo_All:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:prepareClose()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._isRankOpen = false
  self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(false)
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_GuildWarInfo_All:close()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  Panel_GuildWarInfo_All:SetShow(false)
end
function PaGlobal_GuildWarInfo_All:initGuild()
  self:initDefenceGuild()
  self:initOffenceGuild()
end
function PaGlobal_GuildWarInfo_All:initDefenceGuild()
  self._ui.stc_NoOccupantBg:SetShow(false)
  self._ui.stc_LeftGuild_Bg:SetShow(false)
  local leftProgressBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_ProgressBg")
  local leftBoxBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_Box")
  local guildIconBg = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_GuildIconBg")
  self._defenceGuildInfo = {
    stc_Bg = self._ui.stc_LeftGuild_Bg,
    stc_GuildIcon = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Static_GuildIcon"),
    progress_Castle = UI.getChildControl(leftProgressBg, "Progress2_1"),
    txt_GuildName = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_OccupyGuildName"),
    txt_MasterName = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_MasterName"),
    txt_CastleHp = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_Percent"),
    txt_Building = UI.getChildControl(leftBoxBg, "StaticText_DestroyValue"),
    txt_Vehicle = UI.getChildControl(leftBoxBg, "StaticText_ObjectDeathvalue"),
    txt_Member = UI.getChildControl(leftBoxBg, "StaticText_KillValue"),
    txt_Die = UI.getChildControl(leftBoxBg, "StaticText_DeathValue"),
    btn_Record = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "Button_Record"),
    stc_Title = {}
  }
  self._defenceGuildInfo.stc_Title[0] = UI.getChildControl(self._ui.stc_LeftGuild_Bg, "StaticText_Castle")
  self._defenceGuildInfo.stc_Title[1] = UI.getChildControl(leftBoxBg, "StaticText_DestroyTitle")
  self._defenceGuildInfo.stc_Title[2] = UI.getChildControl(leftBoxBg, "StaticText_KillTitle")
  self._defenceGuildInfo.stc_Title[3] = UI.getChildControl(leftBoxBg, "StaticText_ObjectDeathTitle")
  self._defenceGuildInfo.stc_Title[4] = UI.getChildControl(leftBoxBg, "StaticText_DeathTitle")
  self._defenceGuildInfo.btn_Record:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow()")
  local noOccupyTitle = UI.getChildControl(self._ui.stc_NoOccupantBg, "StaticText_NoOccupantInfo_1")
  local noOccupyDesc = UI.getChildControl(self._ui.stc_NoOccupantBg, "StaticText_NoOccupantInfo_Desc")
  noOccupyTitle:SetTextMode(__eTextMode_AutoWrap)
  noOccupyTitle:SetText(noOccupyTitle:GetText())
  noOccupyDesc:SetTextMode(__eTextMode_AutoWrap)
  noOccupyDesc:SetText(noOccupyDesc:GetText())
  noOccupyTitle:SetPosY(noOccupyDesc:GetPosY() - noOccupyTitle:GetTextSizeY() - 20)
  for tIndex = 0, 4 do
    self._defenceGuildInfo.stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
    self._defenceGuildInfo.stc_Title[tIndex]:SetText(self._defenceGuildInfo.stc_Title[tIndex]:GetText())
    self._defenceGuildInfo.stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 0 .. ", " .. tIndex .. ", nil, true)")
    self._defenceGuildInfo.stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false, nil, nil, nil, true)")
  end
end
function PaGlobal_GuildWarInfo_All:initOffenceGuild()
  self._ui.stc_RightGuild_Bg_2:SetShow(false)
  self._ui.stc_RightGuild_Bg_4:SetShow(false)
  self._ui.stc_RightGuild_Bg_list:SetShow(false)
  for index = 0, 1 do
    local rightGuildBg = UI.getChildControl(self._ui.stc_RightGuild_Bg_2, "Static_Guild2_" .. tostring(index + 1) .. "_Bg")
    local rightProgressBg = UI.getChildControl(rightGuildBg, "Static_ProgressBg")
    local rightFlag = UI.getChildControl(rightGuildBg, "Static_RightFlag")
    local guildIconBg = UI.getChildControl(rightFlag, "Static_GuildIconBg")
    self._offenceGuildInfo_2[index] = {
      stc_Bg = rightGuildBg,
      stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
      progress_Castle = UI.getChildControl(rightProgressBg, "Progress2_1"),
      txt_GuildName = UI.getChildControl(rightGuildBg, "StaticText_GuildName"),
      txt_MasterName = UI.getChildControl(rightGuildBg, "StaticText_Name"),
      txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
      txt_Building = UI.getChildControl(rightGuildBg, "StaticText_DestroyValue"),
      txt_Vehicle = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathvalue"),
      txt_Member = UI.getChildControl(rightGuildBg, "StaticText_KillValue"),
      txt_Die = UI.getChildControl(rightGuildBg, "StaticText_DeathValue"),
      stc_Title = {}
    }
    self._offenceGuildInfo_2[index].stc_Title[0] = UI.getChildControl(rightGuildBg, "Static_CatsleIcon")
    self._offenceGuildInfo_2[index].stc_Title[1] = UI.getChildControl(rightGuildBg, "StaticText_DestroyTitle")
    self._offenceGuildInfo_2[index].stc_Title[2] = UI.getChildControl(rightGuildBg, "StaticText_KillTitle")
    self._offenceGuildInfo_2[index].stc_Title[3] = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathTitle")
    self._offenceGuildInfo_2[index].stc_Title[4] = UI.getChildControl(rightGuildBg, "StaticText_DeathTitle")
    self._offenceGuildInfo_2[index].stc_Bg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(index + 1) .. ")")
    for tIndex = 0, 4 do
      if tIndex >= 1 then
        self._offenceGuildInfo_2[index].stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
        self._offenceGuildInfo_2[index].stc_Title[tIndex]:SetText(self._offenceGuildInfo_2[index].stc_Title[tIndex]:GetText())
      end
      self._offenceGuildInfo_2[index].stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 1 .. ", " .. tIndex .. ", " .. index .. ")")
      self._offenceGuildInfo_2[index].stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
    end
    rightGuildBg:SetShow(false)
  end
  for index = 0, 3 do
    local rightGuildBg = UI.getChildControl(self._ui.stc_RightGuild_Bg_4, "Static_Guild4_" .. tostring(index + 1) .. "_Bg")
    local rightProgressBg = UI.getChildControl(rightGuildBg, "Static_ProgressBg")
    local guildIconBg = UI.getChildControl(rightGuildBg, "Static_GuildIconBg")
    self._offenceGuildInfo_4[index] = {
      stc_Bg = rightGuildBg,
      stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
      progress_Castle = UI.getChildControl(rightProgressBg, "Progress2_1"),
      txt_GuildName = UI.getChildControl(rightGuildBg, "StaticText_GuildName"),
      txt_MasterName = UI.getChildControl(rightGuildBg, "StaticText_Name"),
      txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
      txt_Building = UI.getChildControl(rightGuildBg, "StaticText_DestroyValue"),
      txt_Vehicle = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathvalue"),
      txt_Member = UI.getChildControl(rightGuildBg, "StaticText_KillValue"),
      txt_Die = UI.getChildControl(rightGuildBg, "StaticText_DeathValue"),
      stc_Title = {}
    }
    self._offenceGuildInfo_4[index].stc_Title[0] = UI.getChildControl(rightGuildBg, "Static_CatsleIcon")
    self._offenceGuildInfo_4[index].stc_Title[1] = UI.getChildControl(rightGuildBg, "StaticText_DestroyTitle")
    self._offenceGuildInfo_4[index].stc_Title[2] = UI.getChildControl(rightGuildBg, "StaticText_KillTitle")
    self._offenceGuildInfo_4[index].stc_Title[3] = UI.getChildControl(rightGuildBg, "StaticText_ObjectDeathTitle")
    self._offenceGuildInfo_4[index].stc_Title[4] = UI.getChildControl(rightGuildBg, "StaticText_DeathTitle")
    self._offenceGuildInfo_4[index].stc_Bg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(index + 1) .. ")")
    for tIndex = 0, 4 do
      if tIndex >= 1 then
        self._offenceGuildInfo_4[index].stc_Title[tIndex]:SetTextMode(__eTextMode_LimitText)
        self._offenceGuildInfo_4[index].stc_Title[tIndex]:SetText(self._offenceGuildInfo_4[index].stc_Title[tIndex]:GetText())
      end
      self._offenceGuildInfo_4[index].stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 2 .. ", " .. tIndex .. ", " .. index .. ")")
      self._offenceGuildInfo_4[index].stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
    end
    rightGuildBg:SetShow(false)
  end
  self._ui.stc_RightGuild_Bg_list:changeAnimationSpeed(10)
  self._ui.stc_RightGuild_Bg_list:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarInfo_All_UpdateGuildList")
  self._ui.stc_RightGuild_Bg_list:createChildContent(__ePAUIList2ElementManagerType_List)
  self._offenceGuildList = self._ui.stc_RightGuild_Bg_list
end
function PaGlobal_GuildWarInfo_All:updateGuildList(content, index)
  local index_32 = Int64toInt32(index)
  local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, index_32)
  local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, index_32)
  if nil == guildWrapper or nil == siegeBuildingInfo then
    return
  end
  local rightGuildIndex = index_32
  if index_32 > self._defenceGuildIndex then
    rightGuildIndex = rightGuildIndex - 1
  end
  local rightGuildBg = UI.getChildControl(content, "Static_RightGuilListBg")
  local rightInfoBg = UI.getChildControl(rightGuildBg, "Static_RightBG")
  local guildIconBg = UI.getChildControl(rightGuildBg, "Static_GuildIconBg")
  local guildInfo = {
    stc_GuildIcon = UI.getChildControl(guildIconBg, "Static_GuildIcon"),
    txt_GuildName = UI.getChildControl(content, "StaticText_GuildName"),
    txt_MasterName = UI.getChildControl(content, "StaticText_Name"),
    txt_CastleHp = UI.getChildControl(rightGuildBg, "StaticText_Percent"),
    txt_Building = UI.getChildControl(rightInfoBg, "StaticText_DestroyValue"),
    txt_Vehicle = UI.getChildControl(rightInfoBg, "StaticText_ObjectDeathvalue"),
    txt_Member = UI.getChildControl(rightInfoBg, "StaticText_KillValue"),
    txt_Die = UI.getChildControl(rightInfoBg, "StaticText_DeathValue"),
    stc_Title = {}
  }
  guildInfo.stc_Title[0] = UI.getChildControl(rightInfoBg, "Static_CatsleIcon")
  guildInfo.stc_Title[1] = UI.getChildControl(rightInfoBg, "StaticText_DestroyIcon")
  guildInfo.stc_Title[2] = UI.getChildControl(rightInfoBg, "Static_KillIcon")
  guildInfo.stc_Title[3] = UI.getChildControl(rightInfoBg, "Static_ObjectDeathIcon")
  guildInfo.stc_Title[4] = UI.getChildControl(rightInfoBg, "Static_DeathIcon")
  if false == self._isConsole then
    guildInfo.stc_Title[0]:SetIgnore(false)
  end
  for tIndex = 0, 4 do
    guildInfo.stc_Title[tIndex]:addInputEvent("Mouse_On", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(true, " .. 3 .. ", " .. tIndex .. ", " .. rightGuildIndex .. ")")
    guildInfo.stc_Title[tIndex]:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildWarInfo_All_ShowTitleTooltip(false)")
  end
  rightGuildBg:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarInfo_All_OpenScoreWindow(" .. tostring(rightGuildIndex + 1) .. ")")
  local guildAllianceName = guildWrapper:getAllianceName()
  if "" == guildAllianceName then
    guildInfo.txt_GuildName:SetText(guildWrapper:getName())
  else
    guildInfo.txt_GuildName:SetText(guildAllianceName)
  end
  guildInfo.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
  local isSet = false
  if true == guildWrapper:isAllianceGuild() then
    isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), guildInfo.stc_GuildIcon)
  else
    isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), guildInfo.stc_GuildIcon)
  end
  if false == isSet then
    guildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(guildInfo.stc_GuildIcon, 183, 1, 188, 6)
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  else
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  end
  guildInfo.txt_Building:SetText(tostring(guildWrapper:getTotalSiegeCount(0)))
  guildInfo.txt_Member:SetText(tostring(guildWrapper:getTotalSiegeCount(1)))
  guildInfo.txt_Die:SetText(tostring(guildWrapper:getTotalSiegeCount(2)))
  guildInfo.txt_Vehicle:SetText(tostring(guildWrapper:getTotalSiegeCount(3)))
  local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
  guildInfo.txt_CastleHp:SetText(math.floor(hpPercent / 100 * 100) .. "%")
  self._offenceGuildListInfo[rightGuildIndex] = guildInfo
  content:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:updateBasicInfo()
  if true == PaGlobal_GuildWarInfo_All:IsRankClose() then
    return
  end
  self._ui.stc_LeftGuild_Bg:SetShow(false)
  self._ui.stc_NoOccupantBg:SetShow(false)
  self._ui.stc_RightGuild_Bg_2:SetShow(false)
  self._ui.stc_RightGuild_Bg_4:SetShow(false)
  self._ui.stc_RightGuild_Bg_list:SetShow(false)
  self._ui.stc_FinishBg:SetShow(false)
  for showIndex = 0, 1 do
    self._offenceGuildInfo_2[showIndex].stc_Bg:SetShow(false)
  end
  for showIndex = 0, 3 do
    self._offenceGuildInfo_4[showIndex].stc_Bg:SetShow(false)
  end
  self._isSiegeBeing = isSiegeBeing(self._selectedTerritoryKey)
  local siegeWrapper = ToClient_GetSiegeWrapper(self._selectedTerritoryKey)
  if nil == siegeWrapper then
    return
  end
  if true == self._isSiegeBeing then
    local guildCount = ToClient_SiegeGuildCount(self._selectedTerritoryKey)
    self:updateGuildScore(siegeWrapper, guildCount)
    if siegeWrapper:doOccupantExist() and nil ~= self._defenceGuildNo then
      guildCount = guildCount - 1
      self._ui.stc_LeftGuild_Bg:SetShow(true)
    else
      self._ui.stc_NoOccupantBg:SetShow(true)
    end
    if guildCount >= 5 or self._isConsole then
      self._ui.stc_RightGuild_Bg_list:SetShow(true)
    elseif guildCount <= 2 then
      self._ui.stc_RightGuild_Bg_2:SetShow(true)
    elseif guildCount <= 4 then
      self._ui.stc_RightGuild_Bg_4:SetShow(true)
    end
  else
    if true == siegeWrapper:doOccupantExist() then
      self._ui.txt_Finish_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE_END", "selectTerritoy", siegeWrapper:getTerritoryName()))
      local guildWrapper = ToClient_GetGuildWrapperByGuildNo(siegeWrapper:getGuildNo())
      local allianceName = ""
      if nil ~= guildWrapper then
        allianceName = guildWrapper:getAllianceName()
      end
      if "" == allianceName then
        self._ui.txt_Result_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      else
        self._ui.txt_Result_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_ALLIANCE_WARINFOCONTENTS_SETFREEDESC_END", "getName", siegeWrapper:getGuildName()))
      end
    else
      self._ui.txt_Finish_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREE", "selectTerritoy", siegeWrapper:getTerritoryName()))
      self._ui.txt_Result_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDWARINFO_WARINFOCONTENTS_SETFREEDESC"))
    end
    self._ui.stc_FinishBg:SetShow(true)
  end
end
function PaGlobal_GuildWarInfo_All:updateGuildScore(siegeWrapper, guildCount)
  local isDefenceGuild = false
  local rightGuildIndex = 0
  if nil == siegeWrapper then
    return
  end
  local rightGuildCount = guildCount
  if siegeWrapper:doOccupantExist() then
    rightGuildCount = rightGuildCount - 1
  end
  self._defenceGuildIndex = 999
  self._offenceGuildList:getElementManager():clearKey()
  for index = 0, guildCount - 1 do
    local guildWrapper = ToClient_SiegeGuildAt(self._selectedTerritoryKey, index)
    if nil == guildWrapper then
      return
    end
    if guildWrapper:getGuildNo_s64() == siegeWrapper:getGuildNo() then
      isDefenceGuild = true
      self._defenceGuildNo = guildWrapper:getGuildNo_s64()
      self._defenceGuildIndex = index
    else
      isDefenceGuild = false
      rightGuildIndex = index
      if index > self._defenceGuildIndex then
        rightGuildIndex = rightGuildIndex - 1
      end
      self._offenceGuildNoList[rightGuildIndex] = guildWrapper:getGuildNo_s64()
    end
    if (rightGuildCount >= 5 or self._isConsole) and false == isDefenceGuild then
      self._offenceGuildList:getElementManager():pushKey(toInt64(0, index))
    else
      local guildInfo
      if true == isDefenceGuild then
        guildInfo = self._defenceGuildInfo
      elseif rightGuildCount <= 2 then
        guildInfo = self._offenceGuildInfo_2[rightGuildIndex]
      elseif rightGuildCount <= 4 then
        guildInfo = self._offenceGuildInfo_4[rightGuildIndex]
      end
      if nil ~= guildInfo then
        self:setGuildInfo(guildInfo, guildWrapper, index)
      end
    end
  end
end
function PaGlobal_GuildWarInfo_All:setGuildInfo(guildInfo, guildWrapper, index)
  local index_32 = Int64toInt32(index)
  local siegeBuildingInfo = ToClient_SiegeGuildBuildingInfoAt(self._selectedTerritoryKey, index_32)
  if nil == siegeBuildingInfo then
    return
  end
  if nil == guildInfo then
    return
  end
  local guildAllianceName = guildWrapper:getAllianceName()
  if "" == guildAllianceName then
    guildInfo.txt_GuildName:SetText(guildWrapper:getName())
  else
    guildInfo.txt_GuildName:SetText(guildAllianceName)
  end
  if true == isDefence then
    local _posX = 171 - (guildInfo.txt_GuildName:GetSizeX() + guildInfo.txt_GuildName:GetTextSizeX()) / 2
    guildInfo.txt_GuildName:SetPosX(_posX)
  end
  guildInfo.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
  local isSet = false
  if true == guildWrapper:isAllianceGuild() then
    isSet = setGuildTextureByAllianceNo(guildWrapper:guildAllianceNo_s64(), guildInfo.stc_GuildIcon)
  else
    isSet = setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), guildInfo.stc_GuildIcon)
  end
  if false == isSet then
    guildInfo.stc_GuildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(guildInfo.stc_GuildIcon, 183, 1, 188, 6)
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  else
    guildInfo.stc_GuildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    guildInfo.stc_GuildIcon:setRenderTexture(guildInfo.stc_GuildIcon:getBaseTexture())
  end
  guildInfo.txt_Building:SetText(tostring(guildWrapper:getTotalSiegeCount(0)))
  guildInfo.txt_Member:SetText(tostring(guildWrapper:getTotalSiegeCount(1)))
  guildInfo.txt_Die:SetText(tostring(guildWrapper:getTotalSiegeCount(2)))
  guildInfo.txt_Vehicle:SetText(tostring(guildWrapper:getTotalSiegeCount(3)))
  local hpPercent = siegeBuildingInfo:getRemainHp() / 10000
  guildInfo.progress_Castle:SetProgressRate(hpPercent / 100 * 100)
  guildInfo.txt_CastleHp:SetText(tostring(hpPercent) .. "%")
  guildInfo.stc_Bg:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:selectTab(index)
  if true == PaGlobal_GuildWarInfo_All:IsRankClose() then
    local scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(index)
    local outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(index)
    if 0 == scoreRegionKey and 0 == outRegionKey then
      return
    end
  end
  self._selectedTerritoryKey = index
  if nil ~= self._ui.btn_Territory[self._selectedTerritoryKey] then
    self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(true)
    self._ui.stc_SelectLine:SetPosX(self._ui.btn_Territory[self._selectedTerritoryKey]:GetPosX() + self._ui.btn_Territory[self._selectedTerritoryKey]:GetSizeX() / 2 - self._ui.stc_SelectLine:GetSizeX() / 2)
  end
  if true == PaGlobal_GuildWarInfo_All:IsRankClose() then
    self:secondRoundRankOpen()
  else
    self:updateBasicInfo()
  end
end
function PaGlobal_GuildWarInfo_All:getIndexNextIndex(selectIndex, isRight)
  if true == isRight then
    for index = selectIndex + 1, self._MAXTERRITORYCOUNT - 1 do
      if true == ToClient_isStartMajorSiege(index) then
        return index
      end
    end
    for index = 0, selectIndex - 1 do
      if true == ToClient_isStartMajorSiege(index) then
        return index
      end
    end
  else
    for index = self._MAXTERRITORYCOUNT - 1, 0, -1 do
      if true == ToClient_isStartMajorSiege(index) then
        return index
      end
    end
    for index = selectIndex - 1, 0, -1 do
      if true == ToClient_isStartMajorSiege(index) then
        return index
      end
    end
  end
end
function PaGlobal_GuildWarInfo_All:changeTab(flag)
  local tabIndex = self._selectedTerritoryKey + flag
  if tabIndex >= self._MAXTERRITORYCOUNT then
    tabIndex = 0
  elseif tabIndex < 0 then
    tabIndex = self._MAXTERRITORYCOUNT - 1
  end
  if false == ToClient_isStartMajorSiege(tabIndex) then
    if flag > 0 then
      tabIndex = self:getIndexNextIndex(tabIndex, true)
    else
      tabIndex = self:getIndexNextIndex(tabIndex, false)
    end
  end
  self:selectTab(tabIndex)
end
function PaGlobal_GuildWarInfo_All:reload()
  if true == PaGlobal_GuildWarInfo_All:IsRankClose() then
    ToClient_RequestSiegeSecondRoundAllList()
  elseif 5 < self._guildWarInfoAll_UpdateTimer then
    ToClient_RequestSiegeScore(self._selectedTerritoryKey)
    self._guildWarInfoAll_UpdateTimer = 0
  end
end
function PaGlobal_GuildWarInfo_All:updatePerFrameFunc(deltaTime)
  self._guildWarInfoAll_UpdateTimer = self._guildWarInfoAll_UpdateTimer + deltaTime
  if self._guildWarInfoAll_UpdateTimer > 30 then
    ToClient_RequestSiegeScore(self._selectedTerritoryKey)
    self._guildWarInfoAll_UpdateTimer = 0
  end
end
function PaGlobal_GuildWarInfo_All:buttonInit()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  local padding = self._ui.btn_Territory[1]:GetPosX() - self._ui.btn_Territory[0]:GetPosX()
  local count = 0
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    if false == ToClient_isStartMajorSiege(index) then
      self._ui.btn_Territory[index]:SetShow(false)
      count = count + 1
    end
  end
  local showCount = self._MAXTERRITORYCOUNT - count
  local startPos = Panel_GuildWarInfo_All:GetSizeX() / 2 - padding * (showCount / 2)
  count = 0
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    if true == ToClient_isStartMajorSiege(index) then
      self._ui.btn_Territory[index]:SetPosX(startPos + padding * count)
      count = count + 1
    end
  end
end
function PaGlobal_GuildWarInfo_All:validate()
  if nil == Panel_GuildWarInfo_All then
    return
  end
  self._ui.stc_NoOccupantBg:isValidate()
  self._ui.stc_LeftGuild_Bg:isValidate()
  self._ui.stc_RightGuild_Bg_2:isValidate()
  self._ui.stc_RightGuild_Bg_4:isValidate()
  self._ui.stc_RightGuild_Bg_list:isValidate()
  self._ui.btn_Reload:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.btn_Small:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_TabBg:isValidate()
  self._ui.stc_SelectLine:isValidate()
  for index = 0, self._MAXTERRITORYCOUNT - 1 do
    self._ui.btn_Territory[index]:isValidate()
  end
  self._ui.stc_FinishBg:isValidate()
  self._ui.txt_Finish_Desc:isValidate()
  self._ui.txt_Result_Desc:isValidate()
  self._ui.stc_KeyGuide:isValidate()
end
function PaGlobal_GuildWarInfo_All:secondRoundRankToggle()
  if true == PaGlobal_GuildWarInfo_All:IsRankClose() then
    PaGlobal_GuildWarInfo_All:secondRoundRankClose()
    PaGlobal_GuildWarInfo_All:updateBasicInfo()
    return
  end
  ToClient_RequestSiegeSecondRoundAllList()
end
function PaGlobal_GuildWarInfo_All:secondRoundRankOpen()
  self._ui.stc_LeftGuild_Bg:SetShow(false)
  self._ui.stc_NoOccupantBg:SetShow(false)
  self._ui.stc_RightGuild_Bg_2:SetShow(false)
  self._ui.stc_RightGuild_Bg_4:SetShow(false)
  self._ui.stc_RightGuild_Bg_list:SetShow(false)
  self._ui.stc_FinishBg:SetShow(false)
  self._ui.stc_Score_No1:SetShow(false)
  self._ui.stc_Score_No2:SetShow(false)
  self._ui.stc_Score_LeftScore:SetShow(false)
  self._ui.stc_SiegeGuildList:SetShow(false)
  self._ui.stc_GuildList_No1:SetShow(false)
  self._ui.stc_GuildList:SetShow(false)
  self._isRankOpen = true
  local preTerritoryKey = self._selectedTerritoryKey
  local isSet = PaGlobal_GuildWarInfo_All:SetOpenTerritoryKey()
  if false == isSet then
    PaGlobal_GuildWarInfo_All:secondRoundRankClose()
    PaGlobal_GuildWarInfo_All:updateBasicInfo()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARINFO_POINT_NOTYET"))
    return
  end
  local scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local scorelistSize = ToClient_GetSiegeSecondRoundScoreAllListSize(scoreRegionKey)
  local outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(self._selectedTerritoryKey)
  local outlistSize = ToClient_GetSiegeSecondRoundOutAllListSize(outRegionKey)
  if 2 == scorelistSize + outlistSize then
    PaGlobal_GuildWarInfo_All:secondRoundTop2(scorelistSize, outlistSize)
  elseif 3 == scorelistSize + outlistSize then
    PaGlobal_GuildWarInfo_All:secondRoundTop3(scorelistSize, outlistSize)
  elseif scorelistSize + outlistSize > 3 then
    PaGlobal_GuildWarInfo_All:secondRoundOver(scorelistSize, outlistSize)
  else
    self._selectedTerritoryKey = preTerritoryKey
    PaGlobal_GuildWarInfo_All:secondRoundRankClose()
    PaGlobal_GuildWarInfo_All:updateBasicInfo()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARINFO_POINT_NOTYET"))
    return
  end
  if nil ~= self._ui.btn_Territory[self._selectedTerritoryKey] then
    self._ui.btn_Territory[self._selectedTerritoryKey]:SetCheck(true)
    self._ui.stc_SelectLine:SetPosX(self._ui.btn_Territory[self._selectedTerritoryKey]:GetPosX() + self._ui.btn_Territory[self._selectedTerritoryKey]:GetSizeX() / 2 - self._ui.stc_SelectLine:GetSizeX() / 2)
  end
end
function PaGlobal_GuildWarInfo_All:secondRoundRankClose()
  self._ui.stc_Score_No1:SetShow(false)
  self._ui.stc_Score_No2:SetShow(false)
  self._ui.stc_Score_LeftScore:SetShow(false)
  self._ui.stc_SiegeGuildList:SetShow(false)
  self._ui.stc_GuildList_No1:SetShow(false)
  self._ui.stc_GuildList:SetShow(false)
  self._isRankOpen = false
  if true == _ContentsGroup_SiegeSecondScore then
    self._ui.btn_Rank:SetShow(not self._isConsole)
  end
end
function PaGlobal_GuildWarInfo_All:updateSecondRoundRankList(content, index)
  local index_32 = Int64toInt32(index)
  local static2 = UI.getChildControl(content, "Static_No2")
  local txt_score = UI.getChildControl(static2, "StaticText_Score")
  local txt_guildName = UI.getChildControl(static2, "StaticText_Guild_Name")
  local txt_leaderName = UI.getChildControl(static2, "StaticText_Leader_Name")
  local stc_hp = UI.getChildControl(static2, "Static_Fortress")
  local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
  local stc_build = UI.getChildControl(static2, "Static_Cannnon")
  local txt_build = UI.getChildControl(stc_build, "StaticText_2")
  local stc_kill = UI.getChildControl(static2, "Static_Kill")
  local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
  local stc_death = UI.getChildControl(static2, "Static_Death")
  local txt_death = UI.getChildControl(stc_death, "StaticText_2")
  local isSiegeSecondRoundScoreList = true
  local scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local outRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local scorelistSize = ToClient_GetSiegeSecondRoundScoreAllListSize(scoreRegionKey)
  local realIndex = -1
  if index_32 >= scorelistSize then
    realIndex = index_32 - scorelistSize
    isSiegeSecondRoundScoreList = false
  else
    realIndex = index_32
    isSiegeSecondRoundScoreList = true
  end
  if realIndex < 0 then
    return
  end
  if true == isSiegeSecondRoundScoreList then
    local guildNo = ToClient_GetSiegeSecondRoundGuildNo(scoreRegionKey, realIndex)
    local hpScore = ToClient_GetSiegeSecondRoundHpScore(scoreRegionKey, realIndex)
    local buildScore = ToClient_GetSiegeSecondRoundBuildScore(scoreRegionKey, realIndex)
    local killScore = ToClient_GetSiegeSecondRoundKillScore(scoreRegionKey, realIndex)
    local deathScore = ToClient_GetSiegeSecondRoundDeathScore(scoreRegionKey, realIndex)
    local guildName = ToClient_GetSiegeSecondRoundGuildName(scoreRegionKey, realIndex)
    local masterName = ToClient_GetSiegeSecondRoundMasterName(scoreRegionKey, realIndex)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    local totalScore = hpScore + buildScore + killScore + deathScore
    totalScore = toInt64(0, totalScore)
    txt_score:SetText(makeDotMoney(totalScore))
    txt_hp:SetText(tostring(hpScore))
    txt_build:SetText(tostring(buildScore))
    txt_kill:SetText(tostring(killScore + deathScore))
  else
    local guildNo = ToClient_GetSiegeSecondRoundOutGuildNo(outRegionKey, realIndex)
    local guildName = ToClient_GetSiegeSecondRoundOutGuildName(outRegionKey, realIndex)
    local masterName = ToClient_GetSiegeSecondRoundOutGuildMasterName(outRegionKey, realIndex)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    txt_score:SetText("-")
    txt_hp:SetText("-")
    txt_build:SetText("-")
    txt_kill:SetText("-")
  end
  if 1 == index_32 then
    static2:ChangeTextureInfoName("Combine/Etc/Combine_Etc_TerritoryWar_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static2, 1, 194, 906, 289)
    static2:getBaseTexture():setUV(x1, y1, x2, y2)
    static2:setRenderTexture(static2:getBaseTexture())
  elseif 2 == index_32 then
    static2:ChangeTextureInfoName("Combine/Etc/Combine_Etc_TerritoryWar_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static2, 1, 290, 906, 385)
    static2:getBaseTexture():setUV(x1, y1, x2, y2)
    static2:setRenderTexture(static2:getBaseTexture())
  else
    static2:ChangeTextureInfoName("Combine/Etc/Combine_Etc_TerritoryWar_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static2, 907, 194, 1812, 289)
    static2:getBaseTexture():setUV(x1, y1, x2, y2)
    static2:setRenderTexture(static2:getBaseTexture())
  end
  content:SetShow(true)
end
function PaGlobal_GuildWarInfo_All:secondRoundTop2(scorelistSize, outlistSize)
  if 2 ~= scorelistSize + outlistSize then
    return
  end
  self._ui.stc_Score_No1:SetShow(true)
  self._ui.stc_Score_No2:SetShow(true)
  local regionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local currentRank = 1
  for index = 0, scorelistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_Score_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
    elseif 2 == currentRank then
      control = self._ui.stc_Score_No2
    else
      control = nil
    end
    if nil == control then
      return
    end
    local txt_score = UI.getChildControl(control, "StaticText_Score")
    local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
    local stc_leaderName = UI.getChildControl(control, "Static_Leader_Name")
    local txt_leaderName = UI.getChildControl(stc_leaderName, "StaticText_Leader_Name")
    local stc_total = UI.getChildControl(control, "Static_Total")
    local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
    local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
    local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
    local txt_build = UI.getChildControl(stc_build, "StaticText_2")
    local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
    local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
    local stc_death = UI.getChildControl(stc_total, "Static_Death")
    local txt_death = UI.getChildControl(stc_death, "StaticText_2")
    local guildNo = ToClient_GetSiegeSecondRoundGuildNo(regionKey, index)
    local hpScore = ToClient_GetSiegeSecondRoundHpScore(regionKey, index)
    local buildScore = ToClient_GetSiegeSecondRoundBuildScore(regionKey, index)
    local killScore = ToClient_GetSiegeSecondRoundKillScore(regionKey, index)
    local deathScore = ToClient_GetSiegeSecondRoundDeathScore(regionKey, index)
    local guildName = ToClient_GetSiegeSecondRoundGuildName(regionKey, index)
    local masterName = ToClient_GetSiegeSecondRoundMasterName(regionKey, index)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
      local middlePosX = txt_guildName:GetPosX() + txt_guildName:GetSizeX() * 0.5
      stc_leaderName:SetSize(txt_leaderName:GetTextSizeX() + txt_leaderName:GetSizeX(), stc_leaderName:GetSizeY())
      stc_leaderName:SetPosX(middlePosX - stc_leaderName:GetSizeX() * 0.5 - txt_leaderName:GetSizeX() * 0.5)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    local totalScore = hpScore + buildScore + killScore + deathScore
    totalScore = toInt64(0, totalScore)
    txt_score:SetText(makeDotMoney(totalScore))
    txt_hp:SetText(tostring(hpScore))
    txt_build:SetText(tostring(buildScore))
    txt_kill:SetText(tostring(killScore + deathScore))
    currentRank = currentRank + 1
  end
  regionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(self._selectedTerritoryKey)
  for index = 0, outlistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_Score_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
    elseif 2 == currentRank then
      control = self._ui.stc_Score_No2
    else
      control = nil
    end
    if nil == control then
      return
    end
    local txt_score = UI.getChildControl(control, "StaticText_Score")
    local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
    local stc_leaderName = UI.getChildControl(control, "Static_Leader_Name")
    local txt_leaderName = UI.getChildControl(stc_leaderName, "StaticText_Leader_Name")
    local stc_total = UI.getChildControl(control, "Static_Total")
    local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
    local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
    local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
    local txt_build = UI.getChildControl(stc_build, "StaticText_2")
    local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
    local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
    local stc_death = UI.getChildControl(stc_total, "Static_Death")
    local txt_death = UI.getChildControl(stc_death, "StaticText_2")
    local guildName = ToClient_GetSiegeSecondRoundOutGuildName(regionKey, index)
    local masterName = ToClient_GetSiegeSecondRoundOutGuildMasterName(regionKey, index)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
      local middlePosX = txt_guildName:GetPosX() + txt_guildName:GetSizeX() * 0.5
      stc_leaderName:SetSize(txt_leaderName:GetTextSizeX() + txt_leaderName:GetSizeX(), stc_leaderName:GetSizeY())
      stc_leaderName:SetPosX(middlePosX - stc_leaderName:GetSizeX() * 0.5 - txt_leaderName:GetSizeX() * 0.5)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    txt_score:SetText("-")
    txt_hp:SetText("-")
    txt_build:SetText("-")
    txt_kill:SetText("-")
    txt_death:SetText("-")
    currentRank = currentRank + 1
  end
  PaGlobal_GuildWarInfo_All:SetTerritoryTexture()
end
function PaGlobal_GuildWarInfo_All:secondRoundTop3(scorelistSize, outlistSize)
  if 3 ~= scorelistSize + outlistSize then
    return
  end
  self._ui.stc_Score_No1:SetShow(true)
  self._ui.stc_Score_LeftScore:SetShow(true)
  local regionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local currentRank = 1
  for index = 0, scorelistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_Score_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
    elseif 2 == currentRank then
      control = self._ui.stc_Score_LeftScore_No2
    elseif 3 == currentRank then
      control = self._ui.stc_Score_LeftScore_No3
    else
      control = nil
    end
    if nil == control then
      return
    end
    local txt_score = UI.getChildControl(control, "StaticText_Score")
    local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
    local stc_leaderName = UI.getChildControl(control, "Static_Leader_Name")
    local txt_leaderName = UI.getChildControl(stc_leaderName, "StaticText_Leader_Name")
    local stc_total = UI.getChildControl(control, "Static_Total")
    local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
    local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
    local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
    local txt_build = UI.getChildControl(stc_build, "StaticText_2")
    local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
    local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
    local stc_death = UI.getChildControl(stc_total, "Static_Death")
    local txt_death = UI.getChildControl(stc_death, "StaticText_2")
    local guildNo = ToClient_GetSiegeSecondRoundGuildNo(regionKey, index)
    local hpScore = ToClient_GetSiegeSecondRoundHpScore(regionKey, index)
    local buildScore = ToClient_GetSiegeSecondRoundBuildScore(regionKey, index)
    local killScore = ToClient_GetSiegeSecondRoundKillScore(regionKey, index)
    local deathScore = ToClient_GetSiegeSecondRoundDeathScore(regionKey, index)
    local guildName = ToClient_GetSiegeSecondRoundGuildName(regionKey, index)
    local masterName = ToClient_GetSiegeSecondRoundMasterName(regionKey, index)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
      local middlePosX = txt_guildName:GetPosX() + txt_guildName:GetSizeX() * 0.5
      stc_leaderName:SetSize(txt_leaderName:GetTextSizeX() + txt_leaderName:GetSizeX(), stc_leaderName:GetSizeY())
      stc_leaderName:SetPosX(middlePosX - stc_leaderName:GetSizeX() * 0.5 - txt_leaderName:GetSizeX() * 0.5)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    local totalScore = hpScore + buildScore + killScore + deathScore
    totalScore = toInt64(0, totalScore)
    txt_score:SetText(makeDotMoney(totalScore))
    txt_hp:SetText(tostring(hpScore))
    txt_build:SetText(tostring(buildScore))
    txt_kill:SetText(tostring(killScore + deathScore))
    currentRank = currentRank + 1
  end
  regionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(self._selectedTerritoryKey)
  for index = 0, outlistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_Score_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
    elseif 2 == currentRank then
      control = self._ui.stc_Score_LeftScore_No2
    elseif 3 == currentRank then
      control = self._ui.stc_Score_LeftScore_No3
    else
      control = nil
    end
    if nil == control then
      return
    end
    local txt_score = UI.getChildControl(control, "StaticText_Score")
    local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
    local stc_leaderName = UI.getChildControl(control, "Static_Leader_Name")
    local txt_leaderName = UI.getChildControl(stc_leaderName, "StaticText_Leader_Name")
    local stc_total = UI.getChildControl(control, "Static_Total")
    local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
    local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
    local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
    local txt_build = UI.getChildControl(stc_build, "StaticText_2")
    local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
    local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
    local stc_death = UI.getChildControl(stc_total, "Static_Death")
    local txt_death = UI.getChildControl(stc_death, "StaticText_2")
    local guildName = ToClient_GetSiegeSecondRoundOutGuildName(regionKey, index)
    local masterName = ToClient_GetSiegeSecondRoundOutGuildMasterName(regionKey, index)
    if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
      txt_guildName:SetText(guildName)
      txt_leaderName:SetText(masterName)
      local middlePosX = txt_guildName:GetPosX() + txt_guildName:GetSizeX() * 0.5
      stc_leaderName:SetSize(txt_leaderName:GetTextSizeX() + txt_leaderName:GetSizeX(), stc_leaderName:GetSizeY())
      stc_leaderName:SetPosX(middlePosX - stc_leaderName:GetSizeX() * 0.5 - txt_leaderName:GetSizeX() * 0.5)
    else
      txt_guildName:SetText("-")
      txt_leaderName:SetText("-")
    end
    txt_score:SetText("-")
    txt_hp:SetText("-")
    txt_build:SetText("-")
    txt_kill:SetText("-")
    txt_death:SetText("-")
    currentRank = currentRank + 1
  end
  PaGlobal_GuildWarInfo_All:SetTerritoryTexture()
end
function PaGlobal_GuildWarInfo_All:secondRoundOver(scorelistSize, outlistSize)
  if scorelistSize + outlistSize <= 3 then
    return
  end
  self._ui.stc_SiegeGuildList:SetShow(true)
  self._ui.stc_GuildList_No1:SetShow(true)
  self._ui.stc_GuildList:SetShow(true)
  self._ui.stc_GuildList:getElementManager():clearKey()
  local currentRank = 1
  local listIndex = 0
  local regionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  for index = 0, scorelistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_GuildList_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
      listIndex = listIndex + 1
    else
      self._ui.stc_GuildList:getElementManager():pushKey(toInt64(0, listIndex))
      listIndex = listIndex + 1
    end
    if nil ~= control then
      local txt_score = UI.getChildControl(control, "StaticText_Score")
      local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
      local txt_leaderName = UI.getChildControl(control, "StaticText_Leader_Name")
      local stc_total = UI.getChildControl(control, "Static_Total")
      local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
      local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
      local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
      local txt_build = UI.getChildControl(stc_build, "StaticText_2")
      local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
      local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
      local stc_death = UI.getChildControl(stc_total, "Static_Death")
      local txt_death = UI.getChildControl(stc_death, "StaticText_2")
      local guildNo = ToClient_GetSiegeSecondRoundGuildNo(regionKey, index)
      local hpScore = ToClient_GetSiegeSecondRoundHpScore(regionKey, index)
      local buildScore = ToClient_GetSiegeSecondRoundBuildScore(regionKey, index)
      local killScore = ToClient_GetSiegeSecondRoundKillScore(regionKey, index)
      local deathScore = ToClient_GetSiegeSecondRoundDeathScore(regionKey, index)
      local guildName = ToClient_GetSiegeSecondRoundGuildName(regionKey, index)
      local masterName = ToClient_GetSiegeSecondRoundMasterName(regionKey, index)
      if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
        txt_guildName:SetText(guildName)
        txt_leaderName:SetText(masterName)
      else
        txt_guildName:SetText("-")
        txt_leaderName:SetText("-")
      end
      local totalScore = hpScore + buildScore + killScore + deathScore
      totalScore = toInt64(0, totalScore)
      txt_score:SetText(makeDotMoney(totalScore))
      txt_hp:SetText(tostring(hpScore))
      txt_build:SetText(tostring(buildScore))
      txt_kill:SetText(tostring(killScore + deathScore))
    end
    currentRank = currentRank + 1
  end
  regionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(self._selectedTerritoryKey)
  for index = 0, outlistSize - 1 do
    local control
    if 1 == currentRank then
      control = self._ui.stc_GuildList_No1
      PaGlobal_GuildWarInfo_All:SetRankNo1(control)
      listIndex = listIndex + 1
    else
      self._ui.stc_GuildList:getElementManager():pushKey(toInt64(0, listIndex))
      listIndex = listIndex + 1
    end
    if nil ~= control then
      local txt_score = UI.getChildControl(control, "StaticText_Score")
      local txt_guildName = UI.getChildControl(control, "StaticText_Guild_Name")
      local txt_leaderName = UI.getChildControl(control, "StaticText_Leader_Name")
      local stc_total = UI.getChildControl(control, "Static_Total")
      local stc_hp = UI.getChildControl(stc_total, "Static_Fortress")
      local txt_hp = UI.getChildControl(stc_hp, "StaticText_2")
      local stc_build = UI.getChildControl(stc_total, "Static_Cannnon")
      local txt_build = UI.getChildControl(stc_build, "StaticText_2")
      local stc_kill = UI.getChildControl(stc_total, "Static_Kill")
      local txt_kill = UI.getChildControl(stc_kill, "StaticText_2")
      local stc_death = UI.getChildControl(stc_total, "Static_Death")
      local txt_death = UI.getChildControl(stc_death, "StaticText_2")
      local guildName = ToClient_GetSiegeSecondRoundOutGuildName(regionKey, index)
      local masterName = ToClient_GetSiegeSecondRoundOutGuildMasterName(regionKey, index)
      if nil ~= guildName and "" ~= guildName and (nil ~= masterName or "" ~= masterName) then
        txt_guildName:SetText(guildName)
        txt_leaderName:SetText(masterName)
      else
        txt_guildName:SetText("-")
        txt_leaderName:SetText("-")
      end
      txt_score:SetText("-")
      txt_hp:SetText("-")
      txt_build:SetText("-")
      txt_kill:SetText("-")
      txt_death:SetText("-")
    end
    currentRank = currentRank + 1
  end
  PaGlobal_GuildWarInfo_All:SetTerritoryTexture()
end
function PaGlobal_GuildWarInfo_All:IsRankClose()
  if true == self._isRankOpen then
    return true
  end
  return false
end
function PaGlobal_GuildWarInfo_All:SetRankNo1(control)
  if nil == control then
    return
  end
  local stc_Title_Kal = UI.getChildControl(control, "StaticText_Title_Kal")
  local stc_Title_Med = UI.getChildControl(control, "StaticText_Title_Med")
  local stc_Title_Bal = UI.getChildControl(control, "StaticText_Title_Bal")
  stc_Title_Kal:SetShow(false)
  stc_Title_Med:SetShow(false)
  stc_Title_Bal:SetShow(false)
  if true == isSiegeBeing(self._selectedTerritoryKey) then
    return
  end
  if 4 == self._selectedTerritoryKey then
    stc_Title_Bal:SetShow(true)
  elseif 2 == self._selectedTerritoryKey then
    stc_Title_Kal:SetShow(true)
  elseif 3 == self._selectedTerritoryKey then
    stc_Title_Med:SetShow(true)
  end
end
function PaGlobal_GuildWarInfo_All:SetOpenTerritoryKey()
  local scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(self._selectedTerritoryKey)
  local outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(self._selectedTerritoryKey)
  if 0 ~= scoreRegionKey or 0 ~= outRegionKey then
    return true
  end
  scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(2)
  outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(2)
  if 0 ~= scoreRegionKey or 0 ~= outRegionKey then
    self._selectedTerritoryKey = 2
    return true
  end
  scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(3)
  outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(3)
  if 0 ~= scoreRegionKey or 0 ~= outRegionKey then
    self._selectedTerritoryKey = 3
    return true
  end
  scoreRegionKey = ToClient_GetSiegeSecondRoundScoreAllListRegionKey(4)
  outRegionKey = ToClient_GetSiegeSecondRoundOutAllListRegionKey(4)
  if 0 ~= scoreRegionKey or 0 ~= outRegionKey then
    self._selectedTerritoryKey = 4
    return true
  end
  return false
end
function PaGlobal_GuildWarInfo_All:SetTerritoryTexture()
  if 4 == self._selectedTerritoryKey then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No1, 1, 1625, 465, 2198)
    self._ui.stc_Score_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No1:setRenderTexture(self._ui.stc_Score_No1:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No2, 466, 1625, 929, 2198)
    self._ui.stc_Score_No2:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No2:setRenderTexture(self._ui.stc_Score_No2:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildList_No1, 930, 1051, 1858, 1243)
    self._ui.stc_GuildList_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_GuildList_No1:setRenderTexture(self._ui.stc_GuildList_No1:getBaseTexture())
  elseif 2 == self._selectedTerritoryKey then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No1, 1, 477, 465, 1050)
    self._ui.stc_Score_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No1:setRenderTexture(self._ui.stc_Score_No1:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No2, 466, 477, 929, 1050)
    self._ui.stc_Score_No2:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No2:setRenderTexture(self._ui.stc_Score_No2:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildList_No1, 1, 1, 929, 193)
    self._ui.stc_GuildList_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_GuildList_No1:setRenderTexture(self._ui.stc_GuildList_No1:getBaseTexture())
  elseif 3 == self._selectedTerritoryKey then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No1, 1, 1051, 465, 1624)
    self._ui.stc_Score_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No1:setRenderTexture(self._ui.stc_Score_No1:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Score_No2, 466, 1051, 929, 1624)
    self._ui.stc_Score_No2:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Score_No2:setRenderTexture(self._ui.stc_Score_No2:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_GuildList_No1, 930, 1244, 1858, 1436)
    self._ui.stc_GuildList_No1:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_GuildList_No1:setRenderTexture(self._ui.stc_GuildList_No1:getBaseTexture())
  end
end
