Panel_Equipment:SetShow(false, false)
Panel_Equipment:ActiveMouseEventEffect(true)
Panel_Equipment:setMaskingChild(true)
Panel_Equipment:setGlassBackground(true)
Panel_Equipment:RegisterShowEventFunc(true, "EquipmentWindow_ShowAni()")
Panel_Equipment:RegisterShowEventFunc(false, "EquipmentWindow_HideAni()")
local EquipNoMin = CppEnums.EquipSlotNo.rightHand
local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
local UnUsedEquipNo_01 = 100
local UnUsedEquipNo_02 = 101
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local isContentsEnable = ToClient_IsContentsGroupOpen("35")
local isKR2ContentsEnable = isGameTypeKR2()
local isSwimmingSuitContentEnable = true
local awakenWeapon = {
  [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
  [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
  [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
  [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
  [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
  [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
  [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
  [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
  [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
  [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
  [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
  [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
  [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
  [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
  [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
  [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
  [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
  [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
  [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317")
}
local battlePointOpen = false
local classType = getSelfPlayer():getClassType()
local awakenWeaponContentsOpen = awakenWeapon[classType]
local equip = {
  slotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnduranceIcon = true,
    createItemLock = true,
    createBlack = true,
    createEnchant = true
  },
  slotNoId = {
    [0] = "Static_Slot_RightHand",
    [1] = "Static_Slot_LeftHand",
    [2] = "Static_Slot_Gather",
    [3] = "Static_Slot_Chest",
    [4] = "Static_Slot_Glove",
    [5] = "Static_Slot_Boots",
    [6] = "Static_Slot_Helm",
    [7] = "Static_Slot_Necklace",
    [8] = "Static_Slot_Ring1",
    [9] = "Static_Slot_Ring2",
    [10] = "Static_Slot_Earing1",
    [11] = "Static_Slot_Earing2",
    [12] = "Static_Slot_Belt",
    [13] = "Static_Slot_Lantern",
    [14] = "Static_Slot_Avatar_Chest",
    [15] = "Static_Slot_Avatar_Gloves",
    [16] = "Static_Slot_Avatar_Boots",
    [17] = "Static_Slot_Avatar_Helm",
    [18] = "Static_Slot_Avatar_RightHand",
    [19] = "Static_Slot_Avatar_LeftHand",
    [20] = "Static_Slot_Avatar_UnderWear",
    [22] = "Static_Slot_FaceDecoration1",
    [23] = "Static_Slot_FaceDecoration2",
    [21] = "Static_Slot_FaceDecoration3",
    [27] = "Static_Slot_AlchemyStone",
    [29] = "Static_Slot_AwakenWeapon",
    [30] = "Static_Slot_Avatar_AwakenWeapon",
    [31] = "Static_Slot_QuestBook"
  },
  avataEquipSlotId = {
    [14] = "Check_Slot_Avatar_Chest",
    [15] = "Check_Slot_Avatar_Gloves",
    [16] = "Check_Slot_Avatar_Boots",
    [17] = "Check_Slot_Avatar_Helm",
    [18] = "Check_Slot_Avatar_RightHand",
    [19] = "Check_Slot_Avatar_LeftHand",
    [20] = "Check_Slot_Avatar_UnderWear",
    [22] = "Check_Slot_FaceDecoration1",
    [23] = "Check_Slot_FaceDecoration2",
    [21] = "Check_Slot_FaceDecoration3",
    [30] = "Check_Slot_Avatar_AwakenWeapon"
  },
  equipSlotId = {
    [6] = "Check_Slot_Helm"
  },
  _checkFlag = {
    [14] = 1,
    [15] = 2,
    [16] = 4,
    [17] = 8,
    [18] = 32,
    [19] = 64,
    [20] = 16,
    [22] = 256,
    [23] = 512,
    [21] = 128,
    [3] = 65536,
    [4] = 131072,
    [5] = 262144,
    [6] = 524288,
    [0] = 2097152,
    [1] = 4194304,
    [30] = 1024
  },
  slotNoIdToString = {
    [__eEquipSlotNoRightHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [__eEquipSlotNoLeftHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [__eEquipSlotNoSubTool] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
    [__eEquipSlotNoChest] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [__eEquipSlotNoGlove] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [__eEquipSlotNoBoots] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [__eEquipSlotNoHelm] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [__eEquipSlotNoNecklace] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [__eEquipSlotNoRing1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoRing2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoEaring1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoEaring2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoBelt] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [__eEquipSlotNoLantern] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
    [__eEquipSlotNoAvatarChest] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
    [__eEquipSlotNoAvatarGlove] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
    [__eEquipSlotNoAvatarBoots] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
    [__eEquipSlotNoAvatarHelm] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
    [__eEquipSlotNoAvatarWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
    [__eEquipSlotNoAvatarSubWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
    [__eEquipSlotNoAvatarUnderwear] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
    [__eEquipSlotNoFaceDecoration1] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HEAD"),
    [__eEquipSlotNoFaceDecoration2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_EYES"),
    [__eEquipSlotNoFaceDecoration3] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MOUSE"),
    [__eEquipSlotNoAlchemyStone] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [__eEquipSlotNoAvatarAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon"),
    [__eEquipSlotNoQuestBook] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_QUESTBOOK")
  },
  slots = Array.new(),
  slotBGs = Array.new(),
  avataSlots = Array.new(),
  defaultSlots = Array.new(),
  txt_Title = UI.getChildControl(Panel_Equipment, "StaticText_Title"),
  bottom_ButtonArea = UI.getChildControl(Panel_Equipment, "Static_BottomButtonArea"),
  bottom_AbilityArea = UI.getChildControl(Panel_Equipment, "Static_AbilityArea"),
  buttonClose = nil,
  enchantText = UI.getChildControl(Panel_Equipment, "Static_Text_Slot_Enchant_value"),
  effectBG = UI.getChildControl(Panel_Equipment, "Static_Circle"),
  checkPopUp = nil,
  iconSetItemTooltip = UI.getChildControl(Panel_Equipment, "StaticText_SetEffect"),
  iconEquipCrystalTooltip = UI.getChildControl(Panel_Equipment, "StaticText_EquipCrystal"),
  extendedSlotInfoArray = {},
  checkExtendedSlot = 0,
  checkBox_AlchemyStone = UI.getChildControl(Panel_Equipment, "CheckBox_AlchemyStone"),
  slotRingIndex = 0,
  slotEaringIndex = 0,
  reuseAlchemyStoneCheckTime = 0,
  isUsedAlchemyStone = false,
  _isInitControl = false
}
local alchemyStoneQuickKey = UI.getChildControl(Panel_Equipment, "Static_Slot_AlchemyStone_Key")
local isAlchemyStoneCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
equip.checkBox_AlchemyStone:SetCheck(isAlchemyStoneCheck)
equip.checkBox_AlchemyStone:addInputEvent("Mouse_LUp", "AlchemyStone_CheckEventForSave()")
equip.checkBox_AlchemyStone:addInputEvent("Mouse_On", "AlchemyStone_CheckButtonTooltip(true)")
equip.checkBox_AlchemyStone:addInputEvent("Mouse_Out", "AlchemyStone_CheckButtonTooltip(false)")
local setTierIcon = function(iconControl, textureName, iconIdx, leftX, topY, xCount, iconSize)
  iconControl:ChangeTextureInfoName("new_ui_common_forlua/default/Default_Etc_04.dds")
  iconControl:SetShow(true)
  local x1, y1, x2, y2
  x1 = leftX + (iconSize + 1) * (iconIdx % xCount)
  y1 = topY + (iconSize + 1) * math.floor(iconIdx / xCount)
  x2 = x1 + iconSize
  y2 = y1 + iconSize
  x1, y1, x2, y2 = setTextureUV_Func(iconControl, x1, y1, x2, y2)
  iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
  iconControl:setRenderTexture(iconControl:getBaseTexture())
end
function AlchemyStone_CheckEventForSave(isShow)
  local isCheck = equip.checkBox_AlchemyStone:IsCheck()
  if nil ~= isShow and isCheck then
    isCheck = isShow
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eAlchemyStone, isCheck, CppEnums.VariableStorageType.eVariableStorageType_Character)
end
function AlchemyStone_CheckButtonTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONEDESC")
  TooltipSimple_Show(equip.checkBox_AlchemyStone, name, desc)
end
local toolTip_Templete = UI.getChildControl(Panel_Equipment, "StaticText_Notice_1")
local toolTip_BlankSlot = UI.createControl(__ePAUIControl_StaticText, equip.effectBG, "toolTip_BlankSlot_For_Equipment")
CopyBaseProperty(toolTip_Templete, toolTip_BlankSlot)
toolTip_BlankSlot:SetColor(UI_color.C_FFFFFFFF)
toolTip_BlankSlot:SetAlpha(1)
toolTip_BlankSlot:SetFontColor(UI_color.C_FFC4BEBE)
toolTip_BlankSlot:SetTextHorizonCenter()
toolTip_BlankSlot:SetShow(false)
toolTip_BlankSlot:SetIgnore(true)
function equip_checkUseableSlot(index)
  local returnValue = true
  if index == UnUsedEquipNo_01 or index == nUsedEquipNo_02 or index == CppEnums.EquipSlotNo.equipSlotNoCount or index == CppEnums.EquipSlotNo.explorationBonus0 or index == CppEnums.EquipSlotNo.installation4 or index == CppEnums.EquipSlotNo.body or index == CppEnums.EquipSlotNo.avatarBody then
    returnValue = false
  end
  return returnValue
end
function equip:initControl()
  if nil == getSelfPlayer() then
    return
  end
  local isClassType = getSelfPlayer():getClassType()
  for v = EquipNoMin, EquipNoMax do
    if true == equip_checkUseableSlot(v) then
      local slotBG = UI.getChildControl(self.effectBG, self.slotNoId[v] .. "_BG")
      slotBG:SetShow(false)
      self.slotBGs[v] = slotBG
      local whereType = Inventory_GetCurrentInventoryType()
      if true == ToClient_EquipSlot_CheckItemLock(v, whereType) then
        ToClient_Inventory_RemoveItemLock(v)
      end
      if 15 == v then
        if awakenWeaponContentsOpen then
          self.slotBGs[v]:SetPosX(253)
          self.slotBGs[v]:SetPosY(178)
        else
          self.slotBGs[v]:SetPosX(255)
          self.slotBGs[v]:SetPosY(192)
        end
      end
      if 16 == v then
        if awakenWeaponContentsOpen then
          self.slotBGs[v]:SetPosX(89)
          self.slotBGs[v]:SetPosY(178)
        else
          self.slotBGs[v]:SetPosX(87)
          self.slotBGs[v]:SetPosY(192)
        end
      end
      if 18 == v then
        if awakenWeaponContentsOpen then
          self.slotBGs[v]:SetPosX(89)
          self.slotBGs[v]:SetPosY(240)
        else
          self.slotBGs[v]:SetPosX(100)
          self.slotBGs[v]:SetPosY(260)
        end
      end
      if 19 == v then
        if awakenWeaponContentsOpen then
          self.slotBGs[v]:SetPosX(253)
          self.slotBGs[v]:SetPosY(240)
        else
          self.slotBGs[v]:SetPosX(242)
          self.slotBGs[v]:SetPosY(260)
        end
      end
      if 20 == v then
        if awakenWeaponContentsOpen then
          self.slotBGs[v]:SetPosX(208)
          self.slotBGs[v]:SetPosY(282)
        else
          self.slotBGs[v]:SetPosX(171)
          self.slotBGs[v]:SetPosY(290)
        end
      end
      if 29 == v then
        if __eClassType_ShyWaman == isClassType then
          self.slotBGs[v]:ChangeTextureInfoName("renewal/pcremaster/remaster_icon_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[v], 1, 345, 43, 387)
          self.slotBGs[v]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[v]:setRenderTexture(self.slotBGs[v]:getBaseTexture())
        else
          self.slotBGs[v]:ChangeTextureInfoName("renewal/pcremaster/remaster_icon_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[v], 44, 87, 86, 129)
          self.slotBGs[v]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[v]:setRenderTexture(self.slotBGs[v]:getBaseTexture())
        end
      end
      if 30 == v then
        if __eClassType_ShyWaman == isClassType then
          self.slotBGs[v]:ChangeTextureInfoName("renewal/pcremaster/remaster_icon_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[v], 44, 345, 86, 387)
          self.slotBGs[v]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[v]:setRenderTexture(self.slotBGs[v]:getBaseTexture())
        else
          self.slotBGs[v]:ChangeTextureInfoName("renewal/pcremaster/remaster_icon_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[v], 87, 173, 129, 201)
          self.slotBGs[v]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[v]:setRenderTexture(self.slotBGs[v]:getBaseTexture())
        end
      end
      local slot = {}
      slot.icon = UI.getChildControl(self.effectBG, self.slotNoId[v])
      slot.icon:SetPosX(slotBG:GetPosX() + 4)
      slot.icon:SetPosY(slotBG:GetPosY() - 4)
      SlotItem.new(slot, "Equipment_" .. v, v, Panel_Equipment, self.slotConfig)
      slot:createChild()
      slot.icon:addInputEvent("Mouse_RUp", "Equipment_RClick(" .. v .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "Equipment_LClick(" .. v .. ")")
      slot.icon:addInputEvent("Mouse_On", "Equipment_MouseOn(" .. v .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "Equipment_MouseOn(" .. v .. ",false)")
      Panel_Tooltip_Item_SetPosition(v, slot, "equipment")
      self.slots[v] = slot
      if nil ~= self.avataEquipSlotId[v] then
        self.avataSlots[v] = UI.getChildControl(self.effectBG, self.avataEquipSlotId[v])
        self.avataSlots[v]:SetShow(true)
        self.avataSlots[v]:SetPosX(slot.icon:GetSpanSize().x + slot.icon:GetSizeX() - 15)
        self.avataSlots[v]:SetPosY(slot.icon:GetSpanSize().y + slot.icon:GetSizeY() - 15)
        self.avataSlots[v]:addInputEvent("Mouse_LUp", "AvatarEquipSlot_LClick(" .. v .. ")")
        if v <= 20 or 30 == v then
          self.avataSlots[v]:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 4, " .. v .. " )")
          self.avataSlots[v]:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 4, " .. v .. " )")
        else
          self.avataSlots[v]:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 5, " .. v .. " )")
          self.avataSlots[v]:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 5, " .. v .. " )")
        end
        if CppEnums.EquipSlotNo.avatarAwakenWeapon == v then
          if __eClassType_ShyWaman == getSelfPlayer():getClassType() then
            self.avataSlots[v]:SetShow(false)
          else
            self.avataSlots[v]:SetShow(awakenWeaponContentsOpen)
          end
        end
      end
      if nil ~= self.equipSlotId[v] then
        self.defaultSlots[v] = UI.getChildControl(self.effectBG, self.equipSlotId[v])
        self.defaultSlots[v]:SetShow(false)
      end
    end
  end
  if __eClassType_ShyWaman == getSelfPlayer():getClassType() then
    local underwearSlot = CppEnums.EquipSlotNo.avatarUnderWear
    local spanX = 182
    local spanY = 276
    if nil ~= self.slotBGs[underwearSlot] then
      self.slotBGs[underwearSlot]:SetSpanSize(spanX, spanY)
      self.slotBGs[underwearSlot]:ComputePos()
    end
    if nil ~= self.slots[underwearSlot] then
      self.slots[underwearSlot].icon:SetSpanSize(spanX, spanY)
      self.slots[underwearSlot].icon:ComputePos()
      if nil ~= self.avataSlots[underwearSlot] then
        local slotIcon = self.slots[underwearSlot].icon
        self.avataSlots[underwearSlot]:SetPosX(slotIcon:GetSpanSize().x + slotIcon:GetSizeX() - 15)
        self.avataSlots[underwearSlot]:SetPosY(slotIcon:GetSpanSize().y + slotIcon:GetSizeY() - 15)
      end
    end
    local loopSlot = {
      CppEnums.EquipSlotNo.belt,
      CppEnums.EquipSlotNo.necklace
    }
    for k, v in pairs(loopSlot) do
      if nil ~= self.slotBGs[v] then
        self.slotBGs[v]:SetSpanSize(self.slotBGs[v]:GetSpanSize().x, spanY)
        self.slotBGs[v]:ComputePos()
      end
      if nil ~= self.slots[v] then
        self.slots[v].icon:SetSpanSize(self.slots[v].icon:GetSpanSize().x, spanY)
        self.slots[v].icon:ComputePos()
      end
    end
  end
  local partLine = UI.getChildControl(self.bottom_AbilityArea, "Static_PartLine")
  self.battlePointBG = UI.getChildControl(self.bottom_AbilityArea, "Static_BattlePointBg")
  self.battlePointText = UI.getChildControl(self.battlePointBG, "StaticText_BattlePointTitle")
  self.BattlePointValue = UI.getChildControl(self.battlePointBG, "StaticText_BattlePointValue")
  self.BonusBattlePointValue = UI.getChildControl(self.battlePointBG, "StaticText_BonusBattlePointValue")
  self.attackText = UI.getChildControl(self.bottom_AbilityArea, "StaticText_Attack")
  self.attackValue = UI.getChildControl(self.bottom_AbilityArea, "StaticText_Attack_Value")
  self.defenceText = UI.getChildControl(self.bottom_AbilityArea, "StaticText_Defence")
  self.defenceValue = UI.getChildControl(self.bottom_AbilityArea, "StaticText_Defence_Value")
  self.awakenText = UI.getChildControl(self.bottom_AbilityArea, "StaticText_AwakenAttack")
  self.awakenValue = UI.getChildControl(self.bottom_AbilityArea, "StaticText_AwakenAttack_Value")
  self.statExtraParam1Text = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat1_Title")
  self.statExtraParam1Value = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat1_Value")
  self.statExtraParam2Text = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat2_Title")
  self.statExtraParam2Value = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat2_Value")
  self.statExtraParam3Text = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat3_Title")
  self.statExtraParam3Value = UI.getChildControl(self.bottom_AbilityArea, "StaticText_ShyStat3_Value")
  self.attackText:SetTextMode(__eTextMode_AutoWrap)
  self.defenceText:SetTextMode(__eTextMode_AutoWrap)
  self.awakenText:SetTextMode(__eTextMode_AutoWrap)
  self.statExtraParam1Text:SetTextMode(__eTextMode_AutoWrap)
  self.statExtraParam2Text:SetTextMode(__eTextMode_AutoWrap)
  self.statExtraParam3Text:SetTextMode(__eTextMode_AutoWrap)
  self.attackText:SetText(self.attackText:GetText())
  self.defenceText:SetText(self.defenceText:GetText())
  self.awakenText:SetText(self.awakenText:GetText())
  self.statExtraParam1Text:SetText(self.statExtraParam1Text:GetText())
  self.statExtraParam2Text:SetText(self.statExtraParam2Text:GetText())
  self.statExtraParam3Text:SetText(self.statExtraParam3Text:GetText())
  if not battlePointOpen then
    self.battlePointBG:SetShow(false)
    partLine:SetShow(false)
  end
  self.checkCloak = UI.getChildControl(self.bottom_ButtonArea, "CheckButton_Cloak_Invisual")
  self.checkHelm = UI.getChildControl(self.bottom_ButtonArea, "CheckButton_Helm_Invisual")
  self.checkHelmOpen = UI.getChildControl(self.bottom_ButtonArea, "CheckButton_HelmOpen")
  self.btn_PetList = UI.getChildControl(self.bottom_ButtonArea, "Button_PetInfo")
  self.checkUnderwear = UI.getChildControl(self.bottom_ButtonArea, "CheckButton_Underwear_Invisual")
  self.checkCamouflage = UI.getChildControl(self.bottom_ButtonArea, "CheckButton_ShowNameWhenCamouflage")
  self.btn_ServantInventory = UI.getChildControl(self.bottom_ButtonArea, "Button_ServantInventory")
  self.buttonClose = UI.getChildControl(self.txt_Title, "Button_Close")
  self._buttonQuestion = UI.getChildControl(self.txt_Title, "Button_Question")
  self.checkPopUp = UI.getChildControl(self.txt_Title, "CheckButton_PopUp")
  self.checkCloak:SetShow(true)
  self.checkHelm:SetShow(true)
  self.checkHelmOpen:SetShow(true)
  if false == ToClient_isAdultUser() then
    self.checkUnderwear:SetShow(false)
  else
    self.checkUnderwear:SetShow(not isKR2ContentsEnable)
  end
  self.checkCamouflage:SetShow(true)
  local isPopUpContentsEnable = ToClient_IsContentsGroupOpen("240")
  self.checkPopUp:SetShow(isPopUpContentsEnable)
  self.checkCloak:SetCheck(not ToClient_IsShowCloak())
  self.checkHelm:SetCheck(not ToClient_IsShowHelm())
  self.checkHelmOpen:SetCheck(ToClient_IsShowBattleHelm())
  getSelfPlayer():get():setUnderwearModeInhouse(false)
  getSelfPlayer():get():setSwimmingSuitMode(false)
  self.checkUnderwear:SetCheck(false)
  self.checkCamouflage:SetCheck(Toclient_setShowNameWhenCamouflage())
  selfPlayerShowHelmet(ToClient_IsShowHelm())
  selfPlayerShowBattleHelmet(ToClient_IsShowBattleHelm())
  self.btn_PetList:SetShow(true)
  Equipment_RePosition()
  self.checkHelm:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 0 )")
  self.checkHelm:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 0 )")
  self.checkHelmOpen:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 1 )")
  self.checkHelmOpen:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 1 )")
  self.checkCloak:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 6 )")
  self.checkCloak:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 6 )")
  self.checkUnderwear:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 7 )")
  self.checkUnderwear:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 7 )")
  self.btn_PetList:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 2 )")
  self.btn_PetList:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 2 )")
  self.btn_ServantInventory:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 3 )")
  self.btn_ServantInventory:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 3 )")
  self.checkCamouflage:addInputEvent("Mouse_On", "Equipment_SimpleToolTips( true, 8 )")
  self.checkCamouflage:addInputEvent("Mouse_Out", "Equipment_SimpleToolTips( false, 8 )")
  self.attackText:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 0)")
  self.attackText:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.defenceText:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 1)")
  self.defenceText:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.awakenText:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 2)")
  self.awakenText:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.BonusBattlePointValue:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 3)")
  self.BonusBattlePointValue:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.statExtraParam1Text:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 4)")
  self.statExtraParam1Text:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.statExtraParam2Text:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 5)")
  self.statExtraParam2Text:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  self.statExtraParam3Text:addInputEvent("Mouse_On", "Equipment_StatValueTooltips(true, 6)")
  self.statExtraParam3Text:addInputEvent("Mouse_Out", "Equipment_StatValueTooltips(false)")
  local initSucceed = PaGlobal_EquipmentTooltip:initWithIcon(self.iconSetItemTooltip)
  self.iconSetItemTooltip:SetShow(initSucceed)
  self.iconSetItemTooltip:SetIgnore(not initSucceed)
  initSucceed = PaGlobalFunc_CrystalToolTip_InitWithIcon(self.iconEquipCrystalTooltip)
  self.iconEquipCrystalTooltip:SetShow(initSucceed)
  self.iconEquipCrystalTooltip:SetIgnore(not initSucceed)
  initSucceed = PaGlobal_Tooltip_BattlePoint:initWithIcon(self.battlePointText)
  self.battlePointText:SetShow(initSucceed)
  self.battlePointText:SetIgnore(not initSucceed)
  self.iconSetItemTooltip:SetEnableArea(0, 0, self.iconSetItemTooltip:GetSizeX() + self.iconSetItemTooltip:GetTextSizeX() + 10, 25)
  self.iconEquipCrystalTooltip:SetEnableArea(0, 0, self.iconEquipCrystalTooltip:GetSizeX() + self.iconEquipCrystalTooltip:GetTextSizeX() + 10, 25)
  Equipment_onScreenResize()
  self._isInitControl = true
end
function HandleClicked_EquipmentWindow_Close()
  audioPostEvent_SystemUi(1, 1)
  equip.checkPopUp:SetCheck(false)
  Panel_Equipment:CloseUISubApp()
  EquipmentWindow_Close()
  local isCamp = false
  if true == _ContentsGroup_NewUI_RepairFunction_All then
    isCamp = PaGlobalFunc_RepairFunc_All_IsCampingType()
  elseif true == _ContentsGroup_NewUI_Camp_All then
    isCamp = PaGlobalFunc_Camp_All_GetIsCamping()
  else
    isCamp = PaGlobal_Camp:getIsCamping()
  end
  if true == isCamp then
    InventoryWindow_Close()
    if true == _ContentsGroup_NewUI_Camp_All then
      PaGlobalFunc_Camp_All_Open()
    else
      PaGlobal_Camp:open()
    end
  end
end
function EquipmentWindow_Close()
  if Panel_Equipment:IsUISubApp() then
    return
  end
  if Panel_Equipment:IsShow() then
    Panel_Equipment:SetShow(false, false)
    if ToClient_IsSavedUi() then
      ToClient_SaveUiInfo(false)
      ToClient_SetSavedUi(false)
    end
  end
  HelpMessageQuestion_Out()
  equip.slotRingIndex = 0
  equip.slotEaringIndex = 0
  PaGlobal_EquipmentTooltip:show(false)
  PAGlobalFunc_CrystalTooltip_Show(false)
  PaGlobal_Tooltip_BattlePoint:show(false)
end
function EquipmentWindow_ShowAni()
  UIAni.fadeInSCR_Left(Panel_Equipment)
  local aniInfo1 = Panel_Equipment:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Equipment:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Equipment:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Equipment:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Equipment:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Equipment:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function EquipmentWindow_HideAni()
  Panel_Equipment:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Equipment:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function Equipment_MouseOn(slotNo, isOn)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "equipment", isOn, false)
end
function Equipment_NilSlot_MouseOn(slotNo, isOn)
  local self = equip
  if nil == getSelfPlayer() then
    return
  end
  local isClassType = getSelfPlayer():getClassType()
  if true == isOn then
    if isClassType == __eClassType_ShyWaman and 29 == slotNo then
      toolTip_BlankSlot:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
    elseif isClassType == __eClassType_ShyWaman and 30 == slotNo then
      toolTip_BlankSlot:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH"))
    else
      toolTip_BlankSlot:SetText(self.slotNoIdToString[slotNo])
    end
    toolTip_BlankSlot:SetSize(toolTip_BlankSlot:GetTextSizeX() + 30, 20)
    toolTip_BlankSlot:SetPosX(self.slots[slotNo].icon:GetPosX() - toolTip_BlankSlot:GetTextSizeX())
    toolTip_BlankSlot:SetPosY(getMousePosY() - Panel_Equipment:GetPosY() - 50)
    toolTip_BlankSlot:SetShow(true)
  else
    toolTip_BlankSlot:SetShow(false)
  end
end
local _offenceValue, _awakenOffecnValue, _defenceValue
function Equipment_RClick(slotNo)
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    if CppEnums.EquipSlotNoClient.eEquipSlotNoAvatarUnderwear == slotNo then
      HideUnderwearSlotItemModes()
    end
    local repairPanel, endurancePanel
    if true == _ContentsGroup_NewUI_RepairFunction_All then
      repairPanel = Panel_Dialog_Repair_Function_All
    else
      repairPanel = Panel_Window_Repair
    end
    if true == _ContentsGroup_NewUI_BlackSmith_All then
      endurancePanel = Panel_Window_Endurance_Recovery_All
    else
      endurancePanel = Panel_FixEquip
    end
    if repairPanel:IsShow() and nil ~= endurancePanel and false == endurancePanel:GetShow() then
      if true == _ContentsGroup_NewUI_RepairFunction_All then
        PaGlobalFunc_RepairFunc_All_EquipWindowRClick(slotNo, itemWrapper)
      else
        PaGlobal_Repair:repair_EquipWindowRClick(slotNo, itemWrapper)
      end
    elseif repairPanel:IsShow() and nil ~= endurancePanel and true == endurancePanel:GetShow() then
      equipmentDoUnequip(slotNo)
    else
      equipmentDoUnequip(slotNo)
    end
  end
end
function Equipment_LClick(slotNo)
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if DragManager.dragStartPanel == inventoryPanel then
    local dragSlotNo = DragManager.dragSlotInfo
    local itemWrapper = getInventoryItem(dragSlotNo)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus()
      if itemStatic:isEquipable() then
        if true == _ContentsGroup_NewUI_Inventory_All then
          PaGlobalFunc_Inventory_All_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        else
          Inventory_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        end
        DragManager:clearInfo()
      end
    end
  end
end
function AvatarEquipSlot_LClick(slotNo)
  local self = equip
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil and (true == selfPlayer:get():getUnderwearModeInhouse() or true == selfPlayer:get():getSwimmingSuitMode()) then
    local isCheckedTemp = self.avataSlots[slotNo]:IsCheck()
    if isCheckedTemp then
      isCheckedTemp = false
    else
      isCheckedTemp = true
    end
    self.avataSlots[slotNo]:SetCheck(isCheckedTemp)
    return
  end
  local isChecked = self.avataSlots[slotNo]:IsCheck()
  if true == isChecked then
    ToClient_SetAvatarEquipSlotFlag(slotNo)
  else
    ToClient_ResetAvatarEquipSlotFlag(slotNo)
  end
  Toclient_setShowAvatarEquip()
end
local equipMentPosX = 0
local equipMentPosY = 0
function Equipment_PosSaveMemory()
  equipMentPosX = Panel_Equipment:GetPosX()
  equipMentPosY = Panel_Equipment:GetPosY()
end
function Equipment_PosLoadMemory()
  Panel_Equipment:SetPosX(equipMentPosX)
  Panel_Equipment:SetPosY(equipMentPosY)
end
function Equipment_BesideInvenPos()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:GetShow() then
      Panel_Equipment:SetPosY(Panel_Window_Inventory_All:GetPosY())
      Panel_Equipment:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Equipment:GetSizeX())
    end
  elseif Panel_Window_Inventory:GetShow() then
    Panel_Equipment:SetPosY(Panel_Window_Inventory:GetPosY())
    Panel_Equipment:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Equipment:GetSizeX())
  end
end
function Equipment_SetShow(isShow)
  if true == _ContentsGroup_isFairy and true == _ContentsGroup_NewUI_Fairy_All and (true == PaGlobal_FairyInfo_IsGetShow() or true == PaGlobal_FairyChangeSkill_IsGetShow()) then
    return
  end
  if true == _ContentsGroup_DeleteMaxEnchanterName and true == PaGlobal_DeleteMaxEnchanterName_GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MAXENCHANT_DELETENAME_NOUSE"))
    return
  end
  local self = equip
  local isSelfPlayer = getSelfPlayer()
  if nil == isSelfPlayer then
    return
  end
  if _ContentsGroup_NewUI_Camp_All then
    if nil ~= Panel_Window_Camp_All and Panel_Window_Camp_All:GetShow() then
      return
    end
  elseif nil ~= Panel_Window_Camp and Panel_Window_Camp:GetShow() then
    return
  end
  if true == isShow then
    if GetUIMode() == Defines.UIMode.eUIMode_NpcDialog then
      Panel_Equipment:SetShow(false, false)
    else
      Panel_Equipment:SetShow(true, true)
    end
  else
    if Panel_Equipment:IsUISubApp() then
      return
    end
    Panel_Equipment:SetShow(false, false)
    if ToClient_IsSavedUi() then
      ToClient_SaveUiInfo(false)
      ToClient_SetSavedUi(false)
    end
  end
  Inventory_SetFunctor(nil, nil, EquipmentWindow_Close, nil)
  for v = EquipNoMin, EquipNoMax do
    if true == equip_checkUseableSlot(v) and nil ~= self.avataSlots[v] and nil ~= self._checkFlag[v] then
      local isCheck = ToClient_IsSetAvatarEquipSlotFlag(v)
      self.avataSlots[v]:SetCheck(isCheck)
    end
  end
  local alchemyStoneQuickKeyString = keyCustom_GetString_UiKey(__eUiInputType_AlchemyStone)
  alchemyStoneQuickKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_QUICKCOMMAND", "keyString", alchemyStoneQuickKeyString))
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and true == selfPlayer:get():isWearingSwimmingSuit() then
    self.checkUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
  elseif nil ~= selfPlayer and true == selfPlayer:get():isWearingUnderwear() then
    self.checkUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
  else
    self.checkUnderwear:SetCheck(false)
  end
  Equipment_updateSlotData()
end
function FGlobal_Equipment_SetHide(isShow)
  Equipment_SetShow(isShow)
end
function FGlobal_Equipment_SetFunctionButtonHide(isShow)
  equip.btn_PetList:SetShow(isShow)
  if isKR2ContentsEnable or true == ToClient_isAdultUser() then
    equip.checkUnderwear:SetShow(isShow)
  else
    equip.checkUnderwear:SetShow(false)
  end
  equip.checkCamouflage:SetShow(isShow)
  equip.btn_ServantInventory:SetShow(isShow)
  equip.checkBox_AlchemyStone:SetShow(isShow)
  equip.iconSetItemTooltip:SetShow(isShow)
  equip.iconEquipCrystalTooltip:SetShow(isShow)
end
function equip:registEventHandler()
  self.buttonClose:addInputEvent("Mouse_LUp", "HandleClicked_EquipmentWindow_Close()")
  self.checkCloak:addInputEvent("Mouse_LUp", "Check_Cloak()")
  self.checkHelm:addInputEvent("Mouse_LUp", "Check_Helm()")
  self.checkHelmOpen:addInputEvent("Mouse_LUp", "Check_HelmOpen()")
  self.checkUnderwear:addInputEvent("Mouse_LUp", "Check_Underwear()")
  self.checkCamouflage:addInputEvent("Mouse_LUp", "Check_ShowNameWhenCamouflage()")
  self.checkPopUp:addInputEvent("Mouse_LUp", "Check_PopUI()")
  self.checkPopUp:addInputEvent("Mouse_On", "Equipment__PopUp_ShowIconToolTip(true)")
  self.checkPopUp:addInputEvent("Mouse_Out", "Equipment__PopUp_ShowIconToolTip(false)")
  self._buttonQuestion:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowEquipment\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._buttonQuestion, "\"PanelWindowEquipment\"")
  if true == _ContentsGroup_NewUI_Pet_All then
    self.btn_PetList:addInputEvent("Mouse_LUp", "PaGlobal_PetList_Toggle_All()")
  else
    self.btn_PetList:addInputEvent("Mouse_LUp", "FGlobal_PetListNew_Toggle()")
  end
  self.btn_ServantInventory:addInputEvent("Mouse_LUp", "HandleClicked_ServantInventoryOpen()")
end
local function extendedSlotInfo(itemWrapper, SlotNo)
  local itemSSW = itemWrapper:getStaticStatus()
  local itemName = itemSSW:getName()
  local slotNoMax = itemSSW:getExtendedSlotCount()
  local extendedSlotString = ""
  local compareSlot = {}
  for i = 1, slotNoMax do
    local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
    if slotNoMax ~= extendSlotNo then
      equip.extendedSlotInfoArray[extendSlotNo] = SlotNo
      setItemCount = equip.extendedSlotInfoArray[extendSlotNo]
      equip.checkExtendedSlot = 1
      compareSlot[i] = extendSlotNo
      extendedSlotString = extendedSlotString .. ", " .. equip.slotNoId[extendSlotNo] .. "_BG"
    end
  end
end
local setItemInfoUseWrapper = function(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantCount = itemSSW:get()._key:getEnchantLevel()
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
end
function Equipment_updateSlotData()
  if false == Panel_Equipment:GetShow() then
    return
  end
  local self = equip
  if false == self._isInitControl then
    return
  end
  self.extendedSlotInfoArray = {}
  self.checkExtendedSlot = 0
  for v = EquipNoMin, EquipNoMax do
    if true == equip_checkUseableSlot(v) then
      local itemWrapper = ToClient_getEquipmentItem(v)
      local slot = self.slots[v]
      local slotBG = self.slotBGs[v]
      if nil ~= itemWrapper then
        extendedSlotInfo(itemWrapper, v)
        setItemInfoUseWrapper(slot, itemWrapper, false, false, v)
        local whereType = Inventory_GetCurrentInventoryType()
        slotBG:SetShow(false)
        if true == ToClient_EquipSlot_CheckItemLock(v, 1) then
        end
        slot.icon:addInputEvent("Mouse_On", "Equipment_MouseOn(" .. v .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "Equipment_MouseOn(" .. v .. ",false)")
        local itemss = itemWrapper:getStaticStatus()
        local name = itemss:getName()
      else
        slot:clearItem()
        slot.icon:SetEnable(true)
        slotBG:SetShow(true)
        if CppEnums.EquipSlotNo.awakenWeapon == v then
          slotBG:SetShow(awakenWeaponContentsOpen)
          slot.icon:SetEnable(awakenWeaponContentsOpen)
          slot.icon:SetShow(awakenWeaponContentsOpen)
        elseif CppEnums.EquipSlotNo.avatarAwakenWeapon == v then
          local isShow = false
          if __eClassType_ShyWaman ~= getSelfPlayer():getClassType() then
            isShow = awakenWeaponContentsOpen
          end
          slotBG:SetShow(isShow)
          slot.icon:SetEnable(isShow)
          slot.icon:SetShow(isShow)
        end
        slot.icon:addInputEvent("Mouse_On", "Equipment_NilSlot_MouseOn(" .. v .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "Equipment_NilSlot_MouseOn(" .. v .. ",false)")
        if 13 == v then
          slot.icon:SetShow(false)
          slotBG:SetShow(false)
        end
      end
    end
  end
  equip.statExtraParam1Text:SetShow(false)
  equip.statExtraParam1Value:SetShow(false)
  equip.statExtraParam2Text:SetShow(false)
  equip.statExtraParam2Value:SetShow(false)
  equip.statExtraParam3Text:SetShow(false)
  equip.statExtraParam3Value:SetShow(false)
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  local titleSpanSizeY = math.max(0, equip.attackText:GetSpanSize().x)
  local valueSpanSizeY = math.max(equip.attackValue:GetSpanSize().y, 70)
  local isShyWomen = __eClassType_ShyWaman == getSelfPlayer():getClassType() and awakenWeaponContentsOpen
  if not battlePointOpen then
    if awakenWeaponContentsOpen and nil ~= isSetAwakenWeapon then
      equip.awakenText:SetShow(true)
      equip.awakenValue:SetShow(true)
      equip.attackText:SetSpanSize(100, 0)
      equip.attackValue:SetSpanSize(100, 5)
      equip.awakenText:SetSpanSize(100, 0)
      equip.awakenValue:SetSpanSize(100, 0)
      equip.defenceText:SetSpanSize(100, 0)
      equip.defenceValue:SetSpanSize(100, 5)
      if true == isShyWomen then
        equip.awakenText:SetShow(false)
        equip.awakenValue:SetShow(false)
        equip.statExtraParam1Text:SetShow(true)
        equip.statExtraParam1Value:SetShow(true)
        equip.statExtraParam1Text:SetSpanSize(100, 0)
        equip.statExtraParam1Value:SetSpanSize(100, 0)
      end
    else
      equip.awakenText:SetShow(false)
      equip.awakenValue:SetShow(false)
      equip.attackText:SetSpanSize(100, 20)
      equip.attackValue:SetSpanSize(100, 25)
      equip.defenceText:SetSpanSize(100, 20)
      equip.defenceValue:SetSpanSize(100, 25)
    end
  elseif awakenWeaponContentsOpen and nil ~= isSetAwakenWeapon then
    equip.awakenText:SetShow(true)
    equip.awakenValue:SetShow(true)
    equip.attackText:SetSpanSize(186, 0)
    equip.attackValue:SetSpanSize(30, 5)
    equip.awakenText:SetSpanSize(186, 0)
    equip.awakenValue:SetSpanSize(30, 0)
    equip.defenceText:SetSpanSize(186, 0)
    equip.defenceValue:SetSpanSize(30, 5)
    if true == isShyWomen then
      equip.awakenText:SetShow(false)
      equip.awakenValue:SetShow(false)
      equip.statExtraParam1Text:SetShow(true)
      equip.statExtraParam1Value:SetShow(true)
      equip.statExtraParam1Text:SetSpanSize(186, 0)
      equip.statExtraParam1Value:SetSpanSize(30, 0)
    end
  else
    equip.awakenText:SetShow(false)
    equip.awakenValue:SetShow(false)
    equip.attackText:SetSpanSize(186, 20)
    equip.attackValue:SetSpanSize(30, 25)
    equip.defenceText:SetSpanSize(186, 20)
    equip.defenceValue:SetSpanSize(30, 25)
  end
  if self.checkExtendedSlot == 1 then
    for extendSlotNo, parentSlotNo in pairs(self.extendedSlotInfoArray) do
      local itemWrapper = ToClient_getEquipmentItem(parentSlotNo)
      local setSlotBG = self.slotBGs[extendSlotNo]
      slot = self.slots[extendSlotNo]
      setSlotBG:SetShow(false)
      setItemInfoUseWrapper(slot, itemWrapper, true, true)
    end
  end
  if not isContentsEnable then
    self.slotBGs[27]:SetShow(false)
    self.slots[27].icon:SetShow(false)
    alchemyStoneQuickKey:SetShow(false)
  end
  interaction_Forceed()
  ToClient_updateAttackStat()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  _offenceValue = ToClient_getOffence()
  _awakenOffecnValue = ToClient_getAwakenOffence()
  _defenceValue = ToClient_getDefence()
  local battlePointValue = math.floor(selfPlayer:get():getTotalStatValue())
  local bonusBattlePoint = ToClient_GetBonusStatBySupportPoint(ToClient_GetMaxSupportPoint())
  local tier = ToClient_GetTier(battlePointValue)
  self.attackValue:SetText(tostring(_offenceValue))
  self.awakenValue:SetText(tostring(_awakenOffecnValue))
  self.defenceValue:SetText(tostring(_defenceValue))
  self.statExtraParam1Value:SetText(tostring(_awakenOffecnValue))
  setTierIcon(self.battlePointText, "new_ui_common_forlua/default/Default_Etc_04.dds", 8 - tier, 354, 99, 4, 24)
  if bonusBattlePoint > 0 then
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetText("(+" .. bonusBattlePoint .. ")")
    self.BonusBattlePointValue:SetShow(true)
  else
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetShow(false)
  end
  if true == _ContentsGroup_NewUI_Fishing_All then
    if Panel_Global_Manual:GetShow() or PaGlobal_Fishing_All_GetShowPanel() then
      PaGlobal_Fishing_All_UpdateFishingResourceText()
    end
  else
    if Panel_Global_Manual:GetShow() then
      setFishingResourcePool_text()
    end
    if Panel_Fishing:GetShow() then
      setFishingResourcePool_text()
    end
  end
  if nil == ToClient_getEquipmentItem(27) then
    equip.checkBox_AlchemyStone:SetShow(false)
    equip.checkBox_AlchemyStone:SetCheck(false)
    AlchemyStone_CheckEventForSave(false)
  elseif false == _ContentsGroup_NewUI_RepairFunction_All and true == Panel_Window_Repair:GetShow() or true == _ContentsGroup_NewUI_RepairFunction_All and true == Panel_Dialog_Repair_Function_All:GetShow() then
    equip.checkBox_AlchemyStone:SetShow(false)
  else
    equip.checkBox_AlchemyStone:SetShow(true)
  end
  if true == self.isUsedAlchemyStone then
    self.isUsedAlchemyStone = false
    local itemWrapper = ToClient_getEquipmentItem(27)
    if nil ~= itemWrapper and nil ~= itemWrapper and equip.checkBox_AlchemyStone:IsCheck() and 0 < itemWrapper:get():getEndurance() then
      useAlchemyStone()
    end
  end
  if false == ToClient_IsContentsGroupOpen("335") then
    self.slotBGs[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook]:SetShow(false)
    self.slots[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook].icon:SetShow(false)
    self.slots[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook].icon:addInputEvent("Mouse_LUp", "")
  else
    self.slots[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook].icon:addInputEvent("Mouse_LUp", "Input_Equipment_QuestBook()")
  end
  local alchemyStoneQuickKeyString = keyCustom_GetString_UiKey(__eUiInputType_AlchemyStone)
  alchemyStoneQuickKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_QUICKCOMMAND", "keyString", alchemyStoneQuickKeyString))
end
function Input_Equipment_QuestBook()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local itemWrapper = ToClient_getEquipmentItem(CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook)
    if nil ~= itemWrapper and true == questList_isClearQuest(21108, 1) or true == questList_isClearQuest(678, 7) then
      PaGlobalFunc_Achievement_Open()
      InventoryWindow_Close()
    end
  end
end
local _awakenValue = 0
function Equipment_equipItem(slotNo)
  local self = equip
  local slot = self.slots[slotNo]
  if slotNo > 13 and slotNo < 24 then
    slot.icon:AddEffect("UI_ItemInstall_Cash", false, 0, 0)
  else
    slot.icon:AddEffect("UI_ItemInstall", false, 0, 0)
  end
  slot.icon:AddEffect("fUI_SkillButton01", false, 0, 0)
  if slotNo < 14 or 29 == slotNo then
    self.effectBG:AddEffect("UI_ItemInstall_BigRing", false, -0.9, 0)
  else
    self.effectBG:AddEffect("UI_ItemInstall_BigRing02", false, -0.9, 0)
  end
  ToClient_updateAttackStat()
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    if _offenceValue ~= ToClient_getOffence() then
      self.attackValue:AddEffect("fUI_SkillButton01", false, 20, 0)
      self.attackValue:AddEffect("UI_SkillButton01", false, 20, 0)
    end
    if _awakenOffecnValue ~= ToClient_getAwakenOffence() and awakenWeaponContentsOpen then
      self.awakenValue:AddEffect("fUI_SkillButton01", false, 20, 0)
      self.awakenValue:AddEffect("UI_SkillButton01", false, 20, 0)
    end
    if _defenceValue ~= ToClient_getDefence() then
      self.defenceValue:AddEffect("fUI_SkillButton01", false, 20, 0)
      self.defenceValue:AddEffect("UI_SkillButton01", false, 20, 0)
    end
    PaGlobal_TutorialManager:handleEquipItem(slotNo)
  end
  UpdateUnderwearSlotOnEquip(slotNo)
end
function Equipment_onScreenResize()
  if Defines.UIMode.eUIMode_Extraction ~= GetUIMode() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      Panel_Equipment:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Equipment:GetSizeX())
      Panel_Equipment:SetPosY(Panel_Window_Inventory_All:GetPosY())
    else
      Panel_Equipment:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Equipment:GetSizeX())
      Panel_Equipment:SetPosY(Panel_Window_Inventory:GetPosY())
    end
  end
