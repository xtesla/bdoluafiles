function PaGlobal_Equip_CharacterTag_ItemCopy:init()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy or true == self._initailize then
    UI.ASSERT_NAME("\235\133\184\235\140\128\236\152\129", false, "PaGlobal_Equip_CharacterTag_ItemCopy:init \236\139\164\237\140\168 Panel_Window_Equip_CharacterTag_ItemCopy \237\140\168\235\132\144\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164")
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_title = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "StaticText_Title")
  self._ui._stc_title = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close_PCUI")
  self._ui._txt_titleIcon = UI.getChildControl(self._ui._stc_title, "StaticText_TitleIcon")
  self._ui._btn_openDescBox = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "CheckButton_OpenDescBox")
  self._ui._stc_tapBg = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "Static_TapBG")
  self._ui._stc_tapLine = UI.getChildControl(self._ui._stc_tapBg, "Static_TapLine")
  self._ui._stc_selectLine = UI.getChildControl(self._ui._stc_tapLine, "Static_SelectLine")
  self._ui._btn_copyAllTap = UI.getChildControl(self._ui._stc_tapBg, "RadioButton_CopyAllTap")
  self._ui._btn_changeCopy = UI.getChildControl(self._ui._stc_tapBg, "RadioButton_ChangeCopy")
  self._ui._btn_exitCopy = UI.getChildControl(self._ui._stc_tapBg, "RadioButton_ExitCopy")
  self._ui._stc_itemCopyBg = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "Static_ItemCopyBG")
  self._ui._stc_costBox = UI.getChildControl(self._ui._stc_itemCopyBg, "Static_Cost_Box")
  self._ui._txt_itemCost = UI.getChildControl(self._ui._stc_costBox, "StaticText_Cost")
  self._ui._stc_needItemIcon = UI.getChildControl(self._ui._stc_costBox, "Static_Cost_Icon")
  self._ui._btn_copyConfirm = UI.getChildControl(self._ui._stc_itemCopyBg, "Button_Copy")
  self._ui._txt_toCharacterName = UI.getChildControl(self._ui._stc_itemCopyBg, "StaticText_Desc_ToCharacter")
  self._ui._stc_itemCopyDecoBG = UI.getChildControl(self._ui._stc_itemCopyBg, "Static_Deco_BG")
  self._ui._stc_itemCopyEffect = UI.getChildControl(self._ui._stc_itemCopyDecoBG, "Static_ItemCopyEffect")
  self._ui._stc_equipSlotGroup = UI.getChildControl(self._ui._stc_itemCopyBg, "Static_Group_Equip")
  self._ui._stc_mainCirce = UI.getChildControl(self._ui._stc_equipSlotGroup, "Static_MainCircle")
  self._ui._txt_notice = UI.getChildControl(self._ui._stc_equipSlotGroup, "StaticText_Notice_1")
  self._ui._txt_slotEnchantValue = UI.getChildControl(self._ui._stc_equipSlotGroup, "Static_Text_Slot_Enchant_value")
  self._ui._stc_addCopyBg = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "Static_ChangeCopyBG")
  self._ui._btn_addConfirm = UI.getChildControl(self._ui._stc_addCopyBg, "Button_Change")
  self._ui._stc_addCostBox = UI.getChildControl(self._ui._stc_addCopyBg, "Static_ChangeCost_Box")
  self._ui._stc_addCostIcon = UI.getChildControl(self._ui._stc_addCostBox, "Static_ChangeCost")
  self._ui._txt_addCost = UI.getChildControl(self._ui._stc_addCostBox, "StaticText_ChangeCost_Icon")
  self._ui._stc_addCostIcon2 = UI.getChildControl(self._ui._stc_addCostBox, "Static_ChangeCost02")
  self._ui._txt_addCost2 = UI.getChildControl(self._ui._stc_addCostBox, "StaticText_ChangeCost_Icon02")
  self._ui._txt_addToCharacter = UI.getChildControl(self._ui._stc_addCopyBg, "MultilineText_Desc_ChangeToCharacter")
  self._ui._stc_addItemBg = UI.getChildControl(self._ui._stc_addCopyBg, "Static_AddItemBG")
  self._ui._txt_addItemName = UI.getChildControl(self._ui._stc_addCopyBg, "StaticText_Add_ItemName")
  self._ui._stc_addItemEffect = UI.getChildControl(self._ui._stc_addItemBg, "Static_AddItem_Effect")
  self._ui._stc_exitCopyBg = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "Static_ExitCopyBG")
  self._ui._btn_exitConfirm = UI.getChildControl(self._ui._stc_exitCopyBg, "Button_Exit")
  self._ui._txt_exitToCharacter = UI.getChildControl(self._ui._stc_exitCopyBg, "StaticText_Desc_ExitToCharacter")
  self._ui._stc_exitItemBg = UI.getChildControl(self._ui._stc_exitCopyBg, "Static_ItemExitBG")
  self._ui._txt_exitItemName = UI.getChildControl(self._ui._stc_exitCopyBg, "StaticText_Delete_ItemName")
  self._ui._stc_exitItemEffect = UI.getChildControl(self._ui._stc_exitCopyBg, "Static_DeleteItem_Effect")
  self._ui._stc_keyguideBg = UI.getChildControl(Panel_Window_Equip_CharacterTag_ItemCopy, "Static_Key_GuideGroup_ConsoleUI")
  self._ui._txt_keyguideX = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_X_ConsoleUI")
  self._ui._txt_keyguideB = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_B_ConsoleUI")
  self._ui._txt_keyguideA = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_Select")
  self._ui._txt_keyguideY = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_Y_ConsoleUI")
  self._ui._txt_keyguideLTX = UI.getChildControl(self._ui._stc_keyguideBg, "StaticText_LT_X")
  self._ui._txt_keyguideLB = UI.getChildControl(self._ui._stc_tapBg, "StaticText_LB_ConsoleUI")
  self._ui._txt_keyguideRB = UI.getChildControl(self._ui._stc_tapBg, "StaticText_RB_ConsoleUI")
  PaGlobal_Equip_CharacterTag_ItemCopy:validate()
  PaGlobal_Equip_CharacterTag_ItemCopy:registerEventHandler()
  PaGlobal_Equip_CharacterTag_ItemCopy:setControlInit()
  self._initailize = true
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setControlInit()
  for slotNo = self._EquipNoMin, self._EquipNoMax - 1 do
    if true == PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(slotNo) then
      local slotName = self._slotNoId[slotNo]
      if nil ~= slotName then
        local slotBG = UI.getChildControl(self._ui._stc_mainCirce, slotName .. "_BG")
        if nil ~= slotBG then
          self._equipSlotBG[slotNo] = slotBG
        end
        local slot = {}
        slot.icon = UI.getChildControl(self._ui._stc_mainCirce, slotName)
        if nil ~= slot.icon then
          SlotItem.new(slot, "Tag_Equipment_" .. slotNo, slotNo, self._equipBG, self._equipSlotConfig)
          slot:createChild()
          Panel_Tooltip_Item_SetPosition(slotNo, slot, "CharacterTag_ItemCopy")
          self._equipSlot[slotNo] = slot
        end
      end
    end
  end
  if true == _ContentsGroup_DuelCharacterCopyChangeEquip then
    self._changeCopySlot = {}
    self._changeCopySlot.icon = UI.getChildControl(self._ui._stc_addItemBg, "Static_AddItem_Icon")
    if nil ~= self._changeCopySlot.icon then
      SlotItem.new(self._changeCopySlot, "Tag_Equipment_ChangeCopy", 0, self._equipBG, self._equipSlotConfig)
      self._changeCopySlot:createChild()
      Panel_Tooltip_Item_SetPosition(0, self._changeCopySlot, "CharacterTag_ItemChangeCopy")
      if true == _ContentsGroup_UsePadSnapping then
        self._changeCopySlot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopySlotItem(nil,nil)")
      else
        self._changeCopySlot.icon:addInputEvent("Mouse_RUp", "PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopySlotItem(nil,nil)")
      end
    end
    self._releaseCopySlot = {}
    self._releaseCopySlot.icon = UI.getChildControl(self._ui._stc_exitItemBg, "Static_ExitItem_Icon")
    if nil ~= self._releaseCopySlot.icon then
      SlotItem.new(self._releaseCopySlot, "Tag_Equipment_ReleaseCopy", 0, self._equipBG, self._equipSlotConfig)
      self._releaseCopySlot:createChild()
      Panel_Tooltip_Item_SetPosition(0, self._releaseCopySlot, "CharacterTag_ItemReleaseCopy")
      if true == _ContentsGroup_UsePadSnapping then
        self._releaseCopySlot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Equip_CharacterTag_ItemCopy:setReleaseCopySlotItem(nil,nil)")
      else
        self._releaseCopySlot.icon:addInputEvent("Mouse_RUp", "PaGlobal_Equip_CharacterTag_ItemCopy:setReleaseCopySlotItem(nil,nil)")
      end
    end
    self._ui._txt_addCost:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_addCost2:SetTextMode(__eTextMode_AutoWrap)
    self._baseAddCopyNeedItemIconSpanSizeY = self._ui._stc_addCostIcon:GetSpanSize().y
  else
    self._ui._stc_itemCopyBg:SetShow(true)
    self._ui._stc_addCopyBg:SetShow(false)
    self._ui._stc_exitCopyBg:SetShow(false)
    self._ui._btn_copyAllTap:SetShow(true)
    self._ui._btn_changeCopy:SetShow(false)
    self._ui._btn_exitCopy:SetShow(false)
    local linePosX = self._ui._btn_changeCopy:GetPosX()
    self._ui._btn_copyAllTap:SetPosX(linePosX)
    self._ui._stc_selectLine:SetPosX(linePosX)
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._selfClassType = selfPlayer:getClassType()
  end
  self._awakenWeaponContentsOpen = self._awakenWeapon[self._selfClassType]
  self._ui._btn_openDescBox:ChangeTextureInfoNameDefault("combine/icon/combine_basic_icon_00.dds")
  self._ui._txt_itemCost:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_keyguideLB:SetShow(self._isConsole)
  self._ui._txt_keyguideRB:SetShow(self._isConsole)
  self._ui._stc_keyguideBg:SetShow(self._isConsole)
  self._ui._btn_copyConfirm:SetShow(not self._isConsole)
  self._ui._btn_addConfirm:SetShow(not self._isConsole)
  self._ui._btn_exitConfirm:SetShow(not self._isConsole)
  self._ui._btn_close:SetShow(not ToClient_isConsole())
  self._ui._txt_keyguideX:SetShow(false)
  self:setKeyGuideAlign()
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setKeyGuideAlign()
  if false == self._isConsole then
    return
  end
  local keyGuideList = {
    self._ui._txt_keyguideY,
    self._ui._txt_keyguideA,
    self._ui._txt_keyguideX,
    self._ui._txt_keyguideLTX,
    self._ui._txt_keyguideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:registerEventHandler()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  registerEvent("onScreenResize", "FromClient_PaGlobal_Equip_CharacterTag_OnScreenSize")
  registerEvent("FromClient_CopyItemSuccess", "FromClient_PaGlobal_Equip_ChacterTag_CopyItemSuccess")
  registerEvent("FromClient_CopyItemOnlyOneSuccess", "FromClient_PaGlobal_Equip_ChacterTag_CopyItemOnlyOneSuccess")
  registerEvent("FromClient_PrePareAddCopyItemOnlyOne", "FromClient_PaGlobal_Equip_CharacterTag_SelectAddCopyItem")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Equip_CharacterTag_ItemCopy_Close(true,true)")
  self._ui._btn_openDescBox:addInputEvent("Mouse_LUp", "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_OpenDesc()")
  self._ui._btn_copyConfirm:addInputEvent("Mouse_LUp", "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_Confirm()")
  if true == _ContentsGroup_DuelCharacterCopyChangeEquip then
    self._ui._btn_copyAllTap:addInputEvent("Mouse_LUp", "ToClient_PrePareCopyMyEquipItems()")
    self._ui._btn_changeCopy:addInputEvent("Mouse_LUp", "PaGlobal_Equip_CharacterTag_ItemCopy:changeTap(" .. self.eTabIndex.ADD_COPY .. ")")
    self._ui._btn_exitCopy:addInputEvent("Mouse_LUp", "PaGlobal_Equip_CharacterTag_ItemCopy:changeTap(" .. self.eTabIndex.RELEASE_COPY .. ")")
    self._ui._btn_addConfirm:addInputEvent("Mouse_LUp", "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ChangeCopyConfirm()")
    self._ui._btn_exitConfirm:addInputEvent("Mouse_LUp", "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ReleaseCopyConfirm()")
  end
  if true == self._isConsole then
    Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_OpenDesc()")
    Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_Confirm()")
    if true == _ContentsGroup_DuelCharacterCopyChangeEquip then
      Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_MoveTap(false)")
      Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_MoveTap(true)")
    end
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:clear()
  self._currentTap = self.eTabIndex.ALL_COPY
  self._copyEffectType = self.eTabIndex.ALL_COPY
  self._selectSlotNo = __eTInventorySlotNoUndefined
  self._addCopyNeedItemSlotNo = __eTInventorySlotNoUndefined
  self._addCopyNeedItemCount = toInt64(0, 0)
  self._checkFirstNeedItem = true
  self._addCopyNeedItemSlotNo2 = __eTInventorySlotNoUndefined
  self._addCopyNeedItemCount2 = toInt64(0, 0)
  self._isEffectStart = false
  self._curEffectTime = 0
  self._ui._stc_itemCopyEffect:EraseAllEffect()
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if true == self:checkUsableSlot(slotNo) then
      local slot = self._equipSlot[slotNo]
      if nil ~= slot and nil ~= slot.icon then
        slot.icon:EraseAllEffect()
      end
    end
  end
  self._ui._stc_addItemEffect:EraseAllEffect()
  self._ui._stc_exitItemEffect:EraseAllEffect()
  if nil ~= Panel_Window_Equip_CharacterTag_ItemCopy then
    Panel_Window_Equip_CharacterTag_ItemCopy:ClearUpdateLuaFunc()
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:prepareOpen()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  if false == _ContentsGroup_DuelCharacterCopyEquip then
    return
  end
  if false == self:checkClearedQuest() then
    return
  end
  self:clear()
  if true == self._lastShowDescState and nil ~= PaGlobal_DescBox_ItemCopy_Open then
    PaGlobal_DescBox_ItemCopy_Open()
  end
  self:duelCharacterNameSet()
  self:setDescIcon(self._lastShowDescState)
  self._hasCopyOriginItem = ToClient_hasCopyOriginItem()
  self:changeTap(self.eTabIndex.ALL_COPY)
  self:open()
end
function PaGlobal_Equip_CharacterTag_ItemCopy:open()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  Panel_Window_Equip_CharacterTag_ItemCopy:SetShow(true)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:prepareClose()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  self:clear()
  self:close()
end
function PaGlobal_Equip_CharacterTag_ItemCopy:close()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    return
  end
  Panel_Window_Equip_CharacterTag_ItemCopy:SetShow(false)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setInventoryOpen(isShow)
  if true == isShow then
    if false == _ContentsGroup_RenewUI_Inventory then
      if nil ~= PaGlobalFunc_Inventory_All_OpenWithItemCopy then
        PaGlobalFunc_Inventory_All_OpenWithItemCopy()
      end
    elseif nil ~= InventoryWindow_Show then
      InventoryWindow_Show()
    end
    if true == _ContentsGroup_NewUI_Inventory_All then
      if nil ~= PaGlobalFunc_Inventory_All_SetInventoryDragNoUse then
        PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Equip_CharacterTag_ItemCopy)
      end
    elseif nil ~= FGlobal_SetInventoryDragNoUse then
      FGlobal_SetInventoryDragNoUse(Panel_Window_Equip_CharacterTag_ItemCopy)
    end
    if nil ~= Panel_Window_Equip_CharacterTag_ItemCopy and nil ~= Panel_Window_Equipment_All and true == Panel_Window_Equipment_All:GetShow() then
      local equipmentPanelPosX = Panel_Window_Equipment_All:GetPosX()
      local equipmentPanelPosY = Panel_Window_Equipment_All:GetPosY()
      local gabX = 5
      Panel_Window_Equip_CharacterTag_ItemCopy:SetPosX(equipmentPanelPosX - Panel_Window_Equip_CharacterTag_ItemCopy:GetSizeX() - gabX)
      Panel_Window_Equip_CharacterTag_ItemCopy:SetPosY(equipmentPanelPosY)
    end
  elseif false == _ContentsGroup_RenewUI_Inventory then
    if nil ~= PaGlobalFunc_Inventory_All_CloseWithItemCopy then
      PaGlobalFunc_Inventory_All_CloseWithItemCopy()
    end
  elseif nil ~= InventoryWindow_Close then
    InventoryWindow_Close()
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:changeTap(index)
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    self:setEquipment()
    return
  end
  if index < 0 or index >= self.eTabIndex.TAP_COUNT then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() and nil ~= PaGlobalFunc_TooltipInfo_Close then
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if true == self._isEffectStart then
    self._ui._btn_copyAllTap:SetCheck(true == self._ui._stc_itemCopyBg:GetShow())
    self._ui._btn_changeCopy:SetCheck(true == self._ui._stc_addCopyBg:GetShow())
    self._ui._btn_exitCopy:SetCheck(true == self._ui._stc_exitCopyBg:GetShow())
    return
  end
  local isCheckAllCopy = self.eTabIndex.ALL_COPY == index
  local isChangeCopy = self.eTabIndex.ADD_COPY == index
  local isReleaseCopy = self.eTabIndex.RELEASE_COPY == index
  local linePosX = 0
  local descText
  PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY"))
  if true == isCheckAllCopy then
    self._currentTap = index
    self:setInventoryOpen(false)
    linePosX = self._ui._btn_copyAllTap:GetPosX()
    descText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY_DESC")
    self:setEquipment()
    Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_Confirm()")
  else
    if false == self._hasCopyOriginItem then
      self._ui._btn_copyAllTap:SetCheck(true)
      self._ui._btn_changeCopy:SetCheck(false)
      self._ui._btn_exitCopy:SetCheck(false)
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_ITEMCOPY_CANNOT_USE"),
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
    self._currentTap = index
    if true == isChangeCopy then
      linePosX = self._ui._btn_changeCopy:GetPosX()
      descText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY_DESC_ADD")
      self:setAddCopySlotItem(nil, nil)
      Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ChangeCopyConfirm()")
    elseif true == isReleaseCopy then
      linePosX = self._ui._btn_exitCopy:GetPosX()
      descText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY_DESC_DELETE")
      self:setReleaseCopySlotItem(nil, nil)
      Panel_Window_Equip_CharacterTag_ItemCopy:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleLUp_PaGlobal_Equip_CharacterTag_ItemCopy_ReleaseCopyConfirm()")
      PaGlobal_Equip_CharacterTag_ItemCopy._ui._txt_keyguideY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMCOPY_TAP03"))
    end
  end
  if nil ~= descText and nil ~= PaGlobal_DescBox_ItemCopy_SetDescText then
    PaGlobal_DescBox_ItemCopy_SetDescText(descText)
    if nil ~= PaGlobal_DescBox_ItemCopy_SetPanelPosition then
      PaGlobal_DescBox_ItemCopy_SetPanelPosition(Panel_Window_Equip_CharacterTag_ItemCopy:GetPosX(), Panel_Window_Equip_CharacterTag_ItemCopy:GetPosY())
    end
  end
  self._ui._stc_selectLine:SetPosX(linePosX)
  self._ui._stc_itemCopyBg:SetShow(isCheckAllCopy)
  self._ui._btn_copyAllTap:SetCheck(isCheckAllCopy)
  self._ui._stc_addCopyBg:SetShow(isChangeCopy)
  self._ui._btn_changeCopy:SetCheck(isChangeCopy)
  self._ui._stc_exitCopyBg:SetShow(isReleaseCopy)
  self._ui._btn_exitCopy:SetCheck(isReleaseCopy)
  self:setKeyGuideAlign()
