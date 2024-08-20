function PaGlobal_MiniGame_YachtDice:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initTitleBG()
  self:initLeftBG()
  self:initRightBG()
  self:initConsoleKeyGuideBG()
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MiniGame_YachtDice:clear()
  self._ui._txt_maxTurn:SetText("")
  self._ui._txt_currentTurn:SetText("")
  for ii = 0, __eYachtDiceHandRankMax - 1 do
    local slot = self._ui._handRankList[ii]
    slot:clear()
    slot:SetShow(false)
  end
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local control_totalPoint = self._ui._txt_totalPoint[ii]
    control_totalPoint:clear()
    local control_turnBG = self._ui._stc_turnBG[ii]
    control_turnBG:clear()
  end
  self:hideAllFieldCard()
  self:hideAllDiceCard()
  self._isStartGame = false
  self._ui._btn_roll:SetMonoTone(false)
  self._ui._btn_roll:SetIgnore(false)
  self._ui._btn_roll:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CARDGAME_BTN_START"))
  if true == self._isConsole then
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_MiniGame_YachtDice:requestStartGame()")
  else
    self._ui._btn_roll:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:requestStartGame()")
  end
  self._ui._stc_msgPhase:SetShow(false)
  self._ui._stc_keyGuideBG:SetShow(false)
  self._ui._stc_msgGuide:SetShow(false)
  self._turnRemainTime = 0
  self._isTimeOutEffectShow = true
  self._soundTime = 10
  self._ui._stc_timer:SetShow(false)
  PaGlobal_MiniGame_Tooltip:clearRefCount()
  PaGlobal_MiniGame_Tooltip:prepareClose()
  PaGlobal_MiniGame_Tooltip_MyDeck:prepareClose()
  self._isEventStartHandRank = false
  self._eventHandRankTime = 0
  self._isTotalScoreEffectShow = false
  self:clearRenderValue()
end
function PaGlobal_MiniGame_YachtDice:clearRenderValue()
  self._currentRenderEventType = self._renderEventType.None
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  self._rollCardList = {}
  self._drawCardList = {}
  self._drawCardCount = 0
  self._drawIndex = nil
  self._isDrawCard = nil
  self._fieldCardKeepIndex = nil
  self._npcActionEventTime = 0
  self._npcActionEventMaxTime = 0
  self._isUpdateNpcEvent = false
  self._isTimeOut = false
  self._selectedKeepCardIndex = nil
  self._selectedCheckHandIndex = nil
end
function PaGlobal_MiniGame_YachtDice:prepareOpen()
  self:open()
end
function PaGlobal_MiniGame_YachtDice:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  Panel_Npc_Dialog_All:SetShow(false)
  self:clear()
  self:updateGamerInfo()
  Panel_Window_MiniGame_YachtDice:SetShow(true)
  Panel_Window_MiniGame_YachtDice:RegisterUpdateFunc("PaGlobalFunc_MiniGame_YachtDice_Update")
  self:eventStartBeforeGameStart()
end
function PaGlobal_MiniGame_YachtDice:prepareClose()
  self:close()
end
function PaGlobal_MiniGame_YachtDice:close()
  Panel_Npc_Dialog_All:SetShow(true)
  if true == Panel_Widget_MiniGame_YachtDice_Result:GetShow() then
    PaGlobal_MiniGame_YachtDice_Result:prepareClose()
  end
  ToClient_stopMiniGameYachtDice()
  Panel_Window_MiniGame_YachtDice:SetShow(false)
  Panel_Window_MiniGame_YachtDice:ClearUpdateLuaFunc()
end
function PaGlobal_MiniGame_YachtDice:closeMsg()
  if true == self._isStartGame then
    if false == Panel_Window_MessageBox_All:GetShow() then
      function funcClose()
        self:prepareClose()
      end
      local messageData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_MSG_EXIT"),
        functionYes = funcClose,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if true == self._isConsole then
        MessageBox.showMessageBox(messageData)
      else
        MessageBox.showMessageBox(messageData, nil, nil, false)
        else
          self:prepareClose()
        end
      end
    else
    end
end
function PaGlobal_MiniGame_YachtDice:validate()
  self._ui._stc_titleBG:isValidate()
  self._ui._stc_leftBG:isValidate()
  self._ui._stc_rightBG:isValidate()
  self._ui._stc_msgPhase:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._stc_msgGuide:isValidate()
  self._ui._stc_consoleKeyGuideBG:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_MiniGame_YachtDice:registerEvent()
  if true == self._isConsole then
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_MiniGame_YachtDice:padSnappingLeftBG()")
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_MiniGame_YachtDice:padSnappingRightBG()")
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobal_MiniGame_YachtDice:keepCardByConsole()")
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobal_MiniGame_YachtDice:keepCardByConsole()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:closeMsg()")
  end
  for ii = 0, __eYachtDiceCount - 1 do
    local fieldCard = self._ui._fieldCardList[ii]
    if true == self._isConsole then
      fieldCard.stc_numberImage:addInputEvent("Mouse_On", "PaGlobal_MiniGame_YachtDice:selectedKeepCardIndexByConsole(" .. tostring(ii) .. ")")
    else
      fieldCard.stc_numberImage:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:keepCard(" .. tostring(ii) .. ")")
      fieldCard.stc_numberImage:addInputEvent("Mouse_RUp", "PaGlobal_MiniGame_YachtDice:keepCard(" .. tostring(ii) .. ")")
    end
  end
  self._ui._btn_mainCardSkill:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:useMainCardSkill()")
  registerEvent("FromClient_responseYachtDiceGameStart", "FromClient_responseYachtDiceGameStart")
  registerEvent("FromClient_responseYachtDiceGameKeepCard", "FromClient_responseYachtDiceGameKeepCard")
  registerEvent("FromClient_responseYachtDiceGameRoll", "FromClient_responseYachtDiceGameRoll")
  registerEvent("FromClient_responseYachtDiceGameCheckHand", "FromClient_responseYachtDiceGameCheckHand")
  registerEvent("FromClient_responseYachtDiceGameUpdateTurn", "FromClient_responseYachtDiceGameUpdateTurn")
  registerEvent("FromClient_showYachtDiceGameUI", "FromClient_showYachtDiceGameUI")
  registerEvent("FromClient_responseYachtDiceGameNPCDataList", "FromClient_responseYachtDiceGameNPCDataList")
  registerEvent("progressEventCancelByAttacked", "PaGlobalFunc_MiniGame_YachtDice_ForceHide")
end
function PaGlobal_MiniGame_YachtDice:initHandRankList()
  local handRankKeyList = ToClient_getYachtHandRankKeyList()
  if nil == handRankKeyList then
    return false
  end
  for ii = 0, #handRankKeyList do
    local slot = self._ui._handRankList[ii]
    local key = handRankKeyList[ii]
    local handRankWrapper = ToClient_getHandRankStaticStatusWrapper(key)
    slot:clear()
    slot:SetShow(false)
    if nil ~= handRankWrapper then
      slot.keyRaw = key:get()
      slot.startTime = (ii + 1) * 0.5
      local iconTexture = handRankWrapper:getIconTextureName()
      local txt_handRank = handRankWrapper:getName()
      local control = slot.txt_handRank
      control:SetText(txt_handRank)
      control:ChangeTextureInfoTextureIDKey(iconTexture)
      control:setRenderTexture(control:getBaseTexture())
    end
  end
  return true
end
function PaGlobal_MiniGame_YachtDice:setDiceCardListPosition(index, initPosX, initPosY, isShow, alpha)
  local list = self._ui._diceCardList[index]
  if nil == list then
    return
  end
  local addPosY = 0
  if self.__eYachtPlayerType_Me == index then
    addPosY = -5
  elseif self.__eYachtPlayerType_You == index then
    addPosY = 5
  else
    return
  end
  for ii = 0, __eYachtDiceCount - 1 do
    for jj = 0, __eTYachtEyeCount - 1 do
      local diceCard = list[ii][jj]
      diceCard.initPos.x = initPosX + (self._diceCardSizeX + 10) * ii
      diceCard.initPos.y = initPosY + addPosY * jj
      diceCard:SetPosX(diceCard.initPos.x)
      diceCard:SetPosY(diceCard.initPos.y)
      diceCard:SetAlphaChild(alpha)
      if jj == __eTYachtEyeCount - 1 then
        diceCard:SetShow(false)
      else
        diceCard:SetShow(isShow)
      end
    end
  end
