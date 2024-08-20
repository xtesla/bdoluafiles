function PaGlobal_WorldMap_StableList_Open()
  if nil == Panel_WorldMap_StableList then
    return
  end
  if false == _ContentsGroup_TotalStableList then
    return
  end
  PaGlobal_WorldMap_StableList:prepareOpen()
end
function PaGlobal_WorldMap_StableList_Close()
  if nil == Panel_WorldMap_StableList then
    return
  end
  PaGlobal_WorldMap_StableList:prepareClose()
end
function PaGlobal_WorldMap_StableList_GetShow()
  if nil == Panel_WorldMap_StableList then
    return false
  end
  return Panel_WorldMap_StableList:GetShow()
end
function PaGlobal_WorldMap_StableList_Refresh()
  if nil == Panel_WorldMap_StableList then
    return
  end
  if false == _ContentsGroup_TotalStableList then
    return
  end
  TooltipSimple_Hide()
  HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)
  PaGlobal_WorldMap_StableList:close()
  PaGlobal_WorldMap_StableList:prepareOpen()
end
function PaGlobal_WorldMap_StableList_UpdateRegionList(contents, key)
  if nil == Panel_WorldMap_StableList then
    return
  end
  local idx = Int64toInt32(key)
  local territoryButton = UI.getChildControl(contents, "RadioButton_Territory")
  local townButton = UI.getChildControl(contents, "RadioButton_Town")
  local count = UI.getChildControl(contents, "StaticText_Capacity")
  territoryButton:SetTextMode(__eTextMode_Limit_AutoWrap)
  townButton:SetTextMode(__eTextMode_Limit_AutoWrap)
  territoryButton:SetPosX(5)
  townButton:SetPosX(6)
  townButton:SetShow(false)
  count:SetShow(false)
  if true == PaGlobal_WorldMap_StableList._isConsole then
    territoryButton:addInputEvent("Mouse_On", "PaGlobalFunc_WorldMap_StableList_SetSnappingIndex(" .. tostring(PaGlobal_WorldMap_StableList._TOWNSLOTINDEX) .. ")")
    townButton:addInputEvent("Mouse_On", "PaGlobalFunc_WorldMap_StableList_SetSnappingIndex(" .. tostring(PaGlobal_WorldMap_StableList._TOWNSLOTINDEX) .. ")")
  end
  if idx < PaGlobal_WorldMap_StableList._SEPARATORNUMBER then
    if nil ~= PaGlobal_WorldMap_StableList._territoryInfoList[idx] then
      local territoryName = PaGlobal_WorldMap_StableList._territoryInfoList[idx]._territoryName
      local territoryservantTotalCount = PaGlobal_WorldMap_StableList._territoryInfoList[idx]._territoryservantTotalCount
      local territoryNameControl = UI.getChildControl(territoryButton, "StaticText_TerritoryName")
      if nil ~= territoryNameControl then
        territoryNameControl:SetText(territoryName .. "(" .. territoryservantTotalCount .. ")")
        UI.setLimitAutoWrapTextAndAddTooltip(territoryNameControl, 1, "", territoryNameControl:GetText())
        territoryNameControl:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_TerritoryButton(" .. idx .. ")")
      end
      territoryButton:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_TerritoryButton(" .. idx .. ")")
      territoryButton:SetShow(true)
      townButton:SetShow(false)
      count:SetShow(false)
    end
  else
    territoryButton:SetShow(false)
    townButton:SetShow(true)
    local regionKey = idx - PaGlobal_WorldMap_StableList._SEPARATORNUMBER
    if nil ~= PaGlobal_WorldMap_StableList._regionInfoList[regionKey] then
      local areaName = PaGlobal_WorldMap_StableList._regionInfoList[regionKey]._areaName
      local servantCount = PaGlobal_WorldMap_StableList._regionInfoList[regionKey]._servantCount
      local regionNameControl = UI.getChildControl(townButton, "StaticText_RegionName")
      PaGlobal_WorldMap_StableList._currentSlotPage = 0
      townButton:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_TownButton(" .. regionKey .. ")")
      if nil ~= regionNameControl then
        regionNameControl:SetText(areaName .. "(" .. servantCount .. ")")
        regionNameControl:SetFontColor(Defines.Color.C_FFC4BEBE)
        UI.setLimitAutoWrapTextAndAddTooltip(regionNameControl, 1, "", regionNameControl:GetText())
        regionNameControl:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_TownButton(" .. regionKey .. ")")
      end
      townButton:SetCheck(regionKey == PaGlobal_WorldMap_StableList._currentSelectRegionKey)
    end
  end
