PaGlobal_ConsoleQuickMenuSetting = {
  _inventoryData = {},
  _skillData = {},
  _functionTypeData = {},
  _socialActionData = {},
  _guildSkillData = {},
  _ui = {
    _staticIcon = {},
    _staticTextName = {},
    _buttonPosition = {},
    _buttonPositionIcon = {},
    _buttonPositionRemoveIcon = {},
    _buttonPositionSlot = {},
    _registerModeSelectItem = nil,
    _registerModeSelectItemIcon = nil,
    _registerModeSelectItemSlot = nil,
    _rightBg = UI.getChildControl(Panel_QuickMenuCustom, "Static_RightBg"),
    _list2Skill,
    _list2Menu,
    _frameItem,
    _list2SocialAction,
    _list2GuildSkill,
    _slots = {},
    _static_BottomBg = UI.getChildControl(Panel_QuickMenuCustom, "Static_BottomBg"),
    _staticText_Select = nil,
    _staticText_Exit = nil,
    _staticText_Detail = nil,
    _ringBg = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_RingBg"),
    _oneSlotBg = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_OneSlotBg"),
    _ringCrossHair = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_CrossHair"),
    _crossHairText = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "StaticText_CrossText"),
    _registerModeBlackBg = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_BlackBg"),
    _RSGuideBg = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_GuideBg")
  },
  _registMode = {
    _isStart = false,
    _isRemoveStart = false,
    _stickPosition = __eQuickMenuStickPosition_Count,
    _index = -1
  },
  _listMaxCount = 8,
  _curPosition = 1,
  _curPage = 1,
  _curGroup = __eQuickMenuDpadGroup_Count,
  _curCategory = 0,
  _startColumn = 0,
  _curItemIndex = 0,
  _isRegisterQuickMenu = false
}
function PaGlobal_ConsoleQuickMenuSetting:GoCategory(category)
  self._ui._list2Skill:SetShow(false)
  self._ui._list2Menu:SetShow(false)
  self._ui._bgItem:SetShow(false)
  self._ui._list2SocialAction:SetShow(false)
  self._ui._list2GuildSkill:SetShow(false)
  if __eQuickMenuDataType_Skill == category then
    self._ui._list2Skill:SetShow(true)
  elseif __eQuickMenuDataType_Item == category then
    self._ui._bgItem:SetShow(true)
  elseif __eQuickMenuDataType_Function == category then
    self._ui._list2Menu:SetShow(true)
  elseif __eQuickMenuDataType_SocialAction == category then
    self._ui._list2SocialAction:SetShow(true)
  elseif __eQuickMenuDataType_GuildSkill == category then
    self._ui._list2GuildSkill:SetShow(true)
  end
  PaGlobal_ConsoleQuickMenuCustom_HighlightCategory(category)
