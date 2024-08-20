function InputMLUp_NpcNavi_SetWarehouseNavi(index)
  local actorKey = PaGlobal_NpcNavi_All._territoryTownData[index]._actorKey
  if NpcConditionCheck(actorKey) then
    ToClient_DeleteNaviGuideByGroup(0)
    worldmapNavigatorStart(float3(PaGlobal_NpcNavi_All._territoryTownData[index]._x, PaGlobal_NpcNavi_All._territoryTownData[index]._y, PaGlobal_NpcNavi_All._territoryTownData[index]._z), NavigationGuideParam(), false, false, true)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_NOKNOWLEDGE"))
  end
end
function InputMOn_NpcNavi_TownWarehouseTooltip(index)
  if nil == PaGlobal_NpcNavi_All._territoryTownData[index] then
    return
  end
  local name = PaGlobal_NpcNavi_All._territoryTownData[index]._desc
  local uiControl = PaGlobal_NpcNavi_All._btn_CityList[index]._btn
  local desc
  if nil == index then
    TooltipSimple_Hide()
  else
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function InputMLUp_NpcNavi_DrawLine(key)
  ToClient_DeleteNaviGuideByGroup(0)
  local spawnRegionData = PaGlobal_NpcNavi_All:getSelectItemSpawnRegionData()
  if nil == spawnRegionData then
    return
  end
  if NpcConditionCheck(spawnRegionData:getKeyRaw()) then
    if spawnRegionData:hasTimeSpawn() and spawnRegionData:isTimeSpawn(math.floor(getIngameTime_minute() / 60)) == false then
      NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
    end
    worldmapNavigatorStart(spawnRegionData:getPosition(), NavigationGuideParam(), false, false, true)
  else
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOFIND"))
    return
  end
end
function PaGlobal_NpcNavi_All_AutoRun()
  if false == ToClient_WorldMapNaviEmpty() then
    local naviEndPoint = ToClient_getNavigationMoveEndPoint()
    ToClient_DeleteNaviGuideByGroup(0)
    worldmapNavigatorStart(naviEndPoint, NavigationGuideParam(), true, false, true)
  end
end
function InputMLUp_NpcNavi_SearchNpc()
  if false == CheckChattingInput() then
    ClearFocusEdit()
  end
  PaGlobal_NpcNavi_All.filterText = PaGlobal_NpcNavi_All._ui.edit_Serarch:GetEditText()
  local overIndex = PaGlobal_NpcNavi_All._ui.tree_Npc:GetOverIndex()
  PaGlobal_NpcNavi_All:treeClear()
  PaGlobal_NpcNavi_All:npcListUpdate()
  if true == PaGlobal_NpcNavi_All._isConsole then
    local itemQuantity = PaGlobal_NpcNavi_All._ui.tree_Npc:GetItemQuantity()
    local showListSize = PaGlobal_NpcNavi_All._ui.tree_Npc:GetShowItemCount()
    local newOverIndex = math.min(overIndex, math.min(showListSize - 1, itemQuantity - 1))
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetOverIndex(newOverIndex)
  end
end
function InputMLUp_NpcNavi_SetFoucsEdit()
  SetFocusEdit(PaGlobal_NpcNavi_All._ui.edit_Serarch)
  PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText("")
