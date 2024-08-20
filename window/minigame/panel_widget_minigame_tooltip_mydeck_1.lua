function PaGlobal_MiniGame_Tooltip_MyDeck:initialize()
  self._ui._diceCardList = {}
  for ii = 0, __eTYachtEyeCount - 1 do
    do
      local diceCard = {parent = nil}
      function diceCard:SetShow(isShow)
        diceCard.parent:SetShow(isShow)
      end
      local control = UI.getChildControl(Panel_Widget_MiniGame_Tooltip_MyDeck, "Static_MyDeck_Templete" .. tostring(ii))
      control:isValidate()
      control:SetShow(true)
      diceCard.parent = control
      self._ui._diceCardList[ii] = diceCard
    end
  end
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_MiniGame_Tooltip_MyDeck:clear()
end
function PaGlobal_MiniGame_Tooltip_MyDeck:clearRefCount()
  self._refCount = 0
end
function PaGlobal_MiniGame_Tooltip_MyDeck:prepareOpen(index)
  self:open(index)
end
function PaGlobal_MiniGame_Tooltip_MyDeck:open(index)
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  self:clear()
  for ii = 0, __eTYachtEyeCount - 1 do
    local control = self._ui._diceCardList[ii].parent
    local diceCardWrapper = ToClient_getYachtDiceCardWrapper(index, ii, true)
    if nil == diceCardWrapper then
      return
    end
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
  end
  Panel_Widget_MiniGame_Tooltip_MyDeck:SetShow(true)
end
function PaGlobal_MiniGame_Tooltip_MyDeck:prepareClose()
  self:close()
end
function PaGlobal_MiniGame_Tooltip_MyDeck:close()
  Panel_Widget_MiniGame_Tooltip_MyDeck:SetShow(false)
end
function PaGlobal_MiniGame_Tooltip_MyDeck:validate()
end
function PaGlobal_MiniGame_Tooltip_MyDeck:registerEvent()
end
function PaGlobal_MiniGame_Tooltip_MyDeck:SetPos(initPosX, initPosY)
  local diceCard = PaGlobal_MiniGame_YachtDice._ui._diceCardList[0][0][0]
  _PA_ASSERT(nil ~= diceCard, "diceCard is nil")
  local maxPosX = Panel_Window_MiniGame_YachtDice:GetPosX() + Panel_Window_MiniGame_YachtDice:GetSizeX()
  local tooltipSizeX = Panel_Widget_MiniGame_Tooltip_MyDeck:GetSizeX()
  local addSizeX = (tooltipSizeX - diceCard.parent:GetSizeX()) / 2
  local posX = initPosX - addSizeX
  local posY = initPosY - Panel_Widget_MiniGame_Tooltip_MyDeck:GetSizeY()
  if maxPosX < posX + tooltipSizeX then
    posX = maxPosX - tooltipSizeX
  end
  Panel_Widget_MiniGame_Tooltip_MyDeck:SetPosX(posX)
  Panel_Widget_MiniGame_Tooltip_MyDeck:SetPosY(posY - 20)
end
