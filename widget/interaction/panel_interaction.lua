local UI_Color = Defines.Color
local UI_PP = CppEnums.PAUIMB_PRIORITY
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local _needCollectTool = UI.getChildControl(Panel_Interaction, "Static_Cant")
local _background = UI.getChildControl(Panel_Interaction, "Static_Background")
_background:setGlassBackground(true)
local _houseDescBG = UI.getChildControl(Panel_Interaction_House, "Static_BuyHouse_DescBG")
local _houseDesc = UI.getChildControl(Panel_Interaction_House, "StaticText_BuyHouse_Desc")
local _contribute_Help = UI.getChildControl(Panel_Interaction_House, "StaticText_ContHelp")
local _globalGuide = UI.getChildControl(Panel_Interaction, "StaticText_Purpose")
local _circularProgressBarInteraction = UI.getChildControl(Panel_Interaction, "CircularProgress_Press")
local _circularProgressBarStaticbgInteraction = UI.getChildControl(Panel_Interaction, "Static_CircleProgress_PressBG")
Panel_Interaction:RegisterShowEventFunc(true, "Panel_Interaction_ShowAni()")
Panel_Interaction:RegisterShowEventFunc(false, "Panel_Interaction_HideAni()")
local pcExchangeDisableTime = 60
local pcExchangeDisableTimeByNpc = 0
function Panel_Interaction_ShowAni()
end
function Panel_Interaction_HideAni()
end
local eInteractionTypeMax = CppEnums.InteractionType.InteractionType_Count
local preUIMode
local DESC_TEXT = {}
for ii = 0, eInteractionTypeMax - 1 do
  DESC_TEXT[ii] = PAGetString(Defines.StringSheet_GAME, "INTERACTION_TEXT" .. tostring(ii))
end
INETRACTION_BUTTON_TEXT = {}
for ii = 0, eInteractionTypeMax - 1 do
  INETRACTION_BUTTON_TEXT[ii] = PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU" .. tostring(ii))
end
local BUTTON_ID = {
  [0] = "Button_GamePlay",
  "Button_CharInfo",
  "Button_Exchange",
  "Button_Party_Invite",
  "Button_Dialog",
  "Button_Ride",
  "Button_Control",
  "Button_Looting",
  "Button_Collect",
  "Button_OpenDoor",
  "Button_OpenWarehouseInTent",
  "Button_ReBuildTent",
  "Button_InstallationMode",
  "Button_ViewHouseInfo",
  "Button_Havest",
  "Button_ParkingHorse",
  "Button_EquipInstallation",
  "Button_UnequipInstallation",
  "Button_OpenInventory",
  "Button_HorseInfo",
  "Button_Bussiness",
  "Button_Guild_Invite",
  "Button_Guild_Alliance_Invite",
  "Button_UseItem",
  "Button_UnbuildPersonalTent",
  "Button_Manufacture",
  "Button_Greet",
  "Button_Steal",
  "Button_Lottery",
  "Button_HarvestSeed",
  "Button_TopHouse",
  "Button_HouseRank",
  "Button_Lop",
  "Button_KillBug",
  "Button_UninstallTrap",
  "Button_Sympathetic",
  "Button_Observe",
  "Button_HarvestInformation",
  "Button_Clan_Invite",
  "Button_SiegeGateOpen",
  "Button_UnbuildKingOrLordTent",
  "Button_Eavesdrop",
  "Button_WaitComment",
  "Button_TakedownCannon",
  "Button_OpenWindow",
  "Button_ChangeLook",
  "Button_ChangeName",
  "Button_RepairKingOrLordTent",
  "Button_UserIntroduction",
  "Button_FollowActor",
  "Button_BuildingUpgrade",
  "Button_PvPBattle",
  "Button_SiegeObjectStart",
  "Button_SiegeObjectFinish",
  "Button_GateOpen",
  "Button_GateClose",
  "Button_UninstallBarricade",
  "Button_ServantRepair",
  "Button_LanternOn",
  "Button_LanternOff",
  "Button_Escape",
  "Button_Awake",
  "Button_Diving",
  "Button_GuildTeamBattle",
  "Button_Bungalow",
  "Button_SkillAwakenPlayer",
  "Button_GuildDrill",
  "Button_BigHouse",
  "Button_ShowCampingTentUI",
  "Button_UseCampingTent",
  "Button_Refair_Tool"
}
local UI_BUTTON = {}
for ii = 0, #BUTTON_ID do
  UI_BUTTON[ii] = UI.getChildControl(Panel_Interaction, BUTTON_ID[ii])
  UI_BUTTON[ii]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. ii .. ")")
  UI_BUTTON[ii]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. ii .. ", true)")
  UI_BUTTON[ii]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. ii .. ", false)")
  UI_BUTTON[ii]:SetText(INETRACTION_BUTTON_TEXT[ii])
  UI_BUTTON[ii]:SetFontAlpha(1)
  UI_BUTTON[ii]:SetShow(false)
end
local function getDefaultButtonInfo(actor, index)
  return UI_BUTTON[index], INETRACTION_BUTTON_TEXT[index]
