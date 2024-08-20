function PaGlobal_BlackspiritPass:initialize()
  if true == self._initialize then
    return
  end
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:registEventHandler()
  self:validate()
  self:setSeasonDate()
  self:updateTotalQuestInfo()
  self:updateQuestListControl()
  self:updateSeasonPassLockState()
  self._initialize = true
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function PaGlobal_BlackspiritPass:controlAll_Init()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  self._ui._stc_banner = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_BannerArea")
  self._ui._txt_date = UI.getChildControl(self._ui._stc_banner, "StaticText_Date")
  self._ui._stc_directBuy = UI.getChildControl(self._ui._stc_banner, "Static_ClickGuide")
  local topIconArea = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_TopIconArea")
  self._ui._seasonIcon[1] = UI.getChildControl(topIconArea, "StaticText_Icon_Growth")
  self._ui._seasonIcon[2] = UI.getChildControl(topIconArea, "StaticText_Icon_Equip")
  self._ui._seasonIcon[3] = UI.getChildControl(topIconArea, "StaticText_Icon_ETC")
  self._ui._list_quest = UI.getChildControl(Panel_Window_BlackspiritPass, "List2_Quest")
  self._ui._stc_lockBG = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_LockBG")
  self._ui._stc_lockIcon = UI.getChildControl(self._ui._stc_lockBG, "Static_TopLock")
  self._ui._stc_lockEffect = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_LockEffect")
  self._ui._stc_bottomDescBg = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_BottomDesc")
  self._ui._txt_bottomDesc = UI.getChildControl(self._ui._stc_bottomDescBg, "StaticText_Desc")
  self._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_bottomDesc:SetText(self._ui._txt_bottomDesc:GetText())
  local listContent = self._ui._list_quest:GetContent()
  local normalSlotBG = UI.getChildControl(listContent, "Static_NormalSlotBG")
  local slotBG = UI.getChildControl(normalSlotBG, "Static_Slot")
  local slot = {}
  SlotItem.new(slot, "NormalSlot", nil, slotBG, self._rewardSlotConfig)
  slot:createChild()
  slot:clearItem()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
  local normalSlotBG = UI.getChildControl(listContent, "Static_PremiumSlotBG")
  local slotBG = UI.getChildControl(normalSlotBG, "Static_Slot")
  local slot = {}
  SlotItem.new(slot, "PremiumSlot", nil, slotBG, self._rewardSlotConfig)
  slot:createChild()
  slot:clearItem()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
end
function PaGlobal_BlackspiritPass:controlPc_Init()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local stc_titleArea = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_TitleArea")
  self._ui_pc._btn_close = UI.getChildControl(stc_titleArea, "Button_Close")
end
function PaGlobal_BlackspiritPass:controlConsole_Init()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_BlackspiritPass, "Static_KeyGuide_ConsoleUI")
  self._ui._stc_keyGuideLTX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LTX_ConsoleUI")
  self._ui._stc_keyGuideX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui._stc_keyGuideA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
end
function PaGlobal_BlackspiritPass:controlSetShow()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if false == self._isConsole then
    self._ui_pc._btn_close:SetShow(true)
    self._ui._stc_keyGuideBG:SetShow(false)
  else
    self._ui_pc._btn_close:SetShow(false)
    self._ui._stc_directBuy:SetShow(false)
    self._ui._stc_keyGuideBG:SetShow(true)
    if true == _ContentsGroup_RenewUI then
      self._ui._stc_keyGuideX:SetShow(true)
      self._seasonIconString[2]._desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_DESC_EQUIP_CONSOLE")
    else
      self._ui._stc_keyGuideX:SetShow(false)
    end
    self:setAlignKeyGuide()
  end