end
function PaGlobal_NpcNavi_All_SetTreeKeyGuide()
  if false == PaGlobal_NpcNavi_All._isConsole then
    return
  end
  PaGlobal_NpcNavi_All._ui_console.stc_KeyGuideBG:SetShow(true)
  local keyGuides = {
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideLBRB,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideDPadHor,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideDPadVer,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideA,
    PaGlobal_NpcNavi_All._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_NpcNavi_All._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_NpcNavi_All_OverBarUpdatePerFrame(deltaTime)
  PaGlobal_NpcNaviTooltip_OverBarUpdate(true)
  if true == PaGlobal_NpcNavi_All._isConsole and true == keyCustom_IsUp_Action(__eActionInputType_AutoRun) then
    PaGlobal_NpcNavi_All_AutoRun()
  end
end
function FromClient_NpcNavi_All_RregionChanged()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  elseif PaGlobal_NpcNavi_All.lazyUpdate then
    PaGlobal_NpcNavi_All:npcListUpdate()
  end
end
function FromClient_NpcNavi_All_MentalCardUpdate()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  end
  PaGlobal_NpcNavi_All:npcListUpdate()
end
function FromClient_NpcNavi_All_ExplorePointUpdate()
  if false == Panel_NpcNavi_All:IsShow() then
    PaGlobal_NpcNavi_All.lazyUpdate = true
    return
  end
  PaGlobal_NpcNavi_All:npcListUpdate()
end
function FromClient_NpcNavi_All_OnScreenResize()
  if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetItemQuantity(PaGlobal_NpcNavi_All._ui.tree_Npc:GetSizeY() / 195 * 8)
    PaGlobal_NpcNavi_All._ui.tree_Npc:setAddImagePosY(5)
  else
    PaGlobal_NpcNavi_All._ui.tree_Npc:SetItemQuantity(PaGlobal_NpcNavi_All._ui.tree_Npc:GetSizeY() / 465 * 25)
    PaGlobal_NpcNavi_All._ui.tree_Npc:setAddImagePosY(2)
  end
end
function PaGlobal_NpcNavi_All_ReturnKeyEvent(isOk)
  if true ~= isOk then
    PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText("")
  end
  InputMLUp_NpcNavi_SearchNpc()
  ClearFocusEdit()
end
function PaGlobal_NpcNavi_All_SearchNpc(str)
  if nil ~= str then
    PaGlobal_NpcNavi_All._ui.edit_Serarch:SetEditText(str)
    InputMLUp_NpcNavi_SearchNpc()
  end
  ClearFocusEdit()
end
function NpcConditionCheck(keyRaw)
  if false == IsUseDynamicBSS() then
    return checkActiveCondition(keyRaw)
  else
    return npcCheckActiveCondition(keyRaw)
  end
end
function IsUseDynamicBSS()
  if true == ToClient_isUseDynamicBSS(__eDynamicBSSType_Character) or true == ToClient_isUseDynamicBSS(__eDynamicBSSType_Dialog) then
    return true
  end
  return false
end
function PaGlobal_NpcNavi_All_SetOverIndex(index)
  PaGlobal_NpcNavi_All._ui.tree_Npc:SetOverIndex(index)
end
function PaGlobal_NpcNavi_All_GetOverIndex()
  return PaGlobal_NpcNavi_All._ui.tree_Npc:GetOverIndex()
end
function PaGlobal_NpcNavi_All_ShowToggle()
  local isShow = not Panel_NpcNavi_All:IsShow()
  if isShow then
    PaGlobal_NpcNavi_All_ResetPosistion()
    PaGlobal_NpcNavi_All:prepareOpen()
  else
    PaGlobal_NpcNavi_All:clearFocusEdit()
    PaGlobal_NpcNavi_All:prepareClose()
  end
  if false == isShow then
    if ToClient_WorldMapIsShow() then
      WorldMapPopupManager:pop()
    end
    PaGlobal_NpcNavi_Tooltip:prepareClose()
  else
    PaGlobal_NpcNavi_All:updateTownNavi()
    if PaGlobal_NpcNavi_All.lazyUpdate then
      PaGlobal_NpcNavi_All:npcListUpdate()
      PaGlobal_NpcNavi_All.lazyUpdate = false
    end
  end
  Panel_NpcNavi_All:EraseAllEffect()
  local rndNo_1 = math.random(0, 30)
  local rndNo_2 = math.random(30, 60)
  if Panel_WorldMap:GetShow() then
    Panel_NpcNavi_All:SetPosX(getScreenSizeX() - Panel_NpcNavi_All:GetSizeX() - 300)
    Panel_NpcNavi_All:SetPosY(30)
  else
    PaGlobal_NpcNavi_All_ResetPosistion()
  end
  Panel_NpcNavi_All:SetPosX(Panel_NpcNavi_All:GetPosX() - rndNo_1)
  Panel_NpcNavi_All:SetPosY(Panel_NpcNavi_All:GetPosY() + rndNo_2)
  PaGlobal_TutorialManager:handleNpcNavi_ShowToggle(isShow)
end
function PaGlobal_NpcNavi_All_ResetPosistion()
  Panel_NpcNavi_All:SetPosX(FGlobal_Panel_Radar_GetPosX() - Panel_NpcNavi_All:GetSizeX())
  Panel_NpcNavi_All:SetPosY(FGlobal_Panel_Radar_GetPosY())
end
function PaGlobal_NpcNavi_All_HideAni()
  Panel_NpcNavi_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_NpcNavi_All, 0, 0.75)
  aniInfo:SetHideAtEnd(true)
