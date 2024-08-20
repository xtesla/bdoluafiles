TopWidgetIconType = {
  LandVehicle = 1,
  SeaVehicle = 2,
  Pet = 3,
  Garden = 4,
  Camp = 5,
  Fairy = 6,
  Summon = 7,
  Maid = 8,
  GuildServant = 9,
  Count = 10
}
local TopWidgetIconManager_info = {
  _pos = {
    sizeX = 60,
    sizeY = 60,
    spaceX = 14,
    startPosX = 20
  },
  _panelTable = {
    [TopWidgetIconType.LandVehicle] = Panel_Widget_Servant_Renew,
    [TopWidgetIconType.SeaVehicle] = Panel_Widget_Wharf_Renew,
    [TopWidgetIconType.Pet] = Panel_Widget_Pet_Renew,
    [TopWidgetIconType.Garden] = Panel_Widget_GardenIcon_Renew,
    [TopWidgetIconType.Camp] = Panel_Icon_Camp,
    [TopWidgetIconType.Fairy] = Panel_Widget_FairyIcon_Renew,
    [TopWidgetIconType.Summon] = Panel_Widget_SummonIcon_Renew,
    [TopWidgetIconType.Maid] = Panel_Widget_MaidIcon_Renew,
    [TopWidgetIconType.GuildServant] = Panel_Widget_GuildServantIcon_Renew
  },
  _openFunction = {
    [TopWidgetIconType.LandVehicle] = PaGlobalFunc_TopIcon_Servant_Open,
    [TopWidgetIconType.SeaVehicle] = PaGlobalFunc_TopIcon_Wharf_Open,
    [TopWidgetIconType.Pet] = PaGlobalFunc_TopIcon_Pet_Open,
    [TopWidgetIconType.Garden] = PaGlobal_TopIcon_Garden_Open,
    [TopWidgetIconType.Camp] = PaGlobalFunc_TopIcon_Camp_Open,
    [TopWidgetIconType.Fairy] = nil,
    [TopWidgetIconType.Summon] = PaGlobalFunc_TopIcon_Summon_Open,
    [TopWidgetIconType.Maid] = PaGlobalFunc_TopIcon_Maid_Open,
    [TopWidgetIconType.GuildServant] = nil
  },
  _closeFunction = {
    [TopWidgetIconType.LandVehicle] = PaGlobalFunc_TopIcon_Servant_Close,
    [TopWidgetIconType.SeaVehicle] = PaGlobalFunc_TopIcon_Wharf_Close,
    [TopWidgetIconType.Pet] = PaGlobalFunc_TopIcon_Pet_Close,
    [TopWidgetIconType.Garden] = PaGlobal_TopIcon_Garden_Close,
    [TopWidgetIconType.Camp] = PaGlobalFunc_TopIcon_Camp_Close,
    [TopWidgetIconType.Fairy] = nil,
    [TopWidgetIconType.Summon] = PaGlobalFunc_TopIcon_Summon_Close,
    [TopWidgetIconType.Maid] = PaGlobalFunc_TopIcon_Maid_Close,
    [TopWidgetIconType.GuildServant] = nil
  },
  _originalPartyWidgetPosY = 204
}
function PaGlobalFunc_TopIcon_GetPartyWidgetPosY()
  local self = TopWidgetIconManager_info
  local endPosY = self._originalPartyWidgetPosY + self._panelTable[TopWidgetIconType.LandVehicle]:GetSizeY()
  return endPosY
end
function PaGlobalFunc_TopIcon_GetShowAllCheck()
  local self = TopWidgetIconManager_info
  local retval = false
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  if relativePosX > 0 or relativePosY > 0 then
    return retval
  end
  for key, value in pairs(self._panelTable) do
    if nil ~= value and true == value:GetShow() then
      retval = true
      break
    end
  end
  return retval
end
function PaGlobalFunc_TopIcon_UpdatePos()
  local self = TopWidgetIconManager_info
  local sizeX = getOriginScreenSizeX()
  local sizeY = getOriginScreenSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local basePosX = (sizeX - getScreenSizeX()) / 2 + self._pos.startPosX
  local basePosY = 0
  if relativePosX > 0 or relativePosY > 0 then
    basePosX = Panel_Window_Servant:GetPosX()
    basePosY = Panel_Window_Servant:GetPosY()
  end
  for key, value in pairs(self._panelTable) do
    if nil ~= value and true == value:GetShow() then
      value:SetPosX(basePosX)
      basePosX = basePosX + self._pos.sizeX + self._pos.spaceX
      if relativePosX > 0 or relativePosY > 0 then
        value:SetPosY(basePosY + 1)
      end
    end
  end