end
function PaGlobal_MiniGame_YachtDice:updateFieldCardXXX(index)
  local isMyTurn = ToClient_isMyTurnMiniGameYachtDice()
  local fieldCard = self._ui._fieldCardList[index]
  if nil == fieldCard then
    return
  end
  local diceWrapper = ToClient_getYachtDiceWrapper(index, isMyTurn)
  if nil == diceWrapper then
    return
  end
  local currentFaceIndex = diceWrapper:getCurrentFaceIndex()
  local isKeep = diceWrapper:isKeep()
  if currentFaceIndex >= __eTYachtEyeCount then
    return
  end
  local cardWrapper = ToClient_getYachtDiceCardWrapper(index, currentFaceIndex, isMyTurn)
  if nil == cardWrapper then
    return
  end
  local number = cardWrapper:getEye()
  local symbolKey = cardWrapper:getSymbol()
  local txt_number = ""
  if 1 == number then
    txt_number = "A"
  else
    txt_number = tostring(number)
  end
  local numberPath = "UI_Artwork/Card/Card_" .. tostring(self._symbolString[symbolKey]) .. "_" .. txt_number .. ".dds"
  fieldCard.stc_knowledgeImage:ChangeTextureInfoName(cardWrapper:getCardTextureName())
  fieldCard.stc_numberImage:ChangeTextureInfoName(numberPath)
  fieldCard.txt_isKeep:SetShow(isKeep)
  fieldCard:SetShow(false)
  local diceCard
  if true == isMyTurn then
    diceCard = self._ui._diceCardList[self.__eYachtPlayerType_Me][index][__eTYachtEyeCount - 1]
  else
    diceCard = self._ui._diceCardList[self.__eYachtPlayerType_You][index][__eTYachtEyeCount - 1]
  end
  if nil ~= diceCard then
    diceCard.stc_knowledgeImage:ChangeTextureInfoName(cardWrapper:getCardTextureName())
    diceCard.stc_numberImage:ChangeTextureInfoName(numberPath)
    diceCard:SetShow(false)
  end
end
function PaGlobal_MiniGame_YachtDice:keepCard(index)
  if self._renderEventType.None ~= self._currentRenderEventType then
    return
  end
  local fieldCard = self._ui._fieldCardList[index]
  local isShow = fieldCard.txt_isKeep:GetShow()
  if true == isShow then
    ToClient_keepMiniGameYachtDice(index, false)
  else
    ToClient_keepMiniGameYachtDice(index, true)
  end
end
function PaGlobal_MiniGame_YachtDice:selectedKeepCardIndexByConsole(index)
  if false == self._isConsole then
    return
  end
  self._selectedKeepCardIndex = index
end
function PaGlobal_MiniGame_YachtDice:keepCardByConsole()
  if false == self._isConsole then
    return
  end
  if nil ~= self._selectedKeepCardIndex then
    self:keepCard(self._selectedKeepCardIndex)
  end
end
function PaGlobal_MiniGame_YachtDice:doRoll()
  if self._renderEventType.None ~= self._currentRenderEventType then
    return
  end
  ToClient_rollMiniGameYachtDice()
end
function PaGlobal_MiniGame_YachtDice:updateFieldCard()
  for ii = 0, __eYachtDiceCount - 1 do
    self:updateFieldCardXXX(ii)
  end
end
function PaGlobal_MiniGame_YachtDice:updateKeepCard(index, isKeep)
  self:eventStartKeep(index, isKeep)
end
function PaGlobal_MiniGame_YachtDice:updatePoint()
  local rollCount = ToClient_getCurrentRollCountMiniGameYachtDice()
  local isMyTurn = ToClient_isMyTurnMiniGameYachtDice()
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local isSelf = ii == self.__eYachtPlayerType_Me
    for jj = 0, __eYachtDiceHandRankMax - 1 do
      local slot = self._ui._handRankList[jj]
      if nil ~= slot.keyRaw then
        local key = YachtHandRankKey(slot.keyRaw)
        local isSet = ToClient_isSetHandRankMiniGameYachtDice(key, isSelf)
        local point = ToClient_getHandRankPointMiniGameYachtDice(key, isSelf)
        local control = slot.txt_point[ii]
        local isHidePoint = false
        local color = 0
        if true == isSet then
          color = 4294294074
          control:addInputEvent("Mouse_LUp", "")
        else
          color = 4285295724
          if true == isSelf and rollCount > 0 and true == isMyTurn then
            control:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:doCheckHandRank(" .. tostring(slot.keyRaw) .. ")")
          else
            isHidePoint = true
          end
        end
        if true == isHidePoint then
          control:SetText("")
        else
          control:SetFontColor(color)
          control:SetText(tostring(point))
        end
      end
    end
  end
end
function PaGlobal_MiniGame_YachtDice:updateTotalPoint()
  local myControl = self._ui._txt_totalPoint[self.__eYachtPlayerType_Me]
  local yourControl = self._ui._txt_totalPoint[self.__eYachtPlayerType_You]
  local fromMyTotalPoint = myControl.lastPoint
  local fromYourTotalPoint = yourControl.lastPoint
  local toMyTotalPoint = ToClient_getTotalPointMiniGameYachtDice(true)
  local toYourTotalPoint = ToClient_getTotalPointMiniGameYachtDice(false)
  if toMyTotalPoint > toYourTotalPoint then
    if fromMyTotalPoint < fromYourTotalPoint then
      myControl:AddEffect("fUI_Mini_Game_06B", false, 0, 0)
      myControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
      yourControl:EraseAllEffect()
    elseif fromMyTotalPoint > fromYourTotalPoint then
    else
      myControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
    end
  elseif toMyTotalPoint < toYourTotalPoint then
    if fromMyTotalPoint > fromYourTotalPoint then
      myControl:EraseAllEffect()
      yourControl:AddEffect("fUI_Mini_Game_06B", false, 0, 0)
      yourControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
    elseif fromMyTotalPoint < fromYourTotalPoint then
    else
      yourControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
    end
  else
    myControl:EraseAllEffect()
    yourControl:EraseAllEffect()
  end
  myControl:SetText(tostring(toMyTotalPoint))
  yourControl:SetText(tostring(toYourTotalPoint))
  myControl.lastPoint = toMyTotalPoint
  yourControl.lastPoint = toYourTotalPoint
end
function PaGlobal_MiniGame_YachtDice:updateRollCount()
  local maxRollCount = ToClient_getMiniGameYachtCurrentGameRollCountMax()
  local currentRollCount = ToClient_getCurrentRollCountMiniGameYachtDice()
  local remainCount = maxRollCount - currentRollCount
  local txt_roll = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CARDGAME_BTN_ROLL", "count", tostring(remainCount), "Total", tostring(maxRollCount))
  self._ui._btn_roll:SetText(txt_roll)
  if maxRollCount > remainCount then
    self._ui._btn_roll:EraseAllEffect()
  end
end
function PaGlobal_MiniGame_YachtDice:doCheckHandRank(keyRaw)
  local key = YachtHandRankKey(keyRaw)
  ToClient_checkHandRankMiniGameYachtDice(key, true)
end
function PaGlobal_MiniGame_YachtDice:updateTurnBG()
  local isMyTurn = ToClient_isMyTurnMiniGameYachtDice()
  local index = 0
  local effectName = ""
  if true == isMyTurn then
    index = self.__eYachtPlayerType_Me
    effectName = "fUI_Mini_Game_03A"
  else
    index = self.__eYachtPlayerType_You
    effectName = "fUI_Mini_Game_03A_Re"
  end
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local turnBG = self._ui._stc_turnBG[ii]
    if index == ii then
      turnBG:SetShow(true)
      turnBG.stc_rightTurnBG:AddEffect(effectName, true, 0, 0)
    else
      turnBG:SetShow(false)
      turnBG.stc_rightTurnBG:EraseAllEffect()
    end
  end
  if true == isMyTurn then
    self._ui._btn_roll:SetMonoTone(false)
    self._ui._btn_roll:SetIgnore(false)
    self._ui._btn_roll:AddEffect("fUI_Mini_Game_10A", true, 0, 0)
  else
    self._ui._btn_roll:SetMonoTone(true)
    self._ui._btn_roll:SetIgnore(true)
    self._ui._btn_roll:EraseAllEffect()
  end
  self._turnRemainTime = ToClient_getMiniGameYachtTurnRemainTime()
  self._soundTime = 10
  self._isTimeOutEffectShow = true
  self._ui._stc_timer.progress:SetProgressRate(100)
  self._ui._stc_timer:SetShow(true == isMyTurn)
  self._ui._txt_currentTurn:SetText(tostring(ToClient_getCurrentTurnCount()))
  self._ui._txt_maxTurn:SetText("/ " .. tostring(ToClient_getTotalTurnCount()))
end
function PaGlobal_MiniGame_YachtDice:requestStartGame()
  if true == self._isStartGame then
    return
  end
  if self._renderEventType.None ~= self._currentRenderEventType then
    return
  end
  ToClient_startMiniGameYachtDice()
end
function PaGlobal_MiniGame_YachtDice:hideAllFieldCard()
  local isMyTurn = ToClient_isMyTurnMiniGameYachtDice()
  for ii = 0, __eYachtDiceCount - 1 do
    local fieldCard = self._ui._fieldCardList[ii]
    fieldCard.txt_isKeep:SetPosX(fieldCard.txt_isKeepPos.x)
    fieldCard.txt_isKeep:SetPosY(fieldCard.txt_isKeepPos.y)
    fieldCard.parent:SetPosX(fieldCard.initPos.x)
    fieldCard.parent:SetPosY(fieldCard.initPos.y)
    fieldCard:SetIgnore(false == isMyTurn)
    fieldCard:SetShow(false)
  end
end
function PaGlobal_MiniGame_YachtDice:hideAllDiceCard()
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local initPos = self._diceCardPos[ii].initPos
    for jj = 0, __eYachtDiceCount - 1 do
      for kk = 0, __eTYachtEyeCount - 1 do
        local diceCard = self._ui._diceCardList[ii][jj][kk]
        diceCard:SetScaleChild(1, 1)
      end
    end
    self:setDiceCardListPosition(ii, initPos.x, initPos.y, false, 0.6)
  end
