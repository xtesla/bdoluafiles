function PaGlobal_SiegeWar_CastleInfo:initialize()
  if true == PaGlobal_SiegeWar_CastleInfo._initialize then
    return
  end
  PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoTemplate = UI.getChildControl(Panel_SiegeWar_CastleInfo, "Static_CastleInfo")
  PaGlobal_SiegeWar_CastleInfo:registEventHandler()
  PaGlobal_SiegeWar_CastleInfo:validate()
  PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoTemplate:SetShow(false)
  PaGlobal_SiegeWar_CastleInfo._initialize = true
  PaGlobal_SiegeWar_CastleInfo:prepareOpen()
end
function PaGlobal_SiegeWar_CastleInfo:registEventHandler()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  registerEvent("FromClient_SiegeWarCastleInfoOpen", "FromClient_SiegeWarCastleInfoOpen")
  registerEvent("FromClient_SiegeWarCastleInfoClose", "FromClient_SiegeWarCastleInfoClose")
  registerEvent("FromClient_SiegeWarCastleInfoAttackSiegeTent", "FromClient_SiegeWarCastleInfoAttackSiegeTent")
  registerEvent("FromClient_SiegeWarCastleInfoSetHpSiegeTent", "FromClient_SiegeWarCastleInfoSetHpSiegeTent")
  registerEvent("FromClient_ResponseParticipateSiege", "FromClient_SiegeWar_CastleInfo_ResponseParticipateSiege")
end
function PaGlobal_SiegeWar_CastleInfo:prepareOpen()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  if true == Panel_SiegeWar_CastleInfo:GetShow() then
    return
  end
  if false == _ContentsGroup_ConquestSiege then
    return
  end
  if false == ToClient_IsAnySiegeBeingOfMyChannel() then
    return
  end
  if false == ToClient_IsInSiegeBattleSelf() then
    return
  end
  if nil ~= Panel_Radar then
    Panel_SiegeWar_CastleInfo:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 10)
  end
  Panel_SiegeWar_CastleInfo:SetPosX(getScreenSizeX() - Panel_SiegeWar_CastleInfo:GetSizeX() - 20)
  self:addCastleInfo()
  ToClient_getRequestSiegeTentHp()
  Panel_SiegeWar_CastleInfo:RegisterUpdateFunc("PaGlobal_SiegeWar_CastleInfo_UpdatePerFrame")
  PaGlobal_SiegeWar_CastleInfo:open()
end
function PaGlobal_SiegeWar_CastleInfo:open()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  Panel_SiegeWar_CastleInfo:SetShow(true)
end
function PaGlobal_SiegeWar_CastleInfo:prepareClose()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  if false == Panel_SiegeWar_CastleInfo:GetShow() then
    return
  end
  if true == ToClient_IsInSiegeBattleSelf() then
    return
  end
  Panel_SiegeWar_CastleInfo:ClearUpdateLuaFunc("PaGlobal_SiegeWar_CastleInfo_UpdatePerFrame")
  PaGlobal_SiegeWar_CastleInfo:close()
  FGlobal_QuestWidget_Open()
