function PaGlobalFunc_ServantExchange_Fantasy_All_Open()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or true == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All:prepareOpen()
end
function PaGlobalFunc_ServantExchange_Fantasy_All_Close()
  if nil ~= PaGlobalFunc_Servant_FantasySelect_All_Close then
    PaGlobalFunc_Servant_FantasySelect_All_Close()
  end
  if true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All:prepareClose()
end
function PaGlobalFunc_ServantExchange_Fantasy_All_isFantasyMixDoing()
  return PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing
end
function PaGlobalFunc_ServantExchange_Fantasy_All_OpenVirtualKeyboard()
  SetFocusEdit(PaGlobal_ServantExchange_Fantasy_All._ui._edit_Naming)
end
function PaGlobalFunc_ServantExchange_Fantasy_All_SetFantasyServant(isMale, servantNo)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  if true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    return
  end
  if true == isMale then
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Left = servantNo
  else
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Right = servantNo
  end
  PaGlobal_ServantExchange_Fantasy_All:update()
end
function PaGlobalFunc_ServantExchange_Fantasy_All_UpdateEffect(deltaTime)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All._elapsedTime = PaGlobal_ServantExchange_Fantasy_All._elapsedTime + deltaTime
  if false == Panel_Dialog_ServantSwiftResult_All:GetShow() and nil ~= PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow then
    PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(true)
  end
  if 0 == PaGlobal_ServantExchange_Fantasy_All._effectType then
    PaGlobal_ServantExchange_Fantasy_All._effectType = 1
    audioPostEvent_SystemUi(13, 25)
    _AudioPostEvent_SystemUiForXBOX(13, 20)
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(PaGlobal_ServantExchange_Fantasy_All._itemSlot.icon, 14, 0, 0)
  elseif 1 == PaGlobal_ServantExchange_Fantasy_All._effectType and PaGlobal_ServantExchange_Fantasy_All._elapsedTime > 2 then
    PaGlobal_ServantExchange_Fantasy_All._effectType = 2
    if true == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
      Panel_Dialog_ServantExchange_Fantasy_All:SetShow(false)
    end
    PaGlobal_ServantExchange_Fantasy_All:clearNeedItemCount()
    PaGlobalFunc_ServantSwiftResult_All_fantasyMixEffect(0)
  elseif 2 == PaGlobal_ServantExchange_Fantasy_All._effectType and PaGlobal_ServantExchange_Fantasy_All._elapsedTime > 6 then
    PaGlobal_ServantExchange_Fantasy_All._effectType = 3
    if nil ~= PaGlobal_ServantExchange_Fantasy_All._resultCharacterKey and nil ~= PaGlobal_ServantExchange_Fantasy_All._servantNo_Result then
      PaGlobalFunc_ServantSwiftResult_All_fantasyMixEffect(1, PaGlobal_ServantExchange_Fantasy_All._resultCharacterKey)
      audioPostEvent_SystemUi(13, 21)
      _AudioPostEvent_SystemUiForXBOX(13, 25)
      if true == PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._setData and nil ~= FromClient_notifyGetItem then
        PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._setData = false
        FromClient_notifyGetItem(PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._notifyType, PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._playerName, PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._fromName, PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._iconPath, PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._param1, nil, nil)
      end
    else
      PaGlobalFunc_ServantSwiftResult_All_fantasyMixEffect(2)
      audioPostEvent_SystemUi(13, 22)
      _AudioPostEvent_SystemUiForXBOX(13, 22)
    end
    PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing = false
    ToClient_servantListUpdate()
  elseif 3 == PaGlobal_ServantExchange_Fantasy_All._effectType and PaGlobal_ServantExchange_Fantasy_All._elapsedTime > 8.5 then
    PaGlobal_ServantExchange_Fantasy_All._effectType = 4
    if nil ~= PaGlobal_ServantExchange_Fantasy_All._servantNo_Result then
      PaGlobalFunc_ServantList_All_CharacterSceneResetServantNo(PaGlobal_ServantExchange_Fantasy_All._servantNo_Result)
    end
    PaGlobalFunc_ServantExchange_Fantasy_All_Close()
  end
end
function HandleEventLUp_ServantExchange_Fantasy_All_EditClick()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All._ui._edit_Naming:SetEditText("")
end
function HandleEventOnOut_ServantExchange_Fantasy_All_NeedItemToolTip(isShow)
  if false == isShow or true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = ToClient_getFantasyMixNeedItem()
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_ServantExchange_Fantasy_All._ui._stc_ItemSlotBg
  if nil == control then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, control, true, false, nil, nil, nil)
