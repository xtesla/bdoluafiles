function PaGlobal_GrowthPass:initialize()
  if true == PaGlobal_GrowthPass._initialize then
    return
  end
  self:initialize_introArea()
  self:initialize_titleArea()
  self:initialize_categoryArea()
  self:initialize_categoryRewardArea()
  self:initialize_mainArea()
  self:initialize_startArea()
  self:initialize_totalRewardArea()
  self._init_panel_posX = Panel_Window_GrowthPass:GetPosX()
  self._init_panel_posY = Panel_Window_GrowthPass:GetPosY()
  self._ui._stc_keyguideBG = UI.getChildControl(self._ui._frame_mainBG, "Static_KeyGuide_BG")
  self._ui._stc_keyguideBG:SetShow(false)
  self._ui._frame_mainBG:GetVScroll():SetInterval(self._ui._frame_mainBG:GetSizeY() * 0.01 * 1.1)
  self:setCategoryIndex(0)
  self:showLayout(self._currentSelectedCategoryIndex, true)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GrowthPass:initialize_introArea()
  if nil == Panel_Window_GrowthPass then
    return
  end
  self._ui._btn_startOnIntroScreen = UI.getChildControl(self._ui._stc_startBG, "Button_Start")
  self._ui._btn_startOnIntroScreen:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_OnClickedStartButton()")
end
function PaGlobal_GrowthPass:initialize_titleArea()
  self._ui._btn_question = UI.getChildControl(self._ui._stc_titleArea, "Button_Question")
  self._ui._btn_question:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_OnClickedQuestionButton()")
  self._ui._btn_question:SetShow(false)
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_Close()")
end
function PaGlobal_GrowthPass:initialize_categoryArea()
  if nil == Panel_Window_GrowthPass then
    return
  end
  self._ui._btn_pointShop = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Button_OpenShop")
  self._ui._btn_pointShop:SetShow(false)
  self._ui._btn_pointShop:SetEnable(true)
  self._ui._btn_linkGuide = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Button_Link_Guide")
  self._ui._btn_linkGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_GrowthPass_LinkOpen(" .. self._linkType.GUIDE .. ")")
  self._ui._btn_linkGuideText = UI.getChildControl(self._ui._btn_linkGuide, "StaticText_2")
  self._ui._btn_linkGuideText:SetTextMode(__eTextMode_LimitText)
  self._ui._btn_linkGuideText:SetText(self._ui._btn_linkGuideText:GetText())
  if true == self._ui._btn_linkGuideText:IsLimitText() then
    self._ui._btn_linkGuide:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowButtonSimpleTooltip(" .. self._linkType.GUIDE .. ")")
    self._ui._btn_linkGuide:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_HideButtonSimpleTooltip()")
  end
  self._ui._btn_linkMarket = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Button_Link_Market")
  self._ui._btn_linkMarket:addInputEvent("Mouse_LUp", "HandleEventLUp_GrowthPass_LinkOpen(" .. self._linkType.MARKET .. ")")
  self._ui._btn_linkMarketText = UI.getChildControl(self._ui._btn_linkMarket, "StaticText_3")
  self._ui._btn_linkMarketText:SetTextMode(__eTextMode_LimitText)
  self._ui._btn_linkMarketText:SetText(self._ui._btn_linkMarketText:GetText())
  if true == self._ui._btn_linkMarketText:IsLimitText() then
    self._ui._btn_linkMarket:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowButtonSimpleTooltip(" .. self._linkType.MARKET .. ")")
    self._ui._btn_linkMarket:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_HideButtonSimpleTooltip()")
  end
  self._ui._btn_linkQuest = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Button_Link_Quest")
  self._ui._btn_linkQuest:addInputEvent("Mouse_LUp", "HandleEventLUp_GrowthPass_LinkOpen(" .. self._linkType.QUEST .. ")")
  self._ui._btn_linkQuestText = UI.getChildControl(self._ui._btn_linkQuest, "StaticText_4")
  self._ui._btn_linkQuestText:SetTextMode(__eTextMode_LimitText)
  self._ui._btn_linkQuestText:SetText(self._ui._btn_linkQuestText:GetText())
  if true == self._ui._btn_linkQuestText:IsLimitText() then
    self._ui._btn_linkQuest:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowButtonSimpleTooltip(" .. self._linkType.QUEST .. ")")
    self._ui._btn_linkQuest:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_HideButtonSimpleTooltip()")
  end
  self._ui._btn_linkManufacture = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Button_Link_Manufac")
  self._ui._btn_linkManufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_GrowthPass_LinkOpen(" .. self._linkType.MANUFACTURE .. ")")
  self._ui._btn_linkManufactureText = UI.getChildControl(self._ui._btn_linkManufacture, "StaticText_5")
  self._ui._btn_linkManufactureText:SetTextMode(__eTextMode_LimitText)
  self._ui._btn_linkManufactureText:SetText(self._ui._btn_linkManufactureText:GetText())
  if true == self._ui._btn_linkManufactureText:IsLimitText() then
    self._ui._btn_linkManufacture:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowButtonSimpleTooltip(" .. self._linkType.MANUFACTURE .. ")")
    self._ui._btn_linkManufacture:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_HideButtonSimpleTooltip()")
  end
  self._ui._stc_pointValue = UI.getChildControl(self._ui._btn_pointShop, "StaticText_Value")
  self._ui._stc_pointValue:SetShow(false)
  self._ui._stc_pointValue:SetEnable(true)
  local originalCategoryButton = UI.getChildControl(self._ui._stc_mainTabTypeBG, "Radiobutton_1")
  local categoryButtonTermSizeY = 5
  self._ui._categoryButtonList = {}
  self._categoryCount = Int64toInt32(ToClient_getGrowthPassCategoryCount())
  for index = 0, self._categoryCount - 1 do
    local key = ToClient_getGrowthPassCategoryKey(index)
    local categoryWrapper = ToClient_getGrowthPassCategoryStaticStatusWrapper(key)
    if nil ~= categoryWrapper then
      local categoryButtonData = {
        button = nil,
        buttonNameText = nil,
        childIcon = nil,
        childProgressBar = nil,
        childCompleteProgressBar = nil,
        childCompleteIcon = nil,
        categoryKey = nil
      }
      categoryButtonData.button = UI.cloneControl(originalCategoryButton, self._ui._stc_mainTabTypeBG, "CategoryButton_Clone_" .. tostring(key:get()))
      categoryButtonData.button:SetPosY(originalCategoryButton:GetPosY() + (originalCategoryButton:GetSizeY() + categoryButtonTermSizeY) * index)
      categoryButtonData.buttonNameText = UI.getChildControl(categoryButtonData.button, "StaticText_CategoryButtonName")
      categoryButtonData.buttonNameText:SetTextMode(__eTextMode_AutoWrap)
      categoryButtonData.buttonNameText:SetText(categoryWrapper:getCategoryName())
      categoryButtonData.childIcon = UI.getChildControl(categoryButtonData.button, "Static_CategoryIcon")
      categoryButtonData.childIcon:ChangeTextureInfoTextureIDAsync(categoryWrapper:getIconTextureId())
      categoryButtonData.childIcon:setRenderTexture(categoryButtonData.childIcon:getBaseTexture())
      categoryButtonData.childProgressBar = UI.getChildControl(categoryButtonData.button, "Progress2_1")
      categoryButtonData.childProgressBar:SetProgressRate(0)
      categoryButtonData.childCompleteProgressBar = UI.getChildControl(categoryButtonData.button, "Static_Complete")
      categoryButtonData.childCompleteProgressBar:SetShow(false)
      categoryButtonData.childCompleteIcon = UI.getChildControl(categoryButtonData.button, "Static_Mission_ComPlete")
      categoryButtonData.childCompleteIcon:SetShow(false)
      categoryButtonData.button:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_OnClickedCategoryButton(" .. tostring(index) .. ")")
      categoryButtonData.categoryKey = key
      self._ui._categoryButtonList[index] = categoryButtonData
    end
  end
  UI.deleteControl(originalCategoryButton)