end
function PaGlobal_SiegeWar_CastleInfo:close()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  Panel_SiegeWar_CastleInfo:SetShow(false)
end
function PaGlobal_SiegeWar_CastleInfo:update()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
end
function PaGlobal_SiegeWar_CastleInfo:addCastleInfo()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildNo = selfPlayer:getGuildNo_s64()
  if true == selfPlayer:isGuildAllianceMember() then
    guildNo = selfPlayer:getGuildAllianceNo_s64()
  end
  local addSizeY = 0
  if true == _ContentsGroup_SiegeAngerSystem then
    addSizeY = PaGlobal_SiegeWar_AngerGage_GetMainBgSizeY()
  end
  local count = ToClient_getCurrnetBuildingCount(guildNo)
  for ii = 1, count do
    local householdNo = ToClient_getHouseholdNoAtIndex(guildNo, ii - 1)
    if 0 ~= householdNo then
      local buildingInfo = ToClient_getBuildingInfoByHouseholdNo(householdNo)
      if nil == self._ui._stc_castleInfoList[ii] and nil ~= buildingInfo then
        local castleInfo = {}
        local gab = 5
        local tempControl
        castleInfo._stc_castleInfoBg = UI.cloneControl(self._ui._stc_castleInfoTemplate, Panel_SiegeWar_CastleInfo, "Static_SiegeWar_CastleInfo_" .. ii)
        castleInfo._stc_castleInfoBg:SetPosY(addSizeY + self._ui._stc_castleInfoTemplate:GetPosY() + (castleInfo._stc_castleInfoBg:GetSizeY() + gab) * (ii - 1))
        tempControl = UI.getChildControl(castleInfo._stc_castleInfoBg, "Static_CastleInfo_Area")
        local buildingRegionKey
        if nil ~= tempControl then
          castleInfo._stc_castleIconNormal = UI.getChildControl(tempControl, "StaticText_Castle_Normal")
          castleInfo._stc_castleIconNormal:SetShow(true)
          castleInfo._stc_castleIconDamage = UI.getChildControl(tempControl, "StaticText_Castle_Damage")
          castleInfo._stc_castleIconDamage:SetShow(false)
          castleInfo._stc_castleIconBroken = UI.getChildControl(tempControl, "StaticText_CastleInfo_Broken")
          castleInfo._stc_castleIconBroken:SetShow(false)
          if true == ToClient_IsVillageSiegeBeing() then
            buildingRegionKey = buildingInfo:getBuildingRegionKey()
          else
            buildingRegionKey = buildingInfo:getAffiliatedRegionKey()
          end
          local regionInfo = getRegionInfoByRegionKey(buildingRegionKey)
          local regionName = ""
          if nil ~= regionInfo then
            regionName = regionInfo:getAreaName()
          end
          castleInfo._stc_castleRegionName = UI.getChildControl(tempControl, "StaticText_Castle_Region_Name")
          castleInfo._stc_castleRegionName:SetText(regionName)
        end
        tempControl = UI.getChildControl(castleInfo._stc_castleInfoBg, "Static_CastleHP_Area")
        if nil ~= tempControl then
          castleInfo._stc_hpNormal = UI.getChildControl(tempControl, "Progress2_Castle_Normal")
          castleInfo._stc_hpNormal:SetShow(true)
          castleInfo._stc_hpDamage = UI.getChildControl(tempControl, "Progress2_Castle_Damage")
          castleInfo._stc_hpDamage:SetShow(false)
        end
        castleInfo._stc_damageEffect = UI.getChildControl(castleInfo._stc_castleInfoBg, "Static_Damage_Effect")
        castleInfo._stc_damageEffect:SetShow(false)
        local householdActor = buildingInfo:getActorKeyRaw()
        castleInfo._btn_findWay = UI.getChildControl(castleInfo._stc_castleInfoBg, "Button_FindWay")
        castleInfo._btn_findWay:addInputEvent("Mouse_LUp", "PaGlobal_SiegeWar_CastleInfo_FindWayPoint(" .. ii .. ")")
        castleInfo._lastHitTime = 0
        castleInfo._stc_castleInfoBg:SetShow(true)
        castleInfo._householdNo = householdNo
        self._ui._stc_castleInfoList[ii] = castleInfo
      end
    end
  end
end
function PaGlobal_SiegeWar_CastleInfo:setHpSiegeTent(householdNo, hpRate)
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  local castleInfoByIndex
  for ii = 1, #self._ui._stc_castleInfoList do
    if self._ui._stc_castleInfoList[ii]._householdNo == householdNo then
      castleInfoByIndex = self._ui._stc_castleInfoList[ii]
      break
    end
  end
  if nil == castleInfoByIndex then
    return
  end
  local isDestroy = 0 == hpRate
  castleInfoByIndex._stc_castleIconNormal:SetShow(not isDestroy)
  castleInfoByIndex._stc_castleIconBroken:SetShow(true)
  castleInfoByIndex._stc_castleIconDamage:SetShow(isDestroy)
  castleInfoByIndex._stc_hpNormal:SetShow(true)
  castleInfoByIndex._stc_hpDamage:SetShow(false)
  castleInfoByIndex._stc_hpNormal:SetProgressRate(hpRate / 10000)
  castleInfoByIndex._stc_hpDamage:SetProgressRate(hpRate / 10000)
