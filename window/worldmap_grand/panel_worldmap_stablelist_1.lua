function PaGlobal_WorldMap_StableList:initialize()
  if true == PaGlobal_WorldMap_StableList._initialize then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_WorldMap_StableList, "Static_TitleBg")
  self._ui._stc_title = UI.getChildControl(self._ui._stc_titleBg, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._btn_question = UI.getChildControl(self._ui._stc_titleBg, "Button_Question")
  self._ui._stc_leftBg = UI.getChildControl(Panel_WorldMap_StableList, "Static_LeftBg")
  self._ui._list2_region = UI.getChildControl(self._ui._stc_leftBg, "List2_Region")
  self._ui._stc_notAvaliable = UI.getChildControl(self._ui._stc_leftBg, "StaticText_NotAvaliable")
  self._ui._stc_marketTitle = UI.getChildControl(self._ui._stc_leftBg, "StaticText_ServantMarketTitle")
  self._ui._stc_kingdomTitle = UI.getChildControl(self._ui._stc_leftBg, "StaticText_KingdomMoneyTitle")
  self._ui._stc_marketIcon = UI.getChildControl(self._ui._stc_leftBg, "StaticText_ServantMarketIcon")
  self._ui._stc_kingdomMoneyIcon = UI.getChildControl(self._ui._stc_leftBg, "StaticText_KingdomMoneyIcon")
  self._ui._stc_marketValue = UI.getChildControl(self._ui._stc_marketIcon, "StaticText_ServantMarketValue")
  self._ui._stc_kingdomMoneyValue = UI.getChildControl(self._ui._stc_kingdomMoneyIcon, "StaticText_KingdomMoneyValue")
  self._ui._stc_pageBg = UI.getChildControl(Panel_WorldMap_StableList, "Static_PageBg")
  self._ui._stc_pageValue = UI.getChildControl(self._ui._stc_pageBg, "StaticText_PageValue")
  self._ui._btn_leftPC = UI.getChildControl(self._ui._stc_pageBg, "Button_Left_PCUI")
  self._ui._btn_rightPC = UI.getChildControl(self._ui._stc_pageBg, "Button_Right_PCUI")
  self._ui._stc_noServant = UI.getChildControl(self._ui._stc_pageBg, "StaticText_NoServant")
  self._ui._stc_noServant:SetShow(false)
  self._ui._console._btn_leftConsole = UI.getChildControl(self._ui._stc_pageBg, "Button_Left_ConsoleUI")
  self._ui._console._btn_rightConsole = UI.getChildControl(self._ui._stc_pageBg, "Button_Right_ConsoleUI")
  self._ui._stc_SkillTooltip = UI.getChildControl(Panel_WorldMap_StableList, "Static_SkillTooltip")
  self._ui._console._stc_Bottom_KeyGuides = UI.getChildControl(Panel_WorldMap_StableList, "Static_BottomBg_ConsoleUI")
  self._ui._console._stc_KeyGuide_B = UI.getChildControl(self._ui._console._stc_Bottom_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._console._stc_KeyGuide_RS = UI.getChildControl(self._ui._console._stc_Bottom_KeyGuides, "StaticText_RS_ConsoleUI")
  self._ui._console._stc_KeyGuide_A = UI.getChildControl(self._ui._console._stc_Bottom_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._console._stc_KeyGuide_X = UI.getChildControl(self._ui._console._stc_Bottom_KeyGuides, "StaticText_X_ConsoleUI")
  self._ui._console._stc_KeyGuide_Y = UI.getChildControl(Panel_WorldMap_StableList, "Static_Y_ConsoleUI")
  self._ui._console._stc_KeyGuide_Y_Tooltip = UI.getChildControl(self._ui._console._stc_KeyGuide_Y, "StaticText_YButtonToolTip")
  self._ui._console._stc_KeyGuide_LTX = UI.getChildControl(self._ui._console._stc_Bottom_KeyGuides, "StaticText_LTX_ConsoleUI")
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tempServantSlot = {
      _slot = nil,
      _horseIdx = 0,
      _btn_Console_UI = nil,
      _stc_ImageBg = nil,
      _stc_HorseImage = nil,
      _stc_GenderIcon = nil,
      _stc_SwiftIcon = nil,
      _btn_beforeLook = nil,
      _txt_Tier = nil,
      _txt_Level = nil,
      _txt_HpTitle = nil,
      _txt_HpValue = nil,
      _txt_StaminaTitle = nil,
      _txt_StaminaValue = nil,
      _txt_WeightTitle = nil,
      _txt_WeightValue = nil,
      _txt_SpeedTitle = nil,
      _txt_SpeedValue = nil,
      _txt_AccelTitle = nil,
      _txt_AccelValue = nil,
      _txt_CorneringTitle = nil,
      _txt_CorneringValue = nil,
      _txt_BreakTitle = nil,
      _txt_BreakValue = nil,
      _txt_DeadCountTitle = nil,
      _txt_DeadCountValue = nil,
      _txt_LeftMatingTitle = nil,
      _txt_LeftMatingValue = nil,
      _isLookChange = false,
      _txt_learnedSkillCount = nil,
      _list2_Control = nil,
      _regionKey = nil,
      _servantNo_s64 = nil,
      _btn_Transfer = nil,
      _tooltipControls = {},
      _stc_OnlySpeed = nil,
      _speedValueBasePosX = 0
    }
    tempServantSlot._slot = UI.getChildControl(Panel_WorldMap_StableList, "Static_Slot_" .. tostring(slotIdx + 1))
    tempServantSlot._btn_Console_UI = UI.getChildControl(tempServantSlot._slot, "Button_BG_ConsoleUI")
    tempServantSlot._stc_ImageBg = UI.getChildControl(tempServantSlot._slot, "Static_ImageBg")
    tempServantSlot._stc_HorseImage = UI.getChildControl(tempServantSlot._slot, "Static_HorseImage")
    tempServantSlot._stc_GenderIcon = UI.getChildControl(tempServantSlot._slot, "Static_GenderIcon")
    tempServantSlot._stc_SwiftIcon = UI.getChildControl(tempServantSlot._slot, "Static_SwiftIcon")
    tempServantSlot._txt_Tier = UI.getChildControl(tempServantSlot._slot, "StaticText_Tier")
    tempServantSlot._txt_Level = UI.getChildControl(tempServantSlot._slot, "StaticText_Level")
    tempServantSlot._txt_HpTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_HpTitle")
    tempServantSlot._txt_HpValue = UI.getChildControl(tempServantSlot._slot, "StaticText_HpValue")
    tempServantSlot._txt_StaminaTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_StaminaTitle")
    tempServantSlot._txt_StaminaValue = UI.getChildControl(tempServantSlot._slot, "StaticText_StaminaValue")
    tempServantSlot._txt_WeightTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_WeightTitle")
    tempServantSlot._txt_WeightValue = UI.getChildControl(tempServantSlot._slot, "StaticText_WeightValue")
    tempServantSlot._txt_SpeedTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_SpeedTitle")
    tempServantSlot._txt_SpeedValue = UI.getChildControl(tempServantSlot._slot, "StaticText_SpeedValue")
    tempServantSlot._txt_AccelTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_AccelerationTitle")
    tempServantSlot._txt_AccelValue = UI.getChildControl(tempServantSlot._slot, "StaticText_AccelerationValue")
    tempServantSlot._txt_CorneringTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_CorneringSpeedTitle")
    tempServantSlot._txt_CorneringValue = UI.getChildControl(tempServantSlot._slot, "StaticText_CorneringSpeedValue")
    tempServantSlot._txt_BreakTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_BreakTitle")
    tempServantSlot._txt_BreakValue = UI.getChildControl(tempServantSlot._slot, "StaticText_BreakValue")
    tempServantSlot._txt_DeadCountTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_DeadCountTitle")
    tempServantSlot._txt_DeadCountValue = UI.getChildControl(tempServantSlot._slot, "StaticText_DeadCountValue")
    tempServantSlot._txt_LeftMatingTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_LeftMatingCountTitle")
    tempServantSlot._txt_LeftMatingValue = UI.getChildControl(tempServantSlot._slot, "StaticText_LeftMatingCountValue")
    tempServantSlot._txt_SkillCountTitle = UI.getChildControl(tempServantSlot._slot, "StaticText_SkillCountTitle")
    tempServantSlot._list2_Control = UI.getChildControl(tempServantSlot._slot, "List2_ServantSkill")
    tempServantSlot._btn_beforeLook = UI.getChildControl(tempServantSlot._slot, "Button_BeforeLook")
    tempServantSlot._txt_learnedSkillCount = UI.getChildControl(tempServantSlot._slot, "StaticText_SkillCountValue")
    tempServantSlot._btn_Transfer = UI.getChildControl(tempServantSlot._slot, "Button_Transfer")
    tempServantSlot._stc_OnlySpeed = UI.getChildControl(tempServantSlot._slot, "Static_OnlySpeed")
    tempServantSlot._speedValueBasePosX = tempServantSlot._txt_SpeedValue:GetPosX()
    tempServantSlot._slot:SetShow(false)
    local tooltipCheckControl = {
      tempServantSlot._txt_SpeedTitle,
      tempServantSlot._txt_AccelTitle,
      tempServantSlot._txt_CorneringTitle,
      tempServantSlot._txt_BreakTitle,
      tempServantSlot._txt_DeadCountTitle,
      tempServantSlot._txt_LeftMatingTitle,
      tempServantSlot._txt_SkillCountTitle,
      tempServantSlot._txt_DeadCountValue,
      tempServantSlot._txt_LeftMatingValue
    }
    tempServantSlot._tooltipControls = tooltipCheckControl
    tempServantSlot._slot:addInputEvent("Mouse_On", "HandleEventOn_WorldMap_StableList_Slot(" .. slotIdx .. ")")
    if true == self._isConsole then
      tempServantSlot._btn_Transfer:SetIgnore(true)
      tempServantSlot._slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_WorldMap_StableList_TransferOpen(" .. slotIdx .. ")")
    else
      tempServantSlot._btn_Transfer:SetIgnore(false)
      tempServantSlot._btn_Transfer:addInputEvent("Mouse_LUp", "PaGlobal_WorldMap_StableList_TransferOpen(" .. slotIdx .. ")")
    end
    self._ui._servantSlot[slotIdx] = tempServantSlot
  end
  self._string_ServantTier = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_0"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_GENERATION_FILTER_8"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_TEXT_TIER9")
  }
  self._sexFilterString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_SEXFILTER_0"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_SEXFILTER_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEMARKET_SEXFILTER_2")
  }
  self._ui._list2_region:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_WorldMap_StableList_UpdateRegionList")
  self._ui._list2_region:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_pageValue:SetText(self._currentSlotPage .. " / " .. self._currentMaxPage)
  self._ui._stc_pageValue:SetShow(false)
  local tempSlot = UI.getChildControl(Panel_WorldMap_StableList, "Static_Slot_1")
  local tempList2 = UI.getChildControl(tempSlot, "List2_ServantSkill")
  local tempContent = UI.getChildControl(tempList2, "List2_1_Content")
  local tempSkillName = UI.getChildControl(tempContent, "StaticText_SkillName")
  self._skillNameBaseSpanSizeX = tempSkillName:GetSpanSize().x
  PaGlobal_WorldMap_StableList:registEventHandler()
  PaGlobal_WorldMap_StableList:validate()
  PaGlobal_WorldMap_StableList._initialize = true
