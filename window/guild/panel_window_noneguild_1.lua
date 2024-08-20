function PaGlobal_Guild_NoneGuild:init()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  local titleArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Close")
  local radioGroup = UI.getChildControl(Panel_Guild_NoneGuild, "Static_RadioGroup")
  self._ui._categoryType = Array.new()
  for ii = 0, __eCategoryType_Count - 1 do
    self._ui._categoryType[ii] = UI.getChildControl(radioGroup, "RadioButton_Tab" .. tostring(ii))
  end
  self._ui._stc_LBIcon = UI.getChildControl(radioGroup, "Static_SelectLB_C")
  self._ui._stc_RBIcon = UI.getChildControl(radioGroup, "Static_SelectRB_C")
  self._ui._stc_selectLine = UI.getChildControl(radioGroup, "Static_SelctLine")
  local leftArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_LeftArea")
  self._ui._btn_refresh = UI.getChildControl(leftArea, "Button_Refresh")
  self._ui._list2_guildList = UI.getChildControl(leftArea, "List2_GuildListBG")
  local content = UI.getChildControl(self._ui._list2_guildList, "List2_1_Content")
  local buttontemp = UI.getChildControl(content, "Button_GuildList_Temp")
  local name = UI.getChildControl(buttontemp, "StaticText_GuildName")
  self._listGuildNameOriginPosX = name:GetPosX()
  self._ui._txt_search = UI.getChildControl(leftArea, "Edit_Search")
  self._ui._btn_search = UI.getChildControl(self._ui._txt_search, "Button_Search")
  local static = UI.getChildControl(leftArea, "Static_1")
  self._ui._txt_sort_name = UI.getChildControl(static, "StaticText_GuildName")
  self._ui._txt_sort_name:SetIgnore(false)
  self._ui._txt_sort_membercount = UI.getChildControl(static, "StaticText_MemberCount")
  self._ui._txt_sort_membercount:SetIgnore(false)
  local rightArea = UI.getChildControl(Panel_Guild_NoneGuild, "Static_RightArea")
  self._ui._stc_edge = UI.getChildControl(rightArea, "Static_Edge")
  self._ui._stc_descBG = UI.getChildControl(self._ui._stc_edge, "Static_DescBG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_Desc")
  self._ui._txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
  if isGameTypeTaiwan() then
    self._ui._txt_desc:setLineCountByLimitAutoWrap(7)
  else
    self._ui._txt_desc:setLineCountByLimitAutoWrap(10)
  end
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_INFO"))
  self._ui._btn_applyJoin = UI.getChildControl(rightArea, "Button_ApplyJoin")
  self._ui._btn_guildInfo = UI.getChildControl(rightArea, "Button_GuildInfo")
  self._ui._btn_applyJoinList = UI.getChildControl(rightArea, "Button_ApplyJoinList")
  self._ui._btn_recommend = UI.getChildControl(rightArea, "CheckButton_Recommand")
  self._ui._btn_recommend:SetShow(false)
  self._ui._txt_noSelectGuild = UI.getChildControl(rightArea, "StaticText_NoSelectGuild")
  PaGlobal_Guild_NoneGuild:SwitchPlatform()
  self:clear()
  PaGlobal_Guild_NoneGuild:EventHandler()
end
function PaGlobal_Guild_NoneGuild:SwitchPlatform()
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_refresh:SetShow(false)
    self._ui._stc_LBIcon:SetShow(true)
    self._ui._stc_RBIcon:SetShow(true)
  else
  end