end
function PaGlobal_Equip_CharacterTag_ItemCopy:checkClearedQuest()
  local isCleared = ToClient_isClearedDuelCharacterItemCopyQuest()
  if true == isCleared then
    return true
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_COPY_MSGFAIL_QUEST")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return false
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:duelCharacterNameSet()
  local duelCharIndex = ToClient_GetMyDuelCharacterIndex()
  self._toCharacterName = ""
  if self.LOCAL_DEFINE.NODUEL ~= duelCharIndex then
    local characterData = getCharacterDataByIndex(duelCharIndex)
    if nil == characterData then
      return
    end
    local duelCharacterName = getCharacterName(characterData)
    if nil ~= duelCharacterName then
      local toCharacterNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_DESC_TOCHARACTER", "name", duelCharacterName)
      self._ui._txt_toCharacterName:SetText(toCharacterNameString)
      self._toCharacterName = duelCharacterName
    end
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(index)
  if true == _ContentsGroup_DuelCharacterCopyChangeEquip then
    if (index == CppEnums.EquipSlotNo.rightHand or index == CppEnums.EquipSlotNo.leftHand or index == CppEnums.EquipSlotNo.subTool or index == CppEnums.EquipSlotNo.chest or index == CppEnums.EquipSlotNo.glove or index == CppEnums.EquipSlotNo.boots or index == CppEnums.EquipSlotNo.helm or index == CppEnums.EquipSlotNo.necklace or index == CppEnums.EquipSlotNo.ring1 or index == CppEnums.EquipSlotNo.ring2 or index == CppEnums.EquipSlotNo.earing1 or index == CppEnums.EquipSlotNo.earing2 or index == CppEnums.EquipSlotNo.belt or index == CppEnums.EquipSlotNo.alchemyStone or index == CppEnums.EquipSlotNo.awakenWeapon) and index ~= self._UnUsedEquipNo_01 and index ~= self._UnUsedEquipNo_02 then
      return true
    end
    return false
  else
    if index == self._UnUsedEquipNo_01 or index == self._UnUsedEquipNo_02 or index == CppEnums.EquipSlotNo.equipSlotNoCount or index == CppEnums.EquipSlotNo.explorationBonus0 or index == CppEnums.EquipSlotNo.installation4 or index == CppEnums.EquipSlotNo.body or index == CppEnums.EquipSlotNo.avatarBody then
      return false
    end
    return true
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setEquipment()
  self._needItemCount = 0
  self._needItemSlotNo = __eTInventorySlotNoUndefined
  self._extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local allCanCopyAble = true
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if true == PaGlobal_Equip_CharacterTag_ItemCopy:checkUsableSlot(slotNo) then
      local itemWrapper = ToClient_getEquipmentItem(slotNo)
      local slot = self._equipSlot[slotNo]
      local slotBG = self._equipSlotBG[slotNo]
      if nil ~= slot and nil ~= slotBG then
        self:setEquipSlotBGIcon(slotNo)
        if nil ~= itemWrapper then
          local itemSSW = itemWrapper:getStaticStatus()
          local slotNoMax = itemSSW:getExtendedSlotCount()
          for i = 1, slotNoMax do
            local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
            if slotNoMax ~= extendSlotNo then
              self._extendedSlotInfoArray[extendSlotNo] = slotNo
              checkExtendedSlot = true
            end
          end
          local canCopyAble = true
          if true == itemWrapper:canCopyItemForDuel() and true == itemWrapper:isMaxEndurance() then
            canCopyAble = false
          else
            allCanCopyAble = false
          end
          PaGlobal_Equip_CharacterTag_ItemCopy:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo, canCopyAble)
          slotBG:SetShow(false)
          slot.icon:SetEnable(true)
          slot.icon:SetShow(true)
          if true == ToClient_isConsole() then
            slot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip(false, " .. slotNo .. ")")
          else
            slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(true, false, " .. slotNo .. ")")
          end
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(false)")
        else
          slot:clearItem()
          slot.icon:SetEnable(true)
          slotBG:SetShow(true)
          if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
            slotBG:SetShow(self._awakenWeaponContentsOpen)
            slot.icon:SetEnable(self._awakenWeaponContentsOpen)
            slot.icon:SetShow(self._awakenWeaponContentsOpen)
          elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
            local isShow = self._awakenWeaponContentsOpen
            if nil ~= self._selfClassType then
              if __eClassType_ShyWaman == self._selfClassType then
                isShow = false
              end
              slotBG:SetShow(isShow)
              slot.icon:SetEnable(isShow)
              slot.icon:SetShow(isShow)
            end
          end
          if CppEnums.EquipSlotNo.lantern == slotNo then
            slot.icon:SetShow(false)
            slotBG:SetShow(false)
          end
          if true == ToClient_isConsole() then
            slot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip()")
          end
        end
      end
    end
  end
  if true == checkExtendedSlot then
    for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = ToClient_getEquipmentItem(parentSlotNo)
      local slot = self._equipSlot[extendSlotNo]
      local slotBG = self._equipSlotBG[extendSlotNo]
      if nil ~= slot and nil ~= slotBG then
        slotBG:SetShow(false)
        if nil ~= itemWrapper then
          local canCopyAble = true
          if true == itemWrapper:canCopyItemForDuel() and true == itemWrapper:isMaxEndurance() then
            canCopyAble = false
          end
          PaGlobal_Equip_CharacterTag_ItemCopy:setItemInfoUseWrapper(slot, itemWrapper, true, true, canCopyAble)
        end
      end
    end
  end
  local needItemEnchantKey = ToClient_getNeedItemForDuelCopy()
  if nil == needItemEnchantKey then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(needItemEnchantKey)
  if nil == itemEnchantSSW then
    return
  end
  local needItemIconPath = itemEnchantSSW:getIconPath()
  if nil == needItemIconPath then
    return
  end
  self._ui._stc_needItemIcon:ChangeTextureInfoName("icon/" .. needItemIconPath)
  local needItemName = itemEnchantSSW:getName()
  if nil == needItemName then
    return
  end
  local hasItemCount = ToClient_InventoryGetItemCount(needItemEnchantKey)
  local needItemCount = ToClient_getCopyItemForDuelNeedItemCount()
  if hasItemCount < needItemCount then
    self._ui._txt_itemCost:SetFontColor(Defines.Color.C_FFFF0000)
    self._ui._btn_copyConfirm:SetMonoTone(true)
    self._ui._btn_copyConfirm:SetIgnore(true)
    self._ui._txt_keyguideY:SetMonoTone(true)
  else
    self._ui._txt_itemCost:SetFontColor(Defines.Color.C_FFF5BA3A)
    self._ui._btn_copyConfirm:SetMonoTone(false)
    self._ui._btn_copyConfirm:SetIgnore(false)
    self._ui._txt_keyguideY:SetMonoTone(false)
    if true == allCanCopyAble then
      self._ui._btn_copyConfirm:SetMonoTone(false)
      self._ui._btn_copyConfirm:SetIgnore(false)
      self._ui._txt_keyguideY:SetMonoTone(false)
    else
      self._ui._btn_copyConfirm:SetMonoTone(true)
      self._ui._btn_copyConfirm:SetIgnore(true)
      self._ui._txt_keyguideY:SetMonoTone(true)
    end
  end
  self._needItemSlotNo = ToClient_InventoryGetSlotNo(needItemEnchantKey)
  self._needItemCount = needItemCount
  local costString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_DESC_NEEDITEM", "item", tostring(needItemName), "count", tostring(needItemCount), "recent", tostring(hasItemCount))
  if costString ~= nil then
    self._ui._txt_itemCost:SetText(costString)
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopySlotItem(whereType, slotNo)
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if self.eTabIndex.ADD_COPY ~= self._currentTap then
    return
  end
  if nil == self._changeCopySlot then
    return
  end
  if true == self._isEffectStart then
    return
  end
  self._changeCopySlot.icon:addInputEvent("Mouse_On", "")
  self._changeCopySlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(false)")
  self._ui._txt_addItemName:SetFontColor(Defines.Color.C_FF6C6C6C)
  self._ui._txt_addItemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY_NO_SELECTED"))
  self._ui._btn_addConfirm:SetMonoTone(true)
  self._ui._btn_addConfirm:SetIgnore(true)
  self._ui._txt_keyguideY:SetMonoTone(true)
  self._ui._stc_addCostIcon:SetShow(false)
  self._ui._txt_addCost:SetShow(false)
  self._checkFirstNeedItem = true
  local baseBoxSizeY = self._ui._stc_addCostIcon:GetSizeY() + self._baseAddCopyNeedItemIconSpanSizeY * 2
  self._ui._stc_addCostBox:SetSize(self._ui._stc_addCostBox:GetSizeX(), baseBoxSizeY)
  self._ui._stc_addCostBox:ComputePosAllChild()
  self._addCopyNeedItemSlotNo = __eTInventorySlotNoUndefined
  self._addCopyNeedItemCount = toInt64(0, 0)
  self._addCopyNeedItemSlotNo2 = __eTInventorySlotNoUndefined
  self._addCopyNeedItemCount2 = toInt64(0, 0)
  self._selectSlotNo = __eTInventorySlotNoUndefined
  self._changeCopySlot:clearItem(true)
  if nil == whereType or nil == slotNo then
    if true == ToClient_isConsole() then
      HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip()
    end
    self:setAddCopyItemSecond(true)
    self:setInventoryOpen(true)
    Inventory_SetFunctor(PaGlobalFunc_Equip_CharacterTag_ItemCopy_FilterForAddCopy, PaGlobal_Equip_CharacterTag_ItemCopy_RClickAddCopyItem, nil, nil)
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  if false == itemWrapper:canCopyItemForDuel() then
    return
  end
  if false == itemWrapper:isMaxEndurance() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoAuctionEndurance"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if false == self:checkUsableSlot(equipSlotNo) then
    return
  end
  local limitOptionOriginal = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == limitOptionOriginal then
    return
  end
  local limitOption = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == limitOption then
    return
  end
  self._selectInventoryType = whereType
  self._selectSlotNo = slotNo
  PaGlobal_Equip_CharacterTag_ItemCopy:setItemInfoUseWrapper(self._changeCopySlot, itemWrapper, false, false, 0, false)
  if true == ToClient_isConsole() then
    self._changeCopySlot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip(true, " .. slotNo .. ")")
  else
    self._changeCopySlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(true, true, " .. slotNo .. ")")
  end
  local itemName = itemEnchantWrapper:getName()
  if nil ~= itemName then
    self._ui._txt_addItemName:SetFontColor(Defines.Color.C_FFD8AD70)
    self._ui._txt_addItemName:SetText(itemName)
  end
  self:setAddCopyItemFirst()
  self:setAddCopyItemSecond(false)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopyItemFirst()
  local needItemEnchantKey = ToClient_getNeedItemForDuelCopy()
  if nil == needItemEnchantKey then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(needItemEnchantKey)
  if nil == itemEnchantSSW then
    return
  end
  local needItemIconPath = itemEnchantSSW:getIconPath()
  if nil ~= needItemIconPath then
    self._ui._stc_addCostIcon:ChangeTextureInfoName("icon/" .. needItemIconPath)
  end
  local hasItemCount = ToClient_InventoryGetItemCount(needItemEnchantKey)
  local needItemCount = ToClient_getAddCopyItemForDuelNeedItemCount()
  if hasItemCount < needItemCount then
    self._checkFirstNeedItem = false
    self._ui._txt_addCost:SetFontColor(Defines.Color.C_FFFF0000)
  else
    self._checkFirstNeedItem = true
    self._ui._txt_addCost:SetFontColor(Defines.Color.C_FFF5BA3A)
  end
  local needItemName = itemEnchantSSW:getName()
  if nil == needItemName then
    needItemName = ""
  end
  local costString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_DESC_NEEDITEM", "item", tostring(needItemName), "count", tostring(needItemCount), "recent", tostring(hasItemCount))
  if costString ~= nil then
    self._ui._txt_addCost:SetText(costString)
  end
  if needItemCount > toInt64(0, 0) then
    self._ui._stc_addCostIcon:SetShow(true)
    self._ui._txt_addCost:SetShow(true)
  end
  self._addCopyNeedItemCount = needItemCount
  self._addCopyNeedItemSlotNo = ToClient_InventoryGetSlotNo(needItemEnchantKey)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setAddCopyItemSecond(isClear)
  local needItemEnchantKey = ToClient_getNeedItemForIndividuelCopy()
  if nil == needItemEnchantKey then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(needItemEnchantKey)
  if nil == itemEnchantSSW then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local inventory = selfPlayer:getInventory(CppEnums.ItemWhereType.eCashInventory)
  if nil == inventory then
    return
  end
  local needItemEnchantKeyValue = needItemEnchantKey:get()
  local hasItemCount = toInt64(0, 0)
  local invenMaxSize = inventory:sizeXXX()
  local slotNo = __eTInventorySlotNoUndefined
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, ii)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item and item:getKey():get() == needItemEnchantKeyValue then
        slotNo = ii
        hasItemCount = item:getCount_s64()
        break
      end
    end
  end
  local needItemCount = toInt64(0, 1)
  if hasItemCount < needItemCount then
    self._ui._txt_addCost2:SetFontColor(Defines.Color.C_FFFF0000)
    self._ui._btn_addConfirm:SetMonoTone(true)
    self._ui._btn_addConfirm:SetIgnore(true)
    self._ui._txt_keyguideY:SetMonoTone(true)
  else
    self._ui._txt_addCost2:SetFontColor(Defines.Color.C_FFF5BA3A)
    if false == isClear and true == self._checkFirstNeedItem then
      self._ui._btn_addConfirm:SetMonoTone(false)
      self._ui._btn_addConfirm:SetIgnore(false)
      self._ui._txt_keyguideY:SetMonoTone(false)
    end
  end
  local needItemIconPath = itemEnchantSSW:getIconPath()
  if nil ~= needItemIconPath then
    self._ui._stc_addCostIcon2:ChangeTextureInfoName("icon/" .. needItemIconPath)
  end
  local needItemName = itemEnchantSSW:getName()
  if nil == needItemName then
    needItemName = ""
  end
  local costString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_WINDOW_ITEMCOPY_DESC_NEEDITEM", "item", tostring(needItemName), "count", tostring(needItemCount), "recent", tostring(hasItemCount))
  if costString ~= nil then
    self._ui._txt_addCost2:SetText(costString)
  end
  if needItemCount > toInt64(0, 0) and toInt64(0, 0) < self._addCopyNeedItemCount then
    local baseBoxSizeY = self._ui._stc_addCostIcon:GetSizeY() + self._ui._stc_addCostIcon2:GetSizeY() + self._baseAddCopyNeedItemIconSpanSizeY * 2.5
    self._ui._stc_addCostBox:SetSize(self._ui._stc_addCostBox:GetSizeX(), baseBoxSizeY)
    self._ui._stc_addCostBox:ComputePosAllChild()
  end
  if false == isClear then
    self._addCopyNeedItemCount2 = needItemCount
    self._addCopyNeedItemSlotNo2 = slotNo
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setReleaseCopySlotItem(whereType, slotNo)
  if false == _ContentsGroup_DuelCharacterCopyChangeEquip then
    return
  end
  if self.eTabIndex.RELEASE_COPY ~= self._currentTap then
    return
  end
  if nil == self._releaseCopySlot then
    return
  end
  if true == self._isEffectStart then
    return
  end
  self._releaseCopySlot.icon:addInputEvent("Mouse_On", "")
  self._releaseCopySlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(false)")
  self._ui._txt_exitItemName:SetFontColor(Defines.Color.C_FF6C6C6C)
  self._ui._txt_exitItemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERTAG_ITEMCOPY_NO_SELECTED"))
  self._ui._btn_exitConfirm:SetMonoTone(true)
  self._ui._btn_exitConfirm:SetIgnore(true)
  self._ui._txt_keyguideY:SetMonoTone(true)
  self._selectSlotNo = __eTInventorySlotNoUndefined
  self._releaseCopySlot:clearItem(true)
  if nil == whereType or nil == slotNo then
    if true == ToClient_isConsole() then
      HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip()
    end
    self:setInventoryOpen(true)
    Inventory_SetFunctor(PaGlobalFunc_Equip_CharacterTag_ItemCopy_FilterForReleaseCopy, PaGlobal_Equip_CharacterTag_ItemCopy_RClickReleaseCopyItem, nil, nil)
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantWrapper = itemWrapper:getStaticStatus()
  if nil == itemEnchantWrapper then
    return
  end
  local equipSlotNo = itemEnchantWrapper:getEquipSlotNo()
  if false == self:checkUsableSlot(equipSlotNo) then
    return
  end
  local isOriginalItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if false == isOriginalItem then
    return
  end
  self._selectSlotNo = slotNo
  PaGlobal_Equip_CharacterTag_ItemCopy:setItemInfoUseWrapper(self._releaseCopySlot, itemWrapper, false, false, 0, false)
  if true == ToClient_isConsole() then
    self._releaseCopySlot.icon:addInputEvent("Mouse_On", "HandleEventPadPress_PaGlobal_Equip_CharacterTag_ItemCopy_ShowTooltip(true, " .. slotNo .. ")")
  else
    self._releaseCopySlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_Equip_CharacterTag_ItemCopy_InventoryTooltip(true, true, " .. slotNo .. ")")
  end
  local itemName = itemEnchantWrapper:getName()
  if nil ~= itemName then
    self._ui._txt_exitItemName:SetFontColor(Defines.Color.C_FFD8AD70)
    self._ui._txt_exitItemName:SetText(itemName)
  end
  self._ui._btn_exitConfirm:SetMonoTone(false)
  self._ui._btn_exitConfirm:SetIgnore(false)
  self._ui._txt_keyguideY:SetMonoTone(false)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setEquipSlotBGIcon(slotNo)
  if nil == slotNo or nil == self._selfClassType then
    return
  end
  if slotNo < self._EquipNoMin or slotNo >= self._EquipNoMax then
    return
  end
  local slotBG = self._equipSlotBG[slotNo]
  local slot = self._equipSlot[slotNo]
  if nil == slotBG or nil == slot then
    return
  end
  if __eClassType_ShyWaman == self._selfClassType then
    if CppEnums.EquipSlotNo.awakenWeapon == slotNo then
      slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 283, 48, 329, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
      slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 330, 48, 376, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    end
  elseif CppEnums.EquipSlotNo.awakenWeapon == slotNo then
    slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 1, 141, 47)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == slotNo then
    slotBG:ChangeTextureInfoName("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 95, 141, 141)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  end
  local underwearSlotNo = CppEnums.EquipSlotNo.avatarUnderWear
  local underwearSlotBG = self._equipSlotBG[underwearSlotNo]
  local underwearSlot = self._equipSlot[underwearSlotNo]
  if nil == underwearSlotBG or nil == underwearSlot then
    return
  end
  local spanY = underwearSlotBG:GetSpanSize().y
  if __eClassType_ShyWaman == classType or false == PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) then
    underwearSlotBG:SetSpanSize(self._changeUnderWearSpanX, spanY)
    underwearSlot.icon:SetSpanSize(self._changeUnderWearSpanX, spanY)
  else
    underwearSlotBG:SetSpanSize(self._originUnderWearSpanX, spanY)
    underwearSlot.icon:SetSpanSize(self._originUnderWearSpanX, spanY)
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo, canCopyAble)
  slot:setItem(itemWrapper, slotNo, true)
  if false == isExtended then
    slot.icon:SetEnable(true)
  else
    slot.icon:SetEnable(false)
  end
  if true == isMono then
    slot.icon:SetMonoTone(true)
  elseif false == isMono then
    slot.icon:SetMonoTone(false)
  end
  if false == canCopyAble then
    slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
  else
    slot.icon:SetColor(Defines.Color.C_FFD20000)
  end
