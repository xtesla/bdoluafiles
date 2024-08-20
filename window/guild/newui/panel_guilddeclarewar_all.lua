PaGlobal_GuildDeclareWar_All = {
  _ui = {
    stc_Title = nil,
    stc_MainBg = nil,
    edit_Search = nil,
    btn_Declare = nil,
    stc_DescBg = nil,
    stc_KeyGuide_X = nil,
    txt_Desc = nil,
    btn_Close = nil,
    stc_KeyGuides = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildDeclareWar_All_Init")
function FromClient_GuildDeclareWar_All_Init()
  PaGlobal_GuildDeclareWar_All:initialize()
end
function PaGlobal_GuildDeclareWar_All:initialize()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildDeclareWar_All then
    return
  end
  self._ui.stc_Title = UI.getChildControl(Panel_GuildDeclareWar_All, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_Title, "Button_Close")
  self._ui.stc_MainBg = UI.getChildControl(Panel_GuildDeclareWar_All, "Static_MainArea")
  self._ui.edit_Search = UI.getChildControl(self._ui.stc_MainBg, "Edit_Search_Guild")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_Search, "StaticText_X_ConsoleUI")
  self._ui.btn_Declare = UI.getChildControl(self._ui.stc_MainBg, "Button_GoWar")
  self._ui.stc_DescBg = UI.getChildControl(self._ui.stc_MainBg, "Static_DescEdge")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DescBg, "StaticText_Desc")
  self._ui.stc_KeyGuides = UI.getChildControl(Panel_GuildDeclareWar_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_GuildDeclareWar_All:setDesc()
  self._ui.btn_Declare:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.stc_KeyGuides:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui.stc_KeyGuide_X:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.txt_Desc:GetTextSizeY() + 10)
  self._ui.stc_DescBg:SetSize(self._ui.stc_DescBg:GetSizeX(), self._ui.txt_Desc:GetSizeY() + 10)
  self._ui.stc_MainBg:SetSize(self._ui.stc_MainBg:GetSizeX(), self._ui.stc_DescBg:GetSizeY() - 15 + self._ui.btn_Declare:GetSizeY() + self._ui.stc_Title:GetSizeY())
  Panel_GuildDeclareWar_All:SetSize(Panel_GuildDeclareWar_All:GetSizeX(), self._ui.stc_MainBg:GetSizeY() + self._ui.stc_Title:GetSizeY())
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.edit_Search:SetSize(self._ui.edit_Search:GetSizeX() + self._ui.btn_Declare:GetSizeX() + 10, self._ui.edit_Search:GetSizeY())
    self._ui.edit_Search:ComputePos()
    self._ui.stc_KeyGuide_X:ComputePos()
    self._ui.stc_KeyGuides:ComputePos()
    local keyguide = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui.stc_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_GuildDeclareWar_All:registerEvent()
end
function PaGlobal_GuildDeclareWar_All:setDesc()
  if nil == Panel_GuildInfo_All or nil == Panel_GuildDeclareWar_All then
    return
  end
  local warType = ToClient_GetGuildWarType()
  if CppEnums.GuildWarType.GuildWarType_Both == warType then
    self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARHELP_JP"))
    return
  end
  local needMoney = ToClient_ConsumeGuildMoneyForGuildWar()
  if false == _ContentsGroup_ApplyGuildWarPenaltyOption then
    self._ui.txt_Desc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARHELP_NEW", "money", makeDotMoney(needMoney)))
  else
    local penaltyCycleInSecond = ToClient_GetGuildWarPenaltyCycleInSecond()
    local penaltyRatio = ToClient_GetGuildWarPenaltyCostRatio()
    local penaltyRatioMax = ToClient_GetGuildWarPenaltyCostRatioMax()
    local retryTimeInSecond = ToClient_GetGuildWarRetryTimeSecond()
    penaltyRatio = string.format("%.1f", penaltyRatio)
    penaltyRatioMax = string.format("%.1f", penaltyRatioMax)
    local penaltyCycleToHour = math.floor(penaltyCycleInSecond / 3600)
    local timeString1 = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", tostring(penaltyCycleToHour))
    local retryTimeToDay = math.floor(retryTimeInSecond / 86400)
    local timeString2 = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(retryTimeToDay))
    local stringFormatKey = "LUA_GUILD_TEXT_LETSWARHELP_NEW2"
    if true == _ContentsGroup_UnconditionalGuildWar then
      stringFormatKey = "LUA_GUILD_TEXT_LETSWARHELP_UNCONDITIONALGUILDWAR"
    end
    local desc = PAGetStringParam8(Defines.StringSheet_GAME, stringFormatKey, "money", makeDotMoney(needMoney), "time", timeString1, "money2", makeDotMoney(needMoney), "percent", tostring(penaltyRatio) .. "%", "time2", timeString1, "percent2", tostring(penaltyRatio) .. "%", "maxpercent", tostring(penaltyRatioMax) .. "%", "retrytime", timeString2)
    self._ui.txt_Desc:SetText(desc)
  end
