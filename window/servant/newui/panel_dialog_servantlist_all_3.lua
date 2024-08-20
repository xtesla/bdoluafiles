function FromClient_ServantList_All_OnScreenReSize()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantList_All:ComputePos()
end
function FromClient_ServantList_All_UpdateVehicleList()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if true == _ContentsGroup_ServantFantasyMix and nil ~= PaGlobalFunc_ServantExchange_Fantasy_All_isFantasyMixDoing and true == PaGlobalFunc_ServantExchange_Fantasy_All_isFantasyMixDoing() then
    return
  end
  PaGlobal_ServantList_All:dataClear()
  PaGlobal_ServantList_All:update()
  if nil ~= Panel_IngameCashShop_EasyPayment and true == Panel_IngameCashShop_EasyPayment:GetShow() then
    PaGlobal_EasyBuy:Close()
  end
  if nil == PaGlobal_ServantList_All._selectSlotNo or -1 == PaGlobal_ServantList_All._selectSlotNo then
    local sortedSlotNo = PaGlobal_ServantList_All:stableList_GetSlotNoByServentNo(PaGlobal_ServantList_All.sealMyServantNo)
    PaGlobalFunc_ServantInfo_All_Open(sortedSlotNo)
  else
    local sortedSlotNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
    PaGlobalFunc_ServantInfo_All_Open(sortedSlotNo)
  end
  PaGlobal_ServantList_All:subMenuClose(false)
  if true == Panel_Dialog_ServantTransferList_All:GetShow() then
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  if true == Panel_Window_SimpleStableList_All:GetShow() then
    PaGlobalFunc_ServantTransferBackwardList_All_Close()
  end
  if nil ~= PaGlobalFunc_ServantInfo_All_CheckHaveRegistrableVehicle and nil ~= PaGlobalFunc_ServantInfo_All_setRegistButton then
    local isHaveRegistrableVehicle = PaGlobalFunc_ServantInfo_All_CheckHaveRegistrableVehicle()
    PaGlobalFunc_ServantInfo_All_setRegistButton(isHaveRegistrableVehicle)
  end
end
function FromClient_ServantList_All_Servant_SealFinish(servantNo, regionKey, servantWhereType)
  if false == Panel_Dialog_ServantList_All:GetShow() or nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
  if nil == servantInfo then
    return
  end
  PaGlobal_ServantList_All:dataClear()
  PaGlobal_ServantList_All:update()
  FGlobal_Window_Servant_ColorBlindUpdate()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GIVE_SERVANT_ACK"))
  FGlobal_Window_Servant_Update()
