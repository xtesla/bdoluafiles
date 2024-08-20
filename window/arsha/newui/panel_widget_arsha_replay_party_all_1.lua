function PaGlobal_Arsha_Replay_Party_All:initialize()
  if true == PaGlobal_Arsha_Replay_Party_All._initialize or nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_LeftTeam")
  self._ui._leftTeam.stc_teamNameBg = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._leftTeam.txt_teamName = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._leftTeam.stc_memberTemplate = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_MemberArea")
  self._ui._rightTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_RightTeam")
  self._ui._rightTeam.stc_teamNameBg = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._rightTeam.txt_teamName = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._rightTeam.stc_memberTemplate = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_MemberArea")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Arsha_Replay_Party_All:validate()
  PaGlobal_Arsha_Replay_Party_All:registEventHandler()
  PaGlobal_Arsha_Replay_Party_All:swichPlatform(self._isConsole)
  self._teamMemberUi = {}
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    self._teamMemberUi[ii] = {}
  end
  self._isCreate = false
  self._teamMember = {}
  self._isCreatePersonal = false
  self._isFinish = false
  PaGlobal_Arsha_Replay_Party_All._initialize = true
end
function PaGlobal_Arsha_Replay_Party_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_Arsha_Replay_Party_All:prepareOpen()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local selfActorKeyRaw = getSelfPlayer():getActorKey()
  if true == getSelfPlayer():isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(false)
    else
      Panel_Widget_Party:SetShow(false)
    end
  end
  PaGlobal_Arsha_Replay_Party_All:open()
  PaGlobal_Arsha_Replay_Party_All:resize()
end
function PaGlobal_Arsha_Replay_Party_All:open()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(true)
  self._ui._rightTeam.stc_mainBg:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(false)
  self._ui._leftTeam.txt_teamName:SetShow(false)
  self._ui._rightTeam.stc_teamNameBg:SetShow(false)
  self._ui._rightTeam.txt_teamName:SetShow(false)
  Panel_Widget_Arsha_Party_All:SetShow(true)
end
function PaGlobal_Arsha_Replay_Party_All:clearIsFinish()
  self._isFinish = false
end
function PaGlobal_Arsha_Replay_Party_All:prepareClose()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local selfActorKeyRaw = getSelfPlayer():getActorKey()
  if true == getSelfPlayer():isPartyMemberActorKey(selfActorKeyRaw) then
    if true == _ContentsGroup_NewUI_PartyWidget_All then
      Panel_Widget_Party_All:SetShow(true)
    else
      Panel_Widget_Party:SetShow(true)
    end
  end
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    if nil ~= self._teamMemberUi[ii] then
      for jj = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
        if nil ~= self._teamMemberUi[ii][jj] then
          UI.deleteControl(self._teamMemberUi[ii][jj]._memberBg)
          self._teamMemberUi[ii][jj] = nil
        end
      end
    end
  end
  self._teamMemberUi = {}
  for ii = 0, CppEnums.CompetitionFreeForAll.eFreeForAllTeamLimit - 1 do
    self._teamMemberUi[ii] = {}
  end
  self._teamMember = {}
  self._isCreate = false
  self._isCreatePersonal = false
  _leftScore = 0
  _rightScore = 0
  PaGlobal_Arsha_Replay_Party_All:close()
end
function PaGlobal_Arsha_Replay_Party_All:close()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(false)
  self._ui._rightTeam.stc_mainBg:SetShow(false)
  Panel_Widget_Arsha_Party_All:SetShow(false)