end
function PaGlobal_BlackspiritPass:setAlignKeyGuide()
  local keyGuides = {
    self._ui._stc_keyGuideLTX,
    self._ui._stc_keyGuideX,
    self._ui._stc_keyGuideA,
    self._ui._stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_BlackspiritPass:registEventHandler()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  registerEvent("onScreenResize", "FromClient_BlackspiritPass_ResizePanel")
  registerEvent("FromClient_notifyUpdateSeasonPassQuest", "FromClient_BlackspiritPass_UpdateSeasonPassQuest")
  registerEvent("FromClient_SeasonPassUpdate", "FromClient_BlackspiritPass_NotifyGetSeasonPass")
  registerEvent("EventQuestUpdateNotify", "FromClient_BlackspiritPass_EventQuestUpdateNotify")
  if false == self._isConsole then
    self._ui._stc_banner:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
    self._ui._stc_lockIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
    self._ui_pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_BlackspiritPass_Close()")
  else
    Panel_Window_BlackspiritPass:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
  end
  for index = 1, #self._ui._seasonIcon do
    if false == self._isConsole then
      self._ui._seasonIcon[index]:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowSeasonIconTooltip( true, " .. tostring(index) .. " )")
      self._ui._seasonIcon[index]:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowSeasonIconTooltip( false )")
    else
      self._ui._seasonIcon[index]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventOnOut_BlackspiritPass_ShowSeasonIconTooltip(true, " .. tostring(index) .. ")")
    end
  end
  self._ui._list_quest:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_BlackspiritPass_UpdateListContent")
  self._ui._list_quest:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_BlackspiritPass:prepareOpen()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  ToClient_autoAcceptSeasonPass()
  if true == self._hasSeasonPass then
    self._ui._stc_lockBG:SetShow(false)
    self._ui._stc_directBuy:SetShow(false)
    self._ui._stc_banner:addInputEvent("Mouse_LUp", "")
    if true == self._isConsole then
      self._ui._stc_keyGuideLTX:SetShow(false)
      Panel_Window_BlackspiritPass:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    end
  end
  self:updateTotalQuestInfo()
  self:updateQuestListControl()
  local count = self:getClearQuestCount()
  if count >= 3 then
    self._ui._list_quest:moveIndex(count - 2)
  end
  if true == self._isConsole then
    self:setAlignKeyGuide()
  end
  PaGlobal_BlackspiritPass:open()
end
function PaGlobal_BlackspiritPass:open()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  Panel_Window_BlackspiritPass:SetShow(true)
end
function PaGlobal_BlackspiritPass:prepareClose()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  TooltipBlackSpiritPass_Hide()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
    PaGlobalFunc_Widget_FunctionButton_ShowBlackspiritReopenGuideEffect()
  end
  PaGlobal_BlackspiritPass:close()
end
function PaGlobal_BlackspiritPass:close()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  Panel_Window_BlackspiritPass:SetShow(false)
end
function PaGlobal_BlackspiritPass:validate()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  self._ui._stc_banner:isValidate()
  self._ui._stc_directBuy:isValidate()
  self._ui._txt_date:isValidate()
  self._ui._list_quest:isValidate()
  self._ui._stc_lockBG:isValidate()
  self._ui._stc_lockIcon:isValidate()
  self._ui._stc_lockEffect:isValidate()
  self._ui_pc._btn_close:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._stc_keyGuideLTX:isValidate()
  self._ui._stc_keyGuideX:isValidate()
  self._ui._stc_keyGuideA:isValidate()
  self._ui._stc_keyGuideB:isValidate()
end
function PaGlobal_BlackspiritPass:setSeasonDate()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local startTime = PATime(ToClient_getStartSeasonTime())
  local endTime = PATime(ToClient_getEndSeasonTime())
  local start_monthStr = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. startTime:GetMonth())
  local end_monthStr = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. endTime:GetMonth())
  local strConnect = "-"
  if true == isGameTypeKorea() then
    strConnect = "~"
  end
  local startDate = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", startTime:GetYear(), "GetMonth", start_monthStr, "GetDay", startTime:GetDay())
  local endDate = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", endTime:GetYear(), "GetMonth", end_monthStr, "GetDay", endTime:GetDay())
  self._ui._txt_date:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_date:SetText(startDate .. strConnect .. endDate)
  if true == self._ui._txt_date:IsAutoWrapText() then
    self._ui._stc_directBuy:SetSpanSize(self._ui._stc_directBuy:GetSpanSize().x, 10)
    self._ui._stc_directBuy:ComputePos()
  end
end
function PaGlobal_BlackspiritPass:updateTotalQuestInfo()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    self:updateQuestInfo(index)
  end