end
function PaGlobal_MiniGame_YachtDice:updateGamerInfo()
  self:updateMyUserInfo()
  self:updateEnemyUserInfo()
end
function PaGlobal_MiniGame_YachtDice:updateMyUserInfo()
  local userDataWrapper = ToClient_getMyYachtUserDataWrapper()
  if nil == userDataWrapper then
    return
  end
  local txt_name = userDataWrapper:getUserNickname()
  local iconPath = userDataWrapper:getIconPath()
  local turnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_Me]
  if nil ~= txt_name then
    turnBG:SetText(txt_name)
  end
  if nil ~= iconPath then
    turnBG:ChangeTextureInfoTextureIDKey(iconPath)
  end
end
function PaGlobal_MiniGame_YachtDice:updateEnemyUserInfo()
  local userDataWrapper = ToClient_getEnemyYachtUserDataWrapper()
  if nil == userDataWrapper then
    return
  end
  local actorTypeRaw = userDataWrapper:getActorTypeRaw()
  local txt_name = userDataWrapper:getUserNickname()
  local iconPath = userDataWrapper:getIconPath()
  local turnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_You]
  if nil ~= txt_name then
    turnBG:SetText(txt_name)
  end
  if nil ~= iconPath then
    if __eActorType_Player == actorTypeRaw then
      turnBG:ChangeTextureInfoTextureIDKey(iconPath)
    elseif __eActorType_Npc == actorTypeRaw then
      turnBG:ChangeTextureInfoName(iconPath)
    end
  else
  end
end
function PaGlobal_MiniGame_YachtDice:updateRecordInfo()
  local myTurnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_Me]
  local yourTurnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_You]
  local myUserDataWrapper = ToClient_getMyYachtUserDataWrapper()
  if nil ~= myUserDataWrapper then
    local winCount = myUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Win)
    local loseCount = myUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Lose)
    local drawCount = myUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Draw)
    local totalCount = winCount + loseCount + drawCount
    local winRate = 0
    if totalCount > 0 then
      winRate = math.floor(winCount / totalCount * 100)
    end
    local txt_winRate = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_RATE", "rate", tostring(winRate))
    myTurnBG.txt_rightWinRate:SetText(txt_winRate)
    myTurnBG.txt_rightWinRate:SetShow(true)
  else
    myTurnBG.txt_rightWinRate:SetShow(false)
  end
  local enemyUserDataWrapper = ToClient_getEnemyYachtUserDataWrapper()
  if nil ~= enemyUserDataWrapper then
    local actorTypeRaw = enemyUserDataWrapper:getActorTypeRaw()
    if __eActorType_Player == actorTypeRaw then
      local winCount = enemyUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Win)
      local loseCount = enemyUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Lose)
      local drawCount = enemyUserDataWrapper:getRecordTypeValue(__eMiniGameRecordType_Draw)
      local totalCount = winCount + loseCount + drawCount
      local winRate = 0
      if totalCount > 0 then
        winRate = math.floor(winCount / totalCount * 100)
      end
      local txt_winRate = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_RATE", "rate", tostring(winRate))
      yourTurnBG.txt_rightWinRate:SetText(txt_winRate)
      yourTurnBG.txt_rightWinRate:SetShow(true)
    else
      yourTurnBG.txt_rightWinRate:SetShow(false)
    end
  else
    yourTurnBG.txt_rightWinRate:SetShow(false)
  end
end
function PaGlobal_MiniGame_YachtDice:showHandRankTooltip(index)
  local slot = self._ui._handRankList[index]
  if nil == slot then
    return
  end
  if nil == slot.keyRaw then
    return
  end
  PaGlobal_MiniGame_Tooltip:setYachtDiceHandRankKey(slot.parent, slot.keyRaw, false, nil)
  PaGlobal_MiniGame_Tooltip:prepareOpen()
end
function PaGlobal_MiniGame_YachtDice:hideHandRankTooltip()
  PaGlobal_MiniGame_Tooltip:prepareClose()
end
function PaGlobal_MiniGame_YachtDice:showMyDeckTooltip(index)
  local diceCard = self._ui._diceCardList[self.__eYachtPlayerType_Me][index][0]
  if nil == diceCard then
    return
  end
  local posX = diceCard.parent:GetParentPosX()
  local posY = diceCard.parent:GetParentPosY()
  PaGlobal_MiniGame_Tooltip_MyDeck:SetPos(posX, posY)
  PaGlobal_MiniGame_Tooltip_MyDeck:prepareOpen(index)
end
function PaGlobal_MiniGame_YachtDice:hideMyDeckTooltip()
  PaGlobal_MiniGame_Tooltip_MyDeck:prepareClose()
end
function PaGlobal_MiniGame_YachtDice:endGame()
  self:hideAllFieldCard()
  self:hideAllDiceCard()
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local turnBG = self._ui._stc_turnBG[ii]
    turnBG.stc_rightTurnBG:EraseAllEffect()
  end
  self:eventStartHandRank(true)
end
function PaGlobal_MiniGame_YachtDice:showSelectedFieldCard(ii, playerType)
  local slot = self._ui._handRankList[ii]
  if nil == slot.keyRaw then
    return
  end
  self._selectedCheckHandIndex = ii * 10 + playerType
  local isSelf = playerType == self.__eYachtPlayerType_Me
  local key = YachtHandRankKey(slot.keyRaw)
  local isSet = ToClient_isSetHandRankMiniGameYachtDice(key, isSelf)
  if false == isSet then
    PaGlobal_MiniGame_Tooltip:setYachtDiceHandRankKey(slot.parent, slot.keyRaw, false, nil)
  else
    PaGlobal_MiniGame_Tooltip:setYachtDiceHandRankKey(slot.parent, slot.keyRaw, true, isSelf)
  end
  PaGlobal_MiniGame_Tooltip:prepareOpen()
end
function PaGlobal_MiniGame_YachtDice:hideSelectedFieldCard()
  PaGlobal_MiniGame_Tooltip:prepareClose()
end
function PaGlobal_MiniGame_YachtDice:useMainCardSkill()
end
function PaGlobal_MiniGame_YachtDice:initTitleBG()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close")
  self._ui._btn_close:SetShow(false == self._isConsole)
  local phaseControl = {
    parent = nil,
    txt_title = nil,
    txt_desc = nil
  }
  function phaseControl:SetShow(isShow)
    phaseControl.parent:SetShow(isShow)
  end
  function phaseControl:isValidate()
    phaseControl.parent:isValidate()
    phaseControl.txt_title:isValidate()
    phaseControl.txt_desc:isValidate()
  end
  function phaseControl:SetTitle(txt)
    phaseControl.txt_title:SetText(txt)
  end
  function phaseControl:SetDesc(txt)
    phaseControl.txt_desc:SetText(txt)
  end
  phaseControl.parent = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_MSG_Phase")
  phaseControl.txt_title = UI.getChildControl(phaseControl.parent, "StaticText_Title")
  phaseControl.txt_desc = UI.getChildControl(phaseControl.parent, "StaticText_Desc")
  self._ui._stc_msgPhase = phaseControl
  local msgGuideControl = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_MSG_Guide")
  self._ui._stc_msgGuide = UI.getChildControl(msgGuideControl, "MultilineText_Desc")
