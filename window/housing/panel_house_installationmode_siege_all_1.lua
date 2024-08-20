function PaGlobal_House_InstallationSiege_All:initialize()
  if true == PaGlobal_House_InstallationSiege_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_backGround = UI.getChildControl(Panel_House_InstallationMode_Siege_All, "Static_House_InstallationMode_Right")
  local stc_titleBg = UI.getChildControl(self._ui._stc_backGround, "Static_TitleBg")
  self._ui._txt_titleText = UI.getChildControl(stc_titleBg, "StaticText_Title_Top")
  local stc_kitBg = UI.getChildControl(self._ui._stc_backGround, "Static_Kit_BG")
  self._ui._stc_itemKit = UI.getChildControl(stc_kitBg, "Static_Item_Kit")
  self._ui._stc_iconKit = UI.getChildControl(self._ui._stc_itemKit, "Static_Icon_Kit")
  self._ui._txt_itemKitName = UI.getChildControl(self._ui._stc_itemKit, "StaticText_KitName")
  self._ui._txt_itemKitCount = UI.getChildControl(self._ui._stc_itemKit, "StaticText_Count_Kit")
  local stc_categoryBg = UI.getChildControl(self._ui._stc_backGround, "Static_CategoryBG")
  self._ui._edit_searchBox = UI.getChildControl(stc_categoryBg, "Edit_SearchBox")
  self._ui._txt_searchIcon = UI.getChildControl(self._ui._edit_searchBox, "StaticText_SearchIcon")
  self._ui._stc_tentListBg = UI.getChildControl(self._ui._stc_backGround, "Static_HousingItemListBG")
  self._ui._list2_tentList = UI.getChildControl(self._ui._stc_tentListBg, "List2_1")
  self._ui._stc_tentListBg:SetShow(true)
  self._baseItemListBgSizeY = self._ui._stc_tentListBg:GetSizeY()
  self._baseItemListSizeY = self._ui._list2_tentList:GetSizeY()
  self._ui._btn_cancel = UI.getChildControl(self._ui._stc_backGround, "Button_Cancel")
  self._ui._stc_consoleKeyBG = UI.getChildControl(Panel_House_InstallationMode_Siege_All, "Static_KeyGuide_ConsoleBG")
  self._baseKeyGuideSpanGapX = self._ui._stc_consoleKeyBG:GetSpanSize().x
  self._ui._keyGuideBgList = {
    [self._eKeyType.KEY_RS_CLICK] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_Click_ConsoleUI"),
    [self._eKeyType.KEY_RS_UPDOWN] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_UpDown_ConsoleUI"),
    [self._eKeyType.KEY_RS_LEFTRIGHT] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_LeftRight_ConsoleUI"),
    [self._eKeyType.KEY_RS] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_RS_ConsoleUI"),
    [self._eKeyType.KEY_LS] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LS_ConsoleUI"),
    [self._eKeyType.KEY_LB_RB] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LB_RB_ConsoleUI"),
    [self._eKeyType.KEY_LT_RT] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_LT_RT_ConsoleUI"),
    [self._eKeyType.KEY_Y] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_Y_ConsoleUI"),
    [self._eKeyType.KEY_X] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_X_ConsoleUI"),
    [self._eKeyType.KEY_A] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_A_ConsoleUI"),
    [self._eKeyType.KEY_B] = UI.getChildControl(self._ui._stc_consoleKeyBG, "StaticText_B_ConsoleUI")
  }
  PaGlobal_House_InstallationSiege_All:registEventHandler()
  PaGlobal_House_InstallationSiege_All:validate()
  self._ui._txt_itemKitName:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_itemKitName:SetText(self._ui._txt_itemKitName:GetText())
  PaGlobal_House_InstallationSiege_All._initialize = true
