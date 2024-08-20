function PaGlobal_Worldmap_TentInfo_All:initialize()
  if true == PaGlobal_Worldmap_TentInfo_All._initialize then
    return
  end
  self._maxHarvestCount = ToClient_GetMaxHarvestCount()
  local stc_InfoArea = UI.getChildControl(Panel_Worldmap_TentInfo_All, "Static_InfoArea")
  local stc_RemainArea = UI.getChildControl(stc_InfoArea, "Static_RemainArea")
  self._ui.txt_RemainTime = UI.getChildControl(stc_RemainArea, "StaticText_ReaminTime")
  local stc_SeedArea = UI.getChildControl(stc_InfoArea, "Static_SeedArea")
  local stc_SeedBg = UI.getChildControl(stc_SeedArea, "Static_SeedBG")
  local stc_ProgressBG = UI.getChildControl(stc_SeedBg, "Static_ProgressBG")
  for index = 0, self._maxHarvestCount - 1 do
    self.slot[index] = {}
    local slot = self.slot[index]
    slot.bg = UI.createAndCopyBasePropertyControl(stc_SeedArea, "Static_SeedBG", stc_SeedArea, "HarvestSlotBG_" .. index)
    slot.seedName = UI.createAndCopyBasePropertyControl(stc_SeedBg, "StaticText_SeedName", slot.bg, "HarvestSlotSeedName_" .. index)
    slot.progressBG = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_ProgressBG", slot.bg, "HarvestSlot_ProgressBG_" .. index)
    slot.progress_Growing = UI.createAndCopyBasePropertyControl(stc_ProgressBG, "Progress2_Growing", slot.progressBG, "HarvestSlot_Progress2_Growing_" .. index)
    slot.percent = UI.createAndCopyBasePropertyControl(stc_SeedBg, "StaticText_Growing_Percent", slot.bg, "HarvestSlot_Percent_" .. index)
    slot.pruning_Off = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Pruning_Off", slot.bg, "HarvestSlot_Pruning_Off_" .. index)
    slot.bugDamage_Off = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_BugDamage_Off", slot.bg, "HarvestSlot_BugDamage_Off_" .. index)
    slot.feed_Off = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Feed_Off", slot.bg, "HarvestSlot_Feed_Off_" .. index)
    slot.pest_Off = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Pest_Off", slot.bg, "HarvestSlot_Pest_Off_" .. index)
    slot.pruning_On = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Pruning_On", slot.bg, "HarvestSlot_Pruning_On_" .. index)
    slot.bugDamage_On = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_BugDamage_On", slot.bg, "HarvestSlot_BugDamage_On_" .. index)
    slot.feed_On = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Feed_On", slot.bg, "HarvestSlot_Feed_On_" .. index)
    slot.pest_On = UI.createAndCopyBasePropertyControl(stc_SeedBg, "Static_Pest_On", slot.bg, "HarvestSlot_Pest_On_" .. index)
    local slotPosY = (slot.bg:GetSizeY() + self.config.cellSpan) * index + self.config.startPosY
    slot.bg:SetPosY(slotPosY)
  end
  self.config.slotSizeY = stc_SeedBg:GetSizeY() + self.config.cellSpan
  self.config.panelSizeY = Panel_Worldmap_TentInfo_All:GetSizeY() - 30
  PaGlobal_Worldmap_TentInfo_All:registEventHandler()
  PaGlobal_Worldmap_TentInfo_All:validate()
  PaGlobal_Worldmap_TentInfo_All._initialize = true
end
function PaGlobal_Worldmap_TentInfo_All:registEventHandler()
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  registerEvent("FromClient_TentTooltipShow", "FromClient_TentTooltipShow")
  registerEvent("FromClient_TentTooltipHide", "FromClient_TentTooltipHide")
  Panel_Worldmap_TentInfo_All:RegisterUpdateFunc("PaGlobal_Worldmap_TentInfo_All_UpdateFrame")
end
function PaGlobal_Worldmap_TentInfo_All:prepareOpen(householdDataWithInstallationWrapper)
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  self:update(householdDataWithInstallationWrapper)
  Panel_Worldmap_TentInfo_All:SetPosX(Panel_HarvestList_All:GetPosX() + Panel_HarvestList_All:GetSizeX())
  Panel_Worldmap_TentInfo_All:SetPosY(Panel_HarvestList_All:GetPosY())
  PaGlobal_Worldmap_TentInfo_All:open()