end
function PaGlobal_MiniGame_YachtDice:initLeftBG()
  self._ui._txt_maxTurn = UI.getChildControl(self._ui._stc_leftBG, "StaticText_Turn")
  self._ui._txt_currentTurn = UI.getChildControl(self._ui._stc_leftBG, "StaticText_Turn_Result")
  local leftMainBG = UI.getChildControl(self._ui._stc_leftBG, "Static_LeftMain_BG")
  local handRankBaseUI = UI.getChildControl(leftMainBG, "Static_House_Spade_BG")
  self._ui._handRankList = {}
  for ii = 0, __eYachtDiceHandRankMax - 1 do
    do
      local slot = {
        keyRaw = nil,
        parent = nil,
        txt_handRank = nil,
        txt_point = {
          [self.__eYachtPlayerType_Me] = nil,
          [self.__eYachtPlayerType_You] = nil
        },
        startTime = 0,
        isOpen = false
      }
      function slot:clear()
        slot.keyRaw = nil
        slot.startTime = 0
        slot.isOpen = false
        for ii = 0, PaGlobal_MiniGame_YachtDice.__eYachtPlayerType_Count - 1 do
          local control = slot.txt_point[ii]
          control:SetText("")
        end
      end
      function slot:SetShow(isShow)
        slot.parent:SetShow(isShow)
      end
      function slot:GetShow()
        return slot.parent:GetShow()
      end
      local control = UI.cloneControl(handRankBaseUI, leftMainBG, "HandRank_" .. tostring(ii))
      control:addInputEvent("Mouse_On", "PaGlobal_MiniGame_YachtDice:showHandRankTooltip(" .. tostring(ii) .. ")")
      control:addInputEvent("Mouse_Out", "PaGlobal_MiniGame_YachtDice:hideHandRankTooltip()")
      control:SetPosX(0)
      control:SetPosY(ii * control:GetSizeY())
      control:SetShow(false)
      slot.parent = control
      slot.txt_handRank = UI.getChildControl(control, "StaticText_HouseSpade")
      slot.txt_point[self.__eYachtPlayerType_Me] = UI.getChildControl(control, "Button_MyPoint")
      slot.txt_point[self.__eYachtPlayerType_You] = UI.getChildControl(control, "StaticText_NPCPoint")
      slot.txt_point[self.__eYachtPlayerType_Me]:addInputEvent("Mouse_On", "PaGlobal_MiniGame_YachtDice:showSelectedFieldCard(" .. tostring(ii) .. "," .. tostring(self.__eYachtPlayerType_Me) .. ")")
      slot.txt_point[self.__eYachtPlayerType_Me]:addInputEvent("Mouse_Out", "PaGlobal_MiniGame_YachtDice:hideSelectedFieldCard()")
      slot.txt_point[self.__eYachtPlayerType_You]:addInputEvent("Mouse_On", "PaGlobal_MiniGame_YachtDice:showSelectedFieldCard(" .. tostring(ii) .. "," .. tostring(self.__eYachtPlayerType_You) .. ")")
      slot.txt_point[self.__eYachtPlayerType_You]:addInputEvent("Mouse_Out", "PaGlobal_MiniGame_YachtDice:hideSelectedFieldCard()")
      self._ui._handRankList[ii] = slot
    end
  end
  UI.deleteControl(handRankBaseUI)
  local totalBG = UI.getChildControl(leftMainBG, "Static_Total_BG")
  self._ui._txt_totalPoint = {}
  self._ui._txt_totalPoint[self.__eYachtPlayerType_Me] = self:initTotalPoint(totalBG, "StaticText_MyPoint")
  self._ui._txt_totalPoint[self.__eYachtPlayerType_You] = self:initTotalPoint(totalBG, "StaticText_NPCPoint")
  self._ui._stc_turnBG = {}
  self._ui._stc_turnBG[self.__eYachtPlayerType_Me] = self:initTurnBG("Static_MyTurnBG")
  self._ui._stc_turnBG[self.__eYachtPlayerType_You] = self:initTurnBG("Static_NPCTurnBG")
  local myTurnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_Me]
  local yourTurnBG = self._ui._stc_turnBG[self.__eYachtPlayerType_You]
  local stc_bottom = UI.getChildControl(self._ui._stc_rightBG, "Static_Bottom")
  local stc_top = UI.getChildControl(self._ui._stc_rightBG, "Static_Top")
  myTurnBG.stc_rightTurnBG = UI.getChildControl(self._ui._stc_rightBG, "Static_MyTurn")
  local bottomIcon = UI.getChildControl(stc_bottom, "Static_Icon")
  local bottomMyImage = UI.getChildControl(bottomIcon, "Static_MyImage")
  myTurnBG.stc_rightIcon = UI.getChildControl(bottomMyImage, "Static_KnowledgeImage")
  myTurnBG.txt_rightName = UI.getChildControl(stc_bottom, "StaticText_Name")
  myTurnBG.txt_rightWinRate = UI.getChildControl(stc_bottom, "StaticText_WinRate")
  myTurnBG.txt_bubble = UI.getChildControl(self._ui._stc_rightBG, "StaticText_Bubble_My")
  myTurnBG:isValidate()
  yourTurnBG.stc_rightTurnBG = UI.getChildControl(self._ui._stc_rightBG, "Static_YourTurn")
  local topIcon = UI.getChildControl(stc_top, "Static_Icon")
  local topMyImage = UI.getChildControl(topIcon, "Static_MyImage")
  yourTurnBG.stc_rightIcon = UI.getChildControl(topMyImage, "Static_KnowledgeImage")
  yourTurnBG.txt_rightName = UI.getChildControl(stc_top, "StaticText_Name")
  yourTurnBG.txt_rightWinRate = UI.getChildControl(stc_top, "StaticText_WinRate")
  yourTurnBG.txt_bubble = UI.getChildControl(self._ui._stc_rightBG, "StaticText_Bubble_Your")
  yourTurnBG:isValidate()
  self._ui._btn_mainCardSkill = UI.getChildControl(stc_bottom, "Button_CardSkill")
  self._ui._btn_mainCardSkill:SetMonoTone(true)
  self._ui._btn_mainCardSkill:SetIgnore(true)
end
function PaGlobal_MiniGame_YachtDice:initTotalPoint(parent, name)
  local totalPoint = {parent = nil, lastPoint = 0}
  function totalPoint:clear()
    totalPoint.parent:SetText("0")
    totalPoint.parent:EraseAllEffect()
    totalPoint.lastPoint = 0
  end
  function totalPoint:SetText(txt)
    totalPoint.parent:SetText(tostring(txt))
  end
  function totalPoint:EraseAllEffect()
    totalPoint.parent:EraseAllEffect()
  end
  function totalPoint:AddEffect(effectName, isLoop, posX, posY)
    totalPoint.parent:AddEffect(effectName, isLoop, posX, posY)
  end
  local parent = UI.getChildControl(parent, name)
  parent:isValidate()
  totalPoint.parent = parent
  return totalPoint
end
function PaGlobal_MiniGame_YachtDice:initTurnBG(name)
  local turnBG = {
    parent = nil,
    stc_allBG = nil,
    stc_arrow = nil,
    stc_icon = nil,
    txt_name = nil,
    stc_rightTurnBG = nil,
    stc_rightIcon = nil,
    txt_rightName = nil,
    txt_rightWinRate = nil,
    txt_bubble = nil
  }
  function turnBG:SetShow(isShow)
    turnBG.stc_topBG:SetShow(isShow)
    turnBG.stc_allBG:SetShow(isShow)
    turnBG.stc_arrow:SetShow(isShow)
    turnBG.stc_rightTurnBG:SetShow(isShow)
  end
  function turnBG:clear()
    turnBG.stc_topBG:SetShow(false)
    turnBG.stc_allBG:SetShow(false)
    turnBG.stc_arrow:SetShow(false)
    turnBG.stc_rightTurnBG:SetShow(false)
    turnBG.stc_rightTurnBG:EraseAllEffect()
    turnBG.txt_name:SetText("")
    turnBG.txt_rightName:SetText("")
    turnBG.txt_rightWinRate:SetText("")
    turnBG.txt_bubble:SetShow(false)
    turnBG.txt_bubble:SetText("")
  end
  function turnBG:SetText(txt)
    turnBG.txt_name:SetTextMode(__eTextMode_LimitText)
    turnBG.txt_name:SetText(txt)
    turnBG.txt_rightName:SetText(txt)
  end
  function turnBG:ChangeTextureInfoTextureIDKey(textureID)
    turnBG.stc_icon:ChangeTextureInfoTextureIDKey(textureID)
    turnBG.stc_icon:setRenderTexture(turnBG.stc_icon:getBaseTexture())
    turnBG.stc_rightIcon:ChangeTextureInfoTextureIDKey(textureID)
    turnBG.stc_rightIcon:setRenderTexture(turnBG.stc_rightIcon:getBaseTexture())
  end
  function turnBG:ChangeTextureInfoName(texture)
    turnBG.stc_rightIcon:ChangeTextureInfoName(texture)
    turnBG.stc_icon:ChangeTextureInfoName(texture)
  end
  function turnBG:isValidate()
    turnBG.parent:isValidate()
    turnBG.stc_allBG:isValidate()
    turnBG.stc_arrow:isValidate()
    turnBG.stc_icon:isValidate()
    turnBG.txt_name:isValidate()
    turnBG.stc_rightTurnBG:isValidate()
    turnBG.stc_rightIcon:isValidate()
    turnBG.txt_rightName:isValidate()
    turnBG.txt_rightWinRate:isValidate()
    turnBG.txt_bubble:isValidate()
  end
  local parent = UI.getChildControl(self._ui._stc_leftBG, name)
  local stc_topBG = UI.getChildControl(parent, "Static_TopBG")
  local stc_allBG = UI.getChildControl(parent, "Static_AllBG")
  local stc_noSelectBG = UI.getChildControl(parent, "Static_NoSelectBG")
  local stc_arrow = UI.getChildControl(stc_noSelectBG, "Static_Arrow")
  local stc_iconBG = UI.getChildControl(stc_noSelectBG, "Static_One")
  local stc_icon = UI.getChildControl(stc_iconBG, "Static_MyImage")
  local txt_name = UI.getChildControl(stc_noSelectBG, "StaticText_Name")
  parent:SetIgnore(true)
  turnBG.parent = parent
  turnBG.stc_topBG = stc_topBG
  turnBG.stc_allBG = stc_allBG
  turnBG.stc_arrow = stc_arrow
  turnBG.stc_icon = stc_icon
  turnBG.txt_name = txt_name
  return turnBG