end
function PaGlobal_GrowthPass:initialize_categoryRewardArea()
  self._ui._stc_completeCount = UI.getChildControl(self._ui._stc_categoryReward, "StaticText_Count_Value")
  self._ui._stc_totalCount = UI.getChildControl(self._ui._stc_categoryReward, "StaticText_Count_Total")
  self._ui._categoryRewardDataList = {}
  for rewardIndex = 0, self._categoryRewardCount - 1 do
    local categoryRewardData = {
      control = UI.getChildControl(self._ui._stc_categoryReward, "Static_SlotBG_" .. tostring(rewardIndex + 1)),
      itemSlot = nil,
      itemSlotControl = nil,
      itemNameControl = nil,
      NeedClearCountControl = nil,
      checkControl = nil
    }
    categoryRewardData.itemSlotControl = UI.getChildControl(categoryRewardData.control, "Static_ItemSlot")
    categoryRewardData.itemNameControl = UI.getChildControl(categoryRewardData.control, "StaticText_ItemName")
    categoryRewardData.NeedClearCountControl = UI.getChildControl(categoryRewardData.control, "StaticText_NeedCount")
    categoryRewardData.checkControl = UI.getChildControl(categoryRewardData.itemSlotControl, "Static_Checked")
    categoryRewardData.checkControl:SetShow(false)
    local tempSlot = {}
    SlotItem.new(tempSlot, "CategoryReward_Icon_" .. tostring(rewardIndex), rewardIndex, categoryRewardData.control, self._slotConfig)
    tempSlot:createChild()
    tempSlot.icon:SetSize(42, 42)
    tempSlot.icon:SetPosX(categoryRewardData.itemSlotControl:GetPosX())
    tempSlot.icon:SetPosY(categoryRewardData.itemSlotControl:GetPosY())
    tempSlot.icon:ComputePos()
    categoryRewardData.itemSlotControl:SetShow(true)
    categoryRewardData.itemSlot = tempSlot
    categoryRewardData.control:SetChildIndex(categoryRewardData.itemSlotControl, 9999)
    self._ui._categoryRewardDataList[rewardIndex] = categoryRewardData
  end
