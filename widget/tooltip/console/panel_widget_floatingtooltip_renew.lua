local _panel = Panel_Widget_FloatingTooltip_Renew
local COMPONENT_TYPE = {
  HEADER = 1,
  WEIGHT_PRICE = 2,
  ENDURANCE = 3,
  KEY_GUIDE = 4,
  DESC = 5,
  CRAFT_NOTE = 6,
  ITEM_LOCK = 7
}
local FloatingTooltip = {
  _ui = {
    stc_components = {
      [COMPONENT_TYPE.HEADER] = UI.getChildControl(_panel, "HEADER"),
      [COMPONENT_TYPE.WEIGHT_PRICE] = UI.getChildControl(_panel, "WEIGHT_PRICE"),
      [COMPONENT_TYPE.ENDURANCE] = UI.getChildControl(_panel, "ENDURANCE"),
      [COMPONENT_TYPE.KEY_GUIDE] = UI.getChildControl(_panel, "StaticText_KeyGuideDetail"),
      [COMPONENT_TYPE.DESC] = UI.getChildControl(_panel, "DESC"),
      [COMPONENT_TYPE.CRAFT_NOTE] = UI.getChildControl(_panel, "StaticText_KeyGuideCraftNote"),
      [COMPONENT_TYPE.ITEM_LOCK] = UI.getChildControl(_panel, "StaticText_ItemLockBG")
    }
  },
  _defaultXGap = 8
}
local _currentYPos = 15
local _defaultWidth = 290
local _componentOption = {}
local _targetData = {
  [Defines.TooltipTargetType.Item] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.WEIGHT_PRICE,
    COMPONENT_TYPE.ENDURANCE,
    COMPONENT_TYPE.KEY_GUIDE
  },
  [Defines.TooltipTargetType.ItemWithoutCompare] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.WEIGHT_PRICE,
    COMPONENT_TYPE.ENDURANCE,
    COMPONENT_TYPE.KEY_GUIDE
  },
  [Defines.TooltipTargetType.ItemWithCraftNote] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.WEIGHT_PRICE,
    COMPONENT_TYPE.ENDURANCE,
    COMPONENT_TYPE.KEY_GUIDE,
    COMPONENT_TYPE.CRAFT_NOTE,
    COMPONENT_TYPE.ITEM_LOCK
  },
  [Defines.TooltipTargetType.ItemNameOnly] = {
    COMPONENT_TYPE.HEADER
  },
  [Defines.TooltipTargetType.CashBuff] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.DESC
  },
  [Defines.TooltipTargetType.PlainText] = {
    COMPONENT_TYPE.DESC
  },
  [Defines.TooltipTargetType.NameAndWeight] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.WEIGHT_PRICE
  },
  [Defines.TooltipTargetType.ItemWithCraftNoteNoLock] = {
    COMPONENT_TYPE.HEADER,
    COMPONENT_TYPE.WEIGHT_PRICE,
    COMPONENT_TYPE.ENDURANCE,
    COMPONENT_TYPE.KEY_GUIDE,
    COMPONENT_TYPE.CRAFT_NOTE
  }
}
function FromClient_luaLoadComplete_FloatingTooltip_Init()
  FloatingTooltip:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_FloatingTooltip_Init")
function FloatingTooltip:initialize()
  _componentOption = {
    [COMPONENT_TYPE.HEADER] = {fillDataFunc = FloatingTooltip_updateHEADER},
    [COMPONENT_TYPE.WEIGHT_PRICE] = {fillDataFunc = FloatingTooltip_updateWEIGHT_PRICE},
    [COMPONENT_TYPE.ENDURANCE] = {fillDataFunc = FloatingTooltip_updateENDURANCE},
    [COMPONENT_TYPE.KEY_GUIDE] = {fillDataFunc = FloatingTooltip_updateKEY_GUIDE},
    [COMPONENT_TYPE.DESC] = {fillDataFunc = FloatingTooltip_updateDESC},
    [COMPONENT_TYPE.CRAFT_NOTE] = {fillDataFunc = FloatingTooltip_updateCRAFT_NOTE},
    [COMPONENT_TYPE.ITEM_LOCK] = {fillDataFunc = FloatingTooltip_updateITEM_LOCK}
  }
  registerEvent("FromClient_PadSnapChangeTarget", "FromClient_FloatingTooltip_PadSnapChangeTarget")
