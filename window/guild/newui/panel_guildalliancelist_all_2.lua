function PaGlobalFunc_GuildAllianceList_All_Open()
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    PaGlobal_GuildMain_All._ui.stc_AllianceList_Bg:SetShow(false)
    return
  end
  PaGlobal_GuildAllianceList_All:clearSortSetting()
  PaGlobal_GuildAllianceList_All._currentClickGuild = -1
  PaGlobal_GuildAllianceList_All:UpdateAliyNotice(myAllianceWrapper)
  PaGlobal_GuildAllianceList_All:update()
  HandleEventOn_GuildAlliance_All_ResetScrollPos()
end
function PaGlobalFunc_GuildAllianceList_All_ResetUrl()
  if true == _ContentsGroup_RenewUI then
    return
  end
  if nil ~= PaGlobal_GuildAllianceList_All._ui.stc_webControl then
    PaGlobal_GuildAllianceList_All._ui.stc_webControl:ResetUrl()
  end
end
function HandleEventLUp_GuildAllianceList_All_SetGuildMemberShow(index)
  if nil == index then
    return
  end
  local myAllianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == myAllianceWrapper then
    return
  end
  if nil == PaGlobal_GuildAllianceList_All._ui._chkBox[index] then
    return
  end
  local btn = PaGlobal_GuildAllianceList_All._ui._chkBox[index]
  if PaGlobal_GuildAllianceList_All._currentClickGuild == index then
    btn:SetCheck(false)
    PaGlobal_GuildAllianceList_All._currentClickGuild = -1
    PaGlobal_GuildAllianceList_All:updateAllGuildMember()
    return
  else
    local guildWrapper = myAllianceWrapper:getMemberGuild(Int64toInt32(index))
    if nil ~= guildWrapper then
      PaGlobal_GuildAllianceList_All._currentClickGuild = index
      btn:SetCheck(true)
      PaGlobal_GuildAllianceList_All:updateAllGuildMember()
    end
  end
end
function FromClient_GuildAlliance_All_List2GuildUpdate(content, key)
  if nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local btn = UI.getChildControl(content, "Button_Party")
  local masterIcon = UI.getChildControl(btn, "Static_MasterIcon")
  local guildName = UI.getChildControl(btn, "StaticText_GuildName")
  local memberCount = UI.getChildControl(btn, "StaticText_GuildMember")
  local curIdx = PaGlobal_GuildAllianceList_All._currentClickGuild
  btn:SetCheck(false)
  if key32 == curIdx then
    btn:SetCheck(true)
  end
  btn:SetShow(false)
  masterIcon:SetShow(false)
  local allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == allianceWrapper then
    return
  end
  local guildWrapper = allianceWrapper:getMemberGuild(key32)
  if nil == guildWrapper then
    return
  end
  local isAllianceChairman = guildWrapper:isAllianceChair()
  btn:SetShow(true)
  masterIcon:SetShow(isAllianceChairman)
  if true == isAllianceChairman then
    guildName:SetFontColor(Defines.Color.C_FFF5BA3A)
    memberCount:SetFontColor(Defines.Color.C_FFF5BA3A)
  else
    guildName:SetFontColor(Defines.Color.C_FFEFEFEF)
    memberCount:SetFontColor(Defines.Color.C_FFEFEFEF)
  end
  guildName:SetText(guildWrapper:getName())
  memberCount:SetText(guildWrapper:getMemberCount())
  btn:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildAllianceList_All_SetGuildMemberShow(" .. key32 .. ")")
  PaGlobal_GuildAllianceList_All._ui._chkBox[key32] = btn