end
function PaGlobal_GrowthPass:initialize_mainArea()
  local parent = UI.getChildControl(self._ui._frame_mainBG, "Frame_1_Content")
  local originalQuestButtonTemplate = UI.getChildControl(parent, "Quest_Button_Template")
  _PA_ASSERT(nil ~= originalQuestButtonTemplate, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
  parent:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_GrowthPass_OnScrollEvent('Main', true)")
  parent:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_GrowthPass_OnScrollEvent('Main', false)")
  local originalLine_1 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_1")
  local originalLine_2 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_2")
  local originalLine_3 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_3")
  local originalLine_4 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_4")
  local originalLine_5 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_5")
  local originalLine_6 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_6")
  local originalLine_7 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_7")
  local originalLine_8 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_8")
  local originalLine_9 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_9")
  local originalLine_10 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_10")
  local originalLine_11 = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_11")
  local originalLine_Small = UI.getChildControl(self._ui._frame_mainBG, "Static_Line_Small_0")
  local originalLongLine_1 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_1")
  local originalLongLine_2 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_2")
  local originalLongLine_3 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_3")
  local originalLongLine_4 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_4")
  local originalLongLine_5 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_5")
  local originalLongLine_6 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_6")
  local originalLongLine_7 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_7")
  local originalLongLine_8 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_8")
  local originalLongLine_9 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_9")
  local originalLongLine_10 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_10")
  local originalLongLine_11 = UI.getChildControl(self._ui._frame_mainBG, "Static_Long_Line_11")
  local originalQuestButtonSizeX = originalQuestButtonTemplate:GetSizeX()
  local originalQuestButtonSizeY = originalQuestButtonTemplate:GetSizeY()
  local originalSmallLineSizeX = originalLine_Small:GetSizeX()
  local originalSmallLineSizeY = originalLine_Small:GetSizeY()
  self._ui._categoryLayoutCellList = {}
  self._categoryLimitSizeYList = {}
  for key, value in pairs(self._ui._categoryButtonList) do
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
    local categoryKeyRaw = value.categoryKey:get()
    self._ui._categoryLayoutCellList[categoryKeyRaw] = {}
    if nil ~= layoutWrapper then
      local totalRowCount = layoutWrapper:getRowCount()
      local totalColCount = layoutWrapper:getColCount()
      local cellPosY = self._layout_gapY_Top
      self._categoryLimitSizeYList[categoryKeyRaw] = 0
      for row = 0, totalRowCount - 1 do
        self._ui._categoryLayoutCellList[categoryKeyRaw][row] = {}
        local cellPosX = self._layout_gapX
        for col = 0, totalColCount - 1 do
          local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
          local cellData = {
            type = cellWrapper:getCellType(),
            control = nil,
            slotIcon = nil,
            reward = nil,
            rewardIcon = nil,
            completeIcon = nil,
            clearQuest = nil,
            questName = nil,
            questState = __eGrowthPass_QuestState_Count
          }
          local isLongSizeX = col % 2 == 0
          if nil ~= cellWrapper then
            local cellControlName = "LayoutCell_Clone_" .. tostring(categoryKeyRaw) .. "_" .. tostring(row) .. "_" .. tostring(col)
            if __eGrowthPass_CellType_Blank == cellData.type then
            elseif __eGrowthPass_CellType_Value == cellData.type then
              cellData.control = UI.cloneControl(originalQuestButtonTemplate, parent, cellControlName)
              cellData.slotIcon = UI.getChildControl(cellData.control, "Static_SlotIcon")
              cellData.reward = UI.getChildControl(cellData.control, "Static_Reward")
              cellData.rewardIcon = UI.getChildControl(cellData.reward, "Static_RewardIcon")
              cellData.clearQuest = UI.getChildControl(cellData.control, "Static_ClearQuest")
              cellData.completeIcon = UI.getChildControl(cellData.clearQuest, "Static_CompleteIcon")
              cellData.questName = UI.getChildControl(cellData.control, "StaticText_QuestName")
              cellData.closeContents = UI.getChildControl(cellData.control, "Static_CloseContent_BG")
              cellData.guideLink1 = UI.getChildControl(cellData.control, "Button_GuideLink1")
              cellData.guideLink2 = UI.getChildControl(cellData.control, "Button_GuideLink2")
              cellData.guideLink3 = UI.getChildControl(cellData.control, "Button_GuideLink3")
              local questInfoWrapper = questList_getQuestStatic(cellWrapper:getQuestGroup(), cellWrapper:getQuestId())
              local questNo = questInfoWrapper:getQuestNo()
              local questWrapper = ToClient_getQuestWrapper(questNo)
              if nil ~= questWrapper then
                cellData.questName:SetTextMode(__eTextMode_Limit_AutoWrap)
                cellData.questName:setLineCountByLimitAutoWrap(2)
                cellData.questName:SetText(questWrapper:getTitle())
                cellData.slotIcon:ChangeTextureInfoName(questWrapper:getGrowthPassIconPath())
                cellData.clearQuest:SetChildIndex(cellData.completeIcon, 9999)
                cellData.control:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_ShowQuestTooltip(" .. categoryKeyRaw .. "," .. row .. "," .. col .. "," .. "true)")
                cellData.control:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowQuestSimpleTooltip(" .. categoryKeyRaw .. "," .. row .. "," .. col .. "," .. "true)")
                cellData.control:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_ShowQuestSimpleTooltip(nil, nil, nil, false)")
                local gameServiceResType = getGameServiceResType()
                local noteLinkSize = questWrapper:getNoteLinkSize(gameServiceResType)
                if noteLinkSize >= 1 then
                  cellData.guideLink1:SetShow(true)
                  cellData.guideLink1:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_AdventurerNotes(" .. cellWrapper:getQuestGroup() .. "," .. cellWrapper:getQuestId() .. "," .. "0)")
                end
                if noteLinkSize >= 2 then
                  cellData.guideLink2:SetShow(true)
                  cellData.guideLink2:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_AdventurerNotes(" .. cellWrapper:getQuestGroup() .. "," .. cellWrapper:getQuestId() .. "," .. "1)")
                end
                if 3 == noteLinkSize then
                  cellData.guideLink3:SetShow(true)
                  cellData.guideLink3:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_AdventurerNotes(" .. cellWrapper:getQuestGroup() .. "," .. cellWrapper:getQuestId() .. "," .. "2)")
                end
              else
                cellData.slotIcon:SetShow(false)
                cellData.reward:SetShow(false)
                cellData.clearQuest:SetShow(false)
                cellData.questName:SetShow(false)
                cellData.closeContents:SetShow(true)
              end
            elseif __eGrowthPass_CellTYpe_InvalidValue == cellData.type then
              cellData.control = UI.cloneControl(originalQuestButtonTemplate, parent, cellControlName)
              cellData.slotIcon = UI.getChildControl(cellData.control, "Static_SlotIcon")
              cellData.reward = UI.getChildControl(cellData.control, "Static_Reward")
              cellData.clearQuest = UI.getChildControl(cellData.control, "Static_ClearQuest")
              cellData.questName = UI.getChildControl(cellData.control, "StaticText_QuestName")
              cellData.closeContents = UI.getChildControl(cellData.control, "Static_CloseContent_BG")
              cellData.slotIcon:SetShow(false)
              cellData.reward:SetShow(false)
              cellData.clearQuest:SetShow(false)
              cellData.questName:SetShow(false)
              cellData.closeContents:SetShow(true)
              cellData.closeContents:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowQuestSimpleTooltip(" .. categoryKeyRaw .. "," .. row .. "," .. col .. "," .. "true)")
              cellData.closeContents:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_ShowQuestSimpleTooltip(nil, nil, nil, false)")
            elseif __eGrowthPass_CellType_Vertical == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_1, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_1, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_Horizon == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_8, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_8, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_TR == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_7, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_7, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_LT == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_6, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_6, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_RB == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_9, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_9, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_BL == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_10, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_10, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_LRB == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_3, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_3, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_LTR == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_2, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_2, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_LTRB == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_11, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_11, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_LTB == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_5, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_5, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_TRB == cellData.type then
              if true == isLongSizeX then
                cellData.control = UI.cloneControl(originalLongLine_4, parent, cellControlName)
              else
                cellData.control = UI.cloneControl(originalLine_4, parent, cellControlName)
              end
            elseif __eGrowthPass_CellType_MiniVertical == cellData.type then
              cellData.control = UI.cloneControl(originalLine_Small, parent, cellControlName)
              if true == isLongSizeX then
                cellData.control:SetPosX(originalQuestButtonSizeX / 2 - originalSmallLineSizeX / 2)
              end
            else
              _PA_ASSERT(false, "cellType\236\157\180 \235\185\132\236\160\149\236\131\129 \236\158\133\235\139\136\235\139\164. key:" .. tostring(categoryKeyRaw) .. "/row:" .. tostring(row) .. "/col:" .. tostring(col) .. "/type:" .. tostring(cellData.type))
            end
            if nil ~= cellData.control then
              cellData.control:SetShow(false)
              cellData.control:SetPosX(cellData.control:GetPosX() + cellPosX)
              cellData.control:SetPosY(cellData.control:GetPosY() + cellPosY)
              cellData.control:SetSpanSize(0, 0)
            end
            if col % 2 == 0 then
              cellPosX = cellPosX + originalQuestButtonSizeX
            else
              cellPosX = cellPosX + originalSmallLineSizeX
            end
          end
          self._ui._categoryLayoutCellList[categoryKeyRaw][row][col] = cellData
        end
        if row % 2 == 0 then
          cellPosY = cellPosY + originalQuestButtonSizeY
        else
          cellPosY = cellPosY + originalSmallLineSizeY
        end
      end
      if cellPosY > self._categoryLimitSizeYList[categoryKeyRaw] then
        self._categoryLimitSizeYList[categoryKeyRaw] = cellPosY + self._layout_gapY_Bottom
      end
    else
      _PA_ASSERT(false, "\235\160\136\236\157\180\236\149\132\236\155\131 \236\160\149\235\179\180\234\176\128 nullptr\236\158\133\235\139\136\235\139\164. \237\153\149\236\157\184\235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164. [key:" .. tostring(categoryKeyRaw) .. "]")
    end
  end
  UI.deleteControl(originalQuestButtonTemplate)
  UI.deleteControl(originalLine_1)
  UI.deleteControl(originalLine_2)
  UI.deleteControl(originalLine_3)
  UI.deleteControl(originalLine_4)
  UI.deleteControl(originalLine_5)
  UI.deleteControl(originalLine_6)
  UI.deleteControl(originalLine_7)
  UI.deleteControl(originalLine_8)
  UI.deleteControl(originalLine_9)
  UI.deleteControl(originalLine_10)
  UI.deleteControl(originalLine_11)
  UI.deleteControl(originalLine_Small)
  UI.deleteControl(originalLongLine_1)
  UI.deleteControl(originalLongLine_2)
  UI.deleteControl(originalLongLine_3)
  UI.deleteControl(originalLongLine_4)
  UI.deleteControl(originalLongLine_5)
  UI.deleteControl(originalLongLine_6)
  UI.deleteControl(originalLongLine_7)
  UI.deleteControl(originalLongLine_8)
  UI.deleteControl(originalLongLine_9)
  UI.deleteControl(originalLongLine_10)
  UI.deleteControl(originalLongLine_11)
  self._ui._frame_mainBG:UpdateContentScroll()
end
function PaGlobal_GrowthPass:initialize_startArea()
end
function PaGlobal_GrowthPass:initialize_totalRewardArea()
  self._ui._stc_crio_bubble = UI.getChildControl(self._ui._stc_totalRewardBG, "StaticText_Crio_Bubble")
  local headBG = UI.getChildControl(self._ui._stc_totalRewardBG, "Static_Head_BG")
  self._ui._stc_total_reward_text = UI.getChildControl(headBG, "StaticText_Percent")
  self._ui._frame_totalRewardBG = UI.getChildControl(self._ui._stc_totalRewardBG, "Frame_TotalReward")
  self._ui._frame_totalRewardContent = UI.getChildControl(self._ui._frame_totalRewardBG, "Frame_1_Content")
  self._ui._frame_totalRewardProgress = UI.getChildControl(self._ui._frame_totalRewardContent, "Progress2_1")
  self._ui._frame_totalRewardProgressBG = UI.getChildControl(self._ui._frame_totalRewardContent, "Static_Progress_BG")
  self._ui._frame_totalRewardContent:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_GrowthPass_OnScrollEvent('TotalReward', true)")
  self._ui._frame_totalRewardContent:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_GrowthPass_OnScrollEvent('TotalReward', false)")
  local originalTotalBaseRewardTemplate = UI.getChildControl(self._ui._frame_totalRewardContent, "Static_ItemSlot_Basic_Tamplete")
  local originalNeedClearCountTemplate = UI.getChildControl(self._ui._frame_totalRewardContent, "StaticText_NeedCount_Template")
  local beginSlotPosX = self._totalReward_gapX
  local lastSlotPosX = 0
  self._ui.totalRewardDataList = {}
  local totalRewardCount = ToClient_getGrowthPassTotalRewardCount()
  for totalRewardIndex = 0, totalRewardCount - 1 do
    local totalRewardData = {
      totalRewardKey = ToClient_getGrowthPassTotalRewardKey(totalRewardIndex),
      baseItemSlotParent = nil,
      baseItemSlot = nil,
      baseItemIcon = nil,
      baseCheckedControl = nil,
      needClearCountControl = nil
    }
    local totalRewardSSW = ToClient_getGrowthPassTotalRewardStaticStatusWrapper(totalRewardData.totalRewardKey)
    if nil ~= totalRewardSSW then
      lastSlotPosX = beginSlotPosX + self._totalReward_gapX * totalRewardIndex
      local totalRewardBaseItemSSW = totalRewardSSW:getRewardItemWrapper()
      if nil ~= totalRewardBaseItemSSW then
        local baseRewardItemCount = totalRewardSSW:getRewardItemCount()
        totalRewardData.baseItemSlotParent = UI.cloneControl(originalTotalBaseRewardTemplate, self._ui._frame_totalRewardContent, "TotalBaseReward_Clone_" .. tostring(totalRewardIndex))
        totalRewardData.baseItemIcon = UI.getChildControl(totalRewardData.baseItemSlotParent, "Static_ItemIcon")
        totalRewardData.baseCheckedControl = UI.getChildControl(totalRewardData.baseItemSlotParent, "Static_Checked")
        totalRewardData.baseCheckedControl:SetShow(false)
        local tempSlot = {}
        SlotItem.new(tempSlot, "TotalReward_Base_Icon_" .. tostring(totalRewardIndex), totalRewardIndex, totalRewardData.baseItemSlotParent, self._slotConfig)
        tempSlot:createChild()
        tempSlot.icon:SetSize(42, 42)
        tempSlot.icon:SetPosX(0)
        tempSlot.icon:SetPosY(0)
        tempSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_OnClickedTotalRewardIcon(" .. tostring(totalRewardData.totalRewardKey:get()) .. ")")
        tempSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowTotalRewardItemTooltip(" .. tostring(totalRewardIndex) .. ", true)")
        tempSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_ShowTotalRewardItemTooltip(" .. tostring(totalRewardIndex) .. ", false)")
        tempSlot:clearItem()
        tempSlot:setItemByStaticStatus(totalRewardBaseItemSSW, baseRewardItemCount)
        totalRewardData.baseItemSlot = tempSlot
        totalRewardData.baseItemSlotParent:SetPosX(lastSlotPosX - totalRewardData.baseItemSlotParent:GetSizeX() / 2)
        totalRewardData.baseItemSlotParent:SetChildIndex(totalRewardData.baseCheckedControl, 9999)
        totalRewardData.baseItemSlotParent:ComputePos()
        local needClearCount = totalRewardSSW:getRewardClearCount()
        totalRewardData.needClearCountControl = UI.cloneControl(originalNeedClearCountTemplate, self._ui._frame_totalRewardContent, "TotalRewardNeedCount_Clone_" .. tostring(totalRewardIndex))
        totalRewardData.needClearCountControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GROWTHPASS_CATEGORYREWARD_NEEDCOUNT", "count", needClearCount))
        totalRewardData.needClearCountControl:SetPosX(lastSlotPosX - totalRewardData.needClearCountControl:GetSizeX() / 2)
        totalRewardData.needClearCountControl:ComputePos()
      else
        _PA_ASSERT(false, tostring(totalRewardIndex + 1) .. "\235\178\136 \236\167\184 \236\167\132\237\150\137\235\143\132 \235\179\180\236\131\129\236\157\152 BaseReward \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. (Key:" .. tostring(totalRewardData.totalRewardKey:get()) .. ")")
      end
    else
      _PA_ASSERT(false, tostring(totalRewardIndex + 1) .. "\235\178\136 \236\167\184 \236\167\132\237\150\137\235\143\132 \235\179\180\236\131\129 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. (Key:" .. tostring(totalRewardData.totalRewardKey:get()) .. ")")
    end
    self._ui.totalRewardDataList[totalRewardIndex] = totalRewardData
  end
  self._ui._frame_totalRewardContent:SetSize(lastSlotPosX, self._ui._frame_totalRewardContent:GetSizeY())
  self._ui._frame_totalRewardContent:ComputePos()
  self._ui._frame_totalRewardProgress:SetSize(lastSlotPosX, self._ui._frame_totalRewardProgress:GetSizeY())
  self._ui._frame_totalRewardProgress:ComputePos()
  self._ui._frame_totalRewardProgressBG:SetSize(self._ui._frame_totalRewardProgress:GetSizeX(), self._ui._frame_totalRewardProgressBG:GetSizeY())
  self._ui._frame_totalRewardProgressBG:ComputePos()
  local shadowBG_left = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Left")
  local shadowBG_right = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Right")
  if self._ui._frame_totalRewardBG:GetSizeX() < self._ui._frame_totalRewardContent:GetSizeX() then
    shadowBG_left:SetShow(false)
    shadowBG_right:SetShow(true)
    self._isScrollShadowMode_TotalReward = true
  else
    shadowBG_left:SetShow(false)
    shadowBG_right:SetShow(false)
    self._isScrollShadowMode_TotalReward = false
  end
  UI.deleteControl(originalTotalBaseRewardTemplate)
  UI.deleteControl(originalNeedClearCountTemplate)
end
function PaGlobal_GrowthPass:registEventHandler()
  if nil == Panel_Window_GrowthPass then
    return
  end
  registerEvent("onScreenResize", "FromClient_GrowthPass_OnResizePanel")
  registerEvent("FromClient_notifyUpdateGrowthPassQuest", "FromClient_notifyUpdateGrowthPassQuest")
  registerEvent("FromClient_ClearGrowthPassQuest", "FromClient_ClearGrowthPassQuest")
  registerEvent("FromClient_GetGrowthPassRewardItem", "FromClient_RefreshGrowthPassPanelByGetRewardItem")
  registerEvent("FromClient_GetGrowthPassCategoryTotalRewardItem", "FromClient_GetGrowthPassCategoryTotalRewardItem")
end
function PaGlobal_GrowthPass:prepareOpen()
  if nil == Panel_Window_GrowthPass then
    return
  end
  Panel_Window_GrowthPass:SetPosX(self._init_panel_posX)
  Panel_Window_GrowthPass:SetPosY(self._init_panel_posY)
  local isExistCacheData = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eGrowthPassIntroScreen)
  if false == isExistCacheData then
    self:showIntroScreen(true)
  end
  Panel_Window_GrowthPass:RegisterUpdateFunc("PaGlobalFunc_GrowthPass_Animation_Update")
  self:updateCategory()
  self:updateTotalReward()
  self:initTotalRewardScroll()
  self:open()
