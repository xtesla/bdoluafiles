local _panel = Panel_MainStatus_Remaster
local _dangerPanel = Panel_Danger
local MainStatus = {
  _ui = {
    stc_ExpBG = UI.getChildControl(_panel, "Static_ExpBG"),
    progress_Exp = UI.getChildControl(_panel, "CircularProgress_EXP"),
    btn_PVP = UI.getChildControl(_panel, "CheckButton_PvP"),
    stc_HPBG = UI.getChildControl(_panel, "Static_HPBG"),
    progress_HPLater = UI.getChildControl(_panel, "Progress2_HP_Later"),
    stc_injury = UI.getChildControl(_panel, "Static_Injury"),
    progress_HPInjury = nil,
    progress_HP = UI.getChildControl(_panel, "Progress2_HP"),
    hpValue = UI.getChildControl(_panel, "StaticText_HpValue"),
    stc_MPBG = UI.getChildControl(_panel, "Static_MPBG"),
    progress_MPLater = UI.getChildControl(_panel, "Progress2_MP_Later"),
    progress_MP = UI.getChildControl(_panel, "Progress2_MP"),
    mpValue = UI.getChildControl(_panel, "StaticText_MpValue"),
    stc_RageBG = UI.getChildControl(_panel, "Static_RageBG"),
    progress_Rage = UI.getChildControl(_panel, "Progress2_Rage"),
    txt_RageValue = UI.getChildControl(_panel, "StaticText_RageValue"),
    stc_RageLock = UI.getChildControl(_panel, "Static_BlackSpiritLock"),
    txt_SkillPoint = UI.getChildControl(_panel, "StaticText_SkillPoint"),
    txt_EnergyPoint = UI.getChildControl(_panel, "StaticText_EnergyPoint"),
    txt_ContributePoint = UI.getChildControl(_panel, "StaticText_ContributePoint"),
    stc_ClassType0 = UI.getChildControl(_panel, "Static_ClassResourceType0"),
    stc_ClassType1 = UI.getChildControl(_panel, "Static_ClassResourceType1"),
    stc_ClassType2 = UI.getChildControl(_panel, "Static_ClassResourceType2"),
    stc_ClassType3 = UI.getChildControl(_panel, "Static_ClassResourceType3"),
    stc_ClassType_Nova = UI.getChildControl(_panel, "Progress2_NovaResource"),
    stc_ClassType_NovaBG = UI.getChildControl(_panel, "Static_NovaResourceBG"),
    stc_ClassType_Corsair = UI.getChildControl(_panel, "Static_ClassResourceType4"),
    stc_DummyClassType3Effect = nil,
    stc_HPAlert = UI.getChildControl(_dangerPanel, "Static_Alert")
  },
  _statusTooltipType = {
    skill = 0,
    energy = 1,
    contribute = 2,
    resource0 = 3,
    resource1 = 4,
    blackSpirit = 5,
    pvp = 6,
    injury = 7,
    resource2 = 8,
    resource3 = 9,
    resource4 = 10,
    resourceCorsairBomb = 11,
    resourceCorsairBazooka = 12,
    resourceCorsairCannon = 13
  },
  _contributeUsePoint = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_1"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_2"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_3")
  },
  _lastLevel = 0,
  _isSixteenLV = false,
  _lastSkillPoint = -1,
  _lastExplorePoint = 0,
  _lastRemainExplorePoint = 0,
  _lastContRate = 0,
  _isFirstExplore = false,
  _lastWP = -1,
  _prevHpAlertTime = 0,
  _prevHP = 0,
  _prevMaxHP = 0,
  _prevInjuryHP = 0,
  _alertHpValue = 40,
  _strongMonsterAlert = false,
  _prevMP = 0,
  _prevMaxMP = 0,
  _isPvPOn = true,
  _maxType0Count = 3,
  _maxType1Count = 3,
  _maxType2Count = 3,
  _maxType3Count = 3,
  _maxTypeCorsairCount = 3,
  _resourceType0 = {},
  _resourceType1 = {},
  _resourceType2 = {},
  _resourceType3 = {},
  _resourceTypeCorsair = {},
  _classResourceShowCheck = {
    [1] = false,
    [2] = false,
    [3] = false
  },
  _oldCharacter = false,
  _levelUpQuestClear = false,
  _isSuccessionOpen = {
    _meahwa = ToClient_IsContentsGroupOpen("1373"),
    _sorcerer = ToClient_IsContentsGroupOpen("1369")
  },
  _novaEffectTime = 0,
  _maxNovaEffectTime = 0.01,
  _isNovaProgressUp = false,
  _curNovaProgress = 0,
  _maxNovaProgress = 0,
  _isNovaEffectUpdate = false
}
function MainStatus:init()
  if true == _ContentsGroup_UsePadSnapping then
    _dangerPanel:SetOffsetIgnorePanel(true)
    _dangerPanel:ComputePos()
  end
  self._ui.txt_LV = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_Lv")
  self._ui.txt_EXP = UI.getChildControl(self._ui.stc_ExpBG, "StaticText_EXP")
  self._ui.progress_HPInjury = UI.getChildControl(self._ui.stc_injury, "Progress2_HP_Injury")
  self._ui.txt_ResourceCount = UI.getChildControl(self._ui.stc_ClassType0, "StaticText_Count")
  self._ui.txt_ResourceCount2 = UI.getChildControl(self._ui.stc_ClassType2, "StaticText_Count")
  self._ui.stc_ClassType_NovaIcon = UI.getChildControl(self._ui.stc_ClassType_NovaBG, "Static_1")
  if true == self._isSuccessionOpen._sorcerer then
    local bg = UI.getChildControl(self._ui.stc_ClassType0, "Static_Bg1")
    local gabX = bg:GetSizeX() + 5
    self._maxType0Count = 4
    self._ui.txt_ResourceCount:SetSpanSize(self._ui.txt_ResourceCount:GetSpanSize().x + gabX, self._ui.txt_ResourceCount:GetSpanSize().y)
  end
  for idx = 1, self._maxType0Count do
    local bg = UI.getChildControl(self._ui.stc_ClassType0, "Static_Bg" .. idx)
    local element = UI.getChildControl(self._ui.stc_ClassType0, "Static_Element" .. idx)
    self._resourceType0[idx] = {}
    self._resourceType0[idx].bg = bg
    self._resourceType0[idx].element = element
    self._resourceType0[idx].bg:SetShow(true)
  end
  for idx = 1, self._maxType1Count do
    local type1bg = UI.getChildControl(self._ui.stc_ClassType1, "Static_Bg" .. idx)
    local type1element = UI.getChildControl(self._ui.stc_ClassType1, "Static_Element" .. idx)
    self._resourceType1[idx] = {}
    self._resourceType1[idx].bg = type1bg
    self._resourceType1[idx].element = type1element
  end
  for idx = 1, self._maxType2Count do
    local type2bg = UI.getChildControl(self._ui.stc_ClassType2, "Static_Bg" .. idx)
    local type2element = UI.getChildControl(self._ui.stc_ClassType2, "Static_Element" .. idx)
    self._resourceType2[idx] = {}
    self._resourceType2[idx].bg = type2bg
    self._resourceType2[idx].element = type2element
  end
  for idx = 1, self._maxType3Count do
    local type3bg = UI.getChildControl(self._ui.stc_ClassType3, "Static_Bg" .. idx)
    local type3element = UI.getChildControl(self._ui.stc_ClassType3, "Static_Element" .. idx)
    self._resourceType3[idx] = {}
    self._resourceType3[idx].bg = type3bg
    self._resourceType3[idx].element = type3element
  end
  self._ui.stc_DummyClassType3Effect = UI.getChildControl(self._ui.stc_ClassType3, "Static_Dummy")
  for idx = 1, self._maxTypeCorsairCount do
    local typeCorsairbg = UI.getChildControl(self._ui.stc_ClassType_Corsair, "Static_Bg" .. idx)
    local typeCorsairElement = UI.getChildControl(self._ui.stc_ClassType_Corsair, "Static_Element" .. idx)
    self._resourceTypeCorsair[idx] = {}
    self._resourceTypeCorsair[idx].bg = typeCorsairbg
    self._resourceTypeCorsair[idx].element = typeCorsairElement
  end
  self._ui.stc_DummyClassTypeCorsairEffect = UI.getChildControl(self._ui.stc_ClassType_Corsair, "Static_Dummy")
  if true == ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eBlackSpiritSkillOnOff) and getSelfPlayer():isUseableBlackSpritSkill() ~= ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eBlackSpiritSkillOnOff) then
    requestBlackSpritSkill()
  end
  self:addStatusEffect()
  self:setMPBarTexture()
  self:registEventHandler()
  self._isNovaEffectUpdate = false
  self._ui.stc_ClassType_NovaBG:EraseAllEffect()
  if nil ~= Panel_MainStatus_Remaster then
    Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
  end
  PaGlobalFunc_MainStatus_QuestCheck()
  self:updateAll()
  PaGlobalFunc_MainStatus_SetShow(true)
  MainStatus:unRenderPanel()
