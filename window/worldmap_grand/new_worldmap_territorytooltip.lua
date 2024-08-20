local const_lineGap = 5
local const_lineSpanUp = 10
local const_lineSpanDown = 20
local territoryName = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_Title")
local territoryInfoScetion = {
  territoryTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_SiteInfoTItle"),
  territoryIcon = UI.getChildControl(Panel_Worldmap_Territory, "Static_SiteIcon"),
  cityName = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_CityName"),
  userRate = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_UserRate"),
  taxTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_TaxRateInfoTitle"),
  taxTransfer = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_TransferTax"),
  sectionBG = UI.getChildControl(Panel_Worldmap_Territory, "Static_TerritoryInfoBG")
}
local occupyGuildSection = {
  sectionTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupiersInfoTitle"),
  guildIcon = UI.getChildControl(Panel_Worldmap_Territory, "Static_GuildIcon"),
  guildIconBG = UI.getChildControl(Panel_Worldmap_Territory, "Static_GuildIconBG"),
  guildName = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationGuild"),
  guildOwner = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationOwner"),
  occupyDate = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationDate"),
  occupyWeek = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationWeek"),
  occupyEffect = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationEffect"),
  line_2 = UI.getChildControl(Panel_Worldmap_Territory, "Static_TerritoryInfoLine_2"),
  sectionBG = UI.getChildControl(Panel_Worldmap_Territory, "Static_OccupiersInfoBG")
}
local occupyBenefit = {
  sectionBG = UI.getChildControl(Panel_Worldmap_Territory, "Static_OccupyBenefitBg"),
  sectionTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupyTitle"),
  sectionDesc = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupyDesc"),
  line_3 = UI.getChildControl(Panel_Worldmap_Territory, "Static_TerritoryInfoLine_3")
}
occupyBenefit.sectionDesc:SetTextMode(__eTextMode_AutoWrap)
local commonInfoSection = {
  playerInfoTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_PlayerInfoTitle"),
  playerPopular = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_Reputation"),
  warInfoTitle = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_OccupationInfoTitle"),
  warInfo = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_WarInfo"),
  volunteerInfo = UI.getChildControl(Panel_Worldmap_Territory, "StaticText_Volunteer"),
  sectionBG = UI.getChildControl(Panel_Worldmap_Territory, "Static_InformationBG")
}
local limitPanel = UI.getChildControl(Panel_Worldmap_Territory, "Static_StatLimit")
local limitPanelBG = UI.getChildControl(limitPanel, "Static_Black_BG")
local limitStat = {
  _init = false,
  _panel = limitPanel,
  _bg = limitPanelBG,
  _title = UI.getChildControl(limitPanel, "StaticText_TitleBar"),
  _limitDD = UI.getChildControl(limitPanelBG, "StaticText_Att_Title"),
  _limitMyDD = UI.getChildControl(limitPanelBG, "StaticText_Att_Mystat"),
  _limitDV = UI.getChildControl(limitPanelBG, "StaticText_HDV_Title"),
  _limitMyDV = UI.getChildControl(limitPanelBG, "StaticText_HDV_Mystat"),
  _limitDVRate = UI.getChildControl(limitPanelBG, "StaticText_HDV_Title_1"),
  _limitMyDVRate = UI.getChildControl(limitPanelBG, "StaticText_HDV_1_Mystat"),
  _limitPV = UI.getChildControl(limitPanelBG, "StaticText_HPV_Title"),
  _limitMyPV = UI.getChildControl(limitPanelBG, "StaticText_HPV_Mystat"),
  _limitDamageReduce = UI.getChildControl(limitPanelBG, "StaticText_HPVP_Title"),
  _limitMyDamageReduce = UI.getChildControl(limitPanelBG, "StaticText_HPVP_Mystat"),
  _limitHit = UI.getChildControl(limitPanelBG, "StaticText_Hit_Title"),
  _limitMyHit = UI.getChildControl(limitPanelBG, "StaticText_Hit_Mystat"),
  _limitHitRate = UI.getChildControl(limitPanelBG, "StaticText_Hit_1_Title"),
  _limitMyHitRate = UI.getChildControl(limitPanelBG, "StaticText_Hit_1_Mystat"),
  _limitResist = UI.getChildControl(limitPanelBG, "StaticText_Reg_Title"),
  _limitMyResist = UI.getChildControl(limitPanelBG, "StaticText_Reg_Mystat"),
  _desc = UI.getChildControl(limitPanelBG, "StaticText_Desc"),
  _limitDDPosY = 0,
  _limitMyDDPosY = 0,
  _limitDVPosY = 0,
  _limitMyDVPosY = 0,
  _limitDVRatePosY = 0,
  _limitMyDVRatePosY = 0,
  _limitPVPosY = 0,
  _limitMyPVPosY = 0,
  _limitMyDamageReducePosY = 0,
  _limitHitPosY = 0,
  _limitMyHitPosY = 0,
  _limitHitRatePosY = 0,
  _limitMyHitRatePosY = 0,
  _limitResistPosY = 0,
  _limitMyResistPosY = 0,
  _descPosY = 0,
  _defaultPanelSizeY = 0,
  _defaultBgSizeY = 0,
  _defaultTextSizeY = 26,
  _defaultDescSizeY = 52
}
local alianceInfoPanel = UI.getChildControl(Panel_Worldmap_Territory, "Static_Alli_Info")
local alianceInfoPanelBG = UI.getChildControl(alianceInfoPanel, "Static_Black_BG")
local alianceInfoTooltip = {
  _init = false,
  _stc_allianceInfo = alianceInfoPanel,
  _stc_allianceInfoBG = alianceInfoPanelBG,
  _stc_allianceLeader = UI.getChildControl(alianceInfoPanelBG, "Static_GuildInfo_Leader"),
  _stc_guildTemplate = UI.getChildControl(alianceInfoPanelBG, "Static_GuildInfo_Normal"),
  _stc_guildList = {},
  _MAX_MEMBER_COUNT = 9
}
function territoryInfoScetion:SetShow(isShow)
  self.territoryTitle:SetShow(isShow)
  self.territoryIcon:SetShow(isShow)
  self.cityName:SetShow(isShow)
  self.userRate:SetShow(isShow)
  self.taxTitle:SetShow(isShow)
  self.taxTransfer:SetShow(isShow)
  self.sectionBG:SetShow(isShow)
