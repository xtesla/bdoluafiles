function PaGlobal_GuildInviteAlert:initialize()
  if true == PaGlobal_GuildInviteAlert._initialize then
    return
  end
  self._ui.btn_Alert = UI.getChildControl(Panel_GuildInvite_Alert, "Button_1")
  self._ui.txt_count = UI.getChildControl(self._ui.btn_Alert, "StaticText_1")
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  if 0 == listSize then
    PaGlobal_GuildInviteAlert_Close()
  elseif listSize > 0 then
    PaGlobal_GuildInviteAlert_Open()
  end
  PaGlobal_GuildInviteAlert:registEventHandler()
  PaGlobal_GuildInviteAlert:validate()
  PaGlobal_GuildInviteAlert._initialize = true
end
function PaGlobal_GuildInviteAlert:registEventHandler()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  registerEvent("FromClient_SimpleGuildInvite", "PaGlobal_GuildInviteAlert_Update")
  registerEvent("FromClient_SimpleGuildInviteAccept", "PaGlobal_GuildInviteAlert_Close")
  registerEvent("FromClient_SimpleGuildInviteReject", "PaGlobal_GuildInviteAlert_Update")
end
function PaGlobal_GuildInviteAlert:prepareOpen()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  if nil == Panel_Radar then
    return
  end
  PaGlobal_GuildInviteAlert_SetPos()
  PaGlobal_GuildInviteAlert:update()
  PaGlobal_GuildInviteAlert:open()
end
function PaGlobal_GuildInviteAlert:open()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  Panel_GuildInvite_Alert:SetShow(true)
end
function PaGlobal_GuildInviteAlert:prepareClose()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  PaGlobal_GuildInviteAlert:close()
end
function PaGlobal_GuildInviteAlert:close()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  Panel_GuildInvite_Alert:SetShow(false)
end
function PaGlobal_GuildInviteAlert:update()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  self._ui.btn_Alert:addInputEvent("Mouse_LUp", "FromClient_SimpleGuildInvite(" .. 0 .. ")")
  self._ui.txt_count:SetText(tostring(listSize))
  self._ui.txt_count:SetShow(true)
end
function PaGlobal_GuildInviteAlert:validate()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  self._ui.btn_Alert:isValidate()
end
