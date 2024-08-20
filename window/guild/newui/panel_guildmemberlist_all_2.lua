function PaGlobalFunc_GuildMemberList_All_Open()
  PaGlobal_GuildMemberList_All:prepareOpen()
end
function PaGlobalFunc_GuildMemberList_All_Close()
  PaGlobal_GuildMemberList_All:prepareClose()
end
function PaGlobalFunc_GuildMemberList_All_Update()
  PaGlobal_GuildMemberList_All:update()
end
function PaGlobalFunc_GuildMemberList_All_RealIndexInfo()
  return PaGlobal_GuildMemberList_All._memberlistData[PaGlobal_GuildMemberList_All._myGuildIndex + 1].idx
end
function PaGlobalFunc_GuildMemberList_All_AgreementShowDoNotCollect()
  if nil ~= PaGlobal_AgreementGuildMaster_GetShow and true == PaGlobal_AgreementGuildMaster_GetShow() then
    PaGlobal_GuildMemberList_All._ui.btn_getFund:SetIgnore(true)
    PaGlobal_GuildMemberList_All._ui.btn_getFund:SetMonoTone(true)
  else
    PaGlobal_GuildMemberList_All:updateBottomInfo()
  end
end
function PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  return PaGlobal_GuildMemberList_All._selectIndex
end
function PaGlobalFunc_GuildMemberList_All_SetRequestParticipateAtSiege()
  local guildInfo = ToClient_GetMyGuildInfoWrapper()
  local memberInfo = guildInfo:getMember(PaGlobal_GuildMemberList_All._selectIndex)
  if nil == memberInfo then
    _PA_ASSERT(false, "\235\169\164\235\178\132\236\157\184\235\141\177\236\138\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164 " .. tostring(myIndex))
  end
  local bool = memberInfo:isSiegeParticipant()
  ToClient_resquestParticipateSiege(not bool)
end
function PaGlobalFunc_GuildMemberList_All_ReceivePayOpen()
  local myIndex = PaGlobalFunc_GuildMemberList_All_RealIndexInfo()
  local memberInfo = ToClient_GetMyGuildInfoWrapper():getMember(myIndex)
  if nil == memberInfo then
    _PA_ASSERT(false, "\235\169\164\235\178\132\236\157\184\235\141\177\236\138\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164 " .. tostring(myIndex))
  end
  PaGlobal_GuildMemberList_All._dailyPayWhereType = nil
  local GetPayExecute = function()
    PaGlobal_GuildMemberList_All._dailyPayWhereType = MessageBoxCheck.isCheck()
    if PaGlobal_GuildMemberList_All._dailyPayWhereType == CppEnums.ItemWhereType.eInventory then
      ToClient_TakeMyGuildBenefit(false)
    elseif PaGlobal_GuildMemberList_All._dailyPayWhereType == CppEnums.ItemWhereType.eWarehouse then
      ToClient_TakeMyGuildBenefit(true)
    end
  end
  local memberBenefit = memberInfo:getContractedBenefit()
  local messageboxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_GETDAILYPAY_DAIYPAY", "money", makeDotMoney(memberBenefit))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GETDAILYPAY_TITLE"),
    content = messageboxMemo,
    functionApply = GetPayExecute,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBoxCheck.showMessageBoxForRegion(messageboxData)
end
function PaGlobalFunc_GuildMemberList_All_IsReceivePayWareHouse()
  if CppEnums.ItemWhereType.eWarehouse == PaGlobal_GuildMemberList_All._dailyPayWhereType then
    return true
  else
    return false
  end
end
function FromClient_GuildMemberList_All_ResponseGuildMasterChange(userNo, targetNo)
  local userNum = Int64toInt32(getSelfPlayer():get():getUserNo())
  if userNum == Int64toInt32(userNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MASTERCHANGE_MESSAGE_0"))
  elseif userNum == Int64toInt32(targetNo) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MASTERCHANGE_MESSAGE_1"))
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_RequestChangeGuildMemberGrade(grade)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil ~= guildWrapper then
    local guildGrade = guildWrapper:getGuildGrade()
    if 0 ~= guildGrade then
      if __eGuildMemberGradeSubMaster == grade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_2"))
      elseif __eGuildMemberGradeNormal == grade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_3"))
      elseif __eGuildMemberGradeSupplyOfficer == grade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_4"))
      elseif __eGuildMemberGradeAdviser == grade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_5"))
      elseif __eGuildMemberGradeGunner == grade then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_6"))
      end
    elseif __eGuildMemberGradeSubMaster == grade then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CLAN_GRADECHANGE_MESSAGE_2"))
    elseif __eGuildMemberGradeNormal == grade then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CLAN_GRADECHANGE_MESSAGE_3"))
    end
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_ResponseChangeGuildMemberGrade(requestorNo, targetNo, grade, beforeGrade)
  local userNum = Int64toInt32(getSelfPlayer():get():getUserNo())
  local requestorNo = Int64toInt32(requestorNo)
  if userNum == requestorNo then
    FromClient_GuildMemberList_All_RequestChangeGuildMemberGrade(grade)
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local beforeGradeStr, gradeStr, msg
  if nil ~= guildWrapper then
    local guildGrade = guildWrapper:getGuildGrade()
    if 0 ~= guildGrade then
      if userNum == Int64toInt32(targetNo) then
        if __eGuildMemberGradeSubMaster == grade then
          msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_0")
          gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_01")
        elseif __eGuildMemberGradeNormal == grade then
          msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_1")
          gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_02")
        elseif __eGuildMemberGradeSupplyOfficer == grade then
          msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SUPPLYOFFICER_APPOINTMENT_DO")
          gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_03")
        elseif __eGuildMemberGradeAdviser == grade then
          msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_7")
          gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_05")
        elseif __eGuildMemberGradeGunner == grade then
          msg = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GRADECHANGE_MESSAGE_8")
          gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_06")
        end
        if __eGuildMemberGradeSubMaster == beforeGrade then
          beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_01")
        elseif __eGuildMemberGradeNormal == beforeGrade then
          beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_02")
        elseif __eGuildMemberGradeSupplyOfficer == beforeGrade then
          beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_03")
        elseif __eGuildMemberGradeAdviser == beforeGrade then
          beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_05")
        elseif __eGuildMemberGradeGunner == beforeGrade then
          beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_06")
        end
      end
    elseif userNum == Int64toInt32(targetNo) then
      if __eGuildMemberGradeSubMaster == grade then
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_CLAN_GRADECHANGE_MESSAGE_4")
        gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_01")
      elseif __eGuildMemberGradeNormal == grade then
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_CLAN_GRADECHANGE_MESSAGE_5")
        gradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_CLAN_MEMBER_GRADE_MESSAGE_01")
      end
      if __eGuildMemberGradeSubMaster == beforeGrade then
        beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_GUILD_MEMBER_GRADE_MESSAGE_01")
      elseif __eGuildMemberGradeNormal == beforeGrade then
        beforeGradeStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_CLAN_MEMBER_GRADE_MESSAGE_01")
      end
    end
  end
  if nil ~= gradeStr and nil ~= beforeGradeStr then
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CHANGE_MEMBER_GRADE_MESSAGE", "beforeGradeStr", beforeGradeStr, "gradeStr", gradeStr))
  elseif nil ~= msg then
    Proc_ShowMessage_Ack(msg)
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_RequestExpelMemberFromGuild()
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_ResponseChangeProtectGuildMember(targetNo, isProtectable)
  local userNum = Int64toInt32(getSelfPlayer():get():getUserNo())
  if userNum == Int64toInt32(targetNo) then
    if true == isProtectable then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECT_GUILDMEMBER_MESSAGE_0"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECT_GUILDMEMBER_MESSAGE_1"))
    end
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_ChangedSiegeGrade(isNotify, userName, grade)
  if true == isNotify then
    local str = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_SETTING_TOOLTIP", "userName", userName, "grade", tostring(6 - grade))
    Proc_ShowMessage_Ack(str)
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_ResponseParticipateSiege(isParticipant, isSelf)
  if true == isSelf then
    if true == isParticipant then
      if true == _ContentsGroup_majorSiegeParticipate then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NAKMESSAGE_PARTICIPANT_NEW"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NAKMESSAGE_PARTICIPANT"))
      end
    elseif true == _ContentsGroup_majorSiegeParticipate then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NAKMESSAGE_NONPARTICIPANT_NEW"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_NAKMESSAGE_NONPARTICIPANT"))
    end
  end
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_ResponseTakableSiegeReward()
  PaGlobal_GuildMemberList_All:update()