end
local interactionTargetUIList = {}
local interactionTargetTextList = {}
local otherUIList = {
  [CppEnums.InteractionType.InteractionType_HavestLop] = UI.getChildControl(Panel_Interaction, "Button_KillBugs"),
  [CppEnums.InteractionType.InteractionType_HavestKillBug] = UI.getChildControl(Panel_Interaction, "Button_Feeding"),
  [CppEnums.InteractionType.InteractionType_HarvestInformation] = UI.getChildControl(Panel_Interaction, "Button_DomesticAnimalInfo"),
  [CppEnums.InteractionType.InteractionType_SkillAwakenPlayer] = UI.getChildControl(Panel_Interaction, "Button_SkillAwakenPlayer"),
  [CppEnums.InteractionType.InteractionType_GuildDrill] = UI.getChildControl(Panel_Interaction, "Button_GuildDrill"),
  [CppEnums.InteractionType.InteractionType_ReturnRentedMansion] = UI.getChildControl(Panel_Interaction, "Button_BigHouse"),
  [CppEnums.InteractionType.InteractionType_ShowCampingTentUI] = UI.getChildControl(Panel_Interaction, "Button_ShowCampingTentUI"),
  [CppEnums.InteractionType.InteractionType_UseCampingTent] = UI.getChildControl(Panel_Interaction, "Button_UseCampingTent"),
  [CppEnums.InteractionType.InteractionType_RepairTool] = UI.getChildControl(Panel_Interaction, "Button_Refair_Tool")
}
otherUIList[32]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. 32 .. ")")
otherUIList[32]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. 32 .. ", true)")
otherUIList[32]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. 32 .. ", false)")
otherUIList[32]:SetShow(false)
otherUIList[33]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. 33 .. ")")
otherUIList[33]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. 33 .. ", true)")
otherUIList[33]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. 33 .. ", false)")
otherUIList[33]:SetShow(false)
otherUIList[37]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. 37 .. ")")
otherUIList[37]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. 37 .. ", true)")
otherUIList[37]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. 37 .. ", false)")
otherUIList[37]:SetShow(false)
otherUIList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. CppEnums.InteractionType.InteractionType_SkillAwakenPlayer .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_SkillAwakenPlayer .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_SkillAwakenPlayer .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer]:SetShow(true)
otherUIList[CppEnums.InteractionType.InteractionType_GuildDrill]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. 66 .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_GuildDrill]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. 66 .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_GuildDrill]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. 66 .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_GuildDrill]:SetShow(false)
otherUIList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. CppEnums.InteractionType.InteractionType_ReturnRentedMansion .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_ReturnRentedMansion .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_ReturnRentedMansion .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion]:SetShow(true)
otherUIList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. CppEnums.InteractionType.InteractionType_ShowCampingTentUI .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_ShowCampingTentUI .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_ShowCampingTentUI .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI]:SetShow(true)
otherUIList[CppEnums.InteractionType.InteractionType_UseCampingTent]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. CppEnums.InteractionType.InteractionType_UseCampingTent .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_UseCampingTent]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_UseCampingTent .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_UseCampingTent]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_UseCampingTent .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_UseCampingTent]:SetShow(true)
otherUIList[CppEnums.InteractionType.InteractionType_RepairTool]:addInputEvent("Mouse_LUp", "Interaction_ButtonPushed(" .. CppEnums.InteractionType.InteractionType_RepairTool .. ")")
otherUIList[CppEnums.InteractionType.InteractionType_RepairTool]:addInputEvent("Mouse_On", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_RepairTool .. ", true)")
otherUIList[CppEnums.InteractionType.InteractionType_RepairTool]:addInputEvent("Mouse_Out", "Interaction_ButtonOver(" .. CppEnums.InteractionType.InteractionType_RepairTool .. ", false)")
otherUIList[CppEnums.InteractionType.InteractionType_RepairTool]:SetShow(true)
local otherTextList = {
  [CppEnums.InteractionType.InteractionType_HavestLop] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_4"),
  [CppEnums.InteractionType.InteractionType_HavestKillBug] = PAGetString(Defines.StringSheet_GAME, "LUA_INSTALLATIONMODE_FARMGUIDE_DESC1_5"),
  [CppEnums.InteractionType.InteractionType_HarvestInformation] = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTIONBUTTON_NAME_DOMESTICANIMALINFO"),
  [CppEnums.InteractionType.InteractionType_SkillAwakenPlayer] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_TITLE"),
  [CppEnums.InteractionType.InteractionType_GuildDrill] = PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU66"),
  [CppEnums.InteractionType.InteractionType_ReturnRentedMansion] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_INTERACTION_BIGHOUSE"),
  [CppEnums.InteractionType.InteractionType_ShowCampingTentUI] = PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_CONTROL"),
  [CppEnums.InteractionType.InteractionType_UseCampingTent] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INTERACTION_LYINGDOWN"),
  [CppEnums.InteractionType.InteractionType_RepairTool] = PAGetString(Defines.StringSheet_GAME, "LUA_AUTOREPAIR_TOOL_READY_CONDITION")
}
local otherFunctionList = {
  [32] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    local installationActorWrapper = getInstallationActorByProxy(actor:get())
    if nil == installationActorWrapper then
      return getDefaultButtonInfo(actor, index)
    end
    local installationType = installationActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
    if CppEnums.InstallationType.eType_LivestockHarvest ~= installationType then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_HavestLop], otherTextList[CppEnums.InteractionType.InteractionType_HavestLop]
  end,
  [33] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    local installationActorWrapper = getInstallationActorByProxy(actor:get())
    if nil == installationActorWrapper then
      return getDefaultButtonInfo(actor, index)
    end
    local installationType = installationActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
    if CppEnums.InstallationType.eType_LivestockHarvest ~= installationType then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_HavestKillBug], otherTextList[CppEnums.InteractionType.InteractionType_HavestKillBug]
  end,
  [37] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    local installationActorWrapper = getInstallationActorByProxy(actor:get())
    if nil == installationActorWrapper then
      return getDefaultButtonInfo(actor, index)
    end
    local installationType = installationActorWrapper:getStaticStatusWrapper():getObjectStaticStatus():getInstallationType()
    if CppEnums.InstallationType.eType_LivestockHarvest ~= installationType then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_HarvestInformation], otherTextList[CppEnums.InteractionType.InteractionType_HarvestInformation]
  end,
  [CppEnums.InteractionType.InteractionType_SkillAwakenPlayer] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer], otherTextList[CppEnums.InteractionType.InteractionType_SkillAwakenPlayer]
  end,
  [CppEnums.InteractionType.InteractionType_GuildDrill] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_GuildDrill], otherTextList[CppEnums.InteractionType.InteractionType_GuildDrill]
  end,
  [CppEnums.InteractionType.InteractionType_ReturnRentedMansion] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion], otherTextList[CppEnums.InteractionType.InteractionType_ReturnRentedMansion]
  end,
  [CppEnums.InteractionType.InteractionType_ShowCampingTentUI] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI], otherTextList[CppEnums.InteractionType.InteractionType_ShowCampingTentUI]
  end,
  [CppEnums.InteractionType.InteractionType_UseCampingTent] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_UseCampingTent], otherTextList[CppEnums.InteractionType.InteractionType_UseCampingTent]
  end,
  [CppEnums.InteractionType.InteractionType_RepairTool] = function(actor, index)
    if nil == actor then
      return getDefaultButtonInfo(actor, index)
    end
    if nil == otherUIList[index] or nil == otherTextList[index] then
      return getDefaultButtonInfo(actor, index)
    end
    return otherUIList[CppEnums.InteractionType.InteractionType_RepairTool], otherTextList[CppEnums.InteractionType.InteractionType_RepairTool]
  end
}
local function getButtonInfo(actor, index)
  if nil ~= otherFunctionList[index] then
    return otherFunctionList[index](actor, index)
  end
  return getDefaultButtonInfo(actor, index)
end
local function updateButtonList(actor)
  for key, value in pairs(interactionTargetUIList) do
    value:SetShow(false)
  end
  interactionTargetUIList = {}
  interactionTargetTextList = {}
  for ii = 0, #UI_BUTTON do
    interactionTargetUIList[ii], interactionTargetTextList[ii] = getButtonInfo(actor, ii)
  end
end
UI.getChildControl(Panel_Interaction, "Button_Hunting"):SetShow(false)
UI.getChildControl(Panel_Interaction, "Button_VehicleTraining"):SetShow(false)
local UI_NAME = UI.getChildControl(Panel_Interaction, "Static_Text_CharacterName")
local UI_DESC = UI.getChildControl(Panel_Interaction, "Static_Icon_Font")
local INTERACTABLE_ACTOR_KEY = 0
local SHOW_BUTTON_COUNT = 0
local ANIMATING_BUTTON = false
local BUTTON_UPDATE_TIME = 0
local basicInteractionType = 0
local focusInteractionType = 0
local isFocusInteractionType = false
local isTargetNpc = false
local interactionShowableCheck = function(actor)
  if nil == actor or nil == getSelfPlayer() then
    return false
  else
    return interaction_showableCheck(actor:get())
  end
end
local interactionTutorial = true
function Interaction_Update(deltaTime)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil or selfPlayer:isDead() or PaGloabl_Looting_All_GetShowPanel() or true == Panel_Window_Exchange:GetShow() or Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    Interaction_Close()
    return
  end
  local actor = interaction_getInteractable()
  local actorKey = 0
  local isChangeInteractableFrag = false
  if actor ~= nil then
    actorKey = actor:getActorKey()
    isChangeInteractableFrag = actor:isChangeInteractableFrag()
  else
    Interaction_Close()
    return
  end
  if actorKey ~= INTERACTABLE_ACTOR_KEY or true == isChangeInteractableFrag then
    INTERACTABLE_ACTOR_KEY = actorKey
    if interactionShowableCheck(actor) then
      Interaction_Show(actor)
    else
      Interaction_Close()
      return
    end
  end
  if nil ~= actor then
    Interaction_PositionUpdate(actor)
    if Panel_Interaction:GetShow() and ANIMATING_BUTTON then
      Interaction_ButtonPositionUpdate(deltaTime)
    end
  end
  Interaction_UpdatePerFrame_Desc()
end
function interaction_Forceed()
  local actor = interaction_getInteractable()
  local actorKey = 0
  if nil ~= actor then
    actorKey = actor:getActorKey()
    INTERACTABLE_ACTOR_KEY = actorKey
    if interactionShowableCheck(actor) then
      Interaction_Show(actor)
    else
      Interaction_Close()
    end
    Interaction_PositionUpdate(actor)
    Interaction_ButtonPositionUpdate(0)
  else
    return
  end
end
local GetBottomPos = function(control)
  if nil == control then
    UI.ASSERT(false, "GetBottomPos(control) , control nil")
    return
  end
  return control:GetPosY() + control:GetSizeY()
