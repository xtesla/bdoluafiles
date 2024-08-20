function PaGlobal_MiniGame_Tooltip:initialize()
  self._ui._diceCardList = {}
  for ii = 0, __eYachtDiceCount - 1 do
    do
      local diceCard = {parent = nil}
      function diceCard:SetShow(isShow)
        diceCard.parent:SetShow(isShow)
      end
      local control = UI.getChildControl(Panel_Widget_MiniGame_Tooltip, "Static_MyDeck_Templete" .. tostring(ii) .. "_Import")
      control:isValidate()
      control:SetShow(true)
      diceCard.parent = control
      self._ui._diceCardList[ii] = diceCard
    end
  end
  local baseCard = self._ui._diceCardList[0].parent
  _PA_ASSERT(nil ~= baseCard, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
  self._diceCardListSizeX = baseCard:GetSizeX() * __eYachtDiceCount + 5 * (__eYachtDiceCount - 1)
  self._diceCardListSizeY = baseCard:GetSizeY()
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MiniGame_Tooltip:clear()
  self._ui._txt_desc:SetText("")
  self:clearRefCount()
end
function PaGlobal_MiniGame_Tooltip:clearRefCount()
  self._refCount = 0
end
function PaGlobal_MiniGame_Tooltip:prepareOpen()
  self:open()
end
function PaGlobal_MiniGame_Tooltip:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  self._refCount = self._refCount + 1
  Panel_Widget_MiniGame_Tooltip:SetShow(true)
end
function PaGlobal_MiniGame_Tooltip:prepareClose()
  self:close()
end
function PaGlobal_MiniGame_Tooltip:close()
  self._refCount = self._refCount - 1
  if self._refCount > 0 then
    return
  end
  self:clear()
  Panel_Widget_MiniGame_Tooltip:SetShow(false)
end
function PaGlobal_MiniGame_Tooltip:validate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_MiniGame_Tooltip:registerEvent()
end
function PaGlobal_MiniGame_Tooltip:setYachtDiceHandRankKey(control, keyRaw, isCardShow, isSelf)
  if nil == control then
    return
  end
  local key = YachtHandRankKey(keyRaw)
  local handRankWrapper = ToClient_getHandRankStaticStatusWrapper(key)
  if nil == handRankWrapper then
    return
  end
  local posX = control:GetParentPosX() + control:GetSizeX()
  local posY = control:GetParentPosY()
  Panel_Widget_MiniGame_Tooltip:SetPosX(posX)
  Panel_Widget_MiniGame_Tooltip:SetPosY(posY)
  self._ui._txt_desc:SetText(handRankWrapper:getDesc())
  local totalSizeX = 0
  local totalSizeY = 0
  local textSizeX = self._ui._txt_desc:GetTextSizeX()
  local textSizeY = self._ui._txt_desc:GetTextSizeY()
  if textSizeX < self._diceCardListSizeX then
    totalSizeX = self._diceCardListSizeX + 10
  else
    totalSizeX = textSizeX + 10
  end
  local initPosX = (totalSizeX - textSizeX) / 2
  local initPosY = textSizeY / 2
  self._ui._txt_desc:SetPosX(initPosX)
  self._ui._txt_desc:SetPosY(initPosY)
  totalSizeY = textSizeY + 10
  if true == isCardShow and nil ~= isSelf then
    initPosX = (totalSizeX - self._diceCardListSizeX) / 2
    initPosY = totalSizeY
    local isExistCheckedHandRankCard = true
    for ii = 0, __eYachtDiceCount - 1 do
      local control = self._ui._diceCardList[ii].parent
      local diceCardWrapper = ToClient_getMiniGameYachtCheckedHandRankCardWrapper(key, isSelf, ii)
      if nil ~= diceCardWrapper then
        local symbolKey = diceCardWrapper:getSymbol()
        local number = diceCardWrapper:getEye()
        local txt_number = ""
        if 1 == number then
          txt_number = "A"
        else
          txt_number = tostring(number)
        end
        local filePath = "UI_Artwork/Card/Mini_Card_" .. tostring(PaGlobal_MiniGame_YachtDice._symbolString[symbolKey]) .. "_" .. txt_number .. ".dds"
        control:ChangeTextureInfoName(filePath)
        control:SetPosX(initPosX + (control:GetSizeX() + 5) * ii)
        control:SetPosY(initPosY)
        control:SetShow(true)
      else
        isExistCheckedHandRankCard = false
        break
      end
    end
    if true == isExistCheckedHandRankCard then
      totalSizeY = totalSizeY + self._diceCardListSizeY + 5
    else
      for ii = 0, __eYachtDiceCount - 1 do
        local diceCard = self._ui._diceCardList[ii]
        diceCard:SetShow(false)
      end
    end
  else
    for ii = 0, __eYachtDiceCount - 1 do
      local diceCard = self._ui._diceCardList[ii]
      diceCard:SetShow(false)
    end
  end
  Panel_Widget_MiniGame_Tooltip:SetSize(totalSizeX, totalSizeY)
end
