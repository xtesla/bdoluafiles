function PaGlobal_DescBox_ItemCopy:init()
  if nil == Panel_Window_DescBox_ItemCopy then
    UI.ASSERT_NAME("\235\133\184\235\140\128\236\152\129", false, "PaGlobal_Equip_CharacterTag_ItemCopy:init \236\139\164\237\140\168 Panel_Window_Equip_CharacterTag_ItemCopy \237\140\168\235\132\144\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164")
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_LineBG = UI.getChildControl(Panel_Window_DescBox_ItemCopy, "Static_LineBG")
  self._ui._frame1 = UI.getChildControl(stc_LineBG, "Frame_1")
  self._ui._frame_content1 = UI.getChildControl(self._ui._frame1, "Frame_1_Content")
  self._ui._txt_Desc = UI.getChildControl(self._ui._frame_content1, "StaticText_Desc")
  self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_Desc:SetText(self._ui._txt_Desc:GetText())
  self._ui._frame_scroll = UI.getChildControl(self._ui._frame1, "Frame_1_VerticalScroll")
  local gapY = 20
  local textSizeY = self._ui._txt_Desc:GetTextSizeY() + gapY
  self._ui._frame_content1:SetSize(self._ui._frame_content1:GetSizeX(), textSizeY)
  self._ui._txt_Desc:SetSize(self._ui._txt_Desc:GetSizeX(), textSizeY)
  local stc_titleArea = UI.getChildControl(Panel_Window_DescBox_ItemCopy, "Static_TitleArea")
  self._ui._btn_winClose = UI.getChildControl(stc_titleArea, "Button_Win_Close")
  self._ui._btn_function = UI.getChildControl(Panel_Window_DescBox_ItemCopy, "Button_Function")
  self._ui._stc_KeyGuide_ConsoleUI = UI.getChildControl(Panel_Window_DescBox_ItemCopy, "Static_KeyGuide_ConsoleUI")
  self._ui._txt_KeyGuide_Close = UI.getChildControl(self._ui._stc_KeyGuide_ConsoleUI, "StaticText_B_ConsoleUI")
  PaGlobal_DescBox_ItemCopy:validate()
  PaGlobal_DescBox_ItemCopy:registerEventHandler()
  PaGlobal_DescBox_ItemCopy:setConsoleUI()
end
function PaGlobal_DescBox_ItemCopy:setConsoleUI()
  if false == self._isConsole then
    return
  end
  self._ui._btn_winClose:SetShow(not ToClient_isConsole())
  self._ui._btn_function:SetShow(false)
  self._ui._stc_KeyGuide_ConsoleUI:SetShow(true)
  local keyGuides = {
    self._ui._txt_KeyGuide_Close
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuide_ConsoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  local gabY = 70
  Panel_Window_DescBox_ItemCopy:SetSize(Panel_Window_DescBox_ItemCopy:GetSizeX(), Panel_Window_DescBox_ItemCopy:GetSizeY() - gabY)
  local stc_MainArea = UI.getChildControl(Panel_Window_DescBox_ItemCopy, "Static_MainArea")
  if nil ~= stc_MainArea then
    stc_MainArea:SetSize(stc_MainArea:GetSizeX(), stc_MainArea:GetSizeY() - gabY)
  end
  self._ui._stc_KeyGuide_ConsoleUI:ComputePos()
end
function PaGlobal_DescBox_ItemCopy:prepareOpen()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  self:open()
end
function PaGlobal_DescBox_ItemCopy:open()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  Panel_Window_DescBox_ItemCopy:SetShow(true)
end
function PaGlobal_DescBox_ItemCopy:prepareClose()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  self:close()
end
function PaGlobal_DescBox_ItemCopy:close()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  Panel_Window_DescBox_ItemCopy:SetShow(false)
end
function PaGlobal_DescBox_ItemCopy:registerEventHandler()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  self._ui._btn_winClose:addInputEvent("Mouse_LUp", "PaGlobal_DescBox_ItemCopy_Close()")
  self._ui._btn_function:addInputEvent("Mouse_LUp", "PaGlobal_DescBox_ItemCopy_Close()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_DescBox_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleRSticEvent_DescBox_ItemCopy_MoveScroll(true)")
    Panel_Window_DescBox_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleRSticEvent_DescBox_ItemCopy_MoveScroll(false)")
  end
end
function PaGlobal_DescBox_ItemCopy:validate()
  if nil == Panel_Window_DescBox_ItemCopy then
    UI.ASSERT_NAME(false, "Panel_Window_DescBox_ItemCopy \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\235\133\184\235\140\128\236\152\129")
    return
  end
  self._ui._frame1:isValidate()
  self._ui._frame_content1:isValidate()
  self._ui._frame_scroll:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._btn_winClose:isValidate()
  self._ui._btn_function:isValidate()
  self._ui._stc_KeyGuide_ConsoleUI:isValidate()
  self._ui._txt_KeyGuide_Close:isValidate()
end