end
function PaGlobal_Worldmap_TentInfo_All:open()
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  Panel_Worldmap_TentInfo_All:SetShow(true)
end
function PaGlobal_Worldmap_TentInfo_All:prepareClose()
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  self._selectTentActorKey = 0
  self._selectTentID = 0
  PaGlobal_Worldmap_TentInfo_All:close()
end
function PaGlobal_Worldmap_TentInfo_All:close()
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  Panel_Worldmap_TentInfo_All:SetShow(false)
end
function PaGlobal_Worldmap_TentInfo_All:validate()
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  self._ui.txt_RemainTime:isValidate()
end
function PaGlobal_Worldmap_TentInfo_All:update(householdDataWithInstallationWrapper)
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  if nil == householdDataWithInstallationWrapper then
    return
  end
  local expireTime = householdDataWithInstallationWrapper:getSelfTentExpiredTime_s64()
  local lefttimeText = convertStringFromDatetime(getLeftSecond_TTime64(expireTime))
  self._ui.txt_RemainTime:SetText(lefttimeText)
  local count = householdDataWithInstallationWrapper:getSelfHarvestCount()
  self._selectTentActorKey = householdDataWithInstallationWrapper:getActorKeyRaw()
  for index = 0, self._maxHarvestCount - 1 do
    self.slot[index].bg:SetShow(false)
  end
  local showCount = 0
  for index = 0, count - 1 do
    local slot = self.slot[showCount]
    local progressingInfo = householdDataWithInstallationWrapper:getInstallationProgressingInfo(index)
    if nil ~= progressingInfo then
      local harvestCharacterSSW = householdDataWithInstallationWrapper:getSelfHarvest(index)
      if nil == harvestCharacterSSW then
        return
      end
      local percent = math.min(householdDataWithInstallationWrapper:getSelfHarvestCompleteRate(index) * 100, 200)
      local objectSSW = harvestCharacterSSW:getObjectStaticStatus()
      if nil == objectSSW then
        return
      end
      local installationType = objectSSW:getInstallationType()
      slot.seedName:SetText(harvestCharacterSSW:getName())
      UI.setLimitTextAndAddTooltip(slot.seedName, "", harvestCharacterSSW:getName())
      slot.progress_Growing:SetCurrentProgressRate(percent)
      slot.progress_Growing:SetProgressRate(percent)
      slot.percent:SetText(math.floor(percent) .. "%")
      slot.pruning_Off:SetShow(false)
      slot.bugDamage_Off:SetShow(false)
      slot.feed_Off:SetShow(false)
      slot.pest_Off:SetShow(false)
      slot.pruning_On:SetShow(false)
      slot.bugDamage_On:SetShow(false)
      slot.feed_On:SetShow(false)
      slot.pest_On:SetShow(false)
      if installationType == CppEnums.InstallationType.eType_Havest then
        if true == progressingInfo:getNeedLop() then
          slot.pruning_On:SetShow(true)
        else
          slot.pruning_Off:SetShow(true)
        end
        if true == progressingInfo:getNeedPestControl() then
          slot.bugDamage_On:SetShow(true)
        else
          slot.bugDamage_Off:SetShow(true)
        end
      elseif installationType == CppEnums.InstallationType.eType_LivestockHarvest then
        if true == progressingInfo:getNeedLop() then
          slot.feed_On:SetShow(true)
        else
          slot.feed_Off:SetShow(true)
        end
        if true == progressingInfo:getNeedPestControl() then
          slot.pest_On:SetShow(true)
        else
          slot.pest_Off:SetShow(true)
        end
      end
      self.slot[showCount].bg:SetShow(true)
      showCount = showCount + 1
    end
  end
  Panel_Worldmap_TentInfo_All:SetSize(Panel_Worldmap_TentInfo_All:GetSizeX(), self.config.panelSizeY + showCount * self.config.slotSizeY)
end
function PaGlobal_Worldmap_TentInfo_All:updateFrame(deltaTime)
  if nil == Panel_Worldmap_TentInfo_All then
    return
  end
  if false == Panel_Worldmap_TentInfo_All:IsShow() then
    return
  end
  local householdDataWithInstallationWrapper = getTemporaryInformationWrapper():getSelfTentWrapperByActorKeyRaw(self._selectTentActorKey)
  if nil == householdDataWithInstallationWrapper then
    return
  end
  self:update(householdDataWithInstallationWrapper)
end