end
function PaGlobal_WorldMap_StableList:registEventHandler()
  if nil == Panel_WorldMap_StableList then
    return
  end
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local list2 = self._ui._servantSlot[slotIdx]._list2_Control
    if nil ~= list2 then
      list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_WorldMap_StableList_List2UpdateSkillSlot" .. tostring(slotIdx))
      list2:createChildContent(__ePAUIList2ElementManagerType_List)
    end
  end
  self._ui._btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowStableMarket\" )")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_WorldMap_StableList_Close()")
  self._ui._btn_leftPC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_PageChange(false)")
  self._ui._btn_rightPC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_PageChange(true)")
  if false == self._isConsole then
    Panel_WorldMap_StableList:SetDragEnable(true)
    Panel_WorldMap_StableList:SetDragAll(true)
  else
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadLeft, "HandleEventLUp_WorldMap_StableList_PageChange(false)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_YPress_DpadRight, "HandleEventLUp_WorldMap_StableList_PageChange(true)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPadDown_WorldMap_StableList_YPressTooltipToggle(true)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventPadDown_WorldMap_StableList_YPressTooltipToggle(false)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_WorldMap_StableList_Refresh()")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_WorldMap_StableList_ServantSkill(true)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_WorldMap_StableList_ServantSkill(false)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventPadPress_WorldMap_StableList_MoveSnapping(false)")
    Panel_WorldMap_StableList:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "HandleEventPadPress_WorldMap_StableList_MoveSnapping(true)")
  end
  registerEvent("FromClient_OnChangeServantRegion", "FromClient_WorldMap_StableList_UpdateList()")
