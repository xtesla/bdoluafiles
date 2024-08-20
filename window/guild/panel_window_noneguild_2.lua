function PaGlobal_Guild_NoneGuild_CreateControlList2(content, index)
  local self = PaGlobal_Guild_NoneGuild
  local key = Int64toInt32(index)
  local wrapper
  if true == self._isSearchList then
    wrapper = ToClient_getSearchGuildPRListInfoWrapper(key)
  else
    wrapper = ToClient_getGuildPRInfoWrapper(self._selectedIndex, key)
  end
  if nil == wrapper then
    return
  end
  local btn_guildList = UI.getChildControl(content, "Button_GuildList_Temp")
  btn_guildList:SetCheck(key == PaGlobal_Guild_NoneGuild._guildSlotIndex)
  btn_guildList:setNotImpactScrollEvent(true)
  local stc_guildMark = UI.getChildControl(btn_guildList, "Static_GuildMark")
  local txt_guildName = UI.getChildControl(btn_guildList, "StaticText_GuildName")
  local txt_guildMemberCount = UI.getChildControl(btn_guildList, "StaticText_GuildMemberCount")
  local stc_supportMark = UI.getChildControl(btn_guildList, "Static_Supporters")
  if true == _ContentsGroup_NewGuildNone then
    local isPriorityPR = ToClient_isPriorityGuildPR(self._selectedIndex, wrapper:getGuildNo())
    if true == isPriorityPR then
      stc_supportMark:SetShow(true)
      txt_guildName:SetPosX(PaGlobal_Guild_NoneGuild._listGuildNameOriginPosX + stc_supportMark:GetSizeX() + 5)
    else
      stc_supportMark:SetShow(false)
      txt_guildName:SetPosX(PaGlobal_Guild_NoneGuild._listGuildNameOriginPosX)
    end
  else
    stc_supportMark:SetShow(false)
  end
  local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), stc_guildMark)
  if false == isSet then
    ToClient_RequestGuildMark(wrapper:getGuildNo())
    stc_guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_guildMark, 183, 1, 188, 6)
    stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  else
    stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  end
  txt_guildName:SetText(wrapper:getGuildName())
  txt_guildName:SetIgnore(true)
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
  txt_guildMemberCount:SetText(tostring(guildSizeString))
  btn_guildList:addInputEvent("Mouse_LUp", "PaGlobal_Guild_NoneGuild:SetRightAreaInfo(" .. key .. ")")
end
function FromClient_loadCompleteGuildPRList()
  PaGlobal_Guild_NoneGuild:update()