end
function PaGlobalFunc_FloatingTooltip_Open(tooltipDataType, data, tooltipTargetType, targetControl, slotType)
  FloatingTooltip:open(tooltipDataType, data, tooltipTargetType, targetControl, slotType)
end
function FloatingTooltip:open(tooltipDataType, data, tooltipTargetType, targetControl, slotType)
  if Panel_ProductNote:GetShow() then
    return
  end
  if nil == tooltipDataType or nil == data or nil == tooltipTargetType then
    self:close()
    return
  end
  if nil == targetControl then
    targetControl = ToClient_getSnappedControl()
  end
  if nil == targetControl then
    return
  end
  _currentYPos = 15
  local itemWrapper
  local itemSSW = data
  if Defines.TooltipDataType.ItemWrapper == tooltipDataType then
    itemWrapper = data
    itemSSW = itemWrapper:getStaticStatus()
    self:compose(itemWrapper, itemSSW, tooltipTargetType, slotType)
  elseif Defines.TooltipDataType.CashBuffData == tooltipDataType then
    self:compose(data.name, data.desc, tooltipTargetType, slotType)
  elseif Defines.TooltipDataType.PlainText == tooltipDataType then
    self:compose(nil, data, tooltipTargetType, slotType)
  else
    self:compose(itemWrapper, itemSSW, tooltipTargetType, slotType)
  end
  _panel:SetShow(true)
  local defaultXPos = targetControl:GetParentPosX() + targetControl:GetSizeX() - _panel:GetSizeX()
  _panel:SetPosX(math.max(10, defaultXPos))
  if getScreenSizeY() < targetControl:GetParentPosY() + targetControl:GetSizeY() + _panel:GetSizeY() + self._defaultXGap then
    _panel:SetPosY(targetControl:GetParentPosY() + targetControl:GetSizeY() - _panel:GetSizeY())
    _panel:SetPosX(math.max(10, defaultXPos - targetControl:GetSizeX() - self._defaultXGap))
  else
    _panel:SetPosY(targetControl:GetParentPosY() + targetControl:GetSizeY() + self._defaultXGap)
  end
  self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:ComputePos()
end
function FloatingTooltip:compose(primary, secondary, tooltipTargetType, slotType)
  for ii = 1, #self._ui.stc_components do
    self._ui.stc_components[ii]:SetShow(false)
  end
  for ii = 1, #_targetData[tooltipTargetType] do
    if nil ~= _targetData[tooltipTargetType][ii] then
      local componentIndex = _targetData[tooltipTargetType][ii]
      if nil ~= _componentOption[componentIndex] and nil ~= _componentOption[componentIndex].fillDataFunc then
        local updateFunc = _componentOption[componentIndex].fillDataFunc
        if nil ~= updateFunc and "function" == type(updateFunc) and true == updateFunc(primary, secondary, tooltipTargetType, slotType) then
          self._ui.stc_components[_targetData[tooltipTargetType][ii]]:SetShow(true)
          self._ui.stc_components[componentIndex]:SetPosY(_currentYPos)
          _currentYPos = _currentYPos + self._ui.stc_components[componentIndex]:GetSizeY() + 5
        end
      end
    end
  end
  _panel:SetSize(_panel:GetSizeX(), _currentYPos + 10)
end
function PaGlobalFunc_FloatingTooltip_Close()
  FloatingTooltip:close()
end
function FloatingTooltip:close()
  _panel:SetShow(false)