end
function HandleEventLUp_WorldMap_StableList_TerritoryButton(territoryKey)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:clearSlot()
  PaGlobal_WorldMap_StableList._currentSelectRegionKey = nil
  PaGlobal_WorldMap_StableList._currentSlotPage = 0
  PaGlobal_WorldMap_StableList._currentMaxPage = 0
  PaGlobal_WorldMap_StableList._currentSelectSlot = -1
  if territoryKey ~= PaGlobal_WorldMap_StableList._currentSelectTerritoryKey then
    PaGlobal_WorldMap_StableList._currentSelectTerritoryKey = territoryKey
  else
    PaGlobal_WorldMap_StableList._currentSelectTerritoryKey = nil
  end
  PaGlobal_WorldMap_StableList:BuildRegionList()
end
function HandleEventLUp_WorldMap_StableList_TownButton(regionKey)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if regionKey == PaGlobal_WorldMap_StableList._currentSelectRegionKey then
    return
  end
  PaGlobal_WorldMap_StableList._currentSlotPage = 0
  PaGlobal_WorldMap_StableList._currentSelectSlot = -1
  PaGlobal_WorldMap_StableList._currentSelectRegionKey = regionKey
  PaGlobal_WorldMap_StableList:setTotalPrice()
  PaGlobal_WorldMap_StableList:update()
end
function HandleEventLUp_WorldMap_StableList_PageChange(isUp)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if true == isUp then
    PaGlobal_WorldMap_StableList._currentSlotPage = PaGlobal_WorldMap_StableList._currentSlotPage + 1
  else
    PaGlobal_WorldMap_StableList._currentSlotPage = PaGlobal_WorldMap_StableList._currentSlotPage - 1
  end
  local clampValue = math.max(0, math.min(PaGlobal_WorldMap_StableList._currentMaxPage - 1, PaGlobal_WorldMap_StableList._currentSlotPage))
  PaGlobal_WorldMap_StableList._currentSlotPage = clampValue
  PaGlobal_WorldMap_StableList:updateSlot()
  PaGlobalFunc_WorldMap_StableList_ResetSnapping()
end
function HandleEventOn_WorldMap_StableList_Slot(idx)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if idx < 0 or idx > PaGlobal_WorldMap_StableList._MAXSLOTCOUNT - 1 then
    return
  end
  PaGlobal_WorldMap_StableList._currentSelectSlot = idx
  if true == PaGlobal_WorldMap_StableList._isConsole then
    PaGlobalFunc_WorldMap_StableList_SetSnappingIndex(idx)
    HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)
    HandleEventOnOut_WorldMap_StableList_ShowUseAddStatItemTooltip(false)
  end
end
function HandleEventOnOut_WorldMap_StableList_ShowToolTip(slotIdx, idx, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  local control = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]._tooltipControls[idx]
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_WorldMap_StableList_ShowStallionToolTip(isShow, key32, slotIdx)
  if false == isShow or nil == key32 or nil == slotIdx then
    TooltipSimple_Hide()
    return
  end
  local servantSlot = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]
  if nil == servantSlot then
    return
  end
  local skillList = servantSlot._list2_Control
  if nil == skillList then
    return
  end
  local content = skillList:GetContentByKey(toInt64(0, key32))
  if nil == content then
    return
  end
  local control = UI.getChildControl(content, "Static_SkillStallionIcon")
  if nil == control then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_WorldMapStableList_IsYPressTooltipShow()
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return false
  end
  return PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_Y_Tooltip:GetShow()
end
function HandleEventPadDown_WorldMap_StableList_YPressTooltipToggle(isUp)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_Y_Tooltip:SetShow(isUp)
end
function HandleEventScroll_WorldMap_StableList_ServantSkill(isUp)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  local currentSlot = PaGlobal_WorldMap_StableList._currentSelectSlot
  if currentSlot <= -1 or PaGlobal_WorldMap_StableList._MAXSLOTCOUNT == currentSlot then
    return
  end
  local servantSlot = PaGlobal_WorldMap_StableList._ui._servantSlot[currentSlot]
  if nil == servantSlot then
    return
  end
  local list2 = servantSlot._list2_Control
  if nil == list2 then
    return
  end
  if true == isUp then
    list2:MouseUpScroll(list2)
  else
    list2:MouseDownScroll(list2)
  end
end
function HandleEventLUp_WorldMap_StableList_ShowBeforeLook(slotIdx)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if nil == PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx] then
    return
  end
  local servantIdx = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]._horseIdx
  local regionKey = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]._regionKey
  if nil == servantIdx and nil == regionKey then
    return
  end
  local servantInfo = ToClient_GetServantFromRegionKeyRaw(regionKey, servantIdx)
  if nil == servantInfo then
    return
  end
  local slot = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]
  if true == slot._isLookChange then
    slot._stc_HorseImage:ChangeTextureInfoName(servantInfo:getIconPath1())
  else
    slot._stc_HorseImage:ChangeTextureInfoName(servantInfo:getBaseIconPath1())
  end
  slot._isLookChange = not slot._isLookChange