end
function PaGlobal_MiniGame_YachtDice:initRightBG()
  self:initDiceCard()
  self:initFieldCard()
  self._ui._btn_roll = UI.getChildControl(self._ui._stc_rightBG, "Button_Roll")
  local keyText_Y = UI.getChildControl(self._ui._btn_roll, "StaticText_Y_ConsoleUI")
  keyText_Y:SetShow(true == self._isConsole)
  local timer = {
    parent = nil,
    progress = nil,
    txt_time = nil
  }
  function timer:SetShow(isShow)
    timer.parent:SetShow(isShow)
  end
  function timer:GetShow()
    return timer.parent:GetShow()
  end
  function timer:SetText(txt)
    timer.txt_time:SetText(txt)
  end
  timer.parent = UI.getChildControl(self._ui._stc_rightBG, "Static_Timer")
  timer.progress = UI.getChildControl(timer.parent, "CircularProgress_1")
  timer.txt_time = UI.getChildControl(timer.parent, "StaticText_Count")
  self._ui._stc_timer = timer
  local keyGuideBG = {
    parent = nil,
    pc_guide = nil,
    console_guide1 = nil,
    console_guide2 = nil
  }
  function keyGuideBG:SetShow(isShow)
    if false == isShow then
      keyGuideBG.parent:SetShow(false)
    else
      keyGuideBG.parent:SetShow(true)
      if true == PaGlobal_MiniGame_YachtDice._isConsole then
        keyGuideBG.pc_guide:SetShow(false)
        keyGuideBG.console_guide1:SetShow(true)
        keyGuideBG.console_guide2:SetShow(true)
      else
        keyGuideBG.pc_guide:SetShow(true)
        keyGuideBG.console_guide1:SetShow(false)
        keyGuideBG.console_guide2:SetShow(false)
      end
    end
  end
  function keyGuideBG:isValidate()
    keyGuideBG.parent:isValidate()
    keyGuideBG.pc_guide:isValidate()
    keyGuideBG.console_guide1:isValidate()
    keyGuideBG.console_guide2:isValidate()
  end
  keyGuideBG.parent = UI.getChildControl(Panel_Window_MiniGame_YachtDice, "Static_KeyGuide_BG")
  keyGuideBG.pc_guide = UI.getChildControl(keyGuideBG.parent, "StaticText_LClick_PC")
  keyGuideBG.console_guide1 = UI.getChildControl(keyGuideBG.parent, "StaticText_CardSelect_RB_ConsoleUI")
  keyGuideBG.console_guide2 = UI.getChildControl(keyGuideBG.parent, "StaticText_CardSelect_RT_ConsoleUI")
  self._ui._stc_keyGuideBG = keyGuideBG
end
function PaGlobal_MiniGame_YachtDice:initDiceCard()
  local baseSmallCardUI = UI.getChildControl(self._ui._stc_rightBG, "Button_Small")
  local sizeX = self._ui._stc_rightBG:GetSizeX()
  local sizeY = self._ui._stc_rightBG:GetSizeY()
  local smallCardOffsetX = 20
  local smallCardOffsetY = 20
  self._diceCardSizeX = baseSmallCardUI:GetSizeX()
  self._diceCardSizeY = baseSmallCardUI:GetSizeY()
  self._ui._diceCardList = {}
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    self._ui._diceCardList[ii] = {}
    for jj = 0, __eYachtDiceCount - 1 do
      self._ui._diceCardList[ii][jj] = {}
      for kk = 0, __eTYachtEyeCount - 1 do
        do
          local diceCard = {
            parent = nil,
            stc_knowledgeImage = nil,
            stc_numberImage = nil,
            stc_backImage = nil,
            initPos = float2(0, 0),
            destPos = float2(0, 0),
            initSize = float2(0, 0),
            destSize = float2(0, 0),
            startTime = 0,
            currentTime = 0
          }
          function diceCard:clear()
            diceCard.startTime = 0
            diceCard.currentTime = 0
            diceCard.parent:SetAlphaChild(1)
          end
          function diceCard:SetShow(isShow)
            diceCard.parent:SetShow(isShow)
          end
          function diceCard:SetAlphaChild(value)
            diceCard.parent:SetAlphaChild(value)
          end
          function diceCard:SetPosX(posX)
            diceCard.parent:SetPosX(posX)
          end
          function diceCard:SetPosY(posY)
            diceCard.parent:SetPosY(posY)
          end
          function diceCard:SetScaleChild(scaleX, scaleY)
            diceCard.parent:SetScaleChild(scaleX, scaleY)
          end
          function diceCard:SetFrontImage()
            diceCard.stc_knowledgeImage:SetShow(true)
            diceCard.stc_numberImage:SetShow(true)
            diceCard.stc_backImage:SetShow(false)
          end
          function diceCard:SetBackImage()
            diceCard.stc_knowledgeImage:SetShow(false)
            diceCard.stc_numberImage:SetShow(false)
            diceCard.stc_backImage:SetShow(true)
          end
          function diceCard:SetIgnore(ignore)
            diceCard.parent:SetIgnore(ignore)
            diceCard.stc_knowledgeImage:SetIgnore(ignore)
            diceCard.stc_numberImage:SetIgnore(ignore)
            diceCard.stc_backImage:SetIgnore(ignore)
          end
          local parent = UI.cloneControl(baseSmallCardUI, self._ui._stc_rightBG, "SmallCard_" .. tostring(ii) .. "_" .. tostring(jj) .. "_" .. tostring(kk))
          local stc_knowledgeImage = UI.getChildControl(parent, "Static_KnowledgeImage")
          local stc_numberImage = UI.getChildControl(parent, "Static_NumberParts")
          local stc_backImage = UI.getChildControl(parent, "Static_Back")
          diceCard.parent = parent
          diceCard.stc_knowledgeImage = stc_knowledgeImage
          diceCard.stc_numberImage = stc_numberImage
          diceCard.stc_backImage = stc_backImage
          diceCard.initSize.x = parent:GetSizeX()
          diceCard.initSize.y = parent:GetSizeY()
          diceCard:SetShow(false)
          if self.__eYachtPlayerType_Me == ii and __eTYachtEyeCount - 2 == kk then
            diceCard:SetIgnore(false)
            diceCard.stc_backImage:addInputEvent("Mouse_On", "PaGlobal_MiniGame_YachtDice:showMyDeckTooltip(" .. tostring(jj) .. ")")
            diceCard.stc_backImage:addInputEvent("Mouse_Out", "PaGlobal_MiniGame_YachtDice:hideMyDeckTooltip()")
          else
            diceCard:SetIgnore(true)
          end
          self._ui._diceCardList[ii][jj][kk] = diceCard
        end
      end
    end
  end
  self._diceCardPos = {
    [self.__eYachtPlayerType_Me] = {
      initPos = float2(0, 0),
      destPos = float2(0, 0)
    },
    [self.__eYachtPlayerType_You] = {
      initPos = float2(0, 0),
      destPos = float2(0, 0)
    }
  }
  self._diceCardPos[self.__eYachtPlayerType_Me].destPos = float2(sizeX - (self._diceCardSizeX * __eYachtDiceCount + 10 * (__eYachtDiceCount - 1) + smallCardOffsetX), sizeY - (self._diceCardSizeY + smallCardOffsetY))
  self._diceCardPos[self.__eYachtPlayerType_You].destPos = float2(smallCardOffsetX, smallCardOffsetY)
  self._diceCardPos[self.__eYachtPlayerType_Me].initPos.x = self._diceCardPos[self.__eYachtPlayerType_Me].destPos.x
  self._diceCardPos[self.__eYachtPlayerType_Me].initPos.y = self._diceCardPos[self.__eYachtPlayerType_Me].destPos.y + smallCardOffsetY
  self._diceCardPos[self.__eYachtPlayerType_You].initPos.x = self._diceCardPos[self.__eYachtPlayerType_You].destPos.x
  self._diceCardPos[self.__eYachtPlayerType_You].initPos.y = self._diceCardPos[self.__eYachtPlayerType_You].destPos.y - smallCardOffsetY
  UI.deleteControl(baseSmallCardUI)
end
function PaGlobal_MiniGame_YachtDice:initFieldCard()
  local baseBigCardUI = UI.getChildControl(self._ui._stc_rightBG, "Button_Big")
  local sizeX = self._ui._stc_rightBG:GetSizeX()
  local sizeY = self._ui._stc_rightBG:GetSizeY()
  local bigCardSizeX = baseBigCardUI:GetSizeX()
  local bigCardSizeY = baseBigCardUI:GetSizeY()
  local bigCardOffsetX = 15
  local initBigCardPosX = (sizeX - (bigCardSizeX * __eYachtDiceCount + bigCardOffsetX * (__eYachtDiceCount - 1))) / 2
  local initBigCardPosY = (sizeY - bigCardSizeY) / 2
  self._ui._fieldCardList = {}
  for ii = 0, __eYachtDiceCount - 1 do
    do
      local fieldCard = {
        parent = nil,
        stc_knowledgeImage = nil,
        stc_numberImage = nil,
        txt_isKeep = nil,
        stc_backImage = nil,
        initPos = float2(0, 0),
        txt_isKeepPos = float2(0, 0)
      }
      function fieldCard:SetShow(isShow)
        fieldCard.parent:SetShow(isShow)
      end
      function fieldCard:SetFrontImage()
        fieldCard.stc_knowledgeImage:SetShow(true)
        fieldCard.stc_numberImage:SetShow(true)
        fieldCard.stc_backImage:SetShow(false)
      end
      function fieldCard:SetBackImage()
        fieldCard.stc_knowledgeImage:SetShow(false)
        fieldCard.stc_numberImage:SetShow(false)
        fieldCard.stc_backImage:SetShow(true)
      end
      function fieldCard:SetIgnore(ignore)
        fieldCard.parent:SetIgnore(ignore)
        fieldCard.stc_knowledgeImage:SetIgnore(ignore)
        fieldCard.stc_numberImage:SetIgnore(ignore)
        fieldCard.stc_backImage:SetIgnore(ignore)
      end
      local parent = UI.cloneControl(baseBigCardUI, self._ui._stc_rightBG, "FieldCard_" .. tostring(ii))
      parent:SetPosX(initBigCardPosX + (bigCardSizeX + bigCardOffsetX) * ii)
      parent:SetPosY(initBigCardPosY)
      local stc_knowledgeImage = UI.getChildControl(parent, "Static_KnowledgeImage")
      local stc_numberImage = UI.getChildControl(parent, "Static_NumberParts")
      local txt_isKeep = UI.getChildControl(parent, "StaticText_Keep")
      local stc_backImage = UI.getChildControl(parent, "Static_Back")
      fieldCard.parent = parent
      fieldCard.stc_knowledgeImage = stc_knowledgeImage
      fieldCard.stc_numberImage = stc_numberImage
      fieldCard.txt_isKeep = txt_isKeep
      fieldCard.stc_backImage = stc_backImage
      fieldCard.initPos.x = parent:GetPosX()
      fieldCard.initPos.y = parent:GetPosY()
      fieldCard.txt_isKeepPos.x = txt_isKeep:GetPosX()
      fieldCard.txt_isKeepPos.y = txt_isKeep:GetPosY()
      self._ui._fieldCardList[ii] = fieldCard
    end
  end
  UI.deleteControl(baseBigCardUI)
  self:initDiceCardDestInfo()