end
local colorTable = {
  [0] = Defines.Color.C_FFEEEEEE,
  [1] = Defines.Color.C_FF8DB245,
  [2] = Defines.Color.C_FF309BF5,
  [3] = Defines.Color.C_FFF0D147,
  [4] = Defines.Color.C_FFFF6244
}
local self = FloatingTooltip
function FloatingTooltip_updateHEADER(primary, secondary, tooltipTargetType)
  local txt_name = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.HEADER], "StaticText_ItemName")
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  if Defines.TooltipTargetType.CashBuff == tooltipTargetType then
    txt_name:SetText(primary)
    self._ui.stc_components[COMPONENT_TYPE.HEADER]:SetSize(_defaultWidth, txt_name:GetTextSizeY())
    return true
  else
    local itemWrapper = primary
    local itemSSW = secondary
    local nameColorGrade = itemSSW:getGradeType()
    local fontColor = colorTable[0]
    if nil ~= colorTable[nameColorGrade] then
      fontColor = colorTable[nameColorGrade]
    end
    txt_name:SetFontColor(fontColor)
    local enchantLevelStr = PaGlobalFunc_FloatingTooltip_GetEnchantLevelStr(secondary)
    if nil ~= enchantLevelStr then
      txt_name:SetText(enchantLevelStr .. " : " .. itemSSW:getName())
    else
      txt_name:SetText(itemSSW:getName())
    end
    self._ui.stc_components[COMPONENT_TYPE.HEADER]:SetSize(_defaultWidth, txt_name:GetTextSizeY())
    return true
  end
end
function FloatingTooltip_updateDESC(primary, secondary, tooltipTargetType)
  local txt_desc = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.DESC], "StaticText_Desc")
  txt_desc:SetTextMode(__eTextMode_AutoWrap)
  txt_desc:SetFontColor(Defines.Color.C_FF9397A7)
  txt_desc:SetText(secondary)
  self._ui.stc_components[COMPONENT_TYPE.DESC]:SetSize(_defaultWidth, txt_desc:GetTextSizeY())
  return true
end
function FloatingTooltip_updateWEIGHT_PRICE(itemWrapper, itemSSW, tooltipTargetType, slotType)
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local isTradeItem = itemSSW:isTradeAble()
  local s64_originalPrice = itemSSW:get()._originalPrice_s64
  local s64_sellPrice = itemSSW:get()._sellPriceToNpc_s64
  local txt_price = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE], "StaticText_Price")
  if isTradeItem then
    if s64_originalPrice > Defines.s64_const.s64_0 and 0 == enchantLevel then
      if __ePriceType_Shell == itemSSW:getTradePriceType() then
        txt_price:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_SEASHELL") .. " " .. tostring(makeDotMoney(s64_originalPrice)))
      else
        txt_price:SetText(tostring(makeDotMoney(s64_originalPrice)))
      end
      txt_price:SetFontColor(4292726146)
    else
      txt_price:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOT_SELLING_ITEM"))
      txt_price:SetFontColor(4290733156)
    end
  elseif s64_sellPrice > Defines.s64_const.s64_0 and 0 == enchantLevel then
    if __ePriceType_Shell == itemSSW:getTradePriceType() then
      txt_price:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_SEASHELL") .. " " .. tostring(makeDotMoney(s64_sellPrice)))
    else
      txt_price:SetText(tostring(makeDotMoney(s64_sellPrice)))
    end
    txt_price:SetFontColor(4292726146)
  else
    txt_price:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_NOT_SELLING_ITEM"))
    txt_price:SetFontColor(4290733156)
  end
  local txt_weight = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE], "StaticText_Weight")
  local s64_weight = toInt64(0, 0)
  local isWeightFontColorSet = false
  local isInventoryBagItem = CppEnums.ContentsEventType.ContentsType_InventoryBag == itemSSW:get():getContentsEventType()
  if true == isInventoryBagItem then
    local isInWareHouse = false
    local bagItemSlotNo = __eTInventorySlotNoUndefined
    local bagItemKey = itemSSW:get()._key
    if "WareHouse" == slotType then
      bagItemSlotNo = ToClient_InventoryGetSlotNoByType(CppEnums.ItemWhereType.eWarehouse, bagItemKey)
      isInWareHouse = true
    elseif "Inventory" == slotType then
      bagItemSlotNo = ToClient_InventoryGetSlotNoByType(CppEnums.ItemWhereType.eInventory, bagItemKey)
    elseif "ServantInventory" == slotType then
      bagItemSlotNo = ToClient_InventoryGetSlotNoByType(CppEnums.ItemWhereType.eServantInventory, bagItemKey)
    end
    if __eTInventorySlotNoUndefined == bagItemSlotNo then
      s64_weight = itemSSW:get()._weight
      isWeightFontColorSet = false
    else
      local bagItemFullSize = itemSSW:getContentsEventParam2()
      for index = 0, bagItemFullSize - 1 do
        local ItemWrapperInBag
        if true == isInWareHouse then
          if true == _ContentsGroup_NewUI_WareHouse_All then
            ItemWrapperInBag = PaGlobal_Warehouse_All_GetWarehouseWarpper():getItemInBag(bagItemSlotNo, index)
          else
            ItemWrapperInBag = Warehouse_GetWarehouseWarpper():getItemInBag(bagItemSlotNo, index)
          end
        else
          local whereType = CppEnums.ItemWhereType.eInventory
          if itemSSW:get():isCash() then
            whereType = CppEnums.ItemWhereType.eCashInventory
          end
          ItemWrapperInBag = getInventoryBagItemByType(whereType, bagItemSlotNo, index)
        end
        if nil ~= ItemWrapperInBag then
          s64_weight = s64_weight + toInt64(0, ItemWrapperInBag:getStaticStatus():get()._weight) * ItemWrapperInBag:get():getCount_s64()
        end
      end
      if toInt64(0, 0) == s64_weight then
        isWeightFontColorSet = false
      else
        isWeightFontColorSet = true
      end
    end
  else
    s64_weight = itemSSW:get()._weight
    isWeightFontColorSet = false
  end
  if true == isWeightFontColorSet then
    txt_weight:SetText("<PAColor0xFF7DB611>" .. makeWeightString(s64_weight, 2) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "<PAOldColor>")
  else
    txt_weight:SetText(makeWeightString(s64_weight, 2) .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT"))
  end
  txt_weight:SetShow(true)
  txt_weight:SetSpanSize(txt_weight:GetTextSizeX() + 10, 0)
  if itemSSW:get():isCash() then
    txt_weight:SetShow(false)
  end
  local txt_totalCount = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE], "StaticText_TotalCount")
  if nil ~= itemWrapper then
    local totalCount = itemWrapper:get():getCount_s64()
    txt_totalCount:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_BUYORGIFT_BUYCOUNT") .. " : " .. tostring(makeDotMoney(totalCount)))
    self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:SetSize(self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:GetSizeX(), txt_weight:GetSizeY() + txt_price:GetSizeY() + txt_totalCount:GetSizeY())
    self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:ComputePos()
    txt_price:SetPosY(txt_totalCount:GetPosY() + txt_totalCount:GetSizeY())
    txt_totalCount:SetShow(true)
  else
    self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:SetSize(self._ui.stc_components[COMPONENT_TYPE.WEIGHT_PRICE]:GetSizeX(), txt_weight:GetSizeY() + txt_price:GetSizeY())
    txt_price:SetPosY(txt_totalCount:GetPosY())
    txt_totalCount:SetShow(false)
  end
  return true
