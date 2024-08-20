function PaGlobal_Expirience_All:initialize()
  if true == PaGlobal_Expirience_All._initialize then
    return
  end
  self._ui.txt_title = UI.getChildControl(Panel_Window_ExpirienceWiki_All, "StaticText_Title")
  self._ui.stc_Deco = UI.getChildControl(self._ui.txt_title, "Static_DecoBG")
  self._ui.btn_close = UI.getChildControl(self._ui.txt_title, "Button_Close")
  self._ui.btn_question = UI.getChildControl(self._ui.txt_title, "Button_Question")
  self._ui.btn_refresh = UI.getChildControl(self._ui.txt_title, "Button_Refresh")
  self._ui.btn_popUp = UI.getChildControl(self._ui.txt_title, "CheckButton_PopUp")
  self._ui.btn_Full = UI.getChildControl(self._ui.txt_title, "Button_Fullsize")
  self._ui.btn_produceNote = UI.getChildControl(Panel_Window_ExpirienceWiki_All, "Button_ProductNote")
  self._ui.stc_webControl = UI.createControl(__ePAUIControl_WebControl, Panel_Window_ExpirienceWiki_All, "WebControl_ExpirienceWiki")
  self._ui.stc_webControl:SetShow(true)
  self._ui.stc_webControl:SetHorizonCenter()
  self._ui.stc_webControl:SetPosY(52)
  self._ui.stc_webControl:SetSize(self._sizeX, self._sizeY)
  self._ui.stc_webControl:ResetUrl()
  self._ui.btn_Full:SetShow(true)
  local tempTable = Array.new()
  tempTable:push_back(self._ui.btn_Full)
  local isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
  self._ui.btn_popUp:SetShow(isPopUpContentsEnable)
  if true == self._ui.btn_popUp:GetShow() then
    tempTable:push_back(self._ui.btn_popUp)
  end
  self._ui.btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  if true == self._ui.btn_refresh:GetShow() then
    tempTable:push_back(self._ui.btn_refresh)
  end
  for idx = 1, #tempTable do
    if nil ~= tempTable[idx] then
      tempTable[idx]:SetSpanSize(10 + 35 * idx, tempTable[idx]:GetSpanSize().y)
    end
  end
  PaGlobal_Expirience_All:registEventHandler()
  PaGlobal_Expirience_All:validate()
  self._originPanelX = Panel_Window_ExpirienceWiki_All:GetSizeX()
  self._originPanelY = Panel_Window_ExpirienceWiki_All:GetSizeY()
  PaGlobal_Expirience_All:changePanelToFullSize(true)
  PaGlobal_Expirience_All._initialize = true
end
function PaGlobal_Expirience_All:registEventHandler()
  if nil == Panel_Window_ExpirienceWiki_All then
    return
  end
  Panel_Window_ExpirienceWiki_All:SetShow(false, false)
  Panel_Window_ExpirienceWiki_All:setGlassBackground(true)
  Panel_Window_ExpirienceWiki_All:RegisterShowEventFunc(true, "Panel_Window_ExpirienceWiki_All_ShowAni()")
  Panel_Window_ExpirienceWiki_All:RegisterShowEventFunc(false, "Panel_Window_ExpirienceWiki_All_HideAni()")
  registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForExpirienceWikiAll")
  registerEvent("FromClient_ResponseExperienceWikiRefresh", "FromClient_ExpirienceWiki_All_GetCurrentUrl")
  registerEvent("FromClient_OpenAdventurerNote", "FromClient_OpenAdventurerNote")
  registerEvent("FromClient_OpenCraftNote", "FromClient_OpenCraftNote")
  registerEvent("FromClient_UpdateWebLoginAccessToken", "FromClient_UpdateWebLoginAccessToken")
  registerEvent("FromClient_KeyboardHelpShow", "FromClient_KeyboardHelpShow")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "InputMLUp_ExpirienceWiki_All_Close()")
  self._ui.btn_popUp:addInputEvent("Mouse_LUp", "PaGlobal_ExpirienceWiki_All_CheckPopupUI()")
  self._ui.btn_Full:addInputEvent("Mouse_LUp", "HandleEventLUp_ExpirienceWiki_All_SetFulllScreen()")
  self._ui.btn_Full:addInputEvent("Mouse_On", "PaGlobal_ExpirienceWiki_All_FullSizeBtnToolTip(true)")
  self._ui.btn_Full:addInputEvent("Mouse_Out", "PaGlobal_ExpirienceWiki_All_FullSizeBtnToolTip(false)")
  self._ui.btn_popUp:addInputEvent("Mouse_On", "PaGlobal_ExpirienceWiki_All_ShowIconToolTip(true)")
  self._ui.btn_popUp:addInputEvent("Mouse_Out", "PaGlobal_ExpirienceWiki_All_ShowIconToolTip(false)")
  self._ui.btn_produceNote:addInputEvent("Mouse_LUp", "Panel_ProductNote_ShowToggle()")
  PaGlobal_Util_RegistWebResetControl(self._ui.btn_refresh)
  Panel_Window_ExpirienceWiki_All:SetDragEnable(true)
  Panel_Window_ExpirienceWiki_All:SetDragAll(true)
