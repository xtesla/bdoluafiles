function PaGlobal_HorseRacing_Score:initialize()
  if true == PaGlobal_HorseRacing_Score._initialize then
    return
  end
  self._ui.stc_RankingList = UI.getChildControl(Panel_HorseRacing_Score, "Static_RankList")
  self._ui.stc_rankerListBG = UI.getChildControl(self._ui.stc_RankingList, "Static_RankerBG")
  for ii = 1, 3 do
    local ranker = {
      bg = nil,
      myName = nil,
      userName = nil,
      horseName = nil,
      myRecord = nil,
      record = nil,
      recordGap = nil,
      effect = nil,
      rewardBG = nil,
      rewardIcon = {}
    }
    ranker.bg = UI.getChildControl(self._ui.stc_rankerListBG, "Static_Ranker_List_" .. ii)
    ranker.myName = UI.getChildControl(ranker.bg, "StaticText_MyName")
    ranker.userName = UI.getChildControl(ranker.bg, "StaticText_RankerName")
    ranker.horseName = UI.getChildControl(ranker.bg, "StaticText_HorseName")
    ranker.myRecord = UI.getChildControl(ranker.bg, "StaticText_MyRecord")
    ranker.record = UI.getChildControl(ranker.bg, "StaticText_Record")
    ranker.recordGap = UI.getChildControl(ranker.bg, "StaticText_RecordGap")
    ranker.effect = UI.getChildControl(ranker.bg, "Static_Effect")
    ranker.rewardBG = UI.getChildControl(ranker.bg, "Static_RewardBG")
    local iconBG = UI.getChildControl(ranker.rewardBG, "Static_ItemIcon")
    SlotItem.new(ranker.rewardIcon, "reward_", nil, iconBG, self._slotConfig)
    ranker.rewardIcon:createChild()
    ranker.rewardIcon:clearItem()
    self._ui.stc_rankerList[ii] = ranker
  end
  for ii = 4, 10 do
    local unRank = {
      bg = nil,
      myName = nil,
      userName = nil,
      horseName = nil,
      myRecord = nil,
      record = nil,
      recordGap = nil,
      effect = nil,
      rewardBG = nil,
      rewardIcon = {}
    }
    unRank.bg = UI.getChildControl(self._ui.stc_rankerListBG, "Static_NonRanker_List_" .. ii)
    unRank.bg:SetShow(false)
    unRank.myName = UI.getChildControl(unRank.bg, "StaticText_MyName01")
    unRank.userName = UI.getChildControl(unRank.bg, "StaticText_NonRankerName")
    unRank.horseName = UI.getChildControl(unRank.bg, "StaticText_HorseName01")
    unRank.myRecord = UI.getChildControl(unRank.bg, "StaticText_MyRecord01")
    unRank.record = UI.getChildControl(unRank.bg, "StaticText_Record01")
    unRank.recordGap = UI.getChildControl(unRank.bg, "StaticText_Other_Record01")
    unRank.effect = UI.getChildControl(unRank.bg, "Static_Effect01")
    unRank.rewardBG = UI.getChildControl(unRank.bg, "Static_RewardBG01")
    local iconBG = UI.getChildControl(unRank.rewardBG, "Static_ItemIcon01")
    SlotItem.new(unRank.rewardIcon, "reward_", nil, iconBG, self._slotConfig)
    unRank.rewardIcon:createChild()
    unRank.rewardIcon:clearItem()
    self._ui.stc_rankerList[ii] = unRank
  end
  local retire = {
    bg = nil,
    myName = nil,
    userName = nil,
    horseName = nil,
    record = nil,
    effect = nil,
    rewardBG = nil,
    rewardIcon = {}
  }
  retire.bg = UI.getChildControl(self._ui.stc_rankerListBG, "Static_RetireBG")
  retire.bg:SetShow(false)
  retire.myName = UI.getChildControl(retire.bg, "StaticText_MyName02")
  retire.userName = UI.getChildControl(retire.bg, "StaticText_RetireName")
  retire.horseName = UI.getChildControl(retire.bg, "StaticText_RetireHorseName")
  retire.record = UI.getChildControl(retire.bg, "StaticText_Retire")
  retire.effect = UI.getChildControl(retire.bg, "Static_Effect02")
  retire.rewardBG = UI.getChildControl(retire.bg, "Static_RewardBG02")
  local iconBG = UI.getChildControl(retire.rewardBG, "Static_ItemIcon02")
  SlotItem.new(retire.rewardIcon, "reward_", nil, iconBG, self._slotConfig)
  retire.rewardIcon:createChild()
  retire.rewardIcon:clearItem()
  self._ui.stc_retire = retire
  local ButtonBG = UI.getChildControl(self._ui.stc_RankingList, "Static_Extra")
  self._ui.btn_exit = UI.getChildControl(ButtonBG, "Button_Exit")
  self._ui.stc_exitConsole = UI.getChildControl(ButtonBG, "Static_Exit_ConsoleUI")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_HorseRacing_Score:registEventHandler()
  if nil == Panel_HorseRacing_Score then
    return
  end
  self._ui.btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_Score_Exit()")
  registerEvent("onScreenResize", "FromClient_HorseRacing_Score_ReSize")
  registerEvent("FromClient_HorseRacing_UpdateRankingList", "FromClient_HorseRacing_Score_UpdateRankingAck")