end
function FGlobal_NpcNavi_Hide()
  local isShow = Panel_NpcNavi_All:IsShow()
  if isShow then
    PaGlobal_NpcNavi_All:clearFocusEdit()
  end
  PaGlobal_NpcNavi_All:prepareClose()
  PaGlobal_NpcNavi_Tooltip:prepareClose()
end
function FGlobal_NpcNavi_IsShowCheck()
  return Panel_NpcNavi_All:IsShow()
end
function PaGlobal_NpcNavi_All_ShowRequestOuter()
  PaGlobal_NpcNavi_All:clearFocusEdit()
end
function NpcNavi_CheckCurrentUiEdit(_npcNavi_TargetUI)
  return nil ~= _npcNavi_TargetUI and _npcNavi_TargetUI:GetKey() == PaGlobal_NpcNavi_All._ui.edit_Serarch:GetKey()
end
function FGlobal_NpcNavi_PanelSizeSetting(iconCount)
  PaGlobal_NpcNavi_All:panelSizeSetting(iconCount)
end
function FromClient_NpcNavi_List2BookMarkUpdate(content, key)
  local key32 = Int64toInt32(key)
  local btn_startNavi = UI.getChildControl(content, "Button_Ping")
  local btn_deleteNavi = UI.getChildControl(content, "Button_WayDelete")
  local txt_name = UI.getChildControl(content, "StaticText_RegionName")
  local btn_changeName = UI.getChildControl(content, "Button_ChangeName")
  local bookMarkName = ToClient_GetWorldMapBookMarkName(key32)
  if "" == bookMarkName then
    content:SetShow(false)
    return
  end
  content:EraseAllEffect()
  if true == PaGlobal_NpcNavi_All._isNewSaved and key32 == PaGlobal_NpcNavi_All._currentBookMarkCount - 1 then
    content:AddEffect("fUI_Favorites_01A", true, 0, 0)
    PaGlobal_NpcNavi_All._isNewSaved = false
  end
  content:SetShow(true)
  txt_name:SetText(bookMarkName)
  UI.setLimitAutoWrapTextAndAddTooltip(txt_name, 1, bookMarkName)
  btn_startNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_StartBookMarkNavi(" .. key32 .. ")")
  btn_deleteNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_DeleteBookMark(" .. key32 .. ")")
  btn_changeName:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_ChangeBookMarkName(" .. key32 .. ")")
  if nil ~= PaGlobal_NpcNavi_All._list2BookMarkBtn[key32] then
    PaGlobal_NpcNavi_All._list2BookMarkBtn[key32].navi = btn_startNavi
    PaGlobal_NpcNavi_All._list2BookMarkBtn[key32].nameChange = btn_changeName
    PaGlobal_NpcNavi_All._list2BookMarkBtn[key32].delete = btn_deleteNavi
    btn_startNavi:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip(" .. key32 .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.NAVI .. ")")
    btn_deleteNavi:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip(" .. key32 .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.DELETE .. ")")
    btn_changeName:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip(" .. key32 .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.CHANGENAME .. ")")
    btn_startNavi:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip()")
    btn_deleteNavi:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip()")
    btn_changeName:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip()")
  end
  btn_startNavi:setNotImpactScrollEvent(true)
  btn_deleteNavi:setNotImpactScrollEvent(true)
  btn_changeName:setNotImpactScrollEvent(true)