end
function PaGlobal_House_InstallationSiege_All:registEventHandler()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_Close()")
  if true == self._isConsole then
    Panel_House_InstallationMode_Siege_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_House_InstallationSiege_All_SetSearchFocus()")
    self._ui._edit_searchBox:setXboxVirtualKeyBoardEndEvent("HandleEventKey_House_InstallationSiege_All_FindItemName_ForConsole")
    self._ui._stc_consoleKeyBG:SetShow(true)
    self._ui._btn_cancel:SetShow(false)
  else
    self._ui._edit_searchBox:addInputEvent("Mouse_LUp", "HandleEventLUp_House_InstallationSiege_All_EditItemNameClear()")
  end
  self._ui._edit_searchBox:RegistReturnKeyEvent("HandleEventKey_House_InstallationSiege_All_FindItemName()")
  self._ui._list2_tentList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_House_InstallationSiege_All_CreateSiegeInstallationList2")
  self._ui._list2_tentList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "PaGlobal_House_InstallationSiege_All_OnScreenResize")
  registerEvent("FromClient_OpenSiegeInstallationList", "PaGlobal_House_InstallationSiege_All_FromClient_OpenSiegeInstallationList")
  registerEvent("FromClient_InventoryUpdate", "PaGlobal_House_InstallationSiege_All_FromClient_InventoryUpdate")
end
function PaGlobal_House_InstallationSiege_All:resize()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  Panel_House_InstallationMode_Siege_All:SetSize(Panel_House_InstallationMode_Siege_All:GetSizeX(), getScreenSizeY())
  Panel_House_InstallationMode_Siege_All:ComputePosAllChild()
  local gapY = 0
  if false == self._ui._btn_cancel:GetShow() then
    gapY = self._ui._btn_cancel:GetSizeY()
  end
  self._ui._stc_tentListBg:SetSize(self._ui._stc_tentListBg:GetSizeX(), self._baseItemListBgSizeY + gapY)
  self._ui._list2_tentList:SetSize(self._ui._list2_tentList:GetSizeX(), self._baseItemListSizeY + gapY)
end
function PaGlobal_House_InstallationSiege_All:prepareOpen()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  if true == self._isConsole then
    if nil ~= Panel_Window_Inventory and true == Panel_Window_Inventory:GetShow() and nil ~= PaGlobalFunc_InventoryInfo_Close then
      PaGlobalFunc_InventoryInfo_Close()
    end
    self:setKeyGuide(self._eModeState.NONE)
  else
    if true == _ContentsGroup_NewUI_Inventory_All then
      if nil ~= Panel_Window_Inventory_All and true == Panel_Window_Inventory_All:IsShow() and nil ~= PaGlobalFunc_Inventory_All_Close then
        PaGlobalFunc_Inventory_All_Close()
      end
    elseif nil ~= Panel_Window_Inventory and true == Panel_Window_Inventory:IsShow() and nil ~= HandleClicked_InventoryWindow_Close then
      HandleClicked_InventoryWindow_Close()
    end
    if true == _ContentsGroup_NewUI_Equipment_All then
      if nil ~= PaGlobalFunc_Equipment_All_Close then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif nil ~= EquipmentWindow_Close then
      EquipmentWindow_Close()
    end
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    if nil ~= PaGlobalFunc_ClothInventory_All_Close then
      PaGlobalFunc_ClothInventory_All_Close()
    end
  elseif nil ~= ClothInventory_Close then
    ClothInventory_Close()
  end
  SetUIMode(Defines.UIMode.eUIMode_SiegeInstallMode)
  self:resize()
  self:clearEdit()
  self:initTentKitItemInfo()
  self:createSiegeInstallationList()
  PaGlobal_House_InstallationSiege_All:open()
end
function PaGlobal_House_InstallationSiege_All:open()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  Panel_House_InstallationMode_Siege_All:SetShow(true)
end
function PaGlobal_House_InstallationSiege_All:prepareClose()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  SetUIMode(Defines.UIMode.eUIMode_Default)
  ToClient_clearSiegeInstallableList()
  for ii = 0, self._dataCount - 1 do
    if nil ~= self._radioBtnSlot[ii] then
      self._radioBtnSlot[ii]:SetCheck(false)
    end
  end
  self._radioBtnSlot = {}
  self._dataCount = 0
  self._itemEnchantKey = nil
  self._currentSelectedIndex = nil
  self:clearEdit()
  TooltipSimple_Hide()
  PaGlobal_House_InstallationSiege_All:close()