end
function equip:registMessageHandler()
  registerEvent("EventEquipmentUpdate", "Equipment_updateSlotData")
  registerEvent("EventEquipItem", "Equipment_equipItem")
  registerEvent("EventPCEquipSetShow", "Equipment_SetShow")
  registerEvent("onScreenResize", "Equipment_onScreenResize")
  registerEvent("FromClient_FamilySpeicalInfoChange", "FromClient_FamilySpeicalInfoChange_Equipment")
  registerEvent("FromClient_CharacterSpeicalInfoChange", "FromClient_CharacterSpeicalInfoChange_Equipment")
  registerEvent("FromClient_UpdateFamilySkill", "Equipment_updateSlotData")
  registerEvent("FromClient_ChangeUnderwearModeInHouse", "FromClient_ChangeUnderwearMode_Equipment")
  registerEvent("FromClient_ChangeSwimmingSuitShowMode", "FromClient_ChangeSwimmingSuitMode_Equipment")
  registerEvent("FromClient_ChangeWeaponShowMode", "FromClient_ChangeWeaponMode_Equipment")
  registerEvent("FromClient_ShowTotalStatTierChanged", "FGlobal_UpdateTotalStatValue_InEquipment")
end
function Check_Cloak()
  selfPlayerShowCloak(not equip.checkCloak:IsCheck())