end
function FromClient_NpcNavi_List2HuntUpdate(content, key)
  local regionKey = Int64toInt32(key)
  local regionInfo = getRegionInfoWrapper(regionKey)
  if nil ~= regionInfo then
    local txt_Area = UI.getChildControl(content, "StaticText_Hunt")
    local txt_MinAd = UI.getChildControl(content, "StaticText_AttackPoint")
    local btn_Navi = UI.getChildControl(content, "Button_Navi")
    local btn_Move = UI.getChildControl(content, "Button_NaviDelete")
    btn_Navi:setNotImpactScrollEvent(true)
    btn_Move:setNotImpactScrollEvent(true)
    local regionName = regionInfo:getAreaName()
    local needAttackPoint = ToClient_RegionDropItem_GetNeedAttackPoint(regionKey)
    txt_MinAd:SetText(needAttackPoint)
    txt_Area:SetText(regionName)
    UI.setLimitAutoWrapTextAndAddTooltip(txt_Area, 1, regionName)
    btn_Navi:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_HuntAreaNaviStart(" .. regionKey .. ", false)")
    btn_Move:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_HuntAreaNaviStart(" .. regionKey .. ", true)")
    if nil ~= PaGlobal_NpcNavi_All._list2HuntBtn[regionKey] then
      PaGlobal_NpcNavi_All._list2HuntBtn[regionKey].move = btn_Navi
      PaGlobal_NpcNavi_All._list2HuntBtn[regionKey].autoMove = btn_Move
      PaGlobal_NpcNavi_All._list2HuntBtn[regionKey].atk = txt_MinAd
      if false == PaGlobal_NpcNavi_All._isConsole then
        btn_Navi:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip(" .. regionKey .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.NAVI .. ")")
        btn_Move:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip(" .. regionKey .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.AUTOMOVE .. ")")
        btn_Navi:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip()")
        btn_Move:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip()")
        txt_MinAd:SetIgnore(false)
        txt_MinAd:SetEnableArea(0, 0, txt_MinAd:GetTextSizeX() + txt_MinAd:GetSizeX() + 10, txt_MinAd:GetSizeY())
        txt_MinAd:addInputEvent("Mouse_On", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip(" .. regionKey .. "," .. PaGlobal_NpcNavi_All._eBTNTYPE.ATK .. ")")
        txt_MinAd:addInputEvent("Mouse_Out", "HandleEventOnOut_NpcNaviAll_HuntBtnTooltip()")
      end
    end
  end
end
function FromClient_NpcNavi_List2NpcListUpdate(content, key)
  local rowIndex = Int64toInt32(key)
  local btnIndexLeft = rowIndex * 2 - 1
  local btnIndexRight = rowIndex * 2
  local btnLeft = UI.getChildControl(content, "Button_001")
  local btnRight = UI.getChildControl(content, "Button_002")
  local leftDataTable = PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexLeft]
  if nil ~= leftDataTable then
    local spawnTypeLeft = PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexLeft]._spawnType
    local text = UI.getChildControl(btnLeft, "StaticText_Name")
    local icon = UI.getChildControl(btnLeft, "Static_Icon")
    PaGlobal_NpcNavi_All:setNpcBtnTexture(icon, spawnTypeLeft)
    text:SetText(CppEnums.SpawnTypeString[spawnTypeLeft])
    UI.setLimitAutoWrapTextAndAddTooltip(text, 1, text:GetText())
    text:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeLeft .. ")")
    btnLeft:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeLeft .. ")")
    btnLeft:SetEnableArea(0, 0, btnLeft:GetSizeX() + text:GetTextSizeX() + 10, btnLeft:GetSizeY())
    if false == isConsole then
      btnLeft:addInputEvent("Mouse_RUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeLeft .. ", " .. "true)")
      text:addInputEvent("Mouse_RUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeLeft .. ", " .. "true)")
    end
    PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexLeft]._btn = btnLeft
  end
  local rightDataTable = PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexRight]
  if nil ~= rightDataTable then
    local spawnTypeRight = PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexRight]._spawnType
    local text = UI.getChildControl(btnRight, "StaticText_Name")
    local icon = UI.getChildControl(btnRight, "Static_Icon")
    PaGlobal_NpcNavi_All:setNpcBtnTexture(icon, spawnTypeRight)
    text:SetText(CppEnums.SpawnTypeString[spawnTypeRight])
    UI.setLimitAutoWrapTextAndAddTooltip(text, 1, text:GetText())
    text:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeRight .. ")")
    btnRight:addInputEvent("Mouse_LUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeRight .. ")")
    btnRight:SetEnableArea(0, 0, btnRight:GetSizeX() + text:GetTextSizeX() + 10, btnRight:GetSizeY())
    if false == isConsole then
      btnRight:addInputEvent("Mouse_RUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeRight .. ", " .. "true)")
      text:addInputEvent("Mouse_RUp", "HandleEventLUp_NpcNaviAll_NaviStart(" .. spawnTypeRight .. ", " .. "true)")
    end
    PaGlobal_NpcNavi_All._useableNpcBtn[btnIndexRight]._btn = btnRight
  end
  btnLeft:SetShow(nil ~= leftDataTable and true == ToClient_HasClientSpawnByType(spawnTypeLeft))
  btnRight:SetShow(nil ~= rightDataTable and true == ToClient_HasClientSpawnByType(spawnTypeRight))
