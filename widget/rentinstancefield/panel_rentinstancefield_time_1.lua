function PaGlobal_RentInstanceField_Time:initialize()
  self._ui._txt_remainTime = UI.getChildControl(self._ui._stc_timeBG, "StaticText_TimeCount")
  self._ui._txt_playerCount = UI.getChildControl(self._ui._stc_memberBG, "StaticText_MemberCount_Recent")
  self._ui._txt_maxPlayerCount = UI.getChildControl(self._ui._stc_memberBG, "StaticText_MemberCount_Total")
  self._ui._btn_option = UI.getChildControl(self._ui._stc_memberBG, "Button_Option")
  self:validate()
  self:registerEvent()
  self._initialize = true
  self:prepareOpen()
end
function PaGlobal_RentInstanceField_Time:clear()
  self._toTime = 0
  self._fromTime = 0
end
function PaGlobal_RentInstanceField_Time:prepareOpen()
  self:open()
end
function PaGlobal_RentInstanceField_Time:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_RentInstanceField then
    return
  end
  self:clear()
  local playerCount = ToClient_getInstanceFieldPlayerCount()
  self._ui._txt_playerCount:SetText(tostring(playerCount))
  self._ui._txt_maxPlayerCount:SetText("/ " .. tostring(ToClient_getInstanceFieldPlayerMaxCount()))
  if true == ToClient_isInstanceFieldHost() then
    self._ui._btn_option:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:prepareOpen()")
    self._ui._btn_option:SetShow(true)
  else
    self._ui._btn_option:addInputEvent("Mouse_LUp", "")
    self._ui._btn_option:SetShow(false)
  end
  Panel_RentInstanceField_Time:SetShow(true)
  Panel_RentInstanceField_Time:RegisterUpdateFunc("PaGlobal_RentInstanceField_Time_UpdatePerFrame")
end
function PaGlobal_RentInstanceField_Time:prepareClose()
  self:close()
end
function PaGlobal_RentInstanceField_Time:close()
  Panel_RentInstanceField_Time:SetShow(false)
  Panel_RentInstanceField_Time:ClearUpdateLuaFunc()
end
function PaGlobal_RentInstanceField_Time:validate()
  self._ui._stc_timeBG:isValidate()
  self._ui._stc_memberBG:isValidate()
  self._ui._txt_playerCount:isValidate()
  self._ui._txt_maxPlayerCount:isValidate()
  self._ui._btn_option:isValidate()
end
function PaGlobal_RentInstanceField_Time:registerEvent()
  registerEvent("FromClient_responsePersonalFieldInfo", "PaGlobal_RentInstanceField_Time_Open")
  registerEvent("FromClient_responseInstanceFieldFieldPrivateInfo", "PaGlobal_RentInstanceField_Time_Open")
end