end
local YSize = 0
local linkButtonAction = {}
function Interaction_Show(actor)
  audioPostEvent_SystemUi(1, 5)
  local firstInteractionType = actor:getSettedFirstInteractionType()
  firstInteractionType = Interaction_MatchingIndex(firstInteractionType)
  basicInteractionType = firstInteractionType
  focusInteractionType = firstInteractionType
  if DESC_TEXT[firstInteractionType] == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping and actor:get():isHouseHold() then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    for ii = 0, #interactionTargetUIList do
      local isShow = Interaction_isSetInteractableFragLua(actor, ii)
      if isShow and (ii == CppEnums.InteractionType.InteractionType_OpenDoor or ii == CppEnums.InteractionType.InteractionType_Observer or ii == CppEnums.InteractionType.InteractionType_PvPBattle or ii == CppEnums.InteractionType.InteractionType_RankerHouseList) then
        Panel_Interaction:SetShow(false)
        return
      end
    end
  end
  local houseShow = false
  if actor:get():isHouseHold() then
    local houseHoldActor = getHouseHoldActor(actor:getActorKey())
    if houseHoldActor:get():isBuyable() then
      audioPostEvent_SystemUi(1, 5)
      houseShow = true
    end
  end
  Panel_Interaction_House:SetShow(houseShow)
  Panel_Interaction:SetShow(true)
  local actor = interaction_getInteractable()
  local actorKey = 0
  local actorName = actor:getName()
  if actor:get():isInstallationActor() or actor:get():isDeadBody() or actor:get():isCollect() then
    if not actor:get():isMonster() then
      actorName = actor:get():getStaticStatusName()
    end
    isTargetNpc = false
  elseif actor:get():isNpc() then
    local npcTitle = actor:getCharacterTitle()
    if nil == npcTitle or "" == npcTitle then
      actorName = actor:getName()
    else
      actorName = npcTitle .. "\n" .. actor:getName()
    end
    isTargetNpc = true
  elseif actor:get():isHouseHold() then
    if actor:getCharacterStaticStatusWrapper():getObjectStaticStatus():isPersonalTent() then
      actorName = actor:getCharacterStaticStatusWrapper():getName()
    else
      actorName = actor:getAddress()
    end
    isTargetNpc = false
  elseif actor:get():isLoot() then
    actorName = actor:getLootItemName()
    isTargetNpc = false
  end
  if actorName then
    if isTargetNpc then
      UI_NAME:SetSize(130, UI_NAME:GetSizeY())
      UI_NAME:SetPosX(-65)
    else
      UI_NAME:SetSize(100, UI_NAME:GetSizeY())
      UI_NAME:SetPosX(-56)
    end
    UI_NAME:SetTextHorizonCenter()
    UI_NAME:SetTextVerticalTop()
    UI_NAME:SetAutoResize(true)
    UI_NAME:SetText(actorName)
  else
    UI.ASSERT(false, "Interaction_Show // Actor Name is Nil!!!!")
  end
  UI_DESC:SetText(DESC_TEXT[firstInteractionType])
  updateButtonList(actor)
  SHOW_BUTTON_COUNT = 0
  for ii = 0, #interactionTargetUIList do
    local isShow = Interaction_isSetInteractableFragLua(actor, ii)
    interactionTargetUIList[ii]:SetShow(isShow)
    if isShow then
      if CppEnums.InteractionType.InteractionType_Observer == ii then
        local isLean = "LEAN_BACK_ING"
        if ToClient_SelfPlayerCheckAction(isLean) then
          FGlobal_Tutorial_RequestLean()
        end
        local isSitDown = "SIT_DOWN_ING"
        if ToClient_SelfPlayerCheckAction(isSitDown) then
          FGlobal_Tutorial_RequestSitDown()
        end
      end
      if CppEnums.InteractionType.InteractionType_ExchangeItem == ii then
        if actor:get():isNpc() then
          interactionTargetUIList[ii]:SetAutoDisableTime(pcExchangeDisableTimeByNpc)
        else
          interactionTargetUIList[ii]:SetAutoDisableTime(pcExchangeDisableTime)
        end
      end
      local shortcuts = SHOW_BUTTON_COUNT
      if 0 == SHOW_BUTTON_COUNT then
        if CppEnums.InteractionType.InteractionType_InvitedParty == ii or CppEnums.InteractionType.InteractionType_GuildInvite == ii or CppEnums.InteractionType.InteractionType_ExchangeItem == ii then
          interactionTargetUIList[ii]:SetText(interactionTargetTextList[ii])
        elseif CppEnums.InteractionType.InteractionType_Talk == ii and actor:getCharacterStaticStatusWrapper():get():isSummonedCharacterBySiegeObject() then
          if true == _ContentsGroup_RenewUI then
            interactionTargetUIList[ii]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_USE"))
          else
            interactionTargetUIList[ii]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_USE") .. " <PAColor0xFFFFD543>(" .. keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction) .. ")<PAOldColor>")
          end
        elseif true == _ContentsGroup_RenewUI then
          interactionTargetUIList[ii]:SetText(interactionTargetTextList[ii])
        else
          interactionTargetUIList[ii]:SetText(interactionTargetTextList[ii] .. " <PAColor0xFFFFD543>(" .. keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction) .. ")<PAOldColor>")
        end
        interactionTargetUIList[ii]:SetFontColor(UI_Color.C_FFEFEFEF)
      else
        local _string = Interaction_ChangeString(SHOW_BUTTON_COUNT)
        if true == _ContentsGroup_RenewUI or CppEnums.InteractionType.InteractionType_SkillAwakenPlayer == ii then
          interactionTargetUIList[ii]:SetText(interactionTargetTextList[ii])
        else
          interactionTargetUIList[ii]:SetText(interactionTargetTextList[ii] .. " <PAColor0xFFFFD543>(" .. _string .. ")<PAOldColor>")
        end
        interactionTargetUIList[ii]:SetFontColor(UI_Color.C_FF999999)
      end
      linkButtonAction[SHOW_BUTTON_COUNT] = ii
      SHOW_BUTTON_COUNT = SHOW_BUTTON_COUNT + 1
    end
  end
  local npcActorProxyWrapper = getNpcActor(actor:getActorKey())
  if nil ~= npcActorProxyWrapper then
    local currentType = npcActorProxyWrapper:get():getOverHeadQuestInfoType()
    if true == Interaction_isSetInteractableFragLua(actor, 4) and 3 == currentType then
      interactionTargetUIList[4]:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Widget/Interaction/Interaction_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(interactionTargetUIList[4], 1, 106, 35, 140)
      interactionTargetUIList[4]:getBaseTexture():setUV(x1, y1, x2, y2)
      interactionTargetUIList[4]:setRenderTexture(interactionTargetUIList[4]:getBaseTexture())
      UI_NAME:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "INTERACTION_TEXT_COMPLETE_QUEST", "actionInputType", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction)))
    else
      interactionTargetUIList[4]:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Widget/Interaction/Interaction_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(interactionTargetUIList[4], 1, 1, 35, 35)
      interactionTargetUIList[4]:getBaseTexture():setUV(x1, y1, x2, y2)
      interactionTargetUIList[4]:setRenderTexture(interactionTargetUIList[4]:getBaseTexture())
    end
  end
  _globalGuide:SetPosX(60)
  _globalGuide:SetPosY(Panel_Interaction:GetSizeY() * 0.5 - _globalGuide:GetSizeY() * 0.5)
  _needCollectTool:SetShow(false)
  Interaction_UpdateDesc(firstInteractionType)
  ANIMATING_BUTTON = true
  BUTTON_UPDATE_TIME = 0
  Interaction_ButtonPositionUpdate(0)
  isReloadState = false
  local actorKeyRaw = actor:get():getActorKeyRaw()
  Furniture_Check(actorKeyRaw)
  PaGlobal_TutorialManager:handleInteractionShow(actor)
  FGlobal_Interaction_ClearSelectIndex()
  _circularProgressBarInteraction:SetProgressRate(0)
end
function Interaction_ChangeString(index)
  local _string = "F6"
  if 1 == index then
    _string = keyCustom_GetString_UiKey(__eUiInputType_Interaction0)
  elseif 2 == index then
    _string = keyCustom_GetString_UiKey(__eUiInputType_Interaction1)
  elseif 3 == index then
    _string = keyCustom_GetString_UiKey(__eUiInputType_Interaction2)
  elseif 4 == index then
    _string = keyCustom_GetString_UiKey(__eUiInputType_Interaction3)
  elseif 5 == index then
    _string = keyCustom_GetString_UiKey(__eUiInputType_Interaction4)
  end
  return _string
end
function Interaction_isSetInteractableFragLua(actor, index)
  if nil == actor then
    return
  end
  if nil == index then
    return
  end
  local isShow = actor:isSetInteracatbleFrag(index)
  if index == CppEnums.InteractionType.InteractionType_SkillAwakenPlayer then
    isShow = actor:isSetInteracatbleFrag(86)
  elseif index == CppEnums.InteractionType.InteractionType_GuildDrill then
    isShow = actor:isSetInteracatbleFrag(85)
  elseif index == CppEnums.InteractionType.InteractionType_ReturnRentedMansion then
    isShow = actor:isSetInteracatbleFrag(87)
  elseif index == CppEnums.InteractionType.InteractionType_ShowCampingTentUI then
    isShow = actor:isSetInteracatbleFrag(__eInteractionType_ShowCampingTentUI)
  elseif index == CppEnums.InteractionType.InteractionType_UseCampingTent then
    isShow = actor:isSetInteracatbleFrag(__eInteractionType_UseCampingTent)
  elseif index == CppEnums.InteractionType.InteractionType_RepairTool then
    isShow = actor:isSetInteracatbleFrag(__eInteractionType_RepairTool)
  end
  return isShow
end
function FGlobal_InteractionButtonCount()
  return SHOW_BUTTON_COUNT
end
function FGlobal_InteractionButtonActionRun(keyIdx)
  Interaction_ButtonPushed(linkButtonAction[keyIdx])
end
function Panel_Interaction_GetGlobalGuidePosX()
  return Panel_Interaction:GetPosX() + _globalGuide:GetPosX()
end
function Panel_Interaction_GetGlobalGuidePosY()
  return Panel_Interaction:GetPosY() + _globalGuide:GetPosY()
end
function Interaction_Close()
  if Panel_Interaction:IsShow() or Panel_Interaction_House:IsShow() then
    Panel_Interaction:SetShow(false)
    Panel_Interaction_House:SetShow(false)
    INTERACTABLE_ACTOR_KEY = 0
    _globalGuide:SetShow(false)
    Panel_Interaction_HouseRanke_Close()
    FriendHouseRank_Close()
  end
  Funiture_Endurance_Hide()