end
function PaGlobal_House_InstallationSiege_All:close()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  Panel_House_InstallationMode_Siege_All:SetShow(false)
end
function PaGlobal_House_InstallationSiege_All:update()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
end
function PaGlobal_House_InstallationSiege_All:validate()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  self._ui._stc_backGround:isValidate()
  self._ui._txt_titleText:isValidate()
  self._ui._edit_searchBox:isValidate()
  self._ui._txt_searchIcon:isValidate()
  self._ui._stc_tentListBg:isValidate()
  self._ui._list2_tentList:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._txt_itemKitName:isValidate()
  self._ui._stc_consoleKeyBG:isValidate()
  for index = 1, self._eKeyType.COUNT - 1 do
    self._ui._keyGuideBgList[index]:isValidate()
  end
end
function PaGlobal_House_InstallationSiege_All:initTentKitItemInfo()
  local selfPlayer = getSelfPlayer():get()
  if nil == selfPlayer then
    return
  end
  local itemEnchantWrapper = getItemEnchantStaticStatus(self._itemEnchantKey)
  if nil == itemEnchantWrapper then
    return
  end
  local itemCount = Int64toInt32(ToClient_InventoryGetItemCountAll(self._itemEnchantKey))
  self._ui._txt_itemKitCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INST_SIEGE_MYKIT", "count", itemCount))
  self._ui._stc_iconKit:ChangeTextureInfoName("Icon/" .. itemEnchantWrapper:getIconPath())
end
function PaGlobal_House_InstallationSiege_All:createSiegeInstallationList()
  local listSize = ToClient_getSiegeInstallableListSize()
  self._ui._list2_tentList:getElementManager():clearKey()
  if listSize > 0 then
    for ii = 0, listSize - 1 do
      self._ui._list2_tentList:getElementManager():pushKey(ii)
    end
  end
  self._ui._list2_tentList:ComputePos()
  self._dataCount = listSize
end
function PaGlobal_House_InstallationSiege_All:checkRemainTentKitItemCount()
  local itemEnchantWrapper = getItemEnchantStaticStatus(self._itemEnchantKey)
  if nil == itemEnchantWrapper then
    return
  end
  local itemCount = Int64toInt32(ToClient_InventoryGetItemCountAll(self._itemEnchantKey))
  if itemCount <= 0 then
    self:prepareClose()
    return
  end
  local showText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INST_SIEGE_MYKIT", "count", itemCount)
  self._ui._txt_itemKitCount:SetText(showText)
end
function PaGlobal_House_InstallationSiege_All:openAnimation()
  local screenX = getScreenSizeX()
  local anim = self._ui._stc_backGround:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local sizeX = self._ui._stc_backGround:GetSizeX()
  local posY = self._ui._stc_backGround:GetPosY()
  local offsetRate = 1.3
  anim:SetStartPosition(screenX, posY)
  anim:SetEndPosition(screenX - sizeX * offsetRate, posY)
  self._ui._stc_backGround:CalcUIAniPos(anim)
end
function PaGlobal_House_InstallationSiege_All:hideAnimation()
  local screenX = getScreenSizeX()
  local anim = self._ui._stc_backGround:addMoveAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  local sizeX = self._ui._stc_backGround:GetSizeX()
  local posY = self._ui._stc_backGround:GetPosY()
  local offsetRate = 1.3
  anim:SetStartPosition(screenX - sizeX * offsetRate, posY)
  anim:SetEndPosition(screenX, posY)
  self._ui._stc_backGround:CalcUIAniPos(anim)
