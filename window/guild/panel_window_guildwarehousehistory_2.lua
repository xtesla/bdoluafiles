function FromClient_getGuildWareHouseHistory()
  PaGlobal_GuildWareHouseHistory:open()
end
function PaGlobal_GuildWareHouseHistory_CreateControlList2(content, key)
  local self = PaGlobal_GuildWareHouseHistory
  local index = Int64toInt32(key)
  local wrapper = ToClient_guildWareHouseHistoryWrapper(index)
  if nil == wrapper then
    return
  end
  content:SetIgnore(true)
  local txt_info = UI.getChildControl(content, "StaticText_Content")
  local txt_date = UI.getChildControl(content, "StaticText_Date")
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local itemIcon = UI.getChildControl(slotBg, "Static_ItemIcon")
  local itemCount = UI.getChildControl(slotBg, "StaticText_ItemCount")
  local txt = ""
  local itemSSW = getItemEnchantStaticStatus(wrapper:getItemEnchantKey())
  if nil ~= itemSSW then
    local slot = {}
    local itemStatic = itemSSW:get()
    local enchantLevel = itemStatic._key:getEnchantLevel()
    SlotItem.reInclude(slot, "GuildHistory_ItemIcon_", 0, itemIcon, PaGlobal_GuildWareHouseHistory._slotConfig)
    slot:setItemByStaticStatus(itemSSW)
    slotBg:SetIgnore(not _ContentsGroup_UsePadSnapping)
    itemIcon:SetIgnore(_ContentsGroup_UsePadSnapping)
    if true == _ContentsGroup_RenewUI_Tooltip then
      slotBg:addInputEvent("Mouse_On", "HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip( true ," .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
      slotBg:addInputEvent("Mouse_Out", "HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip( false )")
      slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_GuildWareHouseHistory_ShowDetailTooltip(" .. wrapper:getItemEnchantKey():get() .. " )")
    elseif true == _ContentsGroup_UsePadSnapping then
      slotBg:addInputEvent("Mouse_On", "PaGlobal_GuildWareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
      slotBg:addInputEvent("Mouse_Out", "PaGlobal_GuildWareHouseHistory:itemTooltipHide()")
    else
      itemIcon:addInputEvent("Mouse_On", "PaGlobal_GuildWareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
      itemIcon:addInputEvent("Mouse_Out", "PaGlobal_GuildWareHouseHistory:itemTooltipHide()")
    end
    itemCount:SetText(tostring(wrapper:getItemCount()))
    if true == wrapper:isPush() then
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_PUSH", "userNickName", wrapper:getUserNickName())
    else
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_POP", "userNickName", wrapper:getUserNickName())
    end
  end
  txt_info:SetText(txt)
  local paTime = PATime(wrapper:getRegisterDate())
  local registerDate = tostring(paTime:GetYear()) .. "." .. tostring(paTime:GetMonth()) .. "." .. tostring(paTime:GetDay())
  txt_date:SetText(registerDate)
end
function HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip(isShow, index, itemEnchantKey)
  if false == isShow then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    local content = PaGlobal_GuildWareHouseHistory._ui._list2_logList:GetContentByKey(index)
    local slotBg = UI.getChildControl(content, "Static_SlotBg")
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, slotBg, "WareHouse")
  end
end
function HandleEventRUp_GuildWareHouseHistory_ShowDetailTooltip(itemEnchantKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
