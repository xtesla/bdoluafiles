function PaGlobal_GuildFunctionPanel_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildFunctionPanel_All or false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui.stc_TitleBg = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_TitleArea")
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_MainArea")
  self._ui.btn_FucntionTemp = UI.getChildControl(self._ui.stc_MainBg, "Button_FunctionButton_Temp")
  self._ui.stc_ConsoleKeyGuide = UI.getChildControl(Panel_GuildFunctionPanel_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_ConsoleKeyGuide, "StaticText_B_ConsoleUI")
  self._originPanelSize = Panel_GuildFunctionPanel_All:GetSizeY()
  self._ui.btn_FucntionTemp:SetShow(false)
  self._ui.stc_ConsoleKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }, self._ui.stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_GuildFunctionPanel_All:registerEvent()
  PaGlobal_GuildFunctionPanel_All:validate()
  PaGlobal_GuildFunctionPanel_All:createMenuBtn()
end
function PaGlobal_GuildFunctionPanel_All:validate()
  self._ui.stc_MainBg:isValidate()
  self._ui.btn_FucntionTemp:isValidate()
  self._ui.stc_ConsoleKeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
end
function PaGlobal_GuildFunctionPanel_All:registerEvent()
end
function PaGlobal_GuildFunctionPanel_All:createMenuBtn()
  local startPosY = self._ui.btn_FucntionTemp:GetPosY()
  for idx = 0, self._menuCount - 1 do
    local btn = UI.cloneControl(self._ui.btn_FucntionTemp, self._ui.stc_MainBg, "Static_FuncBtn_" .. idx)
    btn:SetPosY(startPosY + (self._ui.btn_FucntionTemp:GetSizeY() + 10) * idx)
    btn:SetShow(true)
    self._funcBtnTable[idx] = btn
  end
end
function PaGlobal_GuildFunctionPanel_All:dataClear()
  if nil ~= self._funcBtnTable then
    for idx = 0, self._menuCount - 1 do
      self._funcBtnTable[idx]:SetText("")
      self._funcBtnTable[idx]:SetShow(false)
      self._funcBtnTable[idx]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    end
  end
  self._enabledBtnCount = 0
end
function PaGlobal_GuildFunctionPanel_All:prepareOpen()
  PaGlobal_GuildFunctionPanel_All:dataClear()
  if nil == self._openType then
    return
  end
  if self._eOpenType.INFO == self._openType then
    if true == _ContentsGroup_GuildRightInfo then
      PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtnMenu()
    else
      PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtn()
    end
  elseif self._eOpenType.LIST == self._openType then
    if true == _ContentsGroup_GuildRightInfo then
      PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtnMenu()
    else
      PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtn()
    end
  elseif self._eOpenType.ALLYINFO == self._openType then
    if true == _ContentsGroup_GuildRightInfo then
      PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtnMenu()
    else
      PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtn()
    end
  end
  local titleSizeY = self._ui.stc_TitleBg:GetSizeY()
  local btnSize = (self._enabledBtnCount + 1) * (self._ui.btn_FucntionTemp:GetSizeY() + 10)
  local panelY = math.max(self._originPanelSize, btnSize)
  Panel_GuildFunctionPanel_All:SetSize(Panel_GuildFunctionPanel_All:GetSizeX(), panelY)
  self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), panelY - titleSizeY)
  self._ui.stc_ConsoleKeyGuide:ComputePos()
  Panel_GuildFunctionPanel_All:ComputePos()
  PaGlobal_GuildFunctionPanel_All:open()
end
function PaGlobal_GuildFunctionPanel_All:open()
  Panel_GuildFunctionPanel_All:SetShow(true)
end
function PaGlobal_GuildFunctionPanel_All:prepareClose()
  Panel_GuildFunctionPanel_All:close()
end
function Panel_GuildFunctionPanel_All:close()
  Panel_GuildFunctionPanel_All:SetShow(false)
