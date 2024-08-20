function PaGlobalFunc_ServantTransferBackwardList_All_Open(regionKey)
  if nil == Panel_Window_SimpleStableList_All then
    return
  end
  if true == Panel_Window_SimpleStableList_All:GetShow() then
    PaGlobalFunc_ServantTransferBackwardList_All_Close()
  end
  PaGlobal_ServantTransferBackwardList_All:prepareOpen(regionKey)
end
function PaGlobalFunc_ServantTransferBackwardList_All_Close()
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferBackwardList_All:prepareClose()
end
function PaGlobalFunc_ServantTransferBackwardList_All_OnScreenResize()
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  Panel_Window_SimpleStableList_All:ComputePos()
end
function PaGlobalFunc_ServantTransferBackwardList_All_List2Update(content, key)
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferBackwardList_All:list2Update(content, key)
end
function PaGlobalFunc_ServantTransferBackwardList_All_Transfer(servantIndex, fromRegeionKey, isHorse)
  if nil == Panel_Window_SimpleStableList_All or false == Panel_Window_SimpleStableList_All:GetShow() then
    return
  end
  if nil == fromRegeionKey then
    return
  end
  if nil == getRegionInfoWrapper(fromRegeionKey) then
    return
  end
  local seravntList = PaGlobal_ServantTransferList_All._transBackWordList[fromRegeionKey]
  if servantIndex < 1 or servantIndex > #seravntList then
    return
  end
  local function TransferConfirm()
    local moneyWhereType = MessageBoxCheck.isCheck()
    ToClient_TransportBackward(seravntList[servantIndex], fromRegeionKey, moneyWhereType)
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  local cost = Int64toInt32(ToClient_GetCostToVehicleTransportBackward())
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVE_BACKWARD_TITLE")
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_CHANGE_REGION_BAKCWARD_NOTIFY_DESC", "cost", makeDotMoney(cost))
  if true == isHorse then
    _desc = _desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEMOVE_GROUND")
  elseif true == _ContentsGroup_Barter then
    _desc = _desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEMOVE_SHIP")
  else
    _desc = _desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEMOVE_SHIP_CS")
  end
  local _confirmFunction = TransferConfirm
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionApply = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority
  }
  MessageBox.showMessageBox(messageboxData)
end