end
function PaGlobal_WorldMap_StableList:switchConsoleUI()
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._btn_question:SetShow(not self._isConsole)
  self._ui._btn_leftPC:SetShow(not self._isConsole)
  self._ui._btn_rightPC:SetShow(not self._isConsole)
  self._ui._console._stc_Bottom_KeyGuides:SetShow(self._isConsole)
  self._ui._console._stc_KeyGuide_Y:SetShow(self._isConsole)
  self._ui._console._btn_leftConsole:SetShow(self._isConsole)
  self._ui._console._btn_rightConsole:SetShow(self._isConsole)
  if true == self._isConsole then
    local keyguide = {
      self._ui._console._stc_KeyGuide_LTX,
      self._ui._console._stc_KeyGuide_RS,
      self._ui._console._stc_KeyGuide_X,
      self._ui._console._stc_KeyGuide_A,
      self._ui._console._stc_KeyGuide_B
    }
    self._ui._keyguides = keyguide
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyguides, self._ui._console._stc_Bottom_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_WorldMap_StableList:prepareOpen()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self:clearSlot()
  self:dataClear()
  self:setStableTitle()
  self:switchConsoleUI()
  self:UpdateRegionHasStableList()
  if false == self:SetOpenFirstData() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_STABLE_NOTHAVEVIHICLE"))
    if false == self._isConsole then
      self:prepareClose()
    elseif nil ~= PaGlobalFunc_WorldMap_StableList_Close then
      PaGlobalFunc_WorldMap_StableList_Close()
    end
    return
  end
  self:setTotalPrice()
  self:BuildRegionList()
  self:update()
  PaGlobal_WorldMap_StableList:open()