end
function Interaction_PositionUpdate(actor)
  local pos2d = actor:get2DPosForInterAction()
  if pos2d.x < 0 and 0 > pos2d.y then
    if Panel_Interaction_House:IsShow() then
      Panel_Interaction_House:SetPosX(-1000)
      Panel_Interaction_House:SetPosY(-1000)
    end
    Panel_Interaction:SetPosX(-1000)
    Panel_Interaction:SetPosY(-1000)
  else
    if Panel_Interaction_House:IsShow() then
      Panel_Interaction_House:SetPosX(pos2d.x - Panel_Interaction_House:GetSizeX() / 2)
      Panel_Interaction_House:SetPosY(pos2d.y + 100)
    end
    Panel_Interaction:SetPosX(pos2d.x + 0)
    Panel_Interaction:SetPosY(pos2d.y - 100)
  end
end
function Interaction_ButtonPositionUpdate(deltaTime)
  local ANIMATION_TIME = 0.35
  local BUTTON_OFFSET_X = 0
  local BUTTON_OFFSET_Y = 0
  local CIRCLE_RADIUS = 0
  if isTargetNpc then
    _background:SetSize(140, 140)
    BUTTON_OFFSET_X = -18
    BUTTON_OFFSET_Y = 42
    CIRCLE_RADIUS = 60
  else
    _background:SetSize(128, 128)
    BUTTON_OFFSET_X = -25
    BUTTON_OFFSET_Y = 35
    CIRCLE_RADIUS = 50
  end
  _circularProgressBarInteraction:SetPosX(BUTTON_OFFSET_X - 10)
  _circularProgressBarInteraction:SetPosY(BUTTON_OFFSET_Y - 7)
  _circularProgressBarStaticbgInteraction:SetPosX(BUTTON_OFFSET_X - 10)
  _circularProgressBarStaticbgInteraction:SetPosY(BUTTON_OFFSET_Y - 7)
  UI_NAME:SetPosY(_background:GetPosY() + _background:GetSizeY() / 2 - UI_NAME:GetSizeY() * 0.5)
  local ANGLE_OFFSET = math.pi * -0.5
  if ANIMATION_TIME < BUTTON_UPDATE_TIME then
    ANIMATING_BUTTON = false
  else
    BUTTON_UPDATE_TIME = BUTTON_UPDATE_TIME + deltaTime
    local aniRate = BUTTON_UPDATE_TIME / ANIMATION_TIME
    if aniRate > 1 then
      aniRate = 1
    end
    local actor = interaction_getInteractable()
    local jj = 0
    for ii = 0, #interactionTargetUIList do
      local isShow = Interaction_isSetInteractableFragLua(actor, ii)
      if isShow then
        local div = jj / SHOW_BUTTON_COUNT
        local buttonPosX = BUTTON_OFFSET_X + CIRCLE_RADIUS * aniRate * math.cos(math.pi * 2 * div * aniRate + ANGLE_OFFSET)
        local buttonPosY = BUTTON_OFFSET_Y + CIRCLE_RADIUS * aniRate * math.sin(math.pi * 2 * div * aniRate + ANGLE_OFFSET)
        interactionTargetUIList[ii]:SetPosX(buttonPosX)
        interactionTargetUIList[ii]:SetPosY(buttonPosY)
        interactionTargetUIList[ii]:SetAlpha(aniRate)
        _needCollectTool:SetPosX(buttonPosX + 2)
        _needCollectTool:SetPosY(buttonPosY + 2)
        local verticalSize = interactionTargetUIList[ii]:GetSizeY()
        if BUTTON_OFFSET_Y > buttonPosY then
          verticalSize = verticalSize * -0.5
        end
        interactionTargetUIList[ii]:SetTextSpan(0, verticalSize)
        if math.floor(buttonPosX) == math.floor(BUTTON_OFFSET_X) then
          interactionTargetUIList[ii]:SetTextHorizonCenter()
        elseif BUTTON_OFFSET_X > buttonPosX then
          interactionTargetUIList[ii]:SetTextHorizonRight()
        elseif BUTTON_OFFSET_X < buttonPosX then
          interactionTargetUIList[ii]:SetTextHorizonLeft()
        end
        jj = jj + 1
      end
    end
  end
end
function Interaction_Reset()
  INTERACTABLE_ACTOR_KEY = 0