end
function HandleEventLUp_WorldMap_StableList_ShowBeforeLook_Tooltip(isShow, slotIdx)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if false == isShow or nil == slotIdx then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx] then
    return
  end
  local uiControl = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]._btn_beforeLook
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_LOOKCHANGETOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_LOOKCHANGETOOLTIP_DESC")
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventOnOut_WorldMap_StableList_ShowUseAddStatItemTooltip(isShow, slotNo, stat)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == slotNo then
    return
  end
  local slot = PaGlobal_WorldMap_StableList._ui._servantSlot[slotNo]
  if nil == slot then
    return
  end
  local control = slot._stc_OnlySpeed
  if nil == control or nil == stat then
    return
  end
  local statString = ""
  if __eServantStatTypeAcceleration == stat then
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION")
  elseif __eServantStatTypeSpeed == stat then
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED")
  elseif __eServantStatTypeCornering == stat then
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING")
  elseif __eServantStatTypeBrake == stat then
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE")
  else
    return
  end
  local name = ""
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_USEADDSTATITEMICON_TOOLTIP", "stat", statString)
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(isShow, slotNo, regionKey, servantIdx, skillKey32)
  if nil == isShow or false == isShow or true == PaGlobal_WorldMap_StableList._isConsole and slotNo ~= PaGlobal_WorldMap_StableList._curTargetSnapIndex then
    if true == _ContentsGroup_NewUI_Tooltip_All and nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    elseif nil ~= PaGlobal_Tooltip_Servant_Close then
      PaGlobal_Tooltip_Servant_Close()
    end
    return
  end
  if nil == slotNo or nil == regionKey or nil == servantIdx or nil == skillKey32 then
    return
  end
  local slot = PaGlobal_WorldMap_StableList._ui._servantSlot[slotNo]
  if nil == slot or nil == slot._list2_Control then
    return
  end
  local content = slot._list2_Control:GetContentByKey(toInt64(0, skillKey32))
  if nil == content then
    return
  end
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  if nil == skillIcon then
    return
  end
  local servantInfo = ToClient_GetServantFromRegionKeyRaw(regionKey, servantIdx)
  if nil == servantInfo then
    return
  end
  local skillWrapper = servantInfo:getSkill(skillKey32)
  if nil == skillWrapper then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    local isShowStallionSkillTooltip = false
    if true == PaGlobal_Servant_PremiumSkillRate._isConsole then
      isShowStallionSkillTooltip = servantInfo:isStallionSkill(skillWrapper:getKey())
    end
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false, isShowStallionSkillTooltip)
  end
end
function HandleEventOnOut_WorldMap_StableList_SnappingSkill(isOn, servantIdx, key32)
  if nil == Panel_WorldMap_StableList and false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if false == PaGlobal_WorldMap_StableList._isConsole then
    return
  end
  if nil == key32 or nil == servantIdx or nil == isOn or false == isOn then
    HandleEventOut_ServantInfo_All_SkillTooltipClose()
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_LTX:SetShow(false)
  else
    PaGlobal_WorldMap_StableList._selectServantIndex = servantIdx
    PaGlobal_WorldMap_StableList._selectSkillIndex = key32
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventOnOut_WorldMap_StableList_ShowSkillTooltipByPad()")
    PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_LTX:SetShow(true)
  end
  PaGlobal_WorldMap_StableList:switchConsoleUI()
end
function HandleEventOnOut_WorldMap_StableList_ShowSkillTooltipByPad()
  if false == PaGlobal_WorldMap_StableList._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_GetShow and true == PaGlobal_Tooltip_Skill_Servant_All_GetShow() then
      HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)
    else
      HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(true, PaGlobal_WorldMap_StableList._currentSelectSlot, PaGlobal_WorldMap_StableList._currentSelectRegionKey, PaGlobal_WorldMap_StableList._selectServantIndex, PaGlobal_WorldMap_StableList._selectSkillIndex)
    end
  elseif nil ~= Panel_Tooltip_Skill_Servant and true == Panel_Tooltip_Skill_Servant:GetShow() then
    HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)
  else
    HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(true, PaGlobal_WorldMap_StableList._currentSelectSlot, PaGlobal_WorldMap_StableList._currentSelectRegionKey, PaGlobal_WorldMap_StableList._selectServantIndex, PaGlobal_WorldMap_StableList._selectSkillIndex)
  end
