function PaGlobal_House_InstallationSiege_All_CreateSiegeInstallationList2(content, index)
  local key = Int64toInt32(index)
  local characterWrapper = ToClient_getSiegeInstallableListByIndex(key)
  if nil == characterWrapper then
    return
  end
  local radioButton = UI.getChildControl(content, "RadioButton_1")
  local stc_itemTemp = UI.getChildControl(radioButton, "Static_Item_Templete")
  local txt_shortCut = UI.getChildControl(stc_itemTemp, "StaticText_ShortCut")
  radioButton:SetText(characterWrapper:getName())
  radioButton:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(" .. key .. ")")
  txt_shortCut:SetText("")
  txt_shortCut:ChangeTextureInfoName("Icon/" .. ToClient_getSiegeInstallationCharacterIconPath(key))
  stc_itemTemp:addInputEvent("Mouse_LUp", "PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(" .. key .. ")")
  stc_itemTemp:addInputEvent("Mouse_On", "HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(true," .. tostring(key) .. ")")
  stc_itemTemp:addInputEvent("Mouse_Out", "HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(false)")
  PaGlobal_House_InstallationSiege_All._radioBtnSlot[key] = radioButton
end
function PaGlobal_House_InstallationSiege_All_RequestSiegeInstallationStart(index)
  PaGlobal_House_InstallationSiege_All:requestSiegeInstallationStart(index)
end
function PaGlobal_House_InstallationSiege_All_EndBuildTent()
  PaGlobal_House_InstallationSiege_All:endBuildTent()
end
function HandleEventLUp_House_InstallationSiege_All_EditItemNameClear()
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText("", true)
  SetFocusEdit(PaGlobal_House_InstallationSiege_All._ui._edit_searchBox)
  PaGlobal_House_InstallationSiege_All._ui._txt_searchIcon:SetShow(false)
end
function HandleEventKey_House_InstallationSiege_All_FindItemName()
  local inputKeyword = PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:GetEditText()
  ClearFocusEdit()
  ToClient_clearFilterSiegeInstallationList()
  ToClient_searchFilterSiegeInstallationList(inputKeyword)
  PaGlobal_House_InstallationSiege_All:createSiegeInstallationList()
end
function HandleEventKey_House_InstallationSiege_All_FindItemName_ForConsole(str)
  local inputKeyword = str
  if nil == inputKeyword then
    inputKeyword = ""
  end
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText(inputKeyword)
  ClearFocusEdit()
  ToClient_clearFilterSiegeInstallationList()
  ToClient_searchFilterSiegeInstallationList(inputKeyword)
  PaGlobal_House_InstallationSiege_All:createSiegeInstallationList()
  PaGlobal_House_InstallationSiege_All:firstItemSnapping()
end
function HandleEventOnOut_House_InstallationSiege_All_ShowInstallationTooltip(isShow, key)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == key then
    return
  end
  local characterWrapper = ToClient_getSiegeInstallableListByIndex(key)
  if nil == characterWrapper then
    return
  end
  local radioButton = PaGlobal_House_InstallationSiege_All._radioBtnSlot[key]
  if nil == radioButton then
    return
  end
  local control = UI.getChildControl(radioButton, "Static_Item_Templete")
  if nil == control then
    return
  end
  local name = characterWrapper:getName()
  local desc = ToClient_getSiegeBuildKitInstallationDesc(key)
  TooltipSimple_Show(control, name, desc)
  TooltipSimple_Common_Pos(PaGlobal_House_InstallationSiege_All._ui._stc_backGround:GetPosX() - Panel_Tooltip_SimpleText:GetSizeX(), Panel_Tooltip_SimpleText:GetPosY())
end
function FromClient_House_InstallationSiege_All_UpdateItemInventory()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationSiege_All:updateItemSetData(true)
  PaGlobal_House_InstallationSiege_All:updateItemSlot(PaGlobal_House_InstallationSiege_All._startItemSlotIndex)
end
function FromClient_House_InstallationSiege_All_CancelInstallModeMessageBox()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  PaGlobal_House_Installation_All_CancelInstallModeMessageBox()
end
function PaGlobal_House_InstallationSiege_All_ShowAni()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
end
function PaGlobal_House_InstallationSiege_All_HideAni()
  if nil == Panel_House_InstallationMode_Siege_All then
    return
  end
end
function PaGlobal_House_InstallationSiege_All_Open()
  PaGlobal_House_InstallationSiege_All:prepareOpen()
end
function PaGlobal_House_InstallationSiege_All_Close()
  PaGlobal_House_InstallationSiege_All:prepareClose()
end
function PaGlobal_House_InstallationSiege_All_GetShowPanel()
  if nil == Panel_House_InstallationMode_Siege_All then
    return false
  end
  return Panel_House_InstallationMode_Siege_All:GetShow()
end
function PaGlobal_House_InstallationSiege_All_SetSearchFocus()
  ClearFocusEdit()
  PaGlobal_House_InstallationSiege_All._ui._edit_searchBox:SetEditText("", false)
  SetFocusEdit(PaGlobal_House_InstallationSiege_All._ui._edit_searchBox)
  PaGlobal_House_InstallationSiege_All._ui._txt_searchIcon:SetShow(false)
end
function PaGlobal_House_InstallationSiege_All_SetKeyGuide(modeState)
  PaGlobal_House_InstallationSiege_All:setKeyGuide(modeState)
end
function PaGlobal_House_InstallationSiege_All_OnScreenResize()
  PaGlobal_House_InstallationSiege_All:resize()
end
function PaGlobal_House_InstallationSiege_All_FromClient_OpenSiegeInstallationList(itemEnchantKey)
  if nil == itemEnchantKey then
    return
  end
  PaGlobal_House_InstallationSiege_All._itemEnchantKey = itemEnchantKey
  PaGlobal_House_InstallationSiege_All_Open()
end
function PaGlobal_House_InstallationSiege_All_FromClient_InventoryUpdate()
  if false == PaGlobal_House_InstallationSiege_All_GetShowPanel() then
    return
  end
  PaGlobal_House_InstallationSiege_All:checkRemainTentKitItemCount()
  self._currentSelectedIndex = nil
end
