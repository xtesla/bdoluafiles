function PaGlobal_Window_Description:initialize()
  if nil == Panel_Window_Description or true == self._initailize then
    return
  end
  self._ui._stc_TitleArea = UI.getChildControl(Panel_Window_Description, "Static_TitleArea")
  self._ui._txt_Title = UI.getChildControl(self._ui._stc_TitleArea, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleArea, "Button_Close")
  self._ui._stc_MainBG = UI.getChildControl(Panel_Window_Description, "Static_MainBG")
  self._ui._stc_DescBG = UI.getChildControl(Panel_Window_Description, "Static_DescBG")
  self._ui._txt_Desc = UI.getChildControl(self._ui._stc_DescBG, "StaticText_Desc")
  self:validate()
  self:registerEventHandler()
  self:controlSetting()
  self._initialize = true
  FromClient_Window_Description_ResultAutoGameOption()
end
function PaGlobal_Window_Description:controlSetting()
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Window_Description_Close()")
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOSAVE_DESCRIPTION"))
  local textSizeY = self._ui._txt_Desc:GetTextSizeY()
  if textSizeY > self._ui._stc_DescBG:GetSizeY() then
    local diffSizeY = textSizeY - self._ui._txt_Desc:GetSizeY()
    self._ui._txt_Desc:SetSize(self._ui._txt_Desc:GetSizeX(), self._ui._txt_Desc:GetSizeY() + diffSizeY)
    self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._stc_DescBG:GetSizeY() + diffSizeY)
    self._ui._stc_MainBG:SetSize(self._ui._stc_MainBG:GetSizeX(), self._ui._stc_MainBG:GetSizeY() + diffSizeY)
    Panel_Window_Description:SetSize(Panel_Window_Description:GetSizeX(), Panel_Window_Description:GetSizeY() + diffSizeY)
  end
end
function PaGlobal_Window_Description:registerEventHandler()
  registerEvent("onScreenResize", "FromClient_Window_Description_OnScreenResize")
  registerEvent("FromClient_ResultAutoGameOptionRepository", "FromClient_Window_Description_ResultAutoGameOption")
end
function PaGlobal_Window_Description:prepareOpen()
  if nil == Panel_Window_Description or true == Panel_Window_Description:GetShow() then
    return
  end
  if false == _ContentsGroup_SettingSaveLoad then
    return
  end
  self:open()
end
function PaGlobal_Window_Description:open()
  if nil == Panel_Window_Description then
    return
  end
  Panel_Window_Description:SetShow(true)
end
function PaGlobal_Window_Description:prepareClose()
  if nil == Panel_Window_Description or false == Panel_Window_Description:GetShow() then
    return
  end
  self:close()
end
function PaGlobal_Window_Description:close()
  if nil == Panel_Window_Description then
    return
  end
  Panel_Window_Description:SetShow(false)
end
function PaGlobal_Window_Description:validate()
  if nil == Panel_Window_Description then
    return
  end
  self._ui._stc_TitleArea:isValidate()
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_MainBG:isValidate()
  self._ui._stc_DescBG:isValidate()
  self._ui._txt_Desc:isValidate()
end