end
function PaGlobal_WorldMap_StableList:setStableTitle()
  local selfProxyWrapper = getSelfPlayer()
  local nickName = ""
  if nil ~= selfProxyWrapper then
    nickName = selfProxyWrapper:getUserNickname()
  end
  self._ui._stc_title:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_TOTALSTABLE", "name", nickName))
end
function PaGlobal_WorldMap_StableList:open()
  if nil == Panel_WorldMap_StableList then
    return
  end
  Panel_WorldMap_StableList:SetShow(true)
end
function PaGlobal_WorldMap_StableList:prepareClose()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self:clearSlot()
  self:dataClear()
  if true == Panel_WorldMap_StableList:GetShow() then
    WorldMapPopupManager:pop()
  end
  if nil ~= PaGlobalFunc_ServantTransferList_All_Close then
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  PaGlobal_WorldMap_StableList:close()
end
function PaGlobal_WorldMap_StableList:close()
  if nil == Panel_WorldMap_StableList then
    return
  end
  Panel_WorldMap_StableList:SetShow(false)
end
function PaGlobal_WorldMap_StableList:update()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self:updateSlot()
end
function PaGlobal_WorldMap_StableList:clearSlot()
  if nil == Panel_WorldMap_StableList then
    return
  end
  if nil ~= PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap then
    PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap()
  end
  self._ui._stc_noServant:SetShow(true)
  if nil ~= self._ui._servantSlot then
    for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
      if nil ~= self._ui._servantSlot[slotIdx] then
        self._ui._servantSlot[slotIdx]._slot:SetShow(false)
      end
    end
  end
  self._ui._stc_pageValue:SetText(self._currentSlotPage .. " / " .. self._currentMaxPage)