end
function FloatingTooltip_updateKEY_GUIDE()
  return true
end
function FloatingTooltip_updateCRAFT_NOTE()
  return true
end
function FloatingTooltip_updateITEM_LOCK()
  local lockable = PaGlobalFunc_InventoryInfo_IsItemlockable()
  local islock = PaGlobalFunc_InventoryInfo_IsCurrentItemlock()
  if nil == islock then
    return false
  end
  local controlBG = self._ui.stc_components[COMPONENT_TYPE.ITEM_LOCK]
  local txt_itemlock = UI.getChildControl(controlBG, "StaticText_ItemLock")
  txt_itemlock:SetTextMode(__eTextMode_AutoWrap)
  if false == islock then
    txt_itemlock:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FLOATINGTOOLTIP_ITEMLOCK"))
  else
    txt_itemlock:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_FLOATINGTOOLTIP_ITEMUNLOCK"))
  end
  local sizeY = txt_itemlock:GetTextSizeY()
  if sizeY > 44 then
    controlBG:SetSize(controlBG:GetSizeX(), sizeY)
  else
    controlBG:SetSize(controlBG:GetSizeX(), 44)
  end
  return lockable
end
function FloatingTooltip_updateENDURANCE(itemWrapper, itemSSW)
  if nil == itemWrapper then
    return false
  end
  local progress_endurance = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.ENDURANCE], "Progress2_Endurance")
  local progress_dynamicEndurance = UI.getChildControl(self._ui.stc_components[COMPONENT_TYPE.ENDURANCE], "Progress2_Dynamic")
  local maxEndurance = 32767
  local dynamicMaxEndurance = 32767
  if false == itemSSW:get():isUnbreakable() then
    maxEndurance = itemSSW:get():getMaxEndurance()
  end
  local currentEndurance = maxEndurance
  if nil ~= itemWrapper then
    dynamicMaxEndurance = itemWrapper:get():getMaxEndurance()
    currentEndurance = itemWrapper:get():getEndurance()
  end
  local calcEndurance = currentEndurance / maxEndurance
  local calcDynamicEndurance = dynamicMaxEndurance / maxEndurance
  progress_endurance:SetCurrentProgressRate(calcEndurance * 100)
  progress_endurance:SetProgressRate(calcEndurance * 100)
  progress_endurance:SetAniSpeed(0)
  progress_dynamicEndurance:SetCurrentProgressRate(calcDynamicEndurance * 100)
  progress_dynamicEndurance:SetProgressRate(calcDynamicEndurance * 100)
  progress_dynamicEndurance:SetAniSpeed(0)
  if 32767 ~= dynamicMaxEndurance then
  elseif 32767 ~= maxEndurance then
  else
    return false
  end
  local check_fishingRod = function(itemKey)
    if 17591 == itemKey or 17592 == itemKey or 17596 == itemKey or 17612 == itemKey or 17613 == itemKey or 17669 == itemKey then
      return true
    else
      return false
    end
  end
  local isCash = itemSSW:get():isCash()
  if true == isCash and false == check_fishingRod(itemSSW:get()._key:getItemKey()) then
    return false
  end
  return true
