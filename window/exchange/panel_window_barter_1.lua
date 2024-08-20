function PaGlobal_Barter:init()
  if true == self._isLoadComplete then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._consoleKeyGuideBg:SetShow(true == self._isConsole)
  self._ui._keyGuide_close = UI.getChildControl(self._ui._consoleKeyGuideBg, "StaticText_KeyGuide_B_Consoleui")
  self._ui._keyGuide_sExchange = UI.getChildControl(self._ui._consoleKeyGuideBg, "StaticText_KeyGuide_A_Consoleui")
  self._ui._keyGuide_sSkip = UI.getChildControl(self._ui._consoleKeyGuideBg, "StaticText_KeyGuide_Y_Consoleui")
  self._ui._keyGuide_nExchanges = UI.getChildControl(self._ui._consoleKeyGuideBg, "StaticText_KeyGuide_A1_Consoleui")
  self._ui._keyGuide_nExchange = UI.getChildControl(self._ui._consoleKeyGuideBg, "StaticText_KeyGuide_Y2_Consoleui")
  self._ui._keyGuide_close:SetShow(false)
  self._ui._keyGuide_sExchange:SetShow(false)
  self._ui._keyGuide_sSkip:SetShow(false)
  self._ui._keyGuide_nExchanges:SetShow(false)
  self._ui._keyGuide_nExchange:SetShow(false)
  self._panelSizeX = Panel_Window_Barter:GetSizeX()
  self._panelSizeY = Panel_Window_Barter:GetSizeY()
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  if true == self._isConsole then
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_Barter:close()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Barter:close()")
  end
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._btn_titleName = UI.getChildControl(self._ui._titleBar, "StaticText_TitleName")
  self._mainBgBaseSizeY = self._ui._mainBg:GetSizeY()
  self._normalBgBaseSizeY = self._ui._normalBg:GetSizeY()
  self._specialBgBaseSizeY = self._ui._specialBg:GetSizeY()
  self:createNormalBarterBg()
  self:createSpecialBarterBg()
  self._ui._btn_normal = UI.getChildControl(self._ui._rdoBtnBg, "RadioButton_NormalList")
  self._ui._btn_special = UI.getChildControl(self._ui._rdoBtnBg, "RadioButton_SpecialList")
  self._ui._selectLine = UI.getChildControl(self._ui._rdoBtnBg, "Static_SelctLine")
  self._ui._keyGuide_LT = UI.getChildControl(self._ui._rdoBtnBg, "Static_KeyGuide_LT_ConsoleUI")
  self._ui._keyGuide_RT = UI.getChildControl(self._ui._rdoBtnBg, "Static_KeyGuide_RT_ConsoleUI")
  self._ui._keyGuide_LT:SetShow(true == self._isConsole)
  self._ui._keyGuide_RT:SetShow(true == self._isConsole)
  if true == self._isConsole then
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_Barter:setNormalBarterInfo()")
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_Barter:setSpecialBarterInfo()")
  else
    self._ui._btn_normal:addInputEvent("Mouse_LUp", "PaGlobal_Barter:setNormalBarterInfo()")
    self._ui._btn_special:addInputEvent("Mouse_LUp", "PaGlobal_Barter:setSpecialBarterInfo()")
  end
  registerEvent("FromClient_SuccessDoBarter", "FromClient_Barter_SuccessDoBarter")
  registerEvent("FromClient_SuccessDoSpecialBarter", "FromClient_Barter_SuccessDoSpecialBarter")
  registerEvent("FromClient_RefreshBarterList", "FromClient_Barter_UpdateBarter")
  registerEvent("FromClient_RefreshSpecialBarterInfo", "FromClient_Barter_UpdateBarter")
  registerEvent("FromClient_LoadBarterList", "FromClient_Barter_UpdateBarter")
  registerEvent("FromClient_UseBarterChangeInfoItem", "FromClient_UseBarterChangeInfoItem")
  registerEvent("FromClient_NotUseBarterChangeInfoItem", "FromClient_NotUseBarterChangeInfoItem")
  self._isLoadComplete = true