end
function PaGlobal_WorldMap_StableList:setTotalPrice()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self._totalSellPrice = toInt64(0, 0)
  self._totalMarketPrice = toInt64(0, 0)
  local currentRegionKey = self._currentSelectRegionKey
  if nil == currentRegionKey then
    return
  end
  if nil == self._regionInfoList[currentRegionKey] then
    return
  end
  local servantCount = self._regionInfoList[currentRegionKey]._servantCount
  local regionKey = self._regionInfoList[currentRegionKey]._regionKey
  for servantIdx = 0, servantCount - 1 do
    local servantInfo = ToClient_GetServantFromRegionKeyRaw(regionKey, servantIdx)
    if nil ~= servantInfo then
      self._totalSellPrice = self._totalSellPrice + servantInfo:getSellCost_s64()
      self._totalMarketPrice = self._totalMarketPrice + servantInfo:getMaxRegisterMarketPrice_s64()
    end
  end
  self._ui._stc_marketValue:SetText(makeDotMoney(self._totalMarketPrice))
  self._ui._stc_kingdomMoneyValue:SetText(makeDotMoney(self._totalSellPrice))
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui._stc_marketTitle, 1, "", self._ui._stc_marketTitle:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui._stc_kingdomTitle, 1, "", self._ui._stc_kingdomTitle:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui._stc_marketValue, 1, "", self._ui._stc_marketValue:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(self._ui._stc_kingdomMoneyValue, 1, "", self._ui._stc_kingdomMoneyValue:GetText())
end
function PaGlobal_WorldMap_StableList:updateSlot()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self:clearSlot()
  local currentRegionKey = self._currentSelectRegionKey
  if nil == currentRegionKey then
    self:clearSlot()
    return
  end
  if nil == self._regionInfoList[currentRegionKey] then
    return
  end
  local servantCount = self._regionInfoList[currentRegionKey]._servantCount
  if servantCount <= 0 then
    return
  end
  self._ui._stc_noServant:SetShow(false)
  local regionKey = self._regionInfoList[currentRegionKey]._regionKey
  local startIndex = self._currentSlotPage * self._MAXSLOTCOUNT
  local endIndex = startIndex + (self._MAXSLOTCOUNT - 1)
  if endIndex > servantCount - 1 then
    endIndex = servantCount - 1
  end
  if 0 >= self._MAXSLOTCOUNT then
    return
  end
  self._currentMaxPage = math.ceil(servantCount / self._MAXSLOTCOUNT)
  self._currentMaxPage = math.max(0, self._currentMaxPage)
  self._ui._stc_pageValue:SetShow(true)
  self._ui._stc_pageValue:SetText(self._currentSlotPage + 1 .. " / " .. self._currentMaxPage)
  for servantIdx = startIndex, endIndex do
    if servantIdx == servantCount then
      return
    end
    local servantInfo = ToClient_GetServantFromRegionKeyRaw(currentRegionKey, servantIdx)
    if nil ~= servantInfo then
      local slotIndex = servantIdx % self._MAXSLOTCOUNT
      local slot = self._ui._servantSlot[slotIndex]
      slot._slot:SetShow(true)
      slot._stc_HorseImage:ChangeTextureInfoName(servantInfo:getIconPath1())
      slot._regionKey = regionKey
      slot._horseIdx = servantIdx
      slot._list2_Control:getElementManager():clearKey()
      local everyVehicleSkillCount = vehicleSkillStaticStatus_skillCount()
      local learnedSkillCount = 0
      local UnlearnedSkillCount = 0
      for skillIdx = 1, everyVehicleSkillCount - 1 do
        local learnSkillWrapper = servantInfo:getSkill(skillIdx)
        local UnLearnSKillWrapper = servantInfo:getSkillXXX(skillIdx)
        if nil ~= learnSkillWrapper then
          learnedSkillCount = learnedSkillCount + 1
          slot._list2_Control:getElementManager():pushKey(toInt64(0, skillIdx))
        end
        if nil ~= UnLearnSKillWrapper then
          UnlearnedSkillCount = UnlearnedSkillCount + 1
        end
      end
      slot._txt_learnedSkillCount:SetText(tostring(learnedSkillCount) .. " / " .. tostring(learnedSkillCount + UnlearnedSkillCount))
      local isNineTier = 9 ~= servantInfo:getTier()
      local servantType = servantInfo:getVehicleType()
      slot._btn_beforeLook:SetShow(false)
      if false == self._isConsole and servantInfo:getBaseIconPath1() ~= servantInfo:getIconPath1() then
        slot._btn_beforeLook:SetShow(true)
        slot._btn_beforeLook:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMap_StableList_ShowBeforeLook(" .. slotIndex .. ")")
        slot._btn_beforeLook:addInputEvent("Mouse_On", "HandleEventLUp_WorldMap_StableList_ShowBeforeLook_Tooltip( true" .. "," .. servantIdx .. ")")
        slot._btn_beforeLook:addInputEvent("Mouse_Out", "HandleEventLUp_WorldMap_StableList_ShowBeforeLook_Tooltip( false )")
      end
      slot._stc_SwiftIcon:SetShow(false)
      if CppEnums.VehicleType.Type_Horse == servantType then
        slot._txt_LeftMatingTitle:SetShow(isNineTier)
        slot._txt_LeftMatingValue:SetShow(isNineTier)
        if servantInfo:doClearCountByMating() then
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", servantInfo:getMatingCount()))
        else
          slot._txt_LeftMatingValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", servantInfo:getMatingCount()))
        end
        if true == servantInfo:isDisplayGender() then
          slot._stc_GenderIcon:SetShow(true)
          slot._stc_GenderIcon:ChangeTextureInfoName("combine/etc/combine_etc_stable.dds")
          local x1, y1, x2, y2 = 0, 0, 0, 0
          if true == servantInfo:isMale() then
            x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 209, 31, 239)
          else
            x1, y1, x2, y2 = setTextureUV_Func(slot._stc_GenderIcon, 1, 178, 31, 208)
          end
          slot._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
          slot._stc_GenderIcon:setRenderTexture(slot._stc_GenderIcon:getBaseTexture())
        end
        slot._txt_Tier:SetShow(true)
        slot._txt_Tier:SetText("")
        local tierName = servantInfo:getDisplayTierName()
        if nil ~= tierName then
          slot._txt_Tier:SetText(tierName)
        end
        if false == isNineTier and true == self._isContentsStallionEnable then
          slot._stc_SwiftIcon:SetShow(false)
        elseif true == self._isContentsStallionEnable then
          local isStallion = servantInfo:isStallion()
          slot._stc_SwiftIcon:SetShow(isStallion)
          slot._stc_SwiftIcon:SetMonoTone(not isStallion)
        end
      else
        slot._txt_Tier:SetShow(false)
        slot._stc_GenderIcon:SetShow(false)
        slot._txt_LeftMatingTitle:SetShow(false)
        slot._txt_LeftMatingValue:SetShow(false)
      end
      slot._txt_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. servantInfo:getLevel() .. " " .. servantInfo:getName())
      slot._txt_HpValue:SetText(servantInfo:getMaxHp())
      slot._txt_StaminaValue:SetText(servantInfo:getMaxMp())
      slot._txt_WeightValue:SetText(tostring(servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000))
      slot._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
      slot._txt_AccelValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
      slot._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
      slot._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
      local deadCount = servantInfo:getDeadCount()
      if true == servantInfo:doClearCountByDead() then
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
      else
        deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
      end
      slot._txt_DeadCountValue:SetText(deadCount)
      slot._servantNo_s64 = servantInfo:getServantNo()
      if CppEnums.ServantStateType.Type_Stable ~= servantInfo:getStateType() or toInt64(0, 0) < servantInfo:getRemainSecondsToUnseal() then
        slot._btn_Transfer:SetMonoTone(true)
        slot._btn_Transfer:SetEnable(false)
      else
        slot._btn_Transfer:SetMonoTone(false)
        slot._btn_Transfer:SetEnable(true)
      end
      if false == self._isConsole then
        self:tooltipCheck()
      end
      slot._stc_OnlySpeed:SetShow(false)
      slot._stc_OnlySpeed:addInputEvent("Mouse_On", "")
      slot._stc_OnlySpeed:addInputEvent("Mouse_Out", "")
      local speedValuePosX = slot._speedValueBasePosX
      if __eVehicleType_Horse == servantType then
        local speedAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeSpeed)
        if speedAddItemUseCount > 0 then
          speedValuePosX = speedValuePosX + slot._stc_OnlySpeed:GetSizeX()
          slot._stc_OnlySpeed:SetShow(true)
          slot._stc_OnlySpeed:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMap_StableList_ShowUseAddStatItemTooltip(true," .. slotIndex .. "," .. __eServantStatTypeSpeed .. ")")
          slot._stc_OnlySpeed:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMap_StableList_ShowUseAddStatItemTooltip(false)")
        end
      end
      slot._txt_SpeedValue:SetPosX(speedValuePosX)
    end
  end