end
function PaGlobal_ConsoleQuickMenuSetting:initializeUI()
  self._ui._staticText_Select = UI.getChildControl(self._ui._static_BottomBg, "StaticText_Select")
  self._ui._staticText_Exit = UI.getChildControl(self._ui._static_BottomBg, "StaticText_Exit")
  self._ui._staticText_Detail = UI.getChildControl(self._ui._static_BottomBg, "StaticText_Detail")
  local param = {
    createIcon = true,
    createCount = true,
    createBagIcon = true,
    createFamilyInvenotry = true
  }
  for ii = 0, __eQuickMenuStickPosition_Count - 1 do
    self._ui._buttonPosition[ii] = UI.getChildControl(self._ui._ringBg, "Button_Templete" .. tostring(ii))
    self._ui._buttonPosition[ii]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:quitRegistQuickMenu( " .. ii .. ")")
    self._ui._buttonPositionIcon[ii] = UI.getChildControl(self._ui._buttonPosition[ii], "Static_Icon")
    self._ui._buttonPositionSlot[ii] = {}
    SlotItem.new(self._ui._buttonPositionSlot[ii], "ButtonPosition_Slot_" .. ii, ii, self._ui._buttonPosition[ii], param)
    self._ui._buttonPositionSlot[ii].icon:SetSize(self._ui._buttonPositionIcon[ii]:GetSizeX(), self._ui._buttonPositionIcon[ii]:GetSizeY())
    self._ui._buttonPositionSlot[ii].icon:SetPosX(self._ui._buttonPositionIcon[ii]:GetPosX())
    self._ui._buttonPositionSlot[ii].icon:SetPosY(self._ui._buttonPositionIcon[ii]:GetPosY())
    self._ui._buttonPositionSlot[ii]:createChild()
    self._ui._buttonPositionRemoveIcon[ii] = UI.getChildControl(self._ui._buttonPosition[ii], "Static_MinusIcon")
  end
  self._ui._registerModeSelectItem = UI.getChildControl(self._ui._ringBg, "StaticText_SelectMenu")
  self._ui._registerModeSelectItemIcon = UI.getChildControl(self._ui._registerModeSelectItem, "Static_Icon")
  self._ui._registerModeSelectItemSlot = {}
  SlotItem.new(self._ui._registerModeSelectItemSlot, "StaticText_SelectMenu_Slot" .. 0, 0, self._ui._registerModeSelectItem, param)
  self._ui._registerModeSelectItemSlot.icon:SetSize(self._ui._registerModeSelectItemIcon:GetSizeX(), self._ui._registerModeSelectItemIcon:GetSizeY())
  self._ui._registerModeSelectItemSlot.icon:SetPosX(self._ui._registerModeSelectItemIcon:GetPosX())
  self._ui._registerModeSelectItemSlot.icon:SetPosY(self._ui._registerModeSelectItemIcon:GetPosY())
  self._ui._registerModeSelectItemSlot:createChild()
  self._ui._changeSlot = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "StaticText_ChangeSlot")
  if true == ToClient_isPS4() then
    self._ui._stc_LTGuide = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_LT_PS")
  else
    self._ui._stc_LTGuide = UI.getChildControl(Panel_QuickMenuCustom_RightRing, "Static_LT_XB")
  end
  local tabBg = UI.getChildControl(Panel_QuickMenuCustom, "Static_TabBg")
  local stc_LBIcon = UI.getChildControl(tabBg, "Static_LB_ConsoleUI")
  local stc_RBIcon = UI.getChildControl(tabBg, "Static_RB_ConsoleUI")
  local tab_Menus = {}
  tab_Menus[0] = UI.getChildControl(tabBg, "RadioButton_Item")
  tab_Menus[0]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:GoCategory(" .. __eQuickMenuDataType_Item .. ")")
  tab_Menus[1] = UI.getChildControl(tabBg, "RadioButton_Skill")
  tab_Menus[1]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:GoCategory(" .. __eQuickMenuDataType_Skill .. ")")
  tab_Menus[2] = UI.getChildControl(tabBg, "RadioButton_Menu")
  tab_Menus[2]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:GoCategory(" .. __eQuickMenuDataType_Function .. ")")
  tab_Menus[3] = UI.getChildControl(tabBg, "RadioButton_Social")
  tab_Menus[3]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:GoCategory(" .. __eQuickMenuDataType_SocialAction .. ")")
  tab_Menus[4] = UI.getChildControl(tabBg, "RadioButton_GuildSkill")
  tab_Menus[4]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:GoCategory(" .. __eQuickMenuDataType_GuildSkill .. ")")
  local menuCount = 4
  local startPosX = stc_LBIcon:GetPosX() + stc_LBIcon:GetSizeX()
  local totalSizeX = stc_RBIcon:GetPosX() - startPosX
  local totalTextSizeX = 0
  for i = 0, menuCount do
    local textSizeX = tab_Menus[i]:GetTextSizeX()
    tab_Menus[i]:SetSize(textSizeX, tab_Menus[i]:GetSizeY())
    tab_Menus[i]:SetTextHorizonLeft()
    totalTextSizeX = totalTextSizeX + textSizeX
  end
  local gapSizeX = (totalSizeX - totalTextSizeX) / 5 - 10
  for i = 0, menuCount do
    tab_Menus[i]:SetPosX(startPosX + gapSizeX)
    startPosX = startPosX + tab_Menus[i]:GetSizeX() + gapSizeX
  end
  self._ui._list2Skill = UI.getChildControl(self._ui._rightBg, "List2_Skillt")
  self._ui._list2Menu = UI.getChildControl(self._ui._rightBg, "List2_Menu")
  self._ui._bgItem = UI.getChildControl(self._ui._rightBg, "Static_ItemMenuBg")
  self._ui._scrollItem = UI.getChildControl(self._ui._bgItem, "Scroll_Inventory")
  self._ui._bgItemTemplate = UI.getChildControl(self._ui._bgItem, "Static_ItemSlotBg_Template")
  self._ui._list2SocialAction = UI.getChildControl(self._ui._rightBg, "List2_SocialAction")
  self._ui._list2GuildSkill = UI.getChildControl(self._ui._rightBg, "List2_GuildSkill")
  self._ui._list2Skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "QuickMenuSeting_List2Event_SKill")
  self._ui._list2Menu:registEvent(__ePAUIList2EventType_LuaChangeContent, "QuickMenuSeting_List2Event_Menu")
  self._ui._list2SocialAction:registEvent(__ePAUIList2EventType_LuaChangeContent, "QuickMenuSeting_List2Event_SocialAction")
  self._ui._list2GuildSkill:registEvent(__ePAUIList2EventType_LuaChangeContent, "QuickMenuSeting_List2Event_GuildSkill")
  self._ui._list2Skill:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2Menu:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2SocialAction:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2GuildSkill:createChildContent(__ePAUIList2ElementManagerType_List)
  local rowMax = 8
  local colMax = 9
  local row = 0
  local col = 0
  local offset = 54
  local bgs = {}
  for index = 1, rowMax * colMax do
    local bg = UI.createAndCopyBasePropertyControl(self._ui._bgItem, "Static_ItemSlotBg_Template", self._ui._bgItem, "Item_" .. index)
    bg:SetPosX(row * offset)
    bg:SetPosY(col * offset)
    if row < rowMax - 1 then
      row = row + 1
    else
      row = 0
      col = col + 1
    end
    bgs[#bgs + 1] = bg
  end
  for index = 1, rowMax * colMax do
    local slot = {}
    local param = {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createEnchant = true,
      createClassEquipBG = true,
      createEnduranceIcon = true,
      createCash = true,
      createBagIcon = true,
      createFamilyInvenotry = true
    }
    local item = SlotItem.new(slot, index, 0, bgs[index], param)
    item:createChild()
    UIScroll.InputEventByControl(bgs[index], "PaGlobal_ConsoleQuickMenuSetting_scrollInventory")
    UIScroll.InputEventByControl(item.icon, "PaGlobal_ConsoleQuickMenuSetting_scrollInventory")
    if index < colMax then
      bgs[index]:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_ConsoleQuickMenuSetting_scrollInventory(true)")
    elseif index > colMax * (rowMax - 1) then
      bgs[index]:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_ConsoleQuickMenuSetting_scrollInventory(false)")
    end
    self._ui._slots[index] = item
  end
  self._ui._ringBg:SetShow(true)
  self._ui._oneSlotBg:SetShow(false)
  self._ui._RSGuideText = UI.getChildControl(self._ui._RSGuideBg, "StaticText_GuideText")
  self._ui._RSGuideText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._RSGuideText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX_RINGMENUSETTING_RSKEYGUIDE"))
end
function PaGlobal_ConsoleQuickMenuSetting:showSelectKeyGuideA(show, index)
  if nil == show then
    show = false
  end
  self._curItemIndex = index
  self._ui._staticText_Select:SetShow(show)
end
function PaGlobal_ConsoleQuickMenuSetting:setAlignKeyGuide()
  local keyGuides = {
    self._ui._staticText_Select,
    self._ui._staticText_Detail,
    self._ui._staticText_Exit
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._static_BottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_LEFT)
end
function PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(type, index)
  if self:isRegisterOrRemoveMode() then
    return
  end
  self._registMode._isStart = true
  self._registMode._stickPosition = __eQuickMenuStickPosition_Count
  local data
  if __eQuickMenuDataType_Item == type then
    data = self._inventoryData[index]
  elseif __eQuickMenuDataType_Skill == type then
    data = self._skillData[index]
  elseif __eQuickMenuDataType_Function == type then
    data = self._functionTypeData[index]
  elseif __eQuickMenuDataType_SocialAction == type then
    data = self._socialActionData[index]
  elseif __eQuickMenuDataType_GuildSkill == type then
    data = self._guildSkillData[index]
  end
  self._registMode._settingData = data
  self:ShowBlackBg(true, data)
end
function PaGlobal_ConsoleQuickMenuSetting:startRegistRemoveQuickMenu()
  if self:isRegisterOrRemoveMode() then
    return
  end
  self._registMode._isStart = false
  self._registMode._isRemoveStart = true
  self._registMode._stickPosition = __eQuickMenuStickPosition_Count
  self._registMode._settingData = nil
  self:ShowBlackBg(true, data)
  self:showRemoveIcon(true)
  self:SetUICusttomSettingCurrentGroup(self._curGroup)
end
function PaGlobal_ConsoleQuickMenuSetting:ShowBlackBg(show, data)
  self._ui._RSGuideBg:SetShow(show)
  self._ui._registerModeBlackBg:SetShow(show)
  self._ui._ringCrossHair:SetShow(not show)
  self._ui._registerModeSelectItem:SetShow(show)
  self._ui._changeSlot:SetShow(not show)
  self:setCenterSlotIconAtregisterMode(data)
end
function PaGlobal_ConsoleQuickMenuSetting:setCenterSlotIconAtregisterMode(data)
  local control = self._ui._registerModeSelectItemIcon
  if nil ~= data then
    self._ui._registerModeSelectItemSlot:clearItem()
    if __eQuickMenuDataType_Skill == data._type then
      PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
    elseif __eQuickMenuDataType_Item == data._type then
      PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
      local selfPlayer = getSelfPlayer():get()
      local inventory = selfPlayer:getInventoryByType(data._whereType)
      local slotNo = data._slotNo
      local itemWrapper = getInventoryItemByType(data._whereType, slotNo)
      if nil ~= itemWrapper then
        self._ui._registerModeSelectItemSlot:setItem(itemWrapper, slotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == data._whereType)
      end
    elseif __eQuickMenuDataType_Function == data._type then
      PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon, data._uv)
    elseif __eQuickMenuDataType_SocialAction == data._type then
      PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
    else
      PaGlobal_ConsoleQuickMenu:setIcon(control)
    end
  else
    PaGlobal_ConsoleQuickMenu:setIcon(control)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:SetSkillDataMonoTone(index)