end
function PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtnMenu()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local infoBtnList = {
    [0] = self._eFuncType.guildNotice,
    [1] = self._eFuncType.guildIntro,
    [2] = self._eFuncType.declareWar,
    [3] = self._eFuncType.guildMark,
    [4] = self._eFuncType.disperseGuild,
    [5] = self._eFuncType.joinMemberCount,
    [6] = self._eFuncType.leaveGuild,
    [7] = self._eFuncType.protectionIncrease,
    [8] = self._eFuncType.mandateMaster,
    [9] = self._eFuncType.arshaAdminGet,
    [10] = self._eFuncType.guildWareHouse,
    [11] = self._eFuncType.joinReward,
    [12] = self._eFuncType.payGuildTax,
    [13] = self._eFuncType.lifeFund,
    [14] = self._eFuncType.setGuildMainServer,
    [15] = self._eFuncType.guildGiveaway
  }
  local function exceptionCheck(btnType)
    local myGrade = getSelfPlayer():getGuildMemberGrade()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
    local isGuildAdviser = getSelfPlayer():get():isGuildAdviser()
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if self._eFuncType.mandateMaster == btnType then
      local delegable = toInt64(0, -1) == myGuildListInfo:getGuildMasterUserNo()
      if true == delegable then
        self:SetButton(self._eFuncType.mandateMaster)
        return false
      elseif ToClient_IsAbleChangeMaster() then
        return isGuildSubMaster or isGuildAdviser
      end
      return false
    elseif self._eFuncType.setGuildMainServer == btnType and false == _ContentsGroup_GuildServerWar then
      return false
    end
    return true
  end
  for ii = 0, #infoBtnList do
    local isCheck = false
    local buttonType = infoBtnList[ii]
    if false == _ContentsGroup_GuildRightInfo or nil == self._eFuncRightType[buttonType] then
      isCheck = self:guildInfoOriginalCheck(buttonType)
    else
      local isDefineRightType = ToClient_IsDefineGuildRightType(self._eFuncRightType[buttonType])
      if false == isDefineRightType then
        isCheck = self:guildInfoOriginalCheck(buttonType)
      else
        isCheck = ToClient_IsCheckGuildRightType(self._eFuncRightType[buttonType])
      end
    end
    if true == exceptionCheck(buttonType) and true == isCheck then
      self:SetButton(infoBtnList[ii])
    end
  end
end
function PaGlobal_GuildFunctionPanel_All:guildInfoOriginalCheck(funcType)
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local isGuildAdviser = getSelfPlayer():get():isGuildAdviser()
  local isMasters = true == isGuildSubMaster or true == isGuildMaster or true == isGuildAdviser
  if self._eFuncType.guildNotice == funcType then
    return isMasters
  elseif self._eFuncType.guildIntro == funcType then
    return isMasters
  elseif self._eFuncType.declareWar == funcType then
    return isMasters
  elseif self._eFuncType.guildMark == funcType then
    return isMasters
  elseif self._eFuncType.disperseGuild == funcType then
    return isGuildMaster
  elseif self._eFuncType.joinMemberCount == funcType then
    return isGuildMaster
  elseif self._eFuncType.leaveGuild == funcType then
    return not isGuildMaster
  elseif self._eFuncType.protectionIncrease == funcType then
    return isMasters
  elseif self._eFuncType.mandateMaster == funcType then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    local delegable = toInt64(0, -1) == myGuildListInfo:getGuildMasterUserNo()
    if true == delegable then
      return not isGuildMaster
    elseif ToClient_IsAbleChangeMaster() then
      return isGuildSubMaster
    end
  elseif self._eFuncType.arshaAdminGet == funcType then
    if true == PaGlobalFunc_GuildInfo_All_CheckAdminArsha() then
      return true
    end
  elseif self._eFuncType.guildWareHouse == funcType then
    if false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
      return true
    end
  elseif self._eFuncType.joinReward == funcType then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    local memberCount = myGuildListInfo:getMemberCount()
    local isTakableSiegeReward = false
    for ii = 1, memberCount do
      local memberInfo = myGuildListInfo:getMember(ii - 1)
      if true == memberInfo:isSelf() then
        isTakableSiegeReward = memberInfo:isTakableSiegeReward()
        self._ui._isSiegeParticipant = memberInfo:isSiegeParticipant()
        break
      end
    end
    if true == isTakableSiegeReward then
      return true
    end
  elseif self._eFuncType.payGuildTax == funcType then
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
    local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
    local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
    if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) and true == isMasters then
      return true
    end
  elseif self._eFuncType.guildGiveaway == funcType then
    if true == _ContentsGroup_GuildGiveaway then
      return true
    else
      return false
    end
  end
  return false
