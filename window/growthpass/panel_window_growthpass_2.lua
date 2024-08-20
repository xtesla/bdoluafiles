function PaGlobalFunc_GrowthPass_Open()
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == ToClient_checkAutoAcceptQuestCompleteForGrowthPass() then
    return
  end
  PaGlobal_GrowthPass:prepareOpen()
end
function PaGlobalFunc_GrowthPass_Close()
  if nil == Panel_Window_GrowthPass then
    return
  end
  PaGlobalFunc_GrowPath_Info_Close()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_GrowthPass:prepareClose()
end
function PaGlobalFunc_GrowthPass_IsShow()
  if nil == Panel_Window_GrowthPass then
    return false
  end
  return Panel_Window_GrowthPass:GetShow()
end
function PaGlobalFunc_GrowthPass_OnClickedStartButton()
  if nil == Panel_Window_GrowthPass then
    return
  end
  PaGlobal_GrowthPass:showIntroScreen(false)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eGrowthPassIntroScreen, true, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobalFunc_GrowthPass_OnClickedQuestionButton()
  if nil == Panel_Window_GrowthPass then
    return
  end
end
function PaGlobalFunc_GrowthPass_OnScrollEvent(where, isUp)
  local self = PaGlobal_GrowthPass
  if where == "Main" and true == self._isScrollShadowMode_Category then
    local vScroll = self._ui._frame_mainBG:GetVScroll()
    if nil == vScroll then
      return
    end
    local shadowBG_top = UI.getChildControl(self._ui._frame_mainBG, "Static_Shadow_Top")
    local shadowBG_bottom = UI.getChildControl(self._ui._frame_mainBG, "Static_Shadow_Botton")
    local scrollPos = vScroll:GetControlPos()
    if true == isUp then
      if 0 == scrollPos then
        shadowBG_top:SetShow(false)
      else
        shadowBG_top:SetShow(true)
      end
      shadowBG_bottom:SetShow(true)
    else
      if 1 == scrollPos then
        shadowBG_bottom:SetShow(false)
      else
        shadowBG_bottom:SetShow(true)
      end
      shadowBG_top:SetShow(true)
    end
    PaGlobalFunc_GrowPath_Info_Close()
  elseif where == "TotalReward" and true == self._isScrollShadowMode_TotalReward then
    local hScroll = self._ui._frame_totalRewardBG:GetHScroll()
    if nil == hScroll then
      return
    end
    local shadowBG_left = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Left")
    local shadowBG_right = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Right")
    local scrollPos = hScroll:GetControlPos()
    if true == isUp then
      if 0 == scrollPos then
        shadowBG_left:SetShow(false)
      else
        shadowBG_left:SetShow(true)
      end
      shadowBG_right:SetShow(true)
    else
      if 1 == scrollPos then
        shadowBG_right:SetShow(false)
      else
        shadowBG_right:SetShow(true)
      end
      shadowBG_left:SetShow(true)
    end
  end
end
function PaGlobalFunc_GrowthPass_OnClickedCategoryButton(index)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if index ~= PaGlobal_GrowthPass._currentSelectedCategoryIndex then
    PaGlobalFunc_GrowPath_Info_Close()
    PaGlobal_GrowthPass:showLayout(PaGlobal_GrowthPass:getCategoryIndex(), false)
    PaGlobal_GrowthPass:showLayout(index, true)
  end
  PaGlobal_GrowthPass:setCategoryIndex(index)
  PaGlobal_GrowthPass:updateCategory()