end
function PaGlobal_Expirience_All:prepareOpen()
  if nil == Panel_Window_ExpirienceWiki_All or true == Panel_Window_ExpirienceWiki_All:GetShow() then
    return
  end
  if true == isUseTotalAccount() then
    ToClient_AdventurerPageAutoLogin()
    return
  else
    self._ui.stc_webControl:ResetUrl()
    self._isFullSize = true
    local isFullSIze = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__eExperienceWIkiFullScreenNoSave)
    if nil ~= isFullSIze then
      self._isFullSize = isFullSIze
    end
    PaGlobal_Expirience_All:changePanelToFullSize(self._isFullSize)
    PaGlobal_Expirience_All:SetUrl()
    Panel_Window_ExpirienceWiki_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_ExpirienceWiki_All:GetSizeX() / 2)
    Panel_Window_ExpirienceWiki_All:SetPosY(getScreenSizeY() / 2 - Panel_Window_ExpirienceWiki_All:GetSizeY() / 2)
    if nil ~= PaGlobalFunc_GrowthPass_IsShow and true == PaGlobalFunc_GrowthPass_IsShow() then
      self._isOpenFromGrowthPass = true
    end
    PaGlobal_Expirience_All:open()
  end
end
function PaGlobal_Expirience_All:SetUrlTotalAccount(token)
  audioPostEvent_SystemUi(13, 6)
  FGlobal_SetCandidate()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = ToClient_getIngameBoardURL()
  local userNo = getSelfPlayer():get():getUserNo()
  local isGm = ToClient_SelfPlayerIsGM()
  if nil == self._directLinkUrl and true == self._isEventTabOpen then
    url = url .. "/NewsList?boardType=3"
  end
  if nil ~= self._directLinkUrl and false == self._isWiki then
    url = self._directLinkUrl
    url = url .. "&_token=" .. tostring(token) .. "&_userNo=" .. tostring(userNo) .. "&isGm=" .. tostring(isGm)
  elseif nil ~= self._directLinkUrl and true == self._isWiki then
    url = self._directLinkUrl
    url = url .. "?_token=" .. tostring(token) .. "&_userNo=" .. tostring(userNo) .. "&isGm=" .. tostring(isGm)
  else
    url = url .. "?_token=" .. tostring(token) .. "&_userNo=" .. tostring(userNo) .. "&isGm=" .. tostring(isGm)
  end
  self._isWiki = false
  self._isEventTabOpen = false
  self._directLinkUrl = nil
  self._ui.stc_webControl:SetUrl(self._ui.stc_webControl:GetSizeX(), self._ui.stc_webControl:GetSizeY(), url, false, true)
  self._ui.stc_webControl:SetIME(true)
