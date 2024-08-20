function PaGlobal_GuildReward_All:initialize()
  if true == PaGlobal_GuildReward_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_RewardTitle = UI.getChildControl(Panel_GuildReward_All, "Static_TitleArea")
  self._ui_pc.btn_Exit = UI.getChildControl(stc_RewardTitle, "Button_Close")
  local stc_RewardBG = UI.getChildControl(Panel_GuildReward_All, "Static_SelectBG")
  self._ui._List2 = UI.getChildControl(stc_RewardBG, "List2_MainServerList")
  self._ui._Content = UI.getChildControl(self._ui._List2, "List2_1_Content")
  local stc_RewardGroup = UI.getChildControl(self._ui._Content, "Static_RewardGroup")
  local stc_RewardSlot = UI.getChildControl(stc_RewardGroup, "Static_RewardSlot")
  for idx = 0, self._COL_SLOT_COUNT - 1 do
    local slot = {}
    local itemlistSlot = UI.getChildControl(stc_RewardSlot, "Static_ItemSlot")
    SlotItem.new(slot, "Reward_Slot_" .. tostring(idx), idx, itemlistSlot, self._slotConfig)
    slot:createChild()
    slot.empty = true
    slot:clearItem()
  end
  self._ui._scroll_List2Vertical = UI.getChildControl(self._ui._List2, "List2_1_VerticalScroll")
  self._ui.stc_No_Itemlog = UI.getChildControl(stc_RewardBG, "StaticText_No_Itemlog")
  self._ui.stc_ItemLog = UI.getChildControl(Panel_GuildReward_All, "StaticText_ItemLog")
  self._ui.stc_TotalRewardKistory = UI.getChildControl(Panel_GuildReward_All, "Static_TotalRewardHistory")
  self._ui.stc_No_WidgetItemlog = UI.getChildControl(self._ui.stc_TotalRewardKistory, "StaticText_ItemLog_Widget_NoLog")
  self._ui._LogFrame = UI.getChildControl(self._ui.stc_TotalRewardKistory, "Frame_ItemLog")
  self._ui._LogContent = UI.getChildControl(self._ui._LogFrame, "Frame_1_Content")
  self._ui._scroll_Frame1Vertical = UI.getChildControl(self._ui._LogFrame, "Frame_1_VerticalScroll")
  self._ui._txt_dateTitleTemplate = UI.getChildControl(self._ui._LogContent, "StaticText_DateTitle_Template")
  self._ui._stc_itemLogTemplate = UI.getChildControl(self._ui._LogContent, "StaticText_ItemLog_Template")
  self._ui._txt_dateTitleTemplate:SetShow(false)
  self._ui._stc_itemLogTemplate:SetShow(false)
  PaGlobal_GuildReward_All:registEventHandler()
  PaGlobal_GuildReward_All:validate()
  PaGlobal_GuildReward_All._initialize = true
end
function PaGlobal_GuildReward_All:registEventHandler()
  if nil == Panel_GuildReward_All then
    return
  end
  if true == self._isConsole then
  else
    self._ui_pc.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_GuildReward_All_Close()")
  end
  self._ui.stc_ItemLog:addInputEvent("Mouse_LUp", "PaGlobal_GuildReward_All_HistoryToggle()")
  self._ui._List2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildReward_List2EventControlCreate")
  self._ui._List2:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_GuildRewardLoad", "FromClient_GuildReward_All_Load")
  registerEvent("FromClient_GuildRewardUpdate", "FromClient_GuildReward_All_Update")
  registerEvent("FromClient_GuildDrill_RewardNotify", "FromClient_GuildReward_All_Open")
end
function PaGlobal_GuildReward_All:prepareOpen()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:itemListUpdate()
  self._ui.stc_TotalRewardKistory:ComputePos()
  PaGlobal_GuildReward_All:logUpdate()
  PaGlobal_GuildReward_All:open()
end
function PaGlobal_GuildReward_All:open()
  if nil == Panel_GuildReward_All then
    return
  end
  Panel_GuildReward_All:SetShow(true)
end
function PaGlobal_GuildReward_All:prepareClose()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:close()
end
function PaGlobal_GuildReward_All:close()
  if nil == Panel_GuildReward_All then
    return
  end
  Panel_GuildReward_All:SetShow(false)
end
function PaGlobal_GuildReward_All:update()
  if nil == Panel_GuildReward_All then
    return
  end