end
function PaGlobal_Arsha_Replay_Party_All:createTeamUi()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local isArshaReplay = ToClient_IsArshaReplay()
  if true == isArshaReplay then
    return
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  local isLeftFull = false
  local index = 0
  local leftMemberCount = 0
  local rightMemberCount = 0
  local leftTeamCount = 0
  local rightTeamCount = 0
  local gab = 5
  local replayTemaCirclePath = "Combine/Etc/Combine_Etc_Arsha_00.dds"
  for teamNo, teamMemberList in pairs(self._teamMember) do
    local teamUserCount = #teamMemberList
    if false == isLeftFull then
      local posY = Panel_Widget_Arsha_Party_All:GetPosY()
      local innerPos = self._ui._leftTeam.stc_memberTemplate:GetPosY() - self._replayMemberUiOffsetY + (self._ui._leftTeam.stc_memberTemplate:GetSizeY() + gab) * (leftMemberCount + teamUserCount)
      posY = posY + innerPos
      posY = posY + 20 * leftTeamCount
      if posY > Panel_Arsha_Replay_All:GetPosY() then
        isLeftFull = true
      end
    end
    if false == self._isCreate then
      for userIndex = 0, teamUserCount - 1 do
        local temp = {}
        if false == isLeftFull then
          temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. teamNo .. "_" .. userIndex)
          temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY() - self._replayMemberUiOffsetY + (temp._memberBg:GetSizeY() + gab) * leftMemberCount)
          leftMemberCount = leftMemberCount + 1
          temp._memberBg:SetPosY(temp._memberBg:GetPosY() + 20 * leftTeamCount)
        else
          temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. teamNo .. "_" .. userIndex)
          temp._memberBg:SetPosY(self._ui._rightTeam.stc_memberTemplate:GetPosY() - self._replayMemberUiOffsetY + (temp._memberBg:GetSizeY() + gab) * rightMemberCount)
          rightMemberCount = rightMemberCount + 1
          temp._memberBg:SetPosY(temp._memberBg:GetPosY() + 20 * rightTeamCount)
        end
        temp._teamNo = teamNo
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._circleBg:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Arsha_00.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(temp._circleBg, 942, 152, 1005, 215)
        temp._circleBg:getBaseTexture():setUV(x1, y1, x2, y2)
        temp._circleBg:setRenderTexture(temp._circleBg:getBaseTexture())
        temp._circleBg:SetPosX(temp._circleBg:GetPosX() - 2)
        temp._circleBg:SetPosY(temp._circleBg:GetPosY() - 4)
        temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
        temp._classIcon:SetSpanSize(2, -2)
        temp._classIcon:ComputePos()
        temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
        temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
        temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
        temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
        temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
        temp._isLeftTeam = not isLeftFull
        temp._buffList = {}
        for ii = 1, self._buffMaxCount do
          temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
        end
        self._teamMemberUi[teamNo][userIndex] = temp
      end
      if false == isLeftFull then
        leftTeamCount = leftTeamCount + 1
      else
        rightTeamCount = rightTeamCount + 1
      end
    end
    PaGlobalFunc_Arsha_Replay_Party_All_Setting(teamNo)
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._isCreate = true
  PaGlobalFunc_Arsha_Replay_Party_All_Open()
end
function PaGlobal_Arsha_Replay_Party_All:setting(teamNo)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local isArshaReplay = ToClient_IsArshaReplay()
  if true == isArshaReplay then
    return
  end
  local hpPercent = 0
  local adrenalinPoint = 0
  for index = 0, #self._teamMember[teamNo] do
    local userSlot = self._teamMemberUi[teamNo][index]
    local tempActorKey = self._teamMember[teamNo][index + 1]
    local playerActorProxyWrapper = getPlayerActor(tempActorKey)
    if nil ~= playerActorProxyWrapper and nil ~= userSlot then
      userSlot._memberBg:SetShow(true)
      userSlot._circleBg:SetShow(true)
      local classType = playerActorProxyWrapper:getClassType()
      userSlot._classIcon:SetShow(true)
      PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, classType)
      userSlot._gaugeRate:SetShow(false)
      userSlot._gaugeRate:SetText("")
      local userLevel = playerActorProxyWrapper:get():getLevel()
      local userName = playerActorProxyWrapper:getUserNickname()
      if 0 == ToClient_getChatNameType() then
        userName = playerActorProxyWrapper:getName()
      else
        userName = playerActorProxyWrapper:getUserNickname()
      end
      userSlot._name:SetShow(true)
      userSlot._name:SetText(userLevel .. " " .. userName)
      hpPercent = 100
      userSlot._progress:SetShow(true)
      userSlot._progress:SetProgressRate(hpPercent)
      userSlot._percent:SetShow(true)
      userSlot._percent:SetText(string.format("%.2f", hpPercent) .. "%")
      for ii = 1, self._buffMaxCount do
        userSlot._buffList[ii]:SetShow(false)
      end
    end
  end