end
function PaGlobal_BlackspiritPass:updateQuestInfo(listIdx)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questInfo = {
    title = nil,
    desc = nil,
    normalQuestNo = nil,
    normalReward = nil,
    normalQuestState = nil,
    premiumQuestNo = nil,
    premiumReward = nil,
    premiumQuestState = nil
  }
  local questWrapper = ToClient_GetSeasonPassQuestAt(listIdx, __eSeasonPassQuest_Normal)
  if nil ~= questWrapper then
    local questNo = questWrapper:getQuestNo()
    questInfo.title = questWrapper:getTitle()
    questInfo.desc = self:getQuestDesc(questNo)
    if true == ToClient_CanShowChangedSeasonPass(listIdx) then
      local changedTitle = ToClient_GetSeasonPassChangedTitle(listIdx)
      local changedDesc = ToClient_GetSeasonPassChangedDesc(listIdx)
      if nil ~= changedTitle and nil ~= changedDesc then
        questInfo.title = changedTitle
        questInfo.desc = changedDesc
      end
    end
    questInfo.normalQuestNo = questNo
    questInfo.normalReward = self:getQuestReward(questNo)
    if false == self:isRepeatQuestion(questNo) then
      questInfo.normalQuestState = self:getQuestState(questNo)
    else
      questInfo.normalQuestState = self:getRepeatQuestState(questNo)
    end
  end
  local premiumQuestWrapper = ToClient_GetSeasonPassQuestAt(listIdx, __eSeasonPassQuest_SeasonPass)
  if nil ~= premiumQuestWrapper then
    local questNo = premiumQuestWrapper:getQuestNo()
    questInfo.premiumQuestNo = questNo
    questInfo.premiumReward = self:getQuestReward(questNo)
    if false == self:isRepeatQuestion(questNo) then
      questInfo.premiumQuestState = self:getQuestState(questNo)
    else
      questInfo.premiumQuestState = self:getRepeatQuestState(questNo)
    end
  end
  self._questInfo[listIdx] = questInfo
