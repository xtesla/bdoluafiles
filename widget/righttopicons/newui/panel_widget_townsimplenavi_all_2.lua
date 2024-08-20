function PaGlobalFunc_Widget_TownSimpleNavi_All_Open()
  PaGlobal_Widget_TownSimpleNavi_All:prepareOpen()
end
function PaGlobalFunc_Widget_TownSimpleNavi_All_Close()
  PaGlobal_Widget_TownSimpleNavi_All:prepareClose()
end
function PaGlobalFunc_Widget_TownSimpleNavi_All_Update()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local regionData = getRegionInfoByPosition(selfPlayer:getPosition())
  if nil == regionData then
    return
  end
  FromClient_Widget_TownSimpleNavi_All_RegionChanged(regionData)
end
function HandleEventLUp_Widget_TownSimpleNavi_All_Expand()
  if nil == Panel_Widget_TownSimpleNavi_All then
    return
  end
  TooltipSimple_Hide()
  local isExpand = not PaGlobal_Widget_TownSimpleNavi_All._ui._stc_expandBg:GetShow()
  PaGlobal_Widget_TownSimpleNavi_All:setExpand(isExpand)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eExpandTownSimpleNavi, not isExpand, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function HandleEventLUp_Widget_TownSimpleNavi_All_NaviStart(spawnType, isAuto)
  if nil == spawnType then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if nil == isAuto then
    isAuto = false
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ToClient_DeleteNaviGuideByGroup(0)
  local position = selfPlayerWrapper:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(spawnType, position)
  if nil == nearNpcInfo then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if (nil == curChannelData or false == curChannelData._isMain) and CppEnums.SpawnType.eSpawnType_TerritoryTrade == spawnType then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_TOWNNPCNAVI_IMPERIAL_DELIVERY_ONLY_FIRSTCH"))
    return
  end
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), isAuto, isAuto)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  if false == nearNpcInfo:isTimeSpawn() then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION", "npcName", tostring(CppEnums.SpawnTypeString[spawnType])))
end
function HandleEventOnOut_Widget_TownSimpleNavi_All_ShowNpcTypeTooltip(isShow, index, spawnType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == index or nil == spawnType then
    return
  end
  local uiControl = PaGlobal_Widget_TownSimpleNavi_All._iconButtonList[index]
  if nil == uiControl then
    return
  end
  local name = CppEnums.SpawnTypeString[spawnType]
  if nil == name then
    return
  end
  local desc = ""
  TooltipSimple_Show(uiControl, name, desc)
end
function FromClient_Widget_TownSimpleNavi_All_OnScreenResize()
  PaGlobal_Widget_TownSimpleNavi_All:resize()
end
function FromClient_Widget_TownSimpleNavi_All_RegionChanged(regionData)
  if nil == regionData then
    return
  end
  local regionInfo = regionData:get()
  if nil == regionInfo then
    return
  end
  local isSafetyZone = regionInfo:isSafeZone()
  if true == isSafetyZone then
    PaGlobal_Widget_TownSimpleNavi_All:prepareOpen()
  else
    PaGlobal_Widget_TownSimpleNavi_All:prepareClose()
  end
end
