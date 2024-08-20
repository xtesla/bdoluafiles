function PaGlobal_BlackspiritPass_Open()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:prepareOpen()
end
function PaGlobal_BlackspiritPass_Close()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if true == PaGlobal_BlackspiritPass._isConsole and nil ~= TooltipBlackSpiritPass_IsShow and true == TooltipBlackSpiritPass_IsShow() then
    TooltipBlackSpiritPass_Hide()
    return
  end
  Panel_Window_BlackspiritPass:CloseUISubApp()
  PaGlobal_BlackspiritPass:prepareClose()
end
function PaGlobal_BlackspiritPass_ShowAni()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
end
function PaGlobal_BlackspiritPass_HideAni()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
end
function PaGlobal_BlackspiritPass_UpdateListContent(content, key)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:updateListContent(content, key)
end
function PaGlobal_BlackspiritPass_IsThereAnyReward()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questCount = ToClient_SeasonPassQuestCount()
  local hasItemState = PaGlobal_BlackspiritPass._state.clear
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_BlackspiritPass._hasSeasonPass = selfPlayer:get():isSeasonPass()
  for index = 0, questCount - 1 do
    local questInfo = PaGlobal_BlackspiritPass._questInfo[index]
    if nil ~= questInfo and (hasItemState == questInfo.normalQuestState or true == PaGlobal_BlackspiritPass._hasSeasonPass and hasItemState == questInfo.premiumQuestState) then
      return true
    end
  end
  return false
end
function PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if nil == moveIndex then
    moveIndex = listIdx
  end
  PaGlobal_BlackspiritPass_Open()
  PaGlobal_BlackspiritPass._ui._list_quest:moveIndex(moveIndex)
  PaGlobal_BlackspiritPass._animListIdx = listIdx
  Panel_Window_BlackspiritPass:ClearUpdateLuaFunc()
  Panel_Window_BlackspiritPass:RegisterUpdateFunc("PaGlobal_BlackspiritPass_StampAnimation")
end
function PaGlobal_BlackspiritPass_StampAnimation(deltaTime)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local startIndex = PaGlobal_BlackspiritPass._ui._list_quest:getCurrenttoIndex()
  local visibleContentCount = PaGlobal_BlackspiritPass._ui._list_quest:getChildContentListSize()
  local listIdx = PaGlobal_BlackspiritPass._animListIdx
  if startIndex <= listIdx and listIdx <= startIndex + visibleContentCount then
    local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
    if nil == content then
      return
    end
    local stc_missionStamp = UI.getChildControl(content, "Static_CompleteStamp")
    stc_missionStamp:SetShow(true)
    stc_missionStamp:ResetVertexAni()
    stc_missionStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
    stc_missionStamp:SetVertexAniRun("Ani_Scale_New", true)
    Panel_Window_BlackspiritPass:ClearUpdateLuaFunc()
  end
end
function HandleEventOnOut_BlackspiritPass_ShowSeasonIconTooltip(isShow, index)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if true == PaGlobal_BlackspiritPass._isConsole and nil ~= TooltipBlackSpiritPass_IsShow and true == TooltipBlackSpiritPass_IsShow() then
    TooltipBlackSpiritPass_Hide()
    return
  end
  if false == isShow then
    TooltipBlackSpiritPass_Hide()
    return
  end
  local title = PaGlobal_BlackspiritPass._seasonIconString[index]._title
  local desc = PaGlobal_BlackspiritPass._seasonIconString[index]._desc
  local showExpIcon = index == 1
  if 3 == index then
    local getRewardListStr = PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
    if "" ~= getRewardListStr then
      desc = getRewardListStr
    end
  end
  TooltipBlackSpiritPass_Show(title, desc, showExpIcon)
end
function PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_REWARD_DESC_ETC")
  return desc