end
function PaGlobal_WorldMap_StableList:list2SkillUpdate(content, key, slotIdx)
  if nil == Panel_WorldMap_StableList or nil == key then
    return
  end
  if nil == self._ui._servantSlot[slotIdx] then
    return
  end
  local servantIdx = self._ui._servantSlot[slotIdx]._horseIdx
  local regionKey = self._ui._servantSlot[slotIdx]._regionKey
  if nil == servantIdx and nil == regionKey then
    return
  end
  local servantInfo = ToClient_GetServantFromRegionKeyRaw(regionKey, servantIdx)
  if nil == servantInfo then
    return
  end
  local key32 = Int64toInt32(key)
  local skillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local skillExpBg = UI.getChildControl(content, "Static_SkillExpBg")
  local prog2_SkillExp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local skillStallionIcon = UI.getChildControl(content, "Static_SkillStallionIcon")
  if true == self._isConsole then
    if slotIdx == self._curTargetSnapIndex then
      skillIcon:SetIgnore(false)
    else
      skillIcon:SetIgnore(true)
    end
  end
  local actorKeyRaw = servantInfo:getActorKeyRaw()
  local skillWrapper = servantInfo:getSkill(key32)
  if nil ~= skillWrapper then
    skillIcon:ChangeTextureInfoName("Icon/" .. skillWrapper:getIconPath())
    if true == self._isConsole then
      skillIcon:addInputEvent("Mouse_LUp", "PaGlobal_WorldMap_StableList_TransferOpen(" .. slotIdx .. ")")
      skillIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMap_StableList_SnappingSkill(true," .. servantIdx .. "," .. key32 .. ")")
      skillIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMap_StableList_SnappingSkill(false)")
    else
      skillIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(true," .. slotIdx .. "," .. regionKey .. "," .. servantIdx .. "," .. key32 .. ")")
      skillIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMap_StableList_ShowSkillTooltip(false)")
    end
    local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
    skillStallionIcon:SetShow(isStallionSkill)
    local skillNameSpanSizeX = self._skillNameBaseSpanSizeX
    if true == isStallionSkill then
      local gabX = 5
      skillNameSpanSizeX = skillNameSpanSizeX + skillStallionIcon:GetSizeX() - gabX
      if false == self._isConsole then
        skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMap_StableList_ShowStallionToolTip(true," .. key32 .. "," .. slotIdx .. ")")
        skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMap_StableList_ShowStallionToolTip(false)")
      end
    end
    skillName:SetSpanSize(skillNameSpanSizeX, skillName:GetSpanSize().y)
    skillName:SetText(skillWrapper:getName())
    local expPercentTxt = servantInfo:getSkillExp(key32) / (skillWrapper:getMaxExp() / 100)
    prog2_SkillExp:SetShow(true)
    if expPercentTxt >= 100 then
      expPercentTxt = 100
    end
    prog2_SkillExp:SetProgressRate(expPercentTxt)
    prog2_SkillExp:SetAniSpeed(0)
  end
