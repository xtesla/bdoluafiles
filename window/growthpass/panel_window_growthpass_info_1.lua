function PaGlobal_GrowthPass_Info:initialize()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  PaGlobal_GrowthPass_Info:initializeControl()
  PaGlobal_GrowthPass_Info:registEventHandler()
  PaGlobal_GrowthPass_Info:validate()
  PaGlobal_GrowthPass_Info._initialize = true
end
function PaGlobal_GrowthPass_Info:registEventHandler()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowPath_Info_Close()")
end
function PaGlobal_GrowthPass_Info:initializeControl()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  local questIconBg = UI.getChildControl(self._ui._stc_mainBg, "Static_QuestIconBG")
  self._ui._stc_questDescBg = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestDesc_BG")
  self._ui._stc_rewardGroup = UI.getChildControl(self._ui._stc_mainBg, "Static_RewardGroup")
  self._ui._stc_rewardBg = UI.getChildControl(self._ui._stc_rewardGroup, "Static_BaseRewardBG")
  self._ui._stc_questTitle = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestTitle")
  self._ui._stc_questIconTexture = UI.getChildControl(questIconBg, "Static_QuestIcon")
  self._ui._stc_questConditionText = UI.getChildControl(self._ui._stc_mainBg, "StaticText_QuestCondition")
  self._ui._stc_questDescText = UI.getChildControl(self._ui._stc_questDescBg, "StaticText_DescBox")
  self._ui._questItemSlot = UI.getChildControl(self._ui._stc_rewardBg, "Static_Reward_Slot_0")
  self._ui._questItemNameText = UI.getChildControl(self._ui._stc_rewardBg, "StaticText_Name")
  self._ui._btn_reward = UI.getChildControl(self._ui._stc_mainBg, "Button_Reward")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_mainBg, "Button_Close")
  self._ui._questItemSlot:SetShow(false)
  local tempSlot = {}
  SlotItem.new(tempSlot, "GrowthPass_RewardItem_", 1, self._ui._stc_rewardBg, self._slotConfig)
  tempSlot:createChild()
  tempSlot.icon:SetSize(42, 42)
  tempSlot.icon:SetPosX(self._ui._questItemSlot:GetPosX())
  tempSlot.icon:SetPosY(self._ui._questItemSlot:GetPosY())
  tempSlot.icon:ComputePos()
  self._ui._itemSlot = tempSlot
  local rewardTitle = UI.getChildControl(self._ui._stc_rewardGroup, "Static_Menu_Reward")
  self._ui._rewardTitle_spanY = rewardTitle:GetSpanSize().y