end
function PaGlobal_Arsha_Replay_Party_All:setting_Personal(teamNo)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local hpPercent = 0
  local adrenalinPoint = 0
  local index = 0
  local userSlot = self._teamMemberUi[teamNo][index]
  local tempActorKey = self._teamMember[teamNo]
  local playerActorProxyWrapper = getPlayerActor(tempActorKey)
  if nil ~= playerActorProxyWrapper and nil ~= userSlot then
    userSlot._memberBg:SetShow(true)
    userSlot._circleBg:SetShow(true)
    local classType = playerActorProxyWrapper:getClassType()
    userSlot._classIcon:SetShow(true)
    PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, classType)
    userSlot._gaugeRate:SetShow(false)
    userSlot._gaugeRate:SetText("")
    local userLevel = playerActorProxyWrapper:get():getLevel()
    local userName = playerActorProxyWrapper:getUserNickname()
    if 0 == ToClient_getChatNameType() then
      userName = playerActorProxyWrapper:getName()
    else
      userName = playerActorProxyWrapper:getUserNickname()
    end
    userSlot._name:SetShow(true)
    userSlot._name:SetText(userLevel .. " " .. userName)
    hpPercent = 100
    userSlot._progress:SetShow(true)
    userSlot._progress:SetProgressRate(hpPercent)
    userSlot._percent:SetShow(true)
    userSlot._percent:SetText(string.format("%.2f", hpPercent) .. "%")
    for ii = 1, self._buffMaxCount do
      userSlot._buffList[ii]:SetShow(false)
    end
  end
  if nil ~= PaGlobal_Arsha_Hud_All then
    PaGlobalFunc_Arsha_Hud_All_settingPersonalForReplay(teamNo, tempActorKey)
  end
end
function PaGlobal_Arsha_Replay_Party_All:updateUserHP()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  if false == Panel_Widget_Arsha_Party_All:GetShow() then
    return
  end
  local isArshaReplay = ToClient_IsArshaReplay()
  if true == isArshaReplay then
    return
  end
  local hpPercent = 0
  for teamNo, teamMemberList in pairs(self._teamMember) do
    local teamUserCount = #teamMemberList
    for userIndex = 0, teamUserCount - 1 do
      local userSlot = self._teamMemberUi[teamNo][userIndex]
      local playerActorProxyWrapper = getPlayerActor(teamMemberList[userIndex + 1])
      if nil ~= playerActorProxyWrapper and nil ~= userSlot then
        local getHP = playerActorProxyWrapper:get():getHp()
        local getMaxHP = playerActorProxyWrapper:get():getMaxHp()
        if getHP > 0 and getMaxHP > 0 then
          hpPercent = getHP / getMaxHP * 100
        end
        if 0 == getHP then
          hpPercent = 0
        end
        userSlot._progress:SetProgressRate(hpPercent)
        userSlot._percent:SetText(string.format("%.2f", hpPercent) .. "%")
        if hpPercent <= 0 then
          userSlot._name:SetFontColor(Defines.Color.C_FFC4BEBE)
        else
          userSlot._name:SetFontColor(Defines.Color.C_FFFFEDD4)
        end
        local actorKey = teamMemberList[userIndex + 1]
        local skillCount = ToClient_getOhterUseSkillForTeamUiCount(actorKey)
        local skillNo = 0
        local remainTime = 0
        local skillIconPosX = 0
        local gabX = 5
        if true == userSlot._isLeftTeam then
          skillIconPosX = userSlot._progress:GetPosX() + userSlot._progress:GetSizeX()
        else
          skillIconPosX = userSlot._progress:GetPosX() - 15
        end
        if 0 == skillCount then
          for idx = 1, self._buffMaxCount do
            if nil ~= userSlot._buffList[idx] then
              userSlot._buffList[idx]:SetShow(false)
            end
          end
        else
          for idx = 0, skillCount - 1 do
            skillNo = ToClient_getOhterUseSkillNoForTeamUiByIndex(actorKey, idx)
            local skillCool = ToClient_getOhterSkillCoolTimeForTeamUiByIndex(actorKey, idx)
            local skillSSW = getSkillTypeStaticStatus(skillNo)
            if nil ~= userSlot._buffList[idx + 1] then
              local isExist = nil ~= skillSSW
              userSlot._buffList[idx + 1]:SetShow(isExist)
              if true == isExist then
                local skillName = skillSSW:getName()
                local skillIcon = skillSSW:getIconPath()
                if skillCool <= 0 then
                  userSlot._buffList[idx + 1]:SetShow(false)
                else
                  userSlot._buffList[idx + 1]:ChangeTextureInfoName("Icon/" .. skillIcon)
                  userSlot._buffList[idx + 1]:SetShow(true)
                end
                if true == userSlot._isLeftTeam then
                  skillIconPosX = skillIconPosX - userSlot._buffList[1]:GetSizeX() - gabX
                else
                  skillIconPosX = skillIconPosX + userSlot._buffList[1]:GetSizeX() + gabX
                end
                userSlot._buffList[idx + 1]:SetPosX(skillIconPosX)
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Arsha_Replay_Party_All:setMember(teamNo, actorKeyRaw)
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  do return end
  if nil == self._teamMember[teamNo] then
    self._teamMember[teamNo] = Array.new()
  end
  self._teamMember[teamNo]:push_back(actorKeyRaw)