end
function PaGlobal_WorldMap_StableList:validate()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._stc_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_question:isValidate()
  self._ui._stc_leftBg:isValidate()
  self._ui._list2_region:isValidate()
  self._ui._stc_notAvaliable:isValidate()
  self._ui._stc_pageBg:isValidate()
  self._ui._stc_pageValue:isValidate()
  self._ui._btn_leftPC:isValidate()
  self._ui._btn_rightPC:isValidate()
  self._ui._console._btn_leftConsole:isValidate()
  self._ui._console._btn_rightConsole:isValidate()
  self._ui._stc_SkillTooltip:isValidate()
  self._ui._console._stc_Bottom_KeyGuides:isValidate()
  self._ui._console._stc_KeyGuide_B:isValidate()
  self._ui._console._stc_KeyGuide_RS:isValidate()
  self._ui._console._stc_KeyGuide_Y:isValidate()
  self._ui._console._stc_KeyGuide_Y_Tooltip:isValidate()
end
function PaGlobal_WorldMap_StableList:dataClear()
  if nil == Panel_WorldMap_StableList or false == Panel_WorldMap_StableList:GetShow() then
    return
  end
  if nil ~= PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap then
    PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap()
  end
  self._currentSelectTerritoryKey = nil
  self._currentSelectRegionKey = nil
  self._currentSlotPage = 0
  self._currentMaxPage = 0
  self._currentSelectSlot = -1
  if nil ~= TooltipSimple_Hide then
    TooltipSimple_Hide()
  end