end
function Check_Helm()
  selfPlayerShowHelmet(not equip.checkHelm:IsCheck())
end
function Check_HelmOpen()
  selfPlayerShowBattleHelmet(equip.checkHelmOpen:IsCheck())
end
function Check_ShowNameWhenCamouflage()
  Toclient_setShowNameWhenCamouflage(not getSelfPlayer():get():isShowNameWhenCamouflage())
end
function Check_PopUI()
  if equip.checkPopUp:IsCheck() then
    Panel_Equipment:OpenUISubApp()
  else
    Panel_Equipment:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function Check_Underwear()
  local self = equip
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:get():isWearingUnderwear() and false == selfPlayer:get():isWearingSwimmingSuit() then
    self.checkUnderwear:SetCheck(false)
    return
  elseif true == selfPlayer:get():isWearingSwimmingSuit() then
    if false == IsSelfPlayerWaitAction() and false == IsSelfPlayerSwimmingWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SWIMMINGSUIT"))
      self.checkUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if true == isSafeZone or true == IsSelfPlayerSwimmingWaitAction() then
      if true == selfPlayer:get():getSwimmingSuitMode() then
        selfPlayer:get():setSwimmingSuitMode(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setSwimmingSuitMode(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_SWIMMINGSUIT_ALERT"))
      equip.checkUnderwear:SetCheck(self.checkUnderwear:SetCheck(selfPlayer:get():getSwimmingSuitMode()))
    end
  else
    if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_UNDERWEAR"))
      self.checkUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if isSafeZone then
      if selfPlayer:get():getUnderwearModeInhouse() then
        selfPlayer:get():setUnderwearModeInhouse(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setUnderwearModeInhouse(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_UNDERWARE_ALERT"))
      self.checkUnderwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
    end
  end
end
function FGlobal_CheckUnderwear()
  local self = equip
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local isSafeZone = regionInfo:get():isSafeZone()
  if not isSafeZone then
    self.checkUnderwear:SetCheck(false)
  end
end
function Equipment_SimpleToolTips(isShow, btnType, flagControl)
  local self = equip
  if btnType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_DESC")
    uiControl = equip.checkHelm
  elseif btnType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_DESC")
    uiControl = equip.checkHelmOpen
  elseif btnType == 2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_DESC")
    uiControl = equip.btn_PetList
  elseif btnType == 3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_DESC")
    uiControl = equip.btn_ServantInventory
  elseif btnType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DESC")
    uiControl = UI.getChildControl(self.effectBG, equip.avataEquipSlotId[flagControl])
  elseif btnType == 5 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_DESC")
    uiControl = UI.getChildControl(self.effectBG, equip.avataEquipSlotId[flagControl])
  elseif btnType == 6 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_DESC")
    uiControl = equip.checkCloak
  elseif btnType == 7 then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if true == isSwimmingSuitContentEnable and true == selfPlayer:get():isWearingSwimmingSuit() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_DESC")
    end
    uiControl = equip.checkUnderwear
  elseif btnType == 8 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_DESC")
    uiControl = equip.checkCamouflage
  end
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Equipment_StatValueTooltips(isShow, tipType)
  if 3 ~= tipType then
    FGlobal_EquipmentEffectTooltip(isShow)
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local self = equip
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = self.attackText
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_DEFENCE_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_DV") .. " " .. tostring(ToClient_getDv()) .. [[
<PAOldColor>
<PAColor0xffe7d583>]] .. PAGetString(Defines.StringSheet_RESOURCE, "TOOLTIP_ITEM_TXT_PV") .. " " .. tostring(ToClient_getPv()) .. "<PAOldColor>"
    control = self.defenceText
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TOOLTIP_AWAKEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AWAKEN_TEXT_TOOLTIP_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = self.awakenText
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_BONUS_TOTALSTAT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BONUS_TOTALSTAT_DESC")
    control = self.BonusBattlePointValue
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT1_DESC") .. [[

<PAColor0xffe7d583>- ]] .. PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT") .. " : " .. tostring(ToClient_getHit()) .. "<PAOldColor>"
    control = self.statExtraParam1Text
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT2_DESC")
    control = self.statExtraParam2Text
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT3_DESC")
    control = self.statExtraParam3Text
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleClicked_ServantInventoryOpen()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isFreeBattle = selfPlayer:get():isBattleGroundDefine()
  if GetUIMode() == Defines.UIMode.eUIMode_Repair then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_REPAIRMODENOOPENINVENTORY"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_OPEN_SERVENTINVENTORY"))
    return
  end
  if true == isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_NOT_USE"))
    return
  end
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_CampWarehouse_All_CloseWareHouseOnly()
  end
  ServantInventory_OpenAll()
  Panel_Window_ServantInventory:SetPosX(Panel_Equipment:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 5)
  Panel_Window_ServantInventory:SetPosY(Panel_Equipment:GetPosY())