end
function PaGlobal_GuildReward_All:validate()
  if nil == Panel_GuildReward_All then
    return
  end
  self._ui_pc.btn_Exit:isValidate()
  self._ui._List2:isValidate()
  self._ui._Content:isValidate()
  self._ui._scroll_List2Vertical:isValidate()
  self._ui.stc_No_Itemlog:isValidate()
  self._ui.stc_ItemLog:isValidate()
  self._ui.stc_TotalRewardKistory:isValidate()
  self._ui.stc_No_WidgetItemlog:isValidate()
  self._ui._LogFrame:isValidate()
  self._ui._LogContent:isValidate()
  self._ui._scroll_Frame1Vertical:isValidate()
  self._ui._txt_dateTitleTemplate:isValidate()
  self._ui._stc_itemLogTemplate:isValidate()
end
function PaGlobal_GuildReward_All:historyToggle()
  if nil == Panel_GuildReward_All then
    return
  end
  if true == self._ui.stc_TotalRewardKistory:GetShow() then
    self._ui.stc_TotalRewardKistory:SetShow(false)
    return
  end
  self._ui.stc_TotalRewardKistory:SetShow(true)
end
function PaGlobal_GuildReward_All:itemListUpdate()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All._ui._List2:getElementManager():clearKey()
  local rewardCount = ToClient_GetGuildPendingRewardCount()
  if 0 == rewardCount then
    self._ui.stc_No_Itemlog:SetShow(true)
    return
  end
  self._ui.stc_No_Itemlog:SetShow(false)
  for index = 0, rewardCount - 1 do
    PaGlobal_GuildReward_All._ui._List2:getElementManager():pushKey(toInt64(0, index))
    PaGlobal_GuildReward_All._ui._List2:requestUpdateByKey(toInt64(0, index))
  end
end
function PaGlobalFunc_GuildReward_List2EventControlCreate(list_content, key)
  if nil == Panel_GuildReward_All then
    return
  end
  local stc_RewardGroup = UI.getChildControl(list_content, "Static_RewardGroup")
  local stc_RewardSlot = UI.getChildControl(stc_RewardGroup, "Static_RewardSlot")
  local stc_BG = UI.getChildControl(stc_RewardSlot, "Static_BG")
  local stc_RewardTime = UI.getChildControl(stc_RewardSlot, "StaticText_RewardTime")
  local stc_TimeValue = UI.getChildControl(stc_RewardSlot, "StaticText_TimeValue")
  local stc_ItemSlot = UI.getChildControl(stc_RewardSlot, "Static_ItemSlot")
  local btn_Reward = UI.getChildControl(stc_RewardSlot, "Button_Reward")
  local stc_Icon = UI.getChildControl(stc_RewardSlot, "Static_Icon")
  local txt_GroupTitle = UI.getChildControl(stc_RewardGroup, "StaticText_GroupTitle")
  local index = Int64toInt32(key)
  stc_TimeValue:SetText(converStringFromLeftDateTime(ToClient_GetGuildPendingRewardExpireDateByIndex(index)))
  local itemListCount = ToClient_GetGuildPendingRewardItemListCountByIndex(index)
  if itemListCount > PaGlobal_GuildReward_All._COL_SLOT_COUNT then
    itemListCount = PaGlobal_GuildReward_All._COL_SLOT_COUNT
  end
  for idx = 0, PaGlobal_GuildReward_All._COL_SLOT_COUNT - 1 do
    if idx < itemListCount then
      local itemKey = ToClient_GetGuildPendingRewardItemKeyByIndex(index, idx)
      local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      local count = ToClient_GetGuildPendingRewardItemCountByIndex(index, idx)
      if nil ~= itemSSW then
        local slot = {}
        SlotItem.reInclude(slot, "Reward_Slot_" .. tostring(idx), idx, stc_ItemSlot, PaGlobal_GuildReward_All._slotConfig)
        slot:clearItem()
        slot:setItemByStaticStatus(itemSSW, Int64toInt32(count))
        slot.icon:SetPosX(2 + idx * 55)
        slot.icon:SetPosY(2)
        slot.icon:SetSize(42, 42)
        slot.border:SetSize(44, 44)
        slot.count:SetPosY(25)
      end
    else
      local slot = {}
      SlotItem.reInclude(slot, "Reward_Slot_" .. tostring(idx), idx, stc_ItemSlot, PaGlobal_GuildReward_All._slotConfig)
      slot:clearItem()
    end
  end
  stc_ItemSlot:SetShow(true)
  txt_GroupTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_CATEGORY_5") .. " " .. tostring(index + 1))
  btn_Reward:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildReward_All_RecieveReward( " .. index .. ")")
