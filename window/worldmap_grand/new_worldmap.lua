local IM = CppEnums.EProcessorInputMode
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local ENT = CppEnums.ExplorationNodeType
local UI_color = Defines.Color
local VCK = CppEnums.VirtualKeyCode
local isCloseWorldMap = false
local HideAutoCompletedNaviBtn = false
local isPrevShowMainQuestPanel = false
local isPrevShowPanel = false
local isCullingNaviBtn = true
local isFirstCall = true
local renderMode = RenderModeWrapper.new(100, {
  Defines.RenderMode.eRenderMode_WorldMap
}, false)
if nil == WorldMapWindow then
  WorldMapWindow = {}
end
local altKeyGuide = ToClient_getWorldmapKeyGuideUI()
WorldMapWindow.EnumInfoNodeKeyType = {
  eInfoNodeKeyType_Waypoint = 0,
  eInfoNodeKeyType_HouseListIdx = 1,
  eInfoNodeKeyType_Region = 2,
  eInfoNodeKeyType_FixedHouseListIdx = 3
}
ToClient_WorldmapRegisterShowEventFunc(true, "FGlobal_WorldmapShowAni()")
ToClient_WorldmapRegisterShowEventFunc(false, "FGlobal_WorldmapHideAni()")
function FGlobal_WorldmapShowAni()
  local worldmapRenderUI = ToClient_getWorldmapRenderBase()
  worldmapRenderUI:ResetVertexAni()
  ToClient_WorldmapSetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  if CppEnums.WorldMapAnimationStyle.noAnimation == ToClient_getGameOptionControllerWrapper():getWorldmapOpenType() then
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_00FFFFFF)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
  elseif nil == selfPlayer or selfPlayer:getRegionInfoWrapper():isDesert() and false == selfPlayer:isResistDesert() then
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
  else
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.8, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_00FFFFFF)
    aniInfo:SetEndColor(2147483647)
    aniInfo.IsChangeChild = false
    aniInfo = worldmapRenderUI:addColorAnimation(0.8, 1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(2147483647)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
  end
  Panel_WorldMap:ResetVertexAni()
  ToClient_WorldmapSetAlpha(0)
  audioPostEvent_SystemUi(1, 2)
end
function FGlobal_WorldmapHideAni()
end
local SelectedNode
local isFadeOutWindow = false
function FGlobal_SelectedNode()
  return SelectedNode
end
local naviBtn, naviBtnSizeX, panelNaviButtonSizeY
local savedBtn = {}
local bookMarkBtn
function initializeNaviBtn()
  Panel_NaviButton:SetShow(false)
  naviBtn = UI.getChildControl(Panel_NaviButton, "Button_Navi")
  bookMarkBtn = UI.getChildControl(Panel_NaviButton, "Button_BookMark")
  bookMarkBtn:SetShow(false)
  local isGrowStep = true
  if true == _ContentsGroup_GrowStep then
    isGrowStep = ToClient_IsGrowStepOpen(__eGrowStep_worldmap1)
  end
  naviBtn:SetShow(isGrowStep)
  if true == _ContentsGroup_RenewUI_WorldMap then
    naviBtn:SetShow(false)
  end
  naviBtnSizeX = naviBtn:GetSizeX()
  panelNaviButtonSizeY = Panel_NaviButton:GetSizeY()
  naviBtn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAPNAVIBUTTON_AUTONAVI"))
  if naviBtnSizeX < naviBtn:GetTextSizeX() + 10 then
    naviBtn:SetSize(naviBtn:GetTextSizeX() + 10, naviBtn:GetSizeY())
    bookMarkBtn:SetSize(naviBtn:GetSizeX(), naviBtn:GetSizeY())
  end
  local panelSizeY = naviBtn:GetSizeY() + 10
  if true == _ContentsGroup_WorldMapBookMark and false == _ContentsGroup_RenewUI then
    panelSizeY = naviBtn:GetSizeY() + bookMarkBtn:GetSizeY() + 10
    bookMarkBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_WorldMap_BookMark_OpenFromWorldMap()")
    bookMarkBtn:SetShow(true)
  end
  Panel_NaviButton:SetSize(naviBtn:GetSizeX() + 10, panelSizeY)
  naviBtn:addInputEvent("Mouse_LUp", "HandleClicked_CompleteNode()")
  naviBtn:addInputEvent("Mouse_On", "SimpleTooltip_NodeBtn(true, 0)")
  naviBtn:addInputEvent("Mouse_Out", "SimpleTooltip_NodeBtn(false)")
  naviBtn:setButtonShortcuts("PANEL_WORLDMAPNAVIBUTTON_AUTONAVI", Defines.RenderMode.eRenderMode_WorldMap)
  for idx = 1, 3 do
    savedBtn[idx] = UI.getChildControl(Panel_NaviButton, "RadioButton_Saved_" .. tostring(idx))
    savedBtn[idx]:addInputEvent("Mouse_LUp", "HandleClicked_AddWorldMapNaviGuideInfo(" .. tostring(idx) .. ")")
    savedBtn[idx]:addInputEvent("Mouse_On", "SimpleTooltip_SaveBtn(" .. tostring(idx) .. ")")
    savedBtn[idx]:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  end
end
function WorldMap_NaviButton_RePos()
  if Panel_NaviButton:IsUse() == false then
    return
  end
  Panel_NaviButton:SetPosX(getWorldMapScenePlayerPosition().x * getScreenSizeX() - 60)
  Panel_NaviButton:SetPosY(getWorldMapScenePlayerPosition().y * getScreenSizeY() + 20)
  local playerModelPositionPosZ = getWorldMapScenePlayerPosition().z
  if playerModelPositionPosZ > 1 or playerModelPositionPosZ < 0 then
    Panel_NaviButton:SetShow(false)
  elseif isCullingNaviBtn == false then
    Panel_NaviButton:SetShow(true)
  end
end
function WorldMap_ShortcutButton_RePos()
  if Panel_NaviButton:IsUse() == false then
    return
  end
  local playerModelPositionVec
  if true == ToClient_WorldMapNaviIsLoopPath() then
    playerModelPositionVec = ToClient_getNaviEndPathPostionForOnlyLoopPath()
  else
    playerModelPositionVec = ToClient_getNaviEndPathPostion()
  end
  if 0 == playerModelPositionVec.x and 0 == playerModelPositionVec.y and 0 == playerModelPositionVec.z then
    isCullingNaviBtn = true
    Panel_NaviButton:SetShow(false)
  end
  Panel_NaviButton:SetPosX(playerModelPositionVec.x * getScreenSizeX() - 60)
  Panel_NaviButton:SetPosY(playerModelPositionVec.y * getScreenSizeY() + 60)
  if playerModelPositionVec.z > 1 or 0 > playerModelPositionVec.z then
    Panel_NaviButton:SetShow(false)
  elseif isCullingNaviBtn == false then
    if nil ~= Panel_Worldmap_WaypointPreset and true == Panel_Worldmap_WaypointPreset:IsShow() then
      return
    end
    Panel_NaviButton:SetShow(true)
  else
    Panel_NaviButton:SetShow(false)
  end
end
function WorldMap_DetectUserButton_RePos()
  if false == Panel_DetectUserButton:IsShow() then
    return
  end
  if true == ToClient_WorldMapNaviIsLoopPath() then
    Panel_DetectUserButton:SetPosX(ToClient_getNaviEndPathPostionForOnlyLoopPath().x * getScreenSizeX() - 60)
    Panel_DetectUserButton:SetPosY(ToClient_getNaviEndPathPostionForOnlyLoopPath().y * getScreenSizeY() - 60)
  else
    Panel_DetectUserButton:SetPosX(ToClient_getNaviEndPathPostion().x * getScreenSizeX() - 60)
    Panel_DetectUserButton:SetPosY(ToClient_getNaviEndPathPostion().y * getScreenSizeY() - 60)
  end
end
function HandleClicked_SaveBookMark()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:isInstancePlayer() then
    return
  end
  if nil == selfPlayer:getRegionInfoWrapper() then
    return
  end
  local isDesert = selfPlayer:getRegionInfoWrapper():isDesert()
  if nil ~= isDesert and true == isDesert then
    return
  end
  bookMarkBtn:SetShow(true)
  for idx = 1, 3 do
    savedBtn[idx]:SetShow(false)
  end
end
function HandleClicked_CompleteNode()
  if ToClient_WorldMapNaviEmpty() == true or ToClient_WorldMapNaviIsLoopPath() == true or false ~= HideAutoCompletedNaviBtn then
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_LOCALWAR_CANTNAVI_ACK"))
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil == selfPlayer:getRegionInfoWrapper() then
    return
  end
  if nil ~= Panel_WorldMap_BookMark and true == Panel_WorldMap_BookMark:GetShow() then
    PaGlobalFunc_WorldMap_BookMark_Close()
  end
  local isDesert = selfPlayer:getRegionInfoWrapper():isDesert()
  if nil ~= isDesert and true == isDesert then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_OnCompletedNodeLoop(NavigationGuideParam())
  TooltipSimple_Hide()
  naviBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVITITLE"))
  bookMarkBtn:SetShow(false)
  if naviBtnSizeX < naviBtn:GetTextSizeX() + 10 then
    naviBtn:SetSize(naviBtn:GetTextSizeX() + 10, naviBtn:GetSizeY())
    bookMarkBtn:SetSize(naviBtn:GetSizeX(), naviBtn:GetSizeY())
  end
  Panel_NaviButton:SetSize(naviBtn:GetSizeX() + 10, panelNaviButtonSizeY)
  for idx = 1, 3 do
    savedBtn[idx]:SetShow(true)
  end
  ToClient_SetTmpWorldMapNaviGuideInfo()
  naviBtn:SetIgnore(true)
end
function HandleClicked_AddWorldMapNaviGuideInfo(idx)
  Panel_NaviButton:SetShow(false)
  isCullingNaviBtn = true
  savedBtn[idx]:SetCheck(false)
  TooltipSimple_Hide()
  ToClient_AddWorldMapNaviGuidePath(idx - 1)
  PaGlobal_Worldmap_Grand_WaypointPreset_Update()
end
function SimpleTooltip_NodeBtn(isShow, tipType)
  if not isShow then
    ToClient_OnNaviRenderAsloopPath(isShow)
    TooltipSimple_Hide()
    return
  end
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAPNAVIBUTTON_AUTONAVI")
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVITITLE")
  end
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVIDESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  control = naviBtn
  TooltipSimple_Show(control, name, desc)
  ToClient_OnNaviRenderAsloopPath(isShow)
end
function SimpleTooltip_SaveBtn(idx)
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVITITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVI_DESC")
  TooltipSimple_Show(savedBtn[idx], name, desc)
end
function FromClient_DeleteNaviGuidOnTheWorldmapPanel()
  ToClient_DeleteNaviGuideByGroup(0)
  Panel_NaviButton:SetShow(false)
end
function FromClient_RClickWorldmapPanel(pos3D, immediately, isTopPicking)
  if true == _ContentsGroup_InstanceHorseRacing and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSERACING_CANT_WAYPOINT"))
    return
  end
  if nil ~= PaGlobalFunc_SetLastFindNodeKey then
    PaGlobalFunc_SetLastFindNodeKey(nil)
  end
  if false == immediately and ToClient_IsShowNaviGuideGroup(0) then
    if true == PaGlobal_TutorialManager:isDoingTutorial() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_TUTORIAL_ACK"))
      return
    end
    if isKeyPressed(VCK.KeyCode_MENU) then
      ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), false, isTopPicking)
      WorldMap_ShortcutButton_RePos()
    else
      ToClient_DeleteNaviGuideByGroup(0)
      Panel_NaviButton:SetShow(false)
      audioPostEvent_SystemUi(0, 15)
      isCullingNaviBtn = true
    end
    if ToClient_WorldMapNaviIsLoopPath() == true then
      ToClient_DeleteNaviGuideByGroup(0)
      ToClient_OnCompletedNodeLoop(NavigationGuideParam())
      TooltipSimple_Hide()
      naviBtn:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_AUTONAVITITLE"))
      bookMarkBtn:SetShow(false)
      if naviBtnSizeX < naviBtn:GetTextSizeX() + 10 then
        naviBtn:SetSize(naviBtn:GetTextSizeX() + 10, naviBtn:GetSizeY())
        bookMarkBtn:SetSize(naviBtn:GetSizeX(), naviBtn:GetSizeY())
      end
      Panel_NaviButton:SetSize(naviBtn:GetSizeX() + 10, panelNaviButtonSizeY)
      for idx = 1, 3 do
        savedBtn[idx]:SetShow(true)
      end
      ToClient_SetTmpWorldMapNaviGuideInfo()
      naviBtn:SetIgnore(true)
    end
    return
  end
  if 0 ~= ToClient_GetMyTeamNoLocalWar() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_LOCALWAR_CANTNAVI_ACK"))
    return
  end
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_TUTORIAL_ACK"))
    return
  end
  if false == isKeyPressed(VCK.KeyCode_MENU) then
    ToClient_DeleteNaviGuideByGroup(0)
  end
  ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), false, isTopPicking)
  audioPostEvent_SystemUi(0, 14)
  local selfPlayer = getSelfPlayer()
  isCullingNaviBtn = true
  if ToClient_WorldMapNaviPickingIsDesert(pos3D) == false and selfPlayer:getRegionInfoWrapper():isDesert() == false and ToClient_WorldMapNaviIsLoopPath() == false and selfPlayer:getRegionInfoWrapper():isOcean() == false and ToClient_WorldMapNaviEmpty() == false and HideAutoCompletedNaviBtn == false then
    isCullingNaviBtn = false
    PaGlobal_Worldmap_Grand_WaypointPreset_Close()
    for idx = 1, 3 do
      savedBtn[idx]:SetShow(false)
    end
    WorldMap_ShortcutButton_RePos()
    naviBtn:SetIgnore(false)
    naviBtn:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAPNAVIBUTTON_AUTONAVI"))
    if naviBtnSizeX < naviBtn:GetTextSizeX() + 10 then
      naviBtn:SetSize(naviBtn:GetTextSizeX() + 10, naviBtn:GetSizeY())
      bookMarkBtn:SetSize(naviBtn:GetSizeX(), naviBtn:GetSizeY())
    end
    local panelSizeY = naviBtn:GetSizeY() + 10
    if true == _ContentsGroup_WorldMapBookMark and false == _ContentsGroup_RenewUI then
      panelSizeY = panelNaviButtonSizeY
      bookMarkBtn:SetShow(true)
    end
    Panel_NaviButton:SetSize(naviBtn:GetSizeX() + 10, panelSizeY)
    Panel_NaviButton:SetShow(true)
  end
  HideAutoCompletedNaviBtn = false