end
function Interaction_ButtonPushed(interactionType)
  if FGlobal_GetIsCutScenePlay() == true then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  preUIMode = GetUIMode()
  if nil ~= PaGlobal_SkillGroup and true == Panel_Window_SkillGroup:GetShow() and false == PaGlobal_SkillGroup._isWindow then
    return
  end
  local isTakedownCannon = false
  local function isTakedownCannonFuncPass()
    interaction_processInteraction(interactionType)
  end
  if CppEnums.InteractionType.InteractionType_TakedownCannon == interactionType then
    isTakedownCannon = true
  elseif CppEnums.InteractionType.InteractionType_Talk == interactionType then
    if true == MessageBoxPanelNilCheck() and true == MessageBoxGetShow() then
      return
    end
    SetUIMode(Defines.UIMode.eUIMode_NpcDialog)
  elseif CppEnums.InteractionType.InteractionType_InvitedParty == interactionType then
    if true == ToClient_IsInstanceRandomMatching() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLOODALTAR_RAMDOMMATCH_FAILBYPARTY"))
      return
    else
      local actor = interaction_getInteractable()
      if nil == actor then
        return
      elseif true == _ContentsGroup_NameTypeEqually then
        local nameType = ToClient_getChatNameType()
        if __eChatNameType_NickName == nameType then
          local actorKeyRaw = actor:getActorKey()
          local playerActorProxyWrapper = getPlayerActor(actorKeyRaw)
          if nil ~= playerActorProxyWrapper then
            local targetNickName = playerActorProxyWrapper:getUserNickname()
            Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", targetNickName))
          end
        else
          local targetName = actor:getName()
          Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", targetName))
        end
      else
        local targetName = actor:getName()
        Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", targetName))
      end
    end
  elseif CppEnums.InteractionType.InteractionType_UseItem == interactionType and true == isCurrentPositionInWater() then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_USEITEM_INTERACTION_IN_WATER"))
    return
  elseif CppEnums.InteractionType.InteractionType_PvPBattle == interactionType then
    local actor = interaction_getInteractable()
    if nil == actor then
      return
    elseif true == ToClient_doExistWorldBossMonsterAtRegion() then
      if true == ToClient_isUseWorldBossMonsterAtRegion() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPVPMatchCantBossMonsterAtRegion"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPVPMatchCantBossMonster"))
      end
    else
      local selfPlayer = getSelfPlayer()
      if selfPlayer == nil then
        return
      end
      if selfPlayer:get():getLevel() <= ToClient_getFightLevelLimit() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoFightLevelLimit"))
        return
      end
      local playerActorProxyWrapper = getPlayerActor(actor:getActorKey())
      if playerActorProxyWrapper:get():getLevel() <= ToClient_getFightLevelLimit() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRequestFightLevelLimit"))
        return
      end
      local targetCharacterName = actor:getOriginalName()
      PaGlobal_PvPBattle:notifyRequest(targetCharacterName)
    end
  elseif CppEnums.InteractionType.InteractionType_InstallationMode == interactionType then
    if getInputMode() == CppEnums.EProcessorInputMode.eProcessorInputMode_ChattingInputMode then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOT_ENTER_HOUSINGMODE_CHATMODE"))
      return
    end
  elseif CppEnums.InteractionType.InteractionType_Collect == interactionType then
    local actorWrapper = interaction_getInteractable()
    if nil ~= actorWrapper then
      local charWrapper = actorWrapper:getCharacterStaticStatusWrapper()
      if nil ~= charWrapper and true == charWrapper:isAttrSet(__eHoeMiniGameCharacter) and nil ~= getSelfPlayer() then
        local playerWp = getSelfPlayer():getWp()
        local needWp = ToClient_CheckMiniGameFindWp(charWrapper:getCharacterKey())
        if playerWp < needWp then
          local charName = charWrapper:getName()
          local failMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_WPHELP", "name", charName)
          Proc_ShowMessage_Ack(failMsg)
          return
        end
        if __eWeightLevel3 <= getWeightLevel() then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemIsTooHeavy"))
          return
        end
      end
    end
  elseif CppEnums.InteractionType.InteractionType_ExchangeItem == interactionType then
    local actor = interaction_getInteractable()
    if nil ~= actor and false == actor:get():isNpc() then
      interactionTargetUIList[interactionType]:SetMonoTone(true)
    end
  elseif CppEnums.InteractionType.InteractionType_SkillAwakenPlayer == interactionType then
    local actor = interaction_getInteractable()
    if nil == actor then
      return
    end
    if false == actor:get() then
      return
    end
    if false == actor:get():isPlayer() then
      return
    end
    local isAwakenPlayer = Interaction_isSetInteractableFragLua(actor, CppEnums.InteractionType.InteractionType_SkillAwakenPlayer)
    if false == isAwakenPlayer then
      return
    end
    if false == IsSelfPlayerWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTCURRENTACTION_ACK"))
      return
    end
    ToClient_RequestSkillAwakeningByPlayerStart()
  elseif CppEnums.InteractionType.InteractionType_GuildDrill == interactionType then
    local actor = interaction_getInteractable()
    if nil == actor then
      return
    end
    PaGlobal_MiningFuel_All_LoadGuildDrillInfo(actor:get():getActorKeyRaw())
    return
  elseif CppEnums.InteractionType.InteractionType_Ride == interactionType then
    local actor = interaction_getInteractable()
    if nil == actor then
      return
    end
    local isSeasonCharacter = getSelfPlayer():get():isSeasonCharacter()
    local actorKeyRaw = actor:get():getActorKeyRaw()
    local vehicleWrapper = getVehicleActor(actorKeyRaw)
    if true == isSeasonCharacter and nil ~= vehicleWrapper then
      local vehicleType = vehicleWrapper:get():getVehicleType()
      if __eVehicleType_Horse == vehicleType then
        local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
        if nil ~= servantWrapper then
          local tier = servantWrapper:getTier()
          if tier > 8 then
            Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_CANTRIDE"))
            return
          end
        end
      end
    end
  elseif CppEnums.InteractionType.InteractionType_ReturnRentedMansion == interactionType then
    local actor = interaction_getInteractable()
    if nil == actor then
      return
    end
    if true == actor:get():isHouseHold() then
      do
        local houseHoldActor = getHouseHoldActor(actor:getActorKey())
        if nil == houseHoldActor then
          return
        end
        local houseHoldActorSSW = houseHoldActor:getStaticStatusWrapper()
        if nil == houseHoldActorSSW then
          return
        end
        local houseObjectSSW = houseHoldActorSSW:getObjectStaticStatus()
        if nil == houseObjectSSW then
          return
        end
        local chracterKey = houseHoldActorSSW:getCharacterKey()
        local isMansionLand = houseObjectSSW:isMansionLand()
        if false == isMansionLand then
          return
        end
        local function returnHouse()
          ToClient_RequestReturnHouse(chracterKey)
        end
        local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
        local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_RETURNMANSION_DESC")
        local messageBoxData = {
          title = messageTitle,
          content = messageBoxMemo,
          functionYes = returnHouse,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageBoxData)
      end
    end
  elseif CppEnums.InteractionType.InteractionType_UnbuildPersonalTent == interactionType then
    local function doUnbuildPersonalTent()
      interaction_processInteraction(interactionType)
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_FARMLINE_RETURN_ITEM_MSG"),
      functionYes = doUnbuildPersonalTent,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
    return
  elseif CppEnums.InteractionType.InteractionType_ShowCampingTentUI == interactionType then
    interaction_processInteraction(__eInteractionType_ShowCampingTentUI)
    return
  elseif CppEnums.InteractionType.InteractionType_UseCampingTent == interactionType then
    interaction_processInteraction(__eInteractionType_UseCampingTent)
    return
  elseif CppEnums.InteractionType.InteractionType_RepairTool == interactionType then
    interaction_processInteraction(__eInteractionType_RepairTool)
    return
  end
  if isTakedownCannon then
    local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "INTERACTION_TEXT_TAKEDOWN_CANNON")
    local messageBoxData = {
      title = messageTitle,
      content = messageBoxMemo,
      functionYes = isTakedownCannonFuncPass,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    interaction_processInteraction(interactionType)
  end
end
function FromClient_InteractionFail()
  if nil == preUIMode then
    return
  end
  SetUIMode(preUIMode)
end
function Interaction_ButtonOver(interactionType, isOver)
  local button = interactionTargetUIList[interactionType]
  button:ResetVertexAni()
  button:SetColor(UI_Color.C_FFFFFFFF)
  if nil == button then
    return
  end
  if isOver then
    audioPostEvent_SystemUi(0, 13)
    button:SetVertexAniRun("Ani_Color_Light", true)
    button:SetFontAlpha(1)
  else
    button:ResetVertexAni()
    button:SetFontAlpha(1)
  end
  isFocusInteractionType = isOver
  if isOver then
    focusInteractionType = interactionType
    Interaction_UpdateDesc(interactionType)
  else
    focusInteractionType = basicInteractionType
    Interaction_UpdateDesc(focusInteractionType)
  end
end
function Interaction_UpdatePerFrame_Desc()
  if focusInteractionType == CppEnums.InteractionType.InteractionType_Sympathetic then
    Interaction_UpdateDesc(focusInteractionType)
  elseif focusInteractionType == CppEnums.InteractionType.InteractionType_Observer then
    Interaction_UpdateDesc(focusInteractionType)
  end
  local actor = interaction_getInteractable()
  if actor == nil then
    return
  end
  if Interaction_isSetInteractableFragLua(actor, CppEnums.InteractionType.InteractionType_Sympathetic) then
    local vehicleWrapper = getVehicleActor(actor:get():getActorKeyRaw())
    if vehicleWrapper ~= nil then
      isSympatheticEnable = vehicleWrapper:checkUsableSympathetic()
      interactionTargetUIList[CppEnums.InteractionType.InteractionType_Sympathetic]:SetMonoTone(not isSympatheticEnable)
      if false == isFocusInteractionType then
        if not isSympatheticEnable then
          if focusInteractionType == basicInteractionType then
            focusInteractionType = CppEnums.InteractionType.InteractionType_Sympathetic
          end
        else
          focusInteractionType = basicInteractionType
        end
      end
    end
  end
end
function Interaction_UpdateDesc(indteractionType)
  local actor = interaction_getInteractable()
  if actor == nil then
    return
  end
  if not Interaction_isSetInteractableFragLua(actor, indteractionType) then
    return
  end
  local interactionDesc
  if indteractionType == basicInteractionType and (not actor:get():isPlayer() or actor:get():isSelfPlayer()) then
    if 61 ~= indteractionType then
      interactionDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_0", "interactionkey", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction), "interaction", interactionTargetTextList[indteractionType])
    else
      interactionDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_2", "interactionkey", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction), "interaction", interactionTargetTextList[indteractionType])
    end
  else
    interactionDesc = DESC_TEXT[indteractionType]
  end
  if indteractionType == CppEnums.InteractionType.InteractionType_Collect then
    if actor:get():isCollect() or actor:get():isDeadBody() then
      local collectWrapper = getCollectActor(actor:getActorKey())
      if nil == collectWrapper then
        collectWrapper = getMonsterActor(actor:getActorKey())
        if nil == collectWrapper then
          collectWrapper = getDeadBodyActor(actor:getActorKey())
          if nil == collectWrapper then
            _PA_ASSERT(false, "\236\177\132\236\167\145\236\157\184\237\132\176\235\158\153\236\133\152\236\157\132 \236\136\152\237\150\137\236\164\145\236\157\184\235\141\176 \235\140\128\236\131\129\236\157\180 \236\177\132\236\167\145\235\172\188\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164. \235\185\132\236\160\149\236\131\129\236\158\132")
            return
          end
        end
      end
      if collectWrapper:isCollectable() and false == collectWrapper:isCollectableUsingMyCollectTool() then
        _needCollectTool:SetShow(true)
        interactionDesc = ""
        for loop = 0, __eCollectToolType_Count do
          local isAble = collectWrapper:getCharacterStaticStatusWrapper():isCollectableToolType(loop)
          if isAble then
            if 0 < string.len(interactionDesc) then
              interactionDesc = "<PAColor0xFFFFD649>'" .. interactionDesc .. "'<PAOldColor>, <PAColor0xFFFFD649>'" .. CppEnums.CollectToolTypeName[loop] .. "'<PAOldColor>"
            else
              interactionDesc = "<PAColor0xFFFFD649>'" .. CppEnums.CollectToolTypeName[loop] .. "'<PAOldColor>"
            end
          end
        end
        interactionDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_TEXT_NEEDGUIDE", "interactionDesc", interactionDesc)
      end
    end
  elseif indteractionType == CppEnums.InteractionType.InteractionType_Sympathetic then
    local isSympathetic = Interaction_isSetInteractableFragLua(actor, CppEnums.InteractionType.InteractionType_Sympathetic)
    if isSympathetic then
      local vehicleWrapper = getVehicleActor(actor:get():getActorKeyRaw())
      if vehicleWrapper ~= nil then
        isSympatheticEnable = vehicleWrapper:checkUsableSympathetic()
        interactionTargetUIList[CppEnums.InteractionType.InteractionType_Sympathetic]:SetMonoTone(not isSympatheticEnable)
        if not isSympatheticEnable then
          local sympatheticCooltime = math.ceil(vehicleWrapper:getSympatheticCoolTime() / 1000) * 1000
          interactionDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SYMPATHETIC_COOLTIME_DESC", "cooltime", convertStringFromMillisecondtime(toUint64(0, sympatheticCooltime)))
        else
          interactionDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SYMPATHETIC_DESC")
        end
      end
    end
  elseif indteractionType == CppEnums.InteractionType.InteractionType_Observer then
    if isObserverMode() then
      if indteractionType == basicInteractionType then
        interactionDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_1", "interactionkey", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction), "interaction", interactionTargetTextList[indteractionType])
      else
        interactionDesc = DESC_TEXT[indteractionType]
      end
      ShowCommandFunc()
    end
  elseif indteractionType == CppEnums.InteractionType.InteractionType_UseCampingTent then
    local index = 0
    for ii, value in pairs(linkButtonAction) do
      if value == indteractionType then
        index = ii
      end
    end
    local keyString = Interaction_ChangeString(index)
    interactionDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_0", "interactionkey", keyString, "interaction", interactionTargetTextList[indteractionType])
  elseif indteractionType == CppEnums.InteractionType.InteractionType_RepairTool then
    interactionDesc = PAGetString(Defines.StringSheet_GAME, "LUA_AUTOREPAIR_TOOL_BASIC_DES")
  end
  _globalGuide:SetText(interactionDesc)
  _globalGuide:SetShow(true)
  if _ContentsGroup_RenewUI then
    if SHOW_BUTTON_COUNT > 1 then
      _globalGuide:SetSize(250, 50)
      _globalGuide:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_INTERACTION_XBOXGUIDE"))
    else
      _globalGuide:SetSize(250, 23)
      _globalGuide:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_INTERACTION_XBOXGUIDE"))
    end
  end
end
function FromClient_NotifyObserverModeEnd()
  if false == _ContentsGroup_RenewUI_WatchMode then
    Panel_WatchingMode:SetShow(false)
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer:isDead() then
    if false == _ContentsGroup_NewUI_DeadMessage_All then
      Panel_DeadMessage:SetShow(true, true)
    else
      PaGlobalFunc_DeadMessage_All_Open()
    end
  end
end
function FromClient_ConfirmInstallationBuff(currentEndurance, skillKey, level)
  if MessageBox.isPopUp() then
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_MSGBOX_MEMO_BUFF", "currentEndurance", tostring(currentEndurance))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_MSGBOX_DATA_TITLE"),
    content = messageBoxMemo,
    functionYes = Interaction_InstallationBuff,
    functionNo = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW
  }
  if 0 ~= skillKey and 0 ~= level then
    local skillWarpper = getSkillStaticStatus(skillKey, level)
    if nil ~= skillWarpper then
      local buffDesc = ""
      for buffIdx = 0, skillWarpper:getBuffCount() - 1 do
        local desc = skillWarpper:getBuffDescription(buffIdx)
        if nil ~= desc and "" ~= desc then
          buffDesc = buffDesc .. "\n" .. desc
        end
      end
      messageboxData.content = messageBoxMemo .. [[


]] .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HOUSING_BUFF_FURNITURE", "buffNames", buffDesc)
    end
  end
  MessageBox.showMessageBox(messageboxData)