end
function PaGlobal_GuildReward_All:logUpdate()
  for index, control in pairs(self._itemLogControl) do
    if nil ~= control then
      control:SetShow(false)
    end
  end
  self._ui.stc_TotalRewardKistory:SetShow(true)
  local logCount = ToClient_GetGuildPendingRewardLogCount()
  if 0 == logCount then
    self._ui.stc_No_WidgetItemlog:SetShow(true)
    return
  end
  PaGlobal_GuildReward_All:setLogData(logCount)
  PaGlobal_GuildReward_All:setLogPosition()
  self._ui.stc_No_WidgetItemlog:SetShow(false)
  self._ui._LogFrame:UpdateContentScroll()
  self._ui._LogFrame:UpdateContentPos()
end
function PaGlobal_GuildReward_All:setLogData(logCount)
  self._logTable = {}
  local beforeMonth = 0
  local beforeDay = 0
  for ii = 1, logCount do
    local logDate = ToClient_GetGuildPendingRewardLogDateByIndex(ii - 1)
    local itemKey = ToClient_GetGuildPendingRewardLogItemKeyByIndex(ii - 1)
    local itemCount = ToClient_GetGuildPendingRewardLogItemCountByIndex(ii - 1)
    if nil == logDate or nil == itemKey or nil == itemCount then
      return
    end
    local timeValue = PATime(logDate)
    if beforeMonth ~= tostring(timeValue:GetMonth()) or beforeDay ~= tostring(timeValue:GetDay()) then
      local timeStr = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_TOTALREWARD_ITEMLOG_DATE", "month", tostring(timeValue:GetMonth()), "day", tostring(timeValue:GetDay()))
      self._logTable[#self._logTable + 1] = {}
      self._logTable[#self._logTable].text = timeStr
      self._logTable[#self._logTable].color = Defines.Color.C_FFFFFFFF
    end
    beforeMonth = tostring(timeValue:GetMonth())
    beforeDay = tostring(timeValue:GetDay())
    local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil == itemStatic then
      return
    end
    local itemNameColor = self:getItemGradeColor(itemStatic:getGradeType())
    local itemName = "<PAColor0x" .. itemNameColor .. ">[" .. itemStatic:getName() .. "]<PAOldColor>"
    local logText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILDREWARD_ITEMLOG_TEXT", "itemName", itemName, "itemCount", makeDotMoney(itemCount))
    self._logTable[#self._logTable + 1] = {}
    self._logTable[#self._logTable].text = logText
  end
end
function PaGlobal_GuildReward_All:setLogPosition()
  local nextPosY = 0
  for ii = 1, #self._logTable do
    if nil == self._logTable[ii] then
      return
    end
    local control = self._itemLogControl[ii]
    if nil == control then
      if self._logTable[ii].color ~= nil then
        control = UI.createAndCopyBasePropertyControl(self._ui._LogContent, "StaticText_DateTitle_Template", self._ui._LogContent, "GuildReward_ItemLog_" .. ii)
      else
        control = UI.createAndCopyBasePropertyControl(self._ui._LogContent, "StaticText_ItemLog_Template", self._ui._LogContent, "GuildReward_ItemLog_" .. ii)
      end
      if nil ~= control then
        self._itemLogControl[ii] = control
      end
    else
      local template
      if self._logTable[ii].color ~= nil then
        template = self._ui._txt_dateTitleTemplate
      else
        template = self._ui._stc_itemLogTemplate
      end
      CopyBaseProperty(template, control)
    end
    if nil == control then
      return
    end
    control:SetShow(true)
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetText(self._logTable[ii].text)
    control:SetPosY(nextPosY)
    control:SetSize(control:GetSizeX(), control:GetTextSizeY() + 2)
    if self._logTable[ii].color ~= nil then
      control:SetFontColor(self._logTable[ii].color)
      nextPosY = nextPosY + 10
      control:SetPosY(nextPosY)
      nextPosY = nextPosY + 5
    else
      control:ChangeTextureInfoName("")
      control:setRenderTexture(control:getBaseTexture())
    end
    nextPosY = nextPosY + control:GetTextSizeY() + 5
  end
  self._ui._LogContent:SetSize(self._ui._LogFrame:GetSizeX(), nextPosY)
end
function PaGlobal_GuildReward_All:getItemGradeColor(grade)
  local itemNameColor = "FFFFFFFF"
  if 0 == grade then
    itemNameColor = "FFFFFFFF"
  elseif 1 == grade then
    itemNameColor = "FF5DFF70"
  elseif 2 == grade then
    itemNameColor = "FF4B97FF"
  elseif 3 == grade then
    itemNameColor = "FFFFC832"
  elseif 4 == grade then
    itemNameColor = "FFFF6C00"
  end
  return itemNameColor
end
function PaGlobal_Test1()
  ToClient_requestGuildDrillStart()
end