end
function PaGlobal_Expirience_All:SetUrl()
  audioPostEvent_SystemUi(13, 6)
  FGlobal_SetCandidate()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local url = ToClient_getIngameBoardURL()
  local characterNo = getSelfPlayer():getCharacterNo_64()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local isGm = ToClient_SelfPlayerIsGM()
  local classType = getSelfPlayer():getClassType()
  local userNickName = getSelfPlayer():getUserNickname()
  local userNo = getSelfPlayer():get():getUserNo()
  local langType = getGameServiceResType()
  if nil == self._directLinkUrl and true == self._isEventTabOpen then
    url = url .. "/News/Index"
  end
  if nil ~= self._directLinkUrl then
    url = self._directLinkUrl
    url = url .. "&userNo=" .. tostring(userNo) .. "&userNickname=" .. tostring(userNickName) .. "&certKey=" .. tostring(cryptKey) .. "&characterNo=" .. tostring(characterNo) .. "&isGm=" .. tostring(isGm) .. "&langType=" .. tostring(langType)
  else
    url = url .. "?userNo=" .. tostring(userNo) .. "&userNickName=" .. tostring(userNickName) .. "&langType=" .. tostring(langType) .. "&isGm=" .. tostring(isGm) .. "&certKey=" .. tostring(cryptKey) .. "&characterNo=" .. tostring(characterNo) .. "&utm_source=link&utm_medium=menu&utm_campaign=note"
  end
  self._isEventTabOpen = false
  self._directLinkUrl = nil
  self._ui.stc_webControl:SetUrl(self._ui.stc_webControl:GetSizeX(), self._ui.stc_webControl:GetSizeY(), url, false, true)
  self._ui.stc_webControl:SetIME(true)
end
function PaGlobal_Expirience_All:refreshCurrentUrl(url)
  if nil == url then
    return
  end
  self._ui.stc_webControl:ResetUrl()
  self._ui.stc_webControl:SetUrl(self._ui.stc_webControl:GetSizeX(), self._ui.stc_webControl:GetSizeY(), url, false, true)
  self._ui.stc_webControl:SetIME(true)
end
function PaGlobal_Expirience_All:open()
  if nil == Panel_Window_ExpirienceWiki_All then
    return
  end
  Panel_Window_ExpirienceWiki_All:SetShow(true, true)
  ToClient_UpdateOpenUICondition(__eCheckOpenUIType_ExpirienceWiki)
end
function PaGlobal_Expirience_All:prepareClose()
  if nil == Panel_Window_ExpirienceWiki_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  TooltipSimple_Hide()
  FGlobal_ClearCandidate()
  if true == self._isOpenFromGrowthPass then
    PaGlobalFunc_GrowthPass_Open()
    self._isOpenFromGrowthPass = false
  end
  self._ui.stc_webControl:ResetUrl()
  PaGlobal_Expirience_All:close()
end
function PaGlobal_Expirience_All:close()
  if nil == Panel_Window_ExpirienceWiki_All then
    return
  end
  Panel_Window_ExpirienceWiki_All:SetShow(false, false)
end
function PaGlobal_Expirience_All:validate()
  if nil == Panel_Window_ExpirienceWiki_All then
    return
  end
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.stc_webControl:isValidate()
  self._ui.btn_popUp:isValidate()
  self._ui.btn_produceNote:isValidate()
  self._ui.btn_Full:isValidate()