end
function FromClient_GuildAlliance_All_List2MemberUpdate(content, key)
  if nil == key then
    return
  end
  local key32 = Int64toInt32(key)
  local stc_tempList = UI.getChildControl(content, "Static_List_Temp")
  local stc_gradeIcon = UI.getChildControl(stc_tempList, "StaticText_C_Grade")
  local txt_level = UI.getChildControl(stc_tempList, "StaticText_C_Level")
  local txt_class = UI.getChildControl(stc_tempList, "StaticText_C_Class")
  local txt_famName = UI.getChildControl(stc_tempList, "StaticText_C_CharName")
  local txt_guildName = UI.getChildControl(stc_tempList, "StaticText_C_GuildName")
  stc_tempList:SetShow(false)
  stc_tempList:SetIgnore(false)
  stc_tempList:addInputEvent("Mouse_On", "HandleEventOn_GuildAlliance_All_SaveScrollPos()")
  local allianceWrapper = ToClient_GetMyGuildAllianceWrapper()
  if nil == allianceWrapper then
    return
  end
  local member = allianceWrapper:getMemberByUserNo(key)
  if nil == member then
    return
  end
  local guild = member:getGuildName()
  local grade = member:getGrade()
  local level = member:getLevel()
  local classType = CppEnums.ClassType2String[member:getClassType()]
  local nickName = member:getName()
  local isOnline = member:isOnline()
  local isGhostMode = member:isGhostMode()
  local isVacation = member:isVacation()
  local classString = "-"
  local levelString = "-"
  local charString = "-"
  local gradeTooltipType
  stc_tempList:SetShow(true)
  if true == isVacation then
    gradeTooltipType = -1
    stc_gradeIcon:SetMonoTone(true)
    txt_level:SetFontColor(Defines.Color.C_FF515151)
    txt_class:SetFontColor(Defines.Color.C_FF515151)
    txt_famName:SetFontColor(Defines.Color.C_FF515151)
    txt_guildName:SetFontColor(Defines.Color.C_FF515151)
  else
    stc_gradeIcon:SetMonoTone(false)
    txt_level:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_class:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_famName:SetFontColor(Defines.Color.C_FFC4BEBE)
    txt_guildName:SetFontColor(Defines.Color.C_FFC4BEBE)
  end
  if true == isOnline and false == isGhostMode then
    classString = classType
    levelString = level
  end
  txt_guildName:SetText(guild)
  txt_level:SetText(levelString)
  txt_class:SetText(classString)
  txt_famName:SetText(nickName)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  stc_gradeIcon:ChangeTextureInfoName("new_ui_common_forlua/window/guild/guild_00.dds")
  stc_gradeIcon:SetIgnore(false)
  if __eGuildMemberGradeMaster == grade then
    stc_gradeIcon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 224, 227, 267, 253)
    gradeTooltipType = 0
  elseif __eGuildMemberGradeAdviser == grade then
    stc_gradeIcon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 66, 1, 109, 27)
    gradeTooltipType = 6
  elseif __eGuildMemberGradeSubMaster == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 159, 511, 185)
    gradeTooltipType = 1
  elseif __eGuildMemberGradeNormal == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 219, 511, 245)
    gradeTooltipType = 2
  elseif __eGuildMemberGradeSupplyOfficer == grade then
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 424, 219, 467, 245)
    gradeTooltipType = 3
  elseif __eGuildMemberGradeGunner == grade then
    stc_gradeIcon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 66, 28, 109, 54)
    gradeTooltipType = 7
  elseif __eGuildMemberGradeJunior == grade then
    stc_gradeIcon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Guild_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 1, 83, 44, 109)
    gradeTooltipType = 4
  else
    x1, y1, x2, y2 = setTextureUV_Func(stc_gradeIcon, 468, 219, 511, 245)
  end
  stc_gradeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_gradeIcon:setRenderTexture(stc_gradeIcon:getBaseTexture())
  if nil == gradeTooltipType then
    stc_gradeIcon:addInputEvent("Mouse_On", "")
    stc_gradeIcon:addInputEvent("Mouse_Out", "")
  else
    stc_gradeIcon:addInputEvent("Mouse_On", "HandleEventOnOut_GuildAlliance_All_GradeTooltip(" .. key32 .. "," .. gradeTooltipType .. ")")
    stc_gradeIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_GuildAlliance_All_GradeTooltip()")
  end
  PaGlobal_GuildAllianceList_All._ui._list2UI[key32] = stc_gradeIcon