end
function MainStatus:registEventHandler()
  self._ui.btn_PVP:addInputEvent("Mouse_LUp", "PaGlobalFunc_MainStatus_RequestTogglePvP()")
  self._ui.btn_PVP:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.pvp .. ")")
  self._ui.btn_PVP:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  if _ContentsGroup_BlackSpiritLock then
    if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
      self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_BlackSpiritSkillLock_All_Open(1)")
    else
      self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "FGlobal_BlackSpiritSkillLock_Open(1)")
    end
  else
    self._ui.stc_RageBG:addInputEvent("Mouse_LUp", "requestBlackSpritSkill()")
  end
  self._ui.stc_RageBG:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.blackSpirit .. ")")
  self._ui.stc_RageBG:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassType0:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource0 .. ")")
  self._ui.stc_ClassType0:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassType1:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource1 .. ")")
  self._ui.stc_ClassType1:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassType2:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource2 .. ")")
  self._ui.stc_ClassType2:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassType3:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource3 .. ")")
  self._ui.stc_ClassType3:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.stc_ClassType_NovaIcon:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resource4 .. ")")
  self._ui.stc_ClassType_NovaIcon:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.txt_SkillPoint:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.skill .. ")")
  self._ui.txt_SkillPoint:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  if nil ~= PaGlobalFunc_SkillGroup_Open then
    self._ui.txt_SkillPoint:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_Open()")
  end
  self._ui.txt_EnergyPoint:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.energy .. ")")
  self._ui.txt_EnergyPoint:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._ui.txt_ContributePoint:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.contribute .. ")")
  self._ui.txt_ContributePoint:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[1].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairBomb .. ")")
  self._resourceTypeCorsair[1].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[2].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairBazooka .. ")")
  self._resourceTypeCorsair[2].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  self._resourceTypeCorsair[3].bg:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.resourceCorsairCannon .. ")")
  self._resourceTypeCorsair[3].bg:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
  registerEvent("EventCharacterInfoUpdate", "PaGlobalFunc_MainStatus_UpdateAll")
  registerEvent("FromClient_SelfPlayerHpChanged", "PaGlobalFunc_MainStatus_UpdateHP")
  registerEvent("FromClient_ReplayHpChanged", "PaGlobalFunc_MainStatus_UpdateReplayHP")
  registerEvent("FromClient_ReplayMpChanged", "PaGlobalFunc_MainStatus_UpdateReplayMP")
  registerEvent("FromClient_SetReplayLevel", "PaGlobalFunc_MainStatus_UpdateReplayLevel")
  if true == _ContentsGroup_InjuryPercent then
    self._ui.stc_injury:addInputEvent("Mouse_On", "InputMO_MainStatus_TooltipShow(true, " .. self._statusTooltipType.injury .. ")")
    self._ui.stc_injury:addInputEvent("Mouse_Out", "InputMO_MainStatus_TooltipShow(false)")
    registerEvent("FromClient_SelfPlayerInjuryHpChanged", "PaGlobalFunc_MainStatus_UpdateInjuryHP")
  end
  registerEvent("FromClient_SelfPlayerMpChanged", "PaGlobalFunc_MainStatus_UpdateMP")
  registerEvent("FromClient_SelfPlayerExpChanged", "PaGlobalFunc_MainStatus_UpdateEXP")
  registerEvent("EventSelfPlayerLevelUp", "PaGlobalFunc_MainStatus_UpdateLV")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "PaGlobalFunc_MainStatus_UpdateEXP")
  registerEvent("subResourceChanged", "PaGlobalFunc_MainStatus_UpdateResource")
  registerEvent("FromClient_WpChanged", "PaGlobalFunc_MainStatus_UpdateEnergy")
  registerEvent("FromClient_UpdateExplorePoint", "PaGlobalFunc_MainStatus_UpdateContribute")
  registerEvent("FromClient_UpdateAdrenalin", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_ChangeAdrenalinMode", "PaGlobalFunc_MainStatus_UpdateRage")
  registerEvent("FromClient_UseableBlackSpritSkill", "FromClient_MainStatus_BlackSpiritLock")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_MainStatus_CheckHpAlertPostEvent")
  registerEvent("EventPvPModeChanged", "PaGlobalFunc_MainStatus_PVPModeChange")
  registerEvent("EventPlayerPvPAbleChanged", "PaGlobalFunc_MainStatus_PVPAbleChange")
  registerEvent("onScreenResize", "FromClient_MainStatus_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "FromClient_MainStatus_OnResize")
  registerEvent("FromClient_notifyUpdateGrowStep", "FromClient_notifyUpdateGrowStep_MainStatus")
end
function PaGlobalFunc_MainStatus_RequestTogglePvP()
  if false == _ContentsGroup_sheriff then
    requestTogglePvP()
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  if true == getPvPMode() then
    requestTogglePvP()
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if 2 == userType then
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FORCEATTACK_NEWBIE_WARNING_MSG")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = requestTogglePvP,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    requestTogglePvP()
  end
end
function MainStatus:addStatusEffect()
  self._ui.progress_HP:EraseAllEffect()
  self._ui.progress_Rage:EraseAllEffect()
  self._ui.stc_RageBG:EraseAllEffect()
  self._ui.progress_HP:AddEffect("UI_Hp_Bar01A", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar01B", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar02A", true, 0, 0)
  self._ui.progress_HP:AddEffect("UI_Hp_Bar02B", true, 0, 0)
  self._ui.progress_HP:AddEffect("fUI_Hp_Bar01", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar01A", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar02A", true, 0, 0)
  self._ui.progress_Rage:AddEffect("UI_Rage_Bar02B", true, 0, 0)
  self._ui.progress_Rage:AddEffect("fUI_Rage_Bar01", true, 0, 0)
  self._ui.stc_RageBG:AddEffect("fN_DarkSpirit_Gage_01A", true, -107, 0)
end
function MainStatus:unRenderPanel()
  if nil == Panel_MainStatus_Remaster then
    _PA_ASSERT_NAME(false, "Panel_MainStatus_Remaster\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\234\185\128\234\183\188\236\154\176")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing)
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_MainStatus_Remaster:SetRenderAndEventHide(true)
  else
    Panel_MainStatus_Remaster:SetRenderAndEventHide(false)
  end
end
function PaGlobalFunc_MainStatus_SetMPBarTexture()
  if false == _panel:GetShow() then
    return
  end
  MainStatus:setMPBarTexture()
end
function MainStatus:setMPBarTexture()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local classType = selfPlayer:getClassType()
  self._ui.progress_MP:EraseAllEffect()
  self._ui.progress_MP:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_03.dds")
  self._ui.progress_MPLater:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_03.dds")
  if classType == __eClassType_Warrior or classType == __eClassType_Giant or classType == __eClassType_Lhan or classType == __eClassType_Combattant or classType == __eClassType_Mystic or classType == __eClassType_BladeMaster or classType == __eClassType_BladeMasterWoman or classType == __eClassType_Kunoichi or classType == __eClassType_KunoichiOld or classType == __eClassType_NinjaMan or classType == __eClassType_Guardian then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 452, 161, 476)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 477, 325, 501)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_Bar01", true, 0, 0)
  elseif classType == __eClassType_Sorcerer or classType == __eClassType_WizardWoman or classType == __eClassType_WizardMan or classType == __eClassType_Tamer or classType == __eClassType_Hashashin or classType == __eClassType_ReservedBlackSpirit or classType == __eClassType_Sorcerer_Reserved1 then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 377, 161, 401)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 377, 325, 401)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_B_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_B_Bar01", true, 0, 0)
  elseif classType == __eClassType_ElfRanger or classType == __eClassType_RangerMan or classType == __eClassType_ShyWaman then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 402, 161, 426)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 402, 325, 426)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_G_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_G_Bar01", true, 0, 0)
  elseif classType == __eClassType_Valkyrie or classType == __eClassType_Nova then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 477, 161, 501)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 477, 325, 501)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_W_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_W_Bar01", true, 0, 0)
  elseif classType == __eClassType_DarkElf then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 5, 427, 161, 451)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MPLater, 169, 427, 325, 451)
    self._ui.progress_MPLater:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MPLater:setRenderTexture(self._ui.progress_MPLater:getBaseTexture())
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar01A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar01B", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar02A", true, 0, 0)
    self._ui.progress_MP:AddEffect("UI_Mp_P_Bar02B", true, 0, 0)
    self._ui.progress_MP:AddEffect("fUI_Mp_P_Bar01", true, 0, 0)
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 1 == isColorBlindMode or 2 == isColorBlindMode then
    self._ui.progress_HP:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_02.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.progress_HP, 1, 471, 156, 507)
    self._ui.progress_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui.progress_HP:setRenderTexture(self._ui.progress_HP:getBaseTexture())
    self._ui.progress_MP:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_02.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.progress_MP, 157, 483, 313, 507)
    self._ui.progress_MP:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.progress_MP:setRenderTexture(self._ui.progress_MP:getBaseTexture())
  else
    self._ui.progress_HP:ChangeTextureInfoName("Renewal/Progress/Console_Progressbar_03.dds")
    local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._ui.progress_HP, 6, 315, 161, 351)
    self._ui.progress_HP:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
    self._ui.progress_HP:setRenderTexture(self._ui.progress_HP:getBaseTexture())
  end
