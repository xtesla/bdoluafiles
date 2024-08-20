function PaGlobalFunc_Widget_HotDeal_All_Close()
  PaGlobal_Widget_HotDeal_All:prepareClose()
end
function PaGlobalFunc_Widget_HotDeal_All_GetShow()
  if nil == Panel_Widget_HotDeal_All then
    return false
  end
  return Panel_Widget_HotDeal_All:GetShow()
end
function HandleEventRUp_Widget_HotDeal_All_updateNavigation()
  ToClient_DeleteNaviGuideByGroup(0)
  local limitedSalesProduct = ToClient_getStartLimitedSalesProduct()
  if nil == limitedSalesProduct then
    return
  end
  local npcCharacterKey = limitedSalesProduct:getNpcCharacterKey()
  if nil == npcCharacterKey then
    return
  end
  local npcClientSpawnInRegionData = ToClient_getNpcInfoByCharacterKey(npcCharacterKey)
  if nil == npcClientSpawnInRegionData then
    return
  end
  local position = npcClientSpawnInRegionData:getPosition()
  if nil == position then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HOTDEAL_NAVIGATION_MSG"))
  worldmapNavigatorStart(position, NavigationGuideParam(), false, false, true)
end
function PaGlobal_Widget_HotDeal_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  if nil == PaGlobal_Widget_HotDeal_All._salesEndTime then
    return
  end
  if PaGlobal_Widget_HotDeal_All._maxEffectTime <= PaGlobal_Widget_HotDeal_All._curEffectTime then
    PaGlobal_Widget_HotDeal_All._isTimeTextRedColor = true
  else
    PaGlobal_Widget_HotDeal_All._curEffectTime = PaGlobal_Widget_HotDeal_All._curEffectTime + deltaTime
  end
  PaGlobal_Widget_HotDeal_All._curUpdateTime = PaGlobal_Widget_HotDeal_All._curUpdateTime + deltaTime
  if PaGlobal_Widget_HotDeal_All._curUpdateTime < PaGlobal_Widget_HotDeal_All._maxUpdateTime then
    return
  end
  PaGlobal_Widget_HotDeal_All._curUpdateTime = 0
  local reminedTime = PaGlobal_Widget_HotDeal_All:updateReminedTime()
  if reminedTime <= 0 then
    PaGlobalFunc_Widget_HotDeal_All_Close()
  end
end
function FromClient_Widget_HotDeal_All_Update()
  if true == PaGlobal_Widget_HotDeal_All:update() then
    if false == PaGlobalFunc_Widget_HotDeal_All_GetShow() then
      PaGlobal_Widget_HotDeal_All:prepareOpen()
    end
  elseif true == PaGlobalFunc_Widget_HotDeal_All_GetShow() then
    PaGlobal_Widget_HotDeal_All:prepareClose()
  end
end
function FromClient_Widget_HotDeal_All_OnResize()
  if nil == Panel_Widget_HotDeal_All then
    return
  end
  PaGlobal_Widget_HotDeal_All:resize()
end