end
function PaGlobal_Arsha_Replay_Party_All:createTeamUi_Personal()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local isReplay = ToClient_IsArshaReplay()
  if false == isReplay then
    return
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  local index = 0
  local replayTemaCirclePath = "Combine/Etc/Combine_Etc_Arsha_00.dds"
  if false == self._isCreatePersonal then
    for teamNo = 1, 2 do
      local attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
      local playerActorProxyWrapper = getPlayerActor(attendActorKey)
      local temp = {}
      local isLeftTeam = 1 == teamNo
      temp._teamNo = teamNo
      if true == isLeftTeam then
        temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. teamNo .. "_" .. index)
        temp._memberBg:SetPosY(self._ui._leftTeam.stc_memberTemplate:GetPosY())
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._circleBg:ChangeTextureInfoName(replayTemaCirclePath)
        local x1, y1, x2, y2 = setTextureUV_Func(temp._circleBg, 129, 152, 192, 215)
        temp._circleBg:getBaseTexture():setUV(x1, y1, x2, y2)
      else
        temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. teamNo .. "_" .. index)
        temp._memberBg:SetPosY(self._ui._rightTeam.stc_memberTemplate:GetPosY())
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._circleBg:ChangeTextureInfoName(replayTemaCirclePath)
        local x1, y1, x2, y2 = setTextureUV_Func(temp._circleBg, 1, 152, 64, 215)
        temp._circleBg:getBaseTexture():setUV(x1, y1, x2, y2)
      end
      temp._circleBg:setRenderTexture(temp._circleBg:getBaseTexture())
      temp._circleBg:SetPosX(temp._circleBg:GetPosX() - 2)
      temp._circleBg:SetPosY(temp._circleBg:GetPosY() - 4)
      temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
      temp._classIcon:SetSpanSize(2, -2)
      temp._classIcon:ComputePos()
      temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
      temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
      temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
      temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
      temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
      temp._isLeftTeam = isLeftTeam
      temp._buffList = {}
      for ii = 1, self._buffMaxCount do
        temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
      end
      self._teamMember[teamNo] = attendActorKey
      self._teamMemberUi[teamNo][index] = temp
      PaGlobalFunc_Arsha_Replay_Party_All_Setting_Personal(teamNo)
    end
    PaGlobalFunc_Arsha_Replay_Party_All_Open()
  else
    for teamNo = 1, 2 do
      local attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
      self._teamMember[teamNo] = attendActorKey
      PaGlobalFunc_Arsha_Replay_Party_All_Setting_Personal(teamNo)
    end
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._leftTeam.stc_teamNameBg:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_teamNameBg:SetShow(false)
  self._isCreatePersonal = true