end
function PaGlobal_WorldMap_StableList_TransferOpen(slotNo)
  if nil == slotNo and slotNo < 0 and slotNo >= PaGlobal_WorldMap_StableList._MAXSLOTCOUNT then
    return
  end
  local servantNo = PaGlobal_WorldMap_StableList._ui._servantSlot[slotNo]._servantNo_s64
  if nil == servantNo then
    return
  end
  if nil ~= PaGlobalFunc_ServantTransferList_All_OpenFromWorldmap then
    PaGlobalFunc_ServantTransferList_All_OpenFromWorldmap(servantNo)
  end
end
function PaGlobalFunc_WorldMap_StableList_ResetSnapping()
  if nil == Panel_WorldMap_StableList then
    return
  end
  if false == PaGlobal_WorldMap_StableList._isConsole then
    return
  end
  PaGlobal_WorldMap_StableList._curTargetSnapIndex = PaGlobal_WorldMap_StableList._TOWNSLOTINDEX
  HandleEventPadPress_WorldMap_StableList_MoveSnapping(true)
end
function PaGlobalFunc_WorldMap_StableList_SetSnappingIndex(index)
  if false == PaGlobal_WorldMap_StableList._isConsole then
    return
  end
  PaGlobal_WorldMap_StableList._curTargetSnapIndex = index
  if index <= PaGlobal_WorldMap_StableList._TOWNSLOTINDEX then
    PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_A:SetShow(false)
  else
    PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_A:SetShow(true)
    PaGlobal_WorldMap_StableList._ui._console._stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE"))
  end
  PaGlobal_WorldMap_StableList:switchConsoleUI()
end
function HandleEventPadPress_WorldMap_StableList_MoveSnapping(isRight)
  if nil == Panel_WorldMap_StableList then
    return
  end
  if false == PaGlobal_WorldMap_StableList._isConsole then
    return
  end
  local selectIndex = PaGlobal_WorldMap_StableList._curTargetSnapIndex
  local targetControl
  if false == isRight then
    if selectIndex <= PaGlobal_WorldMap_StableList._TOWNSLOTINDEX then
      return
    end
    selectIndex = selectIndex - 1
    if selectIndex <= PaGlobal_WorldMap_StableList._TOWNSLOTINDEX then
      for territoryKey, territoryInfo in pairs(PaGlobal_WorldMap_StableList._territoryInfoList) do
        local regionControl = PaGlobal_WorldMap_StableList._ui._list2_region:GetContentByKey(toInt64(0, territoryKey))
        if nil ~= regionControl and true == regionControl:GetShow() then
          selectIndex = PaGlobal_WorldMap_StableList._TOWNSLOTINDEX
          targetControl = regionControl
          break
        end
      end
    end
    if nil == targetControl then
      if selectIndex < 0 then
        selectIndex = 0
      end
      local servantSlot = PaGlobal_WorldMap_StableList._ui._servantSlot[selectIndex]
      if nil ~= servantSlot and nil ~= servantSlot._slot and true == servantSlot._slot:GetShow() then
        targetControl = servantSlot._slot
      end
    end
  else
    selectIndex = selectIndex + 1
    if selectIndex >= PaGlobal_WorldMap_StableList._MAXSLOTCOUNT then
      selectIndex = PaGlobal_WorldMap_StableList._MAXSLOTCOUNT - 1
    end
    local servantSlot = PaGlobal_WorldMap_StableList._ui._servantSlot[selectIndex]
    if nil ~= servantSlot and nil ~= servantSlot._slot and true == servantSlot._slot:GetShow() then
      targetControl = servantSlot._slot
    end
  end
  if nil ~= targetControl then
    ToClient_padSnapChangeToTarget(targetControl)
    PaGlobal_WorldMap_StableList._curTargetSnapIndex = selectIndex
    for slotIdx = 0, PaGlobal_WorldMap_StableList._MAXSLOTCOUNT - 1 do
      local servantSlot = PaGlobal_WorldMap_StableList._ui._servantSlot[slotIdx]
      if nil ~= servantSlot and nil ~= servantSlot._list2_Control then
        servantSlot._list2_Control:requestUpdateVisible()
      end
    end
    HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)
  end
end
function FromClient_WorldMap_StableList_UpdateList()
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:UpdateRegionHasStableList()
  PaGlobal_WorldMap_StableList:BuildRegionList()
  PaGlobal_WorldMap_StableList:update()
end
function FromClient_WorldMap_StableList_List2UpdateSkillSlot0(content, key)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:list2SkillUpdate(content, key, 0)
end
function FromClient_WorldMap_StableList_List2UpdateSkillSlot1(content, key)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:list2SkillUpdate(content, key, 1)
end
function FromClient_WorldMap_StableList_List2UpdateSkillSlot2(content, key)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:list2SkillUpdate(content, key, 2)
end
function FromClient_WorldMap_StableList_List2UpdateSkillSlot3(content, key)
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  PaGlobal_WorldMap_StableList:list2SkillUpdate(content, key, 3)
end