end
function HandleEventLUp_NpcNaviAll_Tooltip(index)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_NpcNavi_All._useableNpcBtn[index] then
    return
  end
  if nil == PaGlobal_NpcNavi_All._useableNpcBtn[index]._btn then
    return
  end
  local name = PaGlobal_NpcNavi_All._useableNpcBtn[index]._btn:GetText()
  local uiControl = PaGlobal_NpcNavi_All._useableNpcBtn[index]._btn
  local desc
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventLUp_NpcNaviAll_NaviStart(spawnType, isAuto)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if nil == isAuto then
    isAuto = false
  end
  if nil == spawnType then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ToClient_DeleteNaviGuideByGroup(0)
  local position = player:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(spawnType, position)
  if nil == nearNpcInfo then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if false == curChannelData._isMain and CppEnums.SpawnType.eSpawnType_TerritoryTrade == spawnType then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_TOWNNPCNAVI_IMPERIAL_DELIVERY_ONLY_FIRSTCH"))
    return
  end
  local isSpawnNearNpc = nearNpcInfo:isTimeSpawn()
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), isAuto, isAuto)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  local selfPlayer = getSelfPlayer():get()
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  if false == isSpawnNearNpc then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION", "npcName", tostring(CppEnums.SpawnTypeString[spawnType])))
  TownfunctionNavi_Set()
  PaGlobal_TutorialManager:handleClickedTownNpcIconNaviStart(spawnType, isAuto)
end
function HandleEventLUp_NpcNaviAll_TapSelect(index)
  PaGlobal_NpcNavi_All:setCurrentTabPage(index)
end
function HandleEventLUp_NpcNaviAll_TapSelectWithPCPad(isUp)
  if true == isUp then
    PaGlobal_NpcNavi_All._currentTab = PaGlobal_NpcNavi_All._currentTab + 1
  else
    PaGlobal_NpcNavi_All._currentTab = PaGlobal_NpcNavi_All._currentTab - 1
  end
  if PaGlobal_NpcNavi_All._currentTab < PaGlobal_NpcNavi_All._eTAB.NPC then
    PaGlobal_NpcNavi_All._currentTab = PaGlobal_NpcNavi_All._eTAB.HUNT
  elseif PaGlobal_NpcNavi_All._eTAB.HUNT < PaGlobal_NpcNavi_All._currentTab then
    PaGlobal_NpcNavi_All._currentTab = PaGlobal_NpcNavi_All._eTAB.NPC
  end
  PaGlobal_NpcNavi_All:setCurrentTabPage(PaGlobal_NpcNavi_All._currentTab)
