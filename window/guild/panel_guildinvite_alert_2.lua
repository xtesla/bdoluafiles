function PaGlobal_GuildInviteAlert_Open()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  if true == Panel_GuildInvite_Alert:GetShow() then
    return
  end
  PaGlobal_GuildInviteAlert:prepareOpen()
end
function PaGlobal_GuildInviteAlert_Close()
  if nil == Panel_GuildInvite_Alert then
    return
  end
  if false == Panel_GuildInvite_Alert:GetShow() then
    return
  end
  PaGlobal_GuildInviteAlert:prepareClose()
end
function PaGlobal_GuildInviteAlert_SetPos()
  if nil ~= Panel_Radar and true == Panel_Radar:GetShow() then
    local alertPosX = Panel_Radar:GetPosX() - Panel_GuildInvite_Alert:GetSizeX()
    local alertPosY = Panel_Radar:GetSizeY() - Panel_GuildInvite_Alert:GetSizeY()
    Panel_GuildInvite_Alert:SetPosXY(alertPosX, alertPosY)
  elseif nil ~= Panel_WorldMiniMap and true == Panel_WorldMiniMap:GetShow() then
    local alertPosX = Panel_WorldMiniMap:GetPosX() - Panel_GuildInvite_Alert:GetSizeX() - 15
    local alertPosY = Panel_WorldMiniMap:GetSizeY() - Panel_GuildInvite_Alert:GetSizeY() + 20
    Panel_GuildInvite_Alert:SetPosXY(alertPosX, alertPosY)
  else
    local alertPosX = Panel_Radar:GetPosX() - Panel_GuildInvite_Alert:GetSizeX()
    local alertPosY = Panel_Radar:GetPosY() + 20
    Panel_GuildInvite_Alert:SetPosXY(alertPosX, alertPosY)
  end
end
function PaGlobal_GuildInviteAlert_Update()
  local listSize = ToClient_getSimpleGuildInviteInfoSize()
  if 0 == listSize then
    PaGlobal_GuildInviteAlert_Close()
  elseif listSize > 0 then
    PaGlobal_GuildInviteAlert_Open()
    PaGlobal_GuildInviteAlert:update()
  end
end
function PaGlobal_GuildInviteAlert_ShowAni()
  if nil == Panel_GuildInvite_Alert then
    return
  end
end
function PaGlobal_GuildInviteAlert_HideAni()
  if nil == Panel_GuildInvite_Alert then
    return
  end
end