end
function PaGlobal_House_InstallationSiege_All:requestSiegeInstallationStart(index)
  if nil == Panel_House_InstallationMode_Siege_All or false == Panel_House_InstallationMode_Siege_All:GetShow() then
    return
  end
  if nil == index or index == self._currentSelectedIndex then
    return
  end
  if nil ~= self._currentSelectedIndex then
    if nil ~= self._radioBtnSlot[index] then
      self._radioBtnSlot[index]:SetCheck(false)
    end
    if nil ~= self._radioBtnSlot[self._currentSelectedIndex] then
      self._radioBtnSlot[self._currentSelectedIndex]:SetCheck(true)
    end
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "TENT_BUILD_CANCEL_MESSAGEBOX_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "TENT_BUILD_CANCEL_MESSAGEBOX_MEMO"),
      functionYes = Panel_Housing_CancelBuildTent_InteractionFromMessageBox,
      functionCancel = MessageBox_Housing_Default_Cancel_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  local characterWrapper = ToClient_getSiegeInstallableListByIndex(index)
  if nil == characterWrapper then
    return
  end
  local characterKey = characterWrapper:getCharacterKey()
  if 0 == characterKey then
    return
  end
  local rv = ToClient_requestSiegeInstallationStart(self._itemEnchantKey, characterKey)
  if 0 ~= rv then
    if nil ~= self._radioBtnSlot[index] then
      self._radioBtnSlot[index]:SetCheck(false)
    end
    self._ui._stc_backGround:SetShow(true)
    return
  end
  self._ui._stc_backGround:SetShow(false)
  if true == self._isConsole then
    ToClient_setMousePosition(0, 0)
  end
  self._currentSelectedIndex = index
end
function PaGlobal_House_InstallationSiege_All:endBuildTent()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  if nil ~= self._radioBtnSlot[self._currentSelectedIndex] then
    self._radioBtnSlot[self._currentSelectedIndex]:SetCheck(false)
  end
  self._currentSelectedIndex = nil
  self._ui._stc_backGround:SetShow(true)
end
function PaGlobal_House_InstallationSiege_All:clearEdit()
  ClearFocusEdit()
  self._ui._txt_searchIcon:SetShow(true)
  self._ui._edit_searchBox:SetEditText("", true)
end
function PaGlobal_House_InstallationSiege_All:firstItemSnapping()
  if false == self._isConsole then
    return
  end
  if nil ~= self._radioBtnSlot[0] then
    local stc_itemTemp = UI.getChildControl(self._radioBtnSlot[0], "Static_Item_Templete")
    if nil ~= stc_itemTemp then
      ToClient_padSnapChangeToTarget(stc_itemTemp)
    end
  end
