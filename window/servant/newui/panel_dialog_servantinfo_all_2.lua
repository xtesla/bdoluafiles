function PaGlobalFunc_ServantInfo_All_Open(servantNo)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  if PaGlobal_ServantInfo_All._currentVehicleIndexNo ~= servantNo then
    PaGlobal_ServantInfo_All._currentSkillListData._index = nil
    PaGlobal_ServantInfo_All._currentSkillListData._pos = nil
  end
  PaGlobal_ServantInfo_All._currentSlotType = -1
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobal_ServantInfo_All._currentSlotType = PaGlobalFunc_ServantList_All_Get_CurrentSlotType()
  end
  if -1 == PaGlobal_ServantInfo_All._currentSlotType or nil == PaGlobal_ServantInfo_All._currentSlotType then
    return
  end
  if nil ~= Panel_Dialog_ServantLookChange_All and true == Panel_Dialog_ServantLookChange_All:GetShow() then
    PaGlobalFunc_ServantLookChange_All_Close()
  end
  PaGlobal_ServantInfo_All._currentVehicleIndexNo = servantNo
  PaGlobal_ServantInfo_All._currentNpcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  PaGlobal_ServantInfo_All:prepareOpen()
end
function PaGlobalFunc_ServantInfo_GetShow()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  return Panel_Dialog_ServantInfo_All:GetShow()
end
function PaGlobalFunc_ServantInfo_All_Close()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:prepareClose()
end
function PaGlobalFunc_ServantInfo_All_CloseEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(false)
end
function FromClient_ServantInfo_All_OnScreenSize()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:ComputePos()
end
function PaGlobalFunc_ServantInfo_All_ShowAni()
  UIAni.fadeInSCR_Right(Panel_Dialog_ServantInfo_All)
  local aniInfo3 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
end
function PaGlobalFunc_ServantInfo_All_HideAni()
  Panel_Dialog_ServantInfo_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_ClearGuildServantDeadCount()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = guildStable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RECOVERINJURY_ELEPHANT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE_ACK"))
  end
  PaGlobal_ServantInfo_All:update()
end
function PaGlobalFunc_ServantInfo_All_Update()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
end
function FromClient_ServantInfo_All_List2ServantSkill(content, key)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:updateServantSkillByList2(content, key)
end
function FromClient_ServantInfo_All_ForgetServantSkill(notUse, notUse)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SkillChangeFinish()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SetBeginningLevelServant()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_COMPLETE_SETBEGINNINGLEVEL")
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(msg)
  if nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    PaGlobalFunc_ServantInfo_All_Open(0)
  else
    PaGlobal_ServantInfo_All:update()
  end
  PaGlobal_ServantList_All:update()
end
function HandleEventLUp_ServantInfo_All_SkillChangeOpen()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(0)
  if nil ~= Panel_Dialog_ServantSkillManagement_All then
    PaGlobalFunc_ServantSkillManagement_All_Open(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_SERVANT_MEMO", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventOn_Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All:Servant_Tooltip_Open(key32)
end
function HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(key32, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  local control = UI.getChildControl(content, "StaticText_SkillName")
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantInfo_All_ShowStallionToolTip(isShow, key32)
  if false == isShow or nil == key32 then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
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
function HandleEventScroll_ServantInfo_All_saveScrollPos()
  PaGlobal_ServantInfo_All._currentSkillListData._index = PaGlobal_ServantInfo_All._ui._list2_Skill:getCurrenttoIndex()
  PaGlobal_ServantInfo_All._currentSkillListData._pos = PaGlobal_ServantInfo_All._ui._list2_Skill:GetVScroll():GetControlPos()
end
function HandleEventOut_ServantInfo_All_SkillTooltipClose()
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
end
function PaGlobalFunc_ServantInfo_All_IsSkillBgShow()
  return PaGlobal_ServantInfo_All._ui._stc_SkillBg:GetShow()
end
function HandleEventLUp_ServantInfo_All_OpenEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  PaGlobal_ServantInfo_All._startInvenSlotIndex = 0
  PaGlobal_ServantInfo_All._ui._scroll_vertical:SetControlTop()
  PaGlobal_ServantInfo_All:switchEquipInvenConsoleUI(_ContentsGroup_UsePadSnapping)
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(true)
end
function HandleEventLUp_ServantInfo_All_PrepareOpenEquipInven()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = true
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoInventoryOpen, PaGlobal_ServantInfo_All._isShowInventory, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  HandleEventLUp_ServantInfo_All_OpenEquipInven()
end
function HandleEventLUp_ServantInfo_All_ToggleEquipInven()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = not PaGlobal_ServantInfo_All._isShowInventory
  if true == PaGlobal_ServantInfo_All._isShowInventory then
    HandleEventLUp_ServantInfo_All_PrepareOpenEquipInven()
  else
    HandleEventLUp_ServantInfo_All_CloseEquipInven()
  end
end
function HandleEventLUp_ServantInfo_All_CloseEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if false == PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = false
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoInventoryOpen, PaGlobal_ServantInfo_All._isShowInventory, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(false)
end
function HandlerEventScroll_ServantInfo_All_InventoryScroll(isUp)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local prevSlotIndex = PaGlobal_ServantInfo_All._startInvenSlotIndex
  local config = PaGlobal_ServantInfo_All._INVENTORY_CONFIG
  PaGlobal_ServantInfo_All._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_ServantInfo_All._ui._scroll_vertical, isUp, config.row, config.contentsCount, PaGlobal_ServantInfo_All._startInvenSlotIndex, config.col)
  if prevSlotIndex ~= PaGlobal_ServantInfo_All._startInvenSlotIndex then
    if true == _ContentsGroup_RenewUI_Tooltip then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    PaGlobal_ServantInfo_All:updateInvenSlot()
  end
end
function HandleEventOn_ServantInfo_All_EquipToolTip(equipNo, isOn)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil == PaGlobalFunc_TooltipInfo_GetShow then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Close then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Open then
      return
    end
    if nil == PaGlobalFunc_FloatingTooltip_Close then
      return
    end
  else
    if nil == Panel_Tooltup_Item_isShow then
      return
    end
    if nil == Panel_Tooltip_Item_hideTooltip then
      return
    end
    if nil == Panel_Tooltip_Item_Show then
      return
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isOn then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg
  if nil == control then
    return
  end
  local itemWrapper = PaGlobal_ServantInfo_All._currentServantInfo:getEquipItem(equipNo)
  if nil == itemWrapper then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true)
  end
