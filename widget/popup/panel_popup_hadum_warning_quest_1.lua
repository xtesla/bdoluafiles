function PaGlobal_HadumWarning_Quest:initialize()
  if true == PaGlobal_HadumWarning_Quest._initialize then
    return
  end
  self._ui.stc_InfoArea = UI.getChildControl(Panel_Popup_Hadum_Warning_Quest, "Static_InfoArea")
  self._ui.btn_TodayNotShow = UI.getChildControl(self._ui.stc_InfoArea, "CheckButton_1")
  self._ui.btn_Yes = UI.getChildControl(Panel_Popup_Hadum_Warning_Quest, "Button_Yes")
  local txt_Info = UI.getChildControl(self._ui.stc_InfoArea, "MultilineText_InfoDesc")
  local panelSizeY = Panel_Popup_Hadum_Warning_Quest:GetSizeY() - self._ui.stc_InfoArea:GetSizeY()
  txt_Info:SetTextMode(__eTextMode_AutoWrap)
  txt_Info:SetText(txt_Info:GetText())
  txt_Info:SetSize(txt_Info:GetSizeX(), txt_Info:GetTextSizeY())
  self._ui.stc_InfoArea:SetSize(self._ui.stc_InfoArea:GetSizeX(), txt_Info:GetSizeY() + self._ui.btn_TodayNotShow:GetSizeY() + 10)
  panelSizeY = panelSizeY + self._ui.stc_InfoArea:GetSizeY()
  Panel_Popup_Hadum_Warning_Quest:SetSize(Panel_Popup_Hadum_Warning_Quest:GetSizeX(), panelSizeY)
  self._ui.stc_InfoArea:ComputePos()
  txt_Info:ComputePos()
  self._ui.btn_Yes:ComputePos()
  self._ui.btn_TodayNotShow:ComputePos()
  Panel_Popup_Hadum_Warning_Quest:ComputePos()
  PaGlobal_HadumWarning_Quest:registEventHandler()
  PaGlobal_HadumWarning_Quest:validate()
  PaGlobal_HadumWarning_Quest._initialize = true
end
function PaGlobal_HadumWarning_Quest:registEventHandler()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  self._ui.btn_Yes:addInputEvent("Mouse_LUp", "PaGlobal_HadumWarning_Quest_Close()")
  registerEvent("FromClient_ShowHadumWarningQuestPopup", "PaGlobal_HadumWarning_Quest_SetOpenFlag")
end
function PaGlobal_HadumWarning_Quest:showByToday()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return false
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eHadumServerQuestWarning)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return false
    end
  end
  return true
end
function PaGlobal_HadumWarning_Quest:prepareOpen()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  if nil ~= self._openFlag and false == self._openFlag then
    return
  end
  if false == ToClient_isHadumChannel() then
    return
  end
  if false == self:showByToday() then
    return
  end
  PaGlobal_HadumWarning_Quest:open()
end
function PaGlobal_HadumWarning_Quest:open()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  Panel_Popup_Hadum_Warning_Quest:SetShow(true)
end
function PaGlobal_HadumWarning_Quest:saveToday()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eHadumServerQuestWarning, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_HadumWarning_Quest:prepareClose()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  if true == self._ui.btn_TodayNotShow:IsCheck() then
    self:saveToday()
  end
  self._openFlag = nil
  PaGlobal_HadumWarning_Quest:close()
end
function PaGlobal_HadumWarning_Quest:close()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  Panel_Popup_Hadum_Warning_Quest:SetShow(false)
end
function PaGlobal_HadumWarning_Quest:update()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
end
function PaGlobal_HadumWarning_Quest:validate()
  if nil == Panel_Popup_Hadum_Warning_Quest then
    return
  end
  self._ui.stc_InfoArea:isValidate()
  self._ui.btn_TodayNotShow:isValidate()
  self._ui.btn_Yes:isValidate()
end
