function HandleEventLUp_PersonalMonster_All_Close()
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  if true == PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:GetShow() then
    HandleEventPadUp_PersonalMonster_All_HideRewardItem()
    if true == _ContentsGroup_RenewUI_Tooltip and true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
    elseif false == _ContentsGroup_RenewUI_Tooltip then
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  PaGlobal_PersonalMonster_ALL:prepareClose()
end
function HandleEventLUp_PersonalMonster_All_Open()
  if true == Panel_PersonalMonster_All:GetShow() then
    PaGlobal_PersonalMonster_ALL:prepareClose()
    return
  end
  PaGlobal_PersonalMonster_ALL:prepareOpen()
end
function HandleEventLUp_PersonalMonster_All_NavigateToMonster(reserveIndex)
  local pos = ToClient_GetReservePersonalMonsterPosition(reserveIndex)
  if nil == pos then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
end
function FromClient_PersonalMonster_All_UpdateRewardList2(content, key)
  local self = PaGlobal_PersonalMonster_ALL
  if -1 == self._selectedMonsterIndexForConsole then
    return
  end
  local key32 = Int64toInt32(key)
  local monsterKey = ToClient_GetReservePersonalMonsterKey(self._selectedMonsterIndexForConsole)
  local monsterStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(monsterKey)
  local personalMonsterWrapper = ToClient_GetPersonalMonsterWrapper(monsterKey)
  if nil == monsterStatusWrapper or 0 == monsterKey or nil == personalMonsterWrapper then
    return
  end
  local btn_Item = UI.getChildControl(content, "Button_ItemBG")
  local stc_slotBg = UI.getChildControl(btn_Item, "Static_SlotBG")
  local txt_itemName = UI.getChildControl(btn_Item, "StaticText_ItemName")
  local itemKey = personalMonsterWrapper:getDropItemKey(key32)
  if nil == itemKey or 0 == itemKey then
    content:SetShow(false)
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    content:SetShow(false)
    return
  end
  content:SetShow(true)
  local tempIcon = {}
  SlotItem.reInclude(tempIcon, "console_RewardSlot_" .. tostring(idx), idx, stc_slotBg, self._slotConfig)
  tempIcon:setItemByStaticStatus(itemSSW)
  if false == self._isConsole then
    tempIcon.icon:addInputEvent("Mouse_On", "PaGlobalFunc_PersonalMonster_All_ShowToolTip(" .. itemKey .. ")")
    tempIcon.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    btn_Item:addInputEvent("Mouse_On", "HandleEventPadUp_PersonalMonster_All_ShowItemTooltip(" .. itemKey .. ")")
  else
    btn_Item:addInputEvent("Mouse_On", "PaGlobalFunc_PersonalMonster_All_ShowToolTip(" .. itemKey .. ")")
    btn_Item:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
  end
  txt_itemName:SetText(itemSSW:getName())
  if txt_itemName:GetSizeX() < txt_itemName:GetTextSizeX() then
    txt_itemName:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(txt_itemName)
  else
    txt_itemName:SetIgnore(true)
  end
  PaGlobal_PersonalMonster_ALL:convertTextToItemGradeColor(itemSSW, txt_itemName)
end
function HandleEventPadUp_PersonalMonster_All_ShowRewardItem(monsterIndex)
  local self = PaGlobal_PersonalMonster_ALL
  local monsterKey = ToClient_GetReservePersonalMonsterKey(monsterIndex)
  local monsterStatusWrapper = ToClient_GetCharacterStaticStatusWrapper(monsterKey)
  local personalMonsterWrapper = ToClient_GetPersonalMonsterWrapper(monsterKey)
  if nil ~= monsterKey and 0 ~= monsterKey and nil ~= monsterStatusWrapper and nil ~= personalMonsterWrapper then
    PaGlobal_PersonalMonster_ALL._ui.txt_ConsoleBossName:SetText(monsterStatusWrapper:getName())
    local dropCount = personalMonsterWrapper:getDropItemCount()
    self._ui.list2_itemList:getElementManager():clearKey()
    for idx = 0, dropCount - 1 do
      self._ui.list2_itemList:getElementManager():pushKey(idx)
    end
    self._selectedMonsterIndexForConsole = monsterIndex
    self._ui.stc_ConsoleItemList:SetShow(true)
  end
