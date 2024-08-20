local UI_color = Defines.Color
local gameOptionActionKey = {
  Forward = 0,
  Back = 1,
  Left = 2,
  Right = 3,
  Attack = 4,
  SubAttack = 5,
  Dash = 6,
  Jump = 7
}
local uiPress = {
  _button_Space = UI.getChildControl(Panel_Fishing, "StaticText_Btn_Space_2"),
  _m1 = UI.getChildControl(Panel_Fishing, "StaticText_M1_2")
}
local fishing_UI = {
  _fish_Icon_Title = UI.getChildControl(Panel_Fishing, "Static_Minigame_Fish_Title"),
  _purposeText = UI.getChildControl(Panel_Fishing, "StaticText_Purpose"),
  _fishBG = UI.getChildControl(Panel_Fishing, "Static_OnlyFishBG"),
  _fishPercent = UI.getChildControl(Panel_Fishing, "StaticText_OnlyFish"),
  _fishComment = UI.getChildControl(Panel_Fishing, "StaticText_OnlyFishComment"),
  _fishWpDesc = UI.getChildControl(Panel_Fishing, "StaticText_OnlyFishWpDesc"),
  _chk_abdPrevention = UI.getChildControl(Panel_Fishing, "CheckBox_AbductionPrevention"),
  _fishCheckText = UI.getChildControl(Panel_Fishing, "StaticText_DropTrashDesc"),
  _fishCheckCombobox = UI.getChildControl(Panel_Fishing, "Combobox_SelectFishGrade"),
  _m0 = UI.getChildControl(Panel_Fishing, "StaticText_M0"),
  _mBody = UI.getChildControl(Panel_Fishing, "StaticText_Mouse_Body")
}
local ui_Value = {
  isFirstTime_Manual_Fishing_Start = true,
  isFirstTime_Manual_Fishing_0 = true,
  isFirstTime_Manual_Fishing_1 = true,
  isFirstTime_Manual_Fishing_2 = true,
  isFirstTime_Manual_Fishing_3 = true,
  isFirstTime_Manual_Jaksal_0 = true,
  isFirstTime_Manual_Jaksal_1 = true,
  isFirstTime_Manual_Jaksal_2 = true,
  isFirstTime_Manual_Jaksal_3 = true,
  isFirstTime_Manual_Jaksal_4 = true,
  isFirstTime_Manual_Jaksal_5 = true
}
local comboBoxList = {
  _none = 0,
  _normal = 1,
  _magic = 2,
  _rare = 3,
  _unique = 4
}
local comboBoxString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_0"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_1"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_2"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_3"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_4")
}
local itemGradeUndefined = getSelfPlayer():ToClient_GetItemGradeTypeUndefined()
function HandleClicked_FishCheck()
  local itemGrade = fishing_UI._fishCheckCombobox:GetSelectIndex()
  getSelfPlayer():setFishingAutoItemGrade(itemGrade)
end
function HandleClicked_FishDropTrash(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_CHECKBUTTON")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_MANUAL_CHECKBUTTON")
  control = fishing_UI._fishCheckCombobox
  TooltipSimple_Show(control, name, desc)
end
function HandleClicked_FishCheckComboBox()
  fishing_UI._fishCheckCombobox:ToggleListbox()
end
function HandleClicked_FishCheckComboBoxText()
  local discardFishingItemGrade = getSelfPlayer():ToClient_GetDiscardFishingItemGrade()
  if comboBoxList._none == fishing_UI._fishCheckCombobox:GetSelectIndex() then
    selectFishCheckComboBoxText()
  elseif itemGradeUndefined ~= discardFishingItemGrade then
    if fishing_UI._fishCheckCombobox:GetSelectIndex() <= discardFishingItemGrade + 1 then
      selectFishCheckComboBoxText()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOW_FISHING_LEVEL"))
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOW_FISHING_LEVEL"))
  end
  fishing_UI._fishCheckCombobox:ToggleListbox()
end
function HandleClicked_FishCheck_AbductionPrevention()
  local selfplayer = getSelfPlayer()
  if nil == selfplayer or nil == selfplayer:get() then
    return
  end
  selfplayer:get():sendAbductionPreventionForFishing(fishing_UI._chk_abdPrevention:IsCheck())
end
function selectFishCheckComboBoxText()
  fishing_UI._fishCheckCombobox:SetSelectItemIndex(fishing_UI._fishCheckCombobox:GetSelectIndex())
  HandleClicked_FishCheck()
