local _panel = Panel_Introduction
local Introduction = {
  _ui = {
    txt_UserName = UI.getChildControl(_panel, "StaticText_UserName"),
    txt_InfoDesc = UI.getChildControl(_panel, "StaticText_UserInfoDec"),
    txt_Level = UI.getChildControl(_panel, "StaticText_LvnJob"),
    txt_GamerTag = UI.getChildControl(_panel, "StaticText_GamerTag"),
    stc_BottomBg = UI.getChildControl(_panel, "Static_BottomBg"),
    stc_PlatformIcon = UI.getChildControl(_panel, "Static_PlatformIcon")
  },
  _currentXuid = nil
}
function Introduction:init()
  self._ui.txt_XConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "StaticText_X_ConsoleUI")
  self._ui.txt_BConsoleUI = UI.getChildControl(self._ui.stc_BottomBg, "StaticText_B_ConsoleUI")
  self._ui.txt_XConsoleUI:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
  local keyGuides = {
    self._ui.txt_XConsoleUI,
    self._ui.txt_BConsoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if true == ToClient_isPS4() then
    self._ui.txt_GamerTag:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FRIENDNEW_PS4NAME"))
  elseif true == ToClient_isXBox() then
    self._ui.txt_GamerTag:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FRIENDNEW_XBOXNAME"))
  end
  self:registEventHandler()
end
function Introduction:resize()
  local defaultSizeX = self._ui.txt_UserName:GetSizeX()
  local longestSizeX = math.max(math.max(self._ui.txt_UserName:GetTextSizeX(), self._ui.txt_GamerTag:GetTextSizeX()), defaultSizeX)
  longestSizeX = longestSizeX + self._ui.txt_UserName:GetPosX() * 2
  self._ui.txt_InfoDesc:SetSize(longestSizeX, self._ui.txt_InfoDesc:GetSizeY())
  self._ui.txt_InfoDesc:SetText(self._ui.txt_InfoDesc:GetText())
  _panel:SetSize(longestSizeX, _panel:GetSizeY())
  self._ui.stc_BottomBg:ComputePos()
  _panel:ComputePos()
end
function Introduction:open(actorKey)
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  if nil == playerActorProxyWrapper then
    return
  end
  local nameString = playerActorProxyWrapper:getOriginalName()
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_TITLE", "name", nameString)
  local desc = playerActorProxyWrapper:getUserIntroduction()
  if true == ToClient_isPS4() and false == ToClient_isUserCreateContentsAllowed() then
    desc = nil
  end
  if nil == desc or "" == desc then
    desc = nameString .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_PLAYERINTRO_NODATA")
  end
  local charLevel = playerActorProxyWrapper:get():getLevel()
  local playerClass = playerActorProxyWrapper:getClassType()
  local classString = CppEnums.ClassType2String[playerClass]
  self._ui.txt_UserName:SetText(name)
  self._ui.txt_InfoDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_InfoDesc:SetText(desc)
  self._ui.txt_Level:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_SUBINFO", "class", classString, "level", charLevel))
  self:resize()
  _panel:SetShow(true)
end
function Introduction:openGamerTag(gamerTag, actorKey)
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  if nil == playerActorProxyWrapper then
    return
  end
  local nameString = playerActorProxyWrapper:getOriginalName()
  local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_TITLE", "name", nameString)
  local desc = playerActorProxyWrapper:getUserIntroduction()
  if nil == desc or "" == desc then
    desc = nameString .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_PLAYERINTRO_NODATA")
  end
  local charLevel = playerActorProxyWrapper:get():getLevel()
  local playerClass = playerActorProxyWrapper:getClassType()
  local classString = CppEnums.ClassType2String[playerClass]
  self._ui.txt_UserName:SetText(name)
  self._ui.txt_InfoDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_InfoDesc:SetText(desc)
  self._ui.txt_Level:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTRODUCTIONMYSELF_SUBINFO", "class", classString, "level", charLevel))
  local xuid = playerActorProxyWrapper:get():getXuid()
  if "" ~= xuid then
    self._currentXuid = xuid
    _panel:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobalFunc_Introduction_ShowXboxProfile()")
  else
    self._currentXuid = nil
    _panel:registerPadEvent(__eConsoleUIPadEvent_X, "")
  end
  if true == _ContentsGroup_ConsoleIntegration then
    local selfPlayerActorProxyWrapper = getSelfPlayer()
    if nil == selfPlayerActorProxyWrapper then
      return
    end
    local myPlatform = selfPlayerActorProxyWrapper:getPlayerPlatformType()
    local otherPlayerPlatform = playerActorProxyWrapper:getPlayerPlatformType()
    local isSamePlatform = myPlatform == otherPlayerPlatform
    self._ui.txt_XConsoleUI:SetShow(isSamePlatform)
    self._ui.stc_PlatformIcon:SetShow(true)
    if not isSamePlatform then
      self._ui.stc_PlatformIcon:ChangeTextureInfoName("combine/commonicon/crossplay_icon_other.dds")
      self._currentXuid = nil
      _panel:registerPadEvent(__eConsoleUIPadEvent_X, "")
      self._ui.txt_GamerTag:SetText(ToClient_ConsoleUserNameString() .. ": -")
    else
      if __eGAME_PLATFORM_TYPE_PS == myPlatform then
        self._ui.stc_PlatformIcon:ChangeTextureInfoName("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == myPlatform then
        self._ui.stc_PlatformIcon:ChangeTextureInfoName("combine/commonicon/crossplay_icon_xb.dds")
      end
      self._ui.txt_GamerTag:SetText(ToClient_ConsoleUserNameString() .. ": " .. gamerTag)
    end
    self._ui.txt_UserName:SetPosX(self._ui.stc_PlatformIcon:GetPosX() + self._ui.stc_PlatformIcon:GetSizeX() + self._ui.txt_UserName:GetSpanSize().x)
  end
  self:resize()
  _panel:SetShow(true)
end
function Introduction:close()
  self._currentXuid = nil
  _panel:SetShow(false)
end
function Introduction:registEventHandler()
  registerEvent("FromClient_InterActionUserIntroduction", "FromClient_UserInfo_InterActionUserIntroduction")
  registerEvent("FromClient_XBOXInteractionProfile", "FromClient_UserInfo_XBOXIntroduction")
end
function PaGlobalFunc_Introduction_Init()
  local self = Introduction
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Introduction")
    return
  end
  self:init()
end
function FGlobal_Introcution_TooltipHide()
  local self = Introduction
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Introduction")
    return
  end
  self:close()
end
function FromClient_UserInfo_InterActionUserIntroduction(actorKey)
  local self = Introduction
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Introduction")
    return
  end
  self:open(actorKey)
end
function FromClient_UserInfo_XBOXIntroduction(gamerTag, actorKeyString)
  local self = Introduction
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : Introduction")
    return
  end
  local actorKey = tonumber(actorKeyString)
  self:openGamerTag(gamerTag, actorKey)
end
function PaGlobalFunc_Introduction_ShowXboxProfile()
  local self = Introduction
  if nil == self._currentXuid then
    return
  end
  ToClient_showXboxFriendProfile(self._currentXuid)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_Introduction_Init")
