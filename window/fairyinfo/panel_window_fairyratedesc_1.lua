function PaGlobal_Window_FairyRateDesc:initialize()
  if true == PaGlobal_Window_FairyRateDesc._initialize then
    return
  end
  local titleArea = UI.getChildControl(Panel_Window_FairyRateDesc, "Static_TitleArea")
  self._ui._btn_Close_top = UI.getChildControl(titleArea, "Button_Close")
  self._ui._btn_Close_bottom = UI.getChildControl(Panel_Window_FairyRateDesc, "Button_Close")
  self._ui._frame_1 = UI.getChildControl(Panel_Window_FairyRateDesc, "Frame_1")
  self._ui._frame_1_Content = UI.getChildControl(self._ui._frame_1, "Frame_1_Content")
  self._ui._frame_scroll = UI.getChildControl(self._ui._frame_1, "Frame_1_VerticalScroll")
  self._ui._txt_Desc = UI.getChildControl(self._ui._frame_1_Content, "StaticText_Desc")
  self._ui._stc_KeyGuide_ConsoleUI = UI.getChildControl(Panel_Window_FairyRateDesc, "Static_KeyGuide_ConsoleUI")
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
    Panel_Window_FairyRateDesc:SetSize(Panel_Window_FairyRateDesc:GetSizeX(), Panel_Window_FairyRateDesc:GetSizeY() - self._ui._btn_Close_bottom:GetSizeY())
  else
    self._ui._stc_KeyGuide_ConsoleUI:SetShow(false)
  end
  PaGlobal_Window_FairyRateDesc:registEventHandler()
  PaGlobal_Window_FairyRateDesc:validate()
  PaGlobal_Window_FairyRateDesc._initialize = true
end
function PaGlobal_Window_FairyRateDesc:registEventHandler()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._btn_Close_top:addInputEvent("Mouse_LUp", "PaGlobal_Window_FairyRateDesc_Close()")
    self._ui._btn_Close_bottom:addInputEvent("Mouse_LUp", "PaGlobal_Window_FairyRateDesc_Close()")
  else
    Panel_Window_FairyRateDesc:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Window_FairyRateDesc_Close()")
    Panel_Window_FairyRateDesc:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEvent_FairyRateDesc_MoveScroll(1)")
    Panel_Window_FairyRateDesc:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEvent_FairyRateDesc_MoveScroll(-1)")
  end
end
function PaGlobal_Window_FairyRateDesc:prepareOpen()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  if true == ToClient_isConsole() then
    self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYCHAGNE_DESC_TOOLTIP_CONSOLE"))
  else
    self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYCHAGNE_DESC_TOOLTIP"))
  end
  self._ui._frame_1_Content:SetSize(self._ui._frame_1_Content:GetSizeX(), self._ui._txt_Desc:GetTextSizeY() + 10)
  self._ui._frame_scroll:SetControlTop()
  self._ui._frame_1:UpdateContentScroll()
  self._ui._frame_1:UpdateContentPos()
  PaGlobal_Window_FairyRateDesc:open()
end
function PaGlobal_Window_FairyRateDesc:open()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  Panel_Window_FairyRateDesc:SetShow(true)
end
function PaGlobal_Window_FairyRateDesc:prepareClose()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  PaGlobal_Window_FairyRateDesc:close()
end
function PaGlobal_Window_FairyRateDesc:close()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  Panel_Window_FairyRateDesc:SetShow(false)
end
function PaGlobal_Window_FairyRateDesc:validate()
  if nil == Panel_Window_FairyRateDesc then
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