end
function PaGlobal_GuildFunctionPanel_All:SetGuildInfoBtn()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local memberCount = myGuildListInfo:getMemberCount()
  local isTakableSiegeReward = false
  local delegable = toInt64(0, -1) == myGuildListInfo:getGuildMasterUserNo()
  for ii = 1, memberCount do
    local memberInfo = myGuildListInfo:getMember(ii - 1)
    if true == memberInfo:isSelf() then
      isTakableSiegeReward = memberInfo:isTakableSiegeReward()
      self._ui._isSiegeParticipant = memberInfo:isSiegeParticipant()
      break
    end
  end
  if true == isGuildMaster then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildIntro)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.declareWar)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildMark)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.disperseGuild)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinMemberCount)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protectionIncrease)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.lifeFund)
  elseif true == isGuildSubMaster then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildIntro)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.declareWar)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildMark)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.leaveGuild)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protectionIncrease)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.lifeFund)
    if true == delegable then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    elseif ToClient_IsAbleChangeMaster() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    end
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.leaveGuild)
    if true == delegable then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.mandateMaster)
    end
  end
  if true == PaGlobalFunc_GuildInfo_All_CheckAdminArsha() then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.arshaAdminGet)
  end
  if false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.guildWareHouse)
  end
  if true == isTakableSiegeReward then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinReward)
  end
  local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
  local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
  local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
  if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) and (isGuildMaster or isGuildSubMaster) then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.payGuildTax)
  end