end
function territoryInfoScetion:SetInfo(territoryInfo, territoryKeyRaw)
  local imagePath = ToClient_getTerritoryImageName(territoryInfo)
  self.territoryIcon:ChangeTextureInfoName(imagePath)
  local siegeWrapper = ToClient_GetSiegeWrapper(territoryKeyRaw)
  if nil ~= siegeWrapper then
    self.cityName:SetText(siegeWrapper:getRegionAreaName())
  end
  local affiliatedUserRate = ToClient_getAffiliatedUserRate(territoryInfo)
  local affiliatedUserRateStr = PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_POPULATIONDENSITY")
  if affiliatedUserRate >= 0 and affiliatedUserRate <= 20 then
    affiliatedUserRateStr = affiliatedUserRateStr .. " <PAColor0xFFFF4C4C>" .. PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_LACK") .. "<PAOldColor> (" .. string.format("%d", affiliatedUserRate) .. "%)"
  elseif affiliatedUserRate > 20 and affiliatedUserRate <= 40 then
    affiliatedUserRateStr = affiliatedUserRateStr .. " <PAColor0xFFFF874C>" .. PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_LOW") .. "<PAOldColor> (" .. string.format("%d", affiliatedUserRate) .. "%)"
  elseif affiliatedUserRate > 40 and affiliatedUserRate <= 60 then
    affiliatedUserRateStr = affiliatedUserRateStr .. " <PAColor0xFFAEFF9B>" .. PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_NORMAL") .. "<PAOldColor> (" .. string.format("%d", affiliatedUserRate) .. "%)"
  elseif affiliatedUserRate > 60 and affiliatedUserRate <= 80 then
    affiliatedUserRateStr = affiliatedUserRateStr .. " <PAColor0xFF9B9BFF>" .. PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_HIGH") .. "<PAOldColor> (" .. string.format("%d", affiliatedUserRate) .. "%)"
  elseif affiliatedUserRate > 80 and affiliatedUserRate <= 100 then
    affiliatedUserRateStr = affiliatedUserRateStr .. " <PAColor0xFF8737FF>" .. PAGetString(Defines.StringSheet_GAME, "LUA_LORDMENU_POPULATIONDENSITY_EXPLOSION") .. "<PAOldColor> (" .. string.format("%d", affiliatedUserRate) .. "%)"
  end
  self.userRate:SetText(affiliatedUserRateStr)
  self.userRate:SetShow(false)
  local taxrate = siegeWrapper:getTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  siegeWrapper:getTaxRateForFortress(CppEnums.TaxType.eTaxTypeSellItemToItemMarket)
  self.taxTransfer:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_LOCAL_TAX") .. " : " .. string.format("%d", taxrate) .. "%")
end
function occupyGuildSection:SetShow(isShow)
  self.sectionTitle:SetShow(isShow)
  self.guildIcon:SetShow(isShow)
  self.guildIconBG:SetShow(isShow)
  self.guildName:SetShow(isShow)
  self.guildOwner:SetShow(isShow)
  self.occupyDate:SetShow(isShow)
  self.occupyWeek:SetShow(isShow)
  self.line_2:SetShow(isShow)
  self.sectionBG:SetShow(isShow)
  if true == _ContentsGroup_MajorSiege_AddMaxHp then
    self.occupyEffect:SetShow(isShow)
  else
    self.occupyEffect:SetShow(false)
  end
