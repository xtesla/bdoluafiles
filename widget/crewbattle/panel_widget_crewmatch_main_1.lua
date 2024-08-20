function PaGlobal_CrewMatch_Main:initialize()
  self._ui._txt_time = UI.getChildControl(self._ui._stc_mainBG, "StaticText_Time_BG")
  local group = {
    [__eCrewMatchTeam_Red] = UI.getChildControl(self._ui._stc_mainBG, "Static_LeftGroup"),
    [__eCrewMatchTeam_Blue] = UI.getChildControl(self._ui._stc_mainBG, "Static_RightGroup")
  }
  self._group = Array.new()
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    local parent = group[ii]
    parent:isValidate()
    local data = {
      _parent = nil,
      _pg2_hp = nil,
      _txt_killCount = nil
    }
    data._parent = parent
    data._pg2_hp = UI.getChildControl(parent, "Progress2_1")
    data._txt_killCount = UI.getChildControl(parent, "StaticText_SkillCount")
    self._group[ii] = data
  end
  self:validate()
  self:registerEvent()
  self._initialize = true
  self:prepareOpen()
end
function PaGlobal_CrewMatch_Main:clear()
  self._ui._txt_time:SetText(convertSecondsToClockTime(0))
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    self._group[ii]._pg2_hp:SetProgressRate(0)
    self._group[ii]._txt_killCount:SetText("")
  end
end
function PaGlobal_CrewMatch_Main:prepareOpen()
  self:open()
end
function PaGlobal_CrewMatch_Main:open()
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if false == self._initialize then
    return
  end
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eeInstanceContentsType_CrewMatch) then
    return
  end
  self:clear()
  self:updateMainObjHp()
  self:hideOtherUI()
  Panel_Widget_CrewMatch_Main:RegisterUpdateFunc("PaGlobal_CrewMain_UpdatePerFrame")
  Panel_Widget_CrewMatch_Main:SetShow(true)
end
function PaGlobal_CrewMatch_Main:prepareClose()
  self:close()
end
function PaGlobal_CrewMatch_Main:close()
  Panel_Widget_CrewMatch_Main:ClearUpdateLuaFunc()
  Panel_Widget_CrewMatch_Main:SetShow(false)
end
function PaGlobal_CrewMatch_Main:validate()
  self._ui._stc_mainBG:isValidate()
  self._ui._txt_time:isValidate()
end
function PaGlobal_CrewMatch_Main:registerEvent()
  registerEvent("FromClient_responseCrewMatchInformation", "FromClient_responseCrewMatchInformation")
  registerEvent("FromClient_showCrewMatchCountDown", "FromClient_showCrewMatchCountDown")
  registerEvent("FromClient_responseCrewMatchKillPlayer", "FromClient_responseCrewMatchKillPlayer")
  registerEvent("FromClient_responseCrewMatchResult", "FromClient_responseCrewMatchResult")
  registerEvent("FromClient_responseCrewMatchCurrentState", "FromClient_responseCrewMatchCurrentState")
  registerEvent("FromClient_responseCrewMatchLogInOut", "FromClient_responseCrewMatchLogInOut")
  registerEvent("FromClient_responseCrewSetMainObject", "FromClient_responseCrewSetMainObject")
end
function PaGlobal_CrewMatch_Main:hideOtherUI()
end
function PaGlobal_CrewMatch_Main:updateMainObjHp()
  for ii = 0, __eCrewMatchTeam_Count - 1 do
    local actorKeyRaw = ToClient_getCrewMatchMainObjActorKeyRaw(ii)
    local mainObj = getActor(actorKeyRaw)
    if nil ~= mainObj then
      local curHp = mainObj:get():getHp()
      local maxHp = mainObj:get():getMaxHp()
      if 0 ~= maxHp then
        local rate = math.floor(curHp / maxHp * 100)
        self._group[ii]._pg2_hp:SetProgressRate(rate)
      end
    end
  end
end
