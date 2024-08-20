function PaGlobal_GuildPoint_SkillLog:initialize()
  if true == PaGlobal_GuildPoint_SkillLog._initialize then
    return
  end
  local stc_titleArea = UI.getChildControl(Panel_GuildPoint_SkillLog, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(stc_titleArea, "Button_Win_Close")
  self._ui.stc_lineBG = UI.getChildControl(Panel_GuildPoint_SkillLog, "Static_LineBG")
  self._ui.frame = UI.getChildControl(self._ui.stc_lineBG, "Frame_1")
  self._ui.frame_content = UI.getChildControl(self._ui.frame, "Frame_1_Content")
  self._ui.frame_content_txt_title = UI.getChildControl(self._ui.frame_content, "StaticText_Title")
  self._ui.frame_content_txt_title:SetShow(false)
  self._ui.frame_content_txt_count = UI.getChildControl(self._ui.frame_content, "StaticText_Count")
  self._ui.frame_content_txt_count:SetShow(false)
  self._ui.frame_content_txt_time = UI.getChildControl(self._ui.frame_content, "StaticText_Time")
  self._ui.frame_content_txt_time:SetShow(false)
  self._ui.frame_content_txt_noTimeLine = UI.getChildControl(self._ui.frame_content, "StaticText_Desc")
  self._ui.frame_content_txt_noTimeLine:SetShow(false)
  self._ui.frame_vertical = UI.getChildControl(self._ui.frame, "Frame_1_VerticalScroll")
  self._ui.frame_vertical_ctrl = UI.getChildControl(self._ui.frame_vertical, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.btn_function = UI.getChildControl(Panel_GuildPoint_SkillLog, "Button_Function")
  PaGlobal_GuildPoint_SkillLog:registEventHandler()
  PaGlobal_GuildPoint_SkillLog:validate()
  PaGlobal_GuildPoint_SkillLog._initialize = true
end
function PaGlobal_GuildPoint_SkillLog:registEventHandler()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  self._ui.btn_function:addInputEvent("Mouse_LUp", "PaGlobal_GuildPoint_SkillLog_Close()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildPoint_SkillLog_Close()")
  registerEvent("FromClient_ChangeActivePolicyTimeLog", "FromClient_ChangeActivePolicyTimeLog")
end
function PaGlobal_GuildPoint_SkillLog:resetFrameControl()
  for index = 0, self._count do
    if nil ~= self._titleTable[index] then
      self._titleTable[index]:SetShow(false)
    end
    if nil ~= self._countTable[index] then
      self._countTable[index]:SetShow(false)
    end
    if nil ~= self._timeTable[index] then
      self._timeTable[index]:SetShow(false)
    end
  end
  self._ui.frame_content_txt_noTimeLine:SetShow(true)
  self._nextPos = 0
  self._count = 0
end
function PaGlobal_GuildPoint_SkillLog:prepareOpen(territoryKey)
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  PaGlobal_GuildPoint_SkillLog:setPosition()
  PaGlobal_GuildPoint_SkillLog:resetFrameControl()
  ToClient_GetInvsetTimeLog(territoryKey)
  PaGlobalFunc_PaGlobal_Guild_Point_ChangeDirect(true)
  PaGlobal_GuildPoint_SkillLog:open()
end
function PaGlobal_GuildPoint_SkillLog:createFrameContent(skillNo, count, time)
  local skillSS = getSkillTypeStaticStatus(skillNo)
  if nil == skillSS then
    return
  end
  self._ui.frame_content_txt_noTimeLine:SetShow(false)
  if nil == self._titleTable[self._count] then
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "StaticText_Title", self._ui.frame_content, "StaticText_Title_" .. self._count)
    if nil ~= tempContent then
      self._titleTable[self._count] = tempContent
    end
  end
  if nil ~= self._titleTable[self._count] then
    self._titleTable[self._count]:SetShow(true)
    self._titleTable[self._count]:SetText(tostring(skillSS:getName()))
    self._titleTable[self._count]:SetSize(self._ui.frame_content_txt_title:GetSizeX(), self._ui.frame_content_txt_title:GetSizeY())
    self._titleTable[self._count]:SetPosY(self._nextPos)
    self._nextPos = self._nextPos + self._titleTable[self._count]:GetSizeY()
  end
  if nil == self._countTable[self._count] then
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "StaticText_Count", self._ui.frame_content, "StaticText_Count_" .. self._count)
    if nil ~= tempContent then
      self._countTable[self._count] = tempContent
    end
  end
  if nil ~= self._countTable[self._count] then
    self._countTable[self._count]:SetShow(true)
    self._countTable[self._count]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDPOINT_SKILLACTIVELOG_COUNT_DESC", "Count", count))
    self._countTable[self._count]:SetSize(self._ui.frame_content_txt_count:GetSizeX(), self._ui.frame_content_txt_count:GetSizeY())
    self._countTable[self._count]:SetPosY(self._nextPos)
    self._nextPos = self._nextPos + self._countTable[self._count]:GetSizeY()
  end
  if nil == self._timeTable[self._count] then
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "StaticText_Time", self._ui.frame_content, "StaticText_Time_" .. self._count)
    if nil ~= tempContent then
      self._timeTable[self._count] = tempContent
    end
  end
  if nil ~= self._timeTable[self._count] then
    local timeValue = PATime(time)
    local timeStr = tostring(self:checkUnderTen(timeValue:GetMonth()) .. "/" .. self:checkUnderTen(timeValue:GetDay()) .. "/" .. self:checkUnderTen(timeValue:GetHour()) .. ":" .. self:checkUnderTen(timeValue:GetMinute()))
    self._timeTable[self._count]:SetShow(true)
    self._timeTable[self._count]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDPOINT_SKILLACTIVELOG_TIME_DESC", "Time", timeStr))
    self._timeTable[self._count]:SetSize(self._ui.frame_content_txt_time:GetSizeX(), self._ui.frame_content_txt_time:GetSizeY())
    self._timeTable[self._count]:SetPosY(self._nextPos)
    self._nextPos = self._nextPos + self._timeTable[self._count]:GetSizeY()
  end
  self._count = self._count + 1
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), self._nextPos)
  local verticalControlSize = self._ui.frame_vertical:GetSizeY() * (self._ui.frame:GetSizeY() / self._nextPos)
  self._ui.frame_vertical_ctrl:SetSize(self._ui.frame_vertical_ctrl:GetSizeX(), verticalControlSize)
  self._ui.frame:UpdateContentScroll()
  self._ui.frame:UpdateContentPos()