end
function FromClient_GuildMemberList_All_UpdateMemberList(userNo)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  PaGlobal_GuildMemberList_All:updateVoiceDataByUserNo(userNo)
end
function HandleEventOnOut_GuildMemeberList_All_TitleTooltip(isShow, titleType)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local control, name, desc
  local control = PaGlobal_GuildMemberList_All._ui._titlelist[titleType]
  if PaGlobal_GuildMemberList_All._SortType.APOINT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_ACTIVITY_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_ACTIVITY_CONTENTS")
  elseif PaGlobal_GuildMemberList_All._SortType.CONTACT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_CONTENTS")
  elseif PaGlobal_GuildMemberList_All._SortType.WPOINT == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_CONTRIBUTEDTENDENCY_TOOLTIP_DESC")
  elseif PaGlobal_GuildMemberList_All._SortType.VOICE == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHAT_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHAT_TOOLTIP_DESC")
  elseif PaGlobal_GuildMemberList_All._SortType.WGRADE == titleType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_NAME")
    local descStr = "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_DESC"
    if true == _ContentsGroup_SiegeAngerSystem then
      descStr = "LUA_GUILD_LIST_SIEGEGRADE_TOOLTIP_DESC_NEW"
    end
    desc = PAGetStringParam4(Defines.StringSheet_GAME, descStr, "grade1", tostring(PaGlobal_GuildMemberList_All._siegeGradeCount.grade1), "grade2", tostring(PaGlobal_GuildMemberList_All._siegeGradeCount.grade2), "grade3", tostring(PaGlobal_GuildMemberList_All._siegeGradeCount.grade3), "grade4", tostring(PaGlobal_GuildMemberList_All._siegeGradeCount.grade4))
  end
  if nil == control or nil == name or nil == desc then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMemeberList_All_ContractTooltip(isShow, titleType, controlIdx)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[controlIdx + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local channelName = getChannelName(worldNo, myGuildMemberInfo:getServerNo())
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local memberChannel = ""
  local lastLogin = ""
  if true == myGuildMemberInfo:isOnline() and false == myGuildMemberInfo:isGhostMode() then
    lastLogin = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ONLINE_MEMBER")
    memberChannel = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_CHANNEL_MEMBER", "channelName", channelName)
  else
    lastLogin = PaGlobal_GuildMemberList_All:getGuildLogOutTimeConvert(myGuildMemberInfo:getElapsedTimeAfterLogOut_s64())
    memberChannel = ""
  end
  if PaGlobal_GuildMemberList_All._ContractType.recontactable == titleType then
    control = PaGlobal_GuildMemberList_All._ui._memberlist[controlIdx]._contractBtn
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_TITLETYPE5_DESC") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LASTLOGOUT", "lastLogin", lastLogin) .. memberChannel
  elseif PaGlobal_GuildMemberList_All._ContractType.contacting == titleType then
    control = PaGlobal_GuildMemberList_All._ui._memberlist[controlIdx]._contractBtn
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_TITLETYPE3_DESC") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LASTLOGOUT", "lastLogin", lastLogin) .. memberChannel
  elseif PaGlobal_GuildMemberList_All._ContractType.expiration == titleType then
    control = PaGlobal_GuildMemberList_All._ui._memberlist[controlIdx]._contractBtn
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDLIST_CONTRACT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_TITLETYPE4_DESC") .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LASTLOGOUT", "lastLogin", lastLogin) .. memberChannel
  end
  local memberIsLimit = myGuildMemberInfo:getIsPriceLimit()
  local memberIsGrade = myGuildMemberInfo:getGrade()
  if true == myGuildMemberInfo:isSelf() and memberIsGrade > 0 then
    if true == memberIsLimit then
      desc = desc .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE", "limitprice", makeDotMoney(myGuildMemberInfo:getPriceLimit()))
    else
      desc = desc .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE", "limitprice", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE_NO"))
    end
  elseif isGuildMaster and memberIsGrade > 0 then
    if true == memberIsLimit then
      desc = desc .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICEOTHER", "limitprice", makeDotMoney(myGuildMemberInfo:getPriceLimit()))
    else
      desc = desc .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICEOTHER", "limitprice", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE_NO"))
    end
  end
  local guildMemberGradeType = myGuildMemberInfo:getGrade()
  if __eGuildMemberGradeJunior == guildMemberGradeType then
    local juniorTime = myGuildMemberInfo:getJuniorUpgradeData()
    local juniorYear = juniorTime:GetYear()
    local juniorMonth = juniorTime:GetMonth()
    local juniorDay = juniorTime:GetDay()
    desc = desc .. [[

- ]] .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_JUNIOR_UPGRADE_REMAIN_TIME_CONTRACT_TOOLTIP_ADD_TEXT", "year", juniorYear, "month", juniorMonth, "day", juniorDay)
  end
  if true == myGuildMemberInfo:isVacation() then
    desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MEMBER_LIST_CONTRACT_TOOLTIP_VACATION_ADD")
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMemeberList_All_GradeTooltip(isShow, index, gradeType)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if nil == index then
    return
  end
  local name, desc, control
  local gradeValue = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER")
  if __eGuildMemberGradeMaster == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMASTER")
  elseif __eGuildMemberGradeSubMaster == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDSUBMASTER")
  elseif __eGuildMemberGradeNormal == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDMEMBER")
  elseif __eGuildMemberGradeSupplyOfficer == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_SUPPLYOFFICER")
  elseif __eGuildMemberGradeJunior == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_NEWBIE")
  elseif __eGuildMemberGradeVolunteer == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_LIST_GRADE_ICON_VACATION_TOOLTIP")
  elseif __eGuildMemberGradeAdviser == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDADVISER")
  elseif __eGuildMemberGradeGunner == gradeType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILDGUNNER")
  end
  control = PaGlobal_GuildMemberList_All._ui._memberlist[index]._grade
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMemeberList_All_VacationTooltip(isShow, index)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if nil == index then
    return
  end
  local name, desc, dcontrol
  name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_LIST_GRADE_ICON_VACATION_TOOLTIP")
  desc = nil
  control = PaGlobal_GuildMemberList_All._ui._memberlist[index]._grade
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMemeberList_All_VoiceIconTooltip(isShow, index, tipType)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHATICON_TOOLTIP_VOICE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHATICON_TOOLTIP_VOICE_DESC")
    control = PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceTalk
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHATICON_TOOLTIP_SPEAKER_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_VOICECHATICON_TOOLTIP_SPEAKER_DESC")
    control = PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildMemeberList_All_GuildFundTooltip(isShow)
  if false == isShow or nil == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  registTooltipControl(PaGlobal_GuildMemberList_All._ui.txt_guildFund, Panel_Tooltip_SimpleText)
  TooltipSimple_Show(PaGlobal_GuildMemberList_All._ui.txt_guildFund, PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_GUILDMONEY"))
end
function HandleEventOnOut_GuildMemberList_All_GuildLifeFundTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_GuildMemberList_All._isConsole then
    return
  end
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_LIST_BTN_WELFARE")
  TooltipSimple_Show(PaGlobal_GuildMemberList_All._ui.btn_guildLifeFund, name, PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ALL_GUILDFUNDS_DESC_TOOLTIP"))
end
function HandleEventOnOut_GuildMemberList_All_CharacterNameTooltip(isShow, dataIndex, uiIndex)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIndex)
  if nil == myGuildMemberInfo then
    _PA_ASSERT(false, "memberInfo\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164. \235\173\148\234\176\128 index\234\176\128 \236\158\152\235\170\187\235\144\152\236\151\136\236\150\180\236\154\148.")
    return
  end
  local isOnline = myGuildMemberInfo:isOnline()
  local uiControl = PaGlobal_GuildMemberList_All._ui._memberlist[uiIndex]._charName
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_FAMILYNAME", "name", myGuildMemberInfo:getName())
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_CHARACTERNAME", "name", myGuildMemberInfo:getCharacterName())
  if true == isOnline then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function HandleEventScroll_GuildMemeberList_All_Scroll(isUp)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetShow(false)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local memberCount = guildWrapper:getMemberCount()
  UIScroll.ScrollEvent(PaGlobal_GuildMemberList_All._ui.scroll_vs, isUp, memberCount, memberCount, 0, 1)
  PaGlobal_GuildMemberList_All:update()
end
function HandleEventLUp_GuildMemberList_All_ContractClick(index)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[index + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local usableActivity = myGuildMemberInfo:getUsableActivity()
  local myGrade = selfPlayer:getGuildMemberGrade()
  if true == _ContentsGroup_GuildRightInfo then
    FGlobal_AgreementGuild_Master_Open(dataIdx, myGrade, usableActivity)
  else
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
    if true == isGuildMaster then
      FGlobal_AgreementGuild_Master_Open(dataIdx, 0, usableActivity)
    elseif true == isGuildSubMaster then
      FGlobal_AgreementGuild_Master_Open(dataIdx, 1, usableActivity)
    else
      FGlobal_AgreementGuild_Master_Open(dataIdx, 2, usableActivity)
    end
  end
  local guildMemberGradeType = myGuildMemberInfo:getGrade()
  if __eGuildMemberGradeJunior == guildMemberGradeType then
    local juniorTime = myGuildMemberInfo:getJuniorUpgradeData()
    local juniorYear = juniorTime:GetYear()
    local juniorMonth = juniorTime:GetMonth()
    local juniorDay = juniorTime:GetDay()
    FGlobal_Add_Contract_juniorTimeText(juniorYear, juniorMonth, juniorDay)
  end
  PaGlobalFunc_GuildMemberList_All_AgreementShowDoNotCollect()
end
function HandlePadEventA_GuildMemberList_All_ContractClick()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMember(PaGlobal_GuildMemberList_All._selectIndex)
  local usableActivity = myGuildMemberInfo:getUsableActivity()
  local myGrade = getSelfPlayer():getGuildMemberGrade()
  if true == _ContentsGroup_GuildRightInfo then
    PaGlobalFunc_AgreementGuild_Master_ContractOpen(PaGlobal_GuildMemberList_All._selectIndex, myGrade, usableActivity)
  else
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    if true == isGuildMaster then
      PaGlobalFunc_AgreementGuild_Master_ContractOpen(PaGlobal_GuildMemberList_All._selectIndex, 0, usableActivity)
    elseif true == isGuildSubMaster then
      PaGlobalFunc_AgreementGuild_Master_ContractOpen(PaGlobal_GuildMemberList_All._selectIndex, 1, usableActivity)
    else
      PaGlobalFunc_AgreementGuild_Master_ContractOpen(PaGlobal_GuildMemberList_All._selectIndex, 2, usableActivity)
    end
  end
end
function HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiege(isparticipant)
  local function confirm()
    ToClient_resquestParticipateSiege(isparticipant)
  end
  local messageBoxMemo
  if true == isparticipant then
    if true == _ContentsGroup_SiegeAngerSystem then
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_MESSAGEBOX_PARTICIPANT_NEW")
    else
      messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_MESSAGEBOX_PARTICIPANT")
    end
  elseif true == _ContentsGroup_SiegeAngerSystem then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_MESSAGEBOX_NONPARTICIPANT_NEW")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGE_MESSAGEBOX_NONPARTICIPANT")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_GuildMemberList_All_RequestParticipateAtSiegeFromMaster(userNo)
  if true == isRealServiceMode() then
    return
  end
  local function confirm()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isParticipant
    if true == isGuildMaster then
      local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
      local guildMember = myGuildListInfo:getMemberByUserNo(userNo)
      local memberCount = myGuildListInfo:getMemberCount()
      local targetUserNo
      local isSiegeParticipant = not guildMember:isSiegeParticipant()
      ToClient_resquestParticipateSiegeFromMaster(myGuildListInfo:getGuildNo_s64(), userNo, isSiegeParticipant)
    end
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local guildMember = myGuildListInfo:getMemberByUserNo(userNo)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SIEGE_MESSAGEBOX_CHANGEPARTICIPANT", "GuildMember", guildMember:getName())
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_GuildMemberList_All_VoiceChatTalkingSet(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local memberIndex = index
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  if false == ToClient_isLoggedInVoiceChatServer() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "VOICECHAT_FAILURE_NOT_CONNECTED"))
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[index + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local isRightVoiceSet = PaGlboalFunc_GuildMemberList_All_GetRightCheck(__eGuildRightType_VoiceForceSet)
  local usableActivity = myGuildMemberInfo:getUsableActivity()
  local isSaying = myGuildMemberInfo:isVoiceChatSpeak()
  local isListening = myGuildMemberInfo:isVoiceChatListen()
  if true == PaGlobal_GuildMemberList_All._contentOpen.voice then
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceTalk:SetAutoDisableTime(2)
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceTalk:DoAutoDisableTime()
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen:SetAutoDisableTime(2)
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen:DoAutoDisableTime()
  end
  if true == myGuildMemberInfo:isSelf() then
    if true == isSaying then
      isSaying = false
      ToClient_StopVoiceChat()
    else
      isSaying = true
      ToClient_StartVoiceChat()
    end
    if false == ToClient_IsConnectedMic() then
      PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceTalk:SetMonoTone(true, true)
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_Guild_List_NotConnectedMic"))
      return
    end
    ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, myGuildMemberInfo:getUserNo(), isSaying, isListening, false)
  elseif true == isRightVoiceForceSet then
    local function handle_SendForceState()
      PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceTalk:SetMonoTone(true, true)
      ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, PaGlobal_GuildMemberList_All._memberlistData[index + 1].userNo, false, isListening, true)
    end
    if false == isSaying then
      return
    end
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "Lua_Guild_List_VoiceChatControl_ForceSpeakOff", "GuildMember", myGuildMemberInfo:getName())
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxMemo,
      functionYes = handle_SendForceState,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