end
function PaGlobal_ConsoleQuickMenuSetting:isRegisterOrRemoveMode()
  if true == self._registMode._isRemoveStart or true == self._registMode._isStart then
    return true
  end
  return false
end
function PaGlobal_ConsoleQuickMenuSetting:quitRegistQuickMenu(executePosition)
  local registData = self._registMode._settingData
  self:clearRegistCustomSetting()
  if nil == executePosition or __eQuickMenuStickPosition_Count == executePosition then
    return
  end
  if nil == registData then
    return
  end
  self:registQuickMenu(registData, executePosition)
  PaGlobal_ConsoleQuickMenu:setWidget()
  self._isRegisterQuickMenu = true
end
function PaGlobal_ConsoleQuickMenuSetting:quitRegistRemoveQuickMenu(executePosition)
  local removeData = self._registMode._settingData
  self:clearRegistCustomSetting()
  if nil == executePosition or __eQuickMenuStickPosition_Count == executePosition then
    return
  end
  if nil == removeData then
    return
  end
  local rv = ToClient_removeQuickMenu(self._curGroup, executePosition)
  if true == rv then
    self:updateIcon(nil, executePosition)
    self._ui._buttonPositionSlot[executePosition]:clearItem()
  end
  _AudioPostEvent_SystemUiForXBOX(52, 1)
  PaGlobal_ConsoleQuickMenu:setWidget()
  self._isRegisterQuickMenu = true
end
function PaGlobal_ConsoleQuickMenuSetting:clearRegistCustomSetting()
  self._registMode._isStart = false
  self._registMode._isRemoveStart = false
  self._registMode._stickPosition = __eQuickMenuStickPosition_Count
  self._registMode._settingData = nil
  self:ShowBlackBg(false)
  self:showRemoveIcon(false)
end
function PaGlobal_ConsoleQuickMenuSetting:registQuickMenu(data, position)
  if nil == data then
    return
  end
  if __eQuickMenuDataType_Skill == data._type then
    self:registSkill(data, position)
  elseif __eQuickMenuDataType_Item == data._type then
    self:registItem(data, position)
  elseif __eQuickMenuDataType_Function == data._type then
    self:registFunctionType(data, position)
  elseif __eQuickMenuDataType_SocialAction == data._type then
    self:registSocialAction(data, position)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:registItem(data, position)
  if nil == data then
    return
  end
  local rv = ToClient_registQuickMenuItem(self._curGroup, position, data._whereType, data._slotNo)
  if true == rv then
    self:updateIcon(data, position)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:registSkill(data, position)
  if nil == data then
    return
  end
  local rv = ToClient_registQuickMenuSkill(self._curGroup, position, data._skillKey)
  if true == rv then
    self:updateIcon(data, position)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:registFunctionType(data, position)
  if nil == data then
    return
  end
  local rv = ToClient_registQuickMenuFunctionType(self._curGroup, position, data._enumType)
  if true == rv then
    self:updateIcon(data, position)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:registSocialAction(data, position)
  if nil == data then
    return
  end
  local rv = ToClient_registQuickMenuSocialAction(self._curGroup, position, data._socialKey)
  if true == rv then
    self:updateIcon(data, position)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setRemoveMode(state)
  if true == state then
    self:startRegistRemoveQuickMenu()
  else
    self:clearRegistCustomSetting()
  end
