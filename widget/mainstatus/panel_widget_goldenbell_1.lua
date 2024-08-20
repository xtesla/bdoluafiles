function PaGlobal_Widget_GoldenBell:initialize()
  if true == PaGlobal_Widget_GoldenBell._initialize then
    return
  end
  PaGlobal_Widget_GoldenBell._ui._stc_title = UI.getChildControl(Panel_Widget_GoldenBell, "StaticText_Title")
  PaGlobal_Widget_GoldenBell._ui._stc_bg = UI.getChildControl(Panel_Widget_GoldenBell, "Static_BG")
  PaGlobal_Widget_GoldenBell._ui._stc_desc = UI.getChildControl(PaGlobal_Widget_GoldenBell._ui._stc_bg, "StaticText_TooltipDesc")
  PaGlobal_Widget_GoldenBell._ui._stc_icon = UI.getChildControl(PaGlobal_Widget_GoldenBell._ui._stc_bg, "Static_BellIcon")
  PaGlobal_Widget_GoldenBell._ui._stc_good = UI.getChildControl(Panel_Widget_GoldenBell, "StaticText_Good")
  PaGlobal_Widget_GoldenBell._ui._stc_lefTime = UI.getChildControl(Panel_Widget_GoldenBell, "StaticText_Time")
  PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc = UI.getChildControl(Panel_Widget_GoldenBell, "StaticText_BottomDesc")
  PaGlobal_Widget_GoldenBell:registEventHandler()
  PaGlobal_Widget_GoldenBell:validate()
  self._originPanelSizeY = Panel_Widget_GoldenBell:GetSizeY()
  self._originBottomDescTextSizeY = PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc:GetTextSizeY()
  self._originBgSizeY = PaGlobal_Widget_GoldenBell._ui._stc_bg:GetSizeY()
  self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_NAME"))
  if true == isGameTypeTaiwan() then
    self:changeIcon(self._TYPE._WHISTLE)
  end
  PaGlobal_Widget_GoldenBell._initialize = true
end
function PaGlobal_Widget_GoldenBell:registEventHandler()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  registerEvent("FromClient_ResponseCheerUp", "FromClient_ResponseCheerUp")
end
function PaGlobal_Widget_GoldenBell:prepareOpen()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  PaGlobal_Widget_GoldenBell:update()
  Panel_Widget_GoldenBell:RegisterUpdateFunc("PaGlobalFunc_Widget_GoldenBell_UpdatePerFrame")
  PaGlobal_Widget_GoldenBell:open()
end
function PaGlobal_Widget_GoldenBell:open()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  Panel_Widget_GoldenBell:SetShow(true)
end
function PaGlobal_Widget_GoldenBell:prepareClose()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  Panel_Widget_GoldenBell:ClearUpdateLuaFunc()
  PaGlobal_Widget_GoldenBell:close()
end
function PaGlobal_Widget_GoldenBell:close()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  Panel_Widget_GoldenBell:SetShow(false)
end
function PaGlobal_Widget_GoldenBell:update()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  if nil == player then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  local goldenBellTime_s64 = player:getGoldenbellExpirationTime_s64()
  local goldenBellTime = convertStringFromDatetime(goldenBellTime_s64)
  local goldenBellPercent = player:getGoldenbellPercent()
  local goldenBellPercentString = tostring(math.floor(goldenBellPercent / 10000))
  local goldenBellCharacterName = player:getGoldenbellItemOwnerCharacterName()
  local goldenBellGuildName = player:getGoldenbellItemOwnerGuildName()
  local goldenBellCheerUpCount = ToClient_GetCheerUpCount()
  local desc = ""
  local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
  if 1000001 == goldenBellPercent then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_CRONGOLDENBELL_TOOLTIP_NAME")
  elseif 1000002 == goldenBellPercent then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_FREEBELL_TOOLTIP_NAME")
  elseif 1000003 == goldenBellPercent then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_ADVENTUREBELL_TOOLTIP_NAME")
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_NAME")
  end
  if nil == goldenBellGuildName or "" == goldenBellGuildName or " " == goldenBellGuildName then
    desc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_NOGUILD_CHEERUP", "channelName", channelName, "name", goldenBellCharacterName, "percent", goldenBellPercentString)
  else
    desc = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_GOLDENBELL_TOOLTIP_DESC_GUILD_CHEERUP", "channelName", channelName, "guildName", goldenBellGuildName, "name", goldenBellCharacterName, "percent", goldenBellPercentString)
  end
  PaGlobal_Widget_GoldenBell._ui._stc_lefTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GOLDENBELL_LEFTTIME", "time", goldenBellTime))
  PaGlobal_Widget_GoldenBell._ui._stc_desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Widget_GoldenBell._ui._stc_desc:SetText(desc)
  PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc:SetText(PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc:GetText())
  PaGlobal_Widget_GoldenBell:resizePanel()
  PaGlobal_Widget_GoldenBell:setCheerUpCount(goldenBellCheerUpCount)