end
function Interaction_InstallationBuff()
  toClient_RequestInstallationBuff()
end
function FromClient_EnablePCExChangeButton()
  local exchagneButton = interactionTargetUIList[CppEnums.InteractionType.InteractionType_ExchangeItem]
  if nil ~= exchagneButton then
    exchagneButton:ClearDisableTime()
    exchagneButton:SetAutoDisableTime(pcExchangeDisableTime)
    exchagneButton:SetMonoTone(false)
    local actor = interaction_getInteractable()
    if nil ~= actor then
      local isNpc = actor:get():isNpc()
      if true == isNpc then
        exchagneButton:ClearDisableTime()
        exchagneButton:SetAutoDisableTime(pcExchangeDisableTimeByNpc)
        exchagneButton:SetMonoTone(false)
      end
    end
  end
end
registerEvent("FromClient_InterAction_UpdatePerFrame", "Interaction_Update")
registerEvent("FromClient_ConfirmInstallationBuff", "FromClient_ConfirmInstallationBuff")
registerEvent("FromClient_InteractionFail", "FromClient_InteractionFail")
registerEvent("FromClient_NotifyObserverModeEnd", "FromClient_NotifyObserverModeEnd")
registerEvent("FromClient_EnablePCExChangeButton", "FromClient_EnablePCExChangeButton")
registerEvent("FromClient_NotEnoughWpByInteraction", "FromClient_Interaction_NotEnoughWp")
local isReloadState = true
local function interactionReload()
  if false == isReloadState then
    Interaction_Close()
    return
  end
  local actor = interaction_getInteractable()
  if nil == actor then
    Interaction_Close()
    return
  end
  if actor:get():isHouseHold() then
    Panel_Interaction:SetShow(false)
    Panel_Interaction_House:SetShow(false)
    INTERACTABLE_ACTOR_KEY = 0
    _globalGuide:SetShow(false)
    if interactionShowableCheck(actor) then
      Interaction_Show(actor)
    else
      Interaction_Close()
    end
  end
end
function renderModeChange_interactionReload(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  interactionReload()
end
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_interactionReload")
function Interaction_SetReloadState()
  isReloadState = true
  if false == isFlushedUI() then
    interactionReload()
  end
end
function FromClient_InteractionHarvest()
  interaction_setInteractingState(CppEnums.InteractionType.InteractionType_Havest)
end
function FromClient_InteractionSeedHarvest()
  interaction_setInteractingState(CppEnums.InteractionType.InteractionType_SeedHavest)
end
local _buildingUpgradeActoKeyRaw = 0
function FromClient_InteractionBuildingUpgrade(actorKeyRaw)
  local actorProxy = getActor(actorKeyRaw)
  if nil == actorProxy then
    return
  end
  local upgradeStaticWrapper = actorProxy:getCharacterStaticStatusWrapper():getBuildingUpgradeStaticStatus()
  if nil == upgradeStaticWrapper then
    _PA_ASSERT(false, "FromClient_InteractionBuildingUpgrade --- upgradeStaticWrapper\236\157\180 \235\185\132\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164. ")
    return
  end
  if nil == upgradeStaticWrapper:getTargetCharacter() then
    _PA_ASSERT(false, "FromClient_InteractionBuildingUpgrade --- upgradeStaticWrapper:getTargetCharacter()\236\157\180 \235\185\132\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164. ")
    return
  end
  local strNeedItems = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_UPGRADE_BARRICADE", "getName", upgradeStaticWrapper:getTargetCharacter():getName())
  local tempStr = ""
  local sourceItemCount = upgradeStaticWrapper:getSourceItemCount()
  for index = 0, sourceItemCount - 1 do
    local iessw = upgradeStaticWrapper:getSourceItemEnchantStaticStatus(index)
    if nil ~= iessw then
      local itemNeedCount = upgradeStaticWrapper:getSourceItemNeedCount(index)
      local itemName = iessw:getName()
      local territoryComma = ", "
      if "" == tempStr then
        territoryComma = ""
      end
      tempStr = tempStr .. " " .. territoryComma .. "[<PAColor0xFFE49800>" .. itemName .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACHIVEMENT_ITEMCOUNT", "count", tostring(itemNeedCount)) .. "<PAOldColor>]"
    end
  end
  _buildingUpgradeActoKeyRaw = actorKeyRaw
  local messageBoxMemo = strNeedItems .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_UPGRADE_BARRICADE_NEEDITEMS", "strNeedItems", tempStr)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_UPGRADE_MESSAGEBOX_TITLE"),
    content = messageBoxMemo,
    functionYes = InteractionBuildingUpgrade_Confirm,
    functionNo = MessageBox_Empty_function,
    priority = UI_PP.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function InteractionBuildingUpgrade_Confirm()
  toClient_RequestBuildingUpgrade(_buildingUpgradeActoKeyRaw)
end
function FromClient_InteractionSiegeObject(actorKeyRaw, funcState)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  local actorProxy = actorProxyWrapper:get()
  _buildingUpgradeActoKeyRaw = actorKeyRaw
  if 0 == funcState then
    local price = Int64toInt32(actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():getUsingPrice())
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_DESC2", "price", makeDotMoney(price))
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_TITLE"),
      content = messageBoxMemo,
      functionYes = InteractSiegeObjectControlStart_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = UI_PP.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif actorProxyWrapper:getCharacterStaticStatusWrapper():getObjectStaticStatus():isElephantBarn() then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_ELEPHANTBARN_MEMO_DESC")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_TITLE"),
      content = messageBoxMemo,
      functionYes = InteractSiegeObjectControlFinish_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = UI_PP.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_DESC")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_WARBUILDING_MEMO_TITLE"),
      content = messageBoxMemo,
      functionYes = InteractSiegeObjectControlFinish_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = UI_PP.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