end
function HandleEventPadUp_PersonalMonster_All_ShowItemTooltip(itemKey)
  if nil == itemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, getScreenSizeX(), 0)
  end
end
function HandleEventPadUp_PersonalMonster_All_HideRewardItem()
  if false == PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:GetShow() then
    return
  end
  PaGlobal_PersonalMonster_ALL._ui.stc_ConsoleItemList:SetShow(false)
end
function FromClient_PersonalMonsterAll_UpdateMonsterList()
  if true == PaGlobal_PersonalMonster_ALL._isConsole then
    return
  end
  local count = ToClient_GetReservedPersonalMonsterCount()
  for ii = 0, count - 1 do
    local infoWrapper = ToClient_GetReservedPersonalMonsterInfoWrapper(ii)
    if nil ~= infoWrapper and nil ~= Panel_UIMain then
      FromClient_updateReservePersonalMonster(infoWrapper:getCharacterKey(), infoWrapper:getPositionIndex())
    end
  end
end
function FromClient_PersonalMonster_All_UpdateList2(content, key)
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  PaGlobal_PersonalMonster_ALL:updateList2Control(content, key)
end
function PaGlobal_PersonalMonster_ALL_OnScreenResize()
  if false == Panel_PersonalMonster_All:GetShow() then
    return
  end
  Panel_PersonalMonster_All:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.list2_Monster:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.txt_ClosedMsg:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.stc_Desc:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.txt_Desc:ComputePos()
  PaGlobal_PersonalMonster_ALL._ui.stc_SearchMsg:ComputePos()
  if true == PaGlobal_PersonalMonster_ALL._isConsole then
    Panel_PersonalMonster_All:SetSpanSize(Panel_PersonalMonster_All:GetSpanSize().x, PaGlobal_PersonalMonster_ALL._originPanelSpanY - 140)
    PaGlobal_PersonalMonster_ALL._ui.stc_Console_KeyGuides:SetPosY(Panel_PersonalMonster_All:GetSizeY())
  end
end
function GoPersonalMonsterPos(characterKey)
  if true == isRealServiceMode() then
    return
  end
  local monsterInfoWrapper = ToClient_FindReservedPersonalMonsterInfoWrapper(characterKey)
  if nil == monsterInfoWrapper then
    Proc_ShowMessage_Ack("Not Reserved Yet")
    return
  end
  local pos = monsterInfoWrapper:getSpawnPosition()
  ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
end
function CheckPersonalMonster(characterKey)
  if true == isRealServiceMode() then
    return
  end
  local monsterInfoWrapper = ToClient_FindReservedPersonalMonsterInfoWrapper(characterKey)
  if nil == monsterInfoWrapper then
    Proc_ShowMessage_Ack("Not Reserved Yet")
    return
  end
  local option = monsterInfoWrapper:getOption()
  local characterWrapper = ToClient_GetCharacterStaticStatusWrapper(characterKey)
  local strInfo = characterKey .. "(" .. characterWrapper:getName() .. ") : "
  local lv = monsterInfoWrapper:getLevel()
  if 0 == option then
    chatting_sendMessage("", strInfo .. "Not Reserved Yet", CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 1 == option then
    chatting_sendMessage("", strInfo .. "Spawned / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 2 == option then
    chatting_sendMessage("", strInfo .. "Reserved / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  elseif 3 == option then
    chatting_sendMessage("", strInfo .. "Reserved And Notified / Lv=" .. lv, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
  end
end
function CheckPersonalMonsterAll()
  if true == isRealServiceMode() then
    return
  end
  local count = ToClient_GetReservedPersonalMonsterCount()
  for ii = 0, count - 1 do
    local infoWrapper = ToClient_GetReservedPersonalMonsterInfoWrapper(ii)
    if nil ~= infoWrapper then
      CheckPersonalMonster(infoWrapper:getCharacterKey())
    end
  end
end