end
function occupyGuildSection:SetInfo(territoryInfo, territoryKeyRaw)
  local siegeWrapper = ToClient_GetSiegeWrapper(territoryKeyRaw)
  local occupyWeekValue = ToClient_GetAccumulatedOccupiedCountByWeek(territoryKeyRaw)
  local isSet = ToClient_setGuildTexture(territoryInfo, self.guildIcon)
  if isSet then
    self.guildIcon:SetAlpha(1)
  else
    self.guildIcon:ChangeTextureInfoName("New_UI_Common_forLua/Default/BlankGuildMark.dds")
    self.guildIcon:SetAlpha(0)
  end
  local overSizeX = 0
  self.guildName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_GUILD") .. " : " .. siegeWrapper:getGuildName())
  if Panel_Worldmap_Territory:GetSizeX() < self.guildName:GetPosX() + self.guildName:GetTextSizeX() then
    self.guildName:SetTextMode(__eTextMode_AutoWrap)
    self.guildName:SetText(self.guildName:GetText())
    self.guildName:SetSize(self.guildName:GetSizeX(), self.guildName:GetTextSizeY())
  end
  self.guildOwner:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MASTER") .. " : " .. siegeWrapper:getGuildMasterName())
  if Panel_Worldmap_Territory:GetSizeX() < self.guildOwner:GetPosX() + self.guildOwner:GetTextSizeX() then
    self.guildOwner:SetTextMode(__eTextMode_AutoWrap)
    self.guildOwner:SetText(self.guildOwner:GetText())
    self.guildOwner:SetSize(self.guildOwner:GetSizeX(), self.guildOwner:GetTextSizeY())
    self.guildOwner:SetSpanSize(self.guildOwner:GetSpanSize().x, self.guildName:GetSpanSize().y + self.guildName:GetTextSizeY())
    self.occupyDate:SetSpanSize(self.occupyDate:GetSpanSize().x, self.guildOwner:GetSpanSize().y + self.guildOwner:GetTextSizeY())
    self.occupyWeek:SetSpanSize(self.occupyWeek:GetSpanSize().x, self.occupyDate:GetSpanSize().y + self.occupyDate:GetTextSizeY())
    self.occupyEffect:SetSpanSize(self.occupyEffect:GetSpanSize().x, self.occupyWeek:GetSpanSize().y + self.occupyWeek:GetTextSizeY())
  end
  local paDate = siegeWrapper:getOccupyingDate()
  local year = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(paDate:GetYear()))
  local month = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(paDate:GetMonth()))
  local day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(paDate:GetDay()))
  local hour = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(paDate:GetHour()))
  self.occupyDate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_TIME") .. " : " .. year .. month .. day .. hour)
  if -1 ~= occupyWeekValue then
    self.occupyWeek:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYTOOLTIP_WEEK_HAVE", "value", occupyWeekValue + 1))
  else
    self.occupyWeek:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYTOOLTIP_WEEK"))
  end
  if true == _ContentsGroup_MajorSiege_AddMaxHp then
    local hpValue = ToClient_GetTerritoryGuildMajorSiegeAddHpMax(siegeWrapper:getGuildNo())
    local hpStack = ToClient_GetTerritoryGuildMajorSiegeAddHpStack(siegeWrapper:getGuildNo())
    self.occupyEffect:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYTOOLTIP_SIEGEHP", "value1", hpStack, "value2", hpValue))
    self.occupyEffect:SetTextMode(__eTextMode_AutoWrap)
    local padding = 25
    local maxXSize = Panel_Worldmap_Territory:GetSizeX() - (self.guildIconBG:GetPosX() + self.guildIconBG:GetSizeX() + padding)
    self.occupyEffect:SetSize(math.min(self.occupyEffect:GetTextSizeX(), maxXSize), self.occupyEffect:GetTextSizeY())
    self.occupyEffect:SetText(self.occupyEffect:GetText())
    local lineSizeY = self.occupyEffect:GetSpanSize().y + self.occupyEffect:GetTextSizeY()
    if siegeWrapper:doOccupantExist() then
      self.line_2:SetSpanSize(0, lineSizeY + const_lineSpanUp)
    end
  else
    self.occupyEffect:SetShow(false)
    local lineSizeY = self.occupyWeek:GetSpanSize().y + self.occupyWeek:GetTextSizeY()
    if siegeWrapper:doOccupantExist() then
      self.line_2:SetSpanSize(0, lineSizeY + const_lineSpanUp)
    end
  end
  self.sectionBG:SetSize(self.sectionBG:GetSizeX(), self.line_2:GetSpanSize().y - self.sectionBG:GetSpanSize().y)
end
function occupyBenefit:SetInfo(territoryKeyRaw)
  local isShow = _ContentsGroup_OccupyBenefit and (2 == territoryKeyRaw or 3 == territoryKeyRaw) or 4 == territoryKeyRaw
  self.sectionBG:SetShow(isShow)
  self.sectionTitle:SetShow(isShow)
  self.sectionDesc:SetShow(isShow)
  self.line_3:SetShow(isShow)
  if false == isShow then
    return
  end
  if 2 == territoryKeyRaw then
    self.sectionDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYINFO_BENEFIT_1"))
  elseif 3 == territoryKeyRaw then
    self.sectionDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYINFO_BENEFIT_2"))
  elseif 4 == territoryKeyRaw then
    self.sectionDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYINFO_BENEFIT_3"))
  end
  self.sectionDesc:SetSize(self.sectionDesc:GetSizeX(), self.sectionDesc:GetTextSizeY())
  local lineSizeY = occupyGuildSection.line_2:GetSpanSize().y
  local siegeWrapper = ToClient_GetSiegeWrapper(territoryKeyRaw)
  if nil ~= siegeWrapper and siegeWrapper:doOccupantExist() then
    self.sectionTitle:SetSpanSize(self.sectionTitle:GetSpanSize().x, lineSizeY + const_lineSpanDown)
    self.sectionDesc:SetSpanSize(self.sectionDesc:GetSpanSize().x, self.sectionTitle:GetSpanSize().y + 26)
  else
    self.sectionTitle:SetSpanSize(20, 240)
    self.sectionDesc:SetSpanSize(30, 270)
  end
  local lineY = self.sectionDesc:GetSpanSize().y + self.sectionDesc:GetTextSizeY()
  self.line_3:SetSpanSize(0, lineY + const_lineSpanUp)
  self.sectionBG:SetSpanSize(self.sectionBG:GetSpanSize().x, self.sectionTitle:GetSpanSize().y - const_lineSpanDown)
  self.sectionBG:SetSize(self.sectionBG:GetSizeX(), self.line_3:GetSpanSize().y - self.sectionBG:GetSpanSize().y)