end
function PaGlobal_GuildNoneGuild_GuildIntroduceLimitToolTip(index, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_Guild_NoneGuild._isSearchList then
    wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
  else
    wrapper = ToClient_getGuildPRInfoWrapper(PaGlobal_Guild_NoneGuild._selectedIndex, index)
  end
  if nil == wrapper then
    return
  end
  local guildWrapper = ToClient_GetGuildWrapperByGuildNo(wrapper:getGuildNo())
  if nil ~= guildWrapper then
    local introdutionText = guildWrapper:getGuildIntrodution()
    TooltipSimple_Show(PaGlobal_Guild_NoneGuild._ui._txt_desc, "", introdutionText)
  end
end
function FromClient_updateGuildApplicant(guildNo, applicantType)
  if __eGuildApplicantType_Insert == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERJOINCOMPLETE"))
  elseif __eGuildApplicantType_Delete_User == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_USERDELETECOMPLETE"))
  elseif __eGuildApplicantType_Delete_Guild == applicantType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_GUILDDELETEUSERCOMPLETE"))
  end
end
function PaGlobal_GuildNoneGuild_GuildInfoUpdate(guildNo)
  if nil == Panel_Guild_NoneGuild then
    return
  end
  local self = PaGlobal_Guild_NoneGuild
  local index = PaGlobal_Guild_NoneGuild._guildSlotIndex
  local Wrapper
  if true == PaGlobal_Guild_NoneGuild._isSearchList then
    Wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
  else
    Wrapper = ToClient_getGuildPRInfoWrapper(PaGlobal_Guild_NoneGuild._selectedIndex, index)
  end
  if nil == Wrapper then
    return
  end
  if Wrapper:getGuildNo() ~= guildNo then
    return
  end
  local guildWrapper = ToClient_GetGuildWrapperByGuildNo(Wrapper:getGuildNo())
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
end
function PaGlobal_GuildNoneGuild_GuildMarkUpdate(guildNo)
  local rightInfoIndex = PaGlobal_Guild_NoneGuild._guildSlotIndex
  local RightWrapper
  if true == PaGlobal_Guild_NoneGuild._isSearchList then
    RightWrapper = ToClient_getSearchGuildPRListInfoWrapper(rightInfoIndex)
  else
    RightWrapper = ToClient_getGuildPRInfoWrapper(PaGlobal_Guild_NoneGuild._selectedIndex, rightInfoIndex)
  end
  if nil ~= RightWrapper then
    local stc_guildMark = UI.getChildControl(PaGlobal_Guild_NoneGuild._ui._stc_edge, "Static_GuildMark")
    local stc_mark = UI.getChildControl(stc_guildMark, "Static_Mark")
    local isSet = setGuildTextureByGuildNo(RightWrapper:getGuildNo(), stc_mark)
    if false == isSet then
      stc_mark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(stc_mark, 183, 1, 188, 6)
      stc_mark:getBaseTexture():setUV(x1, y1, x2, y2)
      stc_mark:setRenderTexture(stc_mark:getBaseTexture())
    else
      stc_mark:getBaseTexture():setUV(0, 0, 1, 1)
      stc_mark:setRenderTexture(stc_mark:getBaseTexture())
    end
  end
  local ListSize = Int64toInt32(PaGlobal_Guild_NoneGuild._ui._list2_guildList:getElementManager():getSize())
  if ListSize > 0 then
    for index = 0, ListSize - 1 do
      local Wrapper
      if true == PaGlobal_Guild_NoneGuild._isSearchList then
        Wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
      else
        Wrapper = ToClient_getGuildPRInfoWrapper(PaGlobal_Guild_NoneGuild._selectedIndex, index)
      end
      if nil ~= Wrapper and Wrapper:getGuildNo() == guildNo then
        local content = PaGlobal_Guild_NoneGuild._ui._list2_guildList:GetContentByKey(toInt64(0, index))
        if nil ~= content then
          local btn_guildList = UI.getChildControl(content, "Button_GuildList_Temp")
          local stc_guildMark = UI.getChildControl(btn_guildList, "Static_GuildMark")
          local isSet = setGuildTextureByGuildNo(Wrapper:getGuildNo(), stc_guildMark)
          if false == isSet then
            stc_guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(stc_guildMark, 183, 1, 188, 6)
            stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
            stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
          else
            stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
            stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
          end
        end
        return
      end
    end
  end
end
function PaGlobalFunc_Guild_NoneGuild_SetFocusEdit()
  PaGlobal_Guild_NoneGuild._ui._txt_search:SetEditText("")
  SetFocusEdit(PaGlobal_Guild_NoneGuild._ui._txt_search)
end
function PaGlobalFunc_Guild_NoneGuild_Search()
  local findstring = PaGlobal_Guild_NoneGuild._ui._txt_search:GetEditText()
  if 0 == string.len(findstring) then
    PaGlobal_Guild_NoneGuild._isSearchList = false
    PaGlobal_Guild_NoneGuild:update()
    return
  end
  ToClient_makeSearchGuildPRList(PaGlobal_Guild_NoneGuild._selectedIndex, findstring)
  PaGlobal_Guild_NoneGuild._ui._list2_guildList:getElementManager():clearKey()
  local PRListSize = ToClient_getSearchGuildPRListSize(PaGlobal_Guild_NoneGuild._selectedIndex)
  if 0 == PRListSize then
    PaGlobal_Guild_NoneGuild._ui._stc_edge:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._btn_applyJoin:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._btn_guildInfo:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._btn_recommend:SetShow(false)
    if false == _ContentsGroup_NewGuildNone then
      PaGlobal_Guild_NoneGuild._ui._txt_sort_name:SetShow(false)
      PaGlobal_Guild_NoneGuild._ui._txt_sort_membercount:SetShow(false)
      PaGlobal_Guild_NoneGuild._ui._txt_search:SetShow(false)
      PaGlobal_Guild_NoneGuild._ui._btn_search:SetShow(false)
    end
    PaGlobal_Guild_NoneGuild._ui._txt_noSelectGuild:SetShow(true)
  end
  for index = 0, PRListSize - 1 do
    local wrapper = ToClient_getSearchGuildPRListInfoWrapper(index)
    if nil ~= wrapper then
      PaGlobal_Guild_NoneGuild._ui._list2_guildList:getElementManager():pushKey(index)
    end
  end
  if 0 == currentIndex then
    PaGlobal_Guild_NoneGuild._ui._txt_noSelectGuild:SetShow(true)
    PaGlobal_Guild_NoneGuild._ui._stc_edge:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._stc_descBG:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._btn_applyJoin:SetShow(false)
    PaGlobal_Guild_NoneGuild._ui._btn_guildInfo:SetShow(false)
  else
    PaGlobal_Guild_NoneGuild._isSearchList = true
    PaGlobal_Guild_NoneGuild:SetRightAreaInfo(0)
  end
end