end
function InteractSiegeObjectControlStart_Confirm()
  toClient_RequestSiegeObjectControlStart(_buildingUpgradeActoKeyRaw)
end
function InteractSiegeObjectControlFinish_Confirm()
  toClient_RequestSiegeObjectControlFinish(_buildingUpgradeActoKeyRaw)
end
function InteractionTooltipResize_ByFontSize()
  if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
    _globalGuide:SetSize(_globalGuide:GetSizeX(), 30)
  else
    _globalGuide:SetSize(_globalGuide:GetSizeX(), 23)
  end
end
function PaGlobal_Interaction_GetShow()
  return Panel_Interaction:GetShow()
end
registerEvent("FromClient_ReceiveBuyHouse", "Interaction_SetReloadState")
registerEvent("FromClient_ReceiveChangeUseType", "Interaction_SetReloadState")
registerEvent("FromClient_ReceiveReturnHouse", "Interaction_SetReloadState")
registerEvent("FromClient_ReceiveSetMyHouse", "Interaction_SetReloadState")
registerEvent("FromClient_InteractionHarvest", "FromClient_InteractionHarvest")
registerEvent("FromClient_InteractionSeedHarvest", "FromClient_InteractionSeedHarvest")
registerEvent("FromClient_InteractionBuildingUpgrade", "FromClient_InteractionBuildingUpgrade")
registerEvent("FromClient_InteractionSiegeObject", "FromClient_InteractionSiegeObject")
registerEvent("FromClient_luaLoadComplete", "InteractionTooltipResize_ByFontSize")
local myContributeValue = Panel_Expgauge_MyContributeValue
local buyHouseButton = UI.getChildControl(Panel_Interaction_House, "Button_BuyHouse")
local function houseInit()
  if myContributeValue == 0 then
    buyHouseButton:SetFontColor(UI_Color.C_FFD20000)
    buyHouseButton:addInputEvent("Mouse_LUp", "")
    buyHouseButton:addInputEvent("Mouse_On", "Panel_Interaction_House_HelpDesc_Func( 0, true )")
    buyHouseButton:addInputEvent("Mouse_Out", "Panel_Interaction_House_HelpDesc_Func( 0, false )")
  else
    buyHouseButton:SetFontColor(UI_Color.C_FFC4BEBE)
    buyHouseButton:addInputEvent("Mouse_LUp", "FGlobal_OpenWorldMapWithHouse()")
    buyHouseButton:addInputEvent("Mouse_On", "Panel_Interaction_House_HelpDesc_Func( 1, true )")
    buyHouseButton:addInputEvent("Mouse_Out", "Panel_Interaction_House_HelpDesc_Func( 1, false )")
  end
  _houseDesc:SetAutoResize(true)
  _houseDesc:SetTextMode(__eTextMode_AutoWrap)
  _houseDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INTERACTION_HouseDesc"))
  _houseDescBG:SetSize(_houseDesc:GetSizeX() + 13, _houseDesc:GetSizeY() + 10)
  YSize = GetBottomPos(_houseDescBG)
  Panel_Interaction_House:SetSize(Panel_Interaction_House:GetSizeX(), YSize + 50)
  buyHouseButton:ComputePos()
end
function Panel_Interaction_House_HelpDesc_Func(contribute, isOn)
  local mouse_posX = getMousePosX()
  local mouse_posY = getMousePosY()
  local panel_posX = Panel_Interaction_House:GetPosX()
  local panel_posY = Panel_Interaction_House:GetPosY()
  _contribute_Help:SetAlpha(0)
  if isOn == true and contribute == 0 then
    buyHouseButton:SetFontColor(UI_Color.C_FFF26A6A)
    _contribute_Help:SetAutoResize(true)
    _contribute_Help:SetTextMode(__eTextMode_AutoWrap)
    _contribute_Help:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ContributeHelp", "myContributeValue", myContributeValue))
    _contribute_Help:SetSize(_contribute_Help:GetSizeX() + 5, _contribute_Help:GetSizeY() + 10)
    _contribute_Help:SetPosY(Panel_Interaction_House:GetSizeY())
    local aniInfo = UIAni.AlphaAnimation(1, _contribute_Help, 0, 0.2)
    _contribute_Help:SetShow(true)
  elseif isOn == false and contribute == 0 then
    buyHouseButton:SetFontColor(UI_Color.C_FFD20000)
    _contribute_Help:SetSize(270, 100)
    local aniInfo = UIAni.AlphaAnimation(0, _contribute_Help, 0, 0.2)
    aniInfo:SetHideAtEnd(true)
  end
  if isOn == true and contribute == 1 then
    buyHouseButton:SetFontColor(UI_Color.C_FFEFEFEF)
  elseif isOn == false and contribute == 1 then
    buyHouseButton:SetFontColor(UI_Color.C_FFC4BEBE)
  end
end
local InteractionCheck = function(interactionType)
  if interactionType == CppEnums.InteractionType.InteractionType_InvitedParty or interactionType == CppEnums.InteractionType.InteractionType_GuildInvite then
    return true
  end
  if interactionType == CppEnums.InteractionType.InteractionType_ExchangeItem then
    local actor = interaction_getInteractable()
    if nil ~= actor then
      local isNpc = actor:get():isNpc()
      if false == isNpc then
        return true
      end
    end
  end
  return false
end
function Interaction_ExecuteByKeyMapping(keycode)
  _circularProgressBarInteraction:SetProgressRate(0)
  local buttonCount = FGlobal_InteractionButtonCount()
  DragManager:clearInfo()
  if keycode ~= CppEnums.ActionInputType.ActionInputType_Interaction then
    setUiInputProcessed(keycode)
  end
  if keycode == CppEnums.ActionInputType.ActionInputType_Interaction then
    local camBlur = getCameraBlur()
    local interactableActor = interaction_getInteractable()
    if interactableActor ~= nil and (not interactableActor:get():isPlayer() or interactableActor:get():isSelfPlayer()) and camBlur <= 0 then
      local interactionType = interactableActor:getSettedFirstInteractionType()
      interactionType = Interaction_MatchingIndex(interactionType)
      if InteractionCheck(interactionType) then
        return
      end
      Interaction_ButtonPushed(interactionType)
      return
    elseif interactableActor ~= nil and interactableActor:get():isPlayer() and camBlur <= 0 then
      local interactionType = interactableActor:getSettedFirstInteractionType()
      interactionType = Interaction_MatchingIndex(interactionType)
      if InteractionCheck(interactionType) then
        return
      end
      Interaction_ButtonPushed(interactionType)
      return
    end
  elseif keycode == __eUiInputType_Interaction0 then
    if buttonCount >= 2 then
      FGlobal_InteractionButtonActionRun(1)
      return
    end
  elseif keycode == __eUiInputType_Interaction1 then
    if buttonCount >= 3 then
      FGlobal_InteractionButtonActionRun(2)
      return
    end
  elseif keycode == __eUiInputType_Interaction2 then
    if buttonCount >= 4 then
      FGlobal_InteractionButtonActionRun(3)
      return
    end
  elseif keycode == __eUiInputType_Interaction3 then
    if buttonCount >= 5 then
      FGlobal_InteractionButtonActionRun(4)
      return
    end
  elseif keycode == __eUiInputType_Interaction4 and buttonCount >= 6 then
    FGlobal_InteractionButtonActionRun(5)
    return
  end
end
local currentInteractionSelectIndex = 0
local currentInteractionKeyPressedTime = 0
local xboxInteractionAvailable = false
local _isInteractionRolling = false
function FGlobal_Interaction_CheckAndGetPressedKeyCode_Xbox(deltaTime)
  FGlobal_Interaction_UpdatePressedInteractionKey(currentInteractionKeyPressedTime)
  if keyCustom_IsDownOnce_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
    currentInteractionKeyPressedTime = 0
    xboxInteractionAvailable = true
  elseif keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
    currentInteractionKeyPressedTime = currentInteractionKeyPressedTime + deltaTime
    if currentInteractionKeyPressedTime > 0.5 then
      if false == xboxInteractionAvailable then
        return nil
      end
      xboxInteractionAvailable = false
      local keyCodeTable = {
        [0] = CppEnums.ActionInputType.ActionInputType_Interaction,
        [1] = __eUiInputType_Interaction0,
        [2] = __eUiInputType_Interaction1,
        [3] = __eUiInputType_Interaction2,
        [4] = __eUiInputType_Interaction3,
        [5] = __eUiInputType_Interaction4,
        [6] = CppEnums.VirtualKeyCode.KeyCode_F10
      }
      local keycode = keyCodeTable[currentInteractionSelectIndex]
      FGlobal_Interaction_ClearSelectIndex()
      return keycode
    end
  elseif keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Interaction) then
    if currentInteractionKeyPressedTime < 0.5 and SHOW_BUTTON_COUNT > 1 then
      _isInteractionRolling = true
    end
    currentInteractionKeyPressedTime = 0
    xboxInteractionAvailable = false
  end
  if true == _isInteractionRolling then
    currentInteractionKeyPressedTime = 0
    FGlobal_Interaction_RollingAnimation(deltaTime)
  end
  return nil
