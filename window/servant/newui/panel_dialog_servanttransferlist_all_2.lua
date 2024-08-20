function PaGlobalFunc_ServantTransferList_All_Open()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:prepareOpen()
end
function PaGlobalFunc_ServantTransferBackwardRegionList_All_Open()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:backwardPrepareOpen()
end
function PaGlobalFunc_ServantTransferList_All_OpenFromWorldmap(servantNo)
  if nil == Panel_Dialog_ServantTransferList_All then
    return
  end
  if false == _ContentsGroup_TotalStableList then
    return
  end
  if true == Panel_Dialog_ServantTransferList_All:GetShow() then
    WorldMapPopupManager:pop()
    PaGlobal_ServantTransferList_All:prepareClose()
    return
  end
  PaGlobal_ServantTransferList_All:PrepareOpenFromWorldmap(servantNo)
end
function PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap()
  if nil == Panel_Dialog_ServantTransferList_All then
    return
  end
  if false == _ContentsGroup_TotalStableList then
    return
  end
  if true == Panel_Dialog_ServantTransferList_All:GetShow() then
    WorldMapPopupManager:pop()
    PaGlobal_ServantTransferList_All:prepareClose()
  end
end
function PaGlobalFunc_ServantTransferList_All_GetShow()
  if nil == Panel_Dialog_ServantTransferList_All then
    return false
  end
  return Panel_Dialog_ServantTransferList_All:GetShow()
end
function PaGlobalFunc_ServantTransferList_All_Close()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:prepareClose()
  PaGlobalFunc_ServantTransferBackwardList_All_Close()
end
function FromClient_ServantTransferList_All_OnScreenResize()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantTransferList_All:ComputePos()
end
function FromClient_ServantTransferList_All_List2Update(content, key)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  PaGlobal_ServantTransferList_All:list2Update(content, key)
end
function HandleEventLUp_ServantTransferList_All_Transfer(regeionKey)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == regeionKey then
    return
  end
  if nil == getRegionInfoWrapper(regeionKey) then
    return
  end
  local servantNo
  if true == PaGlobal_ServantTransferList_All._isWorldMapOpen then
    if false == _ContentsGroup_TotalStableList then
      return
    end
    servantNo = PaGlobal_ServantTransferList_All._servantNo
    if nil == servantNo then
      return
    end
    local servantInfo = stable_getServantByServantNo(servantNo)
    if nil == servantInfo then
      return
    end
  else
    if nil ~= Panel_Dialog_ServantList_All then
      PaGlobalFunc_ServantList_All_SubMenuClose()
    end
    local sortedNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
    if nil == sortedNo then
      return
    end
    local servantInfo = stable_getServant(sortedNo)
    if nil == servantInfo then
      return
    end
    servantNo = servantInfo:getServantNo()
  end
  if nil == servantNo then
    return
  end
  local function TransferConfirm()
    local moneyWhereType = MessageBoxCheck.isCheck()
    ToClient_ChangeServantRegion(servantNo, regeionKey, moneyWhereType)
    if true == PaGlobal_ServantTransferList_All._isWorldMapOpen then
      PaGlobalFunc_ServantTransferList_All_CloseFromWorldmap()
    else
      PaGlobalFunc_ServantTransferList_All_Close()
    end
  end
  local cost = ToClient_GetCostToChangeServantRegion()
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE")
  PaGlobal_ServantTransferList_All._currentTitle = title
  local _desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_CHANGE_REGION_NOTIFY_DESC", "cost", cost)
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