end
function commonInfoSection:SetShow(isShow)
  self.playerInfoTitle:SetShow(isShow)
  self.playerPopular:SetShow(isShow)
  self.warInfoTitle:SetShow(isShow)
  self.warInfo:SetShow(isShow)
  self.volunteerInfo:SetTextMode(__eTextMode_AutoWrap)
  if true == _ContentsGroup_BattleFieldVolunteer then
    self.volunteerInfo:SetShow(isShow)
  else
    self.volunteerInfo:SetShow(false)
  end
  self.sectionBG:SetShow(isShow)
end
function commonInfoSection:SetInfo(territoryInfo, territoryKeyRaw)
  local supportPoint = ToClient_getRemainSurportPointByTerritory(territoryInfo)
  local supportExpRate = ToClient_getCurrentExpRate(territoryInfo)
  if 0 == supportPoint then
    supportPointText = "<PAColor0xAAFFBB88>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ROOKIE") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ADVENTURER") .. "<PAOldColor>"
  elseif 1 == supportPoint then
    supportPointText = "<PAColor0xAAFFBB88>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_STRANGE") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ADVENTURER") .. "<PAOldColor>"
  elseif 2 == supportPoint then
    supportPointText = "<PAColor0xAAFFBB88>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_CLOSE") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ADVENTURER") .. "<PAOldColor>"
  elseif 3 == supportPoint then
    supportPointText = "<PAColor0xAAFFBB88>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_RELIABLE") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ADVENTURER") .. "<PAOldColor>"
  elseif supportPoint >= 4 then
    supportPointText = "<PAColor0xAAFFBB88>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_FAMOUS") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_ADVENTURER") .. "<PAOldColor>"
  end
  self.playerPopular:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_FAME") .. " : " .. supportPointText)
  local isWar = isSiegeBeing(territoryKeyRaw)
  local joinGuildCount = getCompleteKingOrLordTentCount(territoryKeyRaw)
  if isWar then
    self.warInfo:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WOLRDMAP_TERRITORYTOOLTIP_TEXT_GUILDWAR", "joinGuildCount", joinGuildCount))
  else
    self.warInfo:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYTOOLTIP_JOINGUILDCOUNT", "joinGuildCount", joinGuildCount))
  end
  local siegeWrapper = ToClient_GetSiegeWrapper(territoryKeyRaw)
  local lineSizeY = 0
  if true == occupyBenefit.sectionBG:GetShow() then
    lineSizeY = occupyBenefit.line_3:GetSpanSize().y
  else
    lineSizeY = occupyGuildSection.line_2:GetSpanSize().y
  end
  if nil ~= siegeWrapper and true == siegeWrapper:doOccupantExist() then
    self.playerInfoTitle:SetSpanSize(20, lineSizeY + const_lineSpanDown)
    self.playerPopular:SetSpanSize(30, self.playerInfoTitle:GetSpanSize().y + 30)
    self.warInfoTitle:SetSpanSize(20, self.playerPopular:GetSpanSize().y + 40)
    self.warInfo:SetSpanSize(30, self.warInfoTitle:GetSpanSize().y + 30)
  elseif true == occupyBenefit.sectionBG:GetShow() then
    self.playerInfoTitle:SetSpanSize(20, lineSizeY + const_lineSpanDown)
    self.playerPopular:SetSpanSize(30, self.playerInfoTitle:GetSpanSize().y + 30)
    self.warInfoTitle:SetSpanSize(20, self.playerPopular:GetSpanSize().y + 40)
    self.warInfo:SetSpanSize(30, self.warInfoTitle:GetSpanSize().y + 30)
  else
    self.playerInfoTitle:SetSpanSize(20, 240)
    self.playerPopular:SetSpanSize(30, 270)
    self.warInfoTitle:SetSpanSize(20, 310)
    self.warInfo:SetSpanSize(30, 340)
  end
  if true == _ContentsGroup_BattleFieldVolunteer then
    local spanSize = self.warInfo:GetSpanSize()
    self.volunteerInfo:SetSpanSize(spanSize.x, spanSize.y + 30)
    local regionKey = ToClient_getMainTwonRegionKey(territoryInfo)
    local regionWrapper = getRegionInfoWrapper(regionKey)
    local maxMecenary = regionWrapper:getSiegeGuildVolunteerLimitCount()
    local isStartMajorSiege = ToClient_isStartMajorSiege(regionWrapper:getTerritoryKeyRaw())
    local guildMercenaryCost = regionWrapper:getMaxMercenaryCost()
    if maxMecenary > 0 and maxMecenary <= 100 and true == isStartMajorSiege then
      local maxMecenaryString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDMAXMECENARY", "count", maxMecenary)
      self.volunteerInfo:SetText(maxMecenaryString)
      self.volunteerInfo:SetShow(true)
    else
      self.volunteerInfo:SetShow(false)
    end
  end
  local sectionBottom = self.warInfo:GetSpanSize().y + self.warInfo:GetTextSizeY()
  self.sectionBG:SetSize(self.sectionBG:GetSizeX(), sectionBottom - self.sectionBG:GetSpanSize().y)
end
function FromClient_TerritoryUICreate(territoryUI)
  local territoryInfo = territoryUI:FromClient_getTerritoryInfo()
  local guildMark = territoryUI:FromClient_getGuildMark()
  guildMark:SetSize(32, 32)
  guildMark:SetSpanSize(0, 118)
  guildMark:SetHorizonCenter()
  guildMark:SetVerticalTop()
  guildMark:SetIgnore(true)
  guildMark:SetShow(false)
  guildMark:SetTexturePreload(false)
  local isSet = ToClient_setGuildTexture(territoryInfo, guildMark)
  if false == isSet then
    guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/BlankGuildMark.dds")
    guildMark:SetTexturePreload(false)
    guildMark:SetAlpha(0)
  else
    guildMark:SetAlpha(1)
  end