end
function FromClient_ChangeUnderwearMode_Equipment(isUnderwearModeInHouse)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  equip.checkUnderwear:SetCheck(isUnderwearModeInHouse)
end
function FromClient_ChangeSwimmingSuitMode_Equipment(isShowSwimmingSuit)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  equip.checkUnderwear:SetCheck(isShowSwimmingSuit)
end
function FromClient_ChangeWeaponMode_Equipment(isShowWeapon)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  equip.check_subWeapon:SetCheck(isShowSwimmingSuit)
end
function FromClient_FamilySpeicalInfoChange_Equipment()
  if false == Panel_Equipment:GetShow() then
    return
  end
  Equipment_updateSlotData()
end
function FromClient_CharacterSpeicalInfoChange_Equipment()
  if false == Panel_Equipment:GetShow() then
    return
  end
  Equipment_updateSlotData()
end
function FGlobal_AlchemyStonCheck()
  if not equip.checkBox_AlchemyStone:IsCheck() then
    return 0
  end
  local coolTime = PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()
  if coolTime > -1 then
    return coolTime + 3
  end
  coolTime = 0
  local itemWrapper = ToClient_getEquipmentItem(27)
  if nil ~= itemWrapper then
    local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
    if 0 == alchemyStoneType or 3 == alchemyStoneType then
      coolTime = 302
    elseif 1 == alchemyStoneType or 4 == alchemyStoneType then
      coolTime = 302
    elseif 2 == alchemyStoneType or 5 == alchemyStoneType then
      coolTime = 602
    elseif 6 == alchemyStoneType or 7 == alchemyStoneType then
      coolTime = 302
    end
  end
  return coolTime
