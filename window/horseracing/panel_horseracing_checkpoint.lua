PaGlobal_HorseRacing_CheckPoint = {
  _ui = {
    stc_checkPoint = nil,
    txt_remainDistance = nil,
    stc_gaugeBg = nil,
    stc_activeGaugeBg = nil,
    stc_slot = nil,
    txt_remainTitle = nil,
    stc_checkPointTable = Array.new(),
    stc_recordBg = nil,
    stc_rankingList = Array.new(),
    txt_checkPointState = nil,
    rankingBg = nil
  },
  _preCheckPoint = 0,
  _eMAXRANKINGCOUNT = 5,
  _totalCheckPoint = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_CheckPoint_Init")
function FromClient_HorseRacing_CheckPoint_Init()
  PaGlobal_HorseRacing_CheckPoint:initialize()
end
function PaGlobal_HorseRacing_CheckPoint:initialize()
  self._ui.stc_checkPoint = UI.getChildControl(Panel_HorceRacing_CheckPoint, "Static_CheckPoint")
  self._ui.stc_gaugeBg = UI.getChildControl(self._ui.stc_checkPoint, "Static_GaugeBG")
  self._ui.stc_activeGaugeBg = UI.getChildControl(self._ui.stc_gaugeBg, "Static_Gauge_Active")
  self._ui.stc_slot = UI.getChildControl(self._ui.stc_activeGaugeBg, "Static_1")
  self._ui.txt_remainTitle = UI.getChildControl(self._ui.stc_checkPoint, "StaticText_Remain")
  self._ui.txt_remainDistance = UI.getChildControl(self._ui.txt_remainTitle, "StaticText_RemainDistance")
  self._ui.txt_checkPointState = UI.getChildControl(self._ui.stc_checkPoint, "StaticText_CountCheck")
  self._ui.rankingBg = UI.getChildControl(Panel_HorceRacing_CheckPoint, "Static_PlayerRecord")
  self._ui.stc_recordBg = UI.getChildControl(self._ui.rankingBg, "Static_RecordBG")
  PaGlobal_HorseRacing_CheckPoint:registEventHandler()
  PaGlobal_HorseRacing_CheckPoint:validate()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    local state = ToClient_getHorseRacingState()
    if __eHorseRacing_GoalLinePass == state or __eHorseRacing_Play == state then
      local currentCheckPoint = ToClient_getHorseRacingCheckPointNo()
      PaGlobal_HorseRacing_CheckPoint:showRankingSlotByPlayerCount()
      FromClient_HorseRacing_CheckPointUpdate(currentCheckPoint)
      self._ui.txt_checkPointState:SetText(" " .. tostring(currentCheckPoint) .. " / " .. tostring(self._totalCheckPoint))
    end
  end
end
function PaGlobal_HorseRacing_CheckPoint:initControl()
  if true == PaGlobal_HorseRacing_CheckPoint._initialize then
    return
  end
  self._totalCheckPoint = ToClient_getHorseRacingCheckPointCount()
  local slotSize = self._ui.stc_activeGaugeBg:GetSizeX() / self._totalCheckPoint - 1
  for idx = 1, self._totalCheckPoint do
    local slot = UI.cloneControl(self._ui.stc_slot, self._ui.stc_activeGaugeBg, "Static_CheckSlot" .. idx)
    local stc_normalFlag = UI.getChildControl(slot, "Static_PointIcon01")
    local stc_checkCompleteFlag = UI.getChildControl(stc_normalFlag, "Static_PointIcon_Complete01")
    local stc_checkCurrentFlag = UI.getChildControl(stc_normalFlag, "Static_PointIcon_Active01")
    local stc_currentSlot = UI.getChildControl(slot, "Static_Gauge_Active01")
    local stc_completeSlot = UI.getChildControl(slot, "Static_Gauge_Complete01")
    slot:SetSize(slotSize, slot:GetSizeY())
    slot:ComputePos()
    stc_completeSlot:SetSize(slotSize, stc_completeSlot:GetSizeY())
    stc_currentSlot:SetSize(slotSize + 10, stc_currentSlot:GetSizeY())
    slot:SetPosX((slot:GetPosX() + slot:GetSizeX() + 1) * (idx - 1))
    stc_normalFlag:ComputePos()
    stc_normalFlag:SetPosX(slot:GetSizeX() - 5)
    stc_normalFlag:SetPosY(-15)
    if idx == checkPointCount then
      stc_normalFlag:SetShow(false)
    end
    local tempTable = {
      _mainSlot = slot,
      _flag = stc_normalFlag,
      _currentFlag = stc_checkCurrentFlag,
      _completeFlag = stc_checkCompleteFlag,
      _currentSlot = stc_currentSlot,
      _completeSlot = stc_completeSlot
    }
    self._ui.stc_checkPointTable:push_back(tempTable)
  end
  self._ui.stc_slot:SetShow(false)
  for rankIdx = 1, self._eMAXRANKINGCOUNT do
    local rankSlot = UI.cloneControl(self._ui.stc_recordBg, self._ui.rankingBg, "Static_RankSlot" .. rankIdx)
    local otherBg = UI.getChildControl(rankSlot, "Static_OtherRecord01")
    local txt_otherRank = UI.getChildControl(rankSlot, "StaticText_OtherRanking")
    local txt_otherName = UI.getChildControl(rankSlot, "StaticText_OtherName01")
    local myBg = UI.getChildControl(rankSlot, "Static_MyRecord")
    local txt_MyRank = UI.getChildControl(rankSlot, "StaticText_MyRanking")
    local txt_myName = UI.getChildControl(rankSlot, "StaticText_MyName")
    local txt_realTimeRecord = UI.getChildControl(rankSlot, "StaticText_OtherRecord")
    rankSlot:SetPosY((self._ui.stc_recordBg:GetSizeY() + 5) * (rankIdx - 1))
    local tempTable = {
      _rankSlot = rankSlot,
      _otherBg = otherBg,
      _txt_otherRank = txt_otherRank,
      _txt_otherName = txt_otherName,
      _myBg = myBg,
      _txt_MyRank = txt_MyRank,
      _txt_myName = txt_myName,
      _txt_realTimeRecord = txt_realTimeRecord
    }
    self._ui.stc_rankingList:push_back(tempTable)
  end
  self._ui.stc_recordBg:SetShow(false)
  PaGlobal_HorseRacing_CheckPoint._initialize = true
end
function PaGlobal_HorseRacing_CheckPoint:registEventHandler()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  registerEvent("FromClient_HorseRacing_UpdateAck", "FromClient_HorseRacing_CheckPoint_Update")
  registerEvent("FromClient_HorseRacing_UpdateCheckPoint", "FromClient_HorseRacing_CheckPointUpdate")
  registerEvent("FromClient_HorseRacing_UpdateRankingList", "FromClient_HorseRacing_UpdateRankingAck")
end
function PaGlobal_HorseRacing_CheckPoint:clearCheckPoint()
  for idx = 1, self._totalCheckPoint do
    if nil == self._ui.stc_checkPointTable[idx] then
      return
    end
    self._ui.stc_checkPointTable[idx]._flag:SetShow(idx ~= self._totalCheckPoint)
    self._ui.stc_checkPointTable[idx]._currentFlag:SetShow(false)
    self._ui.stc_checkPointTable[idx]._completeFlag:SetShow(false)
    self._ui.stc_checkPointTable[idx]._currentSlot:SetShow(false)
    self._ui.stc_checkPointTable[idx]._completeSlot:SetShow(false)
  end
end
function PaGlobal_HorseRacing_CheckPoint:prepareOpen()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  PaGlobal_HorseRacing_CheckPoint:initControl()
  PaGlobal_HorseRacing_CheckPoint:clearCheckPoint()
  PaGlobal_HorseRacing_CheckPoint:showRankingSlotByPlayerCount()
  PaGlobal_HorseRacing_CheckPoint:open()
  Panel_HorceRacing_CheckPoint:ComputePos()
end
function PaGlobal_HorseRacing_CheckPoint:showRankingSlotByPlayerCount()
  local playerCount = ToClient_getHorseRacingPlayerCount()
  for idx = 1, self._eMAXRANKINGCOUNT do
    if nil ~= self._ui.stc_rankingList[idx] then
      if idx <= playerCount and idx <= self._eMAXRANKINGCOUNT then
        self._ui.stc_rankingList[idx]._rankSlot:SetShow(true)
      else
        self._ui.stc_rankingList[idx]._rankSlot:SetShow(false)
      end
    end
  end
end
function PaGlobal_HorseRacing_CheckPoint:showRankingControlByMine(controlTable, isMine)
  if nil == controlTable or nil == self._ui.stc_rankingList then
    return
  end
  controlTable._otherBg:SetShow(not isMine)
  controlTable._txt_otherRank:SetShow(not isMine)
  controlTable._txt_otherName:SetShow(not isMine)
  controlTable._myBg:SetShow(isMine)
  controlTable._txt_MyRank:SetShow(isMine)
  controlTable._txt_myName:SetShow(isMine)
end
function PaGlobal_HorseRacing_CheckPoint:open()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  Panel_HorceRacing_CheckPoint:SetShow(true)
end
function PaGlobal_HorseRacing_CheckPoint:prepareClose()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  Panel_HorceRacing_CheckPoint:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_CheckPoint:close()
end
function PaGlobal_HorseRacing_CheckPoint:close()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  Panel_HorceRacing_CheckPoint:SetShow(false)
end
function PaGlobal_HorseRacing_CheckPoint:validate()
  if nil == Panel_HorceRacing_CheckPoint then
    return
  end
  self._ui.stc_checkPoint:isValidate()
  self._ui.stc_gaugeBg:isValidate()
  self._ui.stc_activeGaugeBg:isValidate()
  self._ui.stc_slot:isValidate()
  self._ui.txt_remainTitle:isValidate()
  self._ui.txt_remainDistance:isValidate()
  self._ui.txt_checkPointState:isValidate()
  self._ui.rankingBg:isValidate()
  self._ui.stc_recordBg:isValidate()
end
function PaGlobal_HorseRacing_CheckPoint:updateRealTimeRanking(rankingCount)
  if false == Panel_HorceRacing_CheckPoint:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  for ii = 1, self._eMAXRANKINGCOUNT do
    local controlTable = self._ui.stc_rankingList[ii]
    if nil ~= controlTable then
      controlTable._rankSlot:SetShow(false)
    end
  end
  local myUserNo = selfPlayer:get():getUserNo()
  for idx = 1, rankingCount do
    if idx <= self._eMAXRANKINGCOUNT then
      local rankingInfo = ToClient_getHorseRacingRankingByIndex(idx - 1)
      if nil ~= rankingInfo and true == rankingInfo:isDefined() then
        local controlTable = self._ui.stc_rankingList[idx]
        if nil ~= controlTable then
          controlTable._rankSlot:SetShow(true)
          local nickName = rankingInfo:getUserNickName()
          local isMine = myUserNo == rankingInfo:getUserNo()
          local recordTime = ""
          PaGlobal_HorseRacing_CheckPoint:showRankingControlByMine(controlTable, isMine)
          if true == isMine then
            controlTable._txt_MyRank:SetText(idx)
            controlTable._txt_myName:SetText(nickName)
            local lapCount = rankingInfo:getLapCount()
            PaGlobalFunc_HorseRacing_PlayTime_SetMyLapCount(lapCount)
          else
            controlTable._txt_otherRank:SetText(idx)
            controlTable._txt_otherName:SetText(nickName)
          end
        end
      end
    end
  end
end
function PaGlobalFunc_HorseRacing_CheckPoint_UpdatePerframe(deltaTime)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  local state = ToClient_getHorseRacingState()
  if __eHorseRacing_Play == state or __eHorseRacing_GoalLinePass == state then
    local leftDistance = ToClient_getHorseRacingLeftDistance()
    if nil == leftDistance or leftDistance <= 0 then
      return
    end
    PaGlobal_HorseRacing_CheckPoint._ui.txt_remainDistance:SetText(leftDistance)
  end
end
function FromClient_HorseRacing_CheckPoint_Update(state)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  if __eHorseRacing_Play == state or __eHorseRacing_GoalLinePass == state then
    if false == Panel_HorceRacing_CheckPoint:GetShow() then
      PaGlobal_HorseRacing_CheckPoint:prepareOpen()
      Panel_HorceRacing_CheckPoint:RegisterUpdateFunc("PaGlobalFunc_HorseRacing_CheckPoint_UpdatePerframe")
    end
  else
    PaGlobal_HorseRacing_CheckPoint:prepareClose()
    return
  end
end
function FromClient_HorseRacing_UpdateRankingAck(rankingCount)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  PaGlobal_HorseRacing_CheckPoint:updateRealTimeRanking(rankingCount)
end
function FromClient_HorseRacing_CheckPointUpdate(currentCheckPoint)
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    return
  end
  if nil == currentCheckPoint then
    return
  end
  if false == Panel_HorceRacing_CheckPoint:GetShow() then
    PaGlobal_HorseRacing_CheckPoint:prepareOpen()
    Panel_HorceRacing_CheckPoint:RegisterUpdateFunc("PaGlobalFunc_HorseRacing_CheckPoint_UpdatePerframe")
  end
  PaGlobal_HorseRacing_CheckPoint._preCheckPoint = currentCheckPoint
  local self = PaGlobal_HorseRacing_CheckPoint
  if currentCheckPoint < 0 or currentCheckPoint > PaGlobal_HorseRacing_CheckPoint._totalCheckPoint then
    return
  end
  self._ui.txt_checkPointState:SetText(" " .. tostring(ToClient_getHorseRacingCheckPointNo()) .. " / " .. tostring(self._totalCheckPoint))
  PaGlobal_HorseRacing_CheckPoint:clearCheckPoint()
  for idx = 1, currentCheckPoint do
    if nil ~= self._ui.stc_checkPointTable[idx] then
      if currentCheckPoint > idx then
        self._ui.stc_checkPointTable[idx]._currentFlag:SetShow(false)
        self._ui.stc_checkPointTable[idx]._currentSlot:SetShow(false)
        self._ui.stc_checkPointTable[idx]._completeFlag:SetShow(true)
        self._ui.stc_checkPointTable[idx]._completeSlot:SetShow(true)
      elseif idx == currentCheckPoint then
        self._ui.stc_checkPointTable[idx]._currentFlag:SetShow(true)
        self._ui.stc_checkPointTable[idx]._currentSlot:SetShow(true)
      end
    end
  end
end
