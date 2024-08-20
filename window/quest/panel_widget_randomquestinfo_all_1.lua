function PaGlobal_RandomQuestInfo_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_questTitle = UI.getChildControl(Panel_Widget_RandomQuestInfo_All, "StaticText_Name")
  self._ui._txt_questDesc = UI.getChildControl(Panel_Widget_RandomQuestInfo_All, "StaticText_Desc")
  self._ui._stc_rewardGroupBg = UI.getChildControl(Panel_Widget_RandomQuestInfo_All, "Static_RewardGroup")
  self._ui._stc_baseRewardBg = UI.getChildControl(self._ui._stc_rewardGroupBg, "Static_BaseRewardBG")
  self._ui._stc_baseMenuReward = UI.getChildControl(self._ui._stc_baseRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlotBg[index] = UI.getChildControl(self._ui._stc_baseRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._baseRewardSlot[index] = UI.getChildControl(self._ui._stc_baseRewardBg, "Static_Slot_" .. index)
  end
  self._ui._stc_selectRewardBg = UI.getChildControl(self._ui._stc_rewardGroupBg, "Static_SelectRewardBG")
  self._ui._stc_selectMenuReward = UI.getChildControl(self._ui._stc_selectRewardBg, "Static_Menu_Reward")
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlotBg[index] = UI.getChildControl(self._ui._stc_selectRewardBg, "Static_Reward_Slot_" .. index)
    self._ui._selectRewardSlot[index] = UI.getChildControl(self._ui._stc_selectRewardBg, "Static_Slot_" .. index)
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._ui._baseRewardSlot[index]:SetIgnore(true)
    self._uiBackBaseReward[index] = self._ui._baseRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "BaseReward_" .. index, index, self._ui._baseRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listBaseRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Base")
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._ui._selectRewardSlot[index]:SetIgnore(true)
    self._uiBackSelectReward[index] = self._ui._selectRewardSlot[index]
    local slot = {}
    SlotItem.new(slot, "SelectReward_" .. index, index, self._ui._selectRewardSlot[index], self._rewardSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(1)
    slot.icon:SetPosY(1)
    slot.icon:SetSize(40, 40)
    slot.border:SetSize(42, 42)
    slot.icon:SetIgnore(false)
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    if true == self._isConsole then
      slot.icon:SetIgnore(true)
    end
    self._listSelectRewardSlots[index] = slot
    Panel_Tooltip_Item_SetPosition(index, slot, "QuestReward_Select")
  end
  self._ui._txt_agrisPointInfo = UI.getChildControl(Panel_Widget_RandomQuestInfo_All, "StaticText_AgrisPoint_Info")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RandomQuestInfo_All:registEventHandler()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  registerEvent("FromClient_Worldmap_RandomQuestOver", "FromClient_RandomQuestInfo_All_RandomQuestOver")
  if true == self._isConsole then
    Panel_Widget_RandomQuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    Panel_Widget_RandomQuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_A, "")
    Panel_Widget_RandomQuestInfo_All:registerPadEvent(__eConsoleUIPadEvent_X, "")
  else
  end
end
function PaGlobal_RandomQuestInfo_All:prepareOpen(groupId, questId)
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  if nil == groupId or nil == questId then
    return
  end
  if false == _ContentsGroup_FeverQuest or false == _ContentsGroup_WorldmapFeverQuest then
    return
  end
  if true == questList_isClearQuest(groupId, questId) then
    return
  end
  local questInfo = questList_getQuestStatic(groupId, questId)
  if nil == questInfo then
    return
  end
  local agrisPoint = questInfo:getQuestFeverPoint()
  if agrisPoint <= 0 then
    return
  end
  self:update(questInfo, agrisPoint)
  self:open()
end
function PaGlobal_RandomQuestInfo_All:open()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  if true == Panel_Widget_RandomQuestInfo_All:GetShow() then
    return
  end
  if true == self._isConsole or true == Panel_Window_Quest_All:IsUISubApp() then
    Panel_Widget_RandomQuestInfo_All:SetShow(true)
  else
    Panel_Widget_RandomQuestInfo_All:SetShow(true, true)
  end
end
function PaGlobal_RandomQuestInfo_All:prepareClose()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  if true == Panel_Widget_RandomQuestInfo_All:IsUISubApp() then
    Panel_Widget_RandomQuestInfo_All:CloseUISubApp()
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_RandomQuestInfo_All:close()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  Panel_Widget_RandomQuestInfo_All:SetShow(false, false)
end
function PaGlobal_RandomQuestInfo_All:update(questInfo)
  if nil == questInfo then
    return
  end
  local agrisPoint = questInfo:getQuestFeverPoint()
  if agrisPoint <= 0 then
    return
  end
  if false == _ContentsGroup_FeverQuest or false == _ContentsGroup_WorldmapFeverQuest then
    return
  end
  self._ui._txt_questTitle:SetShow(true)
  self._ui._txt_questTitle:SetText(questInfo:getTitle())
  local demandCount = questInfo:getDemadCount()
  local demandString = ""
  for demandIndex = 0, demandCount - 1 do
    local demand = questInfo:getDemandAt(demandIndex)
    demandString = demandString .. "- " .. demand._desc .. "\n"
  end
  self._ui._txt_questDesc:SetShow(true)
  self._ui._txt_questDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_questDesc:SetAutoResize(true)
  self._ui._txt_questDesc:SetText(tostring(ToClient_getReplaceDialog(demandString)))
  local gabY = 20
  local descGabY = self._ui._txt_questDesc:GetSpanSize().y + self._ui._txt_questDesc:GetSizeY() + 5
  self._ui._txt_agrisPointInfo:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_QUEST_AGRISDESC", "point", tostring(agrisPoint)))
  self._ui._txt_agrisPointInfo:SetShow(true)
  self._ui._txt_agrisPointInfo:SetSpanSize(self._ui._txt_agrisPointInfo:GetSpanSize().x, descGabY)
  descGabY = descGabY + self._ui._txt_agrisPointInfo:GetSizeY() + 10
  local baseCount = questInfo:getQuestBaseRewardCount()
  local selectCount = questInfo:getQuestSelectRewardCount()
  self._baseReward = {}
  for baseIdx = 1, baseCount do
    local baseReward = questInfo:getQuestBaseRewardAt(baseIdx - 1)
    self._baseReward[baseIdx] = {}
    self._baseReward[baseIdx]._type = baseReward:getType()
    if __eRewardExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getExperience()
    elseif __eRewardSkillExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getSkillExperience()
    elseif __eRewardLifeExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exp = baseReward:getProductExperience()
    elseif __eRewardItem == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._item = baseReward:getItemEnchantKey()
      self._baseReward[baseIdx]._count = baseReward:getItemCount()
    elseif __eRewardIntimacy == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._character = baseReward:getIntimacyCharacter()
      self._baseReward[baseIdx]._value = baseReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._mentalCard = baseReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._season = baseReward:getSeasonNo()
    elseif __eRewardExploreExp == self._baseReward[baseIdx]._type then
      self._baseReward[baseIdx]._exploreExp = Int64toInt32(baseReward:getExploreExperience())
    end
  end
  for index = 0, self._MAX_BASE_REWARD - 1 do
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listBaseRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._baseRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._baseRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackBaseReward[index]:SetShow(false)
    if index < #self._baseReward then
      self:setReward(self._listBaseRewardSlots[index], self._baseReward[index + 1], index, "main")
      self._uiBackBaseReward[index]:SetShow(true)
    end
  end
  self._selectReward = {}
  for selectIdx = 1, selectCount do
    local selectReward = questInfo:getQuestSelectRewardAt(selectIdx - 1)
    self._selectReward[selectIdx] = {}
    self._selectReward[selectIdx]._type = selectReward:getType()
    if __eRewardExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getExperience()
    elseif __eRewardSkillExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getSkillExperience()
    elseif __eRewardLifeExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exp = selectReward:getProductExperience()
    elseif __eRewardItem == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._item = selectReward:getItemEnchantKey()
      self._selectReward[selectIdx]._count = selectReward:getItemCount()
    elseif __eRewardIntimacy == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._character = selectReward:getIntimacyCharacter()
      self._selectReward[selectIdx]._value = selectReward:getIntimacyValue()
    elseif __eRewardKnowledge == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._mentalCard = selectReward:getMentalCardKey()
    elseif __eRewardSeasonReward == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._season = selectReward:getSeasonNo()
    elseif __eRewardExploreExp == self._selectReward[selectIdx]._type then
      self._selectReward[selectIdx]._exploreExp = Int64toInt32(selectReward:getExploreExperience())
    end
  end
  for index = 0, self._MAX_SELECT_REWARD - 1 do
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_On", "")
    self._listSelectRewardSlots[index].icon:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_On", "")
    self._ui._selectRewardSlotBg[index]:addInputEvent("Mouse_Out", "")
    self._ui._selectRewardSlotBg[index]:registerPadEvent(__eConsoleUIPadEvent_X, "")
    self._uiBackSelectReward[index]:SetShow(false)
    if index < #self._selectReward then
      self:setReward(self._listSelectRewardSlots[index], self._selectReward[index + 1], index, "sub")
      self._uiBackSelectReward[index]:SetShow(true)
    end
  end
end
function PaGlobal_RandomQuestInfo_All:setReward(uiSlot, reward, index, questType)
  uiSlot._type = reward._type
  uiSlot:clearItem()
  uiSlot.count:SetText("")
  uiSlot.icon:SetAlpha(1)
  uiSlot.icon:ChangeTextureInfoName("")
  local rewardTypeStr = self._rewardTypeStr[reward._type]
  if nil == rewardTypeStr then
    return
  end
  local questTypeSlotBg
  if true == self._isConsole then
    if "main" == questType then
      questTypeSlotBg = self._ui._baseRewardSlotBg[index]
    else
      questTypeSlotBg = self._ui._selectRewardSlotBg[index]
    end
  end
  if nil ~= self._rewardTexturePathList[reward._type] then
    uiSlot.count:SetText("")
    uiSlot.icon:ChangeTextureInfoName(self._rewardTexturePathList[reward._type])
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. " )")
    end
  end
  if __eRewardItem == reward._type then
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(reward._item))
    if nil == itemStatic then
      return
    end
    uiSlot:setItemByStaticStatus(itemStatic, reward._count)
    uiSlot._item = reward._item
    if true == self._isConsole then
      if true == _ContentsGroup_RenewUI_Tooltip then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEventX_QuestInfo_All_RewardItemTooltip(" .. index .. ", \"" .. questType .. "\")")
      elseif "main" == questType then
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
      else
        questTypeSlotBg:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
        questTypeSlotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
      end
    elseif "main" == questType then
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Base\",false)")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",true)")
      uiSlot.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralStatic(" .. index .. ",\"QuestReward_Select\",false)")
    end
  elseif __eRewardIntimacy == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", true, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Intimacy\", false, \"" .. questType .. "\", " .. index .. " , " .. reward._character .. ", " .. reward._value .. ")")
    end
  elseif __eRewardKnowledge == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", true, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"Knowledge\", false, \"" .. questType .. "\", " .. index .. "," .. reward._mentalCard .. " )")
    end
  elseif __eRewardSeasonReward == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", true, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"SeasonReward\", false, \"" .. questType .. "\", " .. index .. "," .. reward._season .. ")")
    end
  elseif __eRewardExploreExp == reward._type then
    if true == self._isConsole then
      questTypeSlotBg:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", true, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
      questTypeSlotBg:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"" .. rewardTypeStr .. "\", false, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
    else
      uiSlot.icon:addInputEvent("Mouse_On", "rewardTooltip_ForQuestWidgetInfo( \"ExploreExp\", true, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
      uiSlot.icon:addInputEvent("Mouse_Out", "rewardTooltip_ForQuestWidgetInfo( \"ExploreExp\", false, \"" .. questType .. "\", " .. index .. "," .. reward._exploreExp .. ")")
    end
  end
end
function PaGlobal_RandomQuestInfo_All:setPanelPos(posX, posY, sizeX, sizeY)
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  if nil == posX or nil == posY or nil == sizeX or nil == sizeY then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  if posX > screenSizeX / 2 then
    posX = posX - Panel_Widget_RandomQuestInfo_All:GetSizeX()
  else
    posX = posX + sizeX
  end
  if posY > screenSizeY / 2 then
    posY = posY - Panel_Widget_RandomQuestInfo_All:GetSizeY()
  end
  Panel_Widget_RandomQuestInfo_All:SetPosXY(posX, posY)
end
function PaGlobal_RandomQuestInfo_All:validate()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
  self._ui._txt_questTitle:isValidate()
  self._ui._txt_questDesc:isValidate()
  self._ui._stc_rewardGroupBg:isValidate()
  self._ui._stc_baseRewardBg:isValidate()
  self._ui._stc_baseMenuReward:isValidate()
  self._ui._stc_selectRewardBg:isValidate()
  self._ui._stc_selectMenuReward:isValidate()
end
function PaGlobal_RandomQuestInfo_All:resize()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return
  end
end