end
function PaGlobalFunc_GrowthPass_Animation_Update(deltaTime)
  if nil == Panel_Window_GrowthPass then
    return
  end
  local self = PaGlobal_GrowthPass
  self._animationFrame = self._animationFrame + deltaTime
  if self._animationFrame > 0.06666666666666667 and self._animationFrame < 1 then
    audioPostEvent_SystemUi(0, 21)
    _AudioPostEvent_SystemUiForXBOX(0, 21)
    self._animationFrame = 999
  end
end
function PaGlobal_GrowthPass:showIntroScreen(isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  self._ui._stc_startBG:SetShow(isShow)
end
function PaGlobal_GrowthPass:open()
  if nil == Panel_Window_GrowthPass then
    return
  end
  Panel_Window_GrowthPass:SetShow(true)
end
function PaGlobal_GrowthPass:prepareClose()
  if nil == Panel_Window_GrowthPass then
    return
  end
  Panel_Window_GrowthPass:ClearUpdateLuaFunc()
  self:clear()
  self:close()
end
function PaGlobal_GrowthPass:clear()
  if nil == Panel_Window_GrowthPass then
    return
  end
end
function PaGlobal_GrowthPass:close()
  if nil == Panel_Window_GrowthPass then
    return
  end
  Panel_Window_GrowthPass:SetShow(false)
end
function PaGlobal_GrowthPass:validate()
  if nil == Panel_Window_GrowthPass then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._stc_mainTabTypeBG:isValidate()
  self._ui._stc_categoryReward:isValidate()
  self._ui._frame_mainBG:isValidate()
  self._ui._stc_startBG:isValidate()
  self._ui._stc_totalRewardBG:isValidate()
end
function PaGlobal_GrowthPass:initLayoutScroll()
  if nil == Panel_Window_GrowthPass then
    return
  end
  local vScroll = self._ui._frame_mainBG:GetVScroll()
  vScroll:SetControlPos(0)
  self._ui._frame_mainBG:UpdateContentPos()
end
function PaGlobal_GrowthPass:initTotalRewardScroll()
  if nil == Panel_Window_GrowthPass then
    return
  end
  local hScroll = self._ui._frame_totalRewardBG:GetHScroll()
  hScroll:SetControlPos(0)
  self._ui._frame_totalRewardBG:UpdateContentPos()
  local shadowBG_left = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Left")
  local shadowBG_right = UI.getChildControl(self._ui._frame_totalRewardBG, "Static_Shadow_Right")
  if self._ui._frame_totalRewardBG:GetSizeX() < self._ui._frame_totalRewardContent:GetSizeX() then
    shadowBG_left:SetShow(false)
    shadowBG_right:SetShow(true)
  else
    shadowBG_left:SetShow(false)
    shadowBG_right:SetShow(false)
  end
end
function PaGlobal_GrowthPass:setCategoryIndex(index)
  if nil == Panel_Window_GrowthPass then
    return
  end
  local self = PaGlobal_GrowthPass
  self._currentSelectedCategoryIndex = index
  self._ui._categoryButtonList[index].button:SetCheck(true)
end
function PaGlobal_GrowthPass:getCategoryIndex()
  if nil == Panel_Window_GrowthPass then
    return -1
  end
  local self = PaGlobal_GrowthPass
  return self._currentSelectedCategoryIndex
end
function PaGlobal_GrowthPass:updateCategory()
  if nil == Panel_Window_GrowthPass then
    return
  end
  self:updateCategoryButton()
  self:updateCategoryLayout()
  self:updateCategoryReward()
end
function PaGlobal_GrowthPass:updateCategoryButton()
  if nil == Panel_Window_GrowthPass then
    return
  end
  for key, value in pairs(self._ui._categoryButtonList) do
    local categorySSW = ToClient_getGrowthPassCategoryStaticStatusWrapper(value.categoryKey)
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
    if nil ~= layoutWrapper and nil ~= categorySSW then
      local totalCount = categorySSW:getRewardMaxCount()
      local clearCount = layoutWrapper:getClearValueCount()
      local ratio = math.min(clearCount / totalCount, 1)
      value.childProgressBar:SetProgressRate(ratio * 100)
      if true == ToClient_checkGetableGrowthPassCategoryAndQuestItem(value.categoryKey) then
        value.childCompleteIcon:SetShow(true)
      else
        value.childCompleteIcon:SetShow(false)
      end
      if ratio >= 1 then
        value.childCompleteProgressBar:SetShow(true)
      else
        value.childCompleteProgressBar:SetShow(false)
      end
    end
  end
end
function PaGlobal_GrowthPass:updateCategoryLayout()
  if nil == Panel_Window_GrowthPass then
    return
  end
  if self._categoryCount <= self._currentSelectedCategoryIndex or self._currentSelectedCategoryIndex < 0 then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\157\184\235\141\177\236\138\164 \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  self._ui._frame_mainBG:UpdateContentScroll()
  self:updateCurrentCategoryQuestInfo()
end
function PaGlobal_GrowthPass:showLayout(index, isShow)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if index >= self._categoryCount or index < 0 then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\157\184\235\141\177\236\138\164 \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  local categoryData = self._ui._categoryButtonList[index]
  if nil == categoryData then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \235\141\176\236\157\180\237\132\176\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local keyRaw = categoryData.categoryKey:get()
  local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(categoryData.categoryKey)
  if nil == layoutWrapper then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 wrapper\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local layoutList = self._ui._categoryLayoutCellList[keyRaw]
  if nil == layoutList then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \235\160\136\236\157\180\236\149\132\236\155\131\236\157\132 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local totalRowCount = layoutWrapper:getRowCount()
  local totalColCount = layoutWrapper:getColCount()
  for row = 0, totalRowCount - 1 do
    for col = 0, totalColCount - 1 do
      local cellRef = layoutList[row][col]
      if nil ~= cellRef then
        if nil ~= cellRef.control then
          cellRef.control:SetShow(isShow)
        end
      else
        _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\133\128 \235\141\176\236\157\180\237\132\176\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.[" .. tostring(keyRaw) .. "][" .. tostring(row) .. "][" .. tostring(col) .. "]")
      end
    end
  end
  self:initLayoutScroll()
end
function PaGlobal_GrowthPass:updateCategoryReward()
  if nil == Panel_Window_GrowthPass then
    return
  end
  if self._categoryCount <= self._currentSelectedCategoryIndex or self._currentSelectedCategoryIndex < 0 then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\157\184\235\141\177\236\138\164 \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  for key, value in pairs(self._ui._categoryButtonList) do
    if self._currentSelectedCategoryIndex == key then
      local currentCategorySSW = ToClient_getGrowthPassCategoryStaticStatusWrapper(value.categoryKey)
      if nil == currentCategorySSW then
        _PA_ASSERT(false, "[Lua] \236\132\177\236\158\165\237\140\168\236\138\164 \236\185\180\237\133\140\234\179\160\235\166\172 \234\179\160\236\160\149\236\160\149\235\179\180\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164. (CategoryKey:" .. tostring(categoryKeyRaw) .. ")")
      end
      local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
      local categoryKeyRaw = value.categoryKey:get()
      if nil ~= layoutWrapper and nil ~= currentCategorySSW then
        local totalCount = currentCategorySSW:getRewardMaxCount()
        local clearCount = layoutWrapper:getClearValueCount()
        self._ui._stc_completeCount:SetText(tostring(clearCount))
        self._ui._stc_completeCount:SetSize(self._ui._stc_completeCount:GetTextSizeX(), self._ui._stc_completeCount:GetSizeY())
        self._ui._stc_totalCount:SetText(" / " .. tostring(totalCount))
        self._ui._stc_totalCount:SetSize(self._ui._stc_totalCount:GetTextSizeX(), self._ui._stc_totalCount:GetSizeY())
        self._ui._stc_totalCount:SetPosX(self._ui._stc_completeCount:GetPosX() + self._ui._stc_completeCount:GetSizeX())
        local currentCategorySSW = ToClient_getGrowthPassCategoryStaticStatusWrapper(value.categoryKey)
        for rewardIndex = 0, self._categoryRewardCount - 1 do
          local rewardItemWrapper = currentCategorySSW:getRewardItemWrapper(rewardIndex)
          if nil == rewardItemWrapper then
            _PA_ASSERT(false, "[Lua] \236\132\177\236\158\165\237\140\168\236\138\164 \236\185\180\237\133\140\234\179\160\235\166\172\236\157\152 \235\179\180\236\131\129 \236\149\132\236\157\180\237\133\156 \234\179\160\236\160\149\236\160\149\235\179\180\235\165\188 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \237\153\149\236\157\184 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164. (CategoryKey:" .. tostring(categoryKeyRaw) .. ")")
            return
          end
          local rewardItemCount = Int64toInt32(currentCategorySSW:getRewardItemCount(rewardIndex))
          local needClearCount = currentCategorySSW:getRewardClearCount(rewardIndex)
          local rewardDataRef = self._ui._categoryRewardDataList[rewardIndex]
          if nil ~= rewardDataRef then
            rewardDataRef.itemSlot:clearItem()
            rewardDataRef.itemSlot:setItemByStaticStatus(rewardItemWrapper, rewardItemCount)
            rewardDataRef.itemSlot.icon:removeInputEvent("Mouse_LUp")
            rewardDataRef.itemSlot.icon:removeInputEvent("Mouse_On")
            rewardDataRef.itemSlot.icon:removeInputEvent("Mouse_Out")
            rewardDataRef.itemSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_OnClickedCategoryRewardIcon(" .. tostring(categoryKeyRaw) .. "," .. tostring(rewardIndex) .. ")")
            rewardDataRef.itemSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_GrowthPass_ShowItemTooltip(" .. tostring(categoryKeyRaw) .. "," .. tostring(rewardIndex) .. ",true)")
            rewardDataRef.itemSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_GrowthPass_ShowItemTooltip(" .. tostring(categoryKeyRaw) .. "," .. tostring(rewardIndex) .. ",false)")
            rewardDataRef.itemNameControl:SetTextMode(__eTextMode_LimitText)
            rewardDataRef.itemNameControl:SetText(rewardItemWrapper:getName())
            rewardDataRef.NeedClearCountControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GROWTHPASS_REWARD_COUNT", "count", needClearCount))
            if clearCount >= needClearCount then
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 0, 718, 133, 963, 186)
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 1, 1210, 187, 1455, 240)
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 2, 1210, 241, 1455, 294)
            else
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 0, 964, 133, 1209, 186)
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 1, 1210, 295, 1455, 348)
              self:changeGrowthPassTexture(rewardDataRef.control, "combine/etc/combine_etc_growthsupport.dds", 2, 1210, 349, 1455, 402)
            end
            if true == ToClient_isRewardedCategoryRewardItem(value.categoryKey, rewardIndex) then
              rewardDataRef.checkControl:SetShow(true)
            else
              rewardDataRef.checkControl:SetShow(false)
            end
            if true == ToClient_checkGetableGrowthPassCategoryRewardItem(value.categoryKey, rewardIndex) then
              rewardDataRef.itemSlot.icon:SetMonoTone(false)
            else
              rewardDataRef.itemSlot.icon:SetMonoTone(true)
            end
          end
        end
      end
      break
    end
  end