end
function FromClient_updateGuildmark(territoryUI)
  local territoryInfo = territoryUI:FromClient_getTerritoryInfo()
  local guildMark = territoryUI:FromClient_getGuildMark()
  local isSet = ToClient_setGuildTexture(territoryInfo, guildMark)
  if false == isSet then
    guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/BlankGuildMark.dds")
    guildMark:SetTexturePreload(false)
    guildMark:SetAlpha(0)
  else
    guildMark:SetAlpha(1)
  end
end
function FromClient_OnTerritoryTooltipShow(territoryUI, territoryInfo, territoryKeyRaw)
  if nil == territoryInfo then
    return
  end
  panelHeight = 0
  Panel_Worldmap_Territory:SetShow(true)
  local siegeWrapper = ToClient_GetSiegeWrapper(territoryKeyRaw)
  territoryName:SetText(ToClient_getTerritoryName(territoryInfo))
  territoryInfoScetion:SetShow(true)
  territoryInfoScetion:SetInfo(territoryInfo, territoryKeyRaw)
  local panelHeight = territoryInfoScetion.sectionBG:GetSizeY() + const_lineGap
  if nil ~= siegeWrapper and siegeWrapper:doOccupantExist() then
    occupyGuildSection:SetShow(true)
    occupyGuildSection:SetInfo(territoryInfo, territoryKeyRaw)
    panelHeight = panelHeight + occupyGuildSection.sectionBG:GetSizeY() + const_lineGap
  else
    occupyGuildSection:SetShow(false)
  end
  occupyBenefit:SetInfo(territoryKeyRaw)
  commonInfoSection:SetShow(true)
  commonInfoSection:SetInfo(territoryInfo, territoryKeyRaw)
  Panel_Worldmap_Territory:SetSize(Panel_Worldmap_Territory:GetSizeX(), commonInfoSection.sectionBG:GetPosY() + commonInfoSection.sectionBG:GetSizeY() + const_lineSpanUp)
  if true == commonInfoSection.volunteerInfo:GetShow(true) then
    Panel_Worldmap_Territory:SetSize(Panel_Worldmap_Territory:GetSizeX(), Panel_Worldmap_Territory:GetSizeY() + commonInfoSection.volunteerInfo:GetSizeY() + 10)
  end
  local posX = territoryUI:GetPosX()
  local posY = territoryUI:GetPosY()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  StatLimitOpen(territoryInfo)
  local limitPanelSizeX = 0
  if true == limitStat._panel:GetShow() then
    limitPanelSizeX = limitStat._panel:GetSizeX() + 5
  end
  local isAlliance = true == _ContentsGroup_guildAlliance and true == siegeWrapper:isOccupantGuildAlliance()
  if true == isAlliance then
    alianceInfoTooltip._stc_allianceInfo:SetShow(true)
    if true == limitStat._panel:GetShow() then
      alianceInfoTooltip._stc_allianceInfo:SetPosX(Panel_Worldmap_Territory:GetSizeX() + limitStat._panel:GetSizeX() + 10)
      limitPanelSizeX = limitStat._panel:GetSizeX() + alianceInfoTooltip._stc_allianceInfo:GetSizeX() + 10
    else
      alianceInfoTooltip._stc_allianceInfo:SetPosX(Panel_Worldmap_Territory:GetSizeX() + 5)
      limitPanelSizeX = alianceInfoTooltip._stc_allianceInfo:GetSizeX() + 5
    end
    setGuildAllianceInfo(siegeWrapper:getGuildNo())
  else
    alianceInfoTooltip._stc_allianceInfo:SetShow(false)
  end
  if false == _ContentsGroup_UsePadSnapping then
    if posX / screenSizeX > 0.5 then
      posX = posX - Panel_Worldmap_Territory:GetSizeX() - limitPanelSizeX
    else
      posX = posX + territoryUI:GetSizeX()
    end
    if posY / screenSizeY > 0.5 then
      posY = posY - Panel_Worldmap_Territory:GetSizeY()
    end
  else
    posX = screenSizeX / 2 + territoryUI:GetSizeX() - 50
    posY = screenSizeY / 2 - Panel_Worldmap_Territory:GetSizeY() / 2
  end
  Panel_Worldmap_Territory:SetPosX(posX)
  Panel_Worldmap_Territory:SetPosY(posY)