end
function HandleEventLUp_GuildMemberList_All_VoiceChatListeningOpen(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[index + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  if nil == myGuildMemberInfo then
    return
  end
  PaGlobal_GuildMemberList_All._ui_pc.stc_setVolumBg:SetShow(true)
  if true == myGuildMemberInfo:isSelf() then
    PaGlobal_GuildMemberList_All._setVol_selectedMemberVol = ToClient_getSpeakerVolume()
  else
    PaGlobal_GuildMemberList_All._setVol_selectedMemberVol = myGuildMemberInfo:getVoiceVolume()
  end
  PaGlobal_GuildMemberList_All._ui_pc.slider_listenVol:SetControlPos(PaGlobal_GuildMemberList_All._setVol_selectedMemberVol)
  if PaGlobal_GuildMemberList_All._setVol_selectedMemberVol > 0 then
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen:SetMonoTone(false, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(false, true)
  else
    PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen:SetMonoTone(true, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(true, true)
  end
  PaGlobal_GuildMemberList_All._ui_pc.txt_volumVal:SetText(PaGlobal_GuildMemberList_All._setVol_selectedMemberVol .. "%")
  PaGlobal_GuildMemberList_All._setVol_selectedMemberIdx = index
  local targetControl = PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen
  local memberBg = PaGlobal_GuildMemberList_All._ui._memberlist[index]._voiceListen:GetParentPosY() - Panel_GuildMain_All:GetPosY() - PaGlobal_GuildMemberList_All._config.voiceBgY
  PaGlobal_GuildMemberList_All._ui_pc.stc_setVolumBg:SetPosX(targetControl:GetPosX() - PaGlobal_GuildMemberList_All._ui_pc.stc_setVolumBg:GetSizeX() / 2)
  PaGlobal_GuildMemberList_All._ui_pc.stc_setVolumBg:SetPosY(memberBg + targetControl:GetSizeY())
end
function HandleEventLUp_GuildMemberList_All_VolumeClose()
  PaGlobal_GuildMemberList_All._ui_pc.stc_setVolumBg:SetShow(false)
  PaGlobal_GuildMemberList_All._setVol_selectedMemberIdx = 0
end
function HandleEventLUp_GuildMemberList_All_VolumeListenCheck()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local memberIndex = PaGlobal_GuildMemberList_All._setVol_selectedMemberIdx
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[memberIndex + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local isSaying = myGuildMemberInfo:isVoiceChatSpeak()
  local isListening = myGuildMemberInfo:isVoiceChatListen()
  if true == isListening then
    isListening = false
    PaGlobal_GuildMemberList_All._ui_pc.slider_listenVol:SetControlPos(0)
    ToClient_setSpeakerVolume(0)
    PaGlobal_GuildMemberList_All._ui._memberlist[memberIndex]._voiceListen:SetMonoTone(true, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(true, true)
  else
    isListening = true
    PaGlobal_GuildMemberList_All._ui_pc.slider_listenVol:SetControlPos(100)
    ToClient_setSpeakerVolume(100)
    PaGlobal_GuildMemberList_All._ui._memberlist[memberIndex]._voiceListen:SetMonoTone(false, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(false, true)
  end
  local listeningVol = math.ceil(PaGlobal_GuildMemberList_All._ui_pc.slider_listenVol:GetControlPos() * 100)
  PaGlobal_GuildMemberList_All._ui_pc.txt_volumVal:SetText(listeningVol .. "%")
  ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, myGuildMemberInfo:getUserNo(), isSaying, isListening, not myGuildMemberInfo:isSelf())
  if false == _ContentsGroup_RemasterUI_Main_RightTop then
    FGlobal_VoiceChatState()
  else
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.SetVoice)
  end
end
function HandleEventLPress_GuildMemberList_All_VolumeListenSet()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberIndex = PaGlobal_GuildMemberList_All._setVol_selectedMemberIdx
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[memberIndex + 1].idx
  local myGuildMemberInfo = myGuildListInfo:getMember(dataIdx)
  local isSaying = myGuildMemberInfo:isVoiceChatSpeak()
  local isListening = myGuildMemberInfo:isVoiceChatListen()
  PaGlobal_GuildMemberList_All._prevVoiceChatListen = isListening
  local volume = math.ceil(PaGlobal_GuildMemberList_All._ui_pc.slider_listenVol:GetControlPos() * 100)
  PaGlobal_GuildMemberList_All._ui_pc.txt_volumVal:SetText(volume .. "%")
  if volume > 0 then
    isListening = true
    PaGlobal_GuildMemberList_All._ui._memberlist[memberIndex]._voiceListen:SetMonoTone(false, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(false, true)
  else
    isListening = false
    PaGlobal_GuildMemberList_All._ui._memberlist[memberIndex]._voiceListen:SetMonoTone(true, true)
    PaGlobal_GuildMemberList_All._ui_pc.chk_listenIcon:SetMonoTone(true, true)
  end
  if true == myGuildMemberInfo:isSelf() then
    ToClient_setSpeakerVolume(volume)
    if PaGlobal_GuildMemberList_All._prevVoiceChatListen ~= isListening then
      ToClient_VoiceChatChangeState(__eVoiceChatType_Guild, myGuildMemberInfo:getUserNo(), isSaying, isListening, false)
    end
    if false == _ContentsGroup_RemasterUI_Main_RightTop then
      FGlobal_VoiceChatState()
    else
      PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.SetVoice)
    end
  else
    ToClient_VoiceChatChangeVolume(__eVoiceChatType_Guild, myGuildMemberInfo:getUserNo(), volume)
  end
end
function HandleEventLUp_GuildMemberList_All_TakeSiegeReward()
  local IsSpecialCharacter = getTemporaryInformationWrapper():isSpecialCharacter()
  if true == IsSpecialCharacter then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseContentsPremiumCharacter"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  ToClient_resquestTakeSiegeMedalReward()
end
function HandleEventLUp_GuildMemberList_All_WelfareRequest()
  ToClient_RequestGuildWelfare()
end
function HandleEventLUp_GuildMemberList_All_TakeFund()
  local hasWareHouse = ToClient_HasWareHouseFromNpc()
  if hasWareHouse then
    if true == PaGlobal_GuildMemberList_All._isConsole then
      if true == _ContentsGroup_NewUI_Guild_All then
        PaGlobal_GuildReceivePay_All_Open()
      else
        PaGlobalFunc_GuildReceivePay_Open()
      end
    else
      PaGlobalFunc_GuildMemberList_All_ReceivePayOpen()
    end
  else
    ToClient_TakeMyGuildBenefit(false)
  end
end
function HandleEventLUp_GuildMemberList_All_Deposit()
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
  local unpaidTax_s64 = myGuildListInfo:getAccumulateTax()
  local unpaidCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
  local maxInputValue_s64 = toInt64(0, 0)
  if unpaidTax_s64 > toInt64(0, 0) then
    maxInputValue_s64 = myGuildListInfo:getAccumulateTax() - myGuildListInfo:getGuildBusinessFunds_s64()
  elseif unpaidCost_s64 > toInt64(0, 0) then
    maxInputValue_s64 = myGuildListInfo:getAccumulateGuildHouseCost() - myGuildListInfo:getGuildBusinessFunds_s64()
  end
  PaGlobal_GuildMemberList_All.inputGuildDepositMaxNum_s64 = maxInputValue_s64
  PaGlobal_GuildDeposit_All_Open(maxInputValue_s64)
end
function HandleEventLUp_GuildMemberList_All_IncentiveOption()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  local pcPosition = player:get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local safeZoneCheck = regionInfo:get():isSafeZone()
  if true == safeZoneCheck then
    PaGlobalFunc_GuildIncentive_All_ShowToggle()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_ALERT"))
  end
end
function PaGlobalFunc_GuildMemberList_All_GetAuthorityCheck(myGradeType, memberGradeType, buttonType, isProtect, isOnline)
  local returnValue = false
  if __eGuildMemberGradeMaster == myGradeType then
    if __eGuildMemberGradeMaster == memberGradeType then
      returnValue = false
    elseif __eGuildMemberGradeSubMaster == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeNormal == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType then
        returnValue = true
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER == buttonType then
        if isProtect then
          returnValue = false
        else
          returnValue = true
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == buttonType then
        if isProtect then
          returnValue = false
        else
          returnValue = true
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == buttonType then
        if isProtect then
          returnValue = true
        else
          returnValue = false
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType then
        returnValue = true
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY == buttonType then
        if isProtect then
          returnValue = false
        else
          returnValue = true
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeJunior == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType then
        returnValue = true
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == buttonType then
        if isProtect then
          returnValue = false
        else
          returnValue = true
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == buttonType then
        if isProtect then
          returnValue = true
        else
          returnValue = false
        end
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType then
        returnValue = true
      elseif PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
        returnValue = true
      end
      if ToClient_SelfPlayerIsGM() then
        if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType then
          returnValue = true
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER == buttonType then
          if isProtect then
            returnValue = false
          else
            returnValue = true
          end
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == buttonType then
          if isProtect then
            returnValue = false
          else
            returnValue = true
          end
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == buttonType then
          if isProtect then
            returnValue = true
          else
            returnValue = false
          end
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType then
          returnValue = true
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY == buttonType then
          if isProtect then
            returnValue = false
          else
            returnValue = true
          end
        elseif PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
          returnValue = true
        end
      end
    elseif __eGuildMemberGradeSupplyOfficer == memberGradeType and (PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType) then
      returnValue = true
    end
    if PaGlobal_GuildMemberList_All._MenuButtonType.PRICELIMIT == buttonType then
      returnValue = true
    end
  elseif __eGuildMemberGradeSubMaster == myGradeType then
    if __eGuildMemberGradeMaster == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeSubMaster == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeNormal == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeSupplyOfficer == memberGradeType then
      if PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType then
        returnValue = true
      end
    elseif __eGuildMemberGradeJunior == memberGradeType and (PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == buttonType) then
      returnValue = true
    end
  elseif __eGuildMemberGradeNormal == myGradeType and (PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType) then
    returnValue = true
  end
  if false == isOnline and (PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == buttonType or PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER == buttonType) then
    returnValue = false
  end
  return returnValue
end
function PaGlboalFunc_GuildMemberList_All_GetMenuButtonRightCheck(myGradeType, memberGradeType, buttonType, isProtect, isOnline)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local isCheck = false
  if false == _ContentsGroup_GuildRightInfo then
    isCheck = PaGlobalFunc_GuildMemberList_All_GetAuthorityCheck(myGradeType, memberGradeType, buttonType, isProtect, isOnline)
    return isCheck
  end
  local memberGrade = memberGradeType
  local rightType = PaGlobal_GuildMemberList_All._MenuButtonRightType[buttonType]
  if nil == rightType then
    if false == isOnline then
      return false
    else
      if PaGlobal_GuildMemberList_All._MenuButtonType.LARGEPARTY_INVITE == buttonType then
        return false
      end
      return true
    end
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(rightType)
  if false == isDefineRightType then
    isCheck = PaGlobalFunc_GuildMemberList_All_GetAuthorityCheck(myGradeType, memberGradeType, buttonType, isProtect, isOnline)
    return isCheck
  end
  local isRight = ToClient_IsCheckGuildRightType(rightType)
  local myGradePosition = ToClient_GetGuildMemberPosition(myGradeType)
  local memberGradePosition = ToClient_GetGuildMemberPosition(memberGradeType)
  if __eGuildMemberGradeSubMaster == memberGradeType and PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER == buttonType then
    return false
  end
  if __eGuildMemberGradeSupplyOfficer == memberGradeType and PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY == buttonType then
    return false
  end
  if __eGuildMemberGradeAdviser == memberGradeType and PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_ADVISER == buttonType then
    return false
  end
  if __eGuildMemberGradeGunner == memberGradeType and PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_GUNNER == buttonType then
    return false
  end
  if __eGuildMemberGradeMaster == memberGradeType and __eGuildRightType_ChangeMemberGrade == rightType then
    return false
  end
  if __eGuildMemberGradeSubMaster ~= memberGradeType and __eGuildMemberGradeSupplyOfficer ~= memberGradeType and __eGuildMemberGradeAdviser ~= memberGradeType and __eGuildMemberGradeGunner ~= memberGradeType and PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT == buttonType then
    return false
  end
  if __eGuildRightType_ChangeMemberGrade == rightType and PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER == buttonType then
    if __eGuildMemberGradeMaster ~= myGradeType then
      return false
    end
    if false == isOnline then
      return false
    end
    local isRightGetMaster = ToClient_IsCheckGuildRightTypeByGrade(memberGrade, __eGuildRightType_GetMaster)
    return isRightGetMaster and isRight
  end
  if true == isProtect then
    if __eGuildRightType_ChangeMemberGrade == rightType then
      return false
    end
    if PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == buttonType then
      return false
    end
    if PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == buttonType then
      local isRightProtectTarget = ToClient_IsCheckGuildRightTypeByGrade(memberGrade, __eGuildRightType_ProctectTargetMember)
      return isRightProtectTarget and isRight
    end
  elseif false == isProtect then
    if PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == buttonType then
      if -1 == myGradePosition or -1 == memberGradePosition then
        return false
      end
      if myGradePosition >= memberGradePosition then
        return false
      end
      local isRightProtectTarget = ToClient_IsCheckGuildRightTypeByGrade(memberGrade, __eGuildRightType_ProctectTargetMember)
      return isRightProtectTarget and isRight
    end
    if PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == buttonType then
      return false
    end
  end
  if __eGuildRightType_Expel == rightType then
    if -1 == myGradePosition or -1 == memberGradePosition then
      return false
    end
    if myGradePosition >= memberGradePosition then
      return false
    end
  end
  if __eGuildRightType_SetMemberLimitPrice == rightType then
    if -1 == myGradePosition or -1 == memberGradePosition then
      return false
    end
    if myGradePosition >= memberGradePosition then
      return false
    end
  end
  if __eGuildRightType_ChangeMemberGrade == rightType and PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_ADVISER == buttonType then
    local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
    if nil == myGuildInfo then
      return false
    end
    if Defines.s64_const.s64_0 == myGuildInfo:getGuildAdviserUserNo() or Defines.s64_const.s64_m1 == myGuildInfo:getGuildAdviserUserNo() then
      return isRight
    else
      return false
    end
  end
  return isRight
end
function PaGlboalFunc_GuildMemberList_All_GetRightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
    local isMasters = true == isGuildSubMaster or true == isGuildMaster
    if __eGuildRightType_WelfareMoney == eRightType then
      return isMasters
    elseif __eGuildRightType_PayIncentive == eRightType then
      return isGuildMaster
    elseif __eGuildRightType_VoiceForceSet == eRightType then
      return isMasters
    end
    return false
  end
  if false == _ContentsGroup_GuildRightInfo then
    return OriginalCheck()
  end
  local isDefineRightType = ToClient_IsDefineGuildRightType(eRightType)
  if false == isDefineRightType then
    return OriginalCheck()
  end
  return ToClient_IsCheckGuildRightType(eRightType)
end
function HandleEventLUp_GuildMemberList_All_MenuButtonToggle(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if true == PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:GetShow() then
    PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetShow(false)
    return
  end
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[index + 1].idx
  local guildMember = ToClient_GetMyGuildInfoWrapper():getMember(dataIdx)
  if true == guildMember:isSelf() then
    return
  end
  local grade = guildMember:getGrade()
  local myGrade = getSelfPlayer():getGuildMemberGrade()
  local isProtect = guildMember:isProtectable()
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  local buttonPosY = 5
  PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetShow(false)
  for ii = 0, PaGlobal_GuildMemberList_All._MenuButtonType.COUNT - 1 do
    if nil ~= PaGlobal_GuildMemberList_All._ui._buttonlist[ii] then
      PaGlobal_GuildMemberList_All._ui._buttonlist[ii]:SetShow(false)
    end
  end
  for ii = 0, PaGlobal_GuildMemberList_All._MenuButtonType.COUNT - 1 do
    if true == PaGlboalFunc_GuildMemberList_All_GetMenuButtonRightCheck(myGrade, grade, ii, isProtect, isOnline) then
      PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetShow(true)
      PaGlobal_GuildMemberList_All._ui._buttonlist[ii]:SetShow(true)
      PaGlobal_GuildMemberList_All._ui._buttonlist[ii]:SetPosX(10)
      PaGlobal_GuildMemberList_All._ui._buttonlist[ii]:SetPosY(buttonPosY + 5)
      buttonPosY = buttonPosY + PaGlobal_GuildMemberList_All._ui._buttonlist[ii]:GetSizeY() + 5
    end
  end
  if true == isGameTypeTH() or true == isGameTypeID() then
    PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetSize(PaGlobal_GuildMemberList_All._menuButtonSize.x + 30, buttonPosY + 10)
  else
    PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetSize(PaGlobal_GuildMemberList_All._menuButtonSize.x + 20, buttonPosY + 10)
  end
  local function ButtonListBgSetPos(pX, pY)
    PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetPosX(pX)
    PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetPosY(pY)
    local screenSizeY = getScreenSizeY()
    local checkY = getMousePosY() + PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:GetSizeY()
    if screenSizeY <= checkY then
      pY = PaGlobal_GuildMemberList_All._ui._memberlist[index]._charName:GetParentPosY() - PaGlobal_GuildMemberList_All._ui._memberlist[index]._charName:GetSizeY() - Panel_GuildMain_All:GetPosY() - PaGlobal_GuildMemberList_All._config.collectionY - PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:GetSizeY()
      PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetPosY(pY)
    end
  end
  local buttonListBgX = PaGlobal_GuildMemberList_All._ui._memberlist[index]._charName:GetParentPosX() - Panel_GuildMain_All:GetPosX() + PaGlobal_GuildMemberList_All._config.collectionX
  local buttonListBgY = PaGlobal_GuildMemberList_All._ui._memberlist[index]._charName:GetParentPosY() - Panel_GuildMain_All:GetPosY() - PaGlobal_GuildMemberList_All._config.collectionY
  ButtonListBgSetPos(buttonListBgX, buttonListBgY)
  PaGlobal_GuildMemberList_All._selectIndex = dataIdx
  PaGlobal_GuildMemberList_All._selectUserNo = guildMember:getUserNo()
end
function HandlePadEvent_GuildMemberlist_All_Click(index)
  local dataIdx = PaGlobal_GuildMemberList_All._memberlistData[index + 1].idx
  local guildMember = ToClient_GetMyGuildInfoWrapper():getMember(dataIdx)
  PaGlobal_GuildMemberList_All._selectIndex = dataIdx
  PaGlobal_GuildMemberList_All._selectUserNo = guildMember:getUserNo()
  PaGlobalFunc_GuildFunctionPanel_All_OpenByGuildMember()
end
function HandlePadEvent_GuildMemberlist_All_FontColorChange(index, eMemberStateColor, memberIdx, set)
  if nil == PaGlobal_GuildMemberList_All._ui._memberlist[index] or nil == memberIdx then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local myGuildMemberInfo = myGuildInfo:getMember(memberIdx)
  if nil == myGuildMemberInfo then
    return
  end
  local txt_charName = PaGlobal_GuildMemberList_All._ui._memberlist[index]._charName
  local txt_activity = PaGlobal_GuildMemberList_All._ui._memberlist[index]._activity
  local txt_contribute = PaGlobal_GuildMemberList_All._ui._memberlist[index]._contributedTendency
  if nil == txt_charName or nil == txt_activity or nil == txt_contribute then
    return
  end
  if true == set then
    txt_charName:SetFontColor(Defines.Color.C_FFE0E0E0)
    if 0 ~= eMemberStateColor then
      txt_activity:SetFontColor(Defines.Color.C_FFE0E0E0)
      txt_contribute:SetFontColor(Defines.Color.C_FFE0E0E0)
    end
  else
    local usableActivity = myGuildMemberInfo:getUsableActivity()
    if usableActivity > 10000 then
      usableActivity = 10000
    end
    local textActivity = tostring(myGuildMemberInfo:getTotalActivity()) .. "(<PAColor0xfface400>+" .. tostring(usableActivity) .. "<PAOldColor>)"
    if 0 == eMemberStateColor then
      txt_charName:SetFontColor(Defines.Color.C_FFEF9C7F)
    elseif 1 == eMemberStateColor then
      txt_charName:SetFontColor(Defines.Color.C_FFDDC39E)
      txt_activity:SetFontColor(Defines.Color.C_FFDDC39E)
      txt_activity:SetText(textActivity)
      txt_contribute:SetFontColor(Defines.Color.C_FFDDC39E)
    else
      txt_charName:SetFontColor(Defines.Color.C_FF5A5A5A)
      txt_activity:SetFontColor(Defines.Color.C_FF5A5A5A)
      txt_contribute:SetFontColor(Defines.Color.C_FF5A5A5A)
    end
  end
end
function HandleEventLUp_GuildMemberList_All_SelectMenuButton(index)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMember(PaGlobal_GuildMemberList_All._selectIndex)
  if nil == myGuildMemberInfo then
    return
  end
  local messageTitle = ""
  local messageContent = ""
  local yesFunction
  local targetName = myGuildMemberInfo:getName()
  local characterName = myGuildMemberInfo:getCharacterName()
  local isOnlineMember = myGuildMemberInfo:isOnline()
  local position
  local hotKeyUse = true
  PaGlobal_GuildMemberList_All._characterName = characterName
  PaGlobal_GuildMemberList_All._ui_pc.stc_funcBg:SetShow(false)
  if PaGlobal_GuildMemberList_All._MenuButtonType.CHANGE_MASTER == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_DELEGATE_MASTER")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_DELEGATE_MASTER_QUESTION", "target", "'" .. tostring(targetName) .. "'")
    yesFunction = PaGlobalFunc_GuildMemberList_All_ChangeGuildMaster
    position = "top"
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.DEPORTATION == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_EXPEL_GUILDMEMBER")
    messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_EXPEL_GUILDMEMBER_QUESTION", "target", "[" .. tostring(targetName) .. "]")
    yesFunction = PaGlobalFunc_GuildMemberList_All_ExpelMember
    if false == PaGlobal_GuildMemberList_All._isConsole then
      hotKeyUse = false
    end
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_COMMANDER == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER")
    messageContent = "'" .. tostring(targetName) .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDSUBMASTER_QUESTION")
    yesFunction = PaGlobalFunc_GuildMemberList_All_AppointCommander
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_APPOINT == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDMEMBER")
    messageContent = "'" .. tostring(targetName) .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDMEMBER_QUESTION")
    yesFunction = PaGlobalFunc_GuildMemberList_All_CancelAppoint
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.PROTECT_MEMBER == index then
    local protectRate = 10
    local currentProtectMemberCount = myGuildListInfo:getProtectGuildMemberCount()
    local maxProtectMemberCount = math.floor(myGuildListInfo:getMemberCount() / protectRate + 0.5) - 1
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROTECT_GUILDMEMBER")
    messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_PROTECT_GUILDMEMBER_DESC")
    yesFunction = PaGlobalFunc_GuildMemberList_All_ProtectMember
    position = "top"
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.CANCLE_PROTECT_MEMBER == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CANCEL_PROTECT_GUILDMEMBER")
    messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CANCEL_PROTECT_GUILDMEMBER_DESC")
    yesFunction = PaGlobalFunc_GuildMemberList_All_CancelProtectMember
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.PARTY_INVITE == index then
    if false == ToClient_IsGuildMemberBlocked(PaGlobal_GuildMemberList_All._selectIndex) then
      messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
      if isOnlineMember then
        messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_GUILDMEMBERPARTYINVITE_MSG", "targetName", characterName)
        yesFunction = PaGlobalFunc_GuildMemberList_All_guildMemberPartyInvite
        position = "middle"
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_PARTYINVITE_NOTJOINMEMBER")
        yesFunction = MessageBox_Empty_function
        position = "middle"
      end
    else
      messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
      messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
      yesFunction = MessageBox_Empty_function
    end
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.SUPPLY == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SUPPLYOFFICER_APPOINTMENT_TITLE")
    messageContent = "'" .. tostring(targetName) .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_SUPPLYOFFICER_APPOINTMENT_MEMO")
    yesFunction = PaGlobalFunc_GuildMemberList_All_AppointSupply
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.WHISPER == index then
    PaGlobal_ChattingInput_SendWhisper(characterName, targetName)
    return
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.PRICELIMIT == index then
    if true == _ContentsGroup_NewUI_Guild_All then
      PaGlobalFunc_GuildUseFund_All_ShowToggle(PaGlobal_GuildMemberList_All._selectIndex, true)
    elseif true == PaGlobal_GuildMemberList_All._isConsole then
      PaGlobalFunc_GuildFunding_Open(PaGlobal_GuildFunctionPanel_All._currentMemberIdx)
    else
      PaGlobal_Guild_UseGuildFunds:ShowToggle(PaGlobal_GuildMemberList_All._selectIndex, true)
    end
    return
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.LARGEPARTY_INVITE == index then
    if false == _ContentsGroup_LargeParty then
      return
    end
    if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoingAlterOfBlood"))
      return
    end
    if false == ToClient_IsGuildMemberBlocked(PaGlobal_GuildMemberList_All._selectIndex) then
      local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
      if true == isOnlineMember then
        messageContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_GUILDMEMBER_LARGEPARTYINVITE_MSG", "targetName", characterName)
        position = "middle"
        yesFunction = PaGlobalFunc_GuildMemberList_All_guildMemberLargePartyInvite
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_PARTYINVITE_NOTJOINMEMBER")
        position = "middle"
      end
    else
      messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
      messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
      yesFunction = MessageBox_Empty_function
    end
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_ADVISER == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDADVISER")
    messageContent = "'" .. tostring(targetName) .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDADVISER_QUESTION")
    yesFunction = PaGlobalFunc_GuildMemberList_All_AppointAdviser
  elseif PaGlobal_GuildMemberList_All._MenuButtonType.APPOINT_GUNNER == index then
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDGUNNER")
    messageContent = "'" .. tostring(targetName) .. "'" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_APPOINT_GUILDGUNNER_QUESTION")
    yesFunction = PaGlobalFunc_GuildMemberList_All_AppointGunner
  else
    UI.ASSERT(false, "\236\158\145\236\151\133\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164!")
    return
  end
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = yesFunction,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == hotKeyUse then
    MessageBox.showMessageBox(messageboxData, position, nil, hotKeyUse)
  else
    MessageBox.showMessageBox(messageboxData, position)
  end
end
function PaGlobalFunc_GuildMemberList_All_ChangeGuildMaster()
  ToClient_RequestChangeGuildMemberGradeForMaster(PaGlobal_GuildMemberList_All._selectIndex)
end
function PaGlobalFunc_GuildMemberList_All_ExpelMember()
  ToClient_RequestExpelMemberFromGuild(PaGlobal_GuildMemberList_All._selectIndex, PaGlobal_GuildMemberList_All._selectUserNo)
end
function PaGlobalFunc_GuildMemberList_All_AppointCommander()
  ToClient_RequestChangeGuildMemberGrade(PaGlobal_GuildMemberList_All._selectIndex, __eGuildMemberGradeSubMaster)
end
function PaGlobalFunc_GuildMemberList_All_CancelAppoint()
  ToClient_RequestChangeGuildMemberGrade(PaGlobal_GuildMemberList_All._selectIndex, __eGuildMemberGradeNormal)
end
function PaGlobalFunc_GuildMemberList_All_AppointSupply()
  ToClient_RequestChangeGuildMemberGrade(PaGlobal_GuildMemberList_All._selectIndex, __eGuildMemberGradeSupplyOfficer)
end
function PaGlobalFunc_GuildMemberList_All_ProtectMember()
  ToClient_RequestChangeProtectMember(PaGlobal_GuildMemberList_All._selectIndex, true)
end
function PaGlobalFunc_GuildMemberList_All_CancelProtectMember()
  ToClient_RequestChangeProtectMember(PaGlobal_GuildMemberList_All._selectIndex, false)
end
function PaGlobalFunc_GuildMemberList_All_guildMemberPartyInvite()
  RequestParty_inviteCharacter(PaGlobal_GuildMemberList_All._characterName)
end
function PaGlobalFunc_GuildMemberList_All_guildMemberLargePartyInvite()
  ToClient_InviteLargePartyByCharacterName(PaGlobal_GuildMemberList_All._characterName)
end
function PaGlobalFunc_GuildMemberList_All_AppointAdviser()
  ToClient_RequestChangeGuildMemberGrade(PaGlobal_GuildMemberList_All._selectIndex, __eGuildMemberGradeAdviser)
end
function PaGlobalFunc_GuildMemberList_All_AppointGunner()
  ToClient_RequestChangeGuildMemberGrade(PaGlobal_GuildMemberList_All._selectIndex, __eGuildMemberGradeGunner)
end
function HandleEventLUp_GuildMemeberList_All_ListSort(sortType)
  if nil == PaGlobalFunc_GuildMain_All_GetBgShow then
    return
  end
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._MEMBERLIST) then
    return
  end
  if nil == PaGlobal_GuildMemberList_All._ui._titlelist[sortType] then
    return
  end
  if nil == PaGlobal_GuildMemberList_All._listSort[sortType] then
    return
  end
  PaGlobal_GuildMemberList_All._selectSortType = sortType
  PaGlobal_GuildMemberList_All:titleLineReset()
  local control = PaGlobal_GuildMemberList_All._ui._titlelist[sortType]
  local baseText = PaGlobal_GuildMemberList_All._ui._titlelist[sortType]:GetText()
  if false == PaGlobal_GuildMemberList_All._listSort[sortType] then
    control:SetText(baseText .. "\226\150\178")
    PaGlobal_GuildMemberList_All._listSort[sortType] = true
  else
    control:SetText(baseText .. "\226\150\188")
    PaGlobal_GuildMemberList_All._listSort[sortType] = false
  end
  PaGlobal_GuildMemberList_All:update()
end
function guildListCompareGrade(w1, w2)
  if true == _ContentsGroup_GuildRightInfo then
    local w1Position = ToClient_GetGuildMemberPosition(w1.grade)
    local w2Position = ToClient_GetGuildMemberPosition(w2.grade)
    if __eGuildMemberGradeGunner == w1.grade and __eGuildMemberGradeSupplyOfficer == w2.grade then
      w1Position = 3
      w2Position = 4
    elseif __eGuildMemberGradeSupplyOfficer == w1.grade and __eGuildMemberGradeGunner == w2.grade then
      w1Position = 4
      w2Position = 3
    end
    if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
      return w1Position < w2Position
    else
      return w1Position > w2Position
    end
  else
    local w1Grade = w1.grade
    local w2Grade = w2.grade
    if 2 == w1Grade then
      w1Grade = 3
    elseif 3 == w1Grade then
      w1Grade = 2
    end
    if 2 == w2Grade then
      w2Grade = 3
    elseif 3 == w2Grade then
      w2Grade = 2
    end
    if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
      return w1Grade < w2Grade
    else
      return w1Grade > w2Grade
    end
  end
end
function guildListCompareLev(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.level < w1.level then
      return true
    end
  elseif w1.level < w2.level then
    return true
  end
end
function guildListCompareClass(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.class < w1.class then
      return true
    end
  elseif w1.class < w2.class then
    return true
  end
end
function guildListCompareName(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w1.name < w2.name then
      return true
    end
  elseif w2.name < w1.name then
    return true
  end
end
function guildListCompareAp(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.ap < w1.ap then
      return true
    end
  elseif w1.ap < w2.ap then
    return true
  end
end
function guildListCompareExpiration(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.expiration < w1.expiration then
      return true
    end
  elseif w1.expiration < w2.expiration then
    return true
  end
end
function guildListCompareWp(w1, w2)
  if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.wp < w1.wp then
      return true
    end
  elseif w1.wp < w2.wp then
    return true
  end
end
function guildListSiegeGrade(w1, w2)
  if true == PaGlobal_GuildMemberList_All._contentOpen.newSiegeRule then
    if true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
      if true == w2.siegeParticipant and false == w1.siegeParticipant then
        return true
      elseif false == w2.siegeParticipant and true == w1.siegeParticipant then
        return false
      else
        return guildListCompareGrade(w1, w2)
      end
    elseif true == w1.siegeParticipant and false == w2.siegeParticipant then
      return true
    elseif false == w1.siegeParticipant and true == w2.siegeParticipant then
      return false
    else
      return guildListCompareGrade(w1, w2)
    end
  elseif true == PaGlobal_GuildMemberList_All._listSort[PaGlobal_GuildMemberList_All._selectSortType] then
    if w2.siegegrade < w1.siegegrade then
      return true
    end
  elseif w1.siegegrade < w2.siegegrade then
    return true
  end
end