end
function PaGlobal_House_InstallationSiege_All:setKeyGuide(modeState)
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
  for index = 1, self._eKeyType.COUNT - 1 do
    if nil ~= self._ui._keyGuideBgList[index] then
      self._ui._keyGuideBgList[index]:SetShow(false)
    end
  end
  if false == self._isConsole then
    return
  end
  local keySize
  local keyGuideGapSizeX = 10
  if self._eModeState.NONE == modeState then
    self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetText(self._keyGuideString.SELECT)
    self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetShow(true)
    self._ui._keyGuideBgList[self._eKeyType.KEY_X]:SetShow(true)
    keyGuideGapSizeX = self._ui._stc_backGround:GetSizeX() + 10
  else
    local isRotatePossible = housing_isAvailableRotateSelectedObject()
    local installationType
    local characterStaticWrapper = housing_getCreatedCharacterStaticWrapper()
    if nil ~= characterStaticWrapper then
      local objectStaticWrapper = characterStaticWrapper:getObjectStaticStatus()
      if nil ~= objectStaticWrapper then
        installationType = objectStaticWrapper:getInstallationType()
      end
    end
    if self._eModeState.TRANSLATION == modeState then
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetText(self._keyGuideString.CHANGE_CAMMODE)
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetShow(true)
      if false == ToClient_isCameraControlModeForConsole() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS]:SetShow(true)
      else
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_LEFTRIGHT]:SetShow(true)
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetText(self._keyGuideString.ZOOM_INOUT)
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetShow(true)
      end
      if true == isRotatePossible then
        self._ui._keyGuideBgList[self._eKeyType.KEY_LB_RB]:SetShow(true)
        self._ui._keyGuideBgList[self._eKeyType.KEY_LT_RT]:SetShow(true)
      end
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetText(self._keyGuideString.BUILD)
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetShow(true)
      keySize = 44
    elseif self._eModeState.DETAIL == modeState then
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetText(self._keyGuideString.ZOOM_INOUTANDHEIGHT)
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetShow(true)
      if false == ToClient_isCameraControlModeForConsole() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS]:SetShow(true)
      else
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_LEFTRIGHT]:SetShow(true)
      end
      if CppEnums.InstallationType.eType_Curtain == installationType or CppEnums.InstallationType.eType_Curtain_Tied == installationType then
        self._ui._keyGuideBgList[self._eKeyType.KEY_LS]:SetText(self._keyGuideString.CHANGE_WIDTH)
        self._ui._keyGuideBgList[self._eKeyType.KEY_LS]:SetShow(true)
      end
      if (CppEnums.InstallationType.eType_Chandelier == installationType or CppEnums.InstallationType.eType_Curtain == installationType or CppEnums.InstallationType.eType_Curtain_Tied == installationType) and true == ToClient_isCameraControlModeForConsole() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetText(self._keyGuideString.CHANGE_HEIGHT)
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetShow(true)
      end
      if true == isRotatePossible then
        self._ui._keyGuideBgList[self._eKeyType.KEY_LB_RB]:SetShow(true)
        self._ui._keyGuideBgList[self._eKeyType.KEY_LT_RT]:SetShow(true)
      end
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetText(self._keyGuideString.BUILD)
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetShow(true)
    elseif self._eModeState.WATINGCONFIRM == modeState then
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetText(self._keyGuideString.CHANGE_CAMMODE)
      self._ui._keyGuideBgList[self._eKeyType.KEY_RS_CLICK]:SetShow(true)
      if false == ToClient_isCameraControlModeForConsole() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS]:SetShow(true)
      else
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_LEFTRIGHT]:SetShow(true)
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetText(self._keyGuideString.ZOOM_INOUT)
        self._ui._keyGuideBgList[self._eKeyType.KEY_RS_UPDOWN]:SetShow(true)
      end
      if true == isRotatePossible then
        self._ui._keyGuideBgList[self._eKeyType.KEY_LB_RB]:SetShow(true)
        self._ui._keyGuideBgList[self._eKeyType.KEY_LT_RT]:SetShow(true)
      end
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetText(self._keyGuideString.INSTALL)
      self._ui._keyGuideBgList[self._eKeyType.KEY_A]:SetShow(true)
      if true == PaGlobal_House_Installation_All_IsCanDelete() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_X]:SetShow(true)
      end
      if true == PaGlobal_House_Installation_All_IsCanMove() then
        self._ui._keyGuideBgList[self._eKeyType.KEY_Y]:SetShow(true)
      end
    end
  end
  local maxSizeX = 0
  for _, value in ipairs(self._ui._keyGuideBgList) do
    if nil ~= value and true == value:GetShow() then
      local sizeX = value:GetSizeX() + value:GetTextSizeX()
      if maxSizeX < sizeX then
        maxSizeX = sizeX
      end
    end
  end
  if maxSizeX <= 0 then
    self._ui._stc_consoleKeyBG:SetSpanSize(self._baseKeyGuideSpanGapX, self._ui._stc_consoleKeyBG:GetSpanSize().y)
  else
    self._ui._stc_consoleKeyBG:SetSpanSize(maxSizeX + keyGuideGapSizeX, self._ui._stc_consoleKeyBG:GetSpanSize().y)
  end
  self._ui._keyGuideBgList[self._eKeyType.KEY_B]:SetShow(true)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyGuideBgList, self._ui._stc_consoleKeyBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, keySize, 10)
end
