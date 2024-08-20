function PaGlobal_CrewMatch_ScoreTab:initialize()
  self:createFrameControl()
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_CrewMatch_ScoreTab:prepareOpen()
  self:open()
end
function PaGlobal_CrewMatch_ScoreTab:open()
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if false == self._initialize then
    return
  end
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eeInstanceContentsType_CrewMatch) then
    return
  end
  self:updateSlotInfo()
  Panel_Widget_CrewMatch_ScoreTab:SetShow(true)
end
function PaGlobal_CrewMatch_ScoreTab:prepareClose()
  local currentState = ToClient_getCrewMatchCurrentState()
  if __eCrewMatchState_End == currentState then
    return
  end
  self:close()
end
function PaGlobal_CrewMatch_ScoreTab:close()
  Panel_Widget_CrewMatch_ScoreTab:SetShow(false)
end
function PaGlobal_CrewMatch_ScoreTab:validate()
end
function PaGlobal_CrewMatch_ScoreTab:registerEvent()
end
function PaGlobal_CrewMatch_ScoreTab:createFrameControl()
  local group = {
    [__eCrewMatchTeam_Red] = UI.getChildControl(Panel_Widget_CrewMatch_ScoreTab, "Frame_Left"),
    [__eCrewMatchTeam_Blue] = UI.getChildControl(Panel_Widget_CrewMatch_ScoreTab, "Frame_Right")
  }
  self._slot = Array.new()
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    local parent = group[ii]
    parent:isValidate()
    local frame = UI.getChildControl(parent, "Frame_1_Content")
    local stc_templete = UI.getChildControl(frame, "Static_Templete")
    stc_templete:SetShow(false)
    local spanSize = stc_templete:GetSpanSize()
    self._slot[ii] = Array.new()
    for jj = 0, __eCrewMatch_TeamMemberCountMax - 1 do
      local slot = {
        _parent = nil,
        _txt_userNickName = nil,
        _txt_guildName = nil,
        _txt_killCount = nil,
        _txt_deathCount = nil,
        _txt_assistCount = nil
      }
      function slot:SetShow(isShow)
        self._parent:SetShow(isShow)
      end
      function slot:clear()
        self._txt_userNickName:SetText("")
        self._txt_guildName:SetText("")
        self._txt_killCount:SetText("0")
        self._txt_deathCount:SetText("0")
        self._txt_assistCount:SetText("0")
      end
      local control = UI.cloneControl(stc_templete, frame, "Static_Slot_" .. tostring(ii) .. "_" .. tostring(jj))
      slot._parent = control
      slot._txt_userNickName = UI.getChildControl(control, "StaticText_Name")
      slot._txt_guildName = UI.getChildControl(control, "StaticText_GuildName")
      slot._txt_killCount = UI.getChildControl(control, "StaticText_KillCount")
      slot._txt_deathCount = UI.getChildControl(control, "StaticText_DeathCount")
      slot._txt_assistCount = UI.getChildControl(control, "StaticText_AssistCount")
      slot._parent:SetSpanSize(spanSize.x, spanSize.y + jj * (5 + slot._parent:GetSizeY()))
      slot:clear()
      slot:SetShow(true)
      self._slot[ii][jj] = slot
    end
  end
end
function PaGlobal_CrewMatch_ScoreTab:updateSlotInfo()
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    ToClient_requestSortCrewMatchPlayer(ii)
    for jj = 0, __eCrewMatch_TeamMemberCountMax - 1 do
      local control = self._slot[ii][jj]
      local userNo = ToClient_getCrewMatchPlayerUserNo(ii, jj)
      if userNo == toInt64(0, -1) then
        control:SetShow(false)
      else
        local wrapper = ToClient_getCrewMatchPlayerWrapper(userNo)
        if nil ~= wrapper then
          control._txt_userNickName:SetText(tostring(wrapper:getUserNickName()))
          control._txt_guildName:SetText(tostring(wrapper:getGuildName()))
          control._txt_killCount:SetText(tostring(wrapper:getKillCount()))
          control._txt_deathCount:SetText(tostring(wrapper:getDeathCount()))
          control._txt_assistCount:SetText(tostring(0))
          control:SetShow(true)
        else
          control:SetShow(false)
        end
      end
    end
  end
end