end
function PaGlobal_Barter:createNormalBarterBg()
  local topBg = UI.getChildControl(self._ui._normalBg, "Static_TopBg")
  self._ui._normal_txt_exchangeCount = UI.getChildControl(topBg, "StaticText_CountValue")
  local topBg2 = UI.getChildControl(self._ui._normalBg, "Static_TopBg2")
  self._ui._normal_txt_remainTime = UI.getChildControl(topBg2, "StaticText_CountValue")
  self._ui._normal_btn_doBarter = UI.getChildControl(self._ui._normalBg, "Button_ExchangeOne")
  self._ui._normal_btn_doBarters = UI.getChildControl(self._ui._normalBg, "Button_ExchangeContinuance")
  self._ui._normal_btn_doBarter:addInputEvent("Mouse_LUp", "PaGlobal_Barter:doNormalBarter(1)")
  self._ui._normal_btn_doBarters:addInputEvent("Mouse_LUp", "PaGlobal_Barter:selectExchangeCount()")
  self._ui._normal_btn_doBarter:SetShow(false == self._isConsole)
  self._ui._normal_btn_doBarters:SetShow(false == self._isConsole)
  local slot = {}
  SlotItem.new(slot, "NormalFromSlot", 0, UI.getChildControl(self._ui._normalBg, "Static_MyItemSlotBg"), self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(17)
  slot.icon:SetPosY(17)
  slot.icon:addInputEvent("Mouse_On", "PaGlobal_Barter:itemTooltip_Show(0)")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Barter:itemTooltip_Hide()")
  self._ui._normal_FromSlot = slot
  slot = {}
  SlotItem.new(slot, "NormalToSlot", 0, UI.getChildControl(self._ui._normalBg, "Static_NpcItemSlotBg"), self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(17)
  slot.icon:SetPosY(17)
  slot.icon:addInputEvent("Mouse_On", "PaGlobal_Barter:itemTooltip_Show(1)")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Barter:itemTooltip_Hide()")
  self._ui._normal_ToSlot = slot
  self._ui._normal_FromItemName = UI.getChildControl(self._ui._normalBg, "StaticText_MyItemName")
  self._ui._normal_ToItemName = UI.getChildControl(self._ui._normalBg, "StaticText_NpcItemName")
  local desc = UI.getChildControl(self._ui._normalBg, "Static_DescBg")
  self._ui._normal_Desc = UI.getChildControl(desc, "StaticText_Desc")
  self._ui._normal_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._normal_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_NORMALEXCHANG_DESC"))
  local baseDescY = desc:GetSizeY()
  desc:SetSize(desc:GetSizeX(), self._ui._normal_Desc:GetTextSizeY() + 20)
  self._panelSizeBaseDiffY = desc:GetSizeY() - baseDescY
  Panel_Window_Barter:SetSize(Panel_Window_Barter:GetSizeX(), Panel_Window_Barter:GetSizeY() + self._panelSizeBaseDiffY)
  self._ui._normal_txt_myItemCount = UI.getChildControl(self._ui._normalBg, "StaticText_MyItemCount")
  self._ui._normal_txt_diffWeight = UI.getChildControl(self._ui._normalBg, "StaticText_WeightPerTrade")
  self._ui._normal_txt_currentWeight = UI.getChildControl(self._ui._normalBg, "StaticText_WeightCountValue")
  self._ui._normal_icon_weight = UI.getChildControl(self._ui._normalBg, "StaticText_WeightCountIcon")
  local ticketBg = UI.getChildControl(self._ui._normalBg, "Static_BarterTicketBg")
  self._ui._normal_txt_ticket = UI.getChildControl(ticketBg, "StaticText_CountValue")
end
function PaGlobal_Barter:createSpecialBarterBg()
  local topBg = UI.getChildControl(self._ui._specialBg, "Static_TopBg1")
  self._ui._special_txt_exchangeCount = UI.getChildControl(topBg, "StaticText_CountValue")
  self._ui._special_btn_cancel = UI.getChildControl(self._ui._specialBg, "Button_Skip")
  self._ui._special_btn_doBarter = UI.getChildControl(self._ui._specialBg, "Button_Exchange")
  self._ui._special_btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Barter:cancelSpecialBarter()")
  self._ui._special_btn_doBarter:addInputEvent("Mouse_LUp", "PaGlobal_Barter:doSpecialBarter()")
  self._ui._special_btn_cancel:SetShow(false == self._isConsole)
  self._ui._special_btn_doBarter:SetShow(false == self._isConsole)
  local slot = {}
  SlotItem.new(slot, "SpecialFromSlot", 0, UI.getChildControl(self._ui._specialBg, "Static_MyItemSlotBg"), self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(17)
  slot.icon:SetPosY(17)
  slot.icon:addInputEvent("Mouse_On", "PaGlobal_Barter:itemTooltip_Show(2)")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Barter:itemTooltip_Hide()")
  self._ui._special_FromSlot = slot
  slot = {}
  SlotItem.new(slot, "SpecialToSlot", 0, UI.getChildControl(self._ui._specialBg, "Static_NpcItemSlotBg"), self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(17)
  slot.icon:SetPosY(17)
  slot.icon:addInputEvent("Mouse_On", "PaGlobal_Barter:itemTooltip_Show(3)")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobal_Barter:itemTooltip_Hide()")
  self._ui._special_ToSlot = slot
  self._ui._special_FromItemName = UI.getChildControl(self._ui._specialBg, "StaticText_MyItemName")
  self._ui._special_ToItemName = UI.getChildControl(self._ui._specialBg, "StaticText_NpcItemName")
  local desc = UI.getChildControl(self._ui._specialBg, "Static_DescBg")
  self._ui._special_Desc1 = UI.getChildControl(desc, "StaticText_Desc")
  self._ui._special_Desc1:SetTextMode(__eTextMode_AutoWrap)
  self._ui._special_Desc1:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_SPECIALEXCHANGE_DESC"))
  self._ui._special_Desc2 = UI.getChildControl(desc, "StaticText_SpecialDesc")
  self._ui._special_Desc2:SetTextMode(__eTextMode_AutoWrap)
  self._ui._special_Desc2:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_SPECIALEXCHANGE_DESC_SPECIAL"))
  local baseDescY = desc:GetSizeY()
  desc:SetSize(desc:GetSizeX(), self._ui._special_Desc2:GetTextSizeY() + 20)
  self._panelSizeSpecialDiffY = desc:GetSizeY() - baseDescY
  self._ui._special_txt_myItemCount = UI.getChildControl(self._ui._specialBg, "StaticText_MyItemCount")
  self._ui._special_txt_diffWeight = UI.getChildControl(self._ui._specialBg, "StaticText_WeightPerTrade")
  self._ui._special_txt_currentWeight = UI.getChildControl(self._ui._specialBg, "StaticText_WeightCountValue")
  self._ui._special_icon_weight = UI.getChildControl(self._ui._specialBg, "StaticText_WeightCountIcon")
  local ticketBg = UI.getChildControl(self._ui._specialBg, "Static_BarterTicketBg")
  self._ui._special_txt_ticket = UI.getChildControl(ticketBg, "StaticText_CountValue")
end
function PaGlobal_Barter:clear()
  self._regionKey = nil
  self._actorKey = nil
  self._servantActorKey = nil
  self._fromItemEnchantKey = nil
  self._myFromItemCount_s64 = 0
  self._fromItemCount_s64 = 0
  self._toItemCount_s64 = 0
  self._updateCurrentTime = 0
  self._updatePastTime = 0
  self._fromItemWeight = 0
  self._toItemWeight = 0
  self._curWeight_s64 = toInt64(0, 0)
  self._maxWeight_s64 = toInt64(0, 0)
  self._ui._btn_normal:SetCheck(true)
  self._ui._btn_special:SetCheck(false)
  self._ui._normal_txt_remainTime:SetText("")
end
function PaGlobal_Barter:open(actorKey, regionKey)
  if false == _ContentsGroup_Barter then
    return
  end
  if false == self._isLoadComplete then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local servantActorKey = selfPlayerWrapper:get():getRideVehicleActorKeyRaw()
  if nil == getVehicleActor(servantActorKey) then
    return
  end
  self:clear()
  self._actorKey = actorKey
  self._regionKey = regionKey
  self._servantActorKey = servantActorKey
  if false == self:refresh() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoBarterInfoNotExist"))
    self:close()
    return
  end
  audioPostEvent_SystemUi(26, 0)
  _AudioPostEvent_SystemUiForXBOX(26, 0)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TRADE_PROPOSAL_BUTTON"))
  Panel_Window_Barter:RegisterUpdateFunc("Update_Barter_FrameEvent")
  Panel_Window_Barter:SetShow(true)
end
function PaGlobal_Barter:close()
  Panel_Window_Barter:ClearUpdateLuaFunc("Update_Barter_FrameEvent")
  Panel_Window_Barter:SetShow(false)
end
function PaGlobal_Barter:setNormalBarterInfo()
  local barterWrapper = ToClient_barterWrapper(self._regionKey)
  if nil == barterWrapper then
    return false
  end
  self._fromItemWeight = 0
  self._toItemWeight = 0
  self._curWeight_s64 = toInt64(0, 0)
  self._maxWeight_s64 = toInt64(0, 0)
  self._ui._btn_titleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_TITLE"))
  local fromItemEnchantKey = barterWrapper:getFromItemEnchantKey()
  local fromItemCount = barterWrapper:getFromItemCount()
  local toItemEnchantKey = barterWrapper:getToItemEnchantKey()
  local toItemCount = barterWrapper:getToItemCount()
  local currentExchangeCount = barterWrapper:getExchangeCurrentCount()
  local currentExchangeMaxCount = barterWrapper:getExchangeMaxCount()
  local itemSSW = getItemEnchantStaticStatus(fromItemEnchantKey)
  if nil ~= itemSSW then
    self._ui._normal_FromSlot:setItemByStaticStatus(itemSSW, fromItemCount)
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      self._ui._normal_FromItemName:SetFontColor(fontColor)
    else
      self._ui._normal_FromItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    self._ui._normal_FromItemName:SetText(itemSSW:getName())
    UI.setLimitTextAndAddTooltip(PaGlobal_Barter._ui._normal_FromItemName)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._normal_FromItemName:SetIgnore(not self._ui._normal_FromItemName:IsLimitText())
    end
    self._fromItemWeight = itemSSW:get()._weight
    self._fromItemCount_s64 = fromItemCount
  end
  itemSSW = getItemEnchantStaticStatus(toItemEnchantKey)
  if nil ~= itemSSW then
    self._ui._normal_ToSlot:setItemByStaticStatus(itemSSW, toItemCount)
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      self._ui._normal_ToItemName:SetFontColor(fontColor)
    else
      self._ui._normal_ToItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    self._ui._normal_ToItemName:SetText(itemSSW:getName())
    UI.setLimitTextAndAddTooltip(self._ui._normal_ToItemName)
    if true == _ContentsGroup_UsePadSnapping then
      self._ui._normal_ToItemName:SetIgnore(not self._ui._normal_ToItemName:IsLimitText())
    end
    self._toItemWeight = itemSSW:get()._weight
    self._toItemCount_s64 = toItemCount
  end
  self._ui._normal_txt_exchangeCount:SetText(tostring(currentExchangeMaxCount - currentExchangeCount) .. "/" .. tostring(currentExchangeMaxCount))
  local posX = (self._ui._btn_normal:GetSizeX() - self._ui._selectLine:GetSizeX()) / 2
  self._ui._selectLine:SetPosX(self._ui._btn_normal:GetPosX() + posX)
  self._ui._normalBg:SetShow(true)
  self._ui._specialBg:SetShow(false)
  self:checkInventory(fromItemEnchantKey)
  self._fromItemEnchantKey = fromItemEnchantKey
  if currentExchangeCount < currentExchangeMaxCount and Int64toInt32(fromItemCount) <= Int64toInt32(self._myFromItemCount_s64) then
    self._ui._normal_btn_doBarter:SetMonoTone(false)
    self._ui._normal_btn_doBarters:SetMonoTone(false)
    self._ui._normal_btn_doBarter:SetIgnore(false)
    self._ui._normal_btn_doBarters:SetIgnore(false)
  else
    self._ui._normal_btn_doBarter:SetMonoTone(true)
    self._ui._normal_btn_doBarters:SetMonoTone(true)
    self._ui._normal_btn_doBarter:SetIgnore(true)
    self._ui._normal_btn_doBarters:SetIgnore(true)
  end
  self._ui._normal_txt_myItemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_MYITEMCOUNT", "itemCount", tostring(self._myFromItemCount_s64)))
  local diffWeightStr = ""
  local diffWeight = self._toItemWeight * Int64toInt32(toItemCount) - self._fromItemWeight * Int64toInt32(fromItemCount)
  if diffWeight >= 0 then
    diffWeightStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_DIFFWEIGHT_PLUS", "weight", makeWeightString(diffWeight, 2))
  else
    diffWeightStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_DIFFWEIGHT_MINUS", "weight", makeWeightString(diffWeight, 2))
  end
  self._ui._normal_txt_diffWeight:SetText(diffWeightStr)
  local vehicleWrapper = getVehicleActor(self._servantActorKey)
  if nil ~= vehicleWrapper then
    local vehicleProxy = vehicleWrapper:get()
    if nil ~= vehicleProxy then
      self._curWeight_s64 = vehicleProxy:getCurrentWeight_s64()
      self._maxWeight_s64 = vehicleProxy:getPossessableWeight_s64()
    end
  end
  self._ui._normal_txt_currentWeight:SetText(makeWeightString(self._curWeight_s64, 1) .. "/" .. makeWeightString(self._maxWeight_s64, 0) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  self._ui._normal_icon_weight:SetPosX(self._ui._normalBg:GetSizeX() - self._ui._normal_txt_currentWeight:GetTextSizeX() - 60)
  local needExchangeCount = ToClient_needExchangeCount(self._regionKey)
  local needExchangeCount_s64 = toInt64(0, needExchangeCount)
  self._ui._normal_txt_ticket:SetText(tostring(makeDotMoney(needExchangeCount_s64)))
  if true == self._isConsole then
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_Barter:doNormalBarter(1)")
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_Barter:selectExchangeCount()")
    self._ui._keyGuide_close:SetShow(true)
    self._ui._keyGuide_sExchange:SetShow(false)
    self._ui._keyGuide_sSkip:SetShow(false)
    self._ui._keyGuide_nExchanges:SetShow(true)
    self._ui._keyGuide_nExchange:SetShow(true)
    local keyGuide = {
      self._ui._keyGuide_nExchange,
      self._ui._keyGuide_nExchanges,
      self._ui._keyGuide_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._consoleKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui._btn_normal:SetCheck(true)
    self._ui._btn_special:SetCheck(false)
  end
  local eventCount = self:getRegionEventCount()
  if 0 ~= eventCount then
    if eventCount > 1 then
      Panel_Window_Barter:SetSize(self._panelSizeX, self._panelSizeY + self._panelSizeBaseDiffY)
    else
      Panel_Window_Barter:SetSize(self._panelSizeX, self._panelSizeY + self._panelSizeBaseDiffY - 60)
    end
    self._ui._mainBg:SetSize(self._ui._mainBg:GetSizeX(), self._mainBgBaseSizeY + self._panelSizeBaseDiffY)
    self._ui._normalBg:SetSize(self._ui._normalBg:GetSizeX(), self._normalBgBaseSizeY + self._panelSizeBaseDiffY)
    self._ui._specialBg:SetSize(self._ui._specialBg:GetSizeX(), self._specialBgBaseSizeY + self._panelSizeBaseDiffY)
    self._ui._titleBar:ComputePos()
    self._ui._normalBg:ComputePos()
    self._ui._specialBg:ComputePos()
    self._ui._mainBg:ComputePos()
    self:resizePanel()
  end
  return true
end
function PaGlobal_Barter:setSpecialBarterInfo()
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  if nil == specialBarterWrapper then
    return false
  end
  if specialBarterWrapper:getRegionKey():get() ~= self._regionKey:get() then
    return false
  end
  self._fromItemWeight = 0
  self._toItemWeight = 0
  self._curWeight_s64 = toInt64(0, 0)
  self._maxWeight_s64 = toInt64(0, 0)
  self._ui._btn_titleName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SPECIALTITLE"))
  local fromItemEnchantKey = specialBarterWrapper:getFromItemEnchantKey()
  local fromItemCount = specialBarterWrapper:getFromItemCount()
  local toItemEnchantKey = specialBarterWrapper:getToItemEnchantKey()
  local toItemCount = specialBarterWrapper:getToItemCount()
  local currentExchangeCount = specialBarterWrapper:getExchangeCurrentCount()
  local currentExchangeMaxCount = specialBarterWrapper:getExchangeMaxCount()
  local itemSSW = getItemEnchantStaticStatus(fromItemEnchantKey)
  if nil ~= itemSSW then
    self._ui._special_FromSlot:setItemByStaticStatus(itemSSW, fromItemCount)
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      self._ui._special_FromItemName:SetFontColor(fontColor)
    else
      self._ui._special_FromItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    self._ui._special_FromItemName:SetText(itemSSW:getName())
    self._fromItemWeight = itemSSW:get()._weight
    self._fromItemCount_s64 = fromItemCount
  end
  itemSSW = getItemEnchantStaticStatus(toItemEnchantKey)
  if nil ~= itemSSW then
    self._ui._special_ToSlot:setItemByStaticStatus(itemSSW, toItemCount)
    local fontColor = self._itemGradeColor[itemSSW:getGradeType()]
    if nil ~= fontColor then
      self._ui._special_ToItemName:SetFontColor(fontColor)
    else
      self._ui._special_ToItemName:SetFontColor(Defines.Color.C_FFFFFFFF)
    end
    self._ui._special_ToItemName:SetText(itemSSW:getName())
    self._toItemWeight = itemSSW:get()._weight
    self._toItemCount_s64 = toItemCount
  end
  self._ui._special_txt_exchangeCount:SetText(tostring(currentExchangeMaxCount - currentExchangeCount) .. "/" .. tostring(currentExchangeMaxCount))
  local posX = (self._ui._btn_special:GetSizeX() - self._ui._selectLine:GetSizeX()) / 2
  self._ui._selectLine:SetPosX(self._ui._btn_special:GetPosX() + posX)
  self._ui._normalBg:SetShow(false)
  self._ui._specialBg:SetShow(true)
  self:checkInventory(fromItemEnchantKey)
  self._fromItemEnchantKey = fromItemEnchantKey
  if currentExchangeCount < currentExchangeMaxCount and Int64toInt32(fromItemCount) <= Int64toInt32(self._myFromItemCount_s64) then
    self._ui._special_btn_doBarter:SetMonoTone(false)
    self._ui._special_btn_doBarter:SetIgnore(false)
  else
    self._ui._special_btn_doBarter:SetMonoTone(true)
    self._ui._special_btn_doBarter:SetIgnore(true)
  end
  self._ui._special_txt_myItemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_MYITEMCOUNT", "itemCount", tostring(self._myFromItemCount_s64)))
  local diffWeightStr = ""
  local diffWeight = self._toItemWeight * Int64toInt32(toItemCount) - self._fromItemWeight * Int64toInt32(fromItemCount)
  if diffWeight >= 0 then
    diffWeightStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_DIFFWEIGHT_PLUS", "weight", makeWeightString(diffWeight, 2))
  else
    diffWeightStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_BARTERINFO_DIFFWEIGHT_MINUS", "weight", makeWeightString(diffWeight, 2))
  end
  self._ui._special_txt_diffWeight:SetText(diffWeightStr)
  local vehicleWrapper = getVehicleActor(self._servantActorKey)
  if nil ~= vehicleWrapper then
    local vehicleProxy = vehicleWrapper:get()
    if nil ~= vehicleProxy then
      self._curWeight_s64 = vehicleProxy:getCurrentWeight_s64()
      self._maxWeight_s64 = vehicleProxy:getPossessableWeight_s64()
    end
  end
  self._ui._special_txt_currentWeight:SetText(makeWeightString(self._curWeight_s64, 1) .. "/" .. makeWeightString(self._maxWeight_s64, 0) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  self._ui._special_icon_weight:SetPosX(self._ui._specialBg:GetSizeX() - self._ui._special_txt_currentWeight:GetTextSizeX() - 60)
  local needTicket = specialBarterWrapper:getExchangeCountForTime()
  self._ui._special_txt_ticket:SetText(tostring(needTicket))
  if true == self._isConsole then
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_Barter:cancelSpecialBarter()")
    Panel_Window_Barter:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobal_Barter:doSpecialBarter()")
    self._ui._keyGuide_close:SetShow(true)
    self._ui._keyGuide_sExchange:SetShow(true)
    self._ui._keyGuide_sSkip:SetShow(true)
    self._ui._keyGuide_nExchanges:SetShow(false)
    self._ui._keyGuide_nExchange:SetShow(false)
    local keyGuide = {
      self._ui._keyGuide_sSkip,
      self._ui._keyGuide_sExchange,
      self._ui._keyGuide_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._consoleKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui._btn_normal:SetCheck(false)
    self._ui._btn_special:SetCheck(true)
  end
  local eventCount = self:getRegionEventCount()
  if eventCount > 1 then
    local rdoBtnSizeY = 0
    if true == self._ui._rdoBtnBg:GetShow() then
      rdoBtnSizeY = self._ui._rdoBtnBg:GetSizeY()
    end
    Panel_Window_Barter:SetSize(self._panelSizeX, self._panelSizeY + self._panelSizeSpecialDiffY + rdoBtnSizeY - 60)
    self._ui._mainBg:SetSize(self._ui._mainBg:GetSizeX(), self._mainBgBaseSizeY + self._panelSizeSpecialDiffY + rdoBtnSizeY)
    self._ui._normalBg:SetSize(self._ui._normalBg:GetSizeX(), self._normalBgBaseSizeY + self._panelSizeSpecialDiffY)
    self._ui._specialBg:SetSize(self._ui._specialBg:GetSizeX(), self._specialBgBaseSizeY + self._panelSizeSpecialDiffY + rdoBtnSizeY)
    self._ui._titleBar:ComputePos()
    self._ui._normalBg:ComputePos()
    self._ui._specialBg:ComputePos()
    self._ui._mainBg:ComputePos()
    if rdoBtnSizeY > 0 then
      self._ui._specialBg:SetPosY(self._ui._rdoBtnBg:GetPosY() + rdoBtnSizeY)
    end
    self:resizePanel()
  end
  return true
end
function PaGlobal_Barter:isWeightOver(fromItemCount)
  local div = Int64toInt32(Defines.s64_const.s64_100)
  local addWeight = (self._toItemWeight / div * Int64toInt32(self._toItemCount_s64) - self._fromItemWeight / div * Int64toInt32(self._fromItemCount_s64)) * fromItemCount
  local curWeight = Int64toInt32(self._curWeight_s64) / div
  local maxWeight = Int64toInt32(self._maxWeight_s64) / div
  if maxWeight > curWeight + addWeight then
    return false
  end
  return true
end
function PaGlobal_Barter:doNormalBarter(fromItemCount)
  if true == self:isWeightOver(fromItemCount) then
    local function doBarter()
      ToClient_requestDoBarter(self._actorKey, self._fromItemEnchantKey, fromItemCount)
    end
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_VEHICLE_MSG_TITLE")
    local contentString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_WEIGHTPENALTY_WARNNING")
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = doBarter,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    ToClient_requestDoBarter(self._actorKey, self._fromItemEnchantKey, fromItemCount)
  end
end
function PaGlobal_Barter:selectExchangeCount()
  local barterWrapper = ToClient_barterWrapper(self._regionKey)
  if nil ~= barterWrapper then
    local itemMaxCount = math.floor(Int64toInt32(self._myFromItemCount_s64 / barterWrapper:getFromItemCount()))
    local currentCount = barterWrapper:getExchangeMaxCount() - barterWrapper:getExchangeCurrentCount()
    local totalMaxCount = math.min(itemMaxCount, currentCount)
    Panel_NumberPad_Show(true, toInt64(0, totalMaxCount), nil, NumberPadInput_Barter_SetExchangeCount)
  end
end
function NumberPadInput_Barter_SetExchangeCount(inputCount)
  PaGlobal_Barter:doNormalBarter(Int64toInt32(inputCount))
end
function PaGlobal_Barter:cancelSpecialBarter()
  local function MessageBox_SkipFunc()
    ToClient_giveUpSpecialBarter(self._actorKey)
  end
  local msgTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_BARTER_SPECIALTITLE")
  local msgDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_BARTER_GIVEUPSPECIALBARTER")
  local messageBoxData = {
    title = msgTitle,
    content = msgDesc,
    functionYes = MessageBox_SkipFunc,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Barter:doSpecialBarter()
  if true == self:isWeightOver(1) then
    local function doBarter()
      ToClient_requestDoSpecialBarter(self._actorKey, self._fromItemEnchantKey)
    end
    local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_VEHICLE_MSG_TITLE")
    local contentString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BARTER_WEIGHTPENALTY_WARNNING")
    local messageboxData = {
      title = titleString,
      content = contentString,
      functionYes = doBarter,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    ToClient_requestDoSpecialBarter(self._actorKey, self._fromItemEnchantKey)
  end
end
function PaGlobal_Barter:checkInventory(fromEnchantItemKey)
  self._myFromItemCount_s64 = 0
  local slotNo = ToClient_InventoryGetSlotNoByType(CppEnums.ItemWhereType.eServantInventory, fromEnchantItemKey)
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(selfPlayer:getRideVehicleActorKeyRaw(), slotNo)
  if nil ~= itemWrapper then
    self._myFromItemCount_s64 = itemWrapper:get():getCount_s64()
  end
end
function PaGlobal_Barter:getRegionEventCount()
  local eventCount = 0
  local barterWrapper = ToClient_barterWrapper(self._regionKey)
  if nil ~= barterWrapper then
    eventCount = eventCount + 1
  end
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  if nil ~= specialBarterWrapper and specialBarterWrapper:getRegionKey():get() == self._regionKey:get() then
    eventCount = eventCount + 1
  end
  return eventCount
end
function PaGlobal_Barter:refresh()
  local eventCount = self:getRegionEventCount()
  if 0 == eventCount then
    return false
  elseif eventCount > 1 then
    self:setNormalBarterInfo()
    self._ui._rdoBtnBg:SetShow(true)
  else
    local isExist = self:setNormalBarterInfo()
    if false == isExist then
      isExist = self:setSpecialBarterInfo()
    end
    if false == isExist then
      return false
    end
    self._ui._rdoBtnBg:SetShow(false)
  end
  return true
end
function PaGlobal_Barter:resizePanel()
  if true == self._isConsole then
    local panelSizeX = Panel_Window_Barter:GetSizeX()
    local panelSizeY = Panel_Window_Barter:GetSizeY()
    local btnSizeY = self._ui._normal_btn_doBarter:GetSizeY()
    Panel_Window_Barter:SetSize(panelSizeX, panelSizeY - btnSizeY)
    Panel_Window_Barter:ComputePos()
    self._ui._consoleKeyGuideBg:SetPosY(Panel_Window_Barter:GetSizeY())
  else
    self._ui._normal_btn_doBarter:ComputePos()
    self._ui._normal_btn_doBarters:ComputePos()
    local desc = UI.getChildControl(self._ui._specialBg, "Static_DescBg")
    if nil ~= desc then
      local specialButtonPosY = desc:GetPosY() + desc:GetSizeY() + 10
      self._ui._special_btn_cancel:SetPosY(specialButtonPosY)
      self._ui._special_btn_doBarter:SetPosY(specialButtonPosY)
    end
  end
end
function PaGlobal_Barter:itemTooltip_Show(idx)
  local barterWrapper = ToClient_barterWrapper(self._regionKey)
  local specialBarterWrapper = ToClient_specialBarterWrapper()
  local control, itemEnchantKey
  if 0 == idx and nil ~= barterWrapper then
    control = self._ui._normal_FromSlot.icon
    itemEnchantKey = barterWrapper:getFromItemEnchantKey()
  elseif 1 == idx and nil ~= barterWrapper then
    control = self._ui._normal_ToSlot.icon
    itemEnchantKey = barterWrapper:getToItemEnchantKey()
  elseif 2 == idx and nil ~= specialBarterWrapper then
    control = self._ui._special_FromSlot.icon
    itemEnchantKey = specialBarterWrapper:getFromItemEnchantKey()
  else
    if 3 == idx and nil ~= specialBarterWrapper then
      control = self._ui._special_ToSlot.icon
      itemEnchantKey = specialBarterWrapper:getToItemEnchantKey()
    else
    end
  end
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil ~= control and nil ~= itemSSW then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_Barter:itemTooltip_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
