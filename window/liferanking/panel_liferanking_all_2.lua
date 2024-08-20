function HandleEvent_LifeRanking_RePos()
  if nil == Panel_LifeRanking_All then
    return
  end
  Panel_LifeRanking_All:ComputePos()
end
function HandleEvent_LifeRanking_MoveTab(value)
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All:moveTabIndex(value)
end
function HandleEvent_LifeRanking_ShowXboxProfile(index)
  if nil == Panel_LifeRanking_All then
    return
  end
  local lifeRanker = PaGlobal_LifeRanking_All:GetLifeRankerAt(index)
  local xuid = lifeRanker:getXuid()
  if nil == xuid or "" == xuid then
    return
  end
  ToClient_showXboxFriendProfile(xuid)
end
function HandleEvent_LifeRanking_ShowNameToggle()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All._isFamilyNameShow = not PaGlobal_LifeRanking_All._isFamilyNameShow
  if PaGlobal_LifeRanking_All._isFamilyNameShow then
    PaGlobal_LifeRanking_All._ui.txt_CharacterNameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_CHARACTERCREATE1_STCTXT_FAMILYNAMETITLE") .. "(" .. ToClient_ConsoleUserNameString() .. ")")
  else
    PaGlobal_LifeRanking_All._ui.txt_CharacterNameTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATOPTION_NAMEDISPLAY_CHARNAME") .. "(" .. ToClient_ConsoleUserNameString() .. ")")
  end
  for listIdx = 0, PaGlobal_LifeRanking_All._listCount do
    local lifeRanker = PaGlobal_LifeRanking_All:GetLifeRankerAt(listIdx)
    if nil ~= lifeRanker then
      local lifeRankerLv = PaGlobal_LifeRanking_All:GetLifeRankerLv(lifeRanker, PaGlobal_LifeRanking_All._selectedTabIdx)
      if 0 == lifeRankerLv then
        break
      end
      PaGlobal_LifeRanking_All._ui.list2_Ranking:requestUpdateByKey(toInt64(0, listIdx))
    end
  end
  PaGlobal_LifeRanking_All:NameTooltip(PaGlobal_LifeRanking_All._currentTooltipIndex)
end
function FromClient_LifeRanking_ShowContentsRank_All(contentsRankType)
  if nil == Panel_LifeRanking_All or nil == contentsRankType then
    return
  end
  PaGloabl_LifeRanking_UpdateAndShow_All()
end
function FromClient_LifeRanking_Refresh_All()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All._serverChange = true
end
function FromClient_LifeRanking_Update_All()
  if nil == Panel_LifeRanking_All then
    return
  end
  if false == PaGlobal_LifeRanking_All._listUpdate[PaGlobal_LifeRanking_All._selectedTabIdx] then
    PaGlobal_LifeRanking_All:RequestLifeRank(PaGlobal_LifeRanking_All._selectedTabIdx)
    PaGlobal_LifeRanking_All._listUpdate[PaGlobal_LifeRanking_All._selectedTabIdx] = true
  else
    PaGlobal_LifeRanking_All:update()
  end
end
function FromClient_LifeRanking_Update_GuildCacheData(targetGuildNo)
  if nil == Panel_LifeRanking_All then
    return
  end
  if false == Panel_LifeRanking_All:GetShow() then
    return
  end
  if false == targetGuildNo:isDefined() then
    return
  end
  PaGlobal_LifeRanking_All:updateCurrentTabGuildData(targetGuildNo)
end
function PaGloabl_LifeRanking_ShowAni()
  if nil == Panel_LifeRanking_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_LifeRanking_All)
  local aniInfo1 = Panel_LifeRanking_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.2)
  aniInfo1.AxisX = Panel_LifeRanking_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_LifeRanking_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_LifeRanking_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.2)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_LifeRanking_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_LifeRanking_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGloabl_LifeRanking_HideAni()
  if nil == Panel_LifeRanking_All then
    return
  end
  local aniInfo1 = Panel_LifeRanking_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGloabl_LifeRanking_UpdateAndShow_All()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All:update()
  PaGlobal_LifeRanking_All:open()
end
function PaGlobal_LifeRanking_Open_All()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All:prepareOpen()
end
function PaGlobal_LifeRanking_Close_All()
  if nil == Panel_LifeRanking_All then
    return
  end
  PaGlobal_LifeRanking_All:prepareClose()
end
Panel_LifeRanking_All:RegisterShowEventFunc(true, "PaGloabl_LifeRanking_ShowAni()")
Panel_LifeRanking_All:RegisterShowEventFunc(false, "PaGloabl_LifeRanking_HideAni()")
function HandleEventOnOut_LifeRanking_CategoryNameTooltip(idx, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(PaGlobal_LifeRanking_All._ui.stc_RankingIcons[idx], PaGlobal_LifeRanking_All._tabName[idx])
end
