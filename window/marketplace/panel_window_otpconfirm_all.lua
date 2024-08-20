PaGlobal_OTPConfirm_All = {
  _ui = {
    stc_blockBg = nil,
    stc_bg = nil,
    btn_OTPEnter = nil,
    btn_Close = nil,
    txt_Desc = nil,
    edit_inputOTP = nil,
    stc_KeyGuide_X = nil,
    stc_Bottom_KeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _data = {
    actionType = -1,
    itemKey = 0,
    itemMinLevel = 0,
    selectCount = toInt64(0, 0),
    price = toInt64(0, 0),
    itemLevel = 0,
    isSealed = false,
    isRingBuff = false
  },
  _initilize = false,
  _isConsole = false,
  _MAXINPUT = 8,
  _NUMBER_KEYCODE = {
    CppEnums.VirtualKeyCode.KeyCode_0,
    CppEnums.VirtualKeyCode.KeyCode_1,
    CppEnums.VirtualKeyCode.KeyCode_2,
    CppEnums.VirtualKeyCode.KeyCode_3,
    CppEnums.VirtualKeyCode.KeyCode_4,
    CppEnums.VirtualKeyCode.KeyCode_5,
    CppEnums.VirtualKeyCode.KeyCode_6,
    CppEnums.VirtualKeyCode.KeyCode_7,
    CppEnums.VirtualKeyCode.KeyCode_8,
    CppEnums.VirtualKeyCode.KeyCode_9,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD0,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD1,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD2,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD3,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD4,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD5,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD6,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD7,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD8,
    CppEnums.VirtualKeyCode.KeyCode_NUMPAD9
  }
}
registerEvent("FromClient_luaLoadComplete", "FromClient_OTPConfirm_All")
function FromClient_OTPConfirm_All()
  PaGlobal_OTPConfirm_All:initialize()
end
function PaGlobal_OTPConfirm_All:initialize()
  if true == PaGlobal_OTPConfirm_All._initilize then
    return
  end
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_OTPConfirm_All, "Static_BlockBG")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_OTPConfirm_All, "Static_Bg")
  self._ui.btn_OTPEnter = UI.getChildControl(Panel_Window_OTPConfirm_All, "Button_OTPEnter")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_OTPConfirm_All, "Button_Close")
  self._ui.txt_Desc = UI.getChildControl(Panel_Window_OTPConfirm_All, "StaticText_Content")
  self._ui.edit_inputOTP = UI.getChildControl(Panel_Window_OTPConfirm_All, "Edit_InputOTP")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.edit_inputOTP, "Static_KeyX_Console")
  self._ui.stc_Bottom_KeyGuide = UI.getChildControl(Panel_Window_OTPConfirm_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MARKETPLACE_OTP_EDIT_MSG"))
  self._isConsole = _ContentsGroup_UsePadSnapping
  local textSize = self._ui.txt_Desc:GetTextSizeY()
  local textBGSize = self._ui.txt_Desc:GetSizeY()
  if textSize > textBGSize then
    local gap = textSize - textBGSize
    Panel_Window_OTPConfirm_All:SetSize(Panel_Window_OTPConfirm_All:GetSizeX(), Panel_Window_OTPConfirm_All:GetSizeY() + gap)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() + gap)
    self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), textBGSize + 10)
    Panel_Window_OTPConfirm_All:ComputePos()
    self._ui.txt_Desc:ComputePos()
    self._ui.stc_bg:ComputePos()
    self._ui.btn_Close:ComputePos()
    self._ui.btn_OTPEnter:ComputePos()
    self._ui.edit_inputOTP:ComputePos()
  end
  PaGlobal_OTPConfirm_All:validate()
  PaGlobal_OTPConfirm_All:SwitchUI(self._isConsole)
  PaGlobal_OTPConfirm_All:registerEvent(self._isConsole)
end
function PaGlobal_OTPConfirm_All:validate()
  if true == PaGlobal_OTPConfirm_All._initilize then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.btn_OTPEnter:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.txt_Desc:isValidate()
  self._ui.edit_inputOTP:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_Bottom_KeyGuide:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._initilize = true