end
function PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtnMenu()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local infoBtnList = {
    [0] = self._eFuncType.showInfo,
    [1] = self._eFuncType.participation,
    [2] = self._eFuncType.recvPay,
    [3] = self._eFuncType.incentive,
    [4] = self._eFuncType.joinReward,
    [5] = self._eFuncType.appointAdviser,
    [6] = self._eFuncType.appointCommander,
    [7] = self._eFuncType.appointSupply,
    [8] = self._eFuncType.appointGunner,
    [9] = self._eFuncType.inviteParty,
    [10] = self._eFuncType.inviteLargeParty,
    [11] = self._eFuncType.cancelCommander,
    [12] = self._eFuncType.cancelProtection,
    [13] = self._eFuncType.protection,
    [14] = self._eFuncType.funding,
    [15] = self._eFuncType.voiceOption,
    [16] = self._eFuncType.payGuildTaxAllMember,
    [17] = self._eFuncType.showContract,
    [18] = self._eFuncType.deportation,
    [19] = self._eFuncType.changeMaster
  }
  local function exceptionCheck(btnType)
    local myGrade = getSelfPlayer():getGuildMemberGrade()
    local isGuildMaster = getSelfPlayer():get():isGuildMaster()
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    local selectMemberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
    local guildMember = myGuildListInfo:getMember(selectMemberIdx)
    local memberGrade = guildMember:getGrade()
    local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
    local isSelf = guildMember:isSelf()
    local isProtectable = guildMember:isProtectable()
    local myGradePosition = ToClient_GetGuildMemberPosition(myGrade)
    local memberGradePosition = ToClient_GetGuildMemberPosition(memberGrade)
    if self._eFuncType.participation == btnType then
      return isSelf
    end
    if self._eFuncType.inviteParty == btnType or self._eFuncType.inviteLargeParty == btnType then
      return isOnline and not isSelf
    end
    if self._eFuncType.recvPay == btnType and true == guildMember:isCollectableBenefit() and false == guildMember:isFreeAgent() and toInt64(0, 0) < guildMember:getContractedBenefit() then
      return isSelf
    end
    if self._eFuncType.joinReward == btnType then
      local isTakableSiegeReward = guildMember:isTakableSiegeReward()
      if true == isTakableSiegeReward and false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
        return isSelf
      end
    end
    if self._eFuncType.deportation == btnType then
      if -1 == myGradePosition or -1 == memberGradePosition then
        return false
      end
      if myGradePosition >= memberGradePosition then
        return false
      end
    end
    if self._eFuncType.appointAdviser == btnType then
      if __eGuildMemberGradeAdviser == memberGrade or true == isSelf then
        return false
      end
      if Defines.s64_const.s64_0 ~= myGuildListInfo:getGuildAdviserUserNo() and Defines.s64_const.s64_m1 ~= myGuildListInfo:getGuildAdviserUserNo() then
        return false
      end
    end
    if self._eFuncType.appointCommander == btnType and (__eGuildMemberGradeSubMaster == memberGrade or true == isSelf) then
      return false
    end
    if self._eFuncType.appointSupply == btnType and (__eGuildMemberGradeSupplyOfficer == memberGrade or true == isSelf) then
      return false
    end
    if self._eFuncType.appointGunner == btnType and (__eGuildMemberGradeGunner == memberGrade or true == isSelf) then
      return false
    end
    if __eGuildMemberGradeMaster == memberGrade and __eGuildRightType_ChangeMemberGrade == self._eFuncRightType[btnType] then
      return false
    end
    if self._eFuncType.cancelCommander == btnType then
      if __eGuildMemberGradeAdviser ~= memberGrade and __eGuildMemberGradeSubMaster ~= memberGrade and __eGuildMemberGradeSupplyOfficer ~= memberGrade and __eGuildMemberGradeGunner ~= memberGrade then
        return false
      end
      if __eGuildMemberGradeAdviser == memberGrade and __eGuildMemberGradeMaster ~= myGrade then
        return false
      end
    end
    if self._eFuncType.protection == btnType or self._eFuncType.cancelProtection == btnType then
      if true == isProtectable then
        if __eGuildRightType_ChangeMemberGrade == self._eFuncRightType[btnType] then
          return false
        end
        if self._eFuncType.protection == btnType then
          return false
        end
      else
        if -1 == memberGradePosition or -1 == myGradePosition then
          return false
        end
        if myGradePosition >= memberGradePosition then
          return false
        end
        local isRightProtectTarget = ToClient_IsCheckGuildRightTypeByGrade(memberGrade, __eGuildRightType_ProctectTargetMember)
        if false == isRightProtectTarget then
          return false
        end
        if self._eFuncType.cancelProtection == btnType then
          return false
        end
      end
    end
    if self._eFuncType.funding == btnType then
      if -1 == myGradePosition or -1 == memberGradePosition then
        return false
      end
      if myGradePosition >= memberGradePosition then
        return false
      end
    end
    if self._eFuncType.voiceOption == btnType and (false == isOnline or true == _ContentsGroup_isPS4UI or true == isSelf) then
      return false
    end
    if self._eFuncType.changeMaster == btnType then
      if __eGuildMemberGradeMaster ~= myGrade then
        return false
      end
      if false == isOnline then
        return false
      end
      local isRightGetMaster = ToClient_IsCheckGuildRightTypeByGrade(memberGrade, __eGuildRightType_GetMaster)
      if false == isRightGetMaster then
        return false
      end
    end
    if self._eFuncType.payGuildTaxAllMember == btnType then
      if false == isSelf then
        return false
      end
      local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
      local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
      local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
      if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
        return true
      end
    end
    return true
  end
  for ii = 0, #infoBtnList do
    local isRight = false
    local buttonType = infoBtnList[ii]
    if false == _ContentsGroup_GuildRightInfo or nil == self._eFuncRightType[buttonType] then
      isRight = self:guildMemberOriginalCheck(buttonType)
    else
      local isDefineRightType = ToClient_IsDefineGuildRightType(self._eFuncRightType[buttonType])
      if false == isDefineRightType then
        isRight = self:guildMemberOriginalCheck(buttonType)
      else
        isRight = ToClient_IsCheckGuildRightType(self._eFuncRightType[buttonType])
      end
    end
    if true == isRight and true == exceptionCheck(buttonType) then
      self:SetButton(infoBtnList[ii])
    end
  end
