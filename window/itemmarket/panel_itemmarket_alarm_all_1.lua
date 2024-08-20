function PaGlobal_ItemMarketAlarm:initialize()
  if true == PaGlobal_ItemMarketAlarm._initialize then
    return
  end
  PaGlobal_ItemMarketAlarm._ui._stc_itemIcon = UI.getChildControl(Panel_ItemMarket_Alarm_All, "Static_Slot_Icon")
  PaGlobal_ItemMarketAlarm._ui._txt_itemName = UI.getChildControl(Panel_ItemMarket_Alarm_All, "StaticText_Slot_ItemName")
  PaGlobal_ItemMarketAlarm._ui._txt_price = UI.getChildControl(Panel_ItemMarket_Alarm_All, "StaticText_Price_Value")
  PaGlobal_ItemMarketAlarm._ui._txt_itemRegistTime = UI.getChildControl(Panel_ItemMarket_Alarm_All, "MultilineText_Desc")
  PaGlobal_ItemMarketAlarm._ui._btn_confirm = UI.getChildControl(Panel_ItemMarket_Alarm_All, "Button_Confirm")
  PaGlobal_ItemMarketAlarm._ui._btn_cancel = UI.getChildControl(Panel_ItemMarket_Alarm_All, "Button_AlarmCancel")
  PaGlobal_ItemMarketAlarm:registEventHandler()
  PaGlobal_ItemMarketAlarm:validate()
  PaGlobal_ItemMarketAlarm._defaultSizeY = Panel_ItemMarket_Alarm_All:GetSizeY()
  PaGlobal_ItemMarketAlarm._consoleSizeY = Panel_ItemMarket_Alarm_All:GetSizeY() - PaGlobal_ItemMarketAlarm._ui._btn_confirm:GetSizeY() - PaGlobal_ItemMarketAlarm._ui._btn_confirm:GetSpanSize().y * 2
  PaGlobal_ItemMarketAlarm._initialize = true
end
function PaGlobal_ItemMarketAlarm:registEventHandler()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  PaGlobal_ItemMarketAlarm._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGloabl_ItemMarketAlarm_Close()")
  PaGlobal_ItemMarketAlarm._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGloabl_ItemMarketAlarm_Close()")
end
function PaGlobal_ItemMarketAlarm:prepareOpen(itemKey, price)
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  local itemStaticStatus = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemStaticStatus then
    return
  end
  PaGlobal_ItemMarketAlarm._ui._stc_itemIcon:ChangeTextureInfoNameDefault("icon/" .. itemStaticStatus:getIconPath())
  local enchantLevel = itemStaticStatus:get()._key:getEnchantLevel()
  local itemName = itemStaticStatus:getName()
  if enchantLevel > 0 then
    if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemStaticStatus:getItemClassify() and false == itemStaticStatus:isSpecialEnchantItem() then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel + 15) .. " " .. itemStaticStatus:getName()
    elseif 1 == itemStaticStatus:getItemType() and enchantLevel > 15 then
      itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. itemStaticStatus:getName()
    end
  end
  PaGlobal_ItemMarketAlarm._ui._txt_itemName:SetText(itemName)
  PaGlobal_ItemMarketAlarm._ui._txt_price:SetText(tostring(price))
  local paTime = PATime(getServerUtc64())
  local descStr = ""
  if true == _ContentsGroup_UsePadSnapping then
    descStr = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ALARM_NOTIFY_ALL_CONSOLE", "mon", tostring(paTime:GetMonth()), "day", tostring(paTime:GetDay()), "time", tostring(paTime:GetHour()), "min", tostring(paTime:GetMinute()))
    PaGlobal_ItemMarketAlarm._ui._btn_confirm:SetShow(false)
    Panel_ItemMarket_Alarm_All:SetSize(Panel_ItemMarket_Alarm_All:GetSizeX(), PaGlobal_ItemMarketAlarm._consoleSizeY)
  else
    descStr = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_ITEMMARKET_ALARM_NOTIFY_ALL", "mon", tostring(paTime:GetMonth()), "day", tostring(paTime:GetDay()), "time", tostring(paTime:GetHour()), "min", tostring(paTime:GetMinute()))
    PaGlobal_ItemMarketAlarm._ui._btn_confirm:SetShow(true)
    Panel_ItemMarket_Alarm_All:SetSize(Panel_ItemMarket_Alarm_All:GetSizeX(), PaGlobal_ItemMarketAlarm._defaultSizeY)
  end
  PaGlobal_ItemMarketAlarm._ui._txt_itemRegistTime:SetText(descStr)
  PaGlobal_ItemMarketAlarm:open()
end
function PaGlobal_ItemMarketAlarm:open()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  Panel_ItemMarket_Alarm_All:SetShow(true)
end
function PaGlobal_ItemMarketAlarm:prepareClose()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  PaGlobal_ItemMarketAlarm:close()
end
function PaGlobal_ItemMarketAlarm:close()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  Panel_ItemMarket_Alarm_All:SetShow(false)
end
function PaGlobal_ItemMarketAlarm:validate()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  PaGlobal_ItemMarketAlarm._ui._stc_itemIcon:isValidate()
  PaGlobal_ItemMarketAlarm._ui._txt_itemName:isValidate()
  PaGlobal_ItemMarketAlarm._ui._txt_price:isValidate()
  PaGlobal_ItemMarketAlarm._ui._txt_itemRegistTime:isValidate()
  PaGlobal_ItemMarketAlarm._ui._btn_confirm:isValidate()
  PaGlobal_ItemMarketAlarm._ui._btn_cancel:isValidate()
end