end
function MainStatus:updateAll()
  self:updateLV()
  self:updateEXP()
  self:updateHP()
  self:updateMP()
  self:updateRage()
  self:updateResource()
  self:updateSkillPoint()
  self:updateContribute()
  self:updateEnergy()
  self:updatePvP()
  self:updateInjuryHP()
end
function MainStatus:updateLV()
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  self._ui.txt_LV:SetText(tostring(player:get():getLevel()))
  if self._lastLevel < player:get():getLevel() and 0 ~= self._lastLevel then
    self._ui.txt_LV:EraseAllEffect()
    self._ui.txt_LV:AddEffect("fUI_NewSkill01", false, 0, 0)
    self._ui.txt_LV:AddEffect("UI_NewSkill01", false, 0, 0)
  end
  local inMyLevel = player:get():getLevel()
  if 16 == inMyLevel and false == self._isSixteenLV then
    self._isSixteenLV = true
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "PANEL_SELFPLAYEREXPGAGE_LEVEL_WEATHERCHECK"))
  end
  self._lastLevel = player:get():getLevel()
end
function MainStatus:updateEXP()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local s64_needExp = player:getNeedExp_s64()
  local s64_exp = player:getExp_s64()
  local _const = Defines.s64_const
  local rate = 0
  local rateDisplay = 0
  local stringS64Exp = tostring64(s64_exp)
  local stringS64NeedExp = tostring64(s64_needExp)
  rate = tonumber(stringS64Exp) * 1000 * 100 / tonumber(stringS64NeedExp)
  local real_rate = rate / 1000
  if 100 == real_rate then
    rateDisplay = "100.000%"
  elseif 0 == real_rate then
    rateDisplay = "0.000%"
  elseif real_rate == real_rate - real_rate % 1 then
    rateDisplay = real_rate .. ".000%"
  elseif real_rate == real_rate - real_rate % 0.1 then
    rateDisplay = real_rate .. "00%"
  elseif real_rate == real_rate - real_rate % 0.01 then
    rateDisplay = real_rate .. "0%"
  else
    rateDisplay = real_rate .. "%"
  end
  self._ui.progress_Exp:SetProgressRate(real_rate)
  self._ui.stc_ExpBG:AddEffect("UI_Exp_Bar01", false, 3.1, -1)
  self._ui.txt_EXP:ComputePos()
  self._ui.txt_EXP:SetText(string.format("%.3f", real_rate) .. "%")
  if not self._levelUpQuestClear and 49 <= player:getLevel() and player:getLevel() < 60 then
    if self._oldCharacter then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_YESLIMIT_NOBOSS"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MAXLEVELUP_NOLIMIT_YESBOSS"))
    end
  end
end
function MainStatus:updateInjuryHP()
  local player = getSelfPlayer():get()
  if nil == player then
    return
  end
  if false == _ContentsGroup_InjuryPercent then
    return
  end
  local maxHp = math.floor(player:getMaxHp())
  local injuryHp = math.floor(player:getInjuryHp())
  if self._prevInjuryHP == injuryHp then
    return
  end
  if injuryHp >= 0 then
    self._prevInjuryHP = injuryHp
    local injuryRate = injuryHp / maxHp * 100
    self._ui.progress_HPInjury:SetProgressRate(injuryRate)
    self._ui.stc_injury:SetSize(self._ui.progress_HPInjury:GetSizeX() * injuryRate / 100, self._ui.progress_HPInjury:GetSizeY())
    self._ui.stc_injury:ComputePos()
    self._ui.progress_HPInjury:ComputePos()
  end