end
function PaGlobalFunc_TopIcon_Show(IconType)
  local self = TopWidgetIconManager_info
  if nil == IconType or IconType >= TopWidgetIconType.Count then
    return
  end
  local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  if 0 == isShow then
    PaGlobalFunc_TopIcon_Exit(IconType)
    return
  end
  if nil == self._openFunction[IconType] then
    self._panelTable[IconType]:SetShow(true)
  else
    self._openFunction[IconType]()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobalFunc_Widget_Party_All_Resize()
  else
    FromClient_Party_Resize()
  end
end
function PaGlobalFunc_TopIcon_Exit(IconType)
  local self = TopWidgetIconManager_info
  if nil == IconType or IconType >= TopWidgetIconType.Count then
    return
  end
  if nil == self._closeFunction[IconType] then
    self._panelTable[IconType]:SetShow(false)
  else
    self._closeFunction[IconType]()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobalFunc_Widget_Party_All_Resize()
  else
    FromClient_Party_Resize()
  end
end
function PaGlobalFunc_TopIcon_ShowAll(isShow)
  for idx = 1, #TopWidgetIconManager_info._panelTable do
    if true == isShow and true == PaGlobalFunc_TopIcon_CheckShow(idx) then
      if nil ~= TopWidgetIconManager_info._openFunction[idx] then
        TopWidgetIconManager_info._openFunction[idx]()
      elseif nil ~= TopWidgetIconManager_info._panelTable[idx] then
        TopWidgetIconManager_info._panelTable[idx]:SetShow(true)
      end
    elseif nil ~= TopWidgetIconManager_info._closeFunction[idx] then
      TopWidgetIconManager_info._closeFunction[idx]()
    elseif nil ~= TopWidgetIconManager_info._panelTable[idx] then
      TopWidgetIconManager_info._panelTable[idx]:SetShow(false)
    end
  end
  PaGlobalFunc_TopIcon_UpdatePos()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    PaGlobalFunc_Widget_Party_All_Resize()
  else
    FromClient_Party_Resize()
  end
end
function PaGlobalFunc_TopIcon_CheckShow(IconType)
  local temporaryWrapper
  if TopWidgetIconType.LandVehicle == IconType or TopWidgetIconType.SeaVehicle == IconType or TopWidgetIconType.Garden == IconType then
    temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return false
    end
  end
  local selfPlayer
  if TopWidgetIconType.Summon == IconType or TopWidgetIconType.Maid == IconType then
    selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return false
    end
  end
  if TopWidgetIconType.LandVehicle == IconType then
    local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Vehicle)
    if nil ~= landVehicleWrapper then
      return true
    end
  elseif TopWidgetIconType.SeaVehicle == IconType then
    local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(CppEnums.ServantType.Type_Ship)
    if nil ~= seaVehicleWrapper then
      return true
    end
  elseif TopWidgetIconType.Pet == IconType then
    return 0 ~= ToClient_getPetUnsealedList()
  elseif TopWidgetIconType.Garden == IconType then
    return 0 < temporaryWrapper:getSelfTentCount()
  elseif TopWidgetIconType.Camp == IconType then
    return ToClient_isCampingReigsted()
  elseif TopWidgetIconType.Fairy == IconType then
    return 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList()
  elseif TopWidgetIconType.Summon == IconType then
    local summonCount = selfPlayer:getSummonListCount()
    for summonIdx = 0, summonCount - 1 do
      local summonInfo = selfPlayer:getSummonDataByIndex(summonIdx)
      local characterKey = summonInfo:getCharacterKey()
      if characterKey >= 60028 and characterKey <= 60037 or 60068 == characterKey then
        return true
      end
    end
  elseif TopWidgetIconType.Maid == IconType then
    if nil == selfPlayer:get() then
      return false
    end
    return 0 < getTotalMaidList() and 7 <= selfPlayer:get():getLevel()
  elseif TopWidgetIconType.GuildServant == IconType then
    local guildServantCount = guildstable_getUnsealGuildServantCount()
    for index = 0, guildServantCount - 1 do
      local servantWrapper = guildStable_getUnsealGuildServantAt(index)
      if nil == servantWrapper then
        return false
      end
      local vehicleType = servantWrapper:getVehicleType()
      if CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_Train == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_SiegeTower == vehicleType or CppEnums.VehicleType.Type_LargeSiegeTower == vehicleType then
        return true
      end
    end
  end
  return false
end
function FromClient_TopIcon_Inite()
  registerEvent("onScreenResize", "FromClient_TopIcon_Resize")
  if nil ~= Panel_SelfPlayerExpGage then
    TopWidgetIconManager_info._originalPartyWidgetPosY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  end
end
function FromClient_TopIcon_Resize()
  PaGlobalFunc_TopIcon_UpdatePos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_Inite")