end
function PaGlobal_ConsoleQuickMenuSetting:showRemoveIcon(state)
  for ii = 0, __eQuickMenuStickPosition_Count - 1 do
    self._ui._buttonPositionRemoveIcon[ii]:SetShow(state)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:updateIcon(data, position)
  local control = self._ui._buttonPositionIcon[position]
  if nil == control then
    return
  end
  if nil == data then
    PaGlobal_ConsoleQuickMenu:setIcon(control)
    return
  end
  self._ui._buttonPositionSlot[position]:clearItem()
  if __eQuickMenuDataType_Skill == data._type then
    PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
  elseif __eQuickMenuDataType_Item == data._type then
    PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
    local quickMenu = ToClient_getAtQuickMenu(self._curGroup, position)
    if nil == quickMenu then
      return
    end
    local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickMenu._itemKey)
    if nil == itemStaticStatusWrapper then
      return
    end
    local selfPlayer = getSelfPlayer():get()
    local inventory = selfPlayer:getInventoryByType(quickMenu._itemWhereType)
    local slotNo = ToClient_GetItemNoByInventory(quickMenu._itemWhereType, quickMenu._itemNo)
    local itemWrapper = getInventoryItemByType(quickMenu._itemWhereType, slotNo)
    if nil ~= itemWrapper then
      self._ui._buttonPositionSlot[position]:setItem(itemWrapper, slotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
    end
  elseif __eQuickMenuDataType_Function == data._type then
    PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon, data._uv)
  elseif __eQuickMenuDataType_SocialAction == data._type then
    PaGlobal_ConsoleQuickMenu:setIcon(control, data._icon)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setFunctionTypeData()
  self._functionTypeData = {}
  if nil == PaGlobal_ConsoleQuickMenu._functionTypeList or nil == PaGlobal_ConsoleQuickMenu._functionTypeList._icon or nil == PaGlobal_ConsoleQuickMenu._functionTypeList._icon[__eQuickMenuDataType_Function] or nil == PaGlobal_ConsoleQuickMenu._functionTypeList._name or nil == PaGlobal_ConsoleQuickMenu._functionTypeList._name[__eQuickMenuDataType_Function] then
    return
  end
  for index = 0, PaGlobal_ConsoleQuickMenu._functionTypeCount do
    if true == PaGlobal_ConsoleQuickMenu._functionTypeList._ContentOption[__eQuickMenuDataType_Function][index] then
      local iconUV = PaGlobal_ConsoleQuickMenu._functionTypeList._icon[__eQuickMenuDataType_Function][index]
      uv = {
        _x1 = iconUV._x1,
        _y1 = iconUV._y1,
        _x2 = iconUV._x2,
        _y2 = iconUV._y2
      }
      self._functionTypeData[#self._functionTypeData + 1] = {
        _type = __eQuickMenuDataType_Function,
        _enumType = index,
        _name = PaGlobal_ConsoleQuickMenu._functionTypeList._name[__eQuickMenuDataType_Function][index],
        _icon = PaGlobal_ConsoleQuickMenu._functionTypeList._icon[__eQuickMenuDataType_Function][index]._path,
        _uv = uv
      }
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setInventoryData()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  self._inventoryData = {}
  local useStartSlot = inventorySlotNoUserStart()
  local inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() and true == ToClient_isVaildItemRegistQuickMenu(itemWrapper:getStaticStatus()) then
      self._inventoryData[#self._inventoryData + 1] = {
        _type = __eQuickMenuDataType_Item,
        _whereType = CppEnums.ItemWhereType.eInventory,
        _slotNo = slotNo,
        _name = itemWrapper:getStaticStatus():getName(),
        _icon = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
      }
    end
  end
  inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() and true == ToClient_isVaildItemRegistQuickMenu(itemWrapper:getStaticStatus()) then
      self._inventoryData[#self._inventoryData + 1] = {
        _type = __eQuickMenuDataType_Item,
        _whereType = CppEnums.ItemWhereType.eCashInventory,
        _slotNo = slotNo,
        _name = itemWrapper:getStaticStatus():getName(),
        _icon = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
      }
    end
  end
  inventorysize = ToClient_InventoryGetSize(CppEnums.ItemWhereType.eFamilyInventory)
  for slotNo = useStartSlot, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eFamilyInventory, slotNo)
    if nil ~= itemWrapper and false == itemWrapper:empty() and true == ToClient_isVaildItemRegistQuickMenu(itemWrapper:getStaticStatus()) then
      self._inventoryData[#self._inventoryData + 1] = {
        _type = __eQuickMenuDataType_Item,
        _whereType = CppEnums.ItemWhereType.eFamilyInventory,
        _slotNo = slotNo,
        _name = itemWrapper:getStaticStatus():getName(),
        _icon = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
      }
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setSkillData()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  if classType < 0 then
    return
  end
  self._skillData = {}
  local skillList = ToClient_getCombatSkillList(classType)
  if nil == skillList then
    return
  end
  self:setSkillListData(skillList)
  if true == ToClient_IsContentsGroupOpen("920") then
    local cellTable = getFusionSkillTree()
    if nil ~= cellTable then
      self:setFusionSkillCellTableData(cellTable)
    end
  end
  local skillTypeParam = ToClient_GetSelfPlayerSkillType()
  if __eSkillTypeParam_Normal == skillTypeParam or __eSkillTypeParam_Awaken == skillTypeParam then
    if true == ToClient_IsContentsGroupOpen("901") then
      skillList = ToClient_getAwakeSkillList(classType)
      if nil ~= skillList then
        self:setSkillListData(skillList)
      end
    end
  else
    skillList = ToClient_getSuccesionSkillList(classType)
    if nil ~= skillList then
      self:setSkillListData(skillList)
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setSkillListData(skillList)
  local count = skillList:getCount()
  for ii = 0, count - 1 do
    local skillNo = skillList:getSkillNo(ii)
    if false == _ContentsGroup_RenewUI or false == PaGlobalFunc_Skill_IsBlockByConsoleSkill(skillNo) then
      local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
      if nil ~= skillTypeStaticWrapper and true == skillTypeStaticWrapper:isValidLocalizing() then
        local skillTypeStatic = skillTypeStaticWrapper:get()
        if nil ~= skillTypeStatic and true == skillTypeStatic._isSettableQuickSlot then
          local skillLevelInfo = getSkillLevelInfo(skillNo)
          local skillLearndLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
          if nil ~= skillLevelInfo and true == skillLevelInfo._usable then
            self._skillData[#self._skillData + 1] = {
              _type = __eQuickMenuDataType_Skill,
              _skillKey = skillLevelInfo._skillKey:get(),
              _skillNo = skillNo,
              _name = skillTypeStaticWrapper:getName(),
              _icon = "Icon/" .. skillTypeStaticWrapper:getIconPath()
            }
          end
        end
      end
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setFusionSkillCellTableData(cellTable)
  local cols = cellTable:capacityX()
  local rows = cellTable:capacityY()
  local index = 0
  for row = 0, rows - 1 do
    for col = 0, cols - 1 do
      local cell = cellTable:atPointer(col, row)
      if true == cell:isSkillType() then
        local maxFusionSkill = ToClient_getFusionSkillListCount(index)
        for fusionIndex = 0, maxFusionSkill - 1 do
          local skillNo = ToClient_getFusionSkillNo(index, fusionIndex)
          local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
          local skillTypeStatic = skillTypeStaticWrapper:get()
          if nil ~= skillTypeStaticWrapper and true == skillTypeStaticWrapper:isValidLocalizing() and nil ~= skillTypeStatic and true == skillTypeStatic._isSettableQuickSlot then
            local skillLevelInfo = getSkillLevelInfo(skillNo)
            local skillLearndLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
            if nil ~= skillLevelInfo and true == skillLevelInfo._usable then
              self._skillData[#self._skillData + 1] = {
                _type = __eQuickMenuDataType_Skill,
                _skillKey = skillLevelInfo._skillKey:get(),
                _skillNo = skillNo,
                _name = skillTypeStaticWrapper:getName(),
                _icon = "Icon/" .. skillTypeStaticWrapper:getIconPath()
              }
            end
          end
        end
        index = index + 1
      end
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setSocialActionData()
  self._socialActionData = {}
  for ii = 0, ToClient_getSocialActionInfoList() - 1 do
    local socialActionInfo = ToClient_getSocialActionInfoByIndex(ii)
    local sASS = socialActionInfo:getStaticStatus()
    local socialKey = sASS:getKey()
    local isUsable = ToClient_isUsableSocialAction(socialKey)
    self._socialActionData[#self._socialActionData + 1] = {
      _type = __eQuickMenuDataType_SocialAction,
      _socialKey = socialKey,
      _name = sASS:getName(),
      _icon = "Icon/" .. sASS:getIconPath(),
      _isUsable = isUsable
    }
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setSkillUi()
  self._ui._list2Skill:getElementManager():clearKey()
  for index = 1, #self._skillData do
    if 1 == index % 2 then
      self._ui._list2Skill:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function QuickMenuSeting_List2Event_SKill(content, key)
  local id = Int64toInt32(key)
  local skillData = {
    [0] = PaGlobal_ConsoleQuickMenuSetting._skillData[id],
    PaGlobal_ConsoleQuickMenuSetting._skillData[id + 1]
  }
  for ii = 0, 1 do
    local radiobutton = UI.getChildControl(content, "RadioButton_SkillSlotBg_" .. ii)
    local name = UI.getChildControl(content, "StaticText_SkillName_" .. ii)
    local bg = UI.getChildControl(content, "Static_SlotBg_" .. ii)
    local slot = UI.getChildControl(content, "Static_Slot_" .. ii)
    local dataReady = nil ~= skillData[ii]
    radiobutton:SetShow(dataReady)
    name:SetShow(dataReady)
    bg:SetShow(dataReady)
    slot:SetShow(dataReady)
    if true == dataReady then
      slot:ChangeTextureInfoName(skillData[ii]._icon)
      name:SetTextMode(__eTextMode_AutoWrap)
      name:SetText(skillData[ii]._name)
      radiobutton:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(" .. __eQuickMenuDataType_Skill .. "," .. id + ii .. "  )")
    end
  end