end
function PaGlobal_WorldMap_StableList:BuildRegionList()
  if nil == Panel_WorldMap_StableList then
    return
  end
  self._ui._list2_region:getElementManager():clearKey()
  for territoryKey, territoryInfo in pairs(self._territoryInfoList) do
    self._ui._list2_region:getElementManager():pushKey(toInt64(0, territoryKey))
    if territoryKey == self._currentSelectTerritoryKey then
      for ii = 1, #self._territoryInfoList[territoryKey]._regionKeyList do
        self._ui._list2_region:getElementManager():pushKey(toInt64(0, self._territoryInfoList[territoryKey]._regionKeyList[ii] + self._SEPARATORNUMBER))
      end
    end
  end
end
function PaGlobal_WorldMap_StableList:SetOpenFirstData()
  if nil == Panel_WorldMap_StableList then
    return false
  end
  for territoryKey, territoryInfo in pairs(self._territoryInfoList) do
    if 0 < self._territoryInfoList[territoryKey]._territoryservantTotalCount then
      for regionIndex, regionKey in pairs(self._territoryInfoList[territoryKey]._regionKeyList) do
        if nil ~= self._regionInfoList[regionKey] and 0 < self._regionInfoList[regionKey]._servantCount then
          self._currentSelectTerritoryKey = territoryKey
          self._currentSelectRegionKey = regionKey
          return true
        end
      end
    end
  end
  return false
end
function PaGlobal_WorldMap_StableList:UpdateRegionHasStableList()
  self._territoryInfoList = {}
  self._regionInfoList = {}
  local regionStableListSize = ToClient_GetRegionHasStableListSize()
  for index = 0, regionStableListSize - 1 do
    local regionInfo = ToClient_GetRegionHasStableByIndex(index)
    if nil ~= regionInfo then
      local regionTerritoryKey = regionInfo:getTerritoryKeyRaw()
      regionTerritoryKey = regionTerritoryKey + 1
      local areaName = regionInfo:getAreaName()
      local regionKey = regionInfo:getRegionKey()
      local territoryName = regionInfo:getTerritoryName()
      local servantCount = ToClient_StableCountFromRegionKeyRaw(regionKey)
      if nil == self._territoryInfoList[regionTerritoryKey] then
        self._territoryInfoList[regionTerritoryKey] = {
          _territoryKey = regionTerritoryKey - 1,
          _territoryName = territoryName,
          _territoryservantTotalCount = 0,
          _regionKeyList = {}
        }
      end
      self._territoryInfoList[regionTerritoryKey]._territoryservantTotalCount = self._territoryInfoList[regionTerritoryKey]._territoryservantTotalCount + servantCount
      table.insert(self._territoryInfoList[regionTerritoryKey]._regionKeyList, regionKey)
      if nil == self._regionInfoList[regionKey] then
        self._regionInfoList[regionKey] = {
          _regionKey = regionKey,
          _areaName = areaName,
          _servantCount = servantCount
        }
      end
    end
  end
end
function PaGlobal_WorldMap_StableList:tooltipCheck()
  for slotIdx = 0, self._MAXSLOTCOUNT - 1 do
    local tooltipCheckControl = self._ui._servantSlot[slotIdx]._tooltipControls
    for idx = 1, #tooltipCheckControl do
      if nil ~= tooltipCheckControl[idx] then
        tooltipCheckControl[idx]:SetTextMode(__eTextMode_Limit_AutoWrap)
        tooltipCheckControl[idx]:SetText(tooltipCheckControl[idx]:GetText())
        if true == tooltipCheckControl[idx]:IsLimitText() then
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "HandleEventOnOut_WorldMap_StableList_ShowToolTip(" .. slotIdx .. "," .. idx .. " , true)")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "HandleEventOnOut_WorldMap_StableList_ShowToolTip(" .. slotIdx .. "," .. idx .. " , false)")
        else
          tooltipCheckControl[idx]:addInputEvent("Mouse_On", "")
          tooltipCheckControl[idx]:addInputEvent("Mouse_Out", "")
        end
      end
    end
  end
end