end
function PaGlobal_MiniGame_YachtDice:initDiceCardDestInfo()
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    for jj = 0, __eYachtDiceCount - 1 do
      local fieldCard = self._ui._fieldCardList[jj]
      _PA_ASSERT(nil ~= fieldCard, "fieldCard nil \236\158\133\235\139\136\235\139\164.")
      for kk = 0, __eTYachtEyeCount - 1 do
        local diceCard = self._ui._diceCardList[ii][jj][kk]
        _PA_ASSERT(nil ~= diceCard, "diceCard\234\176\128 nil \236\158\133\235\139\136\235\139\164.")
        diceCard.destPos.x = fieldCard.parent:GetPosX()
        diceCard.destPos.y = fieldCard.parent:GetPosY()
        diceCard.destSize.x = fieldCard.parent:GetSizeX()
        diceCard.destSize.y = fieldCard.parent:GetSizeY()
        _PA_ASSERT(diceCard.initSize.x < diceCard.destSize.x, "destSize\234\176\128 initSize\235\179\180\235\139\164 \236\158\145\236\138\181\235\139\136\235\139\164.")
        _PA_ASSERT(diceCard.initSize.y < diceCard.destSize.y, "destSize\234\176\128 initSize\235\179\180\235\139\164 \236\158\145\236\138\181\235\139\136\235\139\164.")
      end
    end
  end