end
function PaGlobal_Arsha_Replay_Party_All:updateUserHP_Personal()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  if false == Panel_Widget_Arsha_Party_All:GetShow() then
    return
  end
  if true == self._isFinish then
    return
  end
  local hpPercent = 0
  for teamNo = 1, 2 do
    local userSlot = self._teamMemberUi[teamNo][0]
    local attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
    local playerActorProxyWrapper = getPlayerActor(attendActorKey)
    if nil ~= playerActorProxyWrapper and nil ~= userSlot then
      local getHP = playerActorProxyWrapper:get():getHp()
      local getMaxHP = playerActorProxyWrapper:get():getMaxHp()
      if getHP > 0 and getMaxHP > 0 then
        hpPercent = getHP / getMaxHP * 100
      end
      if 0 == getHP then
        hpPercent = 0
      end
      userSlot._progress:SetProgressRate(hpPercent)
      userSlot._percent:SetText(string.format("%.2f", hpPercent) .. "%")
      if hpPercent <= 0 then
        userSlot._name:SetFontColor(Defines.Color.C_FFC4BEBE)
      else
        userSlot._name:SetFontColor(Defines.Color.C_FFFFEDD4)
      end
      if nil ~= PaGlobal_Arsha_Hud_All then
        PaGlobalFunc_Arsha_Hud_All_updateUserHp_PersonalForReplay(teamNo, attendActorKey)
      end
      local skillCount = ToClient_getOhterUseSkillForTeamUiCount(attendActorKey)
      local skillNo = 0
      local remainTime = 0
      local skillIconPosX = 0
      local gabX = 5
      if true == userSlot._isLeftTeam then
        skillIconPosX = userSlot._progress:GetPosX() + userSlot._progress:GetSizeX()
      else
        skillIconPosX = userSlot._progress:GetPosX() - 15
      end
      if 0 == skillCount then
        for idx = 1, self._buffMaxCount do
          if nil ~= userSlot._buffList[idx] then
            userSlot._buffList[idx]:SetShow(false)
            if true == self._isCreatePersonal then
              PaGlobalFunc_Arsha_Hud_All_setShowBuffForPersonal(false, teamNo, idx, "")
            end
          end
        end
      else
        for idx = 0, skillCount - 1 do
          skillNo = ToClient_getOhterUseSkillNoForTeamUiByIndex(attendActorKey, idx)
          local skillCool = ToClient_getOhterSkillCoolTimeForTeamUiByIndex(attendActorKey, idx)
          local skillSSW = getSkillTypeStaticStatus(skillNo)
          if nil ~= userSlot._buffList[idx + 1] then
            local isExist = nil ~= skillSSW
            userSlot._buffList[idx + 1]:SetShow(isExist)
            if true == isExist then
              local skillName = skillSSW:getName()
              local skillIcon = skillSSW:getIconPath()
              if skillCool <= 0 then
                userSlot._buffList[idx + 1]:SetShow(false)
                if true == self._isCreatePersonal then
                  PaGlobalFunc_Arsha_Hud_All_setShowBuffForPersonal(false, teamNo, idx + 1, "")
                end
              elseif true == self._isCreatePersonal then
                PaGlobalFunc_Arsha_Hud_All_setShowBuffForPersonal(true, teamNo, idx + 1, "Icon/" .. skillIcon)
              else
                userSlot._buffList[idx + 1]:ChangeTextureInfoName("Icon/" .. skillIcon)
                userSlot._buffList[idx + 1]:SetShow(true)
              end
              if true == userSlot._isLeftTeam then
                skillIconPosX = skillIconPosX - userSlot._buffList[1]:GetSizeX() - gabX
              else
                skillIconPosX = skillIconPosX + userSlot._buffList[1]:GetSizeX() + gabX
              end
              userSlot._buffList[idx + 1]:SetPosX(skillIconPosX)
            end
          end
        end
      end
    end
  end