end
function HandleEventLUp_ServantExchange_Fantasy_All_ItemSet_NumPadOn()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if true == Panel_NumberPad_IsPopUp then
    Panel_NumberPad_Close()
  end
  if true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local fantasyMixNeedItemWrapper = ToClient_getFantasyMixNeedItem()
  if nil == fantasyMixNeedItemWrapper then
    return
  end
  local needItemKey = fantasyMixNeedItemWrapper:get()._key:getItemKey()
  if nil == needItemKey then
    return
  end
  local fromItemWhereType = CppEnums.ItemWhereType.eInventory
  local fromItemSlotNo = __eTInventorySlotNoUndefined
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:getInventorySlotCount(false)
  local needItemCount = 0
  local needItemWrapper
  for index = useStartSlot, invenUseSize - 1 do
    local itemWrapper = getInventoryItemByType(fromItemWhereType, index)
    if nil ~= itemWrapper then
      local invenItemSSW = itemWrapper:getStaticStatus()
      if needItemKey == invenItemSSW:get()._key:getItemKey() then
        needItemWrapper = itemWrapper
        needItemCount = itemWrapper:getCount()
        fromItemSlotNo = index
        break
      end
    end
  end
  if __eTInventorySlotNoUndefined ~= fromItemSlotNo and nil ~= needItemWrapper then
    local itemMaxCount = ToClient_getFantasyMixNeedItemMaxCount()
    local curItemCount = Int64toInt32(needItemCount)
    if itemMaxCount > curItemCount then
      itemMaxCount = curItemCount
    end
    Panel_NumberPad_Show(true, tonumber64(itemMaxCount), fromItemSlotNo, HandleEventLUp_ServantExchange_Fantasy_All_ItemSetConfirm, nil, fromItemWhereType, nil, nil)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_MATERIAL_COUNT"))
  end
end
function HandleEventLUp_ServantExchange_Fantasy_All_ItemSetConfirm(inputNumber, itemSlotNo, itemWhereType)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    return
  end
  if nil == inputNumber or nil == itemSlotNo or nil == itemWhereType then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, itemSlotNo)
  if nil == itemWrapper then
    return
  end
  local fantasyMixNeedItemWrapper = ToClient_getFantasyMixNeedItem()
  if nil == fantasyMixNeedItemWrapper then
    return
  end
  local fantasyMixNeedItemKey = fantasyMixNeedItemWrapper:get()._key:getItemKey()
  if nil == fantasyMixNeedItemKey then
    return
  end
  local invenItemSSW = itemWrapper:getStaticStatus()
  if fantasyMixNeedItemKey ~= invenItemSSW:get()._key:getItemKey() then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All._needItemInfo._needItemCount = Int64toInt32(inputNumber)
  if PaGlobal_ServantExchange_Fantasy_All._needItemInfo._needItemCount < 1 then
    PaGlobal_ServantExchange_Fantasy_All:clearNeedItemCount()
  else
    PaGlobal_ServantExchange_Fantasy_All._needItemInfo._needItemSlotNo = itemSlotNo
    PaGlobal_ServantExchange_Fantasy_All._itemSlot:setItemByStaticStatus(invenItemSSW, inputNumber)
    PaGlobal_ServantExchange_Fantasy_All._itemSlot.icon:SetMonoTone(false)
    PaGlobal_ServantExchange_Fantasy_All._itemSlot.iconBG:addInputEvent("Mouse_RUp", "PaGlobal_ServantExchange_Fantasy_All:clearNeedItemCount()")
    PaGlobal_ServantExchange_Fantasy_All:exchangeStateUpdate()
  end
end
function HandleEventRUp_ServantExchange_Fantasy_All_ClearSlot(isMale)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  if true == PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing then
    return
  end
  if true == isMale then
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Left = nil
  else
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Right = nil
  end
  PaGlobal_ServantExchange_Fantasy_All:update()
end
function HandleEventLUp_ServantExchange_Fantasy_All_MixConfirm()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All:MixConfirm()
end
function FromClient_ServantExchange_Fantasy_All_ServantExchangeCancle()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All._isFantasyMixDoing = false
end
function FromClient_ServantExchange_Fantasy_All_ServantExchangeFinish(servantNo_Result, resultCharacterKey, isMixSuccess)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  if true == isMixSuccess then
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Result = servantNo_Result
    PaGlobal_ServantExchange_Fantasy_All._resultCharacterKey = resultCharacterKey
  else
    PaGlobal_ServantExchange_Fantasy_All._servantNo_Result = nil
    PaGlobal_ServantExchange_Fantasy_All._resultCharacterKey = nil
  end
  if false == Panel_Dialog_ServantSwiftResult_All:GetShow() then
    PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(true)
  end
  Panel_Dialog_ServantList_All:RegisterUpdateFunc("PaGlobalFunc_ServantExchange_Fantasy_All_UpdateEffect")
end
function FromClient_ServantExchange_Fantasy_All_SetFantasyMixNakData(notifyType, playerName, fromName, iconPath, param1)
  if nil == Panel_Dialog_ServantExchange_Fantasy_All then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  if nil == notifyType or nil == playerName or nil == fromName or nil == iconPath or nil == param1 then
    return
  end
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._setData = true
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._notifyType = notifyType
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._playerName = playerName
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._fromName = fromName
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._iconPath = iconPath
  PaGlobal_ServantExchange_Fantasy_All._fantasyMixNakData._param1 = param1
end
function FromClient_ServantExchange_Fantasy_All_OnScreenResize()
  if nil == Panel_Dialog_ServantExchange_Fantasy_All or false == Panel_Dialog_ServantExchange_Fantasy_All:GetShow() then
    return
  end
  Panel_Dialog_ServantExchange_Fantasy_All:ComputePos()
end
