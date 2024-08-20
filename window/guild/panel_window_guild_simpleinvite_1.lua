function PaGlobal_Guild_SimpleInvite:initialize()
  if true == PaGlobal_Guild_SimpleInvite._initialize then
    return
  end
  self._ui.stc_topArea = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "Static_TopArea")
  self._ui.stc_guildMarkBG = UI.getChildControl(self._ui.stc_topArea, "Static_GuildMarkBG")
  self._ui.stc_guildMark = UI.getChildControl(self._ui.stc_guildMarkBG, "Static_GuildMark")
  self._ui.txt_Desc = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "MultilineText_BottomDesc")
  self._ui.txt_guildName = UI.getChildControl(self._ui.stc_topArea, "StaticText_GuildName")
  self._ui.txt_guildMasterName = UI.getChildControl(self._ui.stc_topArea, "StaticText_GuildMasterName")
  self.originDescSize = self._ui.txt_Desc:GetSizeY()
  self._ui.txt_Desc:SetAutoResize(true)
  self._ui.btn_guildInfo = UI.getChildControl(self._ui.stc_topArea, "Button_GuildInfo")
  self._ui.txt_SubDesc = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "StaticText_SubTitle")
  self._ui.txt_SubDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SubDesc:SetText(self._ui.txt_SubDesc:GetText())
  self._ui.frame = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "Frame_1")
  self._ui.frame_contents = UI.getChildControl(self._ui.frame, "Frame_1_Content")
  self._ui.frame_contents_txt = UI.getChildControl(self._ui.frame_contents, "StaticText_1")
  self._ui.frame_contents:SetIgnore(false)
  self._ui.frame_vertical = UI.getChildControl(self._ui.frame, "Frame_1_VerticalScroll")
  self._ui.frame_vertical_ctrl = UI.getChildControl(self._ui.frame_vertical, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.frame_horizontal = UI.getChildControl(self._ui.frame, "Frame_1_HorizontalScroll")
  self._ui.btn_join = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "Button_Join")
  self._ui.btn_reject = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "Button_Deny")
  self._ui.btn_close = UI.getChildControl(Panel_Window_Guild_SimpleInvite, "Button_Win_Close")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_SimpleInvite_Close()")
  PaGlobal_Guild_SimpleInvite:registEventHandler()
  PaGlobal_Guild_SimpleInvite:validate()
  PaGlobal_Guild_SimpleInvite._initialize = true
end
function PaGlobal_Guild_SimpleInvite:registEventHandler()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  registerEvent("FromClient_SimpleGuildInvite", "FromClient_SimpleGuildInvite")
  registerEvent("FromClient_SimpleGuildInviteReject", "FromClient_SimpleGuildInviteReject")
  registerEvent("FromClient_SimpleGuildInviteRejectNoticeGuild", "FromClient_SimpleGuildInviteRejectNoticeGuild")
end
function PaGlobal_Guild_SimpleInvite:prepareOpen()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  if nil == self._selectIndex then
    return
  end
  PaGlobal_Guild_SimpleInvite:setFrameContent()
  PaGlobal_Guild_SimpleInvite:update()
  if true == self._isFirstOpen then
    self._isFirstOpen = false
    local movepos = self._ui.txt_Desc:GetSizeY() - self.originDescSize
    if 2 < self._ui.txt_Desc:GetLineCount() then
      movepos = self._ui.txt_Desc:GetSizeY() - self.originDescSize - 13
    end
    self._ui.txt_SubDesc:SetSpanSize(self._ui.txt_SubDesc:GetSpanSize().x, self._ui.txt_SubDesc:GetSpanSize().y + movepos)
  end
  PaGlobal_Guild_SimpleInvite:open()
end
function PaGlobal_Guild_SimpleInvite:open()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  Panel_Window_Guild_SimpleInvite:SetShow(true)
end
function PaGlobal_Guild_SimpleInvite:prepareClose()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  PaGlobal_Guild_SimpleInvite:close()
end
function PaGlobal_Guild_SimpleInvite:close()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  TooltipSimple_Hide()
  Panel_Window_Guild_SimpleInvite:SetShow(false)