end
function PaGlobal_Arsha_Replay_Party_All:clearTeamUi()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  local isReplay = ToClient_IsArshaReplay()
  if false == isReplay then
    return
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
  self._ui._leftTeam.stc_teamNameBg:SetShow(false)
  self._ui._rightTeam.stc_teamNameBg:SetShow(false)
end
function PaGlobal_Arsha_Replay_Party_All:updateScore(teamNo, score)
  local self = PaGlobal_Arsha_Replay_Party_All
  if nil ~= PaGlobal_Arsha_Hud_All then
    local isReplayMode = ToClient_IsPlayingReplay()
    if true == isReplayMode then
      self._leftScore = 0
      self._rightScore = 0
      if 1 == teamNo then
        self._leftScore = 1
      else
        self._rightScore = 1
      end
      PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(tostring(self._leftScore))
      PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(tostring(self._rightScore))
    end
  end
end
function PaGlobal_Arsha_Replay_Party_All:updateFightState(state, isNotify)
  local isReplayMode = ToClient_IsPlayingReplay()
  if false == isReplayMode then
    return
  end
  local self = PaGlobal_Arsha_Replay_Party_All
  PaGlobal_Arsha_Hud_All._ui.txt_teamOneLeftPoint:SetShow(false)
  PaGlobal_Arsha_Hud_All._ui.txt_teamOneRightPoint:SetShow(false)
  if nil ~= PaGlobal_Arsha_Hud_All then
    if CppEnums.CompetitionFightState.eCompetitionFightState_Fight == state then
      local str = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_COMPETITION_ALIVECOUNT_SCORE", "aliveCount", 1)
      PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneLeftPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneRightPoint:SetText(str)
    elseif CppEnums.CompetitionFightState.eCompetitionFightState_Done == state then
      PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(tostring(self._leftScore))
      PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(tostring(self._rightScore))
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneLeftPoint:SetText(tostring(self._leftScore))
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneRightPoint:SetText(tostring(self._rightScore))
    else
      local str = PAGetString(Defines.StringSheet_GAME, "LUA_COMPETITION_WAITING")
      PaGlobal_Arsha_Hud_All._ui.txt_leftPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_rightPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneLeftPoint:SetText(str)
      PaGlobal_Arsha_Hud_All._ui.txt_teamOneRightPoint:SetText(str)
    end
  end