end
function FGlobal_FishCheck()
  return comboBoxList._none ~= fishing_UI._fishCheckCombobox:GetSelectIndex()
end
function FGlobal_SetFishCheck(check)
  HandleClicked_FishCheck()
end
local isCheckRideShip = function()
  if true == selfplayerIsCurrentlyOnShip() then
    return true
  end
  local selfProxy = getSelfPlayer():get()
  local vehicleProxy = getVehicleActor(selfProxy:getRideVehicleActorKeyRaw())
  if nil == vehicleProxy then
    return false
  end
  local servantType = vehicleProxy:get():getServantType()
  if nil ~= servantType and servantType == CppEnums.ServantType.Type_Ship then
    return true
  end
  return false
end
local function SetShowPanel_Fishing(isShow)
  if true == isShow then
    Panel_Fishing:SetShow(true)
    Panel_Fishing:SetAlpha(0)
    UIAni.AlphaAnimation(1, Panel_Fishing, 0, 0.22)
    fishing_UI._chk_abdPrevention:SetShow(true)
    HandleClicked_FishCheck_AbductionPrevention()
  else
    Panel_Fishing:SetShow(false)
  end
end
fishing_UI._fishCheckCombobox:GetListControl():addInputEvent("Mouse_LUp", "HandleClicked_FishCheckComboBoxText()")
fishing_UI._fishCheckCombobox:addInputEvent("Mouse_LUp", "HandleClicked_FishCheckComboBox()")
fishing_UI._fishCheckCombobox:addInputEvent("Mouse_On", "HandleClicked_FishDropTrash(true)")
fishing_UI._fishCheckCombobox:addInputEvent("Mouse_Out", "HandleClicked_FishDropTrash(false)")
fishing_UI._chk_abdPrevention:addInputEvent("Mouse_LUp", "HandleClicked_FishCheck_AbductionPrevention()")
local IsHideMiniGameManual = function()
  local uiMode = GetUIMode()
  return getCustomizingManager():isShow() or uiMode == Defines.UIMode.eUIMode_NpcDialog or uiMode == Defines.UIMode.eUIMode_InGameCashShop or uiMode == Defines.UIMode.eUIMode_Mental or uiMode == Defines.UIMode.eUIMode_DyeNew
end
function fishingGame_Initialize()
  SetShowPanel_Fishing(false)
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  Panel_Fishing:SetSize(scrX, scrY)
  Panel_Fishing:SetPosX(0)
  Panel_Fishing:SetPosY(50)
  for _, value in pairs(fishing_UI) do
    value:SetShow(false)
    value:ComputePos()
  end
  for _, value in pairs(uiPress) do
    value:SetShow(false)
    value:ComputePos()
  end
  local targetItemGrade = getSelfPlayer():getFishingAutoItemGrade()
  fishing_UI._fishCheckCombobox:SetSelectItemIndex(targetItemGrade)