end
function PaGlobal_GrowthPass_Info:prepareOpen(questInfoWrapper, questInfoControl, isForceShow)
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  if nil == questInfoWrapper or nil == questInfoControl then
    return
  end
  if false == isForceShow and self._cachedTargetControl == questInfoControl then
    PaGlobalFunc_GrowPath_Info_Close()
    return
  else
    self._cachedTargetControl = questInfoControl
  end
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
  local questBaseReward = questInfoWrapper:getQuestBaseRewardAt(0)
  if nil == questBaseReward then
    return
  end
  local rewardItemKey = ItemEnchantKey(questBaseReward:getItemEnchantKey())
  local rewardItemSSW = getItemEnchantStaticStatus(rewardItemKey)
  if nil == rewardItemSSW then
    return
  end
  local nextSpanY = self._ui._stc_questTitle:GetSpanSize().y
  local gabY = 5
  local panel = Panel_Window_GrowthPass_Info
  self._ui._stc_questTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questTitle:SetText(questWrapper:getTitle())
  self._ui._stc_questIconTexture:ChangeTextureInfoName(questWrapper:getGrowthPassIconPath())
  self._ui._stc_questIconTexture:setRenderTexture(self._ui._stc_questIconTexture:getBaseTexture())
  self._ui._stc_questConditionText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questConditionText:SetText(ToClient_getReplaceDialog(demandString))
  self._ui._stc_questDescText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_questDescText:SetText(ToClient_getReplaceDialog(questWrapper:getDesc()))
  self._ui._itemSlot:clearItem()
  self._ui._itemSlot:setItemByStaticStatus(rewardItemSSW, questBaseReward:getItemCount())
  self._ui._itemSlot.icon:removeInputEvent("Mouse_LUp")
  self._ui._itemSlot.icon:removeInputEvent("Mouse_On")
  self._ui._itemSlot.icon:removeInputEvent("Mouse_Out")
  self._ui._itemSlot.icon:addInputEvent("Mouse_On", "PaGlobal_GrowthPass_Info_ShowItemTooptip(" .. tostring(rewardItemKey:get()) .. ", true)")
  self._ui._itemSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_GrowthPass_Info_ShowItemTooptip(" .. tostring(rewardItemKey:get()) .. ", false)")
  self._ui._questItemNameText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._questItemNameText:SetText(rewardItemSSW:getName() .. " x" .. tostring(questBaseReward:getItemCount()))
  local questState = ToClient_getGrowthPassQuestState(questNo._group, questNo._quest)
  self._ui._btn_reward:SetShow(questState == __eGrowthPass_QuestState_Complete)
  self._ui._btn_reward:addInputEvent("Mouse_LUp", "PaGlobalFunc_GrowthPass_Info_OnClickedQuestionRewardIcon(" .. tostring(questNo._group) .. "," .. tostring(questNo._quest) .. ")")
  nextSpanY = nextSpanY + self._ui._stc_questTitle:GetTextSizeY() + gabY
  self._ui._stc_questConditionText:SetSpanSize(self._ui._stc_questConditionText:GetSpanSize().x, nextSpanY)
  nextSpanY = nextSpanY + self._ui._stc_questConditionText:GetTextSizeY()
  self._ui._stc_questDescBg:SetSize(self._ui._stc_questDescBg:GetSizeX(), self._ui._stc_questDescText:GetTextSizeY() + 20)
  self._ui._stc_questDescBg:SetSpanSize(self._ui._stc_questDescBg:GetSpanSize().x, nextSpanY)
  nextSpanY = nextSpanY + self._ui._stc_questDescBg:GetSizeY() + self._ui._rewardTitle_spanY + self._ui._stc_rewardGroup:GetSizeY()
  self._ui._stc_rewardGroup:SetSpanSize(self._ui._stc_rewardGroup:GetSpanSize().x, nextSpanY)
  local addBtnSizeY = 0
  nextSpanY = nextSpanY + self._ui._stc_rewardGroup:GetSizeY() + gabY
  if true == self._ui._btn_reward:GetShow() then
    addBtnSizeY = self._ui._btn_reward:GetSizeY()
    self._ui._btn_reward:SetSpanSize(self._ui._btn_reward:GetSpanSize().x, nextSpanY)
    self._ui._btn_reward:SetMonoTone(false)
  end
  local changePanelSizeY = nextSpanY + addBtnSizeY + 10
  panel:SetSize(panel:GetSizeX(), changePanelSizeY)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local frameContent = self._cachedTargetControl:getParent()
  local frameContentSizeY = frameContent:GetSizeY()
  local frame = frameContent:getParent()
  local frameSizeY = frame:GetSizeY()
  local posX = self._cachedTargetControl:GetParentPosX()
  local posY = self._cachedTargetControl:GetParentPosY()
  local isRight = posX > screenSizeX / 2
  local isBottom = posY > screenSizeY / 2
  if true == isRight then
    posX = posX - panelSizeX - self._panelPos_gapX
  else
    posX = posX + self._cachedTargetControl:GetSizeX() + self._panelPos_gapX
  end
  if true == isBottom then
    posY = posY - (panelSizeY - self._cachedTargetControl:GetSizeY())
  else
  end
  panel:SetPosX(posX)
  panel:SetPosY(posY)
  PaGlobal_GrowthPass_Info:open()
end
function PaGlobal_GrowthPass_Info:open()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Window_GrowthPass_Info:SetShow(true)
end
function PaGlobal_GrowthPass_Info:prepareClose()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  self._cachedTargetControl = nil
  PaGlobal_GrowthPass_Info:close()
end
function PaGlobal_GrowthPass_Info:close()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  Panel_Window_GrowthPass_Info:SetShow(false)
end
function PaGlobal_GrowthPass_Info:validate()
  if nil == Panel_Window_GrowthPass_Info then
    return
  end
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_questTitle:isValidate()
  self._ui._stc_questIconTexture:isValidate()
  self._ui._stc_questConditionText:isValidate()
  self._ui._stc_questDescText:isValidate()
  self._ui._questItemSlot:isValidate()
  self._ui._questItemNameText:isValidate()
end