end
function HandleEventOnOut_BlackspiritPass_ShowItemTooltip(isShow, listIdx, isPremium, itemKey)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if false == _ContentsGroup_RenewUI then
    if false == isShow then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil ~= itemSSW then
      local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
      if nil == content then
        return
      end
      local control
      if false == isPremium then
        control = UI.getChildControl(content, "Static_NormalSlotBG")
      else
        control = UI.getChildControl(content, "Static_PremiumSlotBG")
      end
      Panel_Tooltip_Item_Show(itemSSW, control, true)
    end
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if nil == itemSSW then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_BlackspiritPass_GetRewardItem(listIdx, isPremium)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questType
  if false == isPremium then
    questType = __eSeasonPassQuest_Normal
  else
    questType = __eSeasonPassQuest_SeasonPass
  end
  ToClient_RequestCompleteSeasonPassQuest(listIdx, questType)
end
function HandleEventLUp_BlackspiritPass_AlreadyGetReward()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_ALREADY_GET_REWARD")
  Proc_ShowMessage_Ack(msg)
end
function HandleEventLUp_BlackspiritPass_ShowEasyPayment()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  if false == isGameServiceTypeConsole() then
    PaGlobal_EasyBuy:Open(80)
  elseif true == ToClient_isPS4() then
    return ToClient_openPS4Store()
  else
    return ToClient_XboxShowStore()
  end
end
function FromClient_BlackspiritPass_ResizePanel()
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  Panel_Window_BlackspiritPass:ComputePosAllChild()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_Window_BlackspiritPass:SetPosX((screenSizeX - Panel_Window_BlackspiritPass:GetSizeX()) / 2)
  Panel_Window_BlackspiritPass:SetPosY((screenSizeY - Panel_Window_BlackspiritPass:GetSizeY()) / 2)
  PaGlobal_BlackspiritPass:updateQuestListControl()
end
function FromClient_BlackspiritPass_UpdateSeasonPassQuest(questNoRaw)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if nil ~= questWrapper then
    local questNo = questWrapper:getQuestNo()
    local listIdx, isPremium = PaGlobal_BlackspiritPass:getListIndex(questNo)
    if -1 ~= listIdx then
      PaGlobal_BlackspiritPass:updateQuestInfo(listIdx)
      local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
      if nil ~= content then
        local key = toInt64(0, listIdx)
        PaGlobal_BlackspiritPass:updateListContent(content, key)
      end
    end
    local state = PaGlobal_BlackspiritPass:getQuestState(questNo)
    if PaGlobal_BlackspiritPass._normalQuestIdx == questNo._quest then
      local demand
      local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
      if nil ~= questInfo then
        demand = questInfo:getDemandAt(0)
      else
        local questStaticInfo = questList_getQuestStatic(questNo._group, questNo._quest)
        demand = questStaticInfo:getDemandAt(0)
      end
      if nil ~= demand then
        AcquireQuestDirect_UpdateQuestDemand(nil, demand, true)
      end
      if PaGlobal_BlackspiritPass._state.clear == state then
        if listIdx >= 3 then
          local moveIndex = listIdx - 2
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
        else
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx)
        end
      end
    end
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function FromClient_BlackspiritPass_NotifyGetSeasonPass(isSuccess)
  if nil == Panel_Window_BlackspiritPass then
    return
  end
  PaGlobal_BlackspiritPass:updateSeasonPassLockState()
  PaGlobal_BlackspiritPass:updateTotalQuestInfo()
  PaGlobal_BlackspiritPass:updateQuestListControl()
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function FromClient_BlackspiritPass_EventQuestUpdateNotify(isAccept, questNoRaw)
  if true == isAccept then
    return
  end
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if nil ~= questWrapper then
    local questNo = questWrapper:getQuestNo()
    local listIdx, isPremium = PaGlobal_BlackspiritPass:getListIndex(questNo)
    if -1 == listIdx then
      return
    end
    PaGlobal_BlackspiritPass:updateGetRewardItem(listIdx, isPremium)
  end
end