end
function MainStatus:updateHP()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local regionKeyRaw = selfPlayer:getRegionKeyRaw()
  local regionWrapper = getRegionInfoWrapper(regionKeyRaw)
  local isArenaZone = regionWrapper:get():isArenaZone()
  if nil == player then
    return
  end
  local hp = math.floor(player:getHp())
  local maxHp = math.floor(player:getMaxHp())
  local minorSiegeMaxHp = maxHp
  local newMaxHp = math.floor(player:getMaxHpInMinorSiege())
  if newMaxHp > 0 and minorSiegeMaxHp > newMaxHp then
    minorSiegeMaxHp = newMaxHp
  end
  local percentHp = math.floor(hp / minorSiegeMaxHp * 100)
  self._percentHP = percentHp
  self:checkHpAlertPostEvent()
  if true == _panel:GetShow() and percentHp < 20 and hp < self._prevHP and self._prevHpAlertTime + 20 <= FGlobal_getLuaLoadTime() and not isArenaZone then
    local sendMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_HP_WARNING"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_HP_WARNING_SUB"),
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(sendMsg, 3, 24)
    self._prevHpAlertTime = FGlobal_getLuaLoadTime()
  end
  local effectSizeX = 185
  local effectPosX = 0
  local baseX = self._ui.stc_HPBG:GetSizeX()
  if 0 ~= maxHp and hp ~= self._prevHP or maxHp ~= self._prevMaxHP then
    self._ui.progress_HP:SetProgressRate(hp / maxHp * 100)
    self._ui.progress_HPLater:SetProgressRate(hp / maxHp * 100)
    self._prevHP = hp
    self._prevMaxHP = maxHp
    self:checkHpAlert(hp, minorSiegeMaxHp, false)
  end
  self._ui.hpValue:SetText(hp .. " / " .. maxHp)
end
function MainStatus:updateReplayHP()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  local hp = math.floor(player:get():getHp())
  local maxHp = math.floor(player:get():getMaxHp())
  local percentHp = math.floor(hp / maxHp * 100)
  self._percentHP = percentHp
  self:checkHpAlertPostEvent()
  local effectSizeX = 185
  local effectPosX = 0
  local baseX = self._ui.stc_HPBG:GetSizeX()
  if 0 ~= maxHp and hp ~= self._prevHP or maxHp ~= self._prevMaxHP then
    self._ui.progress_HP:SetProgressRate(hp / maxHp * 100)
    self._ui.progress_HPLater:SetProgressRate(hp / maxHp * 100)
    self._prevHP = hp
    self._prevMaxHP = maxHp
    self:checkHpAlert(hp, maxHp, false)
  end
  self._ui.hpValue:SetText(hp .. " / " .. maxHp)
end
function MainStatus:updateReplayMP()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  local mp = player:get():getMp()
  local maxMp = player:get():getMaxMp()
  local effectSizeX = 185
  local effectPosX = 0
  if 0 ~= maxMp and (mp ~= self._prevMP or maxMp ~= self._prevMaxMP) then
    self._ui.progress_MP:SetProgressRate(mp / maxMp * 100)
    self._ui.progress_MPLater:SetProgressRate(mp / maxMp * 100)
    self._prevMP = mp
    self._prevMaxMP = maxMp
    effectPosX = self._ui.stc_MPBG:GetSizeX() * mp / maxMp - effectSizeX
  end
  self._ui.mpValue:SetText(mp .. " / " .. maxMp)
  FGlobal_SettingMpBarTemp()
end
function MainStatus:updateReplayLevel()
  local isReplayObserver = ToClient_IsReplayObserver()
  if false == isReplayObserver then
    return
  end
  local player = getPlayerActor(ToClient_getObserverPlayerActorKey())
  if nil == player then
    return
  end
  self._ui.txt_LV:SetText(tostring(player:get():getLevel()))
end
function MainStatus:checkHpAlertPostEvent()
  if self._alertHpValue < self._percentHP then
    self._ui.stc_HPAlert:SetShow(false)
    _dangerPanel:SetShow(false)
  else
    self._ui.stc_HPAlert:SetShow(true)
    _dangerPanel:SetShow(true)
    _dangerPanel:ComputePos()
    self._ui.stc_HPAlert:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  end
end
function MainStatus:checkHpAlert(hp, maxHp, isLevelUp)
  local isUpdate = Defines.UIMode.eUIMode_Default == GetUIMode()
  if false == isLevelUp then
    return
  end
  local totalHp = hp / maxHp * 100
  if totalHp >= 40 and false == self._strongMonsterAlert then
    _dangerPanel:SetShow(false, false)
    self._ui.stc_HPAlert:SetAlpha(0)
  end
  if totalHp <= 39 and totalHp >= 20 then
    if false == _dangerPanel:GetShow() then
      _dangerPanel:SetShow(true, false)
      self._ui.stc_HPAlert:SetAlpha(1)
    end
    if false == self._ui.stc_HPAlert:GetShow() then
      self._ui.stc_HPAlert:SetShow(true)
    end
    self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger0", true)
  end
  if totalHp <= 19 and totalHp >= 0 then
    if false == _dangerPanel:GetShow() then
      _dangerPanel:SetShow(true, false)
      self._ui.stc_HPAlert:SetAlpha(1)
    end
    if false == self._ui.stc_HPAlert:GetShow() then
      self._ui.stc_HPAlert:SetShow(true)
    end
    self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger1", true)
  end
end
function MainStatus:updateMP()
  local player = getSelfPlayer():get()
  local mp = player:getMp()
  local maxMp = player:getMaxMp()
  local effectSizeX = 185
  local effectPosX = 0
  if 0 ~= maxMp and (mp ~= self._prevMP or maxMp ~= self._prevMaxMP) then
    self._ui.progress_MP:SetProgressRate(mp / maxMp * 100)
    self._ui.progress_MPLater:SetProgressRate(mp / maxMp * 100)
    self._prevMP = mp
    self._prevMaxMP = maxMp
    effectPosX = self._ui.stc_MPBG:GetSizeX() * mp / maxMp - effectSizeX
  end
  self._ui.mpValue:SetText(mp .. " / " .. maxMp)
  FGlobal_SettingMpBarTemp()
end
function MainStatus:updateRage()
  local selfPlayer = getSelfPlayer()
  local adrenallin = selfPlayer:getAdrenalin()
  adrenallin = adrenallin / 10
  adrenallin = math.floor(adrenallin) / 10
  adrenallin = string.format("%.1f", adrenallin)
  self._ui.progress_Rage:SetProgressRate(adrenallin)
  self._ui.txt_RageValue:SetText(tostring(adrenallin) .. " %")
  local isAdrenalin = selfPlayer:isEnableAdrenalin()
  local isGrowStep = true
  if true == _ContentsGroup_GrowStep then
    isGrowStep = ToClient_IsGrowStepOpen(__eGrowStep_maxAdrenalin)
  end
  self._ui.stc_RageBG:SetShow(isAdrenalin and not isRecordMode and isGrowStep)
  self._ui.progress_Rage:SetShow(isAdrenalin and not isRecordMode and isGrowStep)
  self._ui.txt_RageValue:SetShow(isAdrenalin and not isRecordMode and isGrowStep)
  local isUseRage = getSelfPlayer():isUseableBlackSpritSkill()
  self._ui.stc_RageLock:SetShow(isAdrenalin and not isUseRage)