end
function QuickMenuSeting_List2Event_GuildSkill(content, key)
  local id = Int64toInt32(key)
  local skillData = {
    [0] = PaGlobal_ConsoleQuickMenuSetting._guildSkillData[id],
    PaGlobal_ConsoleQuickMenuSetting._guildSkillData[id + 1]
  }
  for ii = 0, 1 do
    local radiobutton = UI.getChildControl(content, "RadioButton_SkillSlotBg_" .. ii)
    local name = UI.getChildControl(content, "StaticText_SkillName_" .. ii)
    local bg = UI.getChildControl(content, "Static_SlotBg_" .. ii)
    local slot = UI.getChildControl(content, "Static_Slot_" .. ii)
    local dataReady = nil ~= skillData[ii]
    radiobutton:SetShow(dataReady)
    name:SetShow(dataReady)
    bg:SetShow(dataReady)
    slot:SetShow(dataReady)
    if true == dataReady then
      slot:ChangeTextureInfoName(skillData[ii]._icon)
      name:SetTextMode(__eTextMode_AutoWrap)
      name:SetText(skillData[ii]._name)
      radiobutton:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(" .. __eQuickMenuDataType_GuildSkill .. "," .. id + ii .. "  )")
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setInventoryUi()
  local rowMax = 8
  local colMax = 9
  local row = 0
  local col = 0
  local offset = 54
  for index = 1, rowMax * colMax do
    local dataIndex = index + self._startColumn * rowMax
    local data = self._inventoryData[dataIndex]
    local item = self._ui._slots[index]
    if nil ~= data then
      local itemWrapper = getInventoryItemByType(data._whereType, data._slotNo)
      if nil ~= itemWrapper and false == itemWrapper:empty() and true == ToClient_isVaildItemRegistQuickMenu(itemWrapper:getStaticStatus()) then
        item:setItem(itemWrapper, data._slotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == data._whereType)
        item.icon:addInputEvent("Mouse_On", "HandleEventOn_ConsoleQuickMenuSetting_setItemSlotPadFunc(true," .. index .. "," .. data._whereType .. "," .. data._slotNo .. ")")
        item.icon:addInputEvent("Mouse_Out", "HandleEventOut_ConsoleQuickMenuSetting_hideItemTooltip()")
        item.icon:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(" .. __eQuickMenuDataType_Item .. "," .. dataIndex .. "  )")
      else
        item.icon:addInputEvent("Mouse_On", "HandleEventOn_ConsoleQuickMenuSetting_setItemSlotPadFunc(false," .. index .. ")")
        item:clearItem()
      end
    else
      item.icon:addInputEvent("Mouse_On", "HandleEventOn_ConsoleQuickMenuSetting_setItemSlotPadFunc(false," .. index .. ")")
      item:clearItem()
    end
  end
end
function HandleEventOn_ConsoleQuickMenuSetting_setItemSlotPadFunc(isOn, index, whereType, slotNo)
  if nil == index then
    return
  end
  local isShow = true == isOn and nil ~= whereType and nil ~= slotNo
  if true == isShow then
    Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobal_ConsoleQuickMenuSetting_ShowItemTooltip(" .. whereType .. "," .. slotNo .. "," .. index .. ")")
  else
    Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_X, "")
  end
  PaGlobal_ConsoleQuickMenuSetting:showSelectKeyGuideA(isShow, index)
  PaGlobal_ConsoleQuickMenuSetting._ui._staticText_Detail:SetShow(isShow)
  PaGlobal_ConsoleQuickMenuSetting:setAlignKeyGuide()
