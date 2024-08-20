function HandleEventLUp_GuildReward_All_RecieveReward(index)
  if nil == Panel_GuildReward_All then
    return
  end
  local rewardNo_64 = ToClient_GetGuildPendingRewardRewardNoByIndex(index)
  ToClient_requestGuildRewardRecieve(rewardNo_64)
end
function HandleEvent_GuildReward_All_LogScroll(isDown)
  if isDown then
    PaGlobal_GuildReward_All._scroll_Frame1Vertical:ControlButtonDown()
  else
    PaGlobal_GuildReward_All._scroll_Frame1Vertical:ControlButtonUp()
  end
  PaGlobal_GuildReward_All._scroll_Frame1Vertical:UpdateContentScroll()
end
function PaGlobal_GuildReward_All_Open()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:prepareOpen()
end
function PaGlobal_GuildReward_All_IsOpen()
  if nil == Panel_GuildReward_All then
    return false
  end
  return Panel_GuildReward_All:GetShow()
end
function PaGlobal_GuildReward_All_Close()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:prepareClose()
end
function PaGlobal_GuildReward_All_HistoryToggle()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:historyToggle()
end
function FromClient_GuildReward_All_Load()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:prepareOpen()
end
function FromClient_GuildReward_All_Update()
  if nil == Panel_GuildReward_All then
    return
  end
  PaGlobal_GuildReward_All:itemListUpdate()
  PaGlobal_GuildReward_All._ui.stc_TotalRewardKistory:ComputePos()
  PaGlobal_GuildReward_All:logUpdate()
end
function FromClient_GuildReward_All_Open()
  if nil == Panel_GuildReward_All then
    return
  end
  if nil ~= Panel_Guild_MiningFuel_All then
    PaGlobal_MiningFuel_All_Close()
  end
  ToClient_requestGuildRewardInfo()
end