end
function PaGlobal_Expirience_All:changePanelToFullSize(toFullSize)
  if true == toFullSize then
    local padding = 10
    self._ui.txt_title:SetSize(getScreenSizeX() - padding, self._ui.txt_title:GetSizeY())
    Panel_Window_ExpirienceWiki_All:SetSize(getScreenSizeX() - padding, getScreenSizeY() - padding)
    self._ui.stc_webControl:SetSize(Panel_Window_ExpirienceWiki_All:GetSizeX() - 2, Panel_Window_ExpirienceWiki_All:GetSizeY() - (self._ui.txt_title:GetSizeY() + self._ui.btn_produceNote:GetSizeY() + 30))
    if true == isUseTotalAccount() then
      self._ui.stc_webControl:SetSize(Panel_Window_ExpirienceWiki_All:GetSizeX() - 2, Panel_Window_ExpirienceWiki_All:GetSizeY() - self._ui.txt_title:GetSizeY())
    end
    self._ui.btn_Full:ChangeTextureInfoNameAsync("combine/btn/combine_btn_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 410, 180, 440, 210)
    self._ui.btn_Full:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.btn_Full:setRenderTexture(self._ui.btn_Full:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 410, 211, 440, 241)
    self._ui.btn_Full:getOnTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 410, 242, 440, 272)
    self._ui.btn_Full:getClickTexture():setUV(x1, y1, x2, y2)
  else
    self._ui.txt_title:SetSize(self._originPanelX, self._ui.txt_title:GetSizeY())
    self._ui.stc_webControl:SetSize(self._sizeX, self._sizeY)
    Panel_Window_ExpirienceWiki_All:SetSize(self._originPanelX, self._originPanelY)
    if true == isUseTotalAccount() then
      self._ui.stc_webControl:SetSize(self._sizeX, Panel_Window_ExpirienceWiki_All:GetSizeY() - self._ui.txt_title:GetSizeY())
    end
    self._ui.btn_Full:ChangeTextureInfoNameAsync("combine/btn/combine_btn_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 441, 180, 471, 210)
    self._ui.btn_Full:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.btn_Full:setRenderTexture(self._ui.btn_Full:getBaseTexture())
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 441, 211, 471, 241)
    self._ui.btn_Full:getOnTexture():setUV(x1, y1, x2, y2)
    x1, y1, x2, y2 = setTextureUV_Func(self._ui.btn_Full, 410, 242, 440, 272)
    self._ui.btn_Full:getClickTexture():setUV(x1, y1, x2, y2)
  end
  Panel_Window_ExpirienceWiki_All:ComputePos()
  self._ui.txt_title:ComputePos()
  self._ui.stc_webControl:ComputePos()
  self._ui.txt_title:SetEnableArea(0, 0, self._ui.txt_title:GetSizeX(), self._ui.txt_title:GetSizeY())
  self._ui.stc_Deco:ComputePos()
  self._ui.btn_close:ComputePos()
  self._ui.btn_question:ComputePos()
  self._ui.btn_refresh:ComputePos()
  self._ui.btn_popUp:ComputePos()
  self._ui.btn_Full:ComputePos()
  self._ui.btn_produceNote:ComputePos()
  self._ui.stc_webControl:SetPosY(52)
end
function FromClient_OpenAdventurerNote(token)
  if nil == Panel_Window_ExpirienceWiki_All or true == Panel_Window_ExpirienceWiki_All:GetShow() then
    return
  end
  local self = PaGlobal_Expirience_All
  self._ui.btn_produceNote:SetShow(false)
  self._ui.stc_webControl:ResetUrl()
  self._isFullSize = true
  local isFullSIze = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__eExperienceWIkiFullScreenNoSave)
  if nil ~= isFullSIze then
    self._isFullSize = isFullSIze
  end
  PaGlobal_Expirience_All:changePanelToFullSize(self._isFullSize)
  PaGlobal_Expirience_All:SetUrlTotalAccount(token)
  Panel_Window_ExpirienceWiki_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_ExpirienceWiki_All:GetSizeX() / 2)
  Panel_Window_ExpirienceWiki_All:SetPosY(getScreenSizeY() / 2 - Panel_Window_ExpirienceWiki_All:GetSizeY() / 2)
  PaGlobal_Expirience_All:open()
end
function FromClient_OpenCraftNote()
  Panel_ProductNote_ShowToggle()
end
function FromClient_KeyboardHelpShow()
  FGlobal_KeyboardHelpShow()
end
function FromClient_UpdateWebLoginAccessToken()
  local messageBoxTitle = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_TEXT_TITLE")
  local messageBoxDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXPIRIENCEWIKI_LOGIN_DESC")
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxDesc,
    functionYes = updateWebLogin,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function updateWebLogin()
  InputMLUp_ExpirienceWiki_All_Close()
  ToClient_AdventurerPageAutoLogin()
end
