ToClient_SetActionStatusPanel(Panel_CharacterActionStatus)
ToClient_InitializeActionStatusPanelPool(500)
function PaGlobal_CharacterActionStatus:initialize()
  if true == self._initialize then
    return
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CharacterActionStatus:registEventHandler()
  if nil == Panel_CharacterActionStatus then
    return
  end
  registerEvent("FromClient_NotifyPlayerGuardType", "FromClient_NotifyPlayerGuardType")
  registerEvent("FromClient_NotifyPlayerAvoid", "FromClient_NotifyPlayerAvoid")
end
function PaGlobal_CharacterActionStatus:prepareOpen()
  if nil == Panel_CharacterActionStatus then
    return
  end
  self:open()
end
function PaGlobal_CharacterActionStatus:open()
  if nil == Panel_CharacterActionStatus then
    return
  end
  Panel_CharacterActionStatus:SetShow(true)
end
function PaGlobal_CharacterActionStatus:prepareClose()
  if nil == Panel_CharacterActionStatus then
    return
  end
  self:close()
end
function PaGlobal_CharacterActionStatus:close()
  if nil == Panel_CharacterActionStatus then
    return
  end
  Panel_CharacterActionStatus:SetShow(false)
end
function PaGlobal_CharacterActionStatus:update(actorKey, guardType)
  if nil == Panel_CharacterActionStatus then
    return
  end
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getActionStatusUIPanel()
  if nil == panel then
    return
  end
  local superArmor = UI.getChildControl(panel, "Static_Icon_SuperArmor")
  local defence = UI.getChildControl(panel, "Static_Icon_Defence")
  local avoid = UI.getChildControl(panel, "Static_Icon_Avoid")
  local superDefence_armor = UI.getChildControl(panel, "Static_Icon_SuperDefence_Armor")
  local superDefence_defence = UI.getChildControl(panel, "Static_Icon_SuperDefence_Defence")
  if guardType == CppEnums.GuardType.eGuardType_None then
    panel:SetShow(false)
    superArmor:SetShow(false)
    defence:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  panel:SetShow(true)
  if guardType == CppEnums.GuardType.eGuardType_SuperArmor then
    defence:SetShow(false)
    superArmor:SetShow(true)
    superArmor:EraseAllEffect()
    superArmor:AddEffect("fUI_Judgment_SuperArmor_01A", true, 0, 0)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == CppEnums.GuardType.eGuardType_Defence then
    defence:SetShow(true)
    defence:EraseAllEffect()
    defence:AddEffect("fUI_Judgment_Defence_01A", true, 0, 0)
    superArmor:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == CppEnums.GuardType.eGuardType_Avoid then
    defence:SetShow(false)
    superArmor:SetShow(false)
    avoid:SetShow(true)
    avoid:EraseAllEffect()
    avoid:AddEffect("fUI_Judgment_Avoid_01A", true, 0, 0)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == CppEnums.GuardType.eGuardType_SuperDefence then
    defence:SetShow(false)
    superArmor:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(true)
    superDefence_defence:SetShow(true)
    superDefence_armor:EraseAllEffect()
    superDefence_defence:EraseAllEffect()
    superDefence_armor:AddEffect("fUI_Judgment_SuperArmor_01A", true, 0, 0)
    superDefence_defence:AddEffect("fUI_Judgment_Defence_01A", true, 0, 0)
    return
  end
end
function PaGlobal_CharacterActionStatus:updateAvoid(actorKey, guardType)
  if nil == Panel_CharacterActionStatus then
    return
  end
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local panel = actorProxyWrapper:get():getActionStatusUIPanel()
  if nil == panel then
    return
  end
  local superArmor = UI.getChildControl(panel, "Static_Icon_SuperArmor")
  local defence = UI.getChildControl(panel, "Static_Icon_Defence")
  local avoid = UI.getChildControl(panel, "Static_Icon_Avoid")
  local superDefence_armor = UI.getChildControl(panel, "Static_Icon_SuperDefence_Armor")
  local superDefence_defence = UI.getChildControl(panel, "Static_Icon_SuperDefence_Defence")
  if guardType == CppEnums.GuardType.eGuardType_None then
    avoid:SetShow(false)
    avoid:SetSpanSize(95, 0)
    return
  end
  panel:SetShow(true)
  if guardType == CppEnums.GuardType.eGuardType_Avoid then
    avoid:SetShow(true)
    if true == superArmor:GetShow() or true == defence:GetShow() or true == superDefence_armor:GetShow() or true == superDefence_defence:GetShow() then
      avoid:SetSpanSize(170, 0)
    else
      avoid:SetSpanSize(95, 0)
    end
    avoid:EraseAllEffect()
    avoid:AddEffect("fUI_Judgment_Avoid_01A", true, 0, 0)
    return
  end
end
function PaGlobal_CharacterActionStatus:validate()
  if nil == Panel_CharacterActionStatus then
    return
  end
end