end
function FGlobal_Interaction_CheckAndGetPressedKeyCode()
  local keyCode = CppEnums.ActionInputType.ActionInputType_Interaction
  if keyCustom_IsDownOnce_Action(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction0
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction1
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction2
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction3
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  keyCode = __eUiInputType_Interaction4
  if GlobalKeyBinder_CheckCustomKeyPressed(keyCode) then
    return keyCode
  end
  return nil
end
local _roleCheckTimeAcc = 0
local _rollingTime = 0.5
function FGlobal_Interaction_RollingAnimation(deltaTime)
  local actor = interaction_getInteractable()
  if nil == actor then
    return
  end
  _roleCheckTimeAcc = _roleCheckTimeAcc + deltaTime
  local CIRCLE_RADIUS = 0
  if isTargetNpc then
    _background:SetSize(140, 140)
    BUTTON_OFFSET_X = -18
    BUTTON_OFFSET_Y = 42
    CIRCLE_RADIUS = 60
  else
    _background:SetSize(128, 128)
    BUTTON_OFFSET_X = -25
    BUTTON_OFFSET_Y = 35
    CIRCLE_RADIUS = 50
  end
  local div = 1 / SHOW_BUTTON_COUNT
  local btnIdx = -currentInteractionSelectIndex % SHOW_BUTTON_COUNT
  for ii = 0, #interactionTargetUIList do
    local isShow = Interaction_isSetInteractableFragLua(actor, ii)
    if isShow then
      local ANGLE_OFFSET = math.pi * (2 * btnIdx / SHOW_BUTTON_COUNT - 0.5)
      local buttonPosX = BUTTON_OFFSET_X + CIRCLE_RADIUS * math.cos(math.pi * 2 * div * -(_roleCheckTimeAcc / _rollingTime) + ANGLE_OFFSET)
      local buttonPosY = BUTTON_OFFSET_Y + CIRCLE_RADIUS * math.sin(math.pi * 2 * div * -(_roleCheckTimeAcc / _rollingTime) + ANGLE_OFFSET)
      interactionTargetUIList[ii]:SetPosX(buttonPosX)
      interactionTargetUIList[ii]:SetPosY(buttonPosY)
      _needCollectTool:SetPosX(buttonPosX + 2)
      _needCollectTool:SetPosY(buttonPosY + 2)
      btnIdx = (btnIdx + 1) % SHOW_BUTTON_COUNT
    end
  end
  if _rollingTime < _roleCheckTimeAcc then
    _roleCheckTimeAcc = 0
    FGlobal_Interaction_IncreaseSelectIndex()
    _isInteractionRolling = false
  end
end
function FGlobal_Interaction_IncreaseSelectIndex()
  currentInteractionSelectIndex = (currentInteractionSelectIndex + 1) % SHOW_BUTTON_COUNT
  local CIRCLE_RADIUS = 0
  local actor = interaction_getInteractable()
  if nil == actor then
    return
  end
  if isTargetNpc then
    _background:SetSize(140, 140)
    BUTTON_OFFSET_X = -18
    BUTTON_OFFSET_Y = 42
    CIRCLE_RADIUS = 60
  else
    _background:SetSize(128, 128)
    BUTTON_OFFSET_X = -25
    BUTTON_OFFSET_Y = 35
    CIRCLE_RADIUS = 50
  end
  local ANGLE_OFFSET = math.pi * -0.5
  local jj = -currentInteractionSelectIndex % SHOW_BUTTON_COUNT
  for ii = 0, #interactionTargetUIList do
    local isShow = Interaction_isSetInteractableFragLua(actor, ii)
    if isShow then
      local div = jj / SHOW_BUTTON_COUNT
      local buttonPosX = BUTTON_OFFSET_X + CIRCLE_RADIUS * math.cos(math.pi * 2 * div + ANGLE_OFFSET)
      local buttonPosY = BUTTON_OFFSET_Y + CIRCLE_RADIUS * math.sin(math.pi * 2 * div + ANGLE_OFFSET)
      interactionTargetUIList[ii]:SetPosX(buttonPosX)
      interactionTargetUIList[ii]:SetPosY(buttonPosY)
      _needCollectTool:SetPosX(buttonPosX + 2)
      _needCollectTool:SetPosY(buttonPosY + 2)
      local verticalSize = interactionTargetUIList[ii]:GetSizeY()
      if buttonPosY < BUTTON_OFFSET_Y then
        verticalSize = verticalSize * -0.5
      end
      interactionTargetUIList[ii]:SetTextSpan(0, verticalSize)
      if math.floor(buttonPosX) == math.floor(BUTTON_OFFSET_X) then
        interactionTargetUIList[ii]:SetTextHorizonCenter()
      elseif buttonPosX < BUTTON_OFFSET_X then
        interactionTargetUIList[ii]:SetTextHorizonRight()
      elseif buttonPosX > BUTTON_OFFSET_X then
        interactionTargetUIList[ii]:SetTextHorizonLeft()
      end
      jj = (jj + 1) % SHOW_BUTTON_COUNT
    end
  end
end
function FGlobal_Interaction_ClearSelectIndex()
  currentInteractionSelectIndex = 0
  xboxInteractionAvailable = false
end
function FGlobal_Interaction_UpdatePressedInteractionKey(time)
  if xboxInteractionAvailable then
    if time < 0.2 then
      return
    end
    _circularProgressBarInteraction:SetShow(true)
    _circularProgressBarStaticbgInteraction:SetShow(true)
    UI_NAME:SetShow(false)
  else
    _circularProgressBarInteraction:SetShow(false)
    _circularProgressBarStaticbgInteraction:SetShow(false)
    UI_NAME:SetShow(true)
  end
  _circularProgressBarInteraction:SetProgressRate(time * 200)
end
function Interaction_MatchingIndex(interactionType)
  if 85 == interactionType then
    return CppEnums.InteractionType.InteractionType_GuildDrill
  elseif 87 == interactionType then
    return CppEnums.InteractionType.InteractionType_ReturnRentedMansion
  elseif __eInteractionType_ShowCampingTentUI == interactionType then
    return CppEnums.InteractionType.InteractionType_ShowCampingTentUI
  elseif __eInteractionType_UseCampingTent == interactionType then
    return CppEnums.InteractionType.InteractionType_UseCampingTent
  elseif __eInteractionType_RepairTool == interactionType then
    return CppEnums.InteractionType.InteractionType_RepairTool
  end
  return interactionType
end
function FromClient_Interaction_NotEnoughWp(interactionType, needWp)
  if nil == interactionType or nil == needWp then
    return
  end
  local messageText = ""
  if CppEnums.InteractionType.InteractionType_Greet == interactionType then
    messageText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_NOTENOUGH_WP", "action", PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU26"), "wp", tostring(needWp))
  elseif CppEnums.InteractionType.InteractionType_Steal == interactionType then
    messageText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_NOTENOUGH_WP", "action", PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU27"), "wp", tostring(needWp))
  else
    messageText = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMentalNotEnoughWp")
  end
  if nil ~= messageText and "" ~= messageText then
    Proc_ShowMessage_Ack(messageText)
    if true == PaGlobalFunc_IsRemasterUIOption() then
      if nil ~= PaGlobalFunc_MainStatus_UpdateEnergyEffect then
        PaGlobalFunc_MainStatus_UpdateEnergyEffect()
      end
    elseif nil ~= wpPoint_UpdateEffect then
      wpPoint_UpdateEffect()
    end
  end
end
houseInit()
registerEvent("FromClient_interactionTypeRepairTool", "FromClient_interactionTypeRepairTool")
function FromClient_interactionTypeRepairTool(fromItemEnchantKey, toItemEnchantKey, houseHoldNo, installationNo)
  local fromItemWhereType = CppEnums.ItemWhereType.eInventory
  local fromSlotNo = ToClient_InventoryGetSlotNo(fromItemEnchantKey)
  local fromItemName = ""
  local toItemName = ""
  local fromItemSSW = getItemEnchantStaticStatus(fromItemEnchantKey)
  if nil ~= fromItemSSW then
    fromItemName = fromItemSSW:getName()
  end
  local toItemSSW = getItemEnchantStaticStatus(toItemEnchantKey)
  if nil ~= toItemSSW then
    toItemName = toItemSSW:getName()
  end
  local txt_content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_AUTOREPAIR_TOOL_USE_POP_DES", "repairtoolName", fromItemName, "toolName", toItemName)
  local function funcYes()
    ToClient_requestRepairEnduranceToInstallation(houseHoldNo, installationNo, fromItemWhereType, fromSlotNo)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = txt_content,
    functionYes = funcYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