end
function HandleEventScroll_NpcNaviAll_WareHorseIcon(isUp)
  local scrollForce = 0.3
  PaGlobal_NpcNavi_All._wareHouseBtnScrollIndex = UIScroll.ScrollEvent(PaGlobal_NpcNavi_All._ui.frame_HoriScroll, isUp, 1, PaGlobal_NpcNavi_All._TOWNCOUNT * scrollForce, PaGlobal_NpcNavi_All._wareHouseBtnScrollIndex, 1)
  PaGlobal_NpcNavi_All._ui.frame_CityList:UpdateContentScroll()
  PaGlobalFunc_NpcNaviAll_ShowScrollButton()
end
function HandleEventLUp_NpcNaviAll_WareHorseIconScroll(isUp, force)
  local scrollForce = force
  PaGlobal_NpcNavi_All._wareHouseBtnScrollIndex = UIScroll.ScrollEvent(PaGlobal_NpcNavi_All._ui.frame_HoriScroll, isUp, 1, PaGlobal_NpcNavi_All._TOWNCOUNT * scrollForce, PaGlobal_NpcNavi_All._wareHouseBtnScrollIndex, 1)
  PaGlobal_NpcNavi_All._ui.frame_CityList:UpdateContentPos()
  PaGlobalFunc_NpcNaviAll_ShowScrollButton()
end
function PaGlobalFunc_NpcNaviAll_ShowScrollButton()
  local scrollPos = PaGlobal_NpcNavi_All._ui.frame_HoriScroll:GetControlPos()
  if 0 == scrollPos then
    PaGlobal_NpcNavi_All._ui.stc_frameLeft:SetShow(false)
  elseif 1 == scrollPos then
    PaGlobal_NpcNavi_All._ui.stc_frameRight:SetShow(false)
  else
    PaGlobal_NpcNavi_All._ui.stc_frameLeft:SetShow(true)
    PaGlobal_NpcNavi_All._ui.stc_frameRight:SetShow(true)
  end
end
function HandleEventLUp_NpcNaviAll_HuntAreaNaviStart(regionKey, isMoveRightNow)
  if nil == regionKey then
    return
  end
  local regionInfo = getRegionInfoWrapper(regionKey)
  if nil == regionInfo then
    return
  end
  local pos3D = regionInfo:getPosition()
  if regionInfo:hasBaseWaypoint() then
    pos3D = regionInfo:getPosition()
  elseif 249 == regionKey then
    pos3D = float3(-337181.94, 10127, -248922)
  elseif 948 == regionKey then
    pos3D = float3(32478, -8076, 254519)
  elseif 949 == regionKey then
    pos3D = float3(143790, -7280, 423527)
  elseif 688 == regionKey or 689 == regionKey then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_DESERTALERT"))
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos3D, NavigationGuideParam(), isMoveRightNow, false)
end
function FromClient_NpcNaviAll_OpenBySaveBookMark(isSave)
  PaGlobal_NpcNavi_All._currentTab = PaGlobal_NpcNavi_All._eTAB.BOOKMARK
  if true == isSave and PaGlobal_NpcNavi_All._currentBookMarkCount < ToClient_GetWorldMapBookMarkCount() then
    PaGlobal_NpcNavi_All._isNewSaved = true
  end
  if false == Panel_NpcNavi_All:GetShow() then
    PaGlobal_NpcNavi_All_ResetPosistion()
    PaGlobal_NpcNavi_All:prepareOpen()
  else
    PaGlobal_NpcNavi_All:setCurrentTabPage(PaGlobal_NpcNavi_All._currentTab)
  end