end
function PaGlobal_GrowthPass:changeGrowthPassTexture(control, texturePath, index, uv_x1, uv_y1, uv_x2, uv_y2)
  if 0 == index then
    control:ChangeTextureInfoName(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(control, uv_x1, uv_y1, uv_x2, uv_y2)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif 1 == index then
    control:ChangeOnTextureInfoName(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(control, uv_x1, uv_y1, uv_x2, uv_y2)
    control:getOnTexture():setUV(x1, y1, x2, y2)
  elseif 2 == index then
    control:ChangeClickTextureInfoName(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(control, uv_x1, uv_y1, uv_x2, uv_y2)
    control:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_GrowthPass:updateTotalReward()
  if nil == Panel_Window_GrowthPass then
    return
  end
  local totalCount = ToClient_getGrowthPassTotalRewardMaxCount()
  local clearCount = 0
  for key, value in pairs(self._ui._categoryButtonList) do
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
    if nil ~= layoutWrapper then
      clearCount = clearCount + layoutWrapper:getClearValueCount()
    end
  end
  local ratio = clearCount / totalCount
  local percent = ratio * 100
  self._ui._frame_totalRewardProgress:SetProgressRate(percent)
  self._ui._stc_total_reward_text:SetText(tostring(clearCount) .. " / " .. tostring(totalCount))
  self:updateTotalRewardItemState()
end
function PaGlobal_GrowthPass:updateCurrentCategoryQuestInfo()
  if nil == Panel_Window_GrowthPass then
    return
  end
  if self._categoryCount <= self._currentSelectedCategoryIndex or self._currentSelectedCategoryIndex < 0 then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\157\184\235\141\177\236\138\164 \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  for key, value in pairs(self._ui._categoryButtonList) do
    if key == self._currentSelectedCategoryIndex then
      local categoryKeyRaw = value.categoryKey:get()
      local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
      if nil ~= layoutWrapper then
        local totalRowCount = layoutWrapper:getRowCount()
        local totalColCount = layoutWrapper:getColCount()
        for row = 0, totalRowCount - 1 do
          for col = 0, totalColCount - 1 do
            local cellData = self._ui._categoryLayoutCellList[categoryKeyRaw][row][col]
            if nil ~= cellData and __eGrowthPass_CellType_Value == cellData.type then
              local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
              if nil ~= cellWrapper then
                local currentQuestState = ToClient_getGrowthPassQuestState(cellWrapper:getQuestGroup(), cellWrapper:getQuestId())
                if __eGrowthPass_QuestState_Progress == currentQuestState or __eGrowthPass_QuestState_Count == currentQuestState then
                  cellData.reward:SetShow(false)
                  cellData.rewardIcon:SetShow(false)
                  cellData.clearQuest:SetShow(false)
                  cellData.completeIcon:SetShow(false)
                elseif __eGrowthPass_QuestState_Complete == currentQuestState then
                  cellData.reward:SetShow(true)
                  cellData.rewardIcon:SetShow(true)
                  cellData.clearQuest:SetShow(false)
                  cellData.completeIcon:SetShow(false)
                elseif __eGrowthPass_QuestState_Clear == currentQuestState then
                  cellData.reward:SetShow(false)
                  cellData.rewardIcon:SetShow(false)
                  cellData.clearQuest:SetShow(true)
                  cellData.completeIcon:SetShow(true)
                end
                cellData.questState = currentQuestState
              end
            end
          end
        end
      end
      local frame_content = UI.getChildControl(self._ui._frame_mainBG, "Frame_1_Content")
      frame_content:SetSize(frame_content:GetSizeX(), self._categoryLimitSizeYList[categoryKeyRaw])
      local shadowBG_top = UI.getChildControl(self._ui._frame_mainBG, "Static_Shadow_Top")
      local shadowBG_bottom = UI.getChildControl(self._ui._frame_mainBG, "Static_Shadow_Botton")
      if self._ui._frame_mainBG:GetSizeY() < frame_content:GetSizeY() then
        shadowBG_top:SetShow(false)
        shadowBG_bottom:SetShow(true)
        self._isScrollShadowMode_Category = true
        break
      end
      shadowBG_top:SetShow(false)
      shadowBG_bottom:SetShow(false)
      self._ui._frame_mainBG:GetVScroll():SetShow(false)
      self._isScrollShadowMode_Category = false
      break
    end
  end
end
function PaGlobal_GrowthPass:playQuestWidgetAnimation(questNo)
  if nil == Panel_Window_GrowthPass then
    return
  end
  if self._categoryCount <= self._currentSelectedCategoryIndex or self._currentSelectedCategoryIndex < 0 then
    _PA_ASSERT(false, "\236\185\180\237\133\140\234\179\160\235\166\172 \236\157\184\235\141\177\236\138\164 \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  for key, value in pairs(self._ui._categoryButtonList) do
    if key == self._currentSelectedCategoryIndex then
      local categoryKeyRaw = value.categoryKey:get()
      local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
      if nil ~= layoutWrapper then
        local totalRowCount = layoutWrapper:getRowCount()
        local totalColCount = layoutWrapper:getColCount()
        for row = 0, totalRowCount - 1 do
          for col = 0, totalColCount - 1 do
            local cellData = self._ui._categoryLayoutCellList[categoryKeyRaw][row][col]
            if nil ~= cellData and __eGrowthPass_CellType_Value == cellData.type then
              local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
              if nil ~= cellWrapper and cellWrapper:getQuestNo()._group == questNo._group and cellWrapper:getQuestNo()._quest == questNo._quest then
                local parent = UI.getChildControl(self._ui._frame_mainBG, "Frame_1_Content")
                parent:SetChildIndex(cellData.control, 9999)
                cellData.completeIcon:ResetVertexAni()
                cellData.completeIcon:SetVertexAniRun("Ani_Move_Pos_New", true)
                cellData.completeIcon:SetVertexAniRun("Ani_Scale_New", true)
                self._animationFrame = 0
                return
              end
            end
          end
        end
      end
      break
    end
  end
end
function PaGlobal_GrowthPass:updateTotalRewardItemState()
  if nil == Panel_Window_GrowthPass then
    return
  end
  local totalClearCount = 0
  for key, value in pairs(self._ui._categoryButtonList) do
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
    if nil ~= layoutWrapper then
      totalClearCount = totalClearCount + layoutWrapper:getClearValueCount()
    end
  end
  local totalRewardCount = ToClient_getGrowthPassTotalRewardCount()
  for index = 0, totalRewardCount - 1 do
    local totalRewardKey = ToClient_getGrowthPassTotalRewardKey(index)
    if true == ToClient_isRewardedTotalRewardItem(totalRewardKey) then
      self._ui.totalRewardDataList[index].baseCheckedControl:SetShow(true)
    else
      self._ui.totalRewardDataList[index].baseCheckedControl:SetShow(false)
    end
    if true == ToClient_checkGetableGrowthPassTotalRewardItem(totalRewardKey) then
      self._ui.totalRewardDataList[index].baseItemSlot.icon:SetMonoTone(false)
    else
      self._ui.totalRewardDataList[index].baseItemSlot.icon:SetMonoTone(true)
    end
  end
end
function PaGlobal_GrowthPass:updateDetailTooltip(questGroup, questId)
  if nil == Panel_Window_GrowthPass then
    return
  end
  for key, value in pairs(self._ui._categoryButtonList) do
    local categoryKeyRaw = value.categoryKey:get()
    local layoutWrapper = ToClient_getGrowthPassLayoutWrapper(value.categoryKey)
    if nil ~= layoutWrapper then
      local totalRowCount = layoutWrapper:getRowCount()
      local totalColCount = layoutWrapper:getColCount()
      for row = 0, totalRowCount - 1 do
        for col = 0, totalColCount - 1 do
          local cellData = self._ui._categoryLayoutCellList[categoryKeyRaw][row][col]
          if nil ~= cellData and __eGrowthPass_CellType_Value == cellData.type then
            local cellWrapper = layoutWrapper:getCellObjectWrapper(row, col)
            if nil ~= cellWrapper and cellWrapper:getQuestGroup() == questGroup and cellWrapper:getQuestId() == questId then
              local questInfoWrapper = questList_getQuestStatic(questGroup, questId)
              PaGlobalFunc_GrowPath_Info_Show(questInfoWrapper, cellData.control, true)
              return
            end
          end
        end
      end
    end
  end
end