end
function PaGlobal_BlackspiritPass:getQuestDesc(questNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questStaticInfo = questList_getQuestStatic(groupIdx, questIdx)
  if nil ~= questStaticInfo then
    return questStaticInfo:getDemandAt(0)._desc
  end
  return ""
end
function PaGlobal_BlackspiritPass:getQuestReward(questNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questWrapper = ToClient_getQuestWrapper(questNo)
  if nil ~= questWrapper then
    local baseRewardWrapper = questWrapper:getQuestBaseRewardAt(0)
    if nil ~= baseRewardWrapper then
      local baseReward = baseRewardWrapper:get()
      return baseReward
    end
  end
  return nil
end
function PaGlobal_BlackspiritPass:isRepeatQuestion(questNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local repeatTime = ToClient_ClearedQuestRepeatTime(questNo._group, questNo._quest)
  return repeatTime > 0
end
function PaGlobal_BlackspiritPass:getQuestState(questNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questInfo
  local questStaisfied = false
  local questCleared = questList_isClearQuest(groupIdx, questIdx)
  local isProgressingQuest = ToClient_isProgressingQuest(groupIdx, questIdx)
  if true == isProgressingQuest then
    questInfo = ToClient_GetQuestInfo(groupIdx, questIdx)
    if nil ~= questInfo then
      questSatisfied = questInfo:isSatisfied()
    end
  else
    questInfo = questList_getQuestStatic(groupIdx, questIdx)
  end
  if nil == questInfo then
    return self._state.none
  end
  if true == questCleared then
    return self._state.clickedReward
  elseif true == questSatisfied then
    return self._state.clear
  else
    return self._state.progressing
  end
end
function PaGlobal_BlackspiritPass:getRepeatQuestState(questNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questInfo = ToClient_GetQuestInfo(groupIdx, questIdx)
  local questCleared = questList_isClearQuest(groupIdx, questIdx)
  if nil == questInfo then
    if questCleared then
      return self._state.clickedReward
    end
    return self._state.progressing
  elseif true == questCleared then
    return self._state.clickedReward
  elseif true == questInfo:isSatisfied() then
    return self._state.clear
  else
    return self._state.progressing
  end
end
function PaGlobal_BlackspiritPass:updateQuestListControl()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  self._ui._list_quest:getElementManager():clearKey()
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    self._ui._list_quest:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_BlackspiritPass:updateListContent(content, key)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local index = Int64toInt32(key)
  if nil == content then
    return
  end
  local questBG = UI.getChildControl(content, "Static_QuestBG")
  local txt_title = UI.getChildControl(questBG, "StaticText_Title")
  local txt_desc = UI.getChildControl(questBG, "StaticText_Desc")
  local stc_missionStamp = UI.getChildControl(content, "Static_CompleteStamp")
  local normalSlotBG = UI.getChildControl(content, "Static_NormalSlotBG")
  local normalSlotIcon = UI.getChildControl(normalSlotBG, "Static_Slot")
  local normalSlotGet = UI.getChildControl(normalSlotBG, "Static_Get")
  local normalSlot = {}
  SlotItem.reInclude(normalSlot, "NormalSlot", 0, normalSlotIcon, self._rewardSlotConfig)
  normalSlot.icon:SetIgnore(true)
  local premiumSlotBG = UI.getChildControl(content, "Static_PremiumSlotBG")
  local premiumSlotIcon = UI.getChildControl(premiumSlotBG, "Static_Slot")
  local premiumSlotGet = UI.getChildControl(premiumSlotBG, "Static_Get")
  local premiumSlot = {}
  SlotItem.reInclude(premiumSlot, "PremiumSlot", 0, premiumSlotIcon, self._rewardSlotConfig)
  premiumSlot.icon:SetIgnore(true)
  normalSlotIcon:EraseAllEffect()
  premiumSlotIcon:EraseAllEffect()
  local questInfo = self._questInfo[index]
  if nil ~= questInfo then
    txt_title:SetTextMode(__eTextMode_AutoWrap)
    txt_title:SetText(questInfo.title)
    txt_desc:SetTextMode(__eTextMode_AutoWrap)
    txt_desc:SetText(questInfo.desc)
    local normalReward = questInfo.normalReward
    local itemKey = normalReward:getItemEnchantKey()
    local itemCount = normalReward._itemCount
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil ~= itemSSW then
      normalSlot:clearItem()
      normalSlot:setItemByStaticStatus(itemSSW, itemCount)
      if false == _ContentsGroup_RenewUI then
        normalSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. itemKey .. " )")
        normalSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
      else
        normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. itemKey .. " )")
      end
    end
    local premiumReward = questInfo.premiumReward
    local itemKey = premiumReward:getItemEnchantKey()
    local itemCount = premiumReward._itemCount
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil ~= itemSSW then
      premiumSlot:clearItem()
      premiumSlot:setItemByStaticStatus(itemSSW, itemCount)
      if false == _ContentsGroup_RenewUI then
        premiumSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", true, " .. itemKey .. " )")
        premiumSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
      else
        premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", true, " .. itemKey .. " )")
      end
    end
  end
  if self._state.clear <= questInfo.normalQuestState then
    questBG:SetMonoTone(true)
    stc_missionStamp:SetShow(true)
    if self._state.clickedReward == questInfo.normalQuestState then
      normalSlotIcon:SetMonoTone(true)
      normalSlotGet:SetShow(true)
      normalSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
    elseif self._state.clear == questInfo.normalQuestState then
      normalSlotIcon:SetMonoTone(false)
      normalSlotGet:SetShow(false)
      normalSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. index .. ", false )")
      normalSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    else
      normalSlotIcon:SetMonoTone(true)
      normalSlotGet:SetShow(false)
      normalSlotIcon:addInputEvent("Mouse_LUp", "")
    end
    if true == self._hasSeasonPass and self._state.clickedReward == questInfo.normalQuestState then
      if self._state.clickedReward == questInfo.premiumQuestState then
        premiumSlotIcon:SetMonoTone(true)
        premiumSlotGet:SetShow(true)
        premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
      elseif self._state.clear == questInfo.premiumQuestState then
        premiumSlotIcon:SetMonoTone(false)
        premiumSlotGet:SetShow(false)
        premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. index .. ", true )")
        premiumSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
      else
        premiumSlotIcon:SetMonoTone(true)
        premiumSlotGet:SetShow(false)
        premiumSlotIcon:addInputEvent("Mouse_LUp", "")
      end
    else
      premiumSlotIcon:SetMonoTone(true)
      premiumSlotGet:SetShow(false)
      premiumSlotIcon:addInputEvent("Mouse_LUp", "")
    end
  else
    questBG:SetMonoTone(false)
    stc_missionStamp:SetShow(false)
    normalSlotIcon:SetMonoTone(true)
    normalSlotGet:SetShow(false)
    normalSlotIcon:addInputEvent("Mouse_LUp", "")
    premiumSlotIcon:SetMonoTone(true)
    premiumSlotGet:SetShow(false)
    premiumSlotIcon:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_BlackspiritPass:getListIndex(InQuestNo)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    local normalQuestNo = self._questInfo[index].normalQuestNo
    local premiumQuestNo = self._questInfo[index].premiumQuestNo
    if normalQuestNo._group == InQuestNo._group and normalQuestNo._quest == InQuestNo._quest then
      return index, false
    elseif premiumQuestNo._group == InQuestNo._group and premiumQuestNo._quest == InQuestNo._quest then
      return index, true
    end
  end
  return -1