end
function PaGlobal_HorseRacing_Score:prepareOpen()
  if nil == Panel_HorseRacing_Score then
    return
  end
  for ii = 1, 10 do
    self._ui.stc_rankerList[ii].bg:SetShow(false)
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.btn_exit:SetShow(true)
    self._ui.stc_exitConsole:SetShow(false)
  else
    self._ui.btn_exit:SetShow(false)
    self._ui.stc_exitConsole:SetShow(true)
  end
  self:setRanking()
  audioPostEvent_SystemUi(17, 2)
  PaGlobal_HorseRacing_Score:open()
end
function PaGlobal_HorseRacing_Score:open()
  if nil == Panel_HorseRacing_Score then
    return
  end
  Panel_HorseRacing_Score:SetShow(true)
end
function PaGlobal_HorseRacing_Score:prepareClose()
  if nil == Panel_HorseRacing_Score then
    return
  end
  PaGlobal_HorseRacing_Score:close()
end
function PaGlobal_HorseRacing_Score:close()
  if nil == Panel_HorseRacing_Score then
    return
  end
  Panel_HorseRacing_Score:SetShow(false)
end
function PaGlobal_HorseRacing_Score:setRanking()
  if nil == Panel_HorseRacing_Score then
    return
  end
  local size = 0
  local userNo = getSelfPlayer():get():getUserNo()
  local curPlayerCount = ToClient_getHorseRacingRankingCount()
  local maxPlayerCount = ToClient_getHorseRacingMaxPlayer()
  for ii = 1, curPlayerCount do
    if ii > maxPlayerCount then
      return
    end
    local wrapper = ToClient_getHorseRacingRankingByIndex(ii - 1)
    if nil ~= wrapper then
      local raceTimeString = wrapper:getRaceFinishTime()
      local userName = wrapper:getUserNickName()
      local horseName = wrapper:getHorseName()
      local gap = wrapper:getRaceRecordGap()
      local itemKey = wrapper:getRewardItemKey()
      local itemCount = wrapper:getRewardItemCount()
      if "" ~= raceTimeString and nil ~= raceTimeString then
        self._ui.stc_rankerList[ii].bg:SetShow(true)
        self._ui.stc_rankerList[ii].myName:SetShow(false)
        self._ui.stc_rankerList[ii].userName:SetShow(true)
        self._ui.stc_rankerList[ii].record:SetShow(true)
        self._ui.stc_rankerList[ii].myRecord:SetShow(false)
        self._ui.stc_rankerList[ii].myName:SetText(userName)
        self._ui.stc_rankerList[ii].userName:SetText(userName)
        self._ui.stc_rankerList[ii].horseName:SetText(horseName)
        self._ui.stc_rankerList[ii].record:SetText(raceTimeString)
        self._ui.stc_rankerList[ii].myRecord:SetText(raceTimeString)
        if wrapper:getUserNo() == userNo then
          self._ui.stc_rankerList[ii].myName:SetShow(true)
          self._ui.stc_rankerList[ii].userName:SetShow(false)
          self._ui.stc_rankerList[ii].record:SetShow(false)
          self._ui.stc_rankerList[ii].myRecord:SetShow(true)
          self._ui.stc_rankerList[ii].effect:AddEffect("fUI_Horse_Racing_Score_01A", true, 0, 0)
          self._ui.stc_rankerList[ii].rewardIcon.icon:AddEffect("fUI_Horse_Racing_Reward_01A", true, 0, 0)
        end
        if 1 == ii then
          self._ui.stc_rankerList[ii].recordGap:SetText("00:00")
        else
          self._ui.stc_rankerList[ii].recordGap:SetText("+" .. gap)
        end
        if ii < 4 then
          size = size + 70
        else
          size = size + 65
        end
        if nil ~= itemKey and 0 ~= itemKey then
          local itemWrapper = getItemEnchantStaticStatus(itemKey)
          if nil ~= itemWrapper then
            self._ui.stc_rankerList[ii].rewardIcon:setItemByStaticStatus(itemWrapper, itemCount)
            self._ui.stc_rankerList[ii].rewardIcon.icon:addInputEvent("Mouse_On", "PaGlobal_HorseRacing_Score_ShowToolTip(true," .. ii .. ")")
            self._ui.stc_rankerList[ii].rewardIcon.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
          end
        end
      else
        if nil == self._ui.stc_retireList[ii] then
          self._ui.stc_retireList[ii] = {}
          local retire = {
            bg = nil,
            myName = nil,
            userName = nil,
            horseName = nil,
            record = nil,
            effect = nil,
            rewardBG = nil,
            rewardIcon = {}
          }
          retire.bg = UI.cloneControl(self._ui.stc_retire.bg, self._ui.stc_rankerListBG, "Static_RetireBG_" .. ii)
          retire.bg:SetShow(false)
          retire.myName = UI.getChildControl(retire.bg, "StaticText_MyName02")
          retire.userName = UI.getChildControl(retire.bg, "StaticText_RetireName")
          retire.horseName = UI.getChildControl(retire.bg, "StaticText_RetireHorseName")
          retire.record = UI.getChildControl(retire.bg, "StaticText_Retire")
          retire.effect = UI.getChildControl(retire.bg, "Static_Effect02")
          retire.rewardBG = UI.getChildControl(retire.bg, "Static_RewardBG02")
          local iconBG = UI.getChildControl(retire.rewardBG, "Static_ItemIcon02")
          SlotItem.new(retire.rewardIcon, "reward_" .. ii, nil, iconBG, self._slotConfig)
          retire.rewardIcon:createChild()
          retire.rewardIcon:clearItem()
          self._ui.stc_retireList[ii] = retire
        end
        self._ui.stc_retireList[ii].bg:SetSpanSize(0, size)
        size = size + 65
        self._ui.stc_retireList[ii].bg:SetShow(true)
        self._ui.stc_retireList[ii].record:SetShow(true)
        self._ui.stc_retireList[ii].myName:SetShow(false)
        self._ui.stc_retireList[ii].userName:SetShow(true)
        self._ui.stc_retireList[ii].myName:SetText(userName)
        self._ui.stc_retireList[ii].userName:SetText(userName)
        self._ui.stc_retireList[ii].horseName:SetText(horseName)
        if wrapper:getUserNo() == userNo then
          self._ui.stc_retireList[ii].myName:SetShow(true)
          self._ui.stc_retireList[ii].userName:SetShow(false)
          self._ui.stc_retireList[ii].effect:AddEffect("fUI_Horse_Racing_Score_01A", true, 0, 0)
          self._ui.stc_retireList[ii].rewardIcon.icon:AddEffect("fUI_Horse_Racing_Reward_01A", true, 0, 0)
        end
        if nil ~= itemKey and 0 ~= itemKey then
          local itemWrapper = getItemEnchantStaticStatus(itemKey)
          if nil ~= itemWrapper then
            self._ui.stc_retireList[ii].rewardIcon:setItemByStaticStatus(itemWrapper, itemCount)
            self._ui.stc_retireList[ii].rewardIcon.icon:addInputEvent("Mouse_On", "PaGlobal_HorseRacing_Score_ShowToolTip(false," .. ii .. ")")
            self._ui.stc_retireList[ii].rewardIcon.icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
          end
        end
      end
    end
  end
end
function PaGlobal_HorseRacing_Score:validate()
  if nil == Panel_HorseRacing_Score then
    return
  end
  self._ui.btn_exit:isValidate()
end