end
function PaGlobal_OTPConfirm_All:SwitchUI(isConsole)
  self._ui.btn_OTPEnter:SetShow(not isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isConsole)
  self._ui.stc_KeyGuide_B:SetShow(isConsole)
  self._ui.stc_KeyGuide_X:SetShow(isConsole)
  self._ui.stc_Bottom_KeyGuide:SetShow(isConsole)
  if true == isConsole then
    local minus_btnSizeY = self._ui.btn_OTPEnter:GetSizeY() + 10
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() - minus_btnSizeY)
    Panel_Window_OTPConfirm_All:SetSize(Panel_Window_OTPConfirm_All:GetSizeX(), Panel_Window_OTPConfirm_All:GetSizeY() - minus_btnSizeY)
    self._ui.stc_Bottom_KeyGuide:ComputePos()
    local tempBtnGroup = {
      self._ui.stc_KeyGuide_A,
      self._ui.stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_OTPConfirm_All:registerEvent(isConsole)
  Panel_Window_OTPConfirm_All:ignorePadSnapMoveToOtherPanel()
  registerEvent("onScreenResize", "PaGlobalFunc_OTPConfirm_All_BlockBGResize()")
  if true == isConsole then
    Panel_Window_OTPConfirm_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_OTPConfirm_All_ShowNumberPad()")
    Panel_Window_OTPConfirm_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_OTPConfirm_All_isValidateText()")
    self._ui.edit_inputOTP:setXboxVirtualKeyBoardEndEvent("HandleEventKeyBoard_OTPConfirm_All")
  else
    self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_OTPConfirm_All_Close()")
    self._ui.edit_inputOTP:SetNumberMode(true)
    self._ui.edit_inputOTP:addInputEvent("Mouse_LUp", "HandleEventLUp_OTPConfirm_All_ClearEdit()")
    self._ui.edit_inputOTP:RegistReturnKeyEvent("HandleEventLUp_OTPConfirm_All_isValidateText()")
    self._ui.btn_OTPEnter:addInputEvent("Mouse_LUp", "HandleEventLUp_OTPConfirm_All_isValidateText()")
  end
end
function PaGlobalFunc_OTPConfirm_All_DataSet(actionType, itemKey, itemMinLevel, selectCount, price, itemLevel, isSealed, isRingBuff)
  if nil == Panel_Window_OTPConfirm_All or false == Panel_Window_OTPConfirm_All:GetShow() then
    return
  end
  PaGlobal_OTPConfirm_All._data.actionType = actionType
  PaGlobal_OTPConfirm_All._data.itemKey = itemKey
  PaGlobal_OTPConfirm_All._data.itemMinLevel = itemMinLevel
  PaGlobal_OTPConfirm_All._data.selectCount = selectCount
  PaGlobal_OTPConfirm_All._data.price = price
  PaGlobal_OTPConfirm_All._data.itemLevel = itemLevel
  PaGlobal_OTPConfirm_All._data.isSealed = isSealed
  PaGlobal_OTPConfirm_All._data.isRingBuff = isRingBuff
end
function PaGlobalFunc_OTPConfirm_All_Open()
  if nil == Panel_Window_OTPConfirm_All or true == Panel_Window_OTPConfirm_All:GetShow() then
    return
  end
  ClearFocusEdit()
  PaGlobal_OTPConfirm_All._ui.edit_inputOTP:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRADEMARKET_OTP_EDIT"), true)
  PaGlobal_OTPConfirm_All._data.actionType = -1
  PaGlobal_OTPConfirm_All._data.itemKey = 0
  PaGlobal_OTPConfirm_All._data.itemMinLevel = 0
  PaGlobal_OTPConfirm_All._data.selectCount = toInt64(0, 0)
  PaGlobal_OTPConfirm_All._data.price = toInt64(0, 0)
  PaGlobal_OTPConfirm_All._data.itemLevel = 0
  PaGlobal_OTPConfirm_All._data.isSealed = false
  PaGlobal_OTPConfirm_All._data.isRingBuff = false
  Panel_Window_OTPConfirm_All:SetShow(true)
  PaGlobalFunc_OTPConfirm_All_BlockBGResize()
  ToClient_padSnapSetTargetPanel(Panel_Window_OTPConfirm_All)
end
function PaGlobalFunc_OTPConfirm_All_Close()
  if nil == Panel_Window_OTPConfirm_All or false == Panel_Window_OTPConfirm_All:GetShow() then
    return
  end
  Panel_Window_OTPConfirm_All:SetShow(false)
end
function PaGlobalFunc_OTPConfirm_All_GetShow()
  if nil == Panel_Window_OTPConfirm_All then
    return false
  end
  return Panel_Window_OTPConfirm_All:GetShow()
end
function PaGlobalFunc_OTPConfirm_All_BlockBGResize()
  if nil ~= Panel_Window_OTPConfirm_All or false == Panel_Window_OTPConfirm_All:GetShow() then
    return
  end
  PaGlobal_OTPConfirm_All._ui.stc_blockBg:SetSize(getScreenSizeX(), getScreenSizeY())
end
function HandleEventLUp_OTPConfirm_All_ClearEdit()
  PaGlobal_OTPConfirm_All._ui.edit_inputOTP:SetEditText("", true)
  SetFocusEdit(PaGlobal_OTPConfirm_All._ui.edit_inputOTP)
end
function HandleEventLUp_OTPConfirm_All_ShowNumberPad()
  Panel_NumberPad_Show(true, toInt64(0, 99999999), 0, HandleEventLUp_OTPConfirm_All_SetEditTotalStackText)
end
function HandleEventLUp_OTPConfirm_All_SetEditTotalStackText(count)
  if nil ~= count then
    PaGlobal_OTPConfirm_All._ui.edit_inputOTP:SetEditText(tostring(count))
  end
end
function HandleEventLUp_OTPConfirm_All_isValidateText()
  local userInput = PaGlobal_OTPConfirm_All._ui.edit_inputOTP:GetEditText()
  if "" == userInput then
    return
  end
  ToClient_SetPWorldMarketOTP(userInput)
  local selfData = PaGlobal_OTPConfirm_All._data
  if 0 == selfData.actionType then
    ToClient_requestBuyItemToWorldMarket(selfData.itemKey, selfData.itemMinLevel, selfData.selectCount, selfData.price, selfData.itemLevel)
  elseif 1 == selfData.actionType then
    ToClient_requestSellItemToWorldMarket(selfData.itemKey, selfData.itemMinLevel, selfData.selectCount, selfData.price, selfData.itemLevel, selfData.isSealed, selfData.isRingBuff)
  else
    return
  end
  PaGlobalFunc_OTPConfirm_All_Close()
end
function PaGlobalFunc_OTPConfirm_All_PressKey()
  if nil ~= Panel_Window_OTPConfirm_All and false == Panel_Window_OTPConfirm_All then
    return
  end
  if true == PaGlobal_OTPConfirm_All._ui.edit_inputOTP:GetFocusEdit() then
    local editControl = PaGlobal_OTPConfirm_All._ui.edit_inputOTP
    for idx, val in ipairs(PaGlobal_OTPConfirm_All._NUMBER_KEYCODE) do
      if true == isKeyPressed(val) then
        local curStr = tostring(editControl:GetEditText())
        if nil ~= curStr and "" ~= curStr then
          local length = string.len(curStr)
          if length > PaGlobal_OTPConfirm_All._MAXINPUT then
            local newStr = string.sub(curStr, 0, length - 1)
            editControl:SetEditText(newStr)
          end
        end
      end
    end
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_BACK) then
      if "" ~= editControl:GetEditText() and nil ~= editControl:GetEditText() then
        local str = tostring(editControl:GetEditText())
        local length = string.len(str)
        local newStr = ""
        if length > 0 then
          newStr = string.sub(str, 0, length)
          editControl:SetEditText(tostring(newStr), true)
        end
      else
        PaGlobal_OTPConfirm_All._ui.edit_inputOTP:SetEditText("")
      end
    end
  end
end
function HandleEventKeyBoard_OTPConfirm_All(str)
  PaGlobal_OTPConfirm_All._ui.edit_inputOTP:SetEditText(str)
  ClearFocusEdit()
end
