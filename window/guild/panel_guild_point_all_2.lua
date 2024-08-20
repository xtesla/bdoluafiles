function PaGlobal_Guild_Point_Close()
  if nil == Panel_Guild_Point then
    return
  end
  PaGlobal_Guild_Point:prepareClose()
end
function PaGlobal_Guild_Point_Open()
  if nil == Panel_Guild_Point then
    return
  end
  PaGlobal_Guild_Point:prepareOpen()
end
function FromClient_GuildPointImformation(guildNo, guildPoint, territoryKey)
  if nil == Panel_Guild_Point then
    return
  end
  if PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey] == territoryKey then
    PaGlobal_Guild_Point:update()
  end
end
function FromClient_ChangeInvestImformation(territoryKey)
  if nil == Panel_Guild_Point then
    return
  end
  if PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey] == territoryKey then
    PaGlobal_Guild_Point:update()
  end
end
function FromClient_ShowGuildPolicy(isApplicationTime)
  PaGlobal_Guild_Point._isApplicationTime = isApplicationTime
  PaGlobal_Guild_Point_Open()
end
function PaGlobalFunc_PaGlobal_Guild_Point_CreateSkillContent(content, key)
  if nil == Panel_Guild_Point then
    return
  end
  PaGlobal_Guild_Point:createSkillControl(content, key)
end
function PaGlobalFunc_PaGlobal_Guild_Point_ChangeDirect(isOpened)
  if nil == Panel_Guild_Point then
    return
  end
  if false == isOpened then
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 89, 434, 117, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 118, 434, 146, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 147, 434, 175, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    PaGlobal_Guild_Point._ui.btn_timeLog:setRenderTexture(PaGlobal_Guild_Point._ui.btn_timeLog:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 117, 434, 89, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 146, 434, 118, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(PaGlobal_Guild_Point._ui.btn_timeLog, 175, 434, 147, 462)
    PaGlobal_Guild_Point._ui.btn_timeLog:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    PaGlobal_Guild_Point._ui.btn_timeLog:setRenderTexture(PaGlobal_Guild_Point._ui.btn_timeLog:getBaseTexture())
  end
end
function HandleEventLUp_PaGlobal_Guild_Point_SelectTerritory(index)
  if nil == Panel_Guild_Point then
    return
  end
  if index ~= PaGlobal_Guild_Point._selectTerritoryKey then
    local cellTable = getTerritoryWarSkillTree(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey])
    local content = PaGlobal_Guild_Point._ui.frame_Skill:GetFrameContent()
    PaGlobal_Guild_Point:resetSkillTreeControl(cellTable, content, PaGlobal_Guild_Point.slots)
    local vScroll = PaGlobal_Guild_Point._ui.frame_Skill:GetVScroll()
    vScroll:SetControlPos(0)
    PaGlobal_Guild_Point._selectTerritoryKey = index
    PaGlobal_Guild_Point:setData(index)
  end
  PaGlobal_GuildPoint_SkillLog_Close()
  PaGlobal_Guild_Point:update()
end
function InputEventMOnOut_PaGlobal_Guild_Point_ShowSkillTooltip(skillNo, SlotType, isShow)
  if nil == Panel_Guild_Point then
    return
  end
  if false == isShow then
    PaGlobal_Guild_Point:openMouseGuide(isShow)
    Panel_SkillTooltip_Hide()
    return
  end
  Panel_SkillTooltip_Show(skillNo, false, SlotType)
  PaGlobal_Guild_Point.slots[skillNo].icon:EraseAllEffect()
  PaGlobal_Guild_Point:openMouseGuide(isShow)
end
function HandleEventLUp_PaGlobal_Guild_Point_OpenActiveTimeLine()
  if nil == Panel_Guild_Point then
    return
  end
  PaGlobal_GuildPoint_SkillLog_Open(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey])
end
function HandleEventLUp_PaGlobal_Guild_Point_InvestSkill(skillNo)
  if nil == Panel_Guild_Point then
    return
  end
  ToClient_InvestGuildPointBySkillNo(skillNo)
end
function HandleEventLUp_PaGlobal_Guild_Point_CantInvestSkill()
  if nil == Panel_Guild_Point then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil ~= selfPlayerWrapper then
    local occupyGuildNo = Int64toInt32(ToClient_RequestTerritoryGuildNo(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey]))
    local guildNo = Int64toInt32(selfPlayerWrapper:getGuildNo_s64())
    local alliacneNo = Int64toInt32(selfPlayerWrapper:getGuildAllianceNo_s64())
    if 0 == guildNo and 0 == alliacneNo or 0 ~= alliacneNo and occupyGuildNo ~= alliacneNo or 0 ~= guildNo and occupyGuildNo ~= guildNo then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoGuildHasntAuthority"))
      return
    end
  end
  if true == PaGlobal_Guild_Point._isApplicationTime then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotGuildPolicyTime"))
    return
  end
  local isHaveAuthorityInvestGuildPolicy = ToClient_GetHaveAuthorityInvestGuildPoint(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey])
  if true == isHaveAuthorityInvestGuildPolicy then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POLICY_MSG_LOWLEVEL"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoGuildHasntAuthority"))
  end
end
function HandleEventLUp_PaGlobal_Guild_Point_CancelInvestSkill(skillNo)
  if nil == Panel_Guild_Point then
    return
  end
  ToClient_CancelInvestImformation(skillNo)
end
function HandleEventLUp_Guild_Vote()
  if nil == Panel_Guild_Point then
    return
  end
  local guildNo = ToClient_RequestTerritoryGuildNo(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey])
  local territoryGuildName = ""
  local guildInfo = ToClient_GetGuildAllianceWrapperbyNo(guildNo)
  if nil ~= guildInfo then
    territoryGuildName = guildInfo:getRepresentativeName()
  else
    guildInfo = ToClient_GetGuildWrapperByGuildNo(guildNo)
    if nil ~= guildInfo then
      territoryGuildName = guildInfo:getName()
    end
  end
  if nil == guildInfo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSiegeOccupantIsEmpty"))
    return
  end
  local territoryName = getTerritoryNameByKey(getTerritoryByIndex(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey]))
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_POLICY_VOTE_POPUP_DESC", "guild", territoryGuildName, "territory", territoryName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_POLICY_VOTE_POPUP_TITLE"),
    content = messageBoxMemo,
    functionYes = PaGloabl_PaGlobal_Guild_Point_Vote_To_Territory,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_Guild_Vote_Refresh()
  if nil == Panel_Guild_Point then
    return
  end
  ToClient_VoteCountRefresh(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey])
end
function FromClient_ChangeVoteResult(territoryKey)
  PaGlobal_Guild_Point:setVoteResult(territoryKey)
end
function FromClient_PaGlobal_Guild_Point_updateAppleList(param1)
  if nil == Panel_Guild_Point then
    return
  end
end
function PaGloabl_PaGlobal_Guild_Point_Vote_To_Territory()
  if nil == Panel_Guild_Point then
    return
  end
  ToClient_VoteToTerritory(PaGlobal_Guild_Point.territoryIndex[PaGlobal_Guild_Point._selectTerritoryKey], true)
end
function PaGloabl_PaGlobal_Guild_Point_ShowAni()
  if nil == Panel_Guild_Point then
    return
  end
end
function PaGloabl_PaGlobal_Guild_Point_HideAni()
  if nil == Panel_Guild_Point then
    return
  end
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
