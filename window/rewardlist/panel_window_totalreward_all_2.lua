function PaGlobal_TotalReward_All_Open()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  if Panel_Window_TotalReward_All:GetShow() then
    PaGlobal_TotalReward_All_Close()
  else
    PaGlobal_TotalReward_All:prepareOpen()
  end
end
function PaGlobal_TotalReward_All_OpenWhenOtherPanel(panelIndex)
  if nil == Panel_Window_TotalReward_All then
    return
  end
  local otherPanel
  if PaGlobal_TotalReward_All._otherPanelIndex.mail == panelIndex then
    otherPanel = Panel_Window_Mail_All
  elseif PaGlobal_TotalReward_All._otherPanelIndex.challenge == panelIndex then
    otherPanel = Panel_CharacterInfo_All
  elseif PaGlobal_TotalReward_All._otherPanelIndex.mailDetail == panelIndex then
    otherPanel = Panel_Window_MailDetail_All
  else
    return
  end
  if nil == otherPanel then
    return
  end
  if false == Panel_Window_TotalReward_All:GetShow() then
    PaGlobal_TotalReward_All:prepareOpen()
  end
  local otherPanelPosX = otherPanel:GetPosX()
  local otherPanelPosY = otherPanel:GetPosY()
  local otherPanelSizeX = otherPanel:GetSizeX()
  local gabX = 10
  Panel_Window_TotalReward_All:SetPosX(otherPanelPosX + otherPanelSizeX + gabX)
  Panel_Window_TotalReward_All:SetPosY(otherPanelPosY)
  if true == PaGlobal_TotalRewardHistory_All_IsShow() then
    PaGlobal_TotalRewardHistory_All_ToggleShow()
    PaGlobal_TotalReward_All:setHistoryIcon(true)
  end
end
function PaGlobal_TotalReward_All_Close()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:prepareClose()
end
function PaGlobal_TotalReward_All_ConfirmReceiveSilver()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  local receiveType = MessageBoxCheck.isCheck()
  if nil == receiveType then
    return
  end
  if 0 < #PaGlobal_TotalReward_All._rewardSilverIndex then
    for ii = 1, #PaGlobal_TotalReward_All._rewardSilverIndex do
      local itemIdx = PaGlobal_TotalReward_All._rewardSilverIndex[ii]
      if nil ~= itemIdx then
        local itemKey = ToClient_GetPendingRewardItemKeyByIndex(itemIdx)
        if nil ~= itemKey and 1 == itemKey then
          ToClient_ReceivePendingReward(itemIdx, receiveType)
        end
      end
    end
    audioPostEvent_SystemUi(3, 12)
  end
end
function PaGlobal_TotalReward_All_ConfirmReceiveAll()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  for rewardKey, rewardDatas in pairs(PaGlobal_TotalReward_All._itemDatas) do
    for index, itemDatas in pairs(rewardDatas) do
      local rewardKey = itemDatas.rewardKey
      local itemKey = itemDatas.itemKey
      local itemCnt = itemDatas.itemCnt
      if nil ~= rewardKey and nil ~= itemKey and nil ~= itemCnt and 1 ~= itemKey then
        PaGlobal_TotalReward_All:receiveItem(rewardKey, index, false)
      end
    end
  end
end
function HandleEventOn_TotalReward_All_SlotTooltip(rewardKey, index, slotIndex, isOn)
  if nil == rewardKey or nil == index or nil == slotIndex or nil == isOn then
    return
  end
  if nil == PaGlobal_TotalReward_All._itemDatas[rewardKey] or nil == PaGlobal_TotalReward_All._itemDatas[rewardKey][index] then
    return
  end
  local panelPosX = Panel_Window_TotalReward_All:GetPosX()
  local panelSizeX = Panel_Window_TotalReward_All:GetSizeX()
  local screenSizeX = getScreenSizeX()
  local tooltipX = 0
  local tooltipPanel
  if true == _ContentsGroup_NewUI_Tooltip_All then
    tooltipPanel = Panel_Widget_Tooltip_Item_All
  else
    tooltipPanel = Panel_Tooltip_Item
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if screenSizeX < panelPosX + panelSizeX + tooltipPanel:GetSizeX() then
      tooltipX = panelPosX - tooltipPanel:GetSizeX()
    else
      tooltipX = panelPosX + panelSizeX
    end
  elseif screenSizeX < panelPosX + panelSizeX + tooltipPanel:GetSizeX() then
    tooltipX = panelPosX - tooltipPanel:GetSizeX()
  else
    tooltipX = panelPosX + panelSizeX
  end
  Panel_Tooltip_Item_Show_GeneralStatic(slotIndex, "totalReward", isOn, false, tooltipX, Panel_Window_TotalRewardHistory_All:GetPosY())
end
function HandlePadEventX_TotalReward_All_SlotTooltip(itemKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  if nil == itemKey then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemStatic then
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemStatic, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function HandleEventRUp_TotalReward_All_ReceiveSlot(rewardKey, index)
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:receiveItem(rewardKey, index, false)
end
function HandleEventLUp_TotalReward_All_ReceiveSilver()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:receiveSilver()
end
function HandleEventLUp_TotalReward_All_ReceiveAll()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  PaGlobal_TotalReward_All:receiveAll()
end
function HandleEventLUp_TotalReward_All_History_ToggleShow()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  local isOn = PaGlobal_TotalRewardHistory_All_IsShow()
  PaGlobal_TotalReward_All:setHistoryIcon(isOn)
  PaGlobal_TotalRewardHistory_All_ToggleShow()
end
function FromClient_TotalReward_All_PendingRewardUpdated()
  PaGlobal_TotalReward_All:update()
end
function PaGlobal_TotalReward_Refresh_FromWeb()
  if nil == Panel_Window_TotalReward_All then
    return
  end
  ToClient_LoadPendingRewardXXX()
end