end
function PaGlobalFunc_GrowthPass_ShowQuestTooltip(categoryKeyRaw, row, col, isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if true == isShow then
    TooltipSimple_Hide()
    local categoryKey = GrowthPassCategoryKey(categoryKeyRaw)
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(categoryKey)
    local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
    if nil ~= cellWrapper then
      local questInfoWrapper = questList_getQuestStatic(cellWrapper:getQuestGroup(), cellWrapper:getQuestId())
      if nil ~= questInfoWrapper then
        local cellData = PaGlobal_GrowthPass._ui._categoryLayoutCellList[categoryKeyRaw][row][col]
        if nil ~= cellData then
          if true == questInfoWrapper:hasCheckOpenUICompleteCondition() then
            ToClient_UpdateOpenUICondition(cellWrapper:getQuestId() + __eCheckOpenUIType_ExpirienceWiki)
          end
          PaGlobalFunc_GrowPath_Info_Show(questInfoWrapper, cellData.control, false)
        end
      end
    end
  else
    PaGlobalFunc_GrowPath_Info_Close()
  end
end
function PaGlobalFunc_GrowthPass_ShowQuestSimpleTooltip(categoryKeyRaw, row, col, isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if true == isShow then
    if true == PaGlobal_GrowthPass_Info_GetShow() then
      return
    end
    local categoryKey = GrowthPassCategoryKey(categoryKeyRaw)
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(categoryKey)
    local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
    if nil ~= cellWrapper then
      local cellData = PaGlobal_GrowthPass._ui._categoryLayoutCellList[categoryKeyRaw][row][col]
      if nil ~= cellData then
        if true == cellData.closeContents:GetShow() then
          TooltipSimple_Show(cellData.closeContents, PAGetString(Defines.StringSheet_GAME, "LUA_GROWTHPASS_CONTENTS_NOTOPEN"), nil)
        else
          local questInfoWrapper = questList_getQuestStatic(cellWrapper:getQuestGroup(), cellWrapper:getQuestId())
          if nil ~= questInfoWrapper then
            local questNo = questInfoWrapper:getQuestNo()
            local questWrapper = ToClient_getQuestWrapper(questNo)
            if nil == questWrapper then
              return
            end
            local demandCount = questWrapper:getDemadCount()
            local demandString = ""
            for demandIndex = 0, demandCount - 1 do
              local demand = questWrapper:getDemandAt(demandIndex)
              demandString = demandString .. "- " .. demand._desc .. "\n"
            end
            TooltipSimple_Show(cellData.control, ToClient_getReplaceDialog(demandString), ToClient_getReplaceDialog(questWrapper:getDesc()))
          else
            TooltipSimple_Show(cellData.closeContents, PAGetString(Defines.StringSheet_GAME, "LUA_GROWTHPASS_CONTENTS_NOTOPEN"), nil)
          end
        end
      end
    end
  else
    TooltipSimple_Hide()
  end
end
function PaGlobalFunc_GrowthPass_ShowButtonSimpleTooltip(linkType)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  local targetControl
  if PaGlobal_GrowthPass._linkType.GUIDE == linkType then
    targetControl = PaGlobal_GrowthPass._ui._btn_linkGuideText
  elseif PaGlobal_GrowthPass._linkType.MARKET == linkType then
    targetControl = PaGlobal_GrowthPass._ui._btn_linkMarketText
  elseif PaGlobal_GrowthPass._linkType.QUEST == linkType then
    targetControl = PaGlobal_GrowthPass._ui._btn_linkQuestText
  elseif PaGlobal_GrowthPass._linkType.MANUFACTURE == linkType then
    targetControl = PaGlobal_GrowthPass._ui._btn_linkManufactureText
  end
  if nil == targetControl then
    return
  end
  TooltipSimple_Show(targetControl, targetControl:GetText(), nil)
end
function PaGlobalFunc_GrowthPass_HideButtonSimpleTooltip()
  if nil == Panel_Window_GrowthPass then
    return
  end
  TooltipSimple_Hide()
end
function PaGlobalFunc_GrowthPass_OnClickedCategoryRewardIcon(categoryKeyRaw, rewardIndex)
  if nil == Panel_Window_GrowthPass then
    return
  end
  local categoryKey = GrowthPassCategoryKey(categoryKeyRaw)
  if true == ToClient_isRewardedCategoryRewardItem(categoryKey, rewardIndex) then
    return
  end
  ToClient_requestCategoryRewardItem(categoryKey, rewardIndex)
end
function PaGlobalFunc_GrowthPass_ShowItemTooltip(categoryKeyRaw, rewardIndex, isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if true == isShow then
    local categoryKey = GrowthPassCategoryKey(categoryKeyRaw)
    local currentCategorySSWrapper = ToClient_getGrowthPassCategoryStaticStatusWrapper(categoryKey)
    if nil ~= currentCategorySSWrapper then
      local rewardItemWrapper = currentCategorySSWrapper:getRewardItemWrapper(rewardIndex)
      if nil ~= rewardItemWrapper then
        Panel_Tooltip_Item_Show(rewardItemWrapper, PaGlobal_GrowthPass._ui._categoryRewardDataList[rewardIndex].itemSlot.icon, true, false)
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_GrowthPass_OnClickedTotalRewardIcon(totalRewardKeyRaw)
  if nil == Panel_Window_GrowthPass then
    return
  end
  local totalRewardKey = GrowthPassTotalRewardKey(totalRewardKeyRaw)
  if true == ToClient_isRewardedTotalRewardItem(totalRewardKey) then
    return
  end
  ToClient_requestTotalRewardItem(totalRewardKey)
end
function PaGlobalFunc_GrowthPass_ShowTotalRewardItemTooltip(totalRewardIndex, isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if true == isShow then
    local totalRewardKey = ToClient_getGrowthPassTotalRewardKey(totalRewardIndex)
    local totalRewardSSW = ToClient_getGrowthPassTotalRewardStaticStatusWrapper(totalRewardKey)
    if nil ~= totalRewardSSW then
      local baseRewardItemWrapper = totalRewardSSW:getRewardItemWrapper()
      if nil ~= baseRewardItemWrapper then
        Panel_Tooltip_Item_Show(baseRewardItemWrapper, PaGlobal_GrowthPass._ui.totalRewardDataList[totalRewardIndex].baseItemSlot.icon, true, false)
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobalFunc_GrowthPass_OnClickedPointShop()
  if nil == Panel_Window_GrowthPass then
    return
  end
  PaGlobalFunc_GrowPath_PointShop_Show()
end
function HandleEventLUp_GrowthPass_LinkOpen(linkType)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  if PaGlobal_GrowthPass._linkType.GUIDE == linkType then
    if nil ~= FGlobal_Panel_WebHelper_ShowToggle then
      FGlobal_Panel_WebHelper_ShowToggle()
    end
  elseif PaGlobal_GrowthPass._linkType.MARKET == linkType then
    if true == _ContentsGroup_RenewUI_ItemMarketPlace_Only and nil ~= PaGlobalFunc_Menu_All_MarketPlace_Open then
      PaGlobalFunc_Menu_All_MarketPlace_Open()
    end
  elseif PaGlobal_GrowthPass._linkType.QUEST == linkType then
    if nil ~= HandleEventLUp_MenuRemake_QuestHistory then
      HandleEventLUp_MenuRemake_QuestHistory()
    end
  elseif PaGlobal_GrowthPass._linkType.MANUFACTURE == linkType and nil ~= HandleEventLUp_MenuRemake_Manufacture then
    HandleEventLUp_MenuRemake_Manufacture()
  end
  PaGlobalFunc_GrowthPass_Close()
end
function FromClient_GrowthPass_OnResizePanel()
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
end
function FromClient_notifyUpdateGrowthPassQuest(questGroup, questId)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  PaGlobal_GrowthPass:updateCategoryButton()
  PaGlobal_GrowthPass:updateCurrentCategoryQuestInfo()
  if true == PaGlobal_GrowthPass_Info_GetShow() then
    PaGlobal_GrowthPass:updateDetailTooltip(questGroup, questId)
  end
end
function FromClient_ClearGrowthPassQuest(questNo)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  PaGlobal_GrowthPass:updateCategoryButton()
  PaGlobal_GrowthPass:updateCurrentCategoryQuestInfo()
  PaGlobal_GrowthPass:playQuestWidgetAnimation(questNo)
  PaGlobal_GrowthPass:updateCategoryReward()
  PaGlobal_GrowthPass:updateTotalReward()
end
function FromClient_RefreshGrowthPassPanelByGetRewardItem(itemName, itemCount, itemIconPath)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  PaGlobalFunc_GrowPath_Info_Close()
end
function FromClient_GetGrowthPassCategoryTotalRewardItem(isCategoryReward)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  if true == isCategoryReward then
    PaGlobal_GrowthPass:updateCategoryButton()
    PaGlobal_GrowthPass:updateCategoryReward()
  else
    PaGlobal_GrowthPass:updateTotalReward()
  end
end
function PaGlobalFunc_GrowthPass_AdventurerNotes(questGroup, questId, idx)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if false == Panel_Window_GrowthPass:GetShow() then
    return
  end
  local questInfoWrapper = questList_getQuestStatic(questGroup, questId)
  local questNo = questInfoWrapper:getQuestNo()
  local questWrapper = ToClient_getQuestWrapper(questNo)
  local noteLink = ""
  local gameServiceResType = getGameServiceResType()
  noteLink = questWrapper:getNoteLink(idx, gameServiceResType)
  if "" ~= noteLink then
    InputMLUp_ExpirienceWiki_All_Close()
    PaGlobal_ExpirienceWiki_All_SetDirectLink(noteLink)
    PaGlobal_ExpirienceWiki_All_Open()
  end
end
