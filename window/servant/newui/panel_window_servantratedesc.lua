PaGlobal_Window_ServantRateDesc = {
  _ui = {
    _btn_Close_top = nil,
    _btn_Close_bottom = nil,
    _stc_KeyGuide_ConsoleUI = nil,
    _frame_1 = nil,
    _frame_1_Content = nil,
    _txt_Desc = nil,
    _frame_scroll = nil,
    _txt_B_ConsoleUI = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_ServantRateDescInit")
function FromClient_Window_ServantRateDescInit()
  PaGlobal_Window_ServantRateDesc:initialize()
end
function PaGlobal_Window_ServantRateDesc:initialize()
  if true == PaGlobal_Window_ServantRateDesc._initialize then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_ServantRateDesc, "Static_TitleArea")
  local txt_Title = UI.getChildControl(titleArea, "StaticText_Title")
  txt_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSWCHAGNE_TITLE"))
  self._ui._btn_Close_top = UI.getChildControl(titleArea, "Button_Close")
  self._ui._btn_Close_bottom = UI.getChildControl(Panel_Window_ServantRateDesc, "Button_Close")
  self._ui._frame_1 = UI.getChildControl(Panel_Window_ServantRateDesc, "Frame_1")
  self._ui._frame_1_Content = UI.getChildControl(self._ui._frame_1, "Frame_1_Content")
  self._ui._frame_scroll = UI.getChildControl(self._ui._frame_1, "Frame_1_VerticalScroll")
  self._ui._txt_Desc = UI.getChildControl(self._ui._frame_1_Content, "StaticText_Desc")
  self._ui._stc_KeyGuide_ConsoleUI = UI.getChildControl(Panel_Window_ServantRateDesc, "Static_KeyGuide_ConsoleUI")
  self._ui._txt_B_ConsoleUI = UI.getChildControl(self._ui._stc_KeyGuide_ConsoleUI, "StaticText_B_ConsoleUI")
  if true == _ContentsGroup_UsePadSnapping then
    local keyGuides = {
      self._ui._txt_B_ConsoleUI
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuide_ConsoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui._btn_Close_top:SetShow(false)
    self._ui._btn_Close_bottom:SetShow(false)
    self._ui._stc_KeyGuide_ConsoleUI:SetShow(true)
    self._ui._stc_KeyGuide_ConsoleUI:SetPosY(self._ui._stc_KeyGuide_ConsoleUI:GetPosY() - self._ui._btn_Close_bottom:GetSizeY())
    Panel_Window_ServantRateDesc:SetSize(Panel_Window_ServantRateDesc:GetSizeX(), Panel_Window_ServantRateDesc:GetSizeY() - self._ui._btn_Close_bottom:GetSizeY())
  else
    self._ui._stc_KeyGuide_ConsoleUI:SetShow(false)
  end
  Panel_Window_ServantRateDesc:ignorePadSnapMoveToOtherPanel()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Window_ServantRateDesc:registEventHandler()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Close_top:addInputEvent("Mouse_LUp", "PaGlobal_Window_ServantRateDesc_Close()")
    self._ui._btn_Close_bottom:addInputEvent("Mouse_LUp", "PaGlobal_Window_ServantRateDesc_Close()")
  else
    Panel_Window_ServantRateDesc:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Window_ServantRateDesc_Close()")
    Panel_Window_ServantRateDesc:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEvent_ServantRateDesc_MoveScroll(true)")
    Panel_Window_ServantRateDesc:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEvent_ServantRateDesc_MoveScroll(false)")
  end
end
function PaGlobal_Window_ServantRateDesc:prepareOpen()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  Panel_Window_ServantRateDesc:ComputePos()
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  if true == _ContentsGroup_RenewUI then
    self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSWCHAGNE_DESC_TOOLTIP_CONSOLE"))
  else
    self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSWCHAGNE_DESC_TOOLTIP"))
  end
  self._ui._frame_1_Content:SetSize(self._ui._frame_1_Content:GetSizeX(), self._ui._txt_Desc:GetTextSizeY() + 10)
  self._ui._frame_scroll:SetControlTop()
  self._ui._frame_1:UpdateContentScroll()
  self._ui._frame_1:UpdateContentPos()
  PaGlobal_Window_ServantRateDesc:open()
end
function PaGlobal_Window_ServantRateDesc:open()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  Panel_Window_ServantRateDesc:SetShow(true)
end
function PaGlobal_Window_ServantRateDesc:prepareClose()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  PaGlobal_Window_ServantRateDesc:close()
end
function PaGlobal_Window_ServantRateDesc:close()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  Panel_Window_ServantRateDesc:SetShow(false)
end
function PaGlobal_Window_ServantRateDesc:validate()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  self._ui._btn_Close_top:isValidate()
  self._ui._btn_Close_bottom:isValidate()
  self._ui._stc_KeyGuide_ConsoleUI:isValidate()
  self._ui._frame_1:isValidate()
  self._ui._frame_1_Content:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._frame_scroll:isValidate()
  self._ui._txt_B_ConsoleUI:isValidate()
end
function HandleRSticEvent_ServantRateDesc_MoveScroll(flag)
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  if nil == PaGlobal_Window_ServantRateDesc._ui._frame_1 then
    return
  end
  if false == PaGlobal_Window_ServantRateDesc._ui._frame_1:GetShow() then
    return
  end
  if true == flag then
    PaGlobal_Window_ServantRateDesc._ui._frame_scroll:ControlButtonUp()
  elseif false == flag then
    PaGlobal_Window_ServantRateDesc._ui._frame_scroll:ControlButtonDown()
  end
  PaGlobal_Window_ServantRateDesc._ui._frame_1:UpdateContentScroll()
  PaGlobal_Window_ServantRateDesc._ui._frame_1:UpdateContentPos()
end
function PaGlobal_Window_ServantRateDesc_Open()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  if false == _ContentsGroup_ServantSkillChangeRate then
    return
  end
  PaGlobal_Window_ServantRateDesc:prepareOpen()
end
function PaGlobal_Window_ServantRateDesc_Close()
  if nil == Panel_Window_ServantRateDesc then
    return
  end
  if false == _ContentsGroup_ServantSkillChangeRate then
    return
  end
  PaGlobal_Window_ServantRateDesc:prepareClose()
end