end
function PaGlobal_MiniGame_YachtDice:initConsoleKeyGuideBG()
  if false == self._isConsole then
    self._ui._stc_consoleKeyGuideBG:SetShow(false)
    return
  end
  local stc_keyGuide_X = UI.getChildControl(self._ui._stc_consoleKeyGuideBG, "StaticText_X_ConsoleUI")
  local stc_keyGuide_B = UI.getChildControl(self._ui._stc_consoleKeyGuideBG, "StaticText_B_ConsoleUI")
  local stc_keyGuide_A = UI.getChildControl(self._ui._stc_consoleKeyGuideBG, "StaticText_A_ConsoleUI")
  local stc_keyGuide_DPad = UI.getChildControl(self._ui._stc_consoleKeyGuideBG, "StaticText_DPad_ConsoleUI")
  stc_keyGuide_X:SetShow(true)
  stc_keyGuide_B:SetShow(true)
  stc_keyGuide_A:SetShow(true)
  stc_keyGuide_DPad:SetShow(true)
  local keyGuide = {
    stc_keyGuide_DPad,
    stc_keyGuide_A,
    stc_keyGuide_X,
    stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_consoleKeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._stc_consoleKeyGuideBG:SetShow(true)
end
function PaGlobal_MiniGame_YachtDice:eventStartDrawCard(index, isDrawCard)
  _PA_ASSERT(nil ~= index, "index is nil")
  self._currentRenderEventType = self._renderEventType.DrawFieldCard
  self._drawCardCount = 0
  self._isDrawCard = isDrawCard
  self._drawIndex = index
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  self._drawCardList = {}
  local list = self._ui._diceCardList[index]
  if nil == list then
    return
  end
  for _, ii in pairs(self._rollCardList) do
    local diceCard = list[ii][__eTYachtEyeCount - 1]
    _PA_ASSERT(nil ~= diceCard, "diceCard is nil")
    diceCard:clear()
    diceCard.startTime = self._drawCardCount * 0.1
    if true == isDrawCard then
      diceCard:SetBackImage()
    else
      diceCard:SetFrontImage()
    end
    diceCard:SetShow(false)
    self._drawCardList[ii] = diceCard
    self._drawCardCount = self._drawCardCount + 1
  end
  for key, diceCard in pairs(self._drawCardList) do
    local fieldCard = self._ui._fieldCardList[key]
    _PA_ASSERT(nil ~= fieldCard, "fieldCard is nil")
    fieldCard:SetShow(false)
  end
  self:updateDrawSound(self._isDrawCard, self._drawCardCount)
end
function PaGlobal_MiniGame_YachtDice:eventEndDrawCard()
  self._currentRenderEventType = self._renderEventType.None
  self._drawCardCount = 0
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  for key, diceCard in pairs(self._drawCardList) do
    diceCard:SetShow(false == self._isDrawCard)
    local fieldCard = self._ui._fieldCardList[key]
    fieldCard:SetShow(true == self._isDrawCard)
  end
  if false == self._isDrawCard then
    self:eventStartDrawCard(self._drawIndex, true)
  else
    self._rollCardList = {}
    self._drawCardList = {}
    self._drawIndex = nil
    self:updatePoint()
    if false == ToClient_isMyTurnMiniGameYachtDice() then
      self:endNpcAction()
    else
      self:padSnappingRightBG()
    end
  end
end
function PaGlobal_MiniGame_YachtDice:renderEventDrawFieldCard(deltaTime)
  if self._renderEventType.DrawFieldCard ~= self._currentRenderEventType then
    return
  end
  self._startTime = self._startTime + deltaTime
  if self._startTime < self._delayTime then
    return
  end
  local startTime = self._startTime - self._delayTime
  local maxTime = 0.3
  local drawEndCount = 0
  for _, diceCard in pairs(self._drawCardList) do
    if startTime > diceCard.startTime then
      local ratio = diceCard.currentTime / maxTime
      if ratio > 1 then
        ratio = 1
        drawEndCount = drawEndCount + 1
      end
      local maxScaleX = diceCard.destSize.x / diceCard.initSize.x
      local maxScaleY = diceCard.destSize.y / diceCard.initSize.y
      local scaleX = 0
      local scaleY = 0
      local dx = 0
      local dy = 0
      local initPosX = 0
      local initPosY = 0
      if true == self._isDrawCard then
        scaleX = (maxScaleX - 1) * ratio + 1
        scaleY = (maxScaleY - 1) * ratio + 1
        dx = diceCard.destPos.x - diceCard.initPos.x
        dy = diceCard.destPos.y - diceCard.initPos.y
        initPosX = diceCard.initPos.x
        initPosY = diceCard.initPos.y
      else
        scaleX = -(maxScaleX - 1) * ratio + maxScaleX
        scaleY = -(maxScaleY - 1) * ratio + maxScaleY
        dx = diceCard.initPos.x - diceCard.destPos.x
        dy = diceCard.initPos.y - diceCard.destPos.y
        initPosX = diceCard.destPos.x
        initPosY = diceCard.destPos.y
        diceCard:SetAlphaChild(1 - ratio)
      end
      diceCard:SetScaleChild(scaleX, scaleY)
      diceCard:SetPosX(initPosX + dx * ratio)
      diceCard:SetPosY(initPosY + dy * ratio)
      diceCard:SetShow(ratio > 0)
      diceCard.currentTime = diceCard.currentTime + deltaTime
    end
  end
  if drawEndCount >= self._drawCardCount then
    self:eventEndDrawCard()
  end
end
function PaGlobal_MiniGame_YachtDice:updateRollCardList()
  local rollCount = ToClient_getCurrentRollCountMiniGameYachtDice()
  local index = 0
  if true == ToClient_isMyTurnMiniGameYachtDice() then
    index = self.__eYachtPlayerType_Me
  else
    index = self.__eYachtPlayerType_You
  end
  self._rollCardList = {}
  for ii = 0, __eYachtDiceCount - 1 do
    local fieldCard = self._ui._fieldCardList[ii]
    local isShow = fieldCard.txt_isKeep:GetShow()
    if false == isShow then
      table.insert(self._rollCardList, ii)
    else
      fieldCard:SetShow(true)
    end
  end
  if 1 == rollCount then
    self:eventStartDrawCard(index, true)
  else
    self:eventStartDrawCard(index, false)
  end
end
function PaGlobal_MiniGame_YachtDice:eventStartBeforeGameStart()
  audioPostEvent_SystemUi(11, 63)
  self._currentRenderEventType = self._renderEventType.BeforeGameStart
  self._startTime = 0
  self._endTime = 0.5
  self._delayTime = 0.5
  self._ui._stc_msgPhase:SetShow(false)
  local control = self._ui._stc_msgPhase.parent
  control:EraseAllEffect()
end
function PaGlobal_MiniGame_YachtDice:eventEndBeforeGameStart()
  self._currentRenderEventType = self._renderEventType.None
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  self._ui._stc_msgPhase:SetTitle(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_TITLE_0"))
  self._ui._stc_msgPhase:SetDesc(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_DESC_0"))
  self._ui._stc_msgPhase:SetShow(true)
end
function PaGlobal_MiniGame_YachtDice:renderEventBeforeGameStart(deltaTime)
  if self._renderEventType.BeforeGameStart ~= self._currentRenderEventType then
    return
  end
  self._startTime = self._startTime + deltaTime
  if self._startTime < self._delayTime then
    return
  end
  local startTime = self._startTime - self._delayTime
  if startTime > self._endTime then
    self:eventEndBeforeGameStart()
    return
  end
  local ratio = startTime / self._endTime
  if ratio > 1 then
    ratio = 1
  end
  local defaultAlpha = 0.6
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local posInfo = self._diceCardPos[ii]
    local dx = posInfo.destPos.x - posInfo.initPos.x
    local dy = posInfo.destPos.y - posInfo.initPos.y
    local posX = posInfo.initPos.x + dx * ratio
    local posY = posInfo.initPos.y + dy * ratio
    self:setDiceCardListPosition(ii, posX, posY, true, defaultAlpha + (1 - defaultAlpha) * ratio)
  end
end
function PaGlobal_MiniGame_YachtDice:eventStartChangeTurn()
  self._currentRenderEventType = self._renderEventType.ChangeTurn
  self._startTime = 0
  self._endTime = 1.5
  self._delayTime = 0
  local txt_title = ""
  local txt_desc = ""
  local txt_msgGuide = ""
  local control = self._ui._stc_msgPhase.parent
  control:EraseAllEffect()
  if false == ToClient_isMyTurnMiniGameYachtDice() then
    if false == self._isTimeOut then
      txt_title = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_TITLE_1")
      txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_DESC_1")
    else
      txt_title = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_TITLE_3")
      txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_DESC_3")
      control:AddEffect("fUI_Mini_Game_05A", true, 0, 0)
    end
    txt_msgGuide = PAGetString(Defines.StringSheet_GAME, "LUA_CARDGAME_GUIDE_1")
  else
    txt_title = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_TITLE_2")
    txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_PHASE_DESC_2")
    txt_msgGuide = PAGetString(Defines.StringSheet_GAME, "LUA_CARDGAME_GUIDE_0")
  end
  self._ui._stc_msgPhase:SetTitle(txt_title)
  self._ui._stc_msgPhase:SetDesc(txt_desc)
  self._ui._stc_msgGuide:SetText(txt_msgGuide)
  self._ui._stc_msgPhase:SetShow(true)
  self._ui._stc_msgGuide:SetShow(true)
end
function PaGlobal_MiniGame_YachtDice:eventEndChangeTurn()
  self._currentRenderEventType = self._renderEventType.None
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  self._ui._stc_msgPhase:SetShow(false)
  local control = self._ui._stc_msgPhase.parent
  control:EraseAllEffect()
  if false == ToClient_isMyTurnMiniGameYachtDice() then
    self:endNpcAction()
  end
end
function PaGlobal_MiniGame_YachtDice:renderEventChangeTurn(deltaTime)
  if self._renderEventType.ChangeTurn ~= self._currentRenderEventType then
    return
  end
  self._startTime = self._startTime + deltaTime
  if self._startTime < self._delayTime then
    return
  end
  local startTime = self._startTime - self._delayTime
  if startTime > self._endTime then
    self:eventEndChangeTurn()
    return
  end
end
function PaGlobal_MiniGame_YachtDice:eventStartKeep(index, isKeep)
  if nil ~= self._fieldCardKeepIndex then
    _PA_ASSERT(false, "self._fieldCardKeepIndex is nil")
    return
  end
  local fieldCard = self._ui._fieldCardList[index]
  local isShow = fieldCard.txt_isKeep:GetShow()
  if isShow == isKeep then
    self:eventEndKeep()
    return
  end
  fieldCard.txt_isKeep:SetShow(true)
  local moveValue = 10
  self._currentRenderEventType = self._renderEventType.Keep
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  self._isKeep = isKeep
  if true == isKeep then
    audioPostEvent_SystemUi(11, 119)
    fieldCard.txt_isKeep:SetAlphaChild(0)
    self._endTime = 0.3
  else
    audioPostEvent_SystemUi(11, 122)
    fieldCard.txt_isKeep:SetAlphaChild(1)
    self._endTime = 0.2
  end
  self._fieldCardKeepIndex = index
end
function PaGlobal_MiniGame_YachtDice:eventEndKeep()
  self._currentRenderEventType = self._renderEventType.None
  self._startTime = 0
  self._endTime = 0
  self._delayTime = 0
  if nil ~= self._fieldCardKeepIndex then
    local fieldCard = self._ui._fieldCardList[self._fieldCardKeepIndex]
    fieldCard.txt_isKeep:SetShow(self._isKeep)
  end
  self._fieldCardKeepIndex = nil
  self._isKeep = nil
  if false == ToClient_isMyTurnMiniGameYachtDice() then
    self:endNpcAction()
  end
end
function PaGlobal_MiniGame_YachtDice:renderEventKeep(deltaTime)
  if self._renderEventType.Keep ~= self._currentRenderEventType then
    return
  end
  self._startTime = self._startTime + deltaTime
  if self._startTime < self._delayTime then
    return
  end
  local startTime = self._startTime - self._delayTime
  if startTime > self._endTime then
    self:eventEndKeep()
    return
  end
  local ratio = startTime / self._endTime
  if ratio > 1 then
    ratio = 1
  end
  local fieldCard = self._ui._fieldCardList[self._fieldCardKeepIndex]
  local fromPos = float2(0, 0)
  local toPos = float2(0, 0)
  fromPos.x = fieldCard.txt_isKeepPos.x
  toPos.x = fieldCard.txt_isKeepPos.x
  if true == self._isKeep then
    fromPos.y = fieldCard.txt_isKeepPos.y + 10
    toPos.y = fieldCard.txt_isKeepPos.y
    fieldCard.txt_isKeep:SetAlphaChild(ratio)
  else
    fromPos.y = fieldCard.txt_isKeepPos.y
    toPos.y = fieldCard.txt_isKeepPos.y + 10
    fieldCard.txt_isKeep:SetAlphaChild(1 - ratio)
  end
  local dx = toPos.x - fromPos.x
  local dy = toPos.y - fromPos.y
  fieldCard.txt_isKeep:SetPosX(fromPos.x + dx * ratio)
  fieldCard.txt_isKeep:SetPosY(fromPos.y + dy * ratio)
  fromPos.x = fieldCard.initPos.x
  toPos.x = fieldCard.initPos.x
  if true == self._isKeep then
    fromPos.y = fieldCard.initPos.y
    toPos.y = fieldCard.initPos.y + 5
  else
    fromPos.y = fieldCard.initPos.y + 5
    toPos.y = fieldCard.initPos.y
  end
  dx = toPos.x - fromPos.x
  dy = toPos.y - fromPos.y
  fieldCard.parent:SetPosX(fromPos.x + dx * ratio)
  fieldCard.parent:SetPosY(fromPos.y + dy * ratio)
end
function PaGlobal_MiniGame_YachtDice:loadCompleteNpcAction()
  local npcEventMaxCount = ToClient_getMiniGameYachtRemainNpcActionEventCount()
  if npcEventMaxCount <= 0 then
    return
  end
  self._npcEventMaxCount = npcEventMaxCount
  self._npcEventCurrentIndex = 0
  self:startNpcAction()
end
function PaGlobal_MiniGame_YachtDice:startNpcAction()
  local actionWrapper = ToClient_getNpcYachtActionFlowDataWrapper(self._npcEventCurrentIndex)
  if nil == actionWrapper then
    return
  end
  local eventType = actionWrapper:getEventType()
  if __eNpcYachtActionEventType_TurnOn == eventType then
    self:eventStartChangeTurn()
    self._npcEventCurrentIndex = self._npcEventCurrentIndex + 1
  elseif __eNpcYachtActionEventType_Roll == eventType then
    local rollCount = actionWrapper:getValue()
    ToClient_setRollCountMiniGameYachtDice(rollCount)
    ToClient_setAcceptorDiceListMiniGameYachtDice(self._npcEventCurrentIndex)
    self:updateFieldCard()
    self:updateRollCardList()
    self._npcEventCurrentIndex = self._npcEventCurrentIndex + 1
    local beginIndex = self._npcEventCurrentIndex
    local endIndex = beginIndex + ToClient_getMiniGameYachtNpcActionRollResultEventCount(beginIndex)
    for ii = beginIndex, endIndex - 1 do
      local tempWrapper = ToClient_getNpcYachtActionFlowDataWrapper(ii)
      local tempEventType = tempWrapper:getEventType()
      _PA_ASSERT(tempEventType == __eNpcYachtActionEventType_RollResultHandRank, "tempEventType \236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.")
      local key = tempWrapper:getHankRankKey()
      local point = tempWrapper:getValue()
      ToClient_setAcceptorHandRankPointMiniGameYachtDice(key, point)
      self._npcEventCurrentIndex = self._npcEventCurrentIndex + 1
    end
  elseif __eNpcYachtActionEventType_CheckHandRank == eventType then
    ToClient_checkHandRankMiniGameYachtDice(actionWrapper:getHankRankKey(), false)
  elseif __eNpcYachtActionEventType_Keep == eventType then
    local index = actionWrapper:getValue()
    self:updateKeepCard(index, true)
    self._npcEventCurrentIndex = self._npcEventCurrentIndex + 1
  elseif __eNpcYachtActionEventType_UnKeep == eventType then
    local index = actionWrapper:getValue()
    self:updateKeepCard(index, false)
    self._npcEventCurrentIndex = self._npcEventCurrentIndex + 1
  else
    _PA_ASSERT(false, "eventType\236\157\180 \235\185\132\236\160\149\236\131\129 \236\158\133\235\139\136\235\139\164.")
  end
end
function PaGlobal_MiniGame_YachtDice:endNpcAction()
  if self._npcEventMaxCount <= self._npcEventCurrentIndex then
    self._isUpdateNpcEvent = false
    return
  end
  local actionWrapper = ToClient_getNpcYachtActionFlowDataWrapper(self._npcEventCurrentIndex)
  if nil == actionWrapper then
    self._isUpdateNpcEvent = false
    return
  end
  self._npcActionEventTime = 0
  self._isUpdateNpcEvent = true
  self._npcActionEventMaxTime = 1
  local eventType = actionWrapper:getEventType()
  if __eNpcYachtActionEventType_TurnOn == eventType then
  elseif __eNpcYachtActionEventType_Roll == eventType then
  elseif __eNpcYachtActionEventType_CheckHandRank == eventType then
  elseif __eNpcYachtActionEventType_Keep == eventType then
    self._npcActionEventMaxTime = 0.3
  else
    if __eNpcYachtActionEventType_UnKeep == eventType then
      self._npcActionEventMaxTime = 0.2
    else
    end
  end
end
function PaGlobal_MiniGame_YachtDice:updateNpcActionEvent(deltaTime)
  if false == self._isUpdateNpcEvent then
    return
  end
  self._npcActionEventTime = self._npcActionEventTime + deltaTime
  if self._npcActionEventTime < self._npcActionEventMaxTime then
    return
  end
  self._npcActionEventTime = 0
  self._isUpdateNpcEvent = false
  self:startNpcAction()
end
function PaGlobal_MiniGame_YachtDice:updateTimer(deltaTime)
  if false == self._ui._stc_timer:GetShow() then
    return
  end
  self._turnRemainTime = self._turnRemainTime - deltaTime
  if self._turnRemainTime < 0 then
    self._turnRemainTime = 0
  end
  local ratio = self._turnRemainTime / ToClient_getMiniGameYachtTurnMaxTime()
  local remainTime = ToClient_getMiniGameYachtTurnRemainTime()
  self._ui._stc_timer.progress:SetProgressRate(ratio * 100)
  self._ui._stc_timer:SetText(tostring(remainTime))
  if remainTime == 10 and true == self._isTimeOutEffectShow then
    self._ui._stc_timer.txt_time:AddEffect("fUI_Mini_Game_04A", false, 0, 0)
    self._isTimeOutEffectShow = false
  end
  if self._soundTime == remainTime then
    audioPostEvent_SystemUi(11, 117)
    self._soundTime = self._soundTime - 1
  end
end
function PaGlobal_MiniGame_YachtDice:eventStartHandRank(isTotalScoreEffectShow)
  for ii = 0, __eYachtDiceHandRankMax - 1 do
    local slot = self._ui._handRankList[ii]
    slot.isOpen = false
  end
  for ii = 0, self.__eYachtPlayerType_Count - 1 do
    local control = self._ui._txt_totalPoint[ii]
    control:EraseAllEffect()
  end
  self._isEventStartHandRank = true
  self._eventHandRankTime = 0
  self._isTotalScoreEffectShow = isTotalScoreEffectShow
end
function PaGlobal_MiniGame_YachtDice:eventEndHandRank()
  self._isEventStartHandRank = false
  if true == self._isTotalScoreEffectShow then
    local myTotalPoint = PaGlobal_MiniGame_YachtDice_Result._hostPoint
    local yourTotalPoint = PaGlobal_MiniGame_YachtDice_Result._acceptorPoint
    local myControl = self._ui._txt_totalPoint[self.__eYachtPlayerType_Me]
    local yourControl = self._ui._txt_totalPoint[self.__eYachtPlayerType_You]
    if myTotalPoint > yourTotalPoint then
      myControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
      yourControl:EraseAllEffect()
    elseif myTotalPoint < yourTotalPoint then
      myControl:EraseAllEffect()
      yourControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
    else
      myControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
      yourControl:AddEffect("fUI_Mini_Game_06A", true, 0, 0)
    end
  end
end
function PaGlobal_MiniGame_YachtDice:renderEventHandRank(deltaTime)
  if false == self._isEventStartHandRank then
    return
  end
  self._eventHandRankTime = self._eventHandRankTime + deltaTime
  local openCount = 0
  local totalCount = 0
  for ii = 0, __eYachtDiceHandRankMax - 1 do
    local slot = self._ui._handRankList[ii]
    if nil ~= slot.keyRaw then
      if slot.startTime < self._eventHandRankTime and false == slot.isOpen then
        slot:SetShow(true)
        slot.parent:AddEffect("fUI_Mini_Game_01A", false, 0, 0)
        slot.isOpen = true
        audioPostEvent_SystemUi(11, 107)
      end
      if true == slot.isOpen then
        openCount = openCount + 1
      end
      totalCount = totalCount + 1
    end
  end
  if openCount == totalCount then
    self:eventEndHandRank()
  end
end
function PaGlobal_MiniGame_YachtDice:updateKeyInput(deltaTime)
  if true == self._isConsole then
    self:updateConsoleKeyInput(deltaTime)
  else
    self:updatePCKeyInput(deltaTime)
  end
end
function PaGlobal_MiniGame_YachtDice:updateConsoleKeyInput(deltaTime)
  if true == isPadDown(__eJoyPadInputType_B) then
    self:closeMsg()
  end
end
function PaGlobal_MiniGame_YachtDice:updatePCKeyInput(deltaTime)
  if true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
    self:closeMsg()
  end
end
function PaGlobal_MiniGame_YachtDice:padSnappingLeftBG()
  if false == self._isConsole then
    return
  end
  local ii = 0
  local jj = 0
  if nil ~= self._selectedCheckHandIndex then
    ii = math.floor(self._selectedCheckHandIndex / 10)
    jj = math.floor(self._selectedCheckHandIndex % 10)
  end
  local slot = self._ui._handRankList[ii]
  if nil == slot then
    return
  end
  if nil == slot.keyRaw then
    return
  end
  local control = slot.txt_point[jj]
  if nil ~= control and true == control:GetShow() then
    ToClient_padSnapChangeToTarget(control)
  end
end
function PaGlobal_MiniGame_YachtDice:padSnappingRightBG()
  if false == self._isConsole then
    return
  end
  if false == ToClient_isMyTurnMiniGameYachtDice() then
    return
  end
  local index = 0
  if nil ~= self._selectedKeepCardIndex then
    index = self._selectedKeepCardIndex
  end
  local control = self._ui._fieldCardList[index].parent
  if nil ~= control and true == control:GetShow() then
    ToClient_padSnapChangeToTarget(control)
  end
end
function PaGlobal_MiniGame_YachtDice:updateDrawSound(isDraw, drawCount)
  local index
  if true == isDraw then
    if 5 == drawCount then
      index = 108
    elseif 4 == drawCount then
      index = 110
    elseif 3 == drawCount then
      index = 111
    elseif 2 == drawCount then
      index = 113
    else
      if 1 == drawCount then
        index = 115
      else
      end
    end
  elseif 5 == drawCount then
    index = 109
  elseif 4 == drawCount then
    index = 109
  elseif 3 == drawCount then
    index = 112
  elseif 2 == drawCount then
    index = 114
  else
    if 1 == drawCount then
      index = 116
    else
    end
  end
  if nil ~= index then
    audioPostEvent_SystemUi(11, index)
  end
end
function PaGlobal_MiniGame_YachtDice:updateCheckHandEffect(key, isSelf, point)
  local index = 0
  if true == isSelf then
    index = self.__eYachtPlayerType_Me
  else
    index = self.__eYachtPlayerType_You
  end
  for ii = 0, __eYachtDiceHandRankMax - 1 do
    local slot = self._ui._handRankList[ii]
    if nil ~= slot.keyRaw and key:get() == slot.keyRaw then
      local control = slot.txt_point[index]
      local effectName = ""
      if 0 == point then
        effectName = "fUI_Mini_Game_02A"
      elseif point < 10 then
        effectName = "fUI_Mini_Game_02B"
      elseif point < 20 then
        effectName = "fUI_Mini_Game_02C"
      elseif point < 50 then
        effectName = "fUI_Mini_Game_02D"
      else
        effectName = "fUI_Mini_Game_02E"
      end
      control:AddEffect(effectName, false, 0, 0)
    end
  end
  audioPostEvent_SystemUi(11, 118)
end
