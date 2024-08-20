function PaGlobal_Guild_SimpleInvite_Open()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if true == Panel_Window_Guild_SimpleInvite:GetShow() then
    return
  end
  PaGlobal_Guild_SimpleInvite:prepareOpen()
end
function PaGlobal_Guild_SimpleInvite_Close()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if false == Panel_Window_Guild_SimpleInvite:GetShow() then
    return
  end
  PaGlobal_Guild_SimpleInvite:prepareClose()
end
function FromClient_SimpleGuildInvite(index)
  PaGlobal_Guild_SimpleInvite._selectIndex = index
  PaGlobal_Guild_SimpleInvite_Open()
end
function FromClient_SimpleGuildInviteReject()
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  if listSize > 0 then
    PaGlobal_Guild_SimpleInvite._selectIndex = 0
    PaGlobal_Guild_SimpleInvite_Open()
  end
end
function FromClient_SimpleGuildInviteRejectNoticeGuild(guildName, guestName)
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_REFUSE_GUILDINVITE", "name", guestName, "guild", guildName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_INVITE"),
    content = contentString,
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Guild_SimpleInvite_AcceptGuild()
  local self = PaGlobal_Guild_SimpleInvite
  if nil == self._selectIndex then
    return
  end
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  ToClient_requestAcceptSimpleGuildInvite(wrapper:getGuildNo())
  PaGlobal_Guild_SimpleInvite_Close()
end
function PaGlobal_Guild_SimpleInvite_RejectGuild()
  local self = PaGlobal_Guild_SimpleInvite
  if nil == self._selectIndex then
    return
  end
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  ToClient_requestRejectSimpleGuildInvite(wrapper:getGuildNo())
  PaGlobal_Guild_SimpleInvite_Close()
end
function PaGlobal_Guild_SimpleInvite_OpenGuildInfo()
  local self = PaGlobal_Guild_SimpleInvite
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil == wrapper then
    return
  end
  local strGuildNo = tostring(wrapper:getGuildNo())
  FGlobal_GuildWebInfoForGuildRank_Open(strGuildNo)
end
function PaGlobal_Guild_SimpleInvite_ShowSimpleToolTip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_Guild_SimpleInvite._ui.btn_guildInfo
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NONEGUILD_VIEW_GUILDINFO")
  if nil ~= control then
    TooltipSimple_Show(control, name)
  end
end
function PaGlobal_Guild_SimpleInvite_ShowAni()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
end
function PaGlobal_Guild_SimpleInvite_HideAni()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
end