end
function PaGlobal_GuildDeclareWar_All:validate()
  self._ui.stc_Title:isValidate()
  self._ui.stc_MainBg:isValidate()
  self._ui.edit_Search:isValidate()
  self._ui.btn_Declare:isValidate()
  self._ui.stc_DescBg:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.btn_Close:isValidate()
end
function PaGlobal_GuildDeclareWar_All:registerEvent()
  self._ui.btn_Declare:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildDeclareWar_DeclareWar()")
  self._ui.edit_Search:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildDeclareWar_EditName()")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildDeclareWar_Close()")
  self._ui.edit_Search:RegistReturnKeyEvent("PaGlobalFunc_GuildDeclareWar_DeclareWar()")
  self._ui.edit_Search:SetMaxInput(21)
  if true == _ContentsGroup_UsePadSnapping then
    Panel_GuildDeclareWar_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildDeclareWar_DeclareWar()")
    Panel_GuildDeclareWar_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildDeclareWar_EditName()")
    self._ui.edit_Search:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildDeclareWar_DeclareWar()")
    self._ui.edit_Search:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_GuildDeclareWar_EndXboxKey")
  end
  registerEvent("FromClient_NotEnoughWatingTimeForGuildWar", "FromClient_NotEnoughWatingTimeForGuildWar")
end
function FromClient_NotEnoughWatingTimeForGuildWar(remainSecond64)
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
  local contentString = ""
  local day = remainSecond64 / toInt64(0, 86400)
  local hour = remainSecond64 / toInt64(0, 3600)
  local min = remainSecond64 / toInt64(0, 60)
  local zero = Defines.s64_const.s64_0
  if day > zero then
    local dayString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_DAY")
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_WAR_RETRY_DESC", "value", tostring(day), "time_unit", dayString)
  elseif hour > zero then
    local hourString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR")
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_WAR_RETRY_DESC", "value", tostring(hour), "time_unit", hourString)
  elseif min > zero then
    local minuteString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE")
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_WAR_RETRY_DESC", "value", tostring(min), "time_unit", minuteString)
  else
    local secondString = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_WAR_RETRY_DESC", "value", tostring(remainSecond64), "time_unit", secondString)
  end
  if nil == contentString or "" == contentString then
    return
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_GuildDeclareWar_Open()
  if true == Panel_GuildDeclareWar_All:GetShow() then
    return
  end
  Panel_GuildDeclareWar_All:ComputePos()
  PaGlobal_GuildDeclareWar_All._ui.edit_Search:SetEditText("", true)
  Panel_GuildDeclareWar_All:SetShow(true)
end
function PaGlobalFunc_GuildDeclareWar_Close()
  ClearFocusEdit()
  CheckChattingInput()
  Panel_GuildDeclareWar_All:SetShow(false)
end
function PaGlobalFunc_GuildDeclareWar_DeclareWar()
  local guildName = PaGlobal_GuildDeclareWar_All._ui.edit_Search:GetEditText()
  if nil == guildName or "" == guildName then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGUE_NPCSHOP_GUILD1"))
    return
  end
  ClearFocusEdit()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local myGuildName = myGuildInfo:getName()
  local function confirmWar()
    ToClient_RequestDeclareGuildWar(0, guildName, false)
    PaGlobal_GuildDeclareWar_All._ui.edit_Search:SetEditText("", true)
  end
  local accumulateTax_s32 = Int64toInt32(myGuildInfo:getAccumulateTax())
  local accumulateCost_s32 = Int64toInt32(myGuildInfo:getAccumulateGuildHouseCost())
  if accumulateTax_s32 > 0 or accumulateCost_s32 > 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_RECRUITMENT_TAXFIRST"))
    PaGlobalFunc_GuildDeclareWar_Close()
    return
  end
  if guildName == myGuildName then
    PaGlobal_GuildMain_All:SetMsgDataAndShow("", PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_LETSWARFAIL"), nil, nil, MessageBox_Empty_function, nil)
  elseif CppEnums.GuildWarType.GuildWarType_Both == ToClient_GetGuildWarType() then
    local messageboxData = {
      title = "",
      content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DECLAREWAR_DECREASEMONEY"),
      functionYes = confirmWar,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, nil, nil)
  else
    confirmWar()
  end
end
function PaGlobalFunc_GuildDeclareWar_EditName()
  SetFocusEdit(PaGlobal_GuildDeclareWar_All._ui.edit_Search)
  PaGlobal_GuildDeclareWar_All._ui.edit_Search:SetEditText("", true)
end
function PaGlobalFunc_GuildDeclareWar_EndXboxKey(str)
  PaGlobal_GuildDeclareWar_All._ui.edit_Search:SetEditText(str)
  ClearFocusEdit()
end
