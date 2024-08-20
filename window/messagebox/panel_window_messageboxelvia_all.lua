PaGlobal_Window_MessageBoxElvia_All = {
  _ui = {
    _stc_mainBG = nil,
    _txt_title = nil,
    _stc_centerBG = nil,
    _txt_desc = nil,
    _btn_check = nil,
    _btn_confirm = nil,
    _stc_keyGuideBG = nil,
    _txt_keyGuide_Y = nil,
    _txt_keyGuide_A = nil
  },
  _isConsole = false,
  _initailize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_MessageBoxElvia_All_Init")
function FromClient_Window_MessageBoxElvia_All_Init()
  PaGlobal_Window_MessageBoxElvia_All:initialize()
end
function PaGlobal_Window_MessageBoxElvia_All:initialize()
  if true == self._initailize or nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_MessageBoxElvia_All, "Static_Main_BG")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_mainBG, "Static_Text_Title")
  self._ui._stc_centerBG = UI.getChildControl(self._ui._stc_mainBG, "Static_Center_BG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_centerBG, "MultilineText_Desc")
  self._ui._btn_check = UI.getChildControl(self._ui._stc_centerBG, "CheckButton_1")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_mainBG, "Button_Confirm")
  self._ui._stc_keyGuideBG = UI.getChildControl(self._ui._stc_mainBG, "Static_BottomBg_ConsoleUI")
  self._ui._txt_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._txt_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self:validate()
  self:registerEventHandler()
  self._initailize = true
end
function PaGlobal_Window_MessageBoxElvia_All:registerEventHandler()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Window_MessageBoxElvia_All_OnScreenSize")
  if true == self._isConsole then
    self._ui._btn_confirm:SetShow(false)
    self._ui._stc_keyGuideBG:SetShow(true)
    Panel_Window_MessageBoxElvia_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Window_MessageBoxElvia_All_Confirm()")
    Panel_Window_MessageBoxElvia_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Window_MessageBoxElvia_All_CheckTodayShow()")
  else
    self._ui._btn_confirm:SetShow(true)
    self._ui._stc_keyGuideBG:SetShow(false)
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Window_MessageBoxElvia_All_Confirm()")
  end
end
function PaGlobal_Window_MessageBoxElvia_All:prepareOpen()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  if false == ToClient_isHadumChannel() then
    return
  end
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eHadumServerQuestWarning)
  if nil ~= dayCheck then
    local curYear = ToClient_GetThisYear()
    local curMonth = ToClient_GetThisMonth()
    local curDay = ToClient_GetToday()
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if curYear == savedYear and curMonth == savedMonth and curDay == savedDay then
      return
    end
  end
  self:resize()
  self:open()
end
function PaGlobal_Window_MessageBoxElvia_All:open()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  Panel_Window_MessageBoxElvia_All:SetShow(true)
end
function PaGlobal_Window_MessageBoxElvia_All:prepareClose()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  if true == self._ui._btn_check:IsCheck() then
    local _year = ToClient_GetThisYear()
    local _month = ToClient_GetThisMonth()
    local _day = ToClient_GetToday()
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eHadumServerQuestWarning, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  self:close()
end
function PaGlobal_Window_MessageBoxElvia_All:close()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  Panel_Window_MessageBoxElvia_All:SetShow(false)
end
function PaGlobal_Window_MessageBoxElvia_All:resize()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  Panel_Window_MessageBoxElvia_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_MessageBoxElvia_All:ComputePosAllChild()
  self._ui._stc_mainBG:SetSize(getScreenSizeX(), self._ui._stc_mainBG:GetSizeY())
  self._ui._stc_mainBG:ComputePosAllChild()
end
function PaGlobal_Window_MessageBoxElvia_All:validate()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  self._ui._stc_mainBG:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._stc_centerBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._txt_keyGuide_Y:isValidate()
  self._ui._txt_keyGuide_A:isValidate()
end
function PaGlobalFunc_Window_MessageBoxElvia_All_Open()
  PaGlobal_Window_MessageBoxElvia_All:prepareOpen()
end
function PaGlobalFunc_Window_MessageBoxElvia_All_Close()
  PaGlobal_Window_MessageBoxElvia_All:prepareClose()
end
function HandleEventLUp_Window_MessageBoxElvia_All_Confirm()
  PaGlobal_Window_MessageBoxElvia_All:prepareClose()
end
function HandleEventLUp_Window_MessageBoxElvia_All_CheckTodayShow()
  if nil == Panel_Window_MessageBoxElvia_All then
    return
  end
  PaGlobal_Window_MessageBoxElvia_All._ui._btn_check:SetCheck(not PaGlobal_Window_MessageBoxElvia_All._ui._btn_check:IsCheck())
end
function FromClient_Window_MessageBoxElvia_All_OnScreenSize()
  PaGlobal_Window_MessageBoxElvia_All:resize()
end