end
function MainStatus:updateResource()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  self._ui.stc_ClassType0:SetShow(false)
  self._ui.stc_ClassType1:SetShow(false)
  self._ui.stc_ClassType2:SetShow(false)
  self._ui.stc_ClassType3:SetShow(false)
  self._ui.stc_ClassType_Nova:SetShow(false)
  self._ui.stc_ClassType_NovaBG:SetShow(false)
  self._ui.stc_ClassType_NovaIcon:SetShow(false)
  self._ui.stc_ClassType_Corsair:SetShow(false)
  local classType = selfPlayerWrapper:getClassType()
  if __eClassType_Sorcerer == classType then
    self._ui.stc_ClassType0:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxType0Count do
      self._resourceType0[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceType0[idx].element:EraseAllEffect()
        self._resourceType0[idx].element:AddEffect("UI_Button_Hide", false, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
    self._ui.txt_ResourceCount:SetText(resourceCount)
    self._ui.txt_ResourceCount:useGlowFont(true, "BaseFont_12_Glow", 4278190080)
    self._ui.txt_ResourceCount:SetShow(true)
  elseif __eClassType_Combattant == classType or __eClassType_Mystic == classType then
    self._ui.stc_ClassType1:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxType1Count do
      self._resourceType1[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceType1[idx].element:EraseAllEffect()
        self._resourceType1[idx].element:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
  elseif __eClassType_ShyWaman == classType then
    self._ui.stc_ClassType2:SetShow(true)
    local resourceCount = selfPlayer:getSubResourcePoint()
    local showCount = math.floor(resourceCount / 10)
    for idx = 1, self._maxType2Count do
      self._resourceType2[idx].element:SetShow(idx <= showCount)
      if not self._classResourceShowCheck[idx] and idx <= showCount then
        self._resourceType2[idx].element:EraseAllEffect()
        self._resourceType2[idx].element:AddEffect("fUI_PLW_Energy_01E", true, 0, 0)
      end
      self._classResourceShowCheck[idx] = idx <= showCount
    end
    self._ui.txt_ResourceCount2:SetText(resourceCount)
    self._ui.txt_ResourceCount2:useGlowFont(true, "BaseFont_12_Glow", 4278190080)
    self._ui.txt_ResourceCount2:SetShow(true)
  elseif __eClassType_BladeMasterWoman == classType then
    if false == self._isSuccessionOpen._meahwa then
      return
    end
    local skillType = ToClient_GetSelfPlayerSkillType()
    if __eSkillTypeParam_Inherit == skillType then
      self._ui.stc_ClassType3:SetShow(true)
    end
    local resourceCount = selfPlayer:getSubResourcePoint()
    for idx = 1, self._maxType3Count do
      self._resourceType3[idx].element:SetShow(idx <= resourceCount)
      if not self._classResourceShowCheck[idx] and idx <= resourceCount then
        self._resourceType3[idx].element:EraseAllEffect()
        self._resourceType3[idx].element:AddEffect("fUI_PKW_UP_Icon_03A", true, 0, 0)
        audioPostEvent_SystemUi(2, 5)
      end
      self._classResourceShowCheck[idx] = idx <= resourceCount
    end
    if true == self._ui.stc_ClassType3:GetShow() and resourceCount >= 2 then
      local remainTime = PaGlobalAppliedBuffList:GetMaehwaBuff_RemainTime()
      if remainTime > -1 then
        self._ui.stc_DummyClassType3Effect:EraseAllEffect()
        self._ui.stc_DummyClassType3Effect:AddEffect("fUI_PKW_UP_Icon_04A", false, 0, 0)
        audioPostEvent_SystemUi(2, 6)
        luaTimer_AddEvent(Panel_MainStatus_Remaster_PlayMaehwabuffSound, remainTime, false, 0)
      end
    end
  elseif __eClassType_Nova == classType then
    local skillType = ToClient_GetSelfPlayerSkillType()
    if __eSkillTypeParam_Awaken == skillType and true == ToClient_IsContentsGroupOpen("1466") then
      self._ui.stc_ClassType_Nova:SetShow(true)
      self._ui.stc_ClassType_NovaBG:SetShow(true)
      self._ui.stc_ClassType_NovaIcon:SetShow(true)
      local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
      if maxResourceCount > 0 then
        local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
        local showCount = resourceCount / maxResourceCount * 100
        if showCount > 100 then
          showCount = 100
        end
        self._novaEffectTime = self._maxNovaEffectTime
        self._isNovaProgressUp = showCount >= self._maxNovaProgress
        self._maxNovaProgress = showCount
        self._ui.stc_ClassType_NovaIcon:EraseAllEffect()
        if showCount >= 100 then
          self._ui.stc_ClassType_NovaIcon:AddEffect("fUI_PPW_ARO_Icon_02A", true, 0, 0)
        end
        if true == self._isNovaProgressUp then
          if nil ~= Panel_MainStatus_Remaster then
            Panel_MainStatus_Remaster:RegisterUpdateFunc("Panel_MainStatus_Remaster_UpdateNovaProgress")
          end
        else
          if nil ~= Panel_MainStatus_Remaster then
            Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
          end
          if 1 > self._maxNovaProgress then
            self._isNovaEffectUpdate = false
            self._ui.stc_ClassType_NovaBG:EraseAllEffect()
            self._curNovaProgress = 0
            self._maxNovaProgress = 0
          else
            self._curNovaProgress = self._maxNovaProgress
            if false == self._isNovaEffectUpdate then
              self._isNovaEffectUpdate = true
              self._ui.stc_ClassType_NovaBG:AddEffect("fUI_test_Box", true, 0, 0)
            end
          end
          self._ui.stc_ClassType_Nova:SetProgressRate(self._curNovaProgress)
        end
      end
    else
      self._ui.stc_ClassType_NovaBG:EraseAllEffect()
      self._ui.stc_ClassType_NovaIcon:EraseAllEffect()
      self._ui.stc_ClassType_Nova:SetShow(false)
      self._ui.stc_ClassType_NovaBG:SetShow(false)
      self._ui.stc_ClassType_NovaIcon:SetShow(false)
      Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
    end
  elseif __eClassType_Sorcerer_Reserved1 == classType then
    local skillType = ToClient_GetSelfPlayerSkillType()
    if __eSkillTypeParam_Awaken ~= skillType or false == ToClient_IsContentsGroupOpen("1590") then
      self._ui.stc_ClassType_Corsair:SetShow(false)
      return
    end
    self._ui.stc_ClassType_Corsair:SetShow(true)
    local resourceType = selfPlayer:getSubResourcePoint()
    for idx = 1, self._maxTypeCorsairCount do
      self._resourceTypeCorsair[idx].element:EraseAllEffect()
      if idx == resourceType + 1 then
        self._resourceTypeCorsair[idx].element:SetShow(true)
        if false == self._classResourceShowCheck[idx] then
          if 0 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_01B", true, 0, 0)
          elseif 1 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_02B", true, 0, 0)
          elseif 2 == resourceType then
            self._resourceTypeCorsair[idx].element:AddEffect("fUI_PFW_ARO_Icon_03B", true, 0, 0)
          end
        end
        self._classResourceShowCheck[idx] = true
      else
        self._resourceTypeCorsair[idx].element:SetShow(false)
        self._classResourceShowCheck[idx] = false
      end
    end
  end
end
function Panel_MainStatus_Remaster_UpdateNovaProgress(deltaTime)
  if nil == Panel_MainStatus_Remaster then
    return
  end
  MainStatus._novaEffectTime = MainStatus._novaEffectTime + deltaTime
  if MainStatus._maxNovaEffectTime < MainStatus._novaEffectTime then
    MainStatus._novaEffectTime = 0
    if true == MainStatus._isNovaProgressUp then
      MainStatus._curNovaProgress = MainStatus._curNovaProgress + 1
      if MainStatus._maxNovaProgress <= MainStatus._curNovaProgress then
        MainStatus._curNovaProgress = MainStatus._maxNovaProgress
        Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
      end
      MainStatus._ui.stc_ClassType_Nova:SetProgressRate(MainStatus._curNovaProgress)
    else
      Panel_MainStatus_Remaster:ClearUpdateLuaFunc()
    end
  end
end
function Panel_MainStatus_Remaster_PlayMaehwabuffSound()
  audioPostEvent_SystemUi(2, 7)
end
function Panel_MainStatus_Remaster_MaeHwaResourceHide()
  if nil ~= MainStatus._ui.stc_ClassType3 and false == MainStatus._ui.stc_ClassType3:GetShow() then
    return
  end
  MainStatus._ui.stc_ClassType3:SetShow(false)
end
function Panel_MainStatus_Remaster_MaeHwaResourceShow()
  if false == MainStatus._isSuccessionOpen._meahwa then
    return
  end
  if nil ~= MainStatus._ui.stc_ClassType3 and true == MainStatus._ui.stc_ClassType3:GetShow() then
    return
  end
  MainStatus._ui.stc_ClassType3:SetShow(true)
end
function Panel_MainStatus_Remaster_SetNovaResourceShow(isShow)
  if nil == MainStatus._ui.stc_ClassType_Nova then
    return
  end
  if false == ToClient_IsContentsGroupOpen("1466") then
    MainStatus._ui.stc_ClassType_Nova:SetShow(false)
    MainStatus._ui.stc_ClassType_NovaBG:SetShow(false)
    MainStatus._ui.stc_ClassType_NovaIcon:SetShow(false)
    return
  end
  if isShow == MainStatus._ui.stc_ClassType_Nova:GetShow() then
    return
  end
  MainStatus._ui.stc_ClassType_Nova:SetShow(isShow)
  MainStatus._ui.stc_ClassType_NovaBG:SetShow(isShow)
  MainStatus._ui.stc_ClassType_NovaIcon:SetShow(isShow)
end
function Panel_MainStatus_Remaster_SetCorsairResourceShow(isShow)
  if nil == MainStatus._ui.stc_ClassType_Corsair then
    return
  end
  if false == ToClient_IsContentsGroupOpen("1590") then
    MainStatus._ui.stc_ClassType_Corsair:SetShow(false)
    return
  end
  MainStatus._ui.stc_ClassType_Corsair:SetShow(isShow)
end
function MainStatus:updateSkillPoint()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local skillExpRate = 0
  local skillPointNeedExp
  skillPointNeedExp = player:getSkillPointNeedExperience()
  if 0 ~= skillPointNeedExp then
    skillExpRate = player:getSkillPointExperience() / skillPointNeedExp
  end
  if self._lastSkillPoint < player:getRemainSkillPoint() and -1 ~= self._lastSkillPoint then
    audioPostEvent_SystemUi(3, 7)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSkillIconCheck, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    self._ui.txt_SkillPoint:EraseAllEffect()
    self._ui.txt_SkillPoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
    self._ui.txt_SkillPoint:AddEffect("fUI_LevelUP_Skill02", false, 0, 0)
  end
  local skillPoint = tostring(player:getRemainSkillPoint())
  skillExpRate = skillExpRate * 100
  local skillPointExp = string.format("%.1f", skillExpRate)
  self._ui.txt_SkillPoint:SetText(skillPoint .. " (" .. skillPointExp .. "%)")
  self._ui.txt_SkillPoint:SetFontColor(4294899677)
  self._ui.txt_SkillPoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  self._lastSkillPoint = player:getRemainSkillPoint()
  if false == _ContentsGroup_RenewUI_Skill then
    enableSkill_UpdateData()
  end
end
function MainStatus:updateContribute()
  if true == ToClient_IsGrowStepOpen(__eGrowStep_explorePoint) then
    self._ui.txt_ContributePoint:SetShow(true)
  else
    self._ui.txt_ContributePoint:SetShow(false)
    return
  end
  local territoryKeyRaw = ToClient_getDefaultTerritoryKey()
  local explorePoint = ToClient_getExplorePointByTerritoryRaw(territoryKeyRaw)
  if nil == explorePoint then
    self._ui.txt_ContributePoint:SetText("")
    return
  end
  local s64_exploreRequireExp = getRequireExperienceToExplorePointByTerritory_s64(territoryKeyRaw)
  local cont_expRate = Int64toInt32(explorePoint:getExperience_s64()) / Int64toInt32(getRequireExplorationExperience_s64()) * 100
  local expString = string.format("%.2f", cont_expRate) .. "%"
  local nowRemainExpPoint = tostring(explorePoint:getRemainedPoint())
  local nowExpPoint = tostring(explorePoint:getAquiredPoint())
  if true == isGameServiceTypeDev() then
    self._ui.txt_ContributePoint:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()) .. " (" .. expString .. ")" .. " (" .. Int64toInt32(explorePoint:getExperience_s64()) .. " / " .. Int64toInt32(getRequireExplorationExperience_s64()) .. ")")
  else
    self._ui.txt_ContributePoint:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()) .. " (" .. expString .. ")")
  end
  if self._isFirstExplore == false then
    self._lastRemainExplorePoint = 0
    self._lastExplorePoint = 0
    self._isFirstExplore = true
    nowRemainExpPoint = 0
    nowExpPoint = 0
  end
  if self._lastContRate ~= cont_expRate then
    self._ui.txt_ContributePoint:SetNotAbleMasking(true)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("fUI_Repair01", false, 0, 0)
  end
  if self._lastRemainExplorePoint ~= nowRemainExpPoint and self._isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  end
  if self._lastExplorePoint ~= nowExpPoint and self._isFirstExplore == true then
    audioPostEvent_SystemUi(3, 7)
    self._ui.txt_ContributePoint:EraseAllEffect()
    self._ui.txt_ContributePoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  end
  self._ui.txt_ContributePoint:SetFontColor(4294899677)
  self._ui.txt_ContributePoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  self._lastContRate = cont_expRate
  self._lastRemainExplorePoint = tostring(explorePoint:getRemainedPoint())
  self._lastExplorePoint = tostring(explorePoint:getAquiredPoint())