end
function FGlobal_AccSlotNo(itemWrapper, isChange)
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  local firstRingOffence = 0
  local firstRingDeffence = 0
  local secondRingOffence = 0
  local secondRingDeffence = 0
  local acc
  if 16 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(8)
    equipItemWrapper2 = ToClient_getEquipmentItem(9)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 8 + equip.slotRingIndex
      if isChange then
        if 0 == equip.slotRingIndex then
          equip.slotRingIndex = 1
        else
          equip.slotRingIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      equip.slotRingIndex = 0
      acc = 8
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      equip.slotRingIndex = 0
      acc = 9
    else
      equip.slotRingIndex = 0
      acc = 8
    end
  elseif 17 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(10)
    equipItemWrapper2 = ToClient_getEquipmentItem(11)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 10 + equip.slotEaringIndex
      if isChange then
        if 0 == equip.slotEaringIndex then
          equip.slotEaringIndex = 1
        else
          equip.slotEaringIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = 10
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = 11
    else
      acc = 10
    end
  end
  return acc
end
local posXDefault = 345
function Equipment_RePosition()
  local self = equip
  if self.checkCloak:GetShow() then
    self.checkCloak:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.checkHelm:GetShow() then
    self.checkHelm:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.checkHelmOpen:GetShow() then
    self.checkHelmOpen:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.btn_PetList:GetShow() then
    self.btn_PetList:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.checkUnderwear:GetShow() then
    self.checkUnderwear:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.checkCamouflage:GetShow() then
    self.checkCamouflage:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
  if self.btn_ServantInventory:GetShow() then
    self.btn_ServantInventory:SetPosX(posXDefault)
    posXDefault = posXDefault - 30
  end