end
function PaGlobal_GuildFunctionPanel_All:guildMemberOriginalCheck(funcType)
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local selectMemberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildMember = myGuildListInfo:getMember(selectMemberIdx)
  local memberGrade = guildMember:getGrade()
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  local isSelf = guildMember:isSelf()
  if self._eFuncType.showInfo == funcType then
    return true
  elseif self._eFuncType.participation == funcType then
    return isSelf
  elseif self._eFuncType.recvPay == funcType then
    if true == guildMember:isCollectableBenefit() and false == guildMember:isFreeAgent() and toInt64(0, 0) < guildMember:getContractedBenefit() then
      return isSelf
    end
  elseif self._eFuncType.incentive == funcType then
    if true == isGuildMaster and 0 == memberGrade then
      return isSelf
    end
  elseif self._eFuncType.joinReward == funcType then
    local isTakableSiegeReward = guildMember:isTakableSiegeReward()
    if true == isTakableSiegeReward and false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
      return isSelf
    end
  elseif self._eFuncType.deportation == funcType then
    return true == isGuildMaster and false == isSelf
  elseif self._eFuncType.appointSupply == funcType then
    if __eGuildMemberGradeSubMaster == memberGrade or __eGuildMemberGradeNormal == memberGrade then
      return isGuildMaster
    end
  elseif self._eFuncType.cancelCommander == funcType then
    if __eGuildMemberGradeSubMaster == memberGrade or __eGuildMemberGradeSupplyOfficer == memberGrade then
      return isGuildMaster
    end
  elseif self._eFuncType.changeMaster == funcType then
    if __eGuildMemberGradeSubMaster == memberGrade then
      return isGuildMaster
    end
  elseif self._eFuncType.inviteParty == funcType then
    return true
  elseif self._eFuncType.inviteLargeParty == funcType then
    return _ContentsGroup_LargeParty
  elseif self._eFuncType.appointCommander == funcType then
    if __eGuildMemberGradeNormal == memberGrade or __eGuildMemberGradeSupplyOfficer == memberGrade then
      return isGuildMaster
    end
  elseif self._eFuncType.cancelProtection == funcType then
    if __eGuildMemberGradeNormal == memberGrade or __eGuildMemberGradeJunior == memberGrade then
      return guildMember:isProtectable()
    end
  elseif self._eFuncType.protection == funcType then
    if __eGuildMemberGradeNormal == memberGrade or __eGuildMemberGradeJunior == memberGrade then
      return not guildMember:isProtectable()
    end
  elseif self._eFuncType.funding == funcType then
    return isGuildMaster
  elseif self._eFuncType.voiceOption == funcType then
    if true == isOnline and false == _ContentsGroup_isPS4UI and false == isSelf then
      return true
    end
  elseif self._eFuncType.payGuildTaxAllMember == funcType then
    local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
    local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
    local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
    if accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0) then
      return isGuildMaster and isSelf
    end
  elseif self._eFuncType.showContract == funcType then
    return true
  end
  return false
end
function PaGlobal_GuildFunctionPanel_All:SetGuildMemberBtn()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local selectMemberIdx = PaGlobalFunc_GuildMemberList_All_GetSelectMemeberIdx()
  local guildMember = myGuildListInfo:getMember(selectMemberIdx)
  local memberGrade = guildMember:getGrade()
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  local isSelf = guildMember:isSelf()
  if true == isSelf then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.participation)
    if true == guildMember:isCollectableBenefit() and false == guildMember:isFreeAgent() and toInt64(0, 0) < guildMember:getContractedBenefit() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.recvPay)
    end
    if true == isGuildMaster and 0 == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.incentive)
    end
    local isTakableSiegeReward = guildMember:isTakableSiegeReward()
    if true == isTakableSiegeReward and false == PaGlobalFunc_GuildMain_All_CheckIsMecernary() then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.joinReward)
    end
  elseif true == isGuildMaster then
    if __eGuildMemberGradeSubMaster == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointAdviser)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointSupply)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointGunner)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.changeMaster)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
    elseif __eGuildMemberGradeNormal == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointAdviser)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointSupply)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointGunner)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
      if guildMember:isProtectable() then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelProtection)
      else
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protection)
      end
    elseif __eGuildMemberGradeSupplyOfficer == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointAdviser)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointCommander)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.appointGunner)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
    elseif __eGuildMemberGradeJunior == memberGrade then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.deportation)
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
      if true == _ContentsGroup_LargeParty then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
      end
      if guildMember:isProtectable() then
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.cancelProtection)
      else
        PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.protection)
      end
    end
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.funding)
    if true == isOnline and false == _ContentsGroup_isPS4UI then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.voiceOption)
    end
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showInfo)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteParty)
    if true == _ContentsGroup_LargeParty then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.inviteLargeParty)
    end
    if true == isOnline and false == _ContentsGroup_isPS4UI then
      PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.voiceOption)
    end
  end
  local accumulateTax_s64 = myGuildListInfo:getAccumulateTax()
  local accumulateCost_s64 = myGuildListInfo:getAccumulateGuildHouseCost()
  local businessFunds_s64 = myGuildListInfo:getGuildBusinessFunds_s64()
  if (accumulateTax_s64 > toInt64(0, 0) or accumulateCost_s64 > toInt64(0, 0)) and true == isSelf then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.payGuildTaxAllMember)
  end
  PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.showContract)