end
function PaGlobal_Guild_SimpleInvite:setFrameContent()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  local pos = self._ui.txt_SubDesc:GetPosY() + self._ui.txt_SubDesc:GetSizeY() + 5
  self._ui.frame_contents_txt:SetTextMode(__eTextMode_AutoWrap)
  self._ui.frame_contents_txt:SetText(self._ui.frame_contents_txt:GetText())
  local sizeY = self._ui.frame_contents_txt:GetTextSizeY()
  self._ui.frame_contents:SetSize(self._ui.frame_contents:GetSizeX(), sizeY)
  local verticalControlSize = self._ui.frame_vertical:GetSizeY() * (self._ui.frame:GetSizeY() / (sizeY + 10))
  self._ui.frame_vertical_ctrl:SetSize(self._ui.frame_vertical_ctrl:GetSizeX(), verticalControlSize)
  self._ui.frame_contents:ComputePos()
  self._ui.frame_contents_txt:ComputePos()
  self._ui.frame:UpdateContentScroll()
  self._ui.frame:UpdateContentPos()
end
function PaGlobal_Guild_SimpleInvite:update()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  local SimpleInfoWrapper = ToClient_getSimpleGuildInviteInfoWrapper(self._selectIndex)
  if nil ~= SimpleInfoWrapper then
    self._ui.txt_guildName:SetText(SimpleInfoWrapper:getGuildName())
    self._ui.txt_guildMasterName:SetText(SimpleInfoWrapper:getMasterName())
    self._ui.btn_join:addInputEvent("Mouse_LUp", "PaGlobal_Guild_SimpleInvite_AcceptGuild()")
    self._ui.btn_reject:addInputEvent("Mouse_LUp", "PaGlobal_Guild_SimpleInvite_RejectGuild()")
    self._ui.btn_guildInfo:addInputEvent("Mouse_LUp", "PaGlobal_Guild_SimpleInvite_OpenGuildInfo()")
    self._ui.btn_guildInfo:addInputEvent("Mouse_On", "PaGlobal_Guild_SimpleInvite_ShowSimpleToolTip(true)")
    self._ui.btn_guildInfo:addInputEvent("Mouse_Out", "PaGlobal_Guild_SimpleInvite_ShowSimpleToolTip(false)")
    local descString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLEINVITE_BOTTOM_ASK_DESC", "guildName", SimpleInfoWrapper:getGuildName())
    self._ui.txt_Desc:SetText(descString)
    local joinString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLEINVITE_BTN_INVITE")
    self._ui.btn_join:SetText(joinString)
    local isSet = setGuildTextureByGuildNo(SimpleInfoWrapper:getGuildNo(), self._ui.stc_guildMark)
    if false == isSet then
      self._ui.stc_guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_guildMark, 183, 1, 188, 6)
      self._ui.stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
      self._ui.stc_guildMark:setRenderTexture(self._ui.stc_guildMark:getBaseTexture())
    else
      self._ui.stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
      self._ui.stc_guildMark:setRenderTexture(self._ui.stc_guildMark:getBaseTexture())
    end
  end
end
function PaGlobal_Guild_SimpleInvite:validate()
  if nil == Panel_Window_Guild_SimpleInvite then
    return
  end
  self._ui.stc_topArea:isValidate()
  self._ui.stc_guildMarkBG:isValidate()
  self._ui.stc_guildMark:isValidate()
  self._ui.txt_guildName:isValidate()
  self._ui.txt_guildMasterName:isValidate()
  self._ui.btn_guildInfo:isValidate()
  self._ui.frame:isValidate()
  self._ui.frame_contents:isValidate()
  self._ui.frame_contents_txt:isValidate()
  self._ui.frame_vertical:isValidate()
  self._ui.frame_vertical_ctrl:isValidate()
  self._ui.frame_horizontal:isValidate()
  self._ui.btn_join:isValidate()
  self._ui.btn_reject:isValidate()
  self._ui.btn_close:isValidate()
end
