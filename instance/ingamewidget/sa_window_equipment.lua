Instance_Window_Equipment:SetShow(false, false)
Instance_Window_Equipment:ActiveMouseEventEffect(true)
Instance_Window_Equipment:setMaskingChild(true)
Instance_Window_Equipment:setGlassBackground(true)
Instance_Window_Equipment:RegisterShowEventFunc(true, "EquipmentWindow_ShowAni()")
Instance_Window_Equipment:RegisterShowEventFunc(false, "EquipmentWindow_HideAni()")
local EquipNoMin = CppEnums.EquipSlotNo.rightHand
local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
local UnUsedEquipNo_01 = 100
local UnUsedEquipNo_02 = 101
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local CT = CppEnums.ClassType
local UI_TM = CppEnums.TextMode
local isContentsEnable = ToClient_IsContentsGroupOpen("35")
local isKR2ContentsEnable = isGameTypeKR2()
local isSwimmingSuitContentEnable = true
local awakenWeapon = {
  [CT.ClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
  [CT.ClassType_Ranger] = ToClient_IsContentsGroupOpen("902"),
  [CT.ClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
  [CT.ClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
  [CT.ClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
  [CT.ClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
  [CT.ClassType_BladeMasterWomen] = ToClient_IsContentsGroupOpen("907"),
  [CT.ClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
  [CT.ClassType_Wizard] = ToClient_IsContentsGroupOpen("909"),
  [CT.ClassType_WizardWomen] = ToClient_IsContentsGroupOpen("910"),
  [CT.ClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
  [CT.ClassType_NinjaWomen] = ToClient_IsContentsGroupOpen("912"),
  [CT.ClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
  [CT.ClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
  [CT.ClassType_CombattantWomen] = ToClient_IsContentsGroupOpen("918"),
  [CT.ClassType_Lahn] = ToClient_IsContentsGroupOpen("916"),
  [CT.ClassType_Orange] = ToClient_IsContentsGroupOpen("943"),
  [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366")
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
    [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
    [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [11] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [12] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [13] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_LANTERN"),
    [14] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
    [15] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
    [16] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
    [17] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
    [18] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
    [19] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
    [20] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
    [22] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_EYES"),
    [23] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MOUSE"),
    [21] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HEAD"),
    [27] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [30] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon"),
    [31] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_QUESTBOOK")
  },
  slots = Array.new(),
  slotBGs = Array.new(),
  avataSlots = Array.new(),
  defaultSlots = Array.new(),
  txt_Title = UI.getChildControl(Instance_Window_Equipment, "StaticText_Title"),
  bottom_ButtonArea = UI.getChildControl(Instance_Window_Equipment, "Static_BottomButtonArea"),
  bottom_AbilityArea = UI.getChildControl(Instance_Window_Equipment, "Static_AbilityArea"),
  buttonClose = nil,
  enchantText = UI.getChildControl(Instance_Window_Equipment, "Static_Text_Slot_Enchant_value"),
  effectBG = UI.getChildControl(Instance_Window_Equipment, "Static_Circle"),
  checkPopUp = nil,
  iconSetItemTooltip = UI.getChildControl(Instance_Window_Equipment, "StaticText_SetEffect"),
  extendedSlotInfoArray = {},
  checkExtendedSlot = 0,
  checkBox_AlchemyStone = UI.getChildControl(Instance_Window_Equipment, "CheckBox_AlchemyStone"),
  slotRingIndex = 0,
  slotEaringIndex = 0,
  reuseAlchemyStoneCheckTime = 0,
  _isDeadPlayer = false
}
local alchemyStoneQuickKey = UI.getChildControl(Instance_Window_Equipment, "Static_Slot_AlchemyStone_Key")
local isAlchemyStoneCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
equip.checkBox_AlchemyStone:SetCheck(isAlchemyStoneCheck)
equip.checkBox_AlchemyStone:addInputEvent("Mouse_LUp", "AlchemyStone_CheckEventForSave()")
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
function equip_checkUseableSlot(index)
  local returnValue = true
  if index == UnUsedEquipNo_01 or index == nUsedEquipNo_02 or index == CppEnums.EquipSlotNo.equipSlotNoCount or index == CppEnums.EquipSlotNo.explorationBonus0 or index == CppEnums.EquipSlotNo.installation4 or index == CppEnums.EquipSlotNo.body or index == CppEnums.EquipSlotNo.avatarBody then
    returnValue = false
  end
  return returnValue
end
function equip:initControl()
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
      local slot = {}
      slot.icon = UI.getChildControl(self.effectBG, self.slotNoId[v])
      slot.icon:SetPosX(slotBG:GetPosX() + 4)
      slot.icon:SetPosY(slotBG:GetPosY() - 4)
      SlotItem.new(slot, "Equipment_" .. v, v, Instance_Window_Equipment, self.slotConfig)
      slot:createChild()
      slot.icon:addInputEvent("Mouse_RUp", "Equipment_RClick(" .. v .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "Equipment_LClick(" .. v .. ")")
      slot.icon:addInputEvent("Mouse_On", "Equipment_MouseOn(" .. v .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "Equipment_MouseOn(" .. v .. ",false)")
      self.slots[v] = slot
      if nil ~= self.avataEquipSlotId[v] then
        self.avataSlots[v] = UI.getChildControl(self.effectBG, self.avataEquipSlotId[v])
        self.avataSlots[v]:SetShow(true)
        self.avataSlots[v]:SetPosX(slot.icon:GetSpanSize().x + slot.icon:GetSizeX() - 15)
        self.avataSlots[v]:SetPosY(slot.icon:GetSpanSize().y + slot.icon:GetSizeY() - 15)
        self.avataSlots[v]:addInputEvent("Mouse_LUp", "AvatarEquipSlot_LClick(" .. v .. ")")
        if 30 == v and nil ~= awakenWeaponContentsOpen then
          self.avataSlots[v]:SetShow(awakenWeaponContentsOpen)
        end
      end
      if nil ~= self.equipSlotId[v] then
        self.defaultSlots[v] = UI.getChildControl(self.effectBG, self.equipSlotId[v])
        self.defaultSlots[v]:SetShow(false)
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
  self.attackText:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self.defenceText:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self.awakenText:SetTextMode(UI_TM.eTextMode_AutoWrap)
  self.attackText:SetText(self.attackText:GetText())
  self.defenceText:SetText(self.defenceText:GetText())
  self.awakenText:SetText(self.awakenText:GetText())
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
  Equipment_onScreenResize()
end
function HandleClicked_EquipmentWindow_Close()
  audioPostEvent_SystemUi(1, 1)
  equip.checkPopUp:SetCheck(false)
  Instance_Window_Equipment:CloseUISubApp()
  EquipmentWindow_Close()
end
function EquipmentWindow_Close()
  if Instance_Window_Equipment:IsUISubApp() then
    return
  end
  if Instance_Window_Equipment:IsShow() then
    Instance_Window_Equipment:SetShow(false, false)
    if ToClient_IsSavedUi() then
      ToClient_SaveUiInfo(false)
      ToClient_SetSavedUi(false)
    end
  end
  equip.slotRingIndex = 0
  equip.slotEaringIndex = 0
end
function EquipmentWindow_ShowAni()
  UIAni.fadeInSCR_Left(Instance_Window_Equipment)
  local aniInfo1 = Instance_Window_Equipment:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Instance_Window_Equipment:GetSizeX() / 2
  aniInfo1.AxisY = Instance_Window_Equipment:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Instance_Window_Equipment:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Instance_Window_Equipment:GetSizeX() / 2
  aniInfo2.AxisY = Instance_Window_Equipment:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function EquipmentWindow_HideAni()
  Instance_Window_Equipment:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Instance_Window_Equipment:addColorAnimation(0, 0.1, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function Equipment_MouseOn(slotNo, isOn)
end
function Equipment_NilSlot_MouseOn(slotNo, isOn)
  local self = equip
  if true == isOn then
  else
  end
end
local _offenceValue, _awakenOffecnValue, _defenceValue
function Equipment_RClick(slotNo)
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    if CppEnums.EquipSlotNoClient.eEquipSlotNoAvatarUnderwear == slotNo then
      HideUnderwearSlotItemModes()
    end
    equipmentDoUnequip(slotNo)
  end
end
function Equipment_LClick(slotNo)
  if DragManager.dragStartPanel == Instance_Window_Inventory then
    local dragSlotNo = DragManager.dragSlotInfo
    local itemWrapper = getInventoryItem(dragSlotNo)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus()
      if itemStatic:isEquipable() then
        Inventory_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
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
  equipMentPosX = Instance_Window_Equipment:GetPosX()
  equipMentPosY = Instance_Window_Equipment:GetPosY()
end
function Equipment_PosLoadMemory()
  Instance_Window_Equipment:SetPosX(equipMentPosX)
  Instance_Window_Equipment:SetPosY(equipMentPosY)
end
function Equipment_SetShow(isShow)
  local self = equip
  if true == isShow then
    if true == self._isDeadPlayer then
      return
    end
    Instance_Window_Equipment:SetShow(true, true)
  else
    if Instance_Window_Equipment:IsUISubApp() then
      return
    end
    Instance_Window_Equipment:SetShow(false, false)
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
  if isKR2ContentsEnable or false == ToClient_isAdultUser() then
    equip.checkUnderwear:SetShow(false)
  else
    equip.checkUnderwear:SetShow(isShow)
  end
  equip.checkCamouflage:SetShow(isShow)
  equip.btn_ServantInventory:SetShow(isShow)
  equip.checkBox_AlchemyStone:SetShow(isShow)
end
function equip:registEventHandler()
  self.buttonClose:addInputEvent("Mouse_LUp", "HandleClicked_EquipmentWindow_Close()")
  self.checkCloak:addInputEvent("Mouse_LUp", "Check_Cloak()")
  self.checkHelm:addInputEvent("Mouse_LUp", "Check_Helm()")
  self.checkHelmOpen:addInputEvent("Mouse_LUp", "Check_HelmOpen()")
  self.checkUnderwear:addInputEvent("Mouse_LUp", "Check_Underwear()")
  self.checkCamouflage:addInputEvent("Mouse_LUp", "Check_ShowNameWhenCamouflage()")
  self.checkPopUp:addInputEvent("Mouse_LUp", "Check_PopUI()")
  self.btn_PetList:addInputEvent("Mouse_LUp", "FGlobal_PetListNew_Toggle()")
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
  if not Instance_Window_Equipment:GetShow() then
    return
  end
  local self = equip
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
        if nil ~= awakenWeaponContentsOpen and (CppEnums.EquipSlotNo.awakenWeapon == v or CppEnums.EquipSlotNo.avatarAwakenWeapon == v) then
          slotBG:SetShow(awakenWeaponContentsOpen)
          slot.icon:SetEnable(awakenWeaponContentsOpen)
          slot.icon:SetShow(awakenWeaponContentsOpen)
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
  local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
  local titleSpanSizeY = math.max(0, equip.attackText:GetSpanSize().x)
  local valueSpanSizeY = math.max(equip.attackValue:GetSpanSize().y, 70)
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
  local currentPlayerCount = ToClient_BattleRoyaleRemainPlayerCount()
  local blackSpiritLevel = 0
  local plusOffenceValue = 0
  local plusDefenceValue = 0
  if currentPlayerCount >= 1 then
    blackSpiritLevel = ToClient_GetBattleRoyaleGrowthLevel(currentPlayerCount)
    plusOffenceValue = ToClient_GetBattleRoyaleGrowthDD(blackSpiritLevel)
    plusDefenceValue = ToClient_GetBattleRoyaleGrowthPV(blackSpiritLevel)
  end
  if plusOffenceValue > 0 then
    self.attackValue:SetText(tostring(_offenceValue) .. " +" .. plusOffenceValue)
    self.awakenValue:SetText(tostring(_awakenOffecnValue) .. " +" .. plusOffenceValue)
  else
    self.attackValue:SetText(tostring(_offenceValue))
    self.awakenValue:SetText(tostring(_awakenOffecnValue))
  end
  if plusDefenceValue > 0 then
    self.defenceValue:SetText(tostring(_defenceValue) .. " +" .. plusDefenceValue)
  else
    self.defenceValue:SetText(tostring(_defenceValue))
  end
  setTierIcon(self.battlePointText, "new_ui_common_forlua/default/Default_Etc_04.dds", 8 - tier, 354, 99, 4, 24)
  if bonusBattlePoint > 0 then
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetText("(+" .. bonusBattlePoint .. ")")
    self.BonusBattlePointValue:SetShow(true)
  else
    self.BattlePointValue:SetText(tostring(battlePointValue))
    self.BonusBattlePointValue:SetShow(false)
  end
  if nil == ToClient_getEquipmentItem(27) then
    equip.checkBox_AlchemyStone:SetShow(false)
    equip.checkBox_AlchemyStone:SetCheck(false)
    AlchemyStone_CheckEventForSave(false)
  else
    equip.checkBox_AlchemyStone:SetShow(true)
  end
  if false == ToClient_IsContentsGroupOpen("335") then
    self.slotBGs[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook]:SetShow(false)
    self.slots[CppEnums.EquipSlotNoClient.eEquipSlotNoQuestBook].icon:SetShow(false)
  end
  local alchemyStoneQuickKeyString = keyCustom_GetString_UiKey(__eUiInputType_AlchemyStone)
  alchemyStoneQuickKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_QUICKCOMMAND", "keyString", alchemyStoneQuickKeyString))
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
  end
  UpdateUnderwearSlotOnEquip(slotNo)
end
function Equipment_onScreenResize()
  if Defines.UIMode.eUIMode_Extraction ~= GetUIMode() then
    Instance_Window_Equipment:SetPosX(Instance_Window_Inventory:GetPosX() - Instance_Window_Equipment:GetSizeX())
    Instance_Window_Equipment:SetPosY(Instance_Window_Inventory:GetPosY())
  end
end
function equip:registMessageHandler()
  registerEvent("EventEquipmentUpdate", "Equipment_updateSlotData")
  registerEvent("EventEquipItem", "Equipment_equipItem")
  registerEvent("EventPCEquipSetShow", "Equipment_SetShow")
  registerEvent("onScreenResize", "Equipment_onScreenResize")
  registerEvent("FromClient_FamilySpeicalInfoChange", "FromClient_FamilySpeicalInfoChange_Equipment")
  registerEvent("FromClient_CharacterSpeicalInfoChange", "FromClient_CharacterSpeicalInfoChange_Equipment")
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
    Instance_Window_Equipment:OpenUISubApp()
  else
    Instance_Window_Equipment:CloseUISubApp()
  end
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
end
function Equipment_StatValueTooltips(isShow, tipType)
  if not isShow then
  end
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
  ServantInventory_OpenAll()
  Panel_Window_ServantInventory:SetPosX(Instance_Window_Equipment:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 5)
  Panel_Window_ServantInventory:SetPosY(Instance_Window_Equipment:GetPosY())
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
function FromClient_FamilySpeicalInfoChange_Equipment()
  if false == Instance_Window_Equipment:GetShow() then
    return
  end
  Equipment_updateSlotData()
end
function FromClient_CharacterSpeicalInfoChange_Equipment()
  if false == Instance_Window_Equipment:GetShow() then
    return
  end
  Equipment_updateSlotData()
end
function FGlobal_AlchemyStonCheck()
  if not equip.checkBox_AlchemyStone:IsCheck() then
    return 0
  end
  local coolTime = PaGlobal_SA_MainFrame:getAlchemyStoneBuff_RemainTime()
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
    elseif 6 == alchemyStoneType then
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
function Equipment_GetEquip()
  return equip
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
end
function EquipMent_BulletCheck()
  local itemWrapper = ToClient_getEquipmentItem(1)
  if nil == itemWrapper then
    return PAGetString(Defines.StringSheet_GAME, "LUA_BULLETALERT_0")
  else
    local itemSSW = itemWrapper:getStaticStatus()
    local equipType = itemSSW:getEquipType()
    if 68 == equipType then
      local endurance = itemWrapper:get():getEndurance()
      if 0 == endurance then
        return PAGetString(Defines.StringSheet_GAME, "LUA_BULLETALERT_1")
      else
        return ""
      end
    else
      return PAGetString(Defines.StringSheet_GAME, "LUA_BULLETALERT_2")
    end
  end
end
function FGlobal_Equipment_Init()
  equip:initControl()
  equip:registEventHandler()
  equip:registMessageHandler()
end
function FGlobal_UpdateTotalStatValue_InEquipment(actorKeyRaw)
  if false == Instance_Window_Equipment:GetShow() then
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
function FromClient_Equipment_EventSelfPlayerDead()
  local self = equip
  self._isDeadPlayer = true
end
registerEvent("FromClient_luaLoadComplete", "FGlobal_Equipment_Init")
registerEvent("FromClient_ChangeUnderwearModeInHouse", "FromClient_ChangeUnderwearMode_Equipment")
registerEvent("FromClient_ChangeSwimmingSuitShowMode", "FromClient_ChangeSwimmingSuitMode_Equipment")
registerEvent("FromClient_ShowTotalStatTierChanged", "FGlobal_UpdateTotalStatValue_InEquipment")
registerEvent("EventSelfPlayerDead", "FromClient_Equipment_EventSelfPlayerDead")
registerEvent("FromClient_ChangeBattleRoyalePlayerCount", "Equipment_updateSlotData")