end
function setFishingResourcePool_text()
  local fishComment_head = PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_HEAD")
  local fishingPercent = math.floor(ToClient_CurrentFishingData() * 100)
  if fishingPercent >= 71 and fishingPercent <= 100 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_1")
  elseif fishingPercent >= 46 and fishingPercent <= 70 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_2")
  elseif fishingPercent >= 15 and fishingPercent <= 45 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_3")
  elseif fishingPercent <= 14 and fishingPercent >= 0 then
    fishComment = fishComment_head .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_FISH_POOL_VALUE_4")
  end
  fishing_UI._fishPercent:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_FISHERY_RESOURCE", "FISHERY", fishComment))
  fishing_UI._fishComment:SetAutoResize(true)
  fishing_UI._fishComment:SetTextMode(__eTextMode_AutoWrap)
  fishing_UI._fishComment:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_FISHERY_COMMENT"))
  local itemWrapper = ToClient_getEquipmentItem(0)
  fishing_UI._fishCheckCombobox:DeleteAllItem(0)
  fishing_UI._fishCheckCombobox:setListTextHorizonCenter()
  for index = 0, #comboBoxString do
    fishing_UI._fishCheckCombobox:AddItem(comboBoxString[index])
  end
  fishing_UI._fishCheckCombobox:GetListControl():SetSize(fishing_UI._fishCheckCombobox:GetSizeX() + 30, #comboBoxString * 22)
  if nil == itemWrapper then
    fishing_UI._fishWpDesc:SetShow(false)
    fishing_UI._fishCheckCombobox:SetShow(false)
    fishing_UI._fishCheckText:SetShow(false)
    return
  end
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  if 44 == equipType then
    fishing_UI._fishWpDesc:SetShow(true)
    fishing_UI._fishCheckCombobox:SetShow(true)
    fishing_UI._fishCheckText:SetShow(true)
    HandleClicked_FishCheck()
  elseif 48 == equipType then
    fishing_UI._fishWpDesc:SetShow(false)
    fishing_UI._fishCheckCombobox:SetShow(false)
    fishing_UI._fishCheckText:SetShow(false)
  end
  local sizeX1 = fishing_UI._fishPercent:GetTextSizeX()
  local sizeX2 = fishing_UI._fishComment:GetTextSizeX()
  local maxSizeX = 0
  if sizeX1 > sizeX2 then
    maxSizeX = sizeX1
  else
    maxSizeX = sizeX2
  end
  local maxSizeY = fishing_UI._fishComment:GetSizeY() + fishing_UI._fishPercent:GetSizeY()
  fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
  fishing_UI._fishBG:SetPosX(getScreenSizeX() / 2 - fishing_UI._fishBG:GetSizeX() / 2)
  fishing_UI._fishCheckText:SetSpanSize(-(fishing_UI._fishCheckText:GetSizeX() + fishing_UI._fishCheckText:GetTextSizeX()) * 0.5, 0)
  fishing_UI._fishCheckText:SetPosY(fishing_UI._fishBG:GetPosY() + fishing_UI._fishBG:GetSizeY() + 10)
  fishing_UI._fishCheckCombobox:SetPosY(fishing_UI._fishCheckText:GetPosY())
  fishing_UI._fishCheckCombobox:SetPosX(fishing_UI._fishCheckText:GetPosX() + fishing_UI._fishCheckText:GetTextSizeX() + 10)
  local posX = getScreenSizeX() / 2 - (fishing_UI._chk_abdPrevention:GetSizeX() + fishing_UI._chk_abdPrevention:GetTextSizeX()) * 0.5
  fishing_UI._chk_abdPrevention:SetPosX(posX)
  fishing_UI._chk_abdPrevention:SetPosY(fishing_UI._fishCheckText:GetPosY() + fishing_UI._fishCheckText:GetSizeY() + 5)
  uiPress._button_Space:SetPosY(fishing_UI._chk_abdPrevention:GetPosY() + fishing_UI._fishCheckText:GetSizeY() + 10)
  fishing_UI._fishWpDesc:SetPosY(uiPress._button_Space:GetPosY() + uiPress._button_Space:GetSizeY() + 10)
end
function FromClient_ReconnectCheckItemGrade(itemgrade)
  getSelfPlayer():setFishingAutoItemGrade(itemGrade)
end
registerEvent("FromClient_ReconnectCheckItemGrade", "FromClient_ReconnectCheckItemGrade")
fishingGame_Initialize()
local IsHideFishingGame = function()
  local uiMode = GetUIMode()
  return getCustomizingManager():isShow() or uiMode == Defines.UIMode.eUIMode_NpcDialog or uiMode == Defines.UIMode.eUIMode_InGameCashShop or uiMode == Defines.UIMode.eUIMode_Mental or uiMode == Defines.UIMode.eUIMode_DyeNew
end
local function FishingGame_Manual_Fishing_Start(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Fishing_Start == true and not IsHideFishingGame() then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._chk_abdPrevention:SetCheck(ToClient_IsAbductionPreventionForFishing())
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = ""
    if getGamePadEnable() then
      actionString = keyCustom_GetString_ActionPad(gameOptionActionKey.Jump)
    else
      actionString = keyCustom_GetString_ActionKey(gameOptionActionKey.Jump)
    end
    fishing_UI._purposeText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_START", "key", actionString))
    uiPress._button_Space:SetShow(true)
    uiPress._button_Space:SetText(actionString)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._fish_Icon_Title:SetShow(true)
    ui_Value.isFirstTime_Manual_Fishing_Start = false
    MiniGame_Manual_Value_FishingStart = true
  end
end
local function FishingGame_Manual_Fishing_0(actorKeyRaw, isSelf)
  FGlobal_PowerGauge_Close()
  if ui_Value.isFirstTime_Manual_Fishing_0 == true then
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_0"))
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._fish_Icon_Title:SetShow(true)
    fishing_UI._fishWpDesc:SetShow(false)
    ui_Value.isFirstTime_Manual_Fishing_0 = false
  end
end
local function FishingGame_Manual_Fishing_1(actorKeyRaw, isSelf)
  local selfplayer = getSelfPlayer()
  if nil == selfplayer then
    return
  end
  local autoFishingEnalbe = selfplayer:get():isAutoFishingable()
  if ui_Value.isFirstTime_Manual_Fishing_1 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    close_WindowPanelList()
    if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
      Panel_Menu:SetShow(false, false)
    elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
      Panel_Menu_New:SetShow(false, false)
    elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
      Panel_Widget_Menu_Remake:SetShow(false, false)
    end
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = ""
    if getGamePadEnable() then
      actionString = keyCustom_GetString_ActionPad(gameOptionActionKey.Jump)
    else
      actionString = keyCustom_GetString_ActionKey(gameOptionActionKey.Jump)
    end
    fishing_UI._purposeText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_1", "key", actionString))
    if autoFishingEnalbe then
      fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC"))
    else
      fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC_2"))
    end
    fishing_UI._fishWpDesc:SetSize(fishing_UI._fishWpDesc:GetTextSizeX() + 10, fishing_UI._fishWpDesc:GetTextSizeY() + 10)
    fishing_UI._fish_Icon_Title:SetShow(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    uiPress._button_Space:SetShow(true)
    uiPress._button_Space:SetText(actionString)
    uiPress._button_Space:SetAlpha(0)
    uiPress._button_Space:SetFontAlpha(0)
    uiPress._button_Space:SetPosY(fishing_UI._chk_abdPrevention:GetPosY() + fishing_UI._fishCheckText:GetSizeY() + 10)
    fishing_UI._fishWpDesc:SetShow(false)
    UIAni.AlphaAnimation(1, uiPress._button_Space, 0.75, 1)
    ui_Value.isFirstTime_Manual_Fishing_1 = false
  end
end
local function FishingGame_Manual_Fishing_2(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Fishing_2 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_2"))
    fishing_UI._fishWpDesc:SetShow(false)
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(false)
    uiPress._button_W:SetShow(true)
    uiPress._button_A:SetShow(true)
    uiPress._button_S:SetShow(true)
    uiPress._button_D:SetShow(true)
    uiPress._button_W:SetText(gameOptionActionKey.Forward)
    uiPress._button_A:SetText(gameOptionActionKey.Left)
    uiPress._button_S:SetText(gameOptionActionKey.Back)
    uiPress._button_D:SetText(gameOptionActionKey.Right)
    uiPress._button_W:SetAlpha(0)
    uiPress._button_A:SetAlpha(0)
    uiPress._button_S:SetAlpha(0)
    uiPress._button_D:SetAlpha(0)
    uiPress._button_W:SetFontAlpha(0)
    uiPress._button_A:SetFontAlpha(0)
    uiPress._button_S:SetFontAlpha(0)
    uiPress._button_D:SetFontAlpha(0)
    UIAni.AlphaAnimation(1, uiPress._button_W, 0.5, 0.75)
    UIAni.AlphaAnimation(1, uiPress._button_A, 0.5, 0.75)
    UIAni.AlphaAnimation(1, uiPress._button_S, 0.5, 0.75)
    UIAni.AlphaAnimation(1, uiPress._button_D, 0.5, 0.75)
    ui_Value.isFirstTime_Manual_Fishing_2 = false
  end
end
local function FishingGame_Manual_Fishing_3(actorKeyRaw, isSelf)
  local selfplayer = getSelfPlayer()
  if nil == selfplayer then
    return
  end
  local autoFishingEnalbe = selfplayer:get():isAutoFishingable()
  if ui_Value.isFirstTime_Manual_Fishing_3 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    audioPostEvent_SystemUi(11, 6)
    local leftTimeForAuto = math.floor(Int64toInt32(getSelfPlayer():get():getFishingAutoLeftTime()) / 1000)
    local leftMinute
    if 0 < math.floor(leftTimeForAuto / 60) then
      leftMinute = " (" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTY_MATCH_TIME") .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", math.floor(leftTimeForAuto / 60)) .. ")"
    else
      leftMinute = " (" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTY_MATCH_TIME") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYAUTHORITY_AUCTION_UNDER_ONEMINUTE") .. ")"
    end
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    local actionString = ""
    if getGamePadEnable() then
      actionString = keyCustom_GetString_ActionPad(gameOptionActionKey.Jump)
    else
      actionString = keyCustom_GetString_ActionKey(gameOptionActionKey.Jump)
    end
    fishing_UI._purposeText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_3", "key", actionString))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    uiPress._button_Space:SetText(actionString)
    uiPress._button_Space:SetAlpha(0)
    uiPress._button_Space:SetFontAlpha(0)
    uiPress._button_Space:SetPosY(fishing_UI._chk_abdPrevention:GetPosY() + fishing_UI._fishCheckText:GetSizeY() + 10)
    if autoFishingEnalbe then
      fishing_UI._fishWpDesc:SetShow(true)
      fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC") .. leftMinute)
    else
      fishing_UI._fishWpDesc:SetShow(false)
      fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC_2"))
    end
    fishing_UI._fishWpDesc:SetSize(fishing_UI._fishWpDesc:GetTextSizeX() + 10, fishing_UI._fishWpDesc:GetTextSizeY() + 10)
    UIAni.AlphaAnimation(1, uiPress._button_Space, 0.5, 0.75)
    ui_Value.isFirstTime_Manual_Fishing_2 = false
  end
end
local function FishingGame_Manual_Fishing_Auto()
  local selfplayer = getSelfPlayer()
  if nil == selfplayer then
    return
  end
  local autoFishingEnalbe = selfplayer:get():isAutoFishingable()
  for _, v in pairs(uiPress) do
    v:SetShow(false)
    v:ComputePos()
  end
  if autoFishingEnalbe then
    fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC"))
  else
    fishing_UI._fishWpDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GLOBAL_MANUAL_ONLYFISHWPDESC_2"))
  end
  fishing_UI._fishWpDesc:SetSize(fishing_UI._fishWpDesc:GetTextSizeX() + 10, fishing_UI._fishWpDesc:GetTextSizeY() + 10)
end
local FishingGame_Manual_CommonGaugeOpen = function()
  FGlobal_PowerGuage_StatCheck()
end
local FishingGame_Manual_Fishing_Wait = function(aaa)
  if not Panel_PowerGauge:GetShow() then
    FGlobal_PowerGauge_Open()
  end
end
function FGlobal_MiniGame_FishingCheck()
  fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_FISHING_2"))
  uiPress._button_Space:SetShow(false)
end
function MiniGame_FishingDescInit()
  fishing_UI._fishWpDesc:SetTextMode(__eTextMode_AutoWrap)
  fishing_UI._fishWpDesc:SetSize(fishing_UI._fishWpDesc:GetTextSizeX() + 10, fishing_UI._fishWpDesc:GetTextSizeY() + 10)
end
MiniGame_FishingDescInit()
local function MiniGame_Manual_Jaksal_0(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_0 == true and not IsHideMiniGameManual() then
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Use"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = false
  end
  MiniGame_Manual_Value_FishingStart = true
end
local function MiniGame_Manual_Jaksal_1(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_1 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Finding"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(false)
    fishing_UI._m0:SetShow(true)
    uiPress._m1:SetShow(true)
    fishing_UI._mBody:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = true
    ui_Value.isFirstTime_Manual_Jaksal_1 = false
  end
end
local function MiniGame_Manual_Jaksal_2(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_2 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Find"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = true
    ui_Value.isFirstTime_Manual_Jaksal_1 = false
    ui_Value.isFirstTime_Manual_Jaksal_2 = false
  end
end
local function MiniGame_Manual_Jaksal_3(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_3 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    close_WindowPanelList()
    if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
      Panel_Menu:SetShow(false, false)
    elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
      Panel_Menu_New:SetShow(false, false)
    elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
      Panel_Widget_Menu_Remake:SetShow(false, false)
    end
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Sight"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = true
    ui_Value.isFirstTime_Manual_Jaksal_1 = false
    ui_Value.isFirstTime_Manual_Jaksal_2 = false
    ui_Value.isFirstTime_Manual_Jaksal_3 = false
  end
end
local function MiniGame_Manual_Jaksal_4(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_4 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Success"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = true
    ui_Value.isFirstTime_Manual_Jaksal_1 = false
    ui_Value.isFirstTime_Manual_Jaksal_2 = false
    ui_Value.isFirstTime_Manual_Jaksal_3 = false
    ui_Value.isFirstTime_Manual_Jaksal_4 = false
  end
end
local function MiniGame_Manual_Jaksal_5(actorKeyRaw, isSelf)
  if ui_Value.isFirstTime_Manual_Jaksal_5 == true then
    for _, v in pairs(uiPress) do
      v:SetShow(false)
      v:ComputePos()
    end
    for _, v in pairs(fishing_UI) do
      v:SetShow(false)
      v:ComputePos()
    end
    SetShowPanel_Fishing(true)
    fishing_UI._fishBG:SetShow(true)
    fishing_UI._fishPercent:SetShow(true)
    fishing_UI._fishComment:SetShow(true)
    setFishingResourcePool_text()
    fishing_UI._fishBG:SetSize(fishing_UI._fishComment:GetTextSizeX() + 10, fishing_UI._fishPercent:GetSizeY() + fishing_UI._fishComment:GetSizeY() + 10)
    fishing_UI._purposeText:SetShow(true)
    fishing_UI._purposeText:AddEffect("UI_QustComplete01", false, 0, 0)
    fishing_UI._purposeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALMANUAL_Fishing_Fail"))
    fishing_UI._fish_Icon_Title:SetShow(true)
    uiPress._button_Space:SetShow(true)
    ui_Value.isFirstTime_Manual_Jaksal_0 = true
    ui_Value.isFirstTime_Manual_Jaksal_1 = false
    ui_Value.isFirstTime_Manual_Jaksal_2 = false
    ui_Value.isFirstTime_Manual_Jaksal_3 = false
    ui_Value.isFirstTime_Manual_Jaksal_4 = false
    ui_Value.isFirstTime_Manual_Jaksal_5 = false
  end
end
function Panel_Fishing_End(actorKeyRaw, isSelf)
  if false == isSelf then
    return
  end
  uiPress._button_Space:ComputePos()
  SetShowPanel_Fishing(false)
  ui_Value.isFirstTime_Manual_Fishing_Start = true
  ui_Value.isFirstTime_Manual_Fishing_0 = true
  ui_Value.isFirstTime_Manual_Fishing_1 = true
  ui_Value.isFirstTime_Manual_Fishing_2 = true
  ui_Value.isFirstTime_Manual_Fishing_3 = true
  ui_Value.isFirstTime_Manual_Jaksal_0 = true
  ui_Value.isFirstTime_Manual_Jaksal_1 = true
  ui_Value.isFirstTime_Manual_Jaksal_2 = true
  ui_Value.isFirstTime_Manual_Jaksal_3 = true
  ui_Value.isFirstTime_Manual_Jaksal_4 = true
  ui_Value.isFirstTime_Manual_Jaksal_5 = true
  MiniGame_Manual_Value_FishingStart = false
  if Panel_PowerGauge:GetShow() then
    FGlobal_PowerGauge_Close()
  end
  if Panel_CannonGauge:GetShow() then
    FGlobal_CannonGauge_Close()
  end
end
local MiniGame_Manual_CannonGaugeOpen = function()
  if not Panel_Stamina:GetShow() then
    FGlobal_CannonGauge_Open()
  end
end
ActionChartEventBindFunction(211, FishingGame_Manual_Fishing_0)
ActionChartEventBindFunction(212, FishingGame_Manual_Fishing_1)
ActionChartEventBindFunction(213, FishingGame_Manual_Fishing_2)
ActionChartEventBindFunction(214, FishingGame_Manual_Fishing_Start)
ActionChartEventBindFunction(215, FishingGame_Manual_Fishing_3)
ActionChartEventBindFunction(216, FishingGame_Manual_CommonGaugeOpen)
ActionChartEventBindFunction(217, MiniGame_Manual_CannonGaugeOpen)
ActionChartEventBindFunction(218, FishingGame_Manual_Fishing_Auto)
ActionChartEventBindFunction(219, FishingGame_Manual_Fishing_Wait)
ActionChartEventBindFunction(281, MiniGame_Manual_Jaksal_0)
ActionChartEventBindFunction(282, MiniGame_Manual_Jaksal_1)
ActionChartEventBindFunction(283, MiniGame_Manual_Jaksal_2)
ActionChartEventBindFunction(284, MiniGame_Manual_Jaksal_3)
ActionChartEventBindFunction(285, MiniGame_Manual_Jaksal_4)
ActionChartEventBindFunction(286, MiniGame_Manual_Jaksal_5)
