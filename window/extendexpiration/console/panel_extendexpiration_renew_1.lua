function PaGlobal_ExtendExpiration_Renew:initialize()
  if true == PaGlobal_ExtendExpiration_Renew._initialize then
    return
  end
  self._ui._static_Effect = UI.getChildControl(Panel_ExtendExpiration_Renew, "Static_Effect")
  self._ui._static_materialSlot = UI.getChildControl(Panel_ExtendExpiration_Renew, "Static_Slot_0")
  self._ui._static_Slot = UI.getChildControl(Panel_ExtendExpiration_Renew, "Static_Slot_1")
  self._ui._desc = UI.getChildControl(Panel_ExtendExpiration_Renew, "Static_GuideText")
  self._ui._bottomBg = UI.getChildControl(Panel_ExtendExpiration_Renew, "Static_BottomBg")
  self._ui._keyguideY = UI.getChildControl(self._ui._bottomBg, "StaticText_Y_ConsoleUI")
  self._ui._keyguideB = UI.getChildControl(self._ui._bottomBg, "StaticText_B_ConsoleUI")
  PaGlobal_ExtendExpiration_Renew:registEventHandler()
  PaGlobal_ExtendExpiration_Renew:validate()
  PaGlobal_ExtendExpiration_Renew:createIconSlot()
  PaGlobal_ExtendExpiration_Renew._initialize = true
end
function PaGlobal_ExtendExpiration_Renew:registEventHandler()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  registerEvent("FromClient_ClickedExtendExpirationPeriodMaterial", "FromClient_ClickedExtendExpirationPeriodMaterial")
  registerEvent("FromClient_SucceedExtendedExpirationPeriod", "FromClient_SucceedExtendedExpirationPeriod")
  Panel_ExtendExpiration_Renew:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobalFunc_ExtendExpiration_Renew_RequestExtendExpiration()")
end
function PaGlobal_ExtendExpiration_Renew:prepareOpen(materialWhereType, materialSlotNo)
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  local materialItemWrapper = getInventoryItemByType(materialWhereType, materialSlotNo)
  if nil == materialItemWrapper then
    return
  end
  local materialItemSSW = materialItemWrapper:getStaticStatus()
  if nil == materialItemSSW then
    return
  end
  PaGlobal_ExtendExpiration_Renew._ui.material:setItemByStaticStatus(materialItemSSW, toInt64(0, 1), nil, nil, nil)
  PaGlobal_ExtendExpiration_Renew.config.materialWhereType = materialWhereType
  PaGlobal_ExtendExpiration_Renew.config.materialSlotNo = materialSlotNo
  PaGlobal_ExtendExpiration_Renew.config.materialCount = toInt64(0, 1)
  PaGlobal_ExtendExpiration_Renew.config.materialExtendExpirationType = materialItemSSW:getExtendExpirationPeriodType()
  Inventory_SetFunctor(PaGlobalFunc_ExtendExpiration_Renew_Inventory_Filter, PaGlobalFunc_ExtendExpiration_Renew_Inventory_Rclick, PaGlobalFunc_ExtendExpiration_Renew_Close, nil)
  Panel_ExtendExpiration_Renew:ComputePos()
  PaGlobal_ExtendExpiration_Renew:SetAlignKeyguide()
  PaGlobal_ExtendExpiration_Renew:open()
end
function PaGlobal_ExtendExpiration_Renew:open()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  Panel_ExtendExpiration_Renew:SetShow(true)
end
function PaGlobal_ExtendExpiration_Renew:prepareClose()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  PaGlobal_ExtendExpiration_Renew.config.materialWhereType = 0
  PaGlobal_ExtendExpiration_Renew.config.materialSlotNo = 0
  PaGlobal_ExtendExpiration_Renew.config.materialCount = toInt64(0, 0)
  PaGlobal_ExtendExpiration_Renew.config.materialMaxCount = toInt64(0, 0)
  PaGlobal_ExtendExpiration_Renew.config.materialExtendExpirationType = 0
  PaGlobal_ExtendExpiration_Renew.config.isSetItem = false
  PaGlobal_ExtendExpiration_Renew.config.targetWhereType = 0
  PaGlobal_ExtendExpiration_Renew.config.targetSlotNo = 0
  PaGlobal_ExtendExpiration_Renew._ui.material:clearItem()
  PaGlobal_ExtendExpiration_Renew._ui.item:clearItem()
  Inventory_SetFunctor(nil, nil, nil, nil)
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_SetShow(true)
    else
      Equipment_SetShow(true)
    end
  end
  PaGlobal_ExtendExpiration_Renew:close()
end
function PaGlobal_ExtendExpiration_Renew:close()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  Panel_ExtendExpiration_Renew:SetShow(false)
end
function PaGlobal_ExtendExpiration_Renew:update()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
end
function PaGlobal_ExtendExpiration_Renew:validate()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  self._ui._static_Effect:isValidate()
  self._ui._static_materialSlot:isValidate()
  self._ui._static_Slot:isValidate()
  self._ui._desc:isValidate()
end
function PaGlobal_ExtendExpiration_Renew:createIconSlot()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  SlotItem.new(self._ui.material, "ExtendExpirationmaterialItem_" .. 0, 0, self._ui._static_materialSlot, self.materialSlotConfig)
  self._ui.material:createChild()
  SlotItem.new(self._ui.item, "ExtendExpirationItem_" .. 0, 0, self._ui._static_Slot, self.slotConfig)
  self._ui.item:createChild()
  self._ui._desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._desc:SetText(self._ui._desc:GetText())
  if 30 < self._ui._desc:GetTextSizeY() then
    self._ui._desc:SetSize(self._ui._desc:GetSizeX(), self._ui._desc:GetTextSizeY() + 10)
  else
    self._ui._desc:SetSize(self._ui._desc:GetSizeX(), 30)
  end
end
function PaGlobal_ExtendExpiration_Renew:SetAlignKeyguide()
  if nil == Panel_ExtendExpiration_Renew then
    return
  end
  if true == _ContentsGroup_RenewUI then
    local keyguide = {
      self._ui._keyguideY,
      self._ui._keyguideB
    }
    self._ui._keyguides = keyguide
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyguides, self._ui._bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