end
function HandleEventOn_ServantInfo_All_EquipInvenToolTip(itemEnchantKeyRaw, isOn)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil == PaGlobalFunc_TooltipInfo_GetShow then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Close then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Open then
      return
    end
    if nil == PaGlobalFunc_FloatingTooltip_Close then
      return
    end
  else
    if nil == Panel_Tooltup_Item_isShow then
      return
    end
    if nil == Panel_Tooltip_Item_hideTooltip then
      return
    end
    if nil == Panel_Tooltip_Item_Show then
      return
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isOn then
    return
  end
  if nil == itemEnchantKeyRaw then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg
  if nil == control then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function HandleEventOn_ServantInfo_All_GetActorKeyRaw()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  return PaGlobal_ServantInfo_All._currentServantInfo:getActorKeyRaw()
end
function HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(isShow, stat)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_OnlySpeed
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
function HandleEventOnOut_ServantInfo_All_SnappingSkill(isOn, key32)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if false == PaGlobal_ServantInfo_All._isConsole then
    return
  end
  if nil == key32 or nil == isOn or false == isOn then
    HandleEventOut_ServantInfo_All_SkillTooltipClose()
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    PaGlobal_ServantInfo_All._ui._stc_ConsoleKeyGuideY:SetShow(false)
  else
    PaGlobal_ServantInfo_All._selectSkillIndex = key32
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_ServantInfo_All_ShowSkillTooltipByPad()")
    PaGlobal_ServantInfo_All._ui._stc_ConsoleKeyGuideY:SetShow(true)
  end
  PaGlobal_ServantInfo_All:setKeyguide()
end
function HandleEventOnOut_ServantInfo_All_ShowSkillTooltipByPad()
  if false == PaGlobal_ServantInfo_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_GetShow and true == PaGlobal_Tooltip_Skill_Servant_All_GetShow() then
      HandleEventOut_ServantInfo_All_SkillTooltipClose()
    else
      HandleEventOn_Servant_Tooltip_Open(PaGlobal_ServantInfo_All._selectSkillIndex)
    end
  elseif nil ~= Panel_Tooltip_Skill_Servant and true == Panel_Tooltip_Skill_Servant:GetShow() then
    HandleEventOut_ServantInfo_All_SkillTooltipClose()
  else
    HandleEventOn_Servant_Tooltip_Open(PaGlobal_ServantInfo_All._selectSkillIndex)
  end
end
function FromClient_LoadCompleteServantSimpleItem(servantNo)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:clearInventory()
  if nil == servantNo or 0 == servantNo or servantNo ~= PaGlobal_ServantInfo_All._currentVehicleNo then
    return
  end
  local simpleInvenWrapper = ToClient_SimpleServantInventoryWrapper(servantNo)
  if nil == simpleInvenWrapper then
    return
  end
  PaGlobal_ServantInfo_All._currentServantInventory = simpleInvenWrapper
  PaGlobal_ServantInfo_All:updateInventory()
end
