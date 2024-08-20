function HandleEventLUp_ContentsName_updateAppleList()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
end
function PaGloabl_ItemMarketAlarm_Open(itemKey, price)
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  PaGlobal_ItemMarketAlarm:prepareOpen(itemKey, price)
end
function PaGloabl_ItemMarketAlarm_Close()
  if nil == Panel_ItemMarket_Alarm_All then
    return
  end
  PaGlobal_ItemMarketAlarm:prepareClose()
end
registerEvent("FromClient_OpenWaitItemAlarm", "PaGloabl_ItemMarketAlarm_Open")
