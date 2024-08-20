function PaGlobalFunc_Widget_GoldenBell_Open(positionX, positionY)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  Panel_Widget_GoldenBell:SetPosX(positionX)
  Panel_Widget_GoldenBell:SetPosY(positionY)
  PaGlobal_Widget_GoldenBell:prepareOpen()
end
function PaGlobalFunc_Widget_GoldenBell_Close()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  PaGlobal_Widget_GoldenBell:prepareClose()
end
function PaGlobalFunc_Widget_GoldenBell_GetShow()
  if nil == Panel_Widget_GoldenBell then
    return false
  end
  return Panel_Widget_GoldenBell:GetShow()
end
function FromClient_ResponseCheerUp(count)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  PaGlobal_Widget_GoldenBell:setCheerUpCount(count)
end
function PaGlobalFunc_Widget_GoldenBell_UpdatePerFrame(deltaTime)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  if nil == player then
    return
  end
  local goldenBellTime_s64 = player:getGoldenbellExpirationTime_s64()
  local goldenBellTime = convertStringFromDatetime(goldenBellTime_s64)
  PaGlobal_Widget_GoldenBell._ui._stc_lefTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GOLDENBELL_LEFTTIME", "time", goldenBellTime))
end
function PaGlobalFunc_Widget_GoldenBell_CheerUpGoldenBell()
  if nil == Panel_Widget_GoldenBell then
    return
  end
  if PaGlobal_Widget_GoldenBell._MAX_CHEERUP_COUNT <= PaGlobal_Widget_GoldenBell._currentCheerUpCount then
    return
  end
  ToClient_RequestCheerUpGoldenBell()
end
function PaGlobal_Widget_GoldenBell_SetCheerUpCount(count)
  if nil == Panel_Widget_GoldenBell then
    return
  end
  if false == ToClient_IsDevelopment() then
    return
  end
  PaGlobal_Widget_GoldenBell:setCheerUpCount(count)
end