end
function HandleEventOut_ConsoleQuickMenuSetting_hideItemTooltip()
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil ~= PaGlobalFunc_TooltipInfo_Close then
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_ConsoleQuickMenuSetting_ShowItemTooltip(whereType, slotNo, index)
  local itemWrapper
  if nil ~= whereType and nil ~= slotNo then
    itemWrapper = getInventoryItemByType(whereType, slotNo)
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() or nil == itemWrapper then
      if nil ~= PaGlobalFunc_TooltipInfo_Close then
        PaGlobalFunc_TooltipInfo_Close()
      end
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    if nil ~= Panel_Tooltup_Item_isShow and true == Panel_Tooltup_Item_isShow() or nil == itemWrapper then
      if nil ~= Panel_Tooltip_Item_hideTooltip then
        Panel_Tooltip_Item_hideTooltip()
      end
      return
    end
    local targetControl
    if nil ~= index and nil ~= PaGlobal_ConsoleQuickMenuSetting._ui._slots[index] then
      targetControl = PaGlobal_ConsoleQuickMenuSetting._ui._slots[index].icon
    end
    if nil ~= Panel_Tooltip_Item_Show and nil ~= targetControl then
      Panel_Tooltip_Item_Show(itemWrapper, targetControl, false, true)
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting_scrollInventory(isUp)
  local self = PaGlobal_ConsoleQuickMenuSetting
  local startIndex = UIScroll.ScrollEvent(self._ui._scrollItem, isUp, 9, 192, 1 + self._startColumn * 8, 8)
  local newColumn = math.floor(startIndex / 8)
  if nil ~= self._curItemIndex and self._startColumn ~= newColumn then
    local rowMax = 8
    local dataIndex = self._curItemIndex + newColumn * rowMax
    local data = self._inventoryData[dataIndex]
    if nil ~= data then
      PaGlobal_ConsoleQuickMenuSetting:showSelectKeyGuideA(true, self._curItemIndex)
    else
      PaGlobal_ConsoleQuickMenuSetting:showSelectKeyGuideA(false, self._curItemIndex)
    end
    PaGlobal_ConsoleQuickMenuSetting:setAlignKeyGuide()
  end
  self._startColumn = newColumn
  self:setInventoryUi()
end
function PaGlobal_ConsoleQuickMenuSetting:setFunctionTypeUi()
  self._ui._list2Menu:getElementManager():clearKey()
  for index = 1, #self._functionTypeData do
    if 1 == index % 3 then
      self._ui._list2Menu:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function QuickMenuSeting_List2Event_Menu(content, key)
  local id = Int64toInt32(key)
  local functionData = {
    PaGlobal_ConsoleQuickMenuSetting._functionTypeData[id],
    PaGlobal_ConsoleQuickMenuSetting._functionTypeData[id + 1],
    PaGlobal_ConsoleQuickMenuSetting._functionTypeData[id + 2]
  }
  local btns = {
    UI.getChildControl(content, "Button_1"),
    UI.getChildControl(content, "Button_2"),
    UI.getChildControl(content, "Button_3")
  }
  local stc_icons = {}
  local txt_title = {}
  for ii = 1, #btns do
    stc_icons[ii] = UI.getChildControl(btns[ii], "Static_MenuIcon")
    txt_title[ii] = UI.getChildControl(btns[ii], "StaticText_Menu")
    local dataReady = nil ~= functionData[ii]
    btns[ii]:SetShow(dataReady)
    if true == dataReady then
      PaGlobal_ConsoleQuickMenu:setIcon(stc_icons[ii], functionData[ii]._icon, functionData[ii]._uv)
      btns[ii]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(" .. __eQuickMenuDataType_Function .. "," .. id + (ii - 1) .. "  )")
      txt_title[ii]:SetTextMode(__eTextMode_AutoWrap)
      txt_title[ii]:SetAutoResize(true)
      txt_title[ii]:SetText(functionData[ii]._name)
      txt_title[ii]:SetPosY(btns[ii]:GetPosY() + btns[ii]:GetSizeY() / 2 - txt_title[ii]:GetTextSizeY() / 2)
      txt_title[ii]:SetTextSpan(0, (txt_title[ii]:GetSizeY() - txt_title[ii]:GetTextSizeY()) * 0.5)
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setSocialActionUi()
  self._ui._list2SocialAction:getElementManager():clearKey()
  for index = 1, #self._socialActionData do
    if 1 == index % 3 then
      self._ui._list2SocialAction:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setGuildSkillData()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local guidSkillTree = getGuildSkillTree()
  local maxCols = guidSkillTree:capacityX()
  local maxRows = guidSkillTree:capacityY()
  local passiveCellIdx = 0
  local activeCellIdx = 0
  self._guildSkillData = {}
  for rowIdx = 0, maxRows - 1 do
    for colIdx = 0, maxCols - 1 do
      local skillCell = guidSkillTree:atPointer(colIdx, rowIdx)
      if true == skillCell:isSkillType() then
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillCell._skillNo)
        local skillLevelInfo = getSkillLevelInfo(skillCell._skillNo)
        if nil ~= skillLevelInfo then
          local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillCell._skillNo)
          if not skillLevelInfo._learnable and skillLevelInfo._usable and skillTypeStaticWrapper:get():isActiveSkill() and nil ~= skillTypeStaticWrapper and true == skillTypeStaticWrapper:isValidLocalizing() then
            local skillTypeStatic = skillTypeStaticWrapper:get()
            if nil ~= skillTypeStatic and true == skillTypeStatic._isSettableQuickSlot then
              local skillSSW = getSkillStaticStatus(skillCell._skillNo, 1)
              if nil ~= skillSSW and true == skillSSW:isUsableSkill() then
                self._guildSkillData[#self._guildSkillData + 1] = {
                  _type = __eQuickMenuDataType_Skill,
                  _skillKey = skillSSW:getKey(),
                  _skillNo = skillCell._skillNo,
                  _name = skillTypeStaticWrapper:getName(),
                  _icon = "Icon/" .. skillTypeStaticWrapper:getIconPath()
                }
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:setGuildSkillUi()
  self._ui._list2GuildSkill:getElementManager():clearKey()
  for listIdx = 0, #self._guildSkillData + 1 do
    if 1 == listIdx % 2 then
      self._ui._list2GuildSkill:getElementManager():pushKey(toInt64(0, listIdx))
    end
  end