end
function HandleEventLUp_NpcNaviAll_StartBookMarkNavi(index)
  if nil == index then
    return
  end
  local bookMarkCount = ToClient_GetWorldMapBookMarkCount()
  if index > bookMarkCount - 1 then
    return
  end
  local position = ToClient_GetWorldMapBookMarkPosition(index)
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(position, NavigationGuideParam(), false, false)
end
function HandleEventLUp_NpcNaviAll_ChangeBookMarkName(index)
  if nil == index then
    return
  end
  local bookMarkCount = ToClient_GetWorldMapBookMarkCount()
  if index > bookMarkCount - 1 then
    return
  end
  if nil ~= PaGlobalFunc_WorldMap_BookMark_OpenFromNPCNavi then
    PaGlobalFunc_WorldMap_BookMark_OpenFromNPCNavi(index)
  end
end
function HandleEventLUp_NpcNaviAll_DeleteBookMark(index)
  if nil == index then
    return
  end
  local bookMarkCount = ToClient_GetWorldMapBookMarkCount()
  if index > bookMarkCount - 1 then
    return
  end
  ToClient_DeleteWorldMapBookMark(index)
end
function HandleEventOnOut_NpcNaviAll_HuntBtnTooltip(index, btnType)
  if nil == PaGlobal_NpcNavi_All._tooltipString[btnType] or nil == index or nil == btnType then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_NpcNavi_All._list2HuntBtn[index] then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_NpcNavi_All._list2HuntBtn[index].move or nil == PaGlobal_NpcNavi_All._list2HuntBtn[index].autoMove then
    TooltipSimple_Hide()
    return
  end
  local name = PaGlobal_NpcNavi_All._tooltipString[btnType]
  local uiControl, desc
  if PaGlobal_NpcNavi_All._eBTNTYPE.NAVI == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2HuntBtn[index].move
  elseif PaGlobal_NpcNavi_All._eBTNTYPE.AUTOMOVE == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2HuntBtn[index].autoMove
  elseif PaGlobal_NpcNavi_All._eBTNTYPE.ATK == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2HuntBtn[index].atk
  end
  if nil ~= uiControl then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function HandleEventOnOut_NpcNaviAll_BookMarkBtnTooltip(index, btnType)
  if nil == PaGlobal_NpcNavi_All._tooltipString[btnType] or nil == index or nil == btnType then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_NpcNavi_All._list2BookMarkBtn[index] then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_NpcNavi_All._list2BookMarkBtn[index].navi or nil == PaGlobal_NpcNavi_All._list2BookMarkBtn[index].nameChange or nil == PaGlobal_NpcNavi_All._list2BookMarkBtn[index].delete then
    TooltipSimple_Hide()
    return
  end
  local name = PaGlobal_NpcNavi_All._tooltipString[btnType]
  local uiControl, desc
  if PaGlobal_NpcNavi_All._eBTNTYPE.NAVI == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2BookMarkBtn[index].navi
  elseif PaGlobal_NpcNavi_All._eBTNTYPE.CHANGENAME == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2BookMarkBtn[index].nameChange
  elseif PaGlobal_NpcNavi_All._eBTNTYPE.DELETE == btnType then
    uiControl = PaGlobal_NpcNavi_All._list2BookMarkBtn[index].delete
  end
  if nil ~= uiControl then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function HandleEventLUp_NpcNaviAll_WorldMapBookMarkOpen()
  if false == ToClient_WorldMapIsShow() and nil ~= FGlobal_PushOpenWorldMap then
    FGlobal_PushOpenWorldMap()
  end
  if false == Panel_NpcNavi_All:GetShow() then
    PaGlobal_NpcNavi_All_ResetPosistion()
    PaGlobal_NpcNavi_All:prepareOpen()
    PaGlobal_NpcNavi_All:setCurrentTabPage(PaGlobal_NpcNavi_All._eTAB.BOOKMARK)
  end
end