end
function HideUnderwearSlotItemModes()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  selfPlayer:get():setUnderwearModeInhouse(false)
  selfPlayer:get():setSwimmingSuitMode(false)
  Toclient_setShowAvatarEquip()
  equip.checkUnderwear:SetCheck(false)
end
function UpdateUnderwearSlotOnEquip(slotNo)
  if CppEnums.EquipSlotNoClient.eEquipSlotNoAvatarUnderwear ~= slotNo then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:get():isWearingUnderwear() then
    if true == selfPlayer:get():getSwimmingSuitMode() then
      selfPlayer:get():setSwimmingSuitMode(false)
      equip.checkUnderwear:SetCheck(false)
    end
  elseif true == selfPlayer:get():isWearingSwimmingSuit() and true == selfPlayer:get():getUnderwearModeInhouse() then
    selfPlayer:get():setUnderwearModeInhouse(false)
    equip.checkUnderwear:SetCheck(false)
  end
end
function Equipment__PopUp_ShowIconToolTip(isShow)
  if isShow then
    local self = equip
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if self.checkPopUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(self.checkPopUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FGlobal_Equipment_Init()
  equip:initControl()
  equip:registEventHandler()
  equip:registMessageHandler()
end
function FGlobal_UpdateTotalStatValue_InEquipment(actorKeyRaw)
  if false == Panel_Equipment:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:get():getActorKeyRaw() ~= actorKeyRaw then
    return
  end
  local self = equip
  local battlePointValue = math.floor(selfPlayer:get():getTotalStatValue())
  local bonusBattlePoint = ToClient_GetBonusStatBySupportPoint(ToClient_GetMaxSupportPoint())
  if bonusBattlePoint > 0 then
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetText("(+" .. bonusBattlePoint .. ")")
    self.BonusBattlePointValue:SetShow(true)
  else
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetShow(false)
  end
end
function PaGlobalFunc_Equipment_IsReuseTime(deltaTime)
  if 3 <= equip.reuseAlchemyStoneCheckTime then
    equip.reuseAlchemyStoneCheckTime = 0
    return true
  end
  equip.reuseAlchemyStoneCheckTime = equip.reuseAlchemyStoneCheckTime + deltaTime
  return false
end
function PaGlobal_Equipment_DirectPanelShow(isShow, isAni)
  if true == Panel_Equipment:IsUISubApp() then
    return
  end
  if false == isShow then
    Panel_Equipment:SetShow(false, isAni)
    return
  end
  Panel_Equipment:SetShow(true, isAni)
  Equipment_updateSlotData()
end
function PaGlobalFunc_Equipment_UseAlchemyStoneCheck(flag)
  equip.isUsedAlchemyStone = flag
end
registerEvent("FromClient_luaLoadComplete", "FGlobal_Equipment_Init")