end
function QuickMenuSeting_List2Event_SocialAction(content, key)
  local id = Int64toInt32(key)
  local functionData = {
    PaGlobal_ConsoleQuickMenuSetting._socialActionData[id],
    PaGlobal_ConsoleQuickMenuSetting._socialActionData[id + 1],
    PaGlobal_ConsoleQuickMenuSetting._socialActionData[id + 2]
  }
  local btns = {
    UI.getChildControl(content, "Button_1"),
    UI.getChildControl(content, "Button_2"),
    UI.getChildControl(content, "Button_3")
  }
  local stc_icons = {}
  local txt_title = {}
  for ii = 1, #btns do
    stc_icons[ii] = UI.getChildControl(btns[ii], "Static_MenuIcon")
    txt_title[ii] = UI.getChildControl(btns[ii], "StaticText_Menu")
    local dataReady = nil ~= functionData[ii]
    btns[ii]:SetShow(dataReady)
    if true == dataReady then
      stc_icons[ii]:ChangeTextureInfoName(functionData[ii]._icon)
      btns[ii]:addInputEvent("Mouse_LUp", "PaGlobal_ConsoleQuickMenuSetting:startRegistQuickMenu(" .. __eQuickMenuDataType_SocialAction .. "," .. id + (ii - 1) .. "  )")
      if false == _ContentsGroup_RenewUI then
        if true == functionData[ii]._isUsable then
          stc_icons[ii]:SetMonoTone(false)
        else
          stc_icons[ii]:SetMonoTone(true)
          btns[ii]:addInputEvent("Mouse_LUp", "")
        end
      end
      txt_title[ii]:SetTextMode(__eTextMode_AutoWrap)
      txt_title[ii]:SetAutoResize(true)
      txt_title[ii]:SetText(functionData[ii]._name)
      txt_title[ii]:SetPosY(btns[ii]:GetPosY() + btns[ii]:GetSizeY() / 2 - txt_title[ii]:GetTextSizeY() / 2)
      txt_title[ii]:SetTextSpan(0, (txt_title[ii]:GetSizeY() - txt_title[ii]:GetTextSizeY()) * 0.5)
    end
  end
end
function PaGlobal_ConsoleQuickMenuSetting:UpdateData()
  self:setSkillData()
  self:setInventoryData()
  self:setFunctionTypeData()
  self:setSocialActionData()
  self:setGuildSkillData()
end
function PaGlobal_ConsoleQuickMenuSetting:UpdateUi()
  self:setSkillUi()
  self:setInventoryUi()
  self:setFunctionTypeUi()
  self:setSocialActionUi()
  self:setGuildSkillUi()
end
function FromClient_ConsoleQuickMenu_OpenCustomPage(currentSettingGroup)
  if currentSettingGroup < 0 or currentSettingGroup >= __eQuickMenuDpadGroup_Count then
    return
  end
  local self = PaGlobal_ConsoleQuickMenuSetting
  FromClient_ConsoleQuickMenu_Close()
  Panel_QuickMenuCustom:SetShow(true)
  self:UpdateData()
  self:UpdateUi()
  self._curGroup = currentSettingGroup
  Panel_QuickMenuCustom_RightRing:SetShow(true)
  self:rotateDpadCrossHair(currentSettingGroup)
  PaGlobal_ConsoleQuickMenuSetting:ShowBlackBg(false)
  if true == _ContentsGroup_RenewUI_Chatting and true == Panel_Widget_Chatting_Renew:GetShow() then
    PaGlobalFunc_ChattingInfo_Close()
  end
  if nil == _blueprintQuickMenuWhenOpen then
    _blueprintQuickMenuWhenOpen = {}
  end
  self:clearRegistCustomSetting()
  self:showRemoveIcon(false)
  self:SetUICusttomSettingCurrentGroup(currentSettingGroup)
end
local _crossHairUV = {
  [0] = {
    97,
    1,
    192,
    96
  },
  {
    1,
    1,
    96,
    96
  },
  {
    193,
    1,
    288,
    96
  },
  {
    289,
    1,
    384,
    96
  }
}
local _crossHairURL = "renewal/function/console_function_ringmenu_01.dds"
function PaGlobal_ConsoleQuickMenuSetting:rotateDpadCrossHair(group)
  local control = PaGlobal_ConsoleQuickMenuSetting._ui._ringCrossHair
  UI.changeTextureUV(control, _crossHairURL, _crossHairUV[group % 4])
  if group < __eQuickMenuDpadGroup_Count / 2 then
    self._ui._stc_LTGuide:SetShow(false)
  else
    self._ui._stc_LTGuide:SetShow(true)
  end