end
function PaGlobal_SiegeWar_CastleInfo:attackSiegeTent(householdNo, hpRate)
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  if 0 == hpRate then
    self:destroySiegeTent(householdNo)
    return
  end
  local castleInfoByIndex
  for ii = 1, #self._ui._stc_castleInfoList do
    if self._ui._stc_castleInfoList[ii]._householdNo == householdNo then
      castleInfoByIndex = self._ui._stc_castleInfoList[ii]
      break
    end
  end
  if nil == castleInfoByIndex then
    return
  end
  castleInfoByIndex._stc_castleIconNormal:SetShow(false)
  castleInfoByIndex._stc_castleIconDamage:SetShow(true)
  castleInfoByIndex._stc_castleIconBroken:SetShow(false)
  castleInfoByIndex._stc_hpNormal:SetShow(false)
  castleInfoByIndex._stc_hpDamage:SetShow(true)
  castleInfoByIndex._stc_damageEffect:SetShow(true)
  castleInfoByIndex._stc_hpNormal:SetProgressRate(hpRate / 10000)
  castleInfoByIndex._stc_hpDamage:SetProgressRate(hpRate / 10000)
  castleInfoByIndex._lastHitTime = getTime()
end
function PaGlobal_SiegeWar_CastleInfo:destroySiegeTent(householdNo)
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  local castleInfoByIndex
  for ii = 1, #self._ui._stc_castleInfoList do
    if self._ui._stc_castleInfoList[ii]._householdNo == householdNo then
      castleInfoByIndex = self._ui._stc_castleInfoList[ii]
      break
    end
  end
  if nil == castleInfoByIndex then
    return
  end
  castleInfoByIndex._stc_castleIconNormal:SetShow(false)
  castleInfoByIndex._stc_castleIconDamage:SetShow(false)
  castleInfoByIndex._stc_castleIconBroken:SetShow(true)
  castleInfoByIndex._stc_hpNormal:SetShow(true)
  castleInfoByIndex._stc_hpDamage:SetShow(false)
  castleInfoByIndex._stc_hpNormal:SetProgressRate(0)
  castleInfoByIndex._stc_hpDamage:SetProgressRate(0)
end
function PaGlobal_SiegeWar_CastleInfo:validate()
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  self._ui._stc_castleInfoTemplate:isValidate()
end
function PaGlobal_SiegeWar_CastleInfo_UpdatePerFrame(deletaTime)
  if true == Panel_CheckedQuest:GetShow() or true == Panel_MainQuest:GetShow() then
    FGlobal_QuestWidget_Close()
  end
  for ii = 1, #PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList do
    if 0 == PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_hpNormal:GetProgressRate() then
      PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconNormal:SetShow(false)
      PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconDamage:SetShow(false)
      PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconBroken:SetShow(true)
      PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_hpNormal:SetShow(true)
      PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_hpDamage:SetShow(false)
    else
      local hitElepsedTime = getTime() - PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._lastHitTime
      if PaGlobal_SiegeWar_CastleInfo._HIT_ICON_TIME < Uint64toUint32(hitElepsedTime) then
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconNormal:SetShow(true)
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconDamage:SetShow(false)
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_castleIconBroken:SetShow(false)
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_hpNormal:SetShow(true)
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_hpDamage:SetShow(false)
      end
      if PaGlobal_SiegeWar_CastleInfo._HIT_EFFECT_TIME < Uint64toUint32(hitElepsedTime) then
        PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[ii]._stc_damageEffect:SetShow(false)
      end
    end
  end
end
function PaGlobal_SiegeWar_CastleInfo_FindWayPoint(householdIndex)
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildNo = selfPlayer:getGuildNo_s64()
  if nil == PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[householdIndex] then
    return
  end
  local buildingInfo = ToClient_getBuildingInfoByHouseholdNo(PaGlobal_SiegeWar_CastleInfo._ui._stc_castleInfoList[householdIndex]._householdNo)
  if nil == buildingInfo then
    return
  end
  FromClient_RClickWorldmapPanel(buildingInfo:getPosition(), true, false)
end
function PaGlobal_SiegeWar_CastleInfo:changeParticipant(isParticipant)
  if nil == Panel_SiegeWar_CastleInfo then
    return
  end
  if true == isParticipant then
    PaGlobal_SiegeWar_CastleInfo:prepareOpen()
  else
    PaGlobal_SiegeWar_CastleInfo:prepareClose()
  end
end