end
function MainStatus:updateEnergy()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local Wp = selfPlayer:getWp()
  local maxWp = selfPlayer:getMaxWp()
  local wpSetProgress = 0
  if 0 ~= maxWp then
    wpSetProgress = Wp / maxWp * 100
  end
  if Wp > self._lastWP and -1 ~= self._lastWP then
    audioPostEvent_SystemUi(3, 13)
    self._ui.txt_EnergyPoint:EraseAllEffect()
    self._ui.txt_EnergyPoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
    self._ui.txt_EnergyPoint:AddEffect("fUI_LevelUP_Skill02", false, 0, 0)
  end
  self._ui.txt_EnergyPoint:SetText(tostring(Wp) .. " / " .. maxWp)
  self._ui.txt_EnergyPoint:SetEnableArea(0, 0, self._ui.txt_EnergyPoint:GetTextSizeX(), self._ui.txt_EnergyPoint:GetSizeY())
  self._ui.txt_EnergyPoint:SetFontColor(4294899677)
  self._ui.txt_EnergyPoint:useGlowFont(true, "BaseFont_Glow", 4284572001)
  self._lastWP = Wp
end
function MainStatus:updatePvP()
  if false == isPvpEnable() or false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    self._ui.btn_PVP:SetShow(false)
    return
  end
  if true == ToClient_isAdultUser() then
    self._ui.btn_PVP:SetShow(true)
  end
  if true == getPvPMode() and false == self._ui.btn_PVP:IsCheck() then
    self._ui.btn_PVP:EraseAllEffect()
    self._ui.btn_PVP:AddEffect("fUI_SkillButton02", true, 0, 0)
    self._ui.btn_PVP:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
    self._ui.btn_PVP:SetCheck(true)
    self._isPvPOn = true
  elseif false == getPvPMode() and true == self._ui.btn_PVP:IsCheck() then
    self._ui.btn_PVP:EraseAllEffect()
    self._ui.btn_PVP:SetCheck(false)
    self._isPvPOn = false
  end
