function PaGlobal_Guild_InviteList_Open()
  if nil == Panel_Guild_InviteList then
    return
  end
  if true == Panel_Guild_InviteList:GetShow() then
    return
  end
  PaGlobal_Guild_InviteList:prepareOpen()
end
function PaGlobal_Guild_InviteList_Close()
  if nil == Panel_Guild_InviteList then
    return
  end
  if false == Panel_Guild_InviteList:GetShow() then
    return
  end
  PaGlobal_Guild_InviteList:prepareClose()
end
function PaGlobal_Guild_InviteList_ShowSimpleInvite(index)
  PaGlobal_Guild_InviteList_Close()
  FromClient_SimpleGuildInvite(index)
end
function PaGlobalFunc_Guild_InviteList_Create(content, key)
  local _key = Int64toInt32(key)
  local stc_ListTemp = UI.getChildControl(content, "Static_List_Temp")
  local btn_open = UI.getChildControl(stc_ListTemp, "Button_Accept")
  local txt_GuildName = UI.getChildControl(stc_ListTemp, "StaticText_GuildName")
  local txt_GuildMasterName = UI.getChildControl(stc_ListTemp, "StaticText_GuildMaster")
  local stc_guildMark = UI.getChildControl(stc_ListTemp, "Static_GuildMark")
  local wrapper = ToClient_getSimpleGuildInviteInfoWrapper(_key)
  if nil == wrapper then
    return
  end
  txt_GuildName:SetText(wrapper:getGuildName())
  txt_GuildMasterName:SetText(wrapper:getMasterName())
  local isSet = setGuildTextureByGuildNo(wrapper:getGuildNo(), stc_guildMark)
  if false == isSet then
    stc_guildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_guildMark, 183, 1, 188, 6)
    stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  else
    stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
  end
  btn_open:addInputEvent("Mouse_LUp", "PaGlobal_Guild_InviteList_ShowSimpleInvite(" .. _key .. ")")
end
function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_Guild_InviteList then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_Guild_InviteList then
    return
  end
end