end
function PaGlobalFunc_FloatingTooltip_GetEnchantLevelStr(itemSSW)
  local enchantStr
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  if nil == enchantLevel then
    return enchantStr
  end
  if 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
  end
  if enchantLevel > 0 and enchantLevel < 16 then
    enchantStr = "+" .. enchantLevel
  elseif 16 == enchantLevel then
    enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1")
    if true == _ContentsGroup_KoreanEnchantGrade then
      enchantStr = "\236\158\165"
    end
  elseif 17 == enchantLevel then
    enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2")
    if true == _ContentsGroup_KoreanEnchantGrade then
      enchantStr = "\234\180\145"
    end
  elseif 18 == enchantLevel then
    enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3")
    if true == _ContentsGroup_KoreanEnchantGrade then
      enchantStr = "\234\179\160"
    end
  elseif 19 == enchantLevel then
    enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4")
    if true == _ContentsGroup_KoreanEnchantGrade then
      enchantStr = "\236\156\160"
    end
  elseif 20 == enchantLevel then
    enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5")
    if true == _ContentsGroup_KoreanEnchantGrade then
      enchantStr = "\235\143\153"
    end
  else
    enchantStr = nil
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and false == ToClient_IsSpecialEnchantItem(itemSSW:get()._key) then
    if 1 == enchantLevel then
      enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_1")
      if true == _ContentsGroup_KoreanEnchantGrade then
        enchantStr = "\236\158\165"
      end
    elseif 2 == enchantLevel then
      enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_2")
      if true == _ContentsGroup_KoreanEnchantGrade then
        enchantStr = "\234\180\145"
      end
    elseif 3 == enchantLevel then
      enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_3")
      if true == _ContentsGroup_KoreanEnchantGrade then
        enchantStr = "\234\179\160"
      end
    elseif 4 == enchantLevel then
      enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_4")
      if true == _ContentsGroup_KoreanEnchantGrade then
        enchantStr = "\236\156\160"
      end
    elseif 5 == enchantLevel then
      enchantStr = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ENCHANTLEVEL_5")
      if true == _ContentsGroup_KoreanEnchantGrade then
        enchantStr = "\235\143\153"
      end
    end
  end
  if itemSSW:get():isCash() then
    enchantStr = nil
  end
  local isCash = itemSSW:get():isCash()
  local balksCount = itemSSW:getExtractionCount_s64()
  local cronsCount = itemSSW:getCronCount_s64()
  if false == isCash and nil ~= balksCount and toInt64(0, 0) ~= balksCount and nil ~= cronsCount and toInt64(0, 0) ~= cronsCount then
    enchantStr = nil
  end
  return enchantStr
end
function FromClient_FloatingTooltip_PadSnapChangeTarget()
  self:close()
end
function PaGlobalFunc_FloatingTooltip_GetShow()
  return _panel:GetShow()
end