end
function FromClient_ServantList_All_Servant_UnSealFinish(servantNo, servantWhereType)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  if true == Panel_Dialog_ServantList_All:GetShow() then
    local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
    if nil == servantInfo then
      return
    end
    PaGlobal_ServantList_All:dataClear()
    PaGlobal_ServantList_All._currentSealType = PaGlobal_ServantList_All._ENUM_TYPEUNSEALED
    PaGlobal_ServantList_All:update()
    FGlobal_Window_Servant_ColorBlindUpdate()
    if Panel_Dialog_ServantList_All:GetShow() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GET_SERVANT_ACK"))
    end
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if true == _ContentsGroup_OceanCurrent and nil ~= shipStaticStatus and 0 < shipStaticStatus:getEmployeeMaxCost() then
      local foodRate = getMpToServantInfo(servantInfo) / getMaxMpToServantInfo(servantInfo) * 100
      if foodRate < 20 then
        local messageboxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
        local messageboxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPTUTORIALQUEST_AFTER_NEEDFOOD")
        local messageboxData = {
          title = messageboxTitle,
          content = messageboxMemo,
          functionApply = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      end
    end
  end
  FGlobal_Window_Servant_Update()
end
function FromClient_ServantList_All_ServantToReward(servantWhereType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(self._selectSceneIndex)
  if true == PaGlobal_ServantList_All._SellCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SELL_SERVANT_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_LOOSE_SERVANT_ACK"))
  end
end
function FromClient_ServantList_All_Servant_RecoveryFinish(servantNo, servantWhereType)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo, servantWhereType)
  if nil == servantInfo then
    return
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Horse or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Camel or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Donkey or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_MountainGoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_RECOVERY_ACK"))
  elseif servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Carriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Boat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_CowCarriage or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Raft or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_FishingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_SailingBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_PersonalBoat or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_PersonTradeShip or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_PersonalBattleShip or servantInfo:getVehicleType() == CppEnums.VehicleType.Type_RepairableCarriage then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REPAIR_ACK"))
  end
end
function FromClient_ServantList_All_Servant_NameChangeFinish(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_CHANGENAME_ACK"))
end
function FromClient_ServantList_All_RegisteringFinish(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REGISTMARKET_ACK"))
end
function FromClient_ServantList_All_CancelRegisterFinish(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_REGISTMARKETCANCEL_ACK"))
end
function FromClient_ServantList_All_RecieveMarketFinish(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_GETREGISTMARKET_ACK"))
end
function FromClient_ServantList_All_BuyingServantFinish(doRemove, goodsType)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  if nil == doRemove then
    return
  end
  if goodsType < 8 then
    if doRemove then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SELL_SERVANT_ACK"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_MARKETBUY_ACK"))
    end
  elseif goodsType == 8 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RENT_SERVANT_ACK"))
  elseif goodsType == 9 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RETURN_SERVANT_ACK"))
  end
end
function FromClient_ServantList_All_StartMatingMarket(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_MATINGSTART_ACK"))
end
function FromClient_ServantList_All_Recieve_MatingMarket(servantNo)
  if nil == Panel_Dialog_ServantList_All then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_GETCOLT_ACK"))
end
function FromClient_ServantList_All_Reset_DeadCountFinish(servantNo, isOceanShip)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if true == isOceanShip then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_KILLCOUNTRESET_ACK"))
  end
end
function FromClient_ServantList_All_Success_Imprint(servantNo, isImprint)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  if true == isImprint then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_STAMPING_ACK"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_ISIMPRINT_ACK"))
  end
end
function FromClient_ServantList_All_Reset_MatingCountFinish(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_MATINGCOUNTRESET_ACK"))
end
function FromClient_ServantList_All_LinkFinish(horseNo, carriageNo, isLinkSuccess)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:dataClear()
  PaGlobal_ServantList_All:update()
  local horseInfo = stable_getServantByServantNo(horseNo)
  local carriageInfo = stable_getServantByServantNo(carriageNo)
  if isLinkSuccess then
    if nil == horseInfo or nil == carriageInfo then
      return
    end
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_LINK", "carriageName", stable_getServantByServantNo(carriageNo):getName(), "horseName", stable_getServantByServantNo(horseNo):getName()))
  else
    if nil == horseInfo then
      return
    end
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_SERVANT_UNLINK", "horseName", stable_getServantByServantNo(horseNo):getName()))
  end
  if nil ~= Panel_Dialog_ServantCarriageLink_All and true == Panel_Dialog_ServantCarriageLink_All:GetShow() then
    PaGlobalFunc_ServantCarriageLink_All_UpdateCarriage()
  end
end
function FromClient_ServantList_All_StartSkillTraining(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINSTART", "servantName", servantInfo:getName()))
end
function FromClient_ServantList_All_EndSkillTraining(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINEND", "servantName", servantInfo:getName()))
end
function FromClient_ServantList_All_StartStallionTraining(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  if not PaGlobal_ServantList_All._contentsOption._isContentsStallionEnable or not PaGlobal_ServantList_All._contentsOption._isContentsNineTierEnable or not PaGlobal_ServantList_All._contentsOption._isContentsNineTierTraining then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  if nil ~= Panel_Dialog_ServantSwiftTraining_All then
    PaGlobalFunc_ServantSwiftTraining_All_Open(servantNo)
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINSTART", "servantName", servantInfo:getName()))
end
function FromClient_ServantList_All_EndStallionTraining(servantNo)
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  PaGlobal_ServantList_All:subMenuClose(false)
  audioPostEvent_SystemUi(0, 0)
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  PaGlobal_ServantList_All:update()
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TRAINEND", "servantName", servantInfo:getName()))
end
function FromClient_ServantList_All_ChangeRegion()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "LUA_SERVANT_CHANGE_REGION_ACK_DESC"))
  if true == Panel_Dialog_ServantTransferList_All:GetShow() then
    PaGlobalFunc_ServantTransferList_All_Close()
  end
  PaGlobal_ServantList_All:dataClear()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantList_All_PopFailedMessage()
  if nil == Panel_Dialog_ServantList_All or false == Panel_Dialog_ServantList_All:GetShow() then
    return
  end
  local stringText = convertStringFromDatetime(possibleTime_s64)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLELIST_POPMSGBOX_MEMO", "stringText", stringText)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_ServantList_All_PopServantToWorldMarket(servantKeyRaw, npcActorKeyRaw)
  ToClient_PushServantByName(servantKeyRaw, npcActorKeyRaw, "\235\167\144\235\147\164\236\150\180\234\176\145\235\139\136\235\139\164")
end
function FromClient_ServantList_All_RegistServantSuccess()
  PaGlobal_ServantList_All._selectSlotNo = 0
  PaGlobalFunc_ServantNameRegist_All_SetCurrentServantCount()
  PaGlobalFunc_ServantNameRegist_All_BeginnerMessage()
end