end
function PaGlobal_Arsha_Replay_Party_All:AlertRemainHp(teamNo, score, redTeamHp, blueTeamHp)
  local isReplayMode = ToClient_IsPlayingReplay()
  if false == isReplayMode then
    return
  end
  local winHpPoint = string.format("%.2f", redTeamHp)
  local loseHpPoint = string.format("%.2f", blueTeamHp)
  local hpA = winHpPoint
  local hpB = loseHpPoint
  local redTeamName, blueTeamName
  if 0 == teamNo and 0 == score then
    for idx = 1, 2 do
      local userSlot = self._teamMemberUi[idx][0]
      local tempActorKey = self._teamMember[idx]
      local playerActorProxyWrapper = getPlayerActor(tempActorKey)
      if nil ~= playerActorProxyWrapper and nil ~= userSlot then
        if 1 == idx then
          userSlot._percent:SetText(winHpPoint .. "%")
          redTeamName = playerActorProxyWrapper:getUserNickname()
          PaGlobal_Arsha_Hud_All._ui.txt_teamOneRedHpPercent:SetText(winHpPoint .. "%")
        else
          userSlot._percent:SetText(loseHpPoint .. "%")
          blueTeamName = playerActorProxyWrapper:getUserNickname()
          PaGlobal_Arsha_Hud_All._ui.txt_teamOneBlueHpPercent:SetText(loseHpPoint .. "%")
        end
      end
    end
  else
    for idx = 1, 2 do
      local userSlot = self._teamMemberUi[idx][0]
      local tempActorKey = self._teamMember[idx]
      local playerActorProxyWrapper = getPlayerActor(tempActorKey)
      if nil ~= playerActorProxyWrapper and nil ~= userSlot then
        if 1 == teamNo then
          if 1 == idx then
            userSlot._percent:SetText(winHpPoint .. "%")
            redTeamName = playerActorProxyWrapper:getUserNickname()
            PaGlobal_Arsha_Hud_All._ui.txt_teamOneRedHpPercent:SetText(winHpPoint .. "%")
          else
            userSlot._percent:SetText(loseHpPoint .. "%")
            blueTeamName = playerActorProxyWrapper:getUserNickname()
            PaGlobal_Arsha_Hud_All._ui.txt_teamOneBlueHpPercent:SetText(loseHpPoint .. "%")
          end
        elseif 1 == idx then
          userSlot._percent:SetText(loseHpPoint .. "%")
          redTeamName = playerActorProxyWrapper:getUserNickname()
          hpA = loseHpPoint
          PaGlobal_Arsha_Hud_All._ui.txt_teamOneRedHpPercent:SetText(loseHpPoint .. "%")
        else
          userSlot._percent:SetText(winHpPoint .. "%")
          blueTeamName = playerActorProxyWrapper:getUserNickname()
          hpB = winHpPoint
          PaGlobal_Arsha_Hud_All._ui.txt_teamOneBlueHpPercent:SetText(winHpPoint .. "%")
        end
      end
    end
  end
  local posX = (getOriginScreenSizeX() - Panel_NakMessage:GetSizeX()) * 0.5
  local posY = 200
  local str = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_ARSHA_REMAIN_PERCENT_HP", "redTeamName", redTeamName, "hpA", hpA, "blueTeamName", blueTeamName, "hpB", hpB)
  Proc_ShowMessage_Ack(str, 5, posX, posY)
  self._isFinish = true
end
function PaGlobal_Arsha_Replay_Party_All:registEventHandler()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  registerEvent("FromClient_SetReplayMember", "FromClient_Arsha_Party_All_SetMember")
  registerEvent("FromClient_UpdateReplayMemberHP", "FromClient_Arsha_Replay_Party_All_UpdateUserHP")
  registerEvent("FromClient_OpenReplayTeamUi", "FromClient_Arsha_Replay_Party_All_Create")
  registerEvent("FromClient_CloseReplayTeamUi", "FromClient_Arsha_Replay_Party_All_Close")
  registerEvent("FromClient_OpenReplayTeamUi_Personal", "FromClient_Arsha_Replay_Party_All_Create_Personal")
  registerEvent("FromClient_ClearReplayTeamUi", "FromClient_Arsha_Replay_Party_All_Clear")
  registerEvent("FromClient_UpdateTeamScoreForReplay", "FromClient_Arsha_Replay_Party_All_UpdateScore")
  registerEvent("FromClient_UpdateFightStateForReplay", "FromClient_Arsha_Replay_Party_All_UpdateFightState")
  registerEvent("FromClient_ReplayArshaAlertRemainHp", "FromClient_Arsha_Replay_Party_All_AlertRemainHp")
end
function PaGlobal_Arsha_Replay_Party_All:validate()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  self._ui._leftTeam.stc_mainBg:isValidate()
  self._ui._leftTeam.stc_teamNameBg:isValidate()
  self._ui._leftTeam.txt_teamName:isValidate()
  self._ui._leftTeam.stc_memberTemplate:isValidate()
  self._ui._rightTeam.stc_mainBg:isValidate()
  self._ui._rightTeam.stc_teamNameBg:isValidate()
  self._ui._rightTeam.txt_teamName:isValidate()
  self._ui._rightTeam.stc_memberTemplate:isValidate()
end
function PaGlobal_Arsha_Replay_Party_All:resize()
  if nil == Panel_Widget_Arsha_Party_All then
    return
  end
  Panel_Widget_Arsha_Party_All:SetSize(getScreenSizeX(), Panel_Widget_Arsha_Party_All:GetSizeY())
  Panel_Widget_Arsha_Party_All:ComputePos()
  self._ui._leftTeam.stc_mainBg:ComputePos()
  self._ui._rightTeam.stc_mainBg:ComputePos()
end