end
function PaGlobal_GuildPoint_SkillLog:checkUnderTen(number)
  if number < 10 then
    return "0" .. tostring(number)
  end
  return tostring(number)
end
function PaGlobal_GuildPoint_SkillLog:open()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  Panel_GuildPoint_SkillLog:SetShow(true)
end
function PaGlobal_GuildPoint_SkillLog:prepareClose()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  PaGlobalFunc_PaGlobal_Guild_Point_ChangeDirect(false)
  PaGlobal_GuildPoint_SkillLog:close()
end
function PaGlobal_GuildPoint_SkillLog:close()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  Panel_GuildPoint_SkillLog:SetShow(false)
end
function PaGlobal_GuildPoint_SkillLog:setPosition()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  if nil == Panel_Guild_Point then
    return
  end
  Panel_GuildPoint_SkillLog:SetPosX(Panel_Guild_Point:GetPosX() - Panel_GuildPoint_SkillLog:GetSizeX() - 15)
  Panel_GuildPoint_SkillLog:SetPosY(Panel_Guild_Point:GetPosY())
end
function PaGlobal_GuildPoint_SkillLog:update()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
end
function PaGlobal_GuildPoint_SkillLog:validate()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_lineBG:isValidate()
  self._ui.frame:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.btn_function:isValidate()
end