end
function MainStatus:setPVP(where, actorKeyRaw)
  if nil ~= actorKeyRaw then
    local actorProxyWrapper = getActor(actorKeyRaw)
    if nil == actorProxyWrapper then
      return
    end
    if false == actorProxyWrapper:get():isSelfPlayer() then
      return
    end
  end
  if false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting) then
    return
  end
  if true == isPvpEnable() then
    self:showPVPBtn(true)
    if true == getPvPMode() then
      audioPostEvent_SystemUi(0, 9)
      audioPostEvent_SystemUi(9, 0)
      _AudioPostEvent_SystemUiForXBOX(0, 9)
      _AudioPostEvent_SystemUiForXBOX(9, 0)
      self._ui.btn_PVP:SetCheck(true)
      self._ui.btn_PVP:EraseAllEffect()
      self._ui.btn_PVP:AddEffect("fUI_SkillButton02", true, 0, 0)
      self._ui.btn_PVP:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
      if nil == where then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_ON"))
      end
      self._isPvPOn = true
    elseif true == self._isPvPOn then
      audioPostEvent_SystemUi(0, 11)
      _AudioPostEvent_SystemUiForXBOX(0, 11)
      self._ui.btn_PVP:SetCheck(false)
      self._ui.btn_PVP:EraseAllEffect()
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_OFF"))
      self._isPvPOn = false
    else
      self._ui.btn_PVP:SetCheck(false)
    end
  else
    self:showPVPBtn(false)
  end
end
function MainStatus:showPVPBtn(isShow)
  if false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    self._ui.btn_PVP:SetShow(false)
    return
  end
  if self._ui.btn_PVP:GetShow() == isShow then
    return
  end
  self._ui.btn_PVP:SetShow(isShow)
end
function MainStatus:blackSpiritLock()
  if false == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting) then
    return
  end
  if false == getSelfPlayer():isEnableAdrenalin() then
    self._ui.stc_RageLock:SetShow(false)
  else
    local isUseRage = getSelfPlayer():isUseableBlackSpritSkill()
    if true == isUseRage then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_USEABLE_BLACKSPRITSKILL"), 5)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTUSEABLE_BLACKSPRITSKILL"), 5)
    end
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eBlackSpiritSkillOnOff, isUseRage, CppEnums.VariableStorageType.eVariableStorageType_Character)
    self._ui.stc_RageLock:SetShow(not isUseRage)
  end
end
function PaGlobalFunc_MainStatus_UpdateAll()
  local self = MainStatus
  self:updateAll()
end
function PaGlobalFunc_MainStatus_UpdateLV()
  local self = MainStatus
  self:updateLV()
  self:checkHpAlertPostEvent()
end
function PaGlobalFunc_MainStatus_CheckHpAlertPostEvent()
  local self = MainStatus
  self:checkHpAlertPostEvent()
end
function PaGlobalFunc_MainStatus_UpdateEXP()
  LUA_SCOPED_PROFILE("PaGlobalFunc_MainStatus_UpdateEXP")
  local self = MainStatus
  self:updateEXP()
  self:updateSkillPoint()
end
function PaGlobalFunc_MainStatus_UpdateInjuryHP()
  local self = MainStatus
  self:updateInjuryHP()
end
function PaGlobalFunc_MainStatus_UpdateHP()
  local self = MainStatus
  self:updateHP()
end
function PaGlobalFunc_MainStatus_UpdateReplayHP()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateReplayMP()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateReplayLevel()
  local self = MainStatus
end
function PaGlobalFunc_MainStatus_UpdateMP()
  local self = MainStatus
  self:updateMP()
end
function PaGlobalFunc_MainStatus_UpdateRage()
  local self = MainStatus
  self:updateRage()
end
function PaGlobalFunc_MainStatus_UpdateResource()
  local self = MainStatus
  self:updateResource()
end
function PaGlobalFunc_MainStatus_UpdateContribute()
  local self = MainStatus
  self:updateContribute()
end
function PaGlobalFunc_MainStatus_UpdateEnergy()
  local self = MainStatus
  self:updateEnergy()
end
function PaGlobalFunc_MainStatus_PVPModeChange(actorKeyRaw)
  local self = MainStatus
  if nil ~= actorKeyRaw then
    self:setPVP(nil, actorKeyRaw)
  end
end
function PaGlobalFunc_MainStatus_PVPAbleChange(actorKeyRaw)
  local self = MainStatus
  local selfWrapper = getSelfPlayer()
  if nil == selfWrapper then
    return
  end
  if selfWrapper:getActorKey() == actorKeyRaw then
    self:setPVP(selfWrapper)
  end
end
function PaGlobalFunc_MainStatus_Init()
  local self = MainStatus
  self:init()
end
function PaGlobalFunc_MainStatus_QuestCheck()
  local self = MainStatus
  self._oldCharacter = questList_isClearQuest(650, 1)
  if self._oldCharacter then
    self._levelUpQuestClear = questList_isClearQuest(677, 1)
  else
    self._levelUpQuestClear = questList_isClearQuest(21100, 7)
  end
end
function PaGlobalFunc_MainStatus_DangerAlertShow(isShow)
  local self = MainStatus
  if false == isShow then
    self._strongMonsterAlert = false
    return
  end
  self._strongMonsterAlert = true
  if true ~= _dangerPanel:GetShow() then
    _dangerPanel:SetShow(true, false)
    self._ui.stc_HPAlert:SetAlpha(1)
  end
  if false == self._ui.stc_HPAlert:GetShow() then
    self._ui.stc_HPAlert:SetShow(true)
  end
  self._ui.stc_HPAlert:SetVertexAniRun("Ani_Color_Danger1", true)
end
function PaGlobalFunc_MainStatus_GetPosY()
  return _panel:GetPosY()
end
function PaGlobalFunc_MainStatus_GetPosX()
  return _panel:GetPosX()
end
function PaGlobalFunc_MainStatus_GetSizeY()
  return _panel:GetSizeY()
end
function PaGlobalFunc_MainStatus_GetSizeX()
  return _panel:GetSizeX()
