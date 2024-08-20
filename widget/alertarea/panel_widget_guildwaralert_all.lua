PaGlobal_GuildWarAlert_All = {
  _ui = {
    stc_bg = nil,
    txt_desc = nil,
    btn_confirm = nil,
    btn_cancel = nil
  },
  _targetGuildNo = nil,
  _targetGuildName = nil,
  _targetUserNo = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_GuildWarAlert_All_Init")
function FromClient_PaGlobal_GuildWarAlert_All_Init()
  PaGlobal_GuildWarAlert_All:initialize()
end
function PaGlobal_GuildWarAlert_All:initialize()
  if true == PaGlobal_GuildWarAlert_All._initialize then
    return
  end
  self._ui.stc_bg = UI.getChildControl(Panel_Widget_GuildWarAlert_All, "Static_Bg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_bg, "StaticText_Desc")
  self._ui.btn_confirm = UI.getChildControl(self._ui.stc_bg, "Button_Confirm")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_bg, "Button_Cancel")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildWarAlert_All:registEventHandler()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildWarAlert_All_Resize")
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarAlert_All_Accept()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarAlert_All_Deny()")
end
function PaGlobal_GuildWarAlert_All:setDesc()
  if nil == self._targetGuildName or "" == self._targetGuildName then
    return
  end
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_DECLAREWAR", "guildName", self._targetGuildName))
end
function PaGlobal_GuildWarAlert_All:set(userNo, guildNo, guildName)
  PaGlobal_GuildWarAlert_All._targetGuildNo = guildNo
  PaGlobal_GuildWarAlert_All._targetGuildName = guildName
  PaGlobal_GuildWarAlert_All._targetUserNo = userNo
end
function PaGlobal_GuildWarAlert_All:clear()
  PaGlobal_GuildWarAlert_All._targetGuildNo = nil
  PaGlobal_GuildWarAlert_All._targetGuildName = nil
  PaGlobal_GuildWarAlert_All._targetUserNo = nil
end
function PaGlobal_GuildWarAlert_All:prepareOpen()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  if true == Panel_Widget_GuildWarAlert_All:GetShow() then
    return
  end
  FromClient_GuildWarAlert_All_Resize()
  PaGlobal_GuildWarAlert_All:setDesc()
  PaGlobal_GuildWarAlert_All:open()
end
function PaGlobal_GuildWarAlert_All:open()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  Panel_Widget_GuildWarAlert_All:SetShow(true)
end
function PaGlobal_GuildWarAlert_All:prepareClose()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  if false == Panel_Widget_GuildWarAlert_All:GetShow() then
    return
  end
  PaGlobal_GuildWarAlert_All:clear()
  PaGlobal_GuildWarAlert_All:close()
end
function PaGlobal_GuildWarAlert_All:close()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  Panel_Widget_GuildWarAlert_All:SetShow(false)
end
function PaGlobal_GuildWarAlert_All:validate()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  self._ui.stc_bg:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancel:isValidate()
end
function PaGlobalFunc_GuildWarAlert_All_Open(userNo, guildNo, guildName)
  PaGlobal_GuildWarAlert_All:set(userNo, guildNo, guildName)
  PaGlobal_GuildWarAlert_All:prepareOpen()
end
function PaGlobalFunc_GuildWarAlert_All_Close()
  PaGlobal_GuildWarAlert_All:prepareClose()
end
function FromClient_GuildWarAlert_All_Resize()
  if nil == Panel_Widget_GuildWarAlert_All then
    return
  end
  Panel_Widget_GuildWarAlert_All:ComputePos()
  if nil ~= Panel_UIMain then
    local alertAreaSizeY = Panel_UIMain:GetSizeY()
    Panel_Widget_GuildWarAlert_All:SetPosY(getScreenSizeY() - Panel_Widget_GuildWarAlert_All:GetSizeY() - alertAreaSizeY - 20)
  end
end
function PaGlobalFunc_GuildWarAlert_All_Accept()
  if nil == PaGlobal_GuildWarAlert_All._targetGuildNo and nil == PaGlobal_GuildWarAlert_All._targetGuildName then
    return
  end
  ToClient_RequestDeclareGuildWar(PaGlobal_GuildWarAlert_All._targetGuildNo, PaGlobal_GuildWarAlert_All._targetGuildName, true)
  PaGlobal_GuildWarAlert_All:clear()
  PaGlobalFunc_GuildWarAlert_All_Close()
end
function PaGlobalFunc_GuildWarAlert_All_Deny()
  if nil == PaGlobal_GuildWarAlert_All._targetUserNo and nil == PaGlobal_GuildWarAlert_All._targetGuildName then
    return
  end
  ToClient_RequestRefuseGuildWar(PaGlobal_GuildWarAlert_All._targetUserNo, PaGlobal_GuildWarAlert_All._targetGuildName)
  PaGlobal_GuildWarAlert_All:clear()
  PaGlobalFunc_GuildWarAlert_All_Close()
end