end
function PaGlobal_Equip_CharacterTag_ItemCopy:setDescIcon(isOn)
  if true == self._isConsole then
    return
  end
  if nil == isOn then
    return
  end
  self._ui._btn_openDescBox:ChangeTextureInfoNameDefault("combine/icon/combine_basic_icon_00.dds")
  if false == isOn then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_openDescBox, 89, 434, 117, 462)
    self._ui._btn_openDescBox:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(self._ui._btn_openDescBox, 118, 434, 146, 462)
    self._ui._btn_openDescBox:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(self._ui._btn_openDescBox, 147, 434, 175, 462)
    self._ui._btn_openDescBox:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    self._ui._btn_openDescBox:setRenderTexture(self._ui._btn_openDescBox:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_openDescBox, 117, 434, 89, 462)
    self._ui._btn_openDescBox:getBaseTexture():setUV(x1, y1, x2, y2)
    local onX1, onY1, onX2, onY2 = setTextureUV_Func(self._ui._btn_openDescBox, 146, 434, 118, 462)
    self._ui._btn_openDescBox:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(self._ui._btn_openDescBox, 175, 434, 147, 462)
    self._ui._btn_openDescBox:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    self._ui._btn_openDescBox:setRenderTexture(self._ui._btn_openDescBox:getBaseTexture())
  end
  self._ui._btn_openDescBox:SetShow(true)