end
function PaGlobal_Guild_NoneGuild:EventHandler()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:close()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Guild_NoneGuild:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_Guild_NoneGuild:changeTabForPad(-1)")
    Panel_Guild_NoneGuild:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_Guild_NoneGuild:changeTabForPad(1)")
  else
    for ii = 0, __eCategoryType_Count - 1 do
      self._ui._categoryType[ii]:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:setSelected(" .. ii .. ")")
    end
  end
  self._ui._btn_refresh:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:Refresh()")
  self._ui._list2_guildList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Guild_NoneGuild_CreateControlList2")
  self._ui._list2_guildList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_applyJoinList:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:checkApplyListOpen()")
  self._ui._txt_sort_name:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:sortName(false)")
  self._ui._txt_sort_membercount:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:sortMemberCount(false)")
  self._ui._txt_search:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_NoneGuild_SetFocusEdit()")
  self._ui._txt_search:RegistReturnKeyEvent("PaGlobalFunc_Guild_NoneGuild_Search()")
  self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobalFunc_Guild_NoneGuild_Search()")
  registerEvent("FromClient_loadCompleteGuildPRList", "FromClient_loadCompleteGuildPRList")
  registerEvent("FromClient_updateGuildApplicant", "FromClient_updateGuildApplicant")
  registerEvent("FromClient_GuildInfoUpdateForGuildPR", "PaGlobal_GuildNoneGuild_GuildInfoUpdate")
  registerEvent("FromClient_GuildMarkUpdateForGuildPR", "PaGlobal_GuildNoneGuild_GuildMarkUpdate")
  Panel_Guild_NoneGuild:RegisterCloseLuaFunc(PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }), "PaGlobal_Guild_NoneGuild:checkApplyListClose()")
end
function PaGlobal_Guild_NoneGuild:open()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  Panel_Guild_NoneGuild:SetShow(true)
  self:clear()
  PaGlobal_Guild_NoneGuild:setSelected(0)
end
function PaGlobal_Guild_NoneGuild:close()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  PaGlobal_Guild_NoneGuild:clear()
  Panel_Guild_NoneGuild:SetShow(false)
end
function PaGlobal_Guild_NoneGuild:checkApplyListOpen()
  if true == self._isApplyListOpen then
    return
  end
  PaGlobal_GuildApplyJoinList:open()
  self._isApplyListOpen = true
end
function PaGlobal_Guild_NoneGuild:checkApplyListClose()
  if true == self._isApplyListOpen then
    PaGlobal_GuildApplyJoinList:close()
    self._isApplyListOpen = false
    return
  end
  PaGlobal_Guild_NoneGuild:close()
end
function PaGlobal_Guild_NoneGuild:setSelected(index)
  local self = PaGlobal_Guild_NoneGuild
  local isSame = self._selectedIndex == index
  if true == isSame then
    return
  end
  self._ui._txt_search:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_NONEGUILD_SEARCH_TXT"))
  ClearFocusEdit()
  if nil ~= self._selectedIndex and nil ~= self._ui._categoryType[self._selectedIndex] then
    self._ui._categoryType[self._selectedIndex]:SetCheck(false)
  end
  self._ui._categoryType[index]:SetCheck(true)
  self._selectedIndex = index
  if nil ~= self._lastOrder then
    if self._lastOrder == __eGuildPROrderType_Name then
      self:sortName(true)
    elseif self._lastOrder == __eGuildPROrderType_People then
      self:sortMemberCount(true)
    end
  end
  PaGlobal_Guild_NoneGuild._guildSlotIndex = -1
  local tabPosX = self._ui._categoryType[index]:GetPosX() + self._ui._categoryType[index]:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
  self._ui._stc_selectLine:SetPosX(tabPosX)
  self._ui._stc_edge:SetShow(false)
  self._ui._stc_descBG:SetShow(false)
  self._ui._btn_applyJoin:SetShow(false)
  self._ui._btn_guildInfo:SetShow(false)
  self._ui._txt_noSelectGuild:SetShow(true)
  self._isSearchList = false
  if true == _ContentsGroup_NewGuildNone then
    guildListSize = ToClient_getPriorityGuildPRShowIndexList(self._selectedIndex) + ToClient_getShowGuildPRListSize(self._selectedIndex)
  else
    guildListSize = ToClient_getGuildPRListSize(self._selectedIndex)
  end
  if guildListSize == 0 then
    ToClient_requestGuildPRList(self._selectedIndex, false)
  end
  self:update()