end
function PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtnMenu()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local infoBtnList = {
    [0] = self._eFuncType.allyNotice,
    [1] = self._eFuncType.allyMarkChange,
    [2] = self._eFuncType.allydisperse,
    [3] = self._eFuncType.allyNoticeReset
  }
  for ii = 0, #infoBtnList do
    local isCheck = false
    if false == _ContentsGroup_GuildRightInfo or nil == self._eFuncRightType[ii] then
      isCheck = self:guildAllyInfoOriginalCheck(infoBtnList[ii])
    else
      local isDefineRightType = ToClient_IsDefineGuildRightType(self._eFuncRightType[ii])
      if false == isDefineRightType then
        isCheck = self:guildAllyInfoOriginalCheck(infoBtnList[ii])
      else
        isCheck = ToClient_IsCheckGuildRightType(self._eFuncRightType[ii])
      end
    end
    if true == isCheck then
      self:SetButton(infoBtnList[ii])
    end
  end
end
function PaGlobal_GuildFunctionPanel_All:guildAllyInfoOriginalCheck(funcType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if not isChairman and not isGuildMaster then
    return false
  end
  if self._eFuncType.allyNotice == funcType then
    return isChairman
  elseif self._eFuncType.allyMarkChange == funcType then
    return isChairman
  elseif self._eFuncType.allyNoticeReset == funcType then
    return isChairman
  elseif self._eFuncType.allydisperse == funcType then
    return true
  end
  return false
end
function PaGlobal_GuildFunctionPanel_All:SetAllyInfoBtn()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isChairman = selfPlayer:get():isGuildAllianceChair()
  local isGuildMaster = selfPlayer:get():isGuildMaster()
  if not isChairman and not isGuildMaster then
    return
  end
  if true == isChairman then
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyNotice)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyMarkChange)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allydisperse)
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allyNoticeReset)
  else
    PaGlobal_GuildFunctionPanel_All:SetButton(self._eFuncType.allydisperse)
  end
end
function PaGlobal_GuildFunctionPanel_All:SetButton(btnType)
  if nil == self._funcBtnTable then
    return
  end
  local btnText = self._btnString[btnType]
  if self._eFuncType.guildGiveaway == btnType then
    local itemCount = ToClient_getGiveawayDataCount()
    btnText = btnText .. " [" .. tostring(itemCount) .. "]"
  end
  self._funcBtnTable[self._enabledBtnCount]:SetText(btnText)
  self._funcBtnTable[self._enabledBtnCount]:SetShow(true)
  if self._eOpenType.INFO == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressGuildInfoFunc(" .. btnType .. ")")
  elseif self._eOpenType.LIST == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressMemberInfoFunc(" .. btnType .. ")")
  elseif self._eOpenType.ALLYINFO == PaGlobal_GuildFunctionPanel_All._openType then
    self._funcBtnTable[self._enabledBtnCount]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventPadPress_GuildFunctionPanel_All_PressAllyInfoFunc(" .. btnType .. ")")
  end
  self._enabledBtnCount = self._enabledBtnCount + 1
end