end
function PaGlobal_BlackspiritPass:updateGetRewardItem(listIdx, isPremium)
  local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
  if nil == content then
    return
  end
  local rewardSlotBG
  if false == isPremium then
    rewardSlotBG = UI.getChildControl(content, "Static_NormalSlotBG")
  else
    rewardSlotBG = UI.getChildControl(content, "Static_PremiumSlotBG")
  end
  local slotIcon = UI.getChildControl(rewardSlotBG, "Static_Slot")
  local slotGet = UI.getChildControl(rewardSlotBG, "Static_Get")
  slotGet:SetShow(true)
  slotGet:SetAlpha(0)
  local ImageAni = slotGet:addColorAnimation(0.2, 0.4, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  slotGet:EraseAllEffect()
  slotGet:AddEffect("fUI_BlackSpirit_Pass_Check_01A", false, 0, -1)
  slotGet:AddEffect("UI_Check_02A", false, 0, -1)
  slotIcon:SetMonoTone(true)
  slotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
  slotIcon:EraseAllEffect()
  if false == isPremium then
    PaGlobal_BlackspiritPass._questInfo[listIdx].normalQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  else
    PaGlobal_BlackspiritPass._questInfo[listIdx].premiumQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
  local questInfo = PaGlobal_BlackspiritPass._questInfo[listIdx]
  if nil ~= questInfo then
    local questNo = questInfo.normalQuestNo
    if PaGlobal_BlackspiritPass:isRepeatQuestion(questNo) and false == isPremium and true == PaGlobal_BlackspiritPass._hasSeasonPass then
      local premiumSlotBG = UI.getChildControl(content, "Static_PremiumSlotBG")
      local premiumSlotIcon = UI.getChildControl(premiumSlotBG, "Static_Slot")
      local premiumSlotGet = UI.getChildControl(premiumSlotBG, "Static_Get")
      premiumSlotIcon:SetMonoTone(false)
      premiumSlotGet:SetShow(false)
      premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. listIdx .. ", true )")
      premiumSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
  end
end
function PaGlobal_BlackspiritPass:updateSeasonPassLockState()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._hasSeasonPass = selfPlayer:get():isSeasonPass()
  end
  if Panel_Window_BlackspiritPass:IsShow() and true == self._ui._stc_lockBG:GetShow() and true == self._hasSeasonPass then
    self:showUnlockAnimation()
  end
end
function PaGlobal_BlackspiritPass:showUnlockAnimation()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  self._ui._stc_lockBG:SetShow(true)
  local ImageAni = self._ui._stc_lockBG:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  ImageAni:SetEndColor(Defines.Color.C_00000000)
  ImageAni.IsChangeChild = true
  ImageAni:SetHideAtEnd(true)
  self._ui._stc_lockEffect:EraseAllEffect()
  self._ui._stc_lockEffect:AddEffect("fUI_BlackSpirit_Pass_Clear_01A", false, 0, 0)
  if false == self._isConsole then
    self._ui._stc_directBuy:SetShow(false)
    self._ui._stc_banner:addInputEvent("Mouse_LUp", "")
  else
    Panel_Window_BlackspiritPass:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    self._ui._stc_keyGuideLTX:SetShow(false)
    self:setAlignKeyGuide()
  end
end
function PaGlobal_BlackspiritPass:getClearQuestCount()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local clearCount = 0
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    local questInfo = self._questInfo[index]
    if self._state.clear <= questInfo.normalQuestState then
      clearCount = clearCount + 1
    end
  end
  return clearCount
end