end
function PaGlobal_Equip_CharacterTag_ItemCopy:validate()
  if nil == Panel_Window_Equip_CharacterTag_ItemCopy then
    UI.ASSERT_NAME(false, "Panel_Window_Equip_CharacterTag_ItemCopy \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\235\133\184\235\140\128\236\152\129")
    return
  end
  self._ui._stc_title:isValidate()
  self._ui._stc_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._txt_titleIcon:isValidate()
  self._ui._btn_openDescBox:isValidate()
  self._ui._stc_tapBg:isValidate()
  self._ui._stc_tapLine:isValidate()
  self._ui._stc_selectLine:isValidate()
  self._ui._btn_copyAllTap:isValidate()
  self._ui._btn_changeCopy:isValidate()
  self._ui._btn_exitCopy:isValidate()
  self._ui._stc_itemCopyBg:isValidate()
  self._ui._stc_costBox:isValidate()
  self._ui._txt_itemCost:isValidate()
  self._ui._stc_needItemIcon:isValidate()
  self._ui._btn_copyConfirm:isValidate()
  self._ui._txt_toCharacterName:isValidate()
  self._ui._stc_equipSlotGroup:isValidate()
  self._ui._stc_mainCirce:isValidate()
  self._ui._txt_notice:isValidate()
  self._ui._txt_slotEnchantValue:isValidate()
  self._ui._stc_itemCopyDecoBG:isValidate()
  self._ui._stc_itemCopyEffect:isValidate()
  self._ui._stc_addCopyBg:isValidate()
  self._ui._btn_addConfirm:isValidate()
  self._ui._stc_addCostBox:isValidate()
  self._ui._stc_addCostIcon:isValidate()
  self._ui._txt_addCost:isValidate()
  self._ui._stc_addCostIcon2:isValidate()
  self._ui._txt_addCost2:isValidate()
  self._ui._txt_addToCharacter:isValidate()
  self._ui._stc_addItemBg:isValidate()
  self._ui._txt_addItemName:isValidate()
  self._ui._stc_addItemEffect:isValidate()
  self._ui._stc_exitCopyBg:isValidate()
  self._ui._btn_exitConfirm:isValidate()
  self._ui._txt_exitToCharacter:isValidate()
  self._ui._stc_exitItemBg:isValidate()
  self._ui._txt_exitItemName:isValidate()
  self._ui._stc_exitItemEffect:isValidate()
  self._ui._stc_keyguideBg:isValidate()
  self._ui._txt_keyguideX:isValidate()
  self._ui._txt_keyguideB:isValidate()
  self._ui._txt_keyguideA:isValidate()
  self._ui._txt_keyguideY:isValidate()
  self._ui._txt_keyguideLTX:isValidate()
end
