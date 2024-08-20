function PaGlobalFunc_Servant_FantasySelect_All_Open(isMale)
  if nil == Panel_Dialog_Servant_FantasySelect_All or true == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  PaGlobal_Servant_FantasySelect_All:prepareOpen(isMale)
end
function PaGlobalFunc_Servant_FantasySelect_All_Close()
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  PaGlobal_Servant_FantasySelect_All:prepareClose()
end
function HandleEventLUp_Servant_FantasySelect_All_SelectServantData(dataIdx)
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if nil == dataIdx or nil == PaGlobal_Servant_FantasySelect_All._servantDataTable then
    return
  end
  local servantData = PaGlobal_Servant_FantasySelect_All._servantDataTable[dataIdx]
  if nil == servantData then
    return
  end
  PaGlobal_Servant_FantasySelect_All._selectServantData = servantData
end
function HandleEventLUp_Servant_FantasySelect_All_Confirm()
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if nil == PaGlobal_Servant_FantasySelect_All._selectServantData then
    return
  end
  local servantNo = PaGlobal_Servant_FantasySelect_All._selectServantData._servantNo
  if nil == servantNo then
    return
  end
  if nil ~= PaGlobalFunc_ServantExchange_Fantasy_All_SetFantasyServant then
    PaGlobalFunc_ServantExchange_Fantasy_All_SetFantasyServant(PaGlobal_Servant_FantasySelect_All._isMale, servantNo)
  end
  PaGlobal_Servant_FantasySelect_All:prepareClose()
end
function FromClient_Servant_FantasySelect_All_List2Update(content, key)
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  if false == _ContentsGroup_ServantFantasyMix then
    return
  end
  PaGlobal_Servant_FantasySelect_All:list2Update(content, key)
end
function FromClient_Servant_FantasySelect_All_OnScreenResize()
  if nil == Panel_Dialog_Servant_FantasySelect_All or false == Panel_Dialog_Servant_FantasySelect_All:GetShow() then
    return
  end
  Panel_Dialog_Servant_FantasySelect_All:ComputePos()
end