end
function InputMO_MainStatus_TooltipShow(isShow, tooltipType)
  local self = MainStatus
  local name = ""
  local desc = ""
  local uiControl
  if tooltipType == self._statusTooltipType.blackSpirit then
    local count = ToClient_GetApRegenAmount()
    local countString = string.format("%.2f", count / 10)
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_TITLE")
    if _ContentsGroup_BlackSpiritLock then
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_DESC_2", "count", tostring(countString))
    else
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADRENALLIN_TOOLTIP_DESC", "count", tostring(countString))
    end
    uiControl = self._ui.progress_Rage
  elseif tooltipType == self._statusTooltipType.resource0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PHANTOMCOUNT_MESSAGE")
    uiControl = self._ui.stc_ClassType0
  elseif tooltipType == self._statusTooltipType.resource1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_FIGHTER")
    uiControl = self._ui.stc_ClassType1
  elseif tooltipType == self._statusTooltipType.resource2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_SHY_DESC")
    uiControl = self._ui.stc_ClassType2
  elseif tooltipType == self._statusTooltipType.resource3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_MAEHAW")
    uiControl = self._ui.stc_ClassType3
  elseif tooltipType == self._statusTooltipType.resource4 then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    local showCount = 0
    local maxResourceCount = selfPlayer:getMaxSubResourcePoint(0)
    if maxResourceCount > 0 then
      local resourceCount = math.floor(selfPlayer:getSubResourcePoint(0))
      showCount = resourceCount / maxResourceCount * 100
      if showCount > 100 then
        showCount = 100
      end
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA_NAME")
    showCount = string.format("%.1f", showCount)
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_NOVA", "count", showCount)
    uiControl = self._ui.stc_ClassType_NovaBG
  elseif tooltipType == self._statusTooltipType.resourceCorsairBomb then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_1")
    uiControl = self._ui.stc_ClassType_Corsair
  elseif tooltipType == self._statusTooltipType.resourceCorsairBazooka then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_2")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_2")
    uiControl = self._ui.stc_ClassType_Corsair
  elseif tooltipType == self._statusTooltipType.resourceCorsairCannon then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_NAME_3")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CLASSRESOURCE_CORSAIR_DESC_3")
    uiControl = self._ui.stc_ClassType_Corsair
  elseif tooltipType == self._statusTooltipType.skill then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAINSTATUS_SKILLPOINTICON_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAINSTATUS_SKILLPOINTICON_DESC")
    uiControl = self._ui.txt_SkillPoint
  elseif tooltipType == self._statusTooltipType.energy then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_MENTAL")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_WP")
    uiControl = self._ui.txt_EnergyPoint
  elseif tooltipType == self._statusTooltipType.contribute then
    local _contributeBubbleText = ""
    for i = 0, 2 do
      if 0 < ToClient_UsedExplorePoint(i) then
        if "" == _contributeBubbleText then
          _contributeBubbleText = self._contributeUsePoint[i] .. " " .. ToClient_UsedExplorePoint(i)
        else
          _contributeBubbleText = _contributeBubbleText .. " | " .. self._contributeUsePoint[i] .. " " .. ToClient_UsedExplorePoint(i)
        end
      end
    end
    if "" == _contributeBubbleText then
      _contributeBubbleText = PAGetString(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_4")
    else
      _contributeBubbleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPGUAGE_CONTRIBUTE_VALUE_5", "_contributeBubbleText", _contributeBubbleText)
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLD_MAP_GUIDE_CONTRIBUTIVENESS")
    desc = PAGetString(Defines.StringSheet_GAME, "MAINSTATUS_DESC_EXPLORE") .. "\n" .. _contributeBubbleText
    uiControl = self._ui.txt_ContributePoint
  elseif tooltipType == self._statusTooltipType.pvp then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PVP_TXT_ACTIVATE")
    desc = ""
    uiControl = self._ui.btn_PVP
  elseif tooltipType == self._statusTooltipType.injury then
    if false == _ContentsGroup_InjuryPercent then
      return
    end
    local player = getSelfPlayer()
    if nil == player:get() then
      return
    end
    local injuryHp = math.floor(player:get():getInjuryHp())
    if 0 == injuryHp then
      return
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAINSTATUS_INJURY_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAINSTATUS_INJURY_TOOLTIP_DESC")
    uiControl = self._ui.stc_injury
  end
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FromClient_MainStatus_CheckHpAlertPostEvent(prevRenderModeList, nextRenderModeList)
  local self = MainStatus
  local currentRenderMode = {
    Defines.RenderMode.eRenderMode_Default,
    Defines.RenderMode.eRenderMode_WorldMap
  }
  if CheckRenderModebyGameMode(nextRenderModeList) or CheckRenderMode(prevRenderModeList, currentRenderMode) then
    self:updateHP()
    self:updateMP()
  end
  PaGlobalFunc_MainStatus_SetShow(true)
end
function FromClient_MainStatus_OnResize()
  local self = MainStatus
  _dangerPanel:ComputePos()
  self._ui.stc_HPAlert:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  _panel:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(_panel)
  self:addStatusEffect()
  self:setMPBarTexture()
  PaGlobalFunc_MainStatus_SetShow(true)
end
function FromClient_notifyUpdateGrowStep_MainStatus(key, bool)
  if nil == key or nil == bool then
    return
  end
  if __eGrowStep_explorePoint == key then
    MainStatus._ui.txt_ContributePoint:SetShow(bool)
  end
end
function PaGlobalFunc_MainStatus_SetShow(isShow, isAni, isForce)
  local self = MainStatus
  if true == isForce then
    if _panel:GetShow() == isShow then
      return
    end
    if nil == isAni then
      _panel:SetShow(isShow)
    else
      _panel:SetShow(isShow, isAni)
    end
    self:updateAll()
    return
  end
  local isGetUIInfo = false
  if true == _ContentsGroup_UsePadSnapping then
    if true == isShow then
      if 0 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
        isGetUIInfo = false
      else
        isGetUIInfo = true
      end
    end
  elseif true == PaGlobalFunc_IsRemasterUIOption() then
    isGetUIInfo = true
    if true == isShow and 0 == ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      isGetUIInfo = false
    end
  end
  if nil == isAni then
    _panel:SetShow(isGetUIInfo)
  else
    _panel:SetShow(isGetUIInfo, isAni)
  end
  self:updateAll()
end
function FromClient_MainStatus_BlackSpiritLock()
  local self = MainStatus
  self:blackSpiritLock()
end
function PaGlobalFunc_MainStatus_ImmediatelyResurrection(resurrFunc)
  local self = MainStatus
  self._prevHp = resurrFunc
end
function PaGlobalFunc_MainStatus_CharacterInfoWindowUpdate()
  local self = MainStatus
  self:updateHP()
  self:updateMP()
end
function PaGlobalFunc_MainStatus_ShowPVPButton(isShow)
  local self = MainStatus
  self:showPVPBtn(isShow)
end
function PaGlobalFunc_MainStatus_ShowFromTutorial()
  _panel:SetShow(true)
end
function PaGlobalFunc_MainStatus_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_Response_Pong()
end
function PaGlobalFunc_MainStatus_UpdateEnergyEffect()
  if nil == _panel or false == _panel:GetShow() then
    return
  end
  MainStatus._ui.txt_EnergyPoint:EraseAllEffect()
  MainStatus._ui.txt_EnergyPoint:AddEffect("UI_LevelUP_Skill", false, 0, 0)
  MainStatus._ui.txt_EnergyPoint:AddEffect("fUI_LevelUP_Skill02", false, 0, 0)
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_MainStatus_Init")
registerEvent("FromClient_UpdateQuestList", "PaGlobalFunc_MainStatus_QuestCheck")
registerEvent("FromClient_responsePong", "PaGlobalFunc_Response_Pong")