end
function PaGlobal_Guild_NoneGuild:changeTabForPad(moveDir)
  local nextTab = self._selectedIndex + moveDir
  if nextTab < 0 then
    nextTab = __eCategoryType_Count - 1
  elseif nextTab >= __eCategoryType_Count then
    nextTab = 0
  end
  self:setSelected(nextTab)
end
function PaGlobal_Guild_NoneGuild:update()
  if nil == Panel_Guild_NoneGuild then
    return
  end
  if false == Panel_Guild_NoneGuild:GetShow() then
    return
  end
  local self = PaGlobal_Guild_NoneGuild
  local guildListSize = 0
  if true == _ContentsGroup_NewGuildNone then
    guildListSize = ToClient_getPriorityGuildPRShowIndexList(self._selectedIndex) + ToClient_getShowGuildPRListSize(self._selectedIndex)
  else
    guildListSize = ToClient_getGuildPRListSize(self._selectedIndex)
  end
  self._ui._list2_guildList:getElementManager():clearKey()
  if guildListSize > 0 then
    for ii = 0, guildListSize - 1 do
      self._ui._list2_guildList:getElementManager():pushKey(ii)
    end
  end
  if true == _ContentsGroup_NewGuildNone and guildListSize > 0 then
    self:SetRightAreaInfo(0)
  end
  self._ui._list2_guildList:ComputePos()
end
function PaGlobal_Guild_NoneGuild_SetShow(isShow)
  if true == isShow then
    PaGlobal_Guild_NoneGuild:open()
  else
    PaGlobal_Guild_NoneGuild:close()
  end
end
function PaGlobal_Guild_NoneGuild:Refresh()
  local self = PaGlobal_Guild_NoneGuild
  self._isSearchList = false
  ToClient_requestGuildPRList(self._selectedIndex, true)
end
function PaGlobal_Guild_NoneGuild:SetRightAreaInfo(index)
  local self = PaGlobal_Guild_NoneGuild
  local wrapper
  if true == self._isSearchList then
    wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
  else
    wrapper = ToClient_getGuildPRInfoWrapper(self._selectedIndex, index)
  end
  if nil == wrapper then
    return
  end
  PaGlobal_Guild_NoneGuild._guildSlotIndex = index
  local stc_guildMark = UI.getChildControl(self._ui._stc_edge, "Static_GuildMark")
  local stc_mark = UI.getChildControl(stc_guildMark, "Static_Mark")
  local txt_guildName = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildName")
  local txt_guildMaster = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildMaster")
  local txt_guildSize = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildSize")
  local txt_guildPoint = UI.getChildControl(self._ui._stc_edge, "StaticText_GuildPoint")
  local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), stc_mark)
  if false == isSet then
    stc_mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_mark, 183, 1, 188, 6)
    stc_mark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_mark:setRenderTexture(stc_mark:getBaseTexture())
  else
    stc_mark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_mark:setRenderTexture(stc_mark:getBaseTexture())
  end
  txt_guildName:SetText(tostring(wrapper:getGuildName()))
  txt_guildMaster:SetText(tostring(wrapper:getGuildMasterUserNickName()))
  local guildWrapper = ToClient_GetGuildWrapperByGuildNo(wrapper:getGuildNo())
  if nil ~= guildWrapper then
    local introdutionText = guildWrapper:getGuildIntrodution()
    if 0 ~= string.len(introdutionText) then
      PaGlobal_Guild_NoneGuild._ui._txt_desc:SetText(introdutionText)
    else
      PaGlobal_Guild_NoneGuild._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_NO_INTRODUCE"))
    end
  else
    PaGlobal_Guild_NoneGuild._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_INFO"))
  end
  if PaGlobal_Guild_NoneGuild._ui._txt_desc:IsLimitText() then
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:SetIgnore(false)
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:addInputEvent("Mouse_On", "PaGlobal_GuildNoneGuild_GuildIntroduceLimitToolTip(" .. index .. ",true)")
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:addInputEvent("Mouse_Out", "PaGlobal_GuildNoneGuild_GuildIntroduceLimitToolTip(" .. index .. ",false)")
  else
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:SetIgnore(true)
  end
  local guildRankString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDRANK")
  local guildSizeString = ""
  local guildMemberCount = wrapper:getMemberCount()
  if guildMemberCount < 31 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_SMALL")
  elseif guildMemberCount < 51 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_MIDDLE")
  elseif guildMemberCount < 76 then
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIG")
  else
    guildSizeString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_QUEST_BIGGEST")
  end
  txt_guildSize:SetText(guildRankString .. " " .. guildSizeString)
  local expString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDBATTLE_GUILDSCORE")
  txt_guildPoint:SetText(expString .. " : " .. tostring(wrapper:getAquiredSkillPoint()))
  self._ui._btn_applyJoin:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:requestGuildApplicant(" .. self._selectedIndex .. "," .. index .. ")")
  self._ui._btn_guildInfo:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:requestDetailGuildInfo(" .. self._selectedIndex .. "," .. index .. ")")
  self._ui._stc_edge:SetShow(true)
  self._ui._stc_descBG:SetShow(true)
  self._ui._btn_applyJoin:SetShow(true)
  self._ui._btn_guildInfo:SetShow(true)
  if true == _ContentsGroup_NewGuildNone then
    local isRecommand = ToClient_GetRecommandGuildNo() == wrapper:getGuildNo()
    self._ui._btn_recommend:SetCheck(isRecommand)
    local guildRecommendCount = wrapper:getRecommendCount()
    self._ui._btn_recommend:SetText(tostring(guildRecommendCount))
    self._ui._btn_recommend:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:recommandGuild(" .. index .. ")")
  end
  self._ui._txt_noSelectGuild:SetShow(false)