end
function PaGlobal_Widget_GoldenBell:resizePanel()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  local textGap = 20
  local textSizeYDiff = math.max(0, self._ui._stc_desc:GetTextSizeY() + textGap - self._originBgSizeY)
  local bottomDescTextSizeDiff = self._ui._stc_bottomDesc:GetTextSizeY() - self._originBottomDescTextSizeY
  self._ui._stc_bg:SetSize(self._ui._stc_bg:GetSizeX(), self._originBgSizeY + textSizeYDiff)
  local bottomGap = 5
  local bgEndPosY = self._ui._stc_bg:GetPosY() + self._ui._stc_bg:GetSizeY() + bottomGap
  self._ui._stc_good:SetPosY(bgEndPosY)
  self._ui._stc_lefTime:SetPosY(bgEndPosY + self._ui._stc_good:GetSizeY())
  self._ui._stc_bottomDesc:SetPosY(bgEndPosY + self._ui._stc_good:GetSizeY() + self._ui._stc_lefTime:GetSizeY() + bottomGap)
  Panel_Widget_GoldenBell:SetSize(Panel_Widget_GoldenBell:GetSizeX(), self._originPanelSizeY + textSizeYDiff + bottomDescTextSizeDiff + bottomGap)
end
function PaGlobal_Widget_GoldenBell:validate()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  PaGlobal_Widget_GoldenBell._ui._stc_title:isValidate()
  PaGlobal_Widget_GoldenBell._ui._stc_bg:isValidate()
  PaGlobal_Widget_GoldenBell._ui._stc_desc:isValidate()
  PaGlobal_Widget_GoldenBell._ui._stc_good:isValidate()
  PaGlobal_Widget_GoldenBell._ui._stc_lefTime:isValidate()
  PaGlobal_Widget_GoldenBell._ui._stc_bottomDesc:isValidate()
end
function PaGlobal_Widget_GoldenBell:setCheerUpCount(count)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  self._currentCheerUpCount = math.min(self._MAX_CHEERUP_COUNT, count)
  local countText = ""
  if self._MAX_CHEERUP_COUNT <= self._currentCheerUpCount then
    countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GOLDENBELL_CHEERUP", "cheerup", self._MAX_CHEERUP_COUNT - 1) .. "+"
  else
    countText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GOLDENBELL_CHEERUP", "cheerup", self._currentCheerUpCount)
  end
  PaGlobal_Widget_GoldenBell._ui._stc_good:SetText(countText)
end
function PaGlobal_Widget_GoldenBell:changeIcon(bellType)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  if nil == PaGlobal_Widget_GoldenBell._ui._stc_icon then
    return
  end
  PaGlobal_Widget_GoldenBell._ui._stc_icon:ChangeTextureInfoName("Combine/Icon/Combine_Basic_Icon_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(PaGlobal_Widget_GoldenBell._ui._stc_icon, self._UV_ICON[bellType].x1, self._UV_ICON[bellType].y1, self._UV_ICON[bellType].x2, self._UV_ICON[bellType].y2)
  PaGlobal_Widget_GoldenBell._ui._stc_icon:getBaseTexture():setUV(x1, y1, x2, y2)
  PaGlobal_Widget_GoldenBell._ui._stc_icon:setRenderTexture(PaGlobal_Widget_GoldenBell._ui._stc_icon:getBaseTexture())
end