end
function FromClient_WorldMapFadeOutHideUI(frameTime)
  local worldmapRenderUI = ToClient_getWorldmapRenderBase()
  worldmapRenderUI:ResetVertexAni()
  local selfPlayer = getSelfPlayer()
  if CppEnums.WorldMapAnimationStyle.noAnimation == ToClient_getGameOptionControllerWrapper():getWorldmapOpenType() then
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(false)
    aniInfo:SetDisableWhileAni(true)
    Panel_WorldMap:ResetVertexAni()
    aniInfo = Panel_WorldMap:addColorAnimation(0, 0.3, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(true)
    aniInfo:SetDisableWhileAni(true)
  elseif nil == selfPlayer or selfPlayer:getRegionInfoWrapper():isDesert() and false == selfPlayer:isResistDesert() then
    ToClient_WorldmapSetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(false)
    aniInfo:SetDisableWhileAni(true)
    Panel_WorldMap:ResetVertexAni()
    aniInfo = Panel_WorldMap:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(true)
    aniInfo:SetDisableWhileAni(true)
  else
    ToClient_WorldmapSetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
    local aniInfo = worldmapRenderUI:addColorAnimation(0, 0.5 * frameTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(2147483647)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(false)
    aniInfo:SetDisableWhileAni(true)
    aniInfo = worldmapRenderUI:addColorAnimation(0.5 * frameTime, 1 * frameTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(2147483647)
    aniInfo:SetEndColor(UI_color.C_00FFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(true)
    aniInfo:SetDisableWhileAni(true)
    Panel_WorldMap:ResetVertexAni()
    aniInfo = Panel_WorldMap:addColorAnimation(0, 1 * frameTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_LINEAR)
    aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
    aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
    aniInfo.IsChangeChild = false
    aniInfo:SetHideAtEnd(true)
    aniInfo:SetDisableWhileAni(true)
  end
  ToClient_WorldmapSetAlpha(1)
  audioPostEvent_SystemUi(1, 3)
end
function FromClient_LClickedWorldMapNode(explorationNode)
  SelectedNode = explorationNode:FromClient_getExplorationNodeInClient()
  PaGlobal_TutorialManager:handleLClickWorldMapNode(explorationNode)
end
function FromClient_NodeIsNextSiege(explorationNode)
  explorationNode:EraseAllEffect()
  if false == _ContentsGroup_ConquestSiege then
    explorationNode:AddEffect("UI_ArrowMark_Diagonal01", true, 70, 80)
  end
end
function FromClient_KnowledgeWorldMapPath(pos3D)
  local navParam = NavigationGuideParam()
  navParam._worldmapColor = float4(1, 0.55, 0.55, 0.55)
  navParam._worldmapBgColor = float4(1, 0.85, 0.85, 0.6)
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos3D, navParam, false, true)
  audioPostEvent_SystemUi(0, 14)
end
function UpdateWorldMapNode(node)
  local plantKey = node:getPlantKey()
  local nodeKey = plantKey:getWaypointKey()
  local wayPlant = ToClient_getPlant(plantKey)
  local exploreLevel = node:getLevel()
  local affiliatedTownKey = 0
  local nodeSSW = node:getStaticStatus()
  local regionInfo = nodeSSW:getMinorSiegeRegion()
  if nil ~= wayPlant then
    affiliatedTownKey = ToClinet_getPlantAffiliatedWaypointKey(wayPlant)
  end
  if true == _ContentsGroup_ForXBoxFinalCert then
    if nil ~= PaGlobalFunc_WorldMapSideBar_EraseArrow then
      PaGlobalFunc_WorldMapSideBar_EraseArrow()
    end
    PaGlobalFunc_WorldMapNodeInfo_Open(node)
    WorldMapPopupManager:increaseLayer()
    WorldMapPopupManager:push(Panel_Worldmap_NodeInfo_Console, true)
  else
    if nil ~= WorldMapArrowEffectEraseClear then
      WorldMapArrowEffectEraseClear()
    end
    FGlobal_ShowInfoNodeMenuPanel(node)
    WorldMapPopupManager:increaseLayer()
    WorldMapPopupManager:push(Panel_NodeMenu, true)
    if nil ~= regionInfo and true == ToClient_IsGrowStepOpen(__eGrowStep_worldmap3) then
      local regionKey = regionInfo._regionKey
      local regionWrapper = getRegionInfoWrapper(regionKey:get())
      local minorSiegeWrapper = regionWrapper:getMinorSiegeWrapper()
      if nil ~= minorSiegeWrapper then
        WorldMapPopupManager:push(Panel_NodeOwnerInfo, true)
      end
    end
    FGlobal_OpenOtherPanelWithNodeMenu(node, true)
  end
  FGlobal_FilterClear()
  NodeName_ShowToggle(true)
end
function FGlobal_OpenOtherPanelWithNodeMenu(node, isShow)
  if false == ToClient_WorldMapIsShow() then
    return
  end
  if true ~= isShow then
    return
  end
  if false == Panel_NodeMenu:IsShow() then
    return
  end
  if true == _ContentsGroup_GrowStep and false == ToClient_IsGrowStepOpen(__eGrowStep_node) then
    Panel_NodeMenu:SetShow(false)
    Panel_NodeOwnerInfo:SetShow(false)
    return
  end
  local plantKey = node:getPlantKey()
  local nodeKey = plantKey:getWaypointKey()
  local wayPlant = ToClient_getPlant(plantKey)
  local exploreLevel = node:getLevel()
  if exploreLevel > 0 and wayPlant ~= nil and wayPlant:getType() == CppEnums.PlantType.ePlantType_Zone then
    local workingcnt = ToClient_getPlantWorkingList(plantKey)
    if 0 == workingcnt then
      local _plantKey = node:getPlantKey()
      local nod_Key = _plantKey:get()
      local explorationSSW = ToClient_getExplorationStaticStatusWrapper(nod_Key)
      if explorationSSW:get():isFinance() then
        FGlobal_Finance_WorkManager_Reset_Pos()
        FGlobal_Finance_WorkManager_Open(node)
      else
        FGlobal_Plant_WorkManager_Reset_Pos()
        FGlobal_Plant_WorkManager_Open(node)
      end
    elseif 1 == workingcnt then
      FGlobal_ShowWorkingProgress(node, 1)
    end
  end
end
function FromClient_WorldMapNodeFindNearNode(nodeKey)
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapFindNearNode(nodeKey, NavigationGuideParam())
  audioPostEvent_SystemUi(0, 14)
end
function FromClient_WorldMapNodeFindTargetNode(nodeKey)
  local explorationSSW = ToClient_getExplorationStaticStatusWrapper(nodeKey)
  if nil == explorationSSW then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(explorationSSW:get():getPosition(), NavigationGuideParam(), false, false)
  audioPostEvent_SystemUi(0, 14)
end
function FGlobal_LoadWorldMapTownSideWindow(nodeKey)
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(nodeKey)
  if nil ~= regionInfoWrapper and regionInfoWrapper:get():isMainOrMinorTown() and regionInfoWrapper:get():hasWareHouseNpc() then
    if _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_OpenPanelFromWorldmap(nodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    else
      Warehouse_OpenPanelFromWorldmap(nodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
    end
  end
end
function FGlobal_PushOpenWorldMap()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_BLOCKING_WORLDMAP"))
    return
  end
  if ToClient_RestrictContentsByRegion(__eRestrictContentsType_WorldMap) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Gacha_Roulette then
    return
  end
  if CppEnums.worldmapRenderState.NOT_RENDER ~= ToClient_getWorldmapRenderState() then
    return
  end
  if true == ToClient_SniperGame_IsPlaying() then
    return
  end
  if Panel_Casting_Bar:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NOTOPEN_INGACTION"))
    return
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  if nil ~= ServantInventory_Close then
    ServantInventory_Close()
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    PaGlobal_Widget_ThornCastle_Map_Toggle()
    return
  end
  PaGlobalFunc_FullScreenFade_RunAfterFadeIn(FGlobal_PushOpenWorldMapActual)
end
function FGlobal_PushOpenWorldMapActual()
  PaGlobalFunc_FullScreenFade_FadeOut()
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
    PaGlobalFunc_WorkerManager_All_Close()
  else
    FGlobal_HideWorkerTooltip()
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_Close()
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_Hide()
  else
    FGlobal_HideDialog()
  end
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Close()
  end
  ToClient_AddWorldMapFlush()
end
function FGlobal_CloseWorldmapForLuaKeyHandling()
  if Defines.UIMode.eUIMode_WoldMapSearch == GetUIMode() then
    ClearFocusEdit()
    SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  end
  FGlobal_PopCloseWorldMap()
end
function FGlobal_PopCloseWorldMap()
  if ToClient_WorldMapIsShow() then
    PaGlobalFunc_FullScreenFade_RunAfterFadeIn(FGlobal_PopCloseWorldMapActual)
  end
end
function FGlobal_PopCloseWorldMapActual()
  PaGlobalFunc_FullScreenFade_FadeOut()
  ToClient_preCloseMap()
  Panel_WorldMap_NodeTooltip:SetShow(false)
  Panel_WorldMap_Tooltip:SetShow(false)
  if true == _ContentsGroup_NewUI_Quest_All then
    if false == _ContentsGroup_RenewUI then
      PaGlobalFunc_Quest_All_Close()
    end
  elseif false == _ContentsGroup_RenewUI then
    Panel_Window_QuestNew_Show(false)
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace and true == PaGlobalFunc_MarketPlace_GetShow() then
    PaGlobalFunc_MarketPlace_CloseAllCheck()
  end
  Panel_Tooltip_SimpleText:SetShow(false)
  isCloseWorldMap = false
  Panel_NaviButton:SetShow(false)
  if true == _ContentsGroup_ForXBoxFinalCert then
    PaGlobalFunc_WorldMapSideBar_EraseArrow()
  else
    WorldMapArrowEffectErase()
  end
  DeliveryCarriageInformationWindow_Close()
  FGlobal_Hide_Tooltip_Work(nil, true)
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
  else
    FGlobal_HideWorkerTooltip()
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
  if nil ~= Panel_WorldMap_BookMark and true == Panel_WorldMap_BookMark:GetShow() then
    PaGlobalFunc_WorldMap_BookMark_Close()
  end
  if nil ~= PaGlobalFunc_RandomQuestInfo_All_GetShow and true == PaGlobalFunc_RandomQuestInfo_All_GetShow() then
    PaGlobalFunc_RandomQuestInfo_All_Close()
  end
end
function FromClient_WorldMapOpen()
  if isDeadInWatchingMode() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPOPENALERT_INDEAD"))
    return
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_ConsoleWorldMapKeyGuide_SetShow(true)
  end
  isFadeOutWindow = false
  ToClient_SaveUiInfo(false)
  if ToClient_WorldMapIsShow() then
    FGlobal_PopCloseWorldMap()
    return
  end
  if MessageBoxGetShow() then
    allClearMessageData()
  end
  if ToClient_CheckExistSummonMaid() or Panel_Window_Warehouse:GetShow() then
    if _ContentsGroup_NewUI_WareHouse_All then
      PaGlobal_Warehouse_All_Close()
    else
      Warehouse_Close()
    end
  end
  PaGlobal_TutorialManager:handleBeforeWorldmapOpen()
  Panel_MovieTheater640_Initialize()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  ToClient_CheckConditionForMonsterShow()
  ToClient_openWorldMap()
  setFullSizeMode(true, FullSizeMode.fullSizeModeEnum.Worldmap)
  if _ContentsGroup_NewUI_NpcNavi_All then
    PaGlobal_NpcNavi_All_ShowRequestOuter()
  else
    FGlobal_NpcNavi_ShowRequestOuter()
  end
  if true == _ContentsGroup_NewUI_Dialog_All then
    PaGlobalFunc_DialogMain_All_ShowToggle(false)
  elseif true == _ContentsGroup_RenewUI_Dailog then
    PaGlobalFunc_MainDialog_Close()
  else
    Panel_Npc_Dialog:SetShow(false)
  end
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManager_All_Close()
  else
    workerManager_Close()
  end
  if true == _ContentsGroup_Barter and nil ~= Panel_Window_Barter_Search and true == Panel_Window_Barter_Search:GetShow() then
    PaGlobal_BarterInfoSearch_Close_FromWorldMap()
  end
  FGlobal_NpcNavi_Hide()
  FGlobal_WarInfo_Open()
  FGlobal_NodeWarInfo_Open()
  if true == _ContentsGroup_ForXBoxFinalCert then
    PaGlobalFunc_WorldMapSideBar_Open()
  elseif false == _ContentsGroup_ForXBoxXR then
    FGlobal_WorldMapOpenForMenu()
    FGlobal_WorldMapOpenForMain()
  end
  isPrevShowPanel = Panel_CheckedQuest:GetShow()
  isPrevShowMainQuestPanel = Panel_MainQuest:GetShow()
  FGlobal_QuestWidget_Close()
  if false == _ContentsGroup_RenewUI_Worker then
    if true == _ContentsGroup_NewUI_WorkerManager_All then
      PaGlobalFunc_WorkerManager_All_Close()
    else
      FGlobal_workerChangeSkill_Close()
      if not Panel_WorkerRestoreAll:IsUISubApp() then
        workerRestoreAll_Close()
      end
    end
  else
  end
  if _ContentsGroup_HarvestList_All then
    PaGlobal_Worldmap_TentInfo_All_Close()
  else
    FGlobal_TentTooltipHide()
  end
  if true == _ContentsGroup_NewUI_Quest_All then
    if true == PaGlobalFunc_QuestInfo_All_GetShow() and not Panel_Window_QuestInfo_All:IsUISubApp() then
      PaGlobalFunc_QuestInfo_All_Close()
    end
  elseif Panel_CheckedQuestInfo:GetShow() and not Panel_CheckedQuestInfo:IsUISubApp() then
    Panel_CheckedQuestInfo:SetShow(false)
  end
  FGolbal_ItemMarketNew_Close()
  if PaGlobalFunc_ItemMarketItemSet_GetShow() then
    FGlobal_ItemMarketItemSet_Close()
  end
  if Panel_ChatOption:GetShow() then
    ChattingOption_Close()
  end
  isCullingNaviBtn = true
  Panel_WorldMapNaviBtn()
  Panel_Tooltip_Item_hideTooltip()
  delivery_requsetList()
  renderMode:set()
  if true == ToClient_WorldMapIsShow() then
    PaGlobal_TutorialManager:handleWorldMapOpenComplete()
  end
  if true ~= _ContentsGroup_ForXBoxXR or false == _ContentsGroup_ForXBoxFinalCert then
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_WORLDMAP")
  local worldmapTabNo = ToClient_GetWorldMapTabNo()
  if 0 ~= worldmapTabNo then
    WorldMapStateChange(worldmapTabNo)
    FromClient_NewWorldMap_RenderStateChange(worldmapTabNo)
  end
end
function FGlobal_Worldmap_SetRenderMode(renderModeList)
  renderMode:setRenderMode(renderModeList)
end
function FGlobal_Worldmap_ResetRenderMode()
  renderMode:reset()
end
function Panel_WorldMapNaviBtn()
  if ToClient_WorldMapNaviEmpty() == false and ToClient_WorldMapNaviIsLoopPath() == false then
    local naviEndPos = ToClient_getNaviEndPathPostion()
    if naviEndPos.x == 0 and naviEndPos.y == 0 and naviEndPos.z == 0 then
      isCullingNaviBtn = true
    else
      isCullingNaviBtn = false
    end
    PaGlobal_Worldmap_Grand_WaypointPreset_Close()
    if false == isCullingNaviBtn then
      local panelSizeY = naviBtn:GetSizeY() + 10
      if true == _ContentsGroup_WorldMapBookMark and false == _ContentsGroup_RenewUI then
        panelSizeY = panelNaviButtonSizeY
        bookMarkBtn:SetShow(true)
      end
      Panel_NaviButton:SetSize(naviBtn:GetSizeX() + 10, panelSizeY)
      Panel_NaviButton:SetShow(true)
      for idx = 1, 3 do
        savedBtn[idx]:SetShow(false)
      end
      WorldMap_ShortcutButton_RePos()
    end
    return
  end
  Panel_NaviButton:SetShow(false)
end
local handleClickedHouseControlBuyMansionLand = function()
  local actorWrapper = interaction_getInteractable()
  if nil == actorWrapper then
    return
  end
  local characterKey = actorWrapper:getCharacterKeyRaw()
  ToClient_RequestBuyHouse(characterKey, 0, 1)
end
function FGlobal_OpenWorldMapWithHouse()
  local actorWrapper = interaction_getInteractable()
  if true == actorWrapper:isMansionLand() then
    local characterKey = actorWrapper:getCharacterKeyRaw()
    local houseInfoStaticStatusWrapper = ToClient_GetHouseInfoStaticStatusWrapper(characterKey)
    if false == houseInfoStaticStatusWrapper:isSet() then
      return
    end
    local nextRentHouseLevel = 1
    local useType = 0
    local realIndex = houseInfoStaticStatusWrapper:getIndexByReceipeKey(useType)
    local houseInfoCraftWrapper = houseInfoStaticStatusWrapper:getHouseCraftWrapperByIndex(realIndex)
    local listCount = houseInfoStaticStatusWrapper:getNeedItemListCount(useType, nextRentHouseLevel)
    local needTime_sec = houseInfoStaticStatusWrapper:getTransperTime(useType, nextRentHouseLevel, nextRentHouseLevel)
    local needTime = Util.Time.timeFormatting(needTime_sec)
    local houseName = houseInfoStaticStatusWrapper:getName()
    local useTypeName = houseInfoStaticStatusWrapper:getName()
    local itemExplain = ""
    local needPoint = ToClient_getNeenPointMansion(characterKey)
    itemExplain = itemExplain .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_NEEDPOINT", "needPoint", needPoint) .. "\n"
    itemExplain = itemExplain .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_NEEDTIME", "needTime", needTime)
    itemExplain = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_BUYHOUSE_CONTENT", "houseName", houseName, "useTypeName", useTypeName) .. [[


]] .. itemExplain
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSECONTROL_BUYHOUSE_TITLE"),
      content = itemExplain,
      functionYes = handleClickedHouseControlBuyMansionLand,
      functionCancel = MessageBox_Empty_function
    }
    MessageBox.showMessageBox(messageboxData, "top")
  else
    FGlobal_PushOpenWorldMap()
    ToClient_OpenWorldMapWithHouse(actorWrapper:get())
    isCloseWorldMap = false
  end
end
function FGlobal_WorldMapCloseBeforeCheck()
  if true == _ContentsGroup_WorldMapNodeNavigation and nil ~= Panel_Worldmap_NodeCal and true == Panel_Worldmap_NodeCal:GetShow() then
    PaGlobal_Worldmap_Grand_NodeNavigation_Close()
    return false
  end
  if false == _ContentsGroup_RenewUI then
    if true == _ContentsGroup_NewUI_Quest_All then
      if Panel_Window_Quest_All:GetShow() and Panel_Window_Quest_All:IsUISubApp() == false then
        PaGlobalFunc_Quest_All_Close()
        return false
      end
    elseif Panel_Window_Quest_New:GetShow() and Panel_Window_Quest_New:IsUISubApp() == false then
      Panel_Window_QuestNew_Show(false)
      return false
    end
  end
  if PaGlobalFunc_ItemMarketBidDesc_GetShow() then
    Panel_ItemMarket_BidDesc_Hide()
    return false
  end
  if PaGlobalFunc_ItemMarket_GetShow() and PaGlobalFunc_ItemMarket_IsUISubApp() == false then
    FGolbal_ItemMarketNew_Close()
    return false
  end
  if PaGlobalFunc_ItemMarketItemSet_GetShow() then
    FGlobal_ItemMarketItemSet_Close()
    return false
  end
  if nil ~= Panel_MovieWorldMapGuide_Web and Panel_MovieWorldMapGuide_Web:GetShow() then
    PaGlobal_MovieGuide_Weblist:Close()
    return false
  end
  if false == _ContentsGroup_UsePadSnapping and true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and true == PaGlobalFunc_SubWallet_IsShow() then
    PaGlobalFunc_SubWallet_Close()
    return false
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace and true == PaGlobalFunc_MarketPlace_GetShow() then
    PaGlobalFunc_MarketPlace_CloseAllCheck()
    return false
  end
  if true == _ContentsGroup_NewUI_Servant_All and nil ~= Panel_Dialog_ServantMarket_All and true == Panel_Dialog_ServantMarket_All:GetShow() then
    PaGlobalFunc_ServantMarket_All_Close()
    return false
  end
  if nil ~= Panel_Worldmap_WaypointOption and true == Panel_Worldmap_WaypointOption:GetShow() then
    PaGlobal_Worldmap_Grand_WaypointOption_Close()
    return false
  end
  if nil ~= Panel_Worldmap_WaypointPreset and true == Panel_Worldmap_WaypointPreset:GetShow() then
    PaGlobal_Worldmap_Grand_WaypointPreset_Close()
    return false
  end
  if nil ~= Panel_WorldMap_BookMark and true == Panel_WorldMap_BookMark:GetShow() then
    PaGlobalFunc_WorldMap_BookMark_Close()
    return false
  end
  if nil ~= Panel_NpcNavi_All and true == FGlobal_NpcNavi_IsShowCheck() then
    PaGlobal_NpcNavi_All_ShowToggle()
    return false
  end
  if false == _ContentsGroup_RenewUI_Worker then
    if Panel_WorkerTrade_Caravan:GetShow() and nil ~= Panel_WorkerTrade_Caravan then
      FGlobal_WorkerTradeCaravan_Hide()
      return false
    end
  elseif true == _ContentsGroup_NewUI_WorkerAuction_All and nil ~= Panel_Window_WorkerAuction_All then
    HandleEventLUp_WorkerAuction_All_Close()
  elseif nil ~= Panel_Dialog_WorkerTrade_Renew then
    FGlobal_WorkerTrade_Close()
  end
  if true == _ContentsGroup_NewUI_WorkerManager_All and nil ~= PaGlobalFunc_WorkerManagerChangeName_All_GetShow and true == PaGlobalFunc_WorkerManagerChangeName_All_GetShow() then
    PaGlobalFunc_WorkerManagerChangeName_All_Close()
    return false
  end
  if true == _ContentsGroup_NewUI_TradeMarket_All and nil ~= Panel_Dialog_Trade_Tooltip_All and true == Panel_Dialog_Trade_Tooltip_All:GetShow() then
    PaGlobalFunc_TradeMarketItemToolTip_All_Hide()
  end
  if true == _ContentsGroup_Barter then
    if nil ~= Panel_Window_Barter_Search and true == Panel_Window_Barter_Search:GetShow() and false == Panel_Window_Barter_Search:IsUISubApp() then
      PaGlobal_BarterInfoSearch_Close_FromWorldMap()
      return false
    end
    if nil ~= Panel_Window_Barter_Search_Special and true == Panel_Window_Barter_Search_Special:GetShow() then
      PaGlobal_BarterInfoSearch_Special:close()
      return false
    end
    if nil ~= Panel_Window_Barter_Refresh and true == Panel_Window_Barter_Refresh:GetShow() then
      PaGlobal_BarterInfoRefresh:close()
      return false
    end
  end
  if nil ~= Panel_Window_WareHouse_Search and true == Panel_Window_WareHouse_Search:GetShow() then
    PaGlobal_Warehouse_Search_All_Close()
    return false
  end
  if nil ~= Panel_Window_Delivery_All and true == Panel_Window_Delivery_All:GetShow() then
    PaGlobal_Delivery_All:prepareClose()
    return false
  end
  if nil ~= PaGlobalFunc_QuestInfo_All_GetShow and true == PaGlobalFunc_QuestInfo_All_GetShow() then
    PaGlobalFunc_QuestInfo_All_Close()
    return false
  end
  return true
end
function FGlobal_WorldMapWindowEscape()
  TooltipSimple_Hide()
  if false == FGlobal_WorldMapCloseBeforeCheck() then
    return false
  end
  local _panel_TradeMarket_EventInfo = true == _ContentsGroup_isUsedNewTradeEventNotice and Panel_Window_TradeEventNotice_Renewal_All or Panel_TradeEventNotice_Renewal or Panel_TradeMarket_EventInfo
  local _panel_HouseControl = true == _ContentsGroup_ForXBoxFinalCert and Panel_Worldmap_HouseCraft or Panel_HouseControl
  local _panel_TradeMarket = true == _ContentsGroup_NewUI_TradeMarket_All and Panel_Worldmap_Trade_MarketItemList_All or Panel_Trade_Market_Graph_Window
  local _panel_WorkerManager = true == _ContentsGroup_NewUI_WorkerManager_All and Panel_Window_WorkerManager_All or Panel_WorkerManager
  local _worldmapUI = {
    [0] = _panel_TradeMarket_EventInfo:GetShow() == false or true == _panel_TradeMarket_EventInfo:IsUISubApp(),
    [1] = _panel_HouseControl:GetShow() == false,
    [2] = Panel_LargeCraft_WorkManager:GetShow() == false,
    [3] = Panel_RentHouse_WorkManager:GetShow() == false,
    [4] = Panel_Building_WorkManager:GetShow() == false,
    [5] = Panel_House_SellBuy_Condition:GetShow() == false,
    [6] = PaGlobalFunc_PanelDelivery_GetShow() == false,
    [7] = _panel_TradeMarket:GetShow() == false,
    [8] = _panel_WorkerManager:GetShow() == false,
    [9] = Worldmap_Grand_GuildHouseControl:GetShow() == false,
    [10] = Worldmap_Grand_GuildCraft:GetShow() == false,
    [11] = Panel_NodeStable:GetShow() == false,
    [12] = Panel_Window_Warehouse:GetShow() == false,
    [13] = Panel_Window_Delivery_InformationView:GetShow() == false,
    [14] = Panel_CheckedQuest:GetShow() == false or true == Panel_CheckedQuest:IsUISubApp(),
    [15] = PaGlobalFunc_ItemMarket_GetShow() == false or true == PaGlobalFunc_ItemMarket_IsUISubApp(),
    [16] = Panel_WorldMap_MovieGuide:GetShow() == false
  }
  if false == _ContentsGroup_NewUI_WorkerManager_All then
    _worldmapUI[17] = Panel_WorkerTrade:GetShow() == false
    _worldmapUI[18] = Panel_WorkerTrade_Caravan:GetShow() == false
  end
  if true == _ContentsGroup_WorldMapNodeNavigation then
    _worldmapUI[19] = PaGlobal_Worldmap_Grand_NodeNavigation_GetShow() == false
  end
  if true == ToClient_WorldMapIsShow() then
    local isWorldMapUIOff = false
    for uiIdx = 0, #_worldmapUI do
      if true == _worldmapUI[uiIdx] then
        isWorldMapUIOff = true
      else
        isWorldMapUIOff = false
        break
      end
    end
    if true == isWorldMapUIOff then
      ToClient_WorldMapPushEscape()
    end
    if true == _ContentsGroup_NewUI_Delivery_All then
      if nil ~= PaGlobal_Delivery_All and true == Panel_Window_Delivery_All:GetShow() then
        PaGlobal_InformationView:update()
      end
    elseif true == _ContentsGroup_NewDelivery and nil ~= PaGlobal_InformationView and true == Panel_Window_Delivery_Information:GetShow() then
      PaGlobal_InformationView:update()
    end
    if false == _ContentsGroup_ForXBoxXR and false == _ContentsGroup_ForXBoxFinalCert then
      FGlobal_WarInfo_Open()
      FGlobal_NodeWarInfo_Open()
    end
    if not WorldMapPopupManager:pop() then
      FGlobal_PopCloseWorldMap()
    end
  end
  if 0 > WorldMapPopupManager._currentMode then
    FGlobal_WorldMapCloseSubPanel()
    FGlobal_HideAll_Tooltip_Work_Copy()
  end
  if true == _ContentsGroup_GrowStep and false == ToClient_IsGrowStepOpen(__eGrowStep_node) then
    Panel_NodeMenu:SetShow(false)
    Panel_NodeOwnerInfo:SetShow(false)
  end
  return true
end
function FromClient_ExitWorldMap()
  isCloseWorldMap = true
end
function FromClient_WorldMapFadeOut()
  isFadeOutWindow = true
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingInfo_Close()
  else
    ChatInput_Close()
  end
end
function FGlobal_IsFadeOutState()
  return isFadeOutWindow
end
function FGlobal_AskCloseWorldMap()
  return isCloseWorldMap
end
local IM = CppEnums.EProcessorInputMode
function FGlobal_WorldMapClose()
  if _ContentsGroup_HarvestList_All then
    PaGlobal_Worldmap_TentInfo_All_Close()
  else
    FGlobal_TentTooltipHide()
  end
  isFadeOutWindow = false
  DragManager:clearInfo()
  WorldMapPopupManager:clear()
  setFullSizeMode(false)
  renderMode:reset()
  Panel_WorldMap:ResetVertexAni()
  Panel_WorldMap:SetShow(false, false)
  ToClient_closeWorldMap()
  if _ContentsGroup_NewUI_NpcNavi_All then
    PaGlobal_NpcNavi_All_ShowRequestOuter()
  else
    FGlobal_NpcNavi_ShowRequestOuter()
  end
  setShowLine(true)
  collectgarbage("collect")
  FGlobal_WorldMapCloseSubPanel()
  FGlobal_WarInfo_Close()
  FGlobal_NodeWarInfo_Close()
  isCloseWorldMap = false
  if false == isFirstCall then
    Panel_CheckedQuest:SetShow(isPrevShowPanel)
    Panel_MainQuest:SetShow(isPrevShowMainQuestPanel)
    isPrevShowPanel = false
    isPrevShowMainQuestPanel = false
  end
  isFirstCall = false
  if false == _ContentsGroup_RenewUI_Worker then
    if true == _ContentsGroup_NewUI_WorkerManager_All then
      if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
        PaGlobalFunc_WorkerManager_All_Close()
      end
    elseif nil ~= Panel_WorkerChangeSkill and true == Panel_WorkerChangeSkill:GetShow() then
      FGlobal_workerChangeSkill_Close()
    end
  end
  FGlobal_TownfunctionNavi_UnSetWorldMap()
  if true == _ContentsGroup_NewUI_InstallMode_All then
    PaGlobal_WarInfomation_All_Close()
  else
    FGlobal_HouseInstallation_MinorWar_Close()
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  CheckChattingInput()
  if ToClient_IsSavedUi() then
    ToClient_SaveUiInfo(false)
    ToClient_SetSavedUi(false)
  end
  if true == _ContentsGroup_RenewUI then
    PaGlobal_ConsoleWorldMapKeyGuide_SetShow(false)
  end
  Panel_DetectUserButton:SetShow(false)
  FGlobal_Panel_MovieTheater640_WindowClose()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  if false == _ContentsGroup_NewUI_PersonalMonster_All then
    if nil ~= Panel_Window_PersonalMonsterInfo then
      PaGlobalFunc_PersonalMonsterWorldMpaInfo_Close()
    end
  elseif nil ~= Panel_PersonalMonsterInfo_All then
    FromClient_PersonalMonsterInfoAll_Hide()
  end
end
function FGlobal_WorldMapCloseSubPanel()
  Panel_Window_Warehouse:SetShow(false)
  if true == _ContentsGroup_NewUI_WorkerManager_All then
    PaGlobalFunc_WorkerManager_All_Close()
  else
    workerManager_Close()
  end
  Panel_Working_Progress:SetShow(false)
  FGlobal_ItemMarketItemSet_Close()
  FGolbal_ItemMarketNew_Close()
  FromClient_OutWorldMapQuestInfo()
  FromClient_OnTerritoryTooltipHide()
  NodeName_ShowToggle(false)
  if not _ContentsGroup_isUsedNewTradeEventNotice and not Panel_TradeMarket_EventInfo:IsUISubApp() then
    TradeEventInfo_Close()
  end
  if true == _ContentsGroup_ForXBoxFinalCert then
    PaGlobalFunc_WorldMapSideBar_ResetFilter()
  else
    FGlobal_SetNodeFilter()
  end
  isCullingNaviBtn = true
end
local eCheckState = CppEnums.WorldMapCheckState
local eWorldmapState = CppEnums.WorldMapState
function FromClient_NewWorldMap_RenderStateChange(state)
  if true == _ContentsGroup_ForXBoxFinalCert then
    FromClient_WorldMapSideBar_RenderStateChange(state)
    return
  end
  if eWorldmapState.eWMS_EXPLORE_PLANT == state then
    local questShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Quest)
    local knowledgeShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Knowledge)
    local fishNChipShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_FishnChip)
    local nodeShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Node)
    local tradeShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Trade)
    local wayShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Way)
    local positionShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Postions)
    local wagonIsShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Wagon)
    ToClient_worldmapNodeMangerSetShow(nodeShow)
    ToClient_worldmapBuildingManagerSetShow(true)
    ToClient_worldmapQuestManagerSetShow(questShow)
    ToClient_worldmapGuideLineSetShow(wayShow)
    ToClient_worldmapDeliverySetShow(wagonIsShow)
    ToClient_worldmapTerritoryManagerSetShow(true)
    ToClient_worldmapActorManagerSetShow(positionShow)
    ToClient_worldmapPinSetShow(positionShow)
    ToClient_worldmapGuildHouseSetShow(true, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapLifeKnowledgeSetShow(fishNChipShow, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapExceptionLifeKnowledgeSetShow(knowledgeShow, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapTradeNpcSetShow(tradeShow, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_SetGuildMode(FGlobal_isGuildWarMode())
  elseif eWorldmapState.eWMS_REGION == state then
    ToClient_worldmapNodeMangerSetShow(false)
    ToClient_worldmapBuildingManagerSetShow(false)
    ToClient_worldmapQuestManagerSetShow(false)
    ToClient_worldmapGuideLineSetShow(false)
    ToClient_worldmapDeliverySetShow(false)
    ToClient_worldmapActorManagerSetShow(false)
    ToClient_worldmapPinSetShow(false)
    ToClient_worldmapGuildHouseSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapTradeNpcSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapExceptionLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_WorldmapPersonalMonsterInfoSetShow(false)
    ToClient_WorldmapMonsterInfoSetShow(false)
  elseif eWorldmapState.eWMS_LOCATION_INFO_WATER == state then
    ToClient_worldmapNodeMangerSetShow(false)
    ToClient_worldmapBuildingManagerSetShow(false)
    ToClient_worldmapQuestManagerSetShow(false)
    ToClient_worldmapGuideLineSetShow(false)
    ToClient_worldmapDeliverySetShow(false)
    ToClient_worldmapActorManagerSetShow(false)
    ToClient_worldmapPinSetShow(false)
    ToClient_worldmapGuildHouseSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapTradeNpcSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapExceptionLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_WorldmapPersonalMonsterInfoSetShow(false)
    ToClient_WorldmapMonsterInfoSetShow(false)
  elseif eWorldmapState.eWMS_LOCATION_INFO_CELCIUS == state then
    ToClient_worldmapNodeMangerSetShow(false)
    ToClient_worldmapBuildingManagerSetShow(false)
    ToClient_worldmapQuestManagerSetShow(false)
    ToClient_worldmapGuideLineSetShow(false)
    ToClient_worldmapDeliverySetShow(false)
    ToClient_worldmapActorManagerSetShow(false)
    ToClient_worldmapPinSetShow(false)
    ToClient_worldmapGuildHouseSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapTradeNpcSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapExceptionLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_WorldmapPersonalMonsterInfoSetShow(false)
    ToClient_WorldmapMonsterInfoSetShow(false)
  elseif eWorldmapState.eWMS_LOCATION_INFO_HUMIDITY == state then
    ToClient_worldmapNodeMangerSetShow(false)
    ToClient_worldmapBuildingManagerSetShow(false)
    ToClient_worldmapQuestManagerSetShow(false)
    ToClient_worldmapGuideLineSetShow(false)
    ToClient_worldmapDeliverySetShow(false)
    ToClient_worldmapActorManagerSetShow(false)
    ToClient_worldmapPinSetShow(false)
    ToClient_worldmapGuildHouseSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapTradeNpcSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_worldmapExceptionLifeKnowledgeSetShow(false, CppEnums.WaypointKeyUndefined)
    ToClient_WorldmapPersonalMonsterInfoSetShow(false)
    ToClient_WorldmapMonsterInfoSetShow(false)
  end
end
local _townModeWaypointKey
function FromClient_SetTownMode(waypointKey)
  _townModeWaypointKey = waypointKey
  local explorationNodeInClient = ToClient_getExploratioNodeInClientByWaypointKey(waypointKey)
  if nil ~= explorationNodeInClient then
    UpdateWorldMapNode(explorationNodeInClient)
  end
  FGlobal_WarInfo_Close()
  FGlobal_NodeWarInfo_Close()
  local knowledgeShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Knowledge)
  local fishNChipShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_FishnChip)
  local tradeShow = ToClient_isWorldmapCheckState(eCheckState.eCheck_Trade)
  ToClient_worldmapLifeKnowledgeSetShow(fishNChipShow, waypointKey)
  ToClient_worldmapExceptionLifeKnowledgeSetShow(knowledgeShow, waypointKey)
  ToClient_worldmapHouseManagerSetShow(true, waypointKey)
  ToClient_worldmapTradeNpcSetShow(tradeShow, waypointKey)
  ToClient_worldmapGuildHouseSetShow(true, waypointKey)
  ToClient_worldmapQuestManagerSetShow(false)
  ToClient_worldmapGuideLineSetShow(false)
  ToClient_worldmapDeliverySetShow(false)
  ToClient_worldmapTerritoryManagerSetShow(false)
  if true == _ContentsGroup_ForXBoxFinalCert then
    PaGlobalFunc_WorldMapSideBar_Close()
    PaGlobalFunc_WorldMapSideBar_RetreatToWorldMapMode()
  else
    Panel_WorldMap_Main:SetShow(false)
    FGlobal_WorldmapGrand_Bottom_MenuSet(waypointKey)
    FGlobal_nodeOwnerInfo_SetPosition()
    FGlobal_GrandWorldMap_SearchToWorldMapMode()
  end
  ToClient_SetGuildMode(false)
  FGlobal_LoadWorldMapTownSideWindow(waypointKey)
  Panel_WorldMap_NodeTooltip:SetShow(false)
  PaGlobal_TutorialManager:handleSetTownMode(waypointKey)
end
function FromClient_resetTownMode()
  _townModeWaypointKey = nil
  ToClient_worldmapHouseManagerSetShow(false, CppEnums.WaypointKeyUndefined)
  ToClient_worldmapGuildHouseSetShow(true, CppEnums.WaypointKeyUndefined)
  ToClient_worldmapTerritoryManagerSetShow(true)
  if true == _ContentsGroup_ForXBoxFinalCert then
    PaGlobalFunc_WorldMapSideBar_Open()
    if Panel_NodeStable:GetShow() then
      StableClose_FromWorldMap()
    end
    ToClient_SetGuildMode(PaGlobalFunc_WorldMapSideBar_IsGuildWarMode())
    PaGlobalFunc_WorldMapSideBar_EraseArrow()
    FGlobal_FilterEffectClear()
  else
    FGlobal_WorldMapStateMaintain()
    if nil ~= ToClient_IsGrowStepOpen(__eGrowStep_worldmap1) and true == _ContentsGroup_GrowStep then
      Panel_WorldMap_Main:SetShow(ToClient_IsGrowStepOpen(__eGrowStep_worldmap3), false)
    else
      Panel_WorldMap_Main:SetShow(true)
    end
    FGlobal_WorldmapGrand_Bottom_MenuSet()
    if Panel_NodeStable:GetShow() then
      StableClose_FromWorldMap()
    end
    FGlobal_nodeOwnerInfo_Close()
    ToClient_SetGuildMode(FGlobal_isGuildWarMode())
    WorldMapArrowEffectEraseClear()
    FGlobal_FilterEffectClear()
    FGlobal_GrandWorldMap_SearchToWorldMapMode()
    FGlobal_Hide_Tooltip_Work(nil, true)
  end
end
function FGlobal_OpenNodeStable()
  if nil == _townModeWaypointKey then
    return
  end
  local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(_townModeWaypointKey)
  if nil ~= regionInfoWrapper and regionInfoWrapper:get():hasStableNpc() then
    StableOpen_FromWorldMap(_townModeWaypointKey)
  end
end
function AltKeyGuide_ReSize()
  local altKeyGuideTextX = altKeyGuide:GetTextSizeX() + 10
  local altKeyGuideTextY = altKeyGuide:GetTextSizeY() + 10
  altKeyGuide:SetSize(altKeyGuideTextX, altKeyGuideTextY)
end
function FromClient_HideAutoCompletedNaviBtn(isShow)
  HideAutoCompletedNaviBtn = isShow
end
function FromClient_notifyUpdateGrowStep_WorldMap(key, bool)
  if nil == key or nil == bool then
    return
  end
  if __eGrowStep_worldmap1 == key then
    naviBtn:SetShow(bool)
  end
end
registerEvent("FromClient_RenderStateChange", "FromClient_NewWorldMap_RenderStateChange")
if false == _ContentsGroup_RenewUI_WorldMap then
  registerEvent("FromClient_WorldMapOpen", "FromClient_WorldMapOpen")
  registerEvent("FromClient_LClickedWorldMapNode", "FromClient_LClickedWorldMapNode")
  registerEvent("FromClient_SetTownMode", "FromClient_SetTownMode")
  registerEvent("FromClient_resetTownMode", "FromClient_resetTownMode")
  registerEvent("FromClient_ExitWorldMap", "FromClient_ExitWorldMap")
  registerEvent("FromClient_ImmediatelyCloseWorldMap", "FGlobal_WorldMapClose")
  registerEvent("FromClient_WorldMapFadeOut", "FromClient_WorldMapFadeOut")
  registerEvent("FromClient_WorldMapFadeOutHideUI", "FromClient_WorldMapFadeOutHideUI")
  registerEvent("FromClient_FillNodeInfo", "FGlobal_OpenOtherPanelWithNodeMenu")
end
registerEvent("FromClient_NodeIsNextSiege", "FromClient_NodeIsNextSiege")
registerEvent("FromClient_WorldMapNodeFindNearNode", "FromClient_WorldMapNodeFindNearNode")
registerEvent("FromClient_WorldMapNodeFindTargetNode", "FromClient_WorldMapNodeFindTargetNode")
registerEvent("FromClient_RClickWorldmapPanel", "FromClient_RClickWorldmapPanel")
registerEvent("FromClient_DeleteNaviGuidOnTheWorldmapPanel", "FromClient_DeleteNaviGuidOnTheWorldmapPanel")
registerEvent("FromClient_notifyUpdateGrowStep", "FromClient_notifyUpdateGrowStep_WorldMap")
registerEvent("FromClient_HideAutoCompletedNaviBtn", "FromClient_HideAutoCompletedNaviBtn")
registerEvent("FromClient_DeliveryRequestAck", "DeliveryRequest_UpdateRequestSlotData")
registerEvent("EventDeliveryInfoUpdate", "DeliveryInformation_UpdateSlotData")
function FromClient_WorldMap_luaLoadComplete()
  initializeNaviBtn()
  FGlobal_WorldMapClose()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_luaLoadComplete")
AltKeyGuide_ReSize()
renderMode:setClosefunctor(renderMode, FGlobal_CloseWorldmapForLuaKeyHandling)