end
function StatLimitOpen(territoryInfo)
  if false == _ContentsGroup_MajorSiegeLimitStat then
    limitStat._panel:SetShow(false)
    return
  end
  if false == limitStat._init then
    StatLimitInit()
  end
  local mainTownRegionKey = ToClient_getMainTwonRegionKey(territoryInfo)
  local maxDD = ToClient_getLimitSiegeDDByRegionKey(mainTownRegionKey)
  local maxPV = ToClient_getLimitSiegePVByRegionKey(mainTownRegionKey)
  local maxDV = ToClient_getLimitSiegeDVByRegionKey(mainTownRegionKey)
  local maxDVRate = ToClient_getLimitSiegeDVRateByRegionKey(mainTownRegionKey)
  PaGlobal_Window_Stat_All_Update()
  local myDD = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DD)
  local myADD = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_ADD)
  local myDDstr = GetLimitFontColor(maxDD, myDD)
  local myADDstr = GetLimitFontColor(maxDD, myADD)
  limitStat._limitDD:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_ATT", "attack", tostring(maxDD)))
  limitStat._limitMyDD:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_ATT_MYSTAT", "attackstat", tostring(myDDstr .. "/" .. myADDstr)))
  local myDDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DDV)
  local myRDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RDV)
  local myMDV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MDV)
  local myDDVstr = GetLimitFontColor(maxDV, myDDV)
  local myRDVstr = GetLimitFontColor(maxDV, myRDV)
  local myMDVstr = GetLimitFontColor(maxDV, myMDV)
  limitStat._limitDV:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV", "evade", tostring(maxDV)))
  limitStat._limitMyDV:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_MYSTAT", "Pevade", tostring(myDDVstr), "Revade", tostring(myRDVstr), "Mevade", tostring(myMDVstr)))
  local myDDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DDV_RATE)
  local myRDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RDV_RATE)
  local myMDVRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MDV_RATE)
  local myDDVRateStr = GetRateLimitFontColor(maxDVRate, myDDVRate)
  local myRDVRateStr = GetRateLimitFontColor(maxDVRate, myRDVRate)
  local myMDVRateStr = GetRateLimitFontColor(maxDVRate, myMDVRate)
  limitStat._limitDVRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_1", "evade1", tostring(PaGlobal_Window_Stat_All:getRateText(maxDVRate) .. "%")))
  limitStat._limitMyDVRate:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HDV_1_MYSTAT", "Pevade1", tostring(myDDVRateStr), "Revade1", tostring(myRDVRateStr), "Mevade1", tostring(myMDVRateStr)))
  local myDPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_DPV)
  local myRPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_RPV)
  local myMPV = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_MPV)
  local myDPVstr = GetLimitFontColor(maxPV, myDPV)
  local myRPVstr = GetLimitFontColor(maxPV, myRPV)
  local myMPVstr = GetLimitFontColor(maxPV, myMPV)
  limitStat._limitPV:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HPV", "reduce", tostring(maxPV)))
  limitStat._limitMyPV:SetText(PAGetStringParam3(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HPV_MYSTAT", "Preduce", tostring(myDPVstr), "Rreduce", tostring(myRPVstr), "Mreduce", tostring(myMPVstr)))
  local regionWrapper = getRegionInfoWrapper(mainTownRegionKey)
  local maxDamageReduce = 0
  if nil ~= regionWrapper then
    maxDamageReduce = regionWrapper:getMinorSiegeDamageReduction()
    local myDamageReduce = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_REDUCE)
    local myDamageReduceStr = GetRateLimitFontColor(maxDamageReduce, myDamageReduce)
    if 0 ~= maxDamageReduce then
      maxDamageReduce = maxDamageReduce / 10000
    end
    limitStat._limitDamageReduce:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_DAMAGE_REDUCE", "reduction", tostring(maxDamageReduce)) .. "%")
    limitStat._limitMyDamageReduce:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_DAMAGE_REDUCE_MYSTAT", "reduction", myDamageReduceStr))
  end
  local limitHit = ToClient_getLimitSiegeHitByRegionKey(mainTownRegionKey)
  local limitHitRate = ToClient_getLimitSiegeHitRateByRegionKey(mainTownRegionKey)
  local limitResist = ToClient_getLimitSiegeStunResistByRegionKey(mainTownRegionKey)
  local myHit = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_HIT)
  local myHitRate = PaGlobal_Window_Stat_All_GetTotalStat(PaGlobal_Window_Stat_All._INDEX_HIT_RATE)
  local myStunResist = PaGlobal_CharInfoBasic_All._selfPlayer:getStunResistance()
  local myCatchResist = PaGlobal_CharInfoBasic_All._selfPlayer:getCatchResistance()
  local myKnockdownResist = PaGlobal_CharInfoBasic_All._selfPlayer:getKnockdownResistance()
  local myKnockbackResist = PaGlobal_CharInfoBasic_All._selfPlayer:getKnockbackResistance()
  local myHitStr = GetLimitFontColor(limitHit, myHit)
  local myHitRateStr = GetRateLimitFontColor(limitHitRate, myHitRate)
  local myStunResistStr = GetRateLimitFontColor(limitResist, myStunResist)
  local myCatchResistStr = GetRateLimitFontColor(limitResist, myCatchResist)
  local myKnockdownResistStr = GetRateLimitFontColor(limitResist, myKnockdownResist)
  local myKnockbackResistStr = GetRateLimitFontColor(limitResist, myKnockbackResist)
  if limitHit > 0 and limitHit < 9999 then
    limitStat._limitHit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT", "hit", tostring(limitHit)))
  else
    limitStat._limitHit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT", "hit", "-"))
    myHitStr = GetLimitFontColor(0, myHit)
  end
  if limitHitRate > 0 and limitHitRate < CppDefine.e100Percent then
    limitStat._limitHitRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1", "hit1", PaGlobal_Window_Stat_All:getRateText(limitHitRate)) .. "%")
  else
    limitStat._limitHitRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1", "hit1", "-"))
    myHitRateStr = GetRateLimitFontColor(0, myHitRate)
  end
  if limitResist > 0 and limitResist < CppDefine.e100Percent then
    limitStat._limitResist:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG", "stun", PaGlobal_Window_Stat_All:getRateText(limitResist)) .. "%")
  else
    limitStat._limitResist:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG", "stun", "-"))
    myStunResistStr = GetRateLimitFontColor(0, myStunResist)
    myCatchResistStr = GetRateLimitFontColor(0, myCatchResist)
    myKnockdownResistStr = GetRateLimitFontColor(0, myKnockdownResist)
    myKnockbackResistStr = GetRateLimitFontColor(0, myKnockbackResist)
  end
  limitStat._limitMyHit:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_MYSTAT", "hit", myHitStr))
  limitStat._limitMyHitRate:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_HIT_1_MYSTAT", "hit1", myHitRateStr))
  limitStat._limitMyResist:SetText(PAGetStringParam4(Defines.StringSheet_GAME, "LUA_NODETOOLTIP_STATLIMIT_REG_MYSTAT", "stun", myStunResistStr, "grab", myCatchResistStr, "down", myKnockdownResistStr, "air", myKnockbackResistStr))
  if true == _ContentsGroup_SiegeHitAndResistLimit then
    limitStat._desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_NODETOOLTIP_STATLIMIT_DESC"))
  else
    limitStat._desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_NODETOOLTIP_STATLIMIT_DESC_OLD"))
  end
  local wrapCount = 0
  local padding = 20
  local descPadding = 0
  if limitStat._defaultTextSizeY < limitStat._limitDD:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitMyDD:SetPosY(limitStat._limitMyDDPosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitMyDD:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitDV:SetPosY(limitStat._limitDVPosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitDV:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitMyDV:SetPosY(limitStat._limitMyDVPosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitMyDV:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitDVRate:SetPosY(limitStat._limitDVRatePosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitDVRate:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitMyDVRate:SetPosY(limitStat._limitMyDVRatePosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitMyDVRate:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitPV:SetPosY(limitStat._limitPVPosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitPV:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitMyPV:SetPosY(limitStat._limitMyPVPosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitMyPV:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitDamageReduce:SetPosY(limitStat._limitDamageReducePosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitDamageReduce:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  limitStat._limitMyDamageReduce:SetPosY(limitStat._limitMyDamageReducePosY + wrapCount * padding)
  if limitStat._defaultTextSizeY < limitStat._limitMyDamageReduce:GetTextSizeY() then
    wrapCount = wrapCount + 1
  end
  if true == _ContentsGroup_SiegeHitAndResistLimit then
    limitStat._limitHit:SetPosY(limitStat._limitHitPosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitHit:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._limitMyHit:SetPosY(limitStat._limitMyHitPosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitMyHit:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._limitHitRate:SetPosY(limitStat._limitHitRatePosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitHitRate:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._limitMyHitRate:SetPosY(limitStat._limitMyHitRatePosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitMyHitRate:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._limitResist:SetPosY(limitStat._limitResistPosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitResist:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._limitMyResist:SetPosY(limitStat._limitMyResistPosY + wrapCount * padding)
    if limitStat._defaultTextSizeY < limitStat._limitMyResist:GetTextSizeY() then
      wrapCount = wrapCount + 1
    end
    limitStat._desc:SetPosY(limitStat._descPosY + wrapCount * padding)
  else
    limitStat._limitHit:SetShow(false)
    limitStat._limitMyHit:SetShow(false)
    limitStat._limitHitRate:SetShow(false)
    limitStat._limitMyHitRate:SetShow(false)
    limitStat._limitResist:SetShow(false)
    limitStat._limitMyResist:SetShow(false)
    limitStat._desc:SetPosY(limitStat._limitHitPosY + wrapCount * padding)
  end
  local limitPanelPosY = limitStat._panel:GetPosY()
  local descEndY = limitStat._desc:GetPosY() + limitStat._desc:GetTextSizeY() + 60
  local limitPanelSize = descEndY - limitPanelPosY
  limitStat._panel:SetSize(limitStat._panel:GetSizeX(), limitPanelSize)
  limitStat._bg:SetSize(limitStat._bg:GetSizeX(), limitPanelSize - 50)
  if maxDD > 0 and maxDD < 9999 then
    limitStat._panel:SetShow(true)
  else
    limitStat._panel:SetShow(false)
  end
  limitStat._panel:SetPosX(Panel_Worldmap_Territory:GetSizeX() + 5)
end
function StatLimitInit()
  limitStat._limitDDPosY = limitStat._limitDD:GetPosY()
  limitStat._limitMyDDPosY = limitStat._limitMyDD:GetPosY()
  limitStat._limitDVPosY = limitStat._limitDV:GetPosY()
  limitStat._limitMyDVPosY = limitStat._limitMyDV:GetPosY()
  limitStat._limitDVRatePosY = limitStat._limitDVRate:GetPosY()
  limitStat._limitMyDVRatePosY = limitStat._limitMyDVRate:GetPosY()
  limitStat._limitPVPosY = limitStat._limitPV:GetPosY()
  limitStat._limitMyPVPosY = limitStat._limitMyPV:GetPosY()
  limitStat._limitDamageReducePosY = limitStat._limitDamageReduce:GetPosY()
  limitStat._limitMyDamageReducePosY = limitStat._limitMyDamageReduce:GetPosY()
  limitStat._descPosY = limitStat._desc:GetPosY()
  limitStat._limitHitPosY = limitStat._limitHit:GetPosY()
  limitStat._limitMyHitPosY = limitStat._limitMyHit:GetPosY()
  limitStat._limitHitRatePosY = limitStat._limitHitRate:GetPosY()
  limitStat._limitMyHitRatePosY = limitStat._limitMyHitRate:GetPosY()
  limitStat._limitResistPosY = limitStat._limitResist:GetPosY()
  limitStat._limitMyResistPosY = limitStat._limitMyResist:GetPosY()
  limitStat._defaultPanelSizeY = limitStat._panel:GetSizeY()
  limitStat._defaultBgSizeY = limitStat._bg:GetSizeY()
  limitStat._title:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitDD:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyDD:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitDV:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyDV:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitDVRate:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyDVRate:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitPV:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyPV:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitDamageReduce:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyDamageReduce:SetTextMode(__eTextMode_AutoWrap)
  limitStat._desc:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitHit:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyHit:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitHitRate:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyHitRate:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitResist:SetTextMode(__eTextMode_AutoWrap)
  limitStat._limitMyResist:SetTextMode(__eTextMode_AutoWrap)
  limitStat._title:SetText(limitStat._title:GetText())
  limitStat._desc:SetText(limitStat._desc:GetText())
  limitStat._init = true
end
function initGuildAllianceInfo()
  for ii = 1, alianceInfoTooltip._MAX_MEMBER_COUNT do
    alianceInfoTooltip._stc_guildList[ii] = UI.cloneControl(alianceInfoTooltip._stc_guildTemplate, alianceInfoTooltip._stc_allianceInfoBG, "Static_GuildInfo_Normal_" .. ii)
    alianceInfoTooltip._stc_guildList[ii]:SetSpanSize(0, 50 * ii)
  end
  alianceInfoTooltip._stc_guildTemplate:SetShow(false)
  alianceInfoTooltip._init = true
end
function setGuildAllianceInfo(allianceNo)
  if nil == Panel_Worldmap_Territory then
    return
  end
  if false == alianceInfoTooltip._init then
    initGuildAllianceInfo()
  end
  local name, mark, leaderName
  name = UI.getChildControl(alianceInfoTooltip._stc_allianceLeader, "StaticText_AliiName_LeaderGuild")
  mark = UI.getChildControl(alianceInfoTooltip._stc_allianceLeader, "Static_GuildIconSet")
  leaderName = UI.getChildControl(alianceInfoTooltip._stc_allianceLeader, "StaticText_LeaderName")
  local guildWrapper = ToClient_GetGuildInfoWrapperByGuildNo(allianceNo)
  if nil ~= guildWrapper then
    if nil ~= name then
      name:SetText(guildWrapper:getName())
    end
    if nil ~= leaderName then
      leaderName:SetText(guildWrapper:getGuildMasterName())
    end
    if nil ~= mark then
      mark:getBaseTexture():setUV(0, 0, 1, 1)
      mark:setRenderTexture(mark:getBaseTexture())
      setGuildTextureByGuildNo(allianceNo, mark)
    end
  end
  local guildAlliance = ToClient_GetGuildAllianceWrapperbyNo(allianceNo)
  local memberCount = 0
  for ii = 1, alianceInfoTooltip._MAX_MEMBER_COUNT do
    alianceInfoTooltip._stc_guildList[ii]:SetShow(false)
  end
  if nil ~= guildAlliance then
    local guildInfoIndex = 1
    for index = 0, guildAlliance:getMemberCount() - 1 do
      guildWrapper = guildAlliance:getMemberGuild(index)
      if nil ~= guildWrapper and guildWrapper:getGuildNo_s64() ~= allianceNo and nil ~= alianceInfoTooltip._stc_guildList[guildInfoIndex] then
        name = UI.getChildControl(alianceInfoTooltip._stc_guildList[guildInfoIndex], "StaticText_AliiName_NormalGuild")
        mark = UI.getChildControl(alianceInfoTooltip._stc_guildList[guildInfoIndex], "Static_GuildIconSet")
        leaderName = UI.getChildControl(alianceInfoTooltip._stc_guildList[guildInfoIndex], "StaticText_LeaderName")
        if nil ~= name then
          name:SetText(guildWrapper:getName())
        end
        if nil ~= leaderName then
          leaderName:SetText(guildWrapper:getGuildMasterName())
        end
        if nil ~= mark then
          mark:getBaseTexture():setUV(0, 0, 1, 1)
          mark:setRenderTexture(mark:getBaseTexture())
          setGuildTextureByGuildNo(guildWrapper:getGuildNo_s64(), mark)
        end
        alianceInfoTooltip._stc_guildList[guildInfoIndex]:SetShow(true)
        guildInfoIndex = guildInfoIndex + 1
      end
    end
    local sizeY = alianceInfoTooltip._stc_guildTemplate:GetSizeY() * guildInfoIndex + 20
    alianceInfoTooltip._stc_allianceInfo:SetSize(alianceInfoTooltip._stc_allianceInfo:GetSizeX(), sizeY + 50)
    alianceInfoTooltip._stc_allianceInfoBG:SetSize(alianceInfoTooltip._stc_allianceInfoBG:GetSizeX(), sizeY)
  end
end
function GetLimitFontColor(max, current)
  if max <= current then
    return "<PAColor0xff6cf000>" .. tostring(current) .. "<PAOldColor>"
  else
    return "<PAColor0xffd05d48>" .. tostring(current) .. "<PAOldColor>"
  end
end
function FromClient_OnTerritoryTooltipHide()
  Panel_Worldmap_Territory:SetShow(false)
end
function PaGlobalFunc_TerritoryTooltipInfo_Close()
  FromClient_OnTerritoryTooltipHide()
end
registerEvent("FromClient_WorldMapTerritoryNodeCreate", "FromClient_TerritoryUICreate")
registerEvent("FromClient_WorldMapTerritoryNodeGuildMarkUpdate", "FromClient_updateGuildmark")
registerEvent("FromClient_TerritoryTooltipShow", "FromClient_OnTerritoryTooltipShow")
registerEvent("FromClient_TerritoryTooltipHide", "FromClient_OnTerritoryTooltipHide")
