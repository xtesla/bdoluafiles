function PaGlobal_FriendMessanger_All:createMessanger(messangerIdstr, userName, friendUserNo, isOnline)
  local messanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiSmall = nil,
    _uiPopup = nil,
    _uiAlarm = nil,
    _uiEditGroup = nil,
    _uiEnter = nil,
    _uiPartyInvite = nil,
    _uiEmo = nil,
    _uiEditInputChat = nil,
    _uiSizeControl = nil,
    _uiSlider = nil,
    _uiSliderButton = nil,
    _uiFrame = nil,
    _uiFrameContent = nil,
    _uiFrameScroll = nil,
    _uiStaticBg = {},
    _uiStaticText = {},
    _uiStaticTime = {},
    _uiClassIcon = {},
    _friendUserNo = nil,
    _messangerAlpha = 1,
    _messageCount = 0,
    _isCallShow = false
  }
  function messanger:initialize(messangerIdstr, userName, friendUserNo, isOnline)
    messanger:createPanel(messangerIdstr, isOnline)
    messanger:prepareControl(messangerIdstr, userName, isOnline, friendUserNo)
    PaGlobal_FriendMessanger_All._messangerMinSizeX = messanger._mainPanel:GetSizeX()
    PaGlobal_FriendMessanger_All._messangerMinSizeY = messanger._mainPanel:GetSizeY()
    messanger._friendUserNo = friendUserNo
  end
  function messanger:clear()
    UI.deletePanel(messanger._mainPanel:GetID())
    messanger._mainPanel = nil
    messanger._friendUserNo = nil
  end
  function messanger:createPanel(messangerIdstr, isOnline)
    local newName = "Panel_FriendMessanger" .. messangerIdstr
    messanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Friend_TalkMessanger_All, messanger._mainPanel)
    messanger._mainPanel:SetDragAll(true)
    messanger._mainPanel:SetShow(true)
    messanger._mainPanel:addInputEvent("Mouse_UpScroll", "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", true )")
    messanger._mainPanel:addInputEvent("Mouse_DownScroll", "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", false )")
    if true == _ContentsGroup_UsePadSnapping then
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "FriendMessanger_SetFocusEdit(" .. messangerIdstr .. ")")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", true )")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", false )")
      registerCloseLuaEvent(messanger._mainPanel, PAUIRenderModeBitSet({
        Defines.CloseType.eCloseType_Escape
      }), "FriendMessanger_Close(" .. messangerIdstr .. ")")
    end
  end
  function messanger:prepareControl(messangerIdstr, userName, isOnline, friendUserNo)
    local titleBar = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_Chat_TitleBar")
    local editGroup = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_EditGroup")
    local keyguideBg = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_KeyGuide_Console")
    messanger._uiTitleBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_Chat_TitleBar", 0)
    messanger._uiName = messanger:createControl(__ePAUIControl_StaticText, titleBar, messanger._uiTitleBg, "StaticText_Name", 0)
    messanger._uiName:SetText(userName)
    messanger._uiClose = messanger:createControl(__ePAUIControl_Button, titleBar, messanger._uiTitleBg, "Button_Close", 0)
    messanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessanger_Close(" .. messangerIdstr .. ")")
    messanger._uiSmall = messanger:createControl(__ePAUIControl_Button, titleBar, messanger._uiTitleBg, "Button_Small", 0)
    messanger._uiSmall:addInputEvent("Mouse_LUp", "FriendMessangerFloating_OpenMessanger(" .. messangerIdstr .. "," .. tostring(friendUserNo) .. ")")
    messanger._uiPopup = messanger:createControl(__ePAUIControl_CheckButton, titleBar, messanger._uiTitleBg, "CheckButton_PopUp", 0)
    messanger._uiPopup:addInputEvent("Mouse_LUp", "FriendMessanger_CheckPopupUI(" .. messangerIdstr .. ")")
    messanger._uiAlarm = messanger:createControl(__ePAUIControl_CheckButton, titleBar, messanger._uiTitleBg, "CheckButton_Alarm", 0)
    messanger._uiAlarm:addInputEvent("Mouse_LUp", "FriendMessanger_AlarmToggle(" .. messangerIdstr .. ")")
    messanger._uiSlider = messanger:createControl(__ePAUIControl_Slider, titleBar, messanger._uiTitleBg, "Slider_Alpha", 0)
    messanger._uiSlider:SetInterval(100)
    messanger._uiSlider:SetControlPos(100)
    messanger._uiSlider:addInputEvent("Mouse_LPress", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._uiSlider:addInputEvent("Mouse_LUp", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._uiSliderButton = messanger._uiSlider:GetControlButton()
    messanger._uiSliderButton:addInputEvent("Mouse_LPress", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "FriendMessanger_AlphaSliderForPad(" .. messangerIdstr .. ",false)")
    messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "FriendMessanger_AlphaSliderForPad(" .. messangerIdstr .. ",true)")
    messanger._uiFrame = messanger:createControl(__ePAUIControl_Frame, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Frame_Chat", 0)
    messanger._uiFrameContent = messanger._uiFrame:GetFrameContent()
    messanger._uiFrameScroll = messanger._uiFrame:GetVScroll()
    messanger._uiFrameHScroll = messanger._uiFrame:GetHScroll()
    local styleFrame = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Frame_Chat")
    local styleScroll = UI.getChildControl(styleFrame, "Frame_1_VerticalScroll")
    CopyBaseProperty(styleScroll, messanger._uiFrameScroll)
    messanger._uiFrameHScroll:SetIgnoreChild(true)
    messanger._uiFrameContent:SetSize(0, 0)
    messanger._uiEditGroup = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_EditGroup", 0)
    messanger._uiEnter = messanger:createControl(__ePAUIControl_Button, editGroup, messanger._uiEditGroup, "Button_Enter", 0)
    messanger._uiEnter:addInputEvent("Mouse_LUp", "friend_sendMessage(" .. messangerIdstr .. ")")
    messanger._uiEnter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_BTN"))
    messanger._uiEnter:SetSize(messanger._uiEnter:GetTextSizeX() + 30, messanger._uiEnter:GetSizeY())
    messanger._uiPartyInvite = messanger:createControl(__ePAUIControl_Button, editGroup, messanger._uiEditGroup, "Button_Invite", 0)
    messanger._uiPartyInvite:addInputEvent("Mouse_LUp", "FriendMessanger_PartyInvite(" .. messangerIdstr .. ")")
    messanger._uiPartyInvite:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_PARTY"))
    messanger._uiPartyInvite:SetSize(messanger._uiPartyInvite:GetTextSizeX() + 30, messanger._uiPartyInvite:GetSizeY())
    messanger._uiPartyInvite:SetPosX(messanger._uiEditGroup:GetPosX() + messanger._uiEditGroup:GetSizeX() - messanger._uiPartyInvite:GetSizeX() - 15)
    messanger._uiEnter:SetPosX(messanger._uiPartyInvite:GetPosX() - messanger._uiEnter:GetSizeX() - 5)
    messanger._uiEmo = messanger:createControl(__ePAUIControl_Static, editGroup, messanger._uiEditGroup, "Static_Emo", 0)
    messanger._uiEmo:SetShow(false)
    messanger._uiEditInputChat = messanger:createControl(__ePAUIControl_Edit, editGroup, messanger._uiEditGroup, "Edit_1", 0)
    messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - messanger._uiEnter:GetSizeX() * 2 - 30, messanger._uiEditGroup:GetSizeY())
    messanger._uiEditInputChat:SetMaxInput(100)
    messanger._uiEditInputChat:setOnMouseCursorType(__eMouseCursorType_Text)
    messanger._uiEditInputChat:setClickMouseCursorType(__eMouseCursorType_Text)
    messanger._uiEditInputChat:SetEnable(true)
    messanger._uiEnter:SetEnable(true)
    messanger._uiEditInputChat:addInputEvent("Mouse_LUp", "FriendMessanger_SetFocusEdit(" .. messangerIdstr .. ")")
    if true == _ContentsGroup_RenewUI then
      messanger._uiEditInputChat:setXboxVirtualKeyBoardEndEvent("friend_sendMessageByKey")
    else
      messanger._uiEditInputChat:RegistReturnKeyEvent("friend_sendMessageByKey()")
    end
    messanger._uiSizeControl = messanger:createControl(__ePAUIControl_Button, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Button_SizeControl", 0)
    messanger._uiSizeControl:addInputEvent("Mouse_LDown", "FriendMessanger_ResizeStartPos( " .. messangerIdstr .. " )")
    messanger._uiSizeControl:addInputEvent("Mouse_LPress", "FriendMessanger_Resize( " .. messangerIdstr .. " )")
    messanger._uiSizeControl:setOnMouseCursorType(__eMouseCursorType_ResizeLeft)
    messanger._uiSizeControl:setClickMouseCursorType(__eMouseCursorType_ResizeLeft)
    messanger._keyguideBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_KeyGuide_Console", 0)
    messanger._keyguideClose = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Close_Console", 0)
    messanger._keyguideSend = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Send_Console", 0)
    messanger._keyguideScroll = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Scroll_Console", 0)
    if true == _ContentsGroup_UsePadSnapping then
      messanger._keyguideBg:SetShow(true)
      messanger._uiEditInputChat:SetSize(messanger._uiEditInputChat:GetSizeX() + messanger._uiEnter:GetSizeX(), messanger._uiEditInputChat:GetSizeY())
      messanger._uiClose:SetShow(false)
      messanger._uiEnter:SetShow(false)
      messanger._uiSizeControl:SetShow(false)
      messanger._uiPartyInvite:SetShow(false)
      messanger._keyguideBg:ComputePos()
    else
      messanger._uiPartyInvite:SetShow(true)
      messanger._keyguideBg:SetShow(false)
    end
  end
  function messanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  function messanger:clearAllMessage()
    for index = 0, messanger._messageCount - 1 do
      messanger._uiStaticText[index]:SetShow(false)
      messanger._uiStaticBg[index]:SetShow(false)
      messanger._uiStaticTime[index]:SetShow(false)
      messanger._uiClassIcon[index]:SetShow(false)
      UI.deleteControl(messanger._uiStaticText[index])
      UI.deleteControl(messanger._uiStaticBg[index])
      UI.deleteControl(messanger._uiStaticTime[index])
      UI.deleteControl(messanger._uiClassIcon[index])
    end
    messanger._messageCount = 0
  end
  function messanger:updateMessage(chattingMessage, friendClass, isOnline)
    local msg = chattingMessage:getContent()
    local msgTime = chattingMessage:getTime()
    local isMe = chattingMessage.isMe
    messanger:showMessage(isMe, msg, msgTime, friendClass, isOnline)
    messanger._messageCount = messanger._messageCount + 1
  end
  function messanger:showMessage(isMe, msg, msgTime, friendClass, isOnline)
    messanger:createMessageUI(isMe)
    messanger:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
    messanger:setPosMessageUI(isMe)
  end
  function messanger:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
    local panelSizeX = messanger._mainPanel:GetSizeX()
    local maxTextSizeX = panelSizeX - 100
    local maxTimeTextSize = 100
    local staticText = messanger._uiStaticText[messanger._messageCount]
    local staticBg = messanger._uiStaticBg[messanger._messageCount]
    local staticTime = messanger._uiStaticTime[messanger._messageCount]
    local staticClass = messanger._uiClassIcon[messanger._messageCount]
    if false == isMe then
      staticText:SetFontColor(Defines.Color.C_FF6C6C6C)
    else
      staticText:SetFontColor(Defines.Color.C_FFFFEDD4)
    end
    staticText:SetSize(maxTextSizeX, staticText:GetSizeY())
    staticText:SetAutoResize(true)
    staticText:SetTextMode(__eTextMode_AutoWrap)
    staticText:SetText(msg)
    staticTime:SetFontColor(Defines.Color.C_FF988D83)
    staticTime:SetSize(maxTimeTextSize, staticTime:GetSizeY())
    local timeValue = PATime(msgTime)
    staticTime:SetText(timeValue:GetYear() .. "/" .. timeValue:GetMonth() .. "/" .. timeValue:GetDay() .. " " .. timeValue:GetHour() .. ":" .. timeValue:GetMinute())
    if true == isOnline then
      PaGlobal_Friend_SetTexture(staticClass, friendClass)
    else
      PaGlobal_Friend_SetTexture(staticClass, __eClassType_Count)
    end
    staticBg:SetSize(staticText:GetTextSizeX() + 20, staticText:GetSizeY() + 15)
  end
  function messanger:createMessageUI(isMe)
    local frameChat = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Frame_Chat")
    local frameContent = UI.getChildControl(frameChat, "Frame_1_Content")
    local styleBg = UI.getChildControl(frameContent, "Static_To")
    local styleText = UI.getChildControl(styleBg, "StaticText_To")
    local styleTime = UI.getChildControl(styleBg, "StaticText_Time")
    local styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
    if false == isMe then
      styleBg = UI.getChildControl(frameContent, "Static_From")
      styleText = UI.getChildControl(styleBg, "StaticText_From")
      styleTime = UI.getChildControl(styleBg, "StaticText_Time")
      styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
    end
    messanger._uiStaticBg[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_BG_" .. messanger._messageCount)
    messanger._uiStaticText[messanger._messageCount] = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Text_" .. messanger._messageCount)
    messanger._uiStaticTime[messanger._messageCount] = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Time_" .. messanger._messageCount)
    messanger._uiClassIcon[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_Class_" .. messanger._messageCount)
    CopyBaseProperty(styleBg, messanger._uiStaticBg[messanger._messageCount])
    CopyBaseProperty(styleText, messanger._uiStaticText[messanger._messageCount])
    CopyBaseProperty(styleTime, messanger._uiStaticTime[messanger._messageCount])
    CopyBaseProperty(styleClass, messanger._uiClassIcon[messanger._messageCount])
    messanger._uiStaticBg[messanger._messageCount]:SetShow(true)
    messanger._uiStaticText[messanger._messageCount]:SetIgnore(true)
    messanger._uiStaticText[messanger._messageCount]:SetShow(true)
    messanger._uiStaticTime[messanger._messageCount]:SetIgnore(true)
    messanger._uiStaticTime[messanger._messageCount]:SetShow(true)
    if false == isMe then
      messanger._uiClassIcon[messanger._messageCount]:SetIgnore(true)
      messanger._uiClassIcon[messanger._messageCount]:SetShow(true)
    else
      messanger._uiClassIcon[messanger._messageCount]:SetIgnore(true)
      messanger._uiClassIcon[messanger._messageCount]:SetShow(false)
    end
  end
  function messanger:setPosMessageUI(isMe)
    local prevBgSizeY = 0
    local prevBgPosY = 0
    local preTimeSizeY = messanger._uiStaticBg[messanger._messageCount]:GetSizeY() + 1
    if 0 < messanger._messageCount then
      prevBgSizeY = messanger._uiStaticBg[messanger._messageCount - 1]:GetSizeY()
      prevBgPosY = messanger._uiStaticBg[messanger._messageCount - 1]:GetPosY() + preTimeSizeY
    end
    if false == isMe then
      messanger._uiClassIcon[messanger._messageCount]:SetPosX(5)
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(messanger._uiClassIcon[messanger._messageCount]:GetPosX() + messanger._uiClassIcon[messanger._messageCount]:GetSizeX() + 10)
      messanger._uiStaticText[messanger._messageCount]:SetPosX(messanger._uiStaticBg[messanger._messageCount]:GetPosX() + 10)
      messanger._uiStaticTime[messanger._messageCount]:SetPosX(messanger._uiStaticBg[messanger._messageCount]:GetPosX() + 5)
    else
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(messanger._uiFrameScroll:GetPosX() - messanger._uiStaticBg[messanger._messageCount]:GetSizeX() - 10)
      messanger._uiStaticText[messanger._messageCount]:SetPosX(messanger._mainPanel:GetSizeX() - messanger._uiStaticText[messanger._messageCount]:GetSizeX() - 30)
      messanger._uiStaticTime[messanger._messageCount]:SetPosX(messanger._mainPanel:GetSizeX() - messanger._uiStaticTime[messanger._messageCount]:GetSizeX() - 15)
    end
    messanger._uiStaticBg[messanger._messageCount]:SetPosY(prevBgPosY + prevBgSizeY)
    messanger._uiStaticText[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY() + 10)
    messanger._uiStaticTime[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY() + messanger._uiStaticBg[messanger._messageCount]:GetSizeY() + 5)
    messanger._uiClassIcon[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY())
  end
  messanger:initialize(messangerIdstr, userName, friendUserNo, isOnline)
  return messanger
end
function FriendMessanger_AlphaSlider(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  messanger._messangerAlpha = math.max(messanger._uiSlider:GetControlPos(), 0.1)
  panel:SetAlpha(messanger._messangerAlpha)
  messanger._uiEditGroup:SetAlpha(messanger._messangerAlpha)
end
function FriendMessanger_AlphaSliderForPad(messangerIdstr, isUp)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  if true == isUp then
    messanger._messangerAlpha = messanger._messangerAlpha + 0.1
    messanger._messangerAlpha = math.min(messanger._messangerAlpha, 1)
  else
    messanger._messangerAlpha = messanger._messangerAlpha - 0.1
    messanger._messangerAlpha = math.max(messanger._messangerAlpha, 0)
  end
  messanger._uiSlider:SetControlPos(messanger._messangerAlpha * 100)
  panel:SetAlpha(messanger._messangerAlpha)
  messanger._keyguideBg:SetAlpha(messanger._messangerAlpha)
end
local orgMouseX = 0
local orgMouseY = 0
local orgPanelSizeX = 0
local orgPanelSizeY = 0
local orgPanelPosY = 0
local scrollPos = 0
function FriendMessanger_ResizeStartPos(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  orgMouseX = getMousePosX()
  orgMouseY = getMousePosY()
  orgPanelPosX = panel:GetPosX()
  orgPanelSizeX = panel:GetSizeX()
  orgPanelSizeY = panel:GetSizeY()
  scrollPos = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._uiFrameScroll:GetControlPos()
end
function FriendMessanger_Resize(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = messanger._mainPanel
  if nil == panel then
    return
  end
  local currentPosX = panel:GetPosX()
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  local deltaX = orgMouseX - currentX
  local deltaY = currentY - orgMouseY
  local sizeX = orgPanelSizeX + deltaX
  local sizeY = orgPanelSizeY + deltaY
  if sizeX > PaGlobal_FriendMessanger_All._messangerMaxSizeX then
    sizeX = PaGlobal_FriendMessanger_All._messangerMaxSizeX
  elseif sizeX < PaGlobal_FriendMessanger_All._messangerMinSizeX then
    sizeX = PaGlobal_FriendMessanger_All._messangerMinSizeX
  end
  if sizeY > PaGlobal_FriendMessanger_All._messangerMaxSizeY then
    sizeY = PaGlobal_FriendMessanger_All._messangerMaxSizeY
  elseif sizeY < PaGlobal_FriendMessanger_All._messangerMinSizeY then
    sizeY = PaGlobal_FriendMessanger_All._messangerMinSizeY
  end
  local currentSizeX = panel:GetSizeX()
  local currentSizeY = panel:GetSizeY()
  local titleSizeY = 50
  local gap = 10
  panel:SetSize(sizeX, sizeY)
  panel:SetPosX(currentPosX + currentSizeX - sizeX)
  messanger._uiTitleBg:SetSize(sizeX - 2, titleSizeY)
  messanger._uiClose:SetPosX(panel:GetSizeX() - messanger._uiClose:GetSizeX() - gap)
  messanger._uiPopup:SetPosX(messanger._uiClose:GetPosX() - messanger._uiPopup:GetSizeX() - gap)
  messanger._uiSmall:SetPosX(messanger._uiPopup:GetPosX() - messanger._uiSmall:GetSizeX() - gap)
  messanger._uiSlider:SetPosX(messanger._uiSmall:GetPosX() - messanger._uiSlider:GetSizeX() - gap)
  messanger._uiFrameScroll:SetControlPos(scrollPos)
  messanger._uiSizeControl:SetPosY(panel:GetSizeY() - messanger._uiSizeControl:GetSizeY())
  messanger._uiEditGroup:SetPosX(gap)
  messanger._uiEditGroup:SetPosY(panel:GetSizeY() - messanger._uiEditGroup:GetSizeY() - gap)
  messanger._uiEditGroup:SetSize(panel:GetSizeX() - gap * 2, messanger._uiEditGroup:GetSizeY())
  messanger._uiPartyInvite:SetPosX(messanger._uiEditGroup:GetPosX() + messanger._uiEditGroup:GetSizeX() - messanger._uiPartyInvite:GetSizeX() - gap * 1.5)
  messanger._uiEnter:SetPosX(messanger._uiPartyInvite:GetPosX() - messanger._uiEnter:GetSizeX() - gap * 0.5)
  messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - messanger._uiEnter:GetSizeX() * 2 - gap * 3, messanger._uiEditGroup:GetSizeY())
  messanger._uiEditInputChat:SetEditText(messanger._uiEditInputChat:GetEditText())
  messanger._uiFrame:SetSize(panel:GetSizeX(), panel:GetSizeY() - messanger._uiEditGroup:GetSizeY() - messanger._uiTitleBg:GetSizeY() - gap)
  messanger._uiFrameContent:SetSize(messanger._uiFrame:GetSizeX(), messanger._uiFrame:GetSizeY())
  if true == _ContentsGroup_UsePadSnapping then
    messanger._keyguideBg:SetSize(panel:GetSizeX(), messanger._keyguideBg:GetSizeY())
    messanger._keyguideBg:ComputePos()
    local keyGuides = {
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  FriendMessanger_ListUpdate(messangerIdstr)
end
function FriendMessanger_CheckPopupUI(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiPopup:IsCheck() then
    messanger._mainPanel:OpenUISubApp()
  else
    messanger._mainPanel:CloseUISubApp()
  end
end
function FriendMessanger_AlarmToggle(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiAlarm:IsCheck() then
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, false)
  else
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, true)
  end
end
function FriendMessanger_OnMouseWheel(messangerIdstr, isUp)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local targetScroll = messanger._uiFrameScroll
  if isUp then
    targetScroll:ControlButtonUp()
  else
    targetScroll:ControlButtonDown()
  end
  messanger._uiFrame:UpdateContentPos()
end
function FriendMessanger_CheckCurrentUiEdit(targetUI)
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return false
  end
  local messanger = PaGlobal_FriendMessanger_All._messangerList[PaGlobal_FriendMessanger_All._currentMessangerId]
  if nil == messanger then
    return
  end
  local currentEdit = messanger._uiEditInputChat
  if nil == currentEdit then
    return
  end
  return nil ~= targetUI and targetUI:GetKey() == currentEdit:GetKey()
end
function FriendMessanger_Close(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiPopup:IsCheck() then
    messanger._mainPanel:CloseUISubApp()
  end
  ToClient_CloseFriendMessenger(tonumber64(messangerIdstr), __eMessengerTypeFriend)
  messanger._mainPanel:SetShow(false)
  messanger:clear()
  PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] = nil
  if messangerIdstr == PaGlobal_FriendMessanger_All._currentMessangerId then
    PaGlobal_FriendMessanger_All._currentMessangerId = toInt64(0, -1)
    ClearFocusEdit()
  end
  CheckChattingInput()
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_FriendInfo_All and true == Panel_FriendInfo_All:GetShow() then
    ToClient_padSnapSetTargetPanel(Panel_FriendInfo_All)
  end
end
function FriendMessanger_SetFocusEdit(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  SetFocusEdit(messanger._uiEditInputChat)
  PaGlobal_FriendMessanger_All._currentMessangerId = messangerIdstr
  messanger._uiEditInputChat:SetEditText("")
end
function FriendMessanger_KillFocusEdit()
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return false
  end
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_FriendMessanger_All._currentMessangerId = toInt64(0, -1)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  return false
end
function friend_sendMessageByKey()
  local messangerIdstr = tostring(PaGlobal_FriendMessanger_All._currentMessangerId)
  friend_sendMessage(messangerIdstr)
end
function friend_killFocusMessangerByKey()
  FriendMessanger_KillFocusEdit()
end
function friend_sendMessage(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local friendUserNo = messanger._friendUserNo
  if nil == friendUserNo then
    return
  end
  ToClient_SetSenderMessengerNo(tonumber64(messangerIdstr))
  ToClient_SetSenderMessengerType(__eMessengerTypeFriend)
  chatting_sendMessageByUserNo(friendUserNo, messanger._uiEditInputChat:GetEditText(), CppEnums.ChatType.Messenger)
  messanger._uiEditInputChat:SetEditText("", true)
end
function FriendMessanger_ListUpdate(messangerIdstr)
  ToClient_sortMessengerMessage()
  messangerIdstr = tostring(messangerIdstr)
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local message = messengerInfo:beginMessage()
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId_s64)
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local friendClass = friendInfo:getClassType()
  local isOnline = friendInfo:isOnline()
  if 0 < messanger._messageCount then
    messanger:clearAllMessage()
  end
  while message ~= nil do
    messanger:updateMessage(message, friendClass, isOnline)
    message = messengerInfo:nextMessage()
  end
  messanger._uiAlarm:SetCheck(not messengerInfo:getAlarmIsOn())
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
  if true == _ContentsGroup_UsePadSnapping then
    if true == messanger._uiFrameScroll:GetShow() then
      messanger._keyguideScroll:SetShow(true)
    else
      messanger._keyguideScroll:SetShow(false)
    end
    local keyGuides = {
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function FriendMessanger_IsOpenMessanger(messangerId)
  local messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return false
  end
  return true
end
function FriendMessanger_PartyInvite(messangerIdstr)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(tonumber64(messangerIdstr))
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local userCharacterName = friendInfo:getCharacterName()
  local isOnline = friendInfo:isOnline()
  local groupNo = friendInfo:getGroupNo()
  local userNo = friendInfo:getUserNo()
  local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == RequestFriends_isBlockedFriend(userNo, groupNo) then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if nil ~= userCharacterName and "" ~= userCharacterName and false == isSelfPlayerPlayingPvPMatch then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", userCharacterName))
  end
  RequestParty_inviteCharacter(userCharacterName)
end
function FromClient_FriendInfoListUpdateMessanger(messangerIdstr)
  FriendMessanger_ListUpdate(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  messanger._uiFrameScroll:SetControlBottom()
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
end
function FromClient_FriendInfoListOpenMessanger(messangerId, friendUserNo)
  HandleEventLUp_FriendInfoList_All_MessangerCloseInFriendList()
  local messangerIdstr = tostring(messangerId)
  local friendUserNostr = tostring(friendUserNo)
  local friendInfo = ToClient_getFreindInfoByUserNo(tonumber64(friendUserNostr))
  if nil == friendInfo then
    return
  end
  local userName = friendInfo:getName()
  local isOnline = friendInfo:isOnline()
  if nil == PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] then
    PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] = PaGlobal_FriendMessanger_All:createMessanger(messangerIdstr, userName, tonumber64(friendUserNostr), isOnline)
  end
  FromClient_FriendInfoListUpdateMessanger(messangerIdstr)
end
function FromClient_FriendMessangerUpdate(messangerId)
  local messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  FriendMessanger_ListUpdate(messangerIdstr)
  messanger._uiFrameScroll:SetControlBottom()
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
end
function FromClient_AlarmToggle(messangerId, isOn)
  messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  messanger._uiAlarm:SetCheck(not isOn)
end