end
function HandleEventOnOut_GuildAlliance_All_TerritortyTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name
  control = PaGlobal_GuildAllianceList_All._ui.txt_Territory
  name = PaGlobal_GuildAllianceList_All._ui.txt_Territory:GetText()
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOnOut_GuildAlliance_All_GradeTooltip(index, type)
  if nil == type or nil == index then
    TooltipSimple_Hide()
    return
  end
  local control, name
  control = PaGlobal_GuildAllianceList_All._ui._list2UI[index]
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  name = PAGetString(Defines.StringSheet_GAME, PaGlobal_GuildAllianceList_All._gradeString[type])
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOn_GuildAlliance_All_SaveScrollPos()
  PaGlobal_GuildAllianceList_All._scrollData._pos = PaGlobal_GuildAllianceList_All._ui.list2_Member:GetVScroll():GetControlPos()
  PaGlobal_GuildAllianceList_All._scrollData._idx = PaGlobal_GuildAllianceList_All._ui.list2_Member:getCurrenttoIndex()
end
function HandleEventOn_GuildAlliance_All_LoadScrollPos()
  if nil == PaGlobal_GuildAllianceList_All._scrollData._pos or nil == PaGlobal_GuildAllianceList_All._scrollData._idx then
    return
  end
  PaGlobal_GuildAllianceList_All._ui.list2_Member:GetVScroll():SetControlPos(PaGlobal_GuildAllianceList_All._scrollData._pos)
  PaGlobal_GuildAllianceList_All._ui.list2_Member:setCurrenttoIndex(PaGlobal_GuildAllianceList_All._scrollData._idx)
end
function HandleEventOn_GuildAlliance_All_ResetScrollPos()
  PaGlobal_GuildAllianceList_All._scrollData._pos = nil
  PaGlobal_GuildAllianceList_All._scrollData._idx = nil
end
function PaGlobalFunc_GuildAllianceList_All_RightCheck(eRightType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  local function OriginalCheck()
    local isGuildMaster = selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = selfPlayer:get():isGuildSubMaster()
    local isMasters = true == isGuildSubMaster or true == isGuildMaster
    if __eGuildRightType_TodayCommentAdmin == eRightType then
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
function HandleEventLUp_GuildAllianceList_All_ListSort(sortType)
  if nil == PaGlobal_GuildAllianceList_All._ui._titlelist[sortType] then
    return
  end
  if nil == PaGlobal_GuildAllianceList_All._listSort[sortType] then
    return
  end
  PaGlobal_GuildAllianceList_All._selectSortType = sortType
  PaGlobal_GuildAllianceList_All:titleBarStringClear()
  local control = PaGlobal_GuildAllianceList_All._ui._titlelist[sortType]
  if nil == control then
    return
  end
  local baseText = PaGlobal_GuildAllianceList_All._ui._titlelist[sortType]:GetText()
  if false == PaGlobal_GuildAllianceList_All._listSort[sortType] then
    control:SetText(baseText .. "\226\150\178")
    PaGlobal_GuildAllianceList_All._listSort[sortType] = true
  else
    control:SetText(baseText .. "\226\150\188")
    PaGlobal_GuildAllianceList_All._listSort[sortType] = false
  end
  PaGlobal_GuildAllianceList_All:updateAllGuildMember()
end
function guildAllianceListCompareGrade(w1, w2)
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
    if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
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
    if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
      return w1Grade < w2Grade
    else
      return w1Grade > w2Grade
    end
  end
  return false
end
function guildAllianceListCompareLev(w1, w2)
  if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
    if w2.level < w1.level then
      return true
    end
  elseif w1.level < w2.level then
    return true
  end
  return false
end
function guildAllianceListCompareClass(w1, w2)
  if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
    if -1 == stringCompare(w2.class, w1.class) then
      return true
    end
  elseif 1 == stringCompare(w2.class, w1.class) then
    return true
  end
  return false
end
function guildAllianceListCompareName(w1, w2)
  if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
    if -1 == stringCompare(w2.name, w1.name) then
      return true
    end
  elseif 1 == stringCompare(w2.name, w1.name) then
    return true
  end
  return false
end
function guildAllianceListCompareGuild(w1, w2)
  if true == PaGlobal_GuildAllianceList_All._listSort[PaGlobal_GuildAllianceList_All._selectSortType] then
    if -1 == stringCompare(w2.guild, w1.guild) then
      return true
    end
  elseif 1 == stringCompare(w2.guild, w1.guild) then
    return true
  end
  return false
end