end
function PaGlobal_Guild_NoneGuild:clear()
  local self = PaGlobal_Guild_NoneGuild
  self._selectedIndex = -1
  self._guildSlotIndex = -1
  for ii = 0, __eCategoryType_Count - 1 do
    self._ui._categoryType[ii]:SetCheck(false)
  end
  self._ui._categoryType[0]:SetCheck(true)
  local tabPosX = self._ui._categoryType[0]:GetPosX() + self._ui._categoryType[0]:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2
  self._ui._stc_selectLine:SetPosX(tabPosX)
  self._ui._stc_edge:SetShow(false)
  self._ui._stc_descBG:SetShow(false)
  self._ui._btn_applyJoin:SetShow(false)
  self._ui._btn_guildInfo:SetShow(false)
  self._ui._btn_recommend:SetShow(false)
  if false == _ContentsGroup_NewGuildNone then
    self._ui._txt_sort_name:SetShow(false)
    self._ui._txt_sort_membercount:SetShow(false)
    self._ui._txt_search:SetShow(false)
    self._ui._btn_search:SetShow(false)
  end
  self._ui._txt_noSelectGuild:SetShow(true)
end
function PaGlobal_Guild_NoneGuild:requestPRList()
  local self = PaGlobal_Guild_NoneGuild
end
function PaGlobal_Guild_NoneGuild:requestGuildApplicant(selectedCategory, index)
  local selfPlayerProxy = getSelfPlayer()
  if nil == selfPlayerProxy then
    return
  end
  if nil == PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange then
    return
  end
  local isAppliedNickNameChange = PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange()
  if false == isAppliedNickNameChange then
    return
  end
  local function requestUpdateGuildApplicant()
    if true == _ContentsGroup_NewGuildNone then
      if false == PaGlobal_Guild_NoneGuild._isSearchList then
        PaGlobal_GuildIntroduceMySelf_Open(selectedCategory, index, PaGlobal_Guild_NoneGuild._isSearchList)
      else
        PaGlobal_GuildIntroduceMySelf_Open(selectedCategory, index, PaGlobal_Guild_NoneGuild._isSearchList)
      end
    elseif false == PaGlobal_Guild_NoneGuild._isSearchList then
      ToClient_requestUpdateGuildApplicant(__eGuildApplicantType_Insert, selectedCategory, index, "\236\167\128\236\155\144\237\149\152\234\184\176", false)
    else
      ToClient_requestUpdateGuildApplicant(__eGuildApplicantType_Insert, selectedCategory, index, "\236\167\128\236\155\144\237\149\152\234\184\176", true)
    end
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERTITLE")
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERCONFIRM")
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = requestUpdateGuildApplicant,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Guild_NoneGuild:requestDetailGuildInfo(categoryType, index)
  local info
  if true == self._isSearchList then
    info = ToClient_getSearchGuildPRListInfoWrapper(index)
  else
    info = ToClient_getGuildPRInfoWrapper(categoryType, index)
  end
  if nil == info then
    return
  end
  local strGuildNo = tostring(info:getGuildNo())
  FGlobal_GuildWebInfoForGuildRank_Open(strGuildNo)