end
function PaGlobal_ConsoleQuickMenuSetting:SetUICusttomSettingCurrentGroup(group)
  local groupInfo = PaGlobal_ConsoleQuickMenu:GetCurrentGroupInfo(group)
  for position, info in ipairs(groupInfo) do
    local control = self._ui._buttonPositionIcon[position - 1]
    if nil == control then
      return
    end
    PaGlobal_ConsoleQuickMenu:setIcon(control, info._icon, info._uv)
    self._ui._buttonPositionSlot[position - 1]:clearItem()
    if __eQuickMenuDataType_Item == info._type then
      local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
      if nil == quickMenu then
        return
      end
      local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickMenu._itemKey)
      if nil == itemStaticStatusWrapper then
        return
      end
      local selfPlayer = getSelfPlayer():get()
      local inventory = selfPlayer:getInventoryByType(quickMenu._itemWhereType)
      local slotNo = ToClient_GetItemNoByInventory(quickMenu._itemWhereType, quickMenu._itemNo)
      local itemWrapper = getInventoryItemByType(quickMenu._itemWhereType, slotNo)
      if nil ~= itemWrapper then
        self._ui._buttonPositionSlot[position - 1]:setItem(itemWrapper, slotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
      else
        self._ui._buttonPositionSlot[position - 1].familyInvenIcon:SetShow(CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
      end
    end
  end
end
function FGlobal_ConsoleQuickMenuSetting_RegistMode()
  local self = PaGlobal_ConsoleQuickMenuSetting
  local registPosition = ToClient_checkQuickMenuCurrentPosition()
  if __eQuickMenuStickPosition_Count == registPosition then
    if __eQuickMenuStickPosition_Count ~= self._registMode._stickPosition then
      self:quitRegistQuickMenu(self._registMode._stickPosition)
      _AudioPostEvent_SystemUiForXBOX(52, 1)
    end
  else
    self._registMode._stickPosition = registPosition
  end
  PaGlobal_ConsoleQuickMenuSetting:updatePosition(registPosition)
end
function FGlobal_ConsoleQuickMenuSetting_RemoveMode()
  local self = PaGlobal_ConsoleQuickMenuSetting
  local registPosition = ToClient_checkQuickMenuCurrentPosition()
  if __eQuickMenuStickPosition_Count == registPosition then
    if __eQuickMenuStickPosition_Count ~= self._registMode._stickPosition then
      self:quitRegistRemoveQuickMenu(self._registMode._stickPosition)
    end
  else
    self._registMode._stickPosition = registPosition
    self._registMode._settingData = ToClient_getAtQuickMenu(self._curGroup, self._registMode._stickPosition)
    local data = PaGlobal_ConsoleQuickMenu:GetPositionInfo(self._registMode._settingData)
    self:setCenterSlotIconAtregisterMode(data)
  end
  PaGlobal_ConsoleQuickMenuSetting:updatePosition(registPosition)
end
function PaGlobal_ConsoleQuickMenuSetting:updatePosition(registPosition)
  if __eQuickMenuStickPosition_Count == registPosition then
    for _, control in pairs(self._ui._buttonPosition) do
      control:SetMonoTone(false)
      control:SetCheck(false)
    end
    self._ui._registerModeSelectItem:SetText("")
  else
    for _, control in pairs(self._ui._buttonPosition) do
      control:SetMonoTone(true)
      control:SetCheck(false)
    end
    self._ui._buttonPosition[registPosition]:SetMonoTone(false)
    self._ui._buttonPosition[registPosition]:SetCheck(true)
    local string = PaGlobal_ConsoleQuickMenu:GetCurrentQuickMenuName(self._curGroup, self._registMode._stickPosition)
    self._ui._registerModeSelectItem:SetText(string)
    self._ui._RSGuideBg:SetShow(false)
  end
end
function FromClient_ConsoleQuickMenuSetting_luaLoadComplete()
  PaGlobal_ConsoleQuickMenuSetting:initializeUI()
  PaGlobal_ConsoleQuickMenuSetting:GoCategory(__eQuickMenuDataType_Item)
end
function FromClient_OnscreenResize()
  Panel_QuickMenuCustom:ComputePos()
  Panel_QuickMenuCustom_RightRing:ComputePos()
end
function FGlobal_ConsoleQuickMenu_PerFrame()
  if true == PaGlobal_ConsoleQuickMenuSetting._registMode._isStart then
    FGlobal_ConsoleQuickMenuSetting_RegistMode()
  else
    if true == PaGlobal_ConsoleQuickMenuSetting._registMode._isRemoveStart then
      FGlobal_ConsoleQuickMenuSetting_RemoveMode()
    else
    end
  end
end
function FGlobal_ConsoleQuickMenuSetting_Close()
  if PaGlobal_ConsoleQuickMenuSetting:isRegisterOrRemoveMode() then
    PaGlobal_ConsoleQuickMenuSetting:clearRegistCustomSetting()
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip and nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  Panel_QuickMenuCustom:SetShow(false)
  Panel_QuickMenuCustom_RightRing:SetShow(false)
  if true == PaGlobal_ConsoleQuickMenuSetting._isRegisterQuickMenu then
    PaGlobal_ConsoleQuickMenuSetting._isRegisterQuickMenu = false
    ToClient_saveUserCache()
  end
end
function FGlobal_ConsoleQuickMenu_ChangeDpadGroup(left)
  local self = PaGlobal_ConsoleQuickMenuSetting
  local changeGroup = self._curGroup
  if left == false then
    changeGroup = (PaGlobal_ConsoleQuickMenuSetting._curGroup + 1) % __eQuickMenuDpadGroup_Count
  else
    changeGroup = (PaGlobal_ConsoleQuickMenuSetting._curGroup - 1) % __eQuickMenuDpadGroup_Count
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  self._curGroup = changeGroup
  self:SetUICusttomSettingCurrentGroup(changeGroup)
  self:rotateDpadCrossHair(changeGroup)
end
function FGlobal_ConsoleQuickMenu_LTGroupToggle()
  local self = PaGlobal_ConsoleQuickMenuSetting
  local changeGroup = self._curGroup
  if changeGroup > 3 then
    changeGroup = changeGroup - __eQuickMenuDpadGroup_Count / 2
  else
    changeGroup = changeGroup + __eQuickMenuDpadGroup_Count / 2
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  self._curGroup = changeGroup
  self:SetUICusttomSettingCurrentGroup(changeGroup)
  self:rotateDpadCrossHair(changeGroup)
end
function Toggle_QuickMenuSetting_forPadEventFunc(left)
  if true == left then
    PaGlobal_ConsoleQuickMenuSetting._curCategory = PaGlobal_ConsoleQuickMenuSetting._curCategory - 1
  else
    PaGlobal_ConsoleQuickMenuSetting._curCategory = PaGlobal_ConsoleQuickMenuSetting._curCategory + 1
  end
  _AudioPostEvent_SystemUiForXBOX(51, 6)
  PaGlobal_ConsoleQuickMenuSetting._curCategory = PaGlobal_ConsoleQuickMenuSetting._curCategory % 5
  PaGlobal_ConsoleQuickMenuSetting:GoCategory(PaGlobal_ConsoleQuickMenuSetting._curCategory)
  PaGlobal_ConsoleQuickMenuSetting:showSelectKeyGuideA(true)
  if nil ~= Panel_QuickMenuCustom then
    Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_X, "")
  end
  PaGlobal_ConsoleQuickMenuSetting._ui._staticText_Detail:SetShow(false)
  PaGlobal_ConsoleQuickMenuSetting:setAlignKeyGuide()
  HandleEventOut_ConsoleQuickMenuSetting_hideItemTooltip()
end
function PaGlobal_QuickMenuSetting_GetShow()
  return Panel_QuickMenuCustom:GetShow()
end
function Toggle_QuickMenuSetting_removeMode()
  if false == PaGlobal_ConsoleQuickMenuSetting._registMode._isRemoveStart then
    PaGlobal_ConsoleQuickMenuSetting:setRemoveMode(true)
  else
    PaGlobal_ConsoleQuickMenuSetting:setRemoveMode(false)
  end
end
Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_RT, "FGlobal_ConsoleQuickMenu_ChangeDpadGroup(false)")
Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_LT, "FGlobal_ConsoleQuickMenu_LTGroupToggle(false)")
Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_LB, "Toggle_QuickMenuSetting_forPadEventFunc(true)")
Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_RB, "Toggle_QuickMenuSetting_forPadEventFunc(false)")
Panel_QuickMenuCustom:registerPadEvent(__eConsoleUIPadEvent_Y, "Toggle_QuickMenuSetting_removeMode()")
Panel_QuickMenuCustom:RegisterUpdateFunc("FGlobal_ConsoleQuickMenu_PerFrame")
registerEvent("FromClient_luaLoadComplete", "FromClient_ConsoleQuickMenuSetting_luaLoadComplete")
registerEvent("FromClient_ConsoleQuickMenu_OpenCustomPage", "FromClient_ConsoleQuickMenu_OpenCustomPage")
registerEvent("onScreenResize", "FromClient_OnscreenResize")