end
function PaGlobal_Guild_NoneGuild:sortName(isChange)
  if true == self._isSearchList then
    return
  end
  self._lastOrder = __eGuildPROrderType_Name
  if false == isChange then
    self._nameSort = not self._nameSort
  end
  ToClient_ReorderingFromType(self._selectedIndex, __eGuildPROrderType_Name, self._nameSort)
  self._ui._txt_sort_membercount:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SIZETITLE"))
  if false == self._nameSort then
    self._ui._txt_sort_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDNAME") .. "\226\150\188")
  else
    self._ui._txt_sort_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDNAME") .. "\226\150\178")
  end
  self:update()
end
function PaGlobal_Guild_NoneGuild:sortMemberCount(isChange)
  if true == self._isSearchList then
    return
  end
  self._lastOrder = __eGuildPROrderType_People
  if false == isChange then
    self._membercountSort = not self._membercountSort
  end
  ToClient_ReorderingFromType(self._selectedIndex, __eGuildPROrderType_People, self._membercountSort)
  self._ui._txt_sort_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_GUILDNAME"))
  if false == self._membercountSort then
    self._ui._txt_sort_membercount:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SIZETITLE") .. "\226\150\188")
  else
    self._ui._txt_sort_membercount:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_SIZETITLE") .. "\226\150\178")
  end
  self:update()
end
function PaGlobal_Guild_NoneGuild:recommandGuild(index)
  local wrapper
  if true == self._isSearchList then
    wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
  else
    wrapper = ToClient_getGuildPRInfoWrapper(self._selectedIndex, index)
  end
  if nil == wrapper then
    return
  end
  if false == ToClient_GetIsRecommand() then
    ToClient_GuildRecommend(wrapper:getGuildNo(), true)
  elseif wrapper:getGuildNo() == ToClient_GetRecommandGuildNo() then
    local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RECOMMAND_CANCEL", "guildName", wrapper:getGuildName())
    local MessageBoxYesFunc = function()
      ToClient_CancelGuildRecommend(true)
    end
    local MessageBoxNoFunc = function()
      PaGlobal_Guild_NoneGuild._ui._btn_recommend:SetCheck(false)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = contentString,
      functionYes = MessageBoxYesFunc,
      functionNo = MessageBoxNoFunc,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    local guildName = ""
    local beforeGuildPRWrpper = ToClient_getGuildPRInfoWrapperByGuildNo(ToClient_GetRecommandGuildNo())
    if nil ~= beforeGuildPRWrpper then
      guildName = beforeGuildPRWrpper:getGuildName()
    end
    local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ALREADY_RECOMMAND_CANCEL", "beforeguildName", guildName, "guildName", wrapper:getGuildName())
    local function MessageBoxYesFunc()
      ToClient_GuildRecommend(wrapper:getGuildNo(), true)
    end
    local MessageBoxNoFunc = function()
      PaGlobal_Guild_NoneGuild._ui._btn_recommend:SetCheck(false)
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = contentString,
      functionYes = MessageBoxYesFunc,
      functionNo = MessageBoxNoFunc,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
