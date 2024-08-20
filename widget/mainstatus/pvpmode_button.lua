local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local pvpText = UI.getChildControl(Panel_PvpMode, "StaticText_pvpText")
local _bubbleNotice = UI.getChildControl(Panel_PvpMode, "StaticText_Notice")
_pvpButton = UI.getChildControl(Panel_PvpMode, "CheckButton_PvpButton")
_pvpButton:addInputEvent("Mouse_LUp", "HandleClicked_PvpModeChange()")
Panel_PvpMode:addInputEvent("Mouse_On", "Panel_PvpMode_ChangeTexture_On()")
Panel_PvpMode:addInputEvent("Mouse_Out", "Panel_PvpMode_ChangeTexture_Off()")
Panel_PvpMode:addInputEvent("Mouse_LUp", "ResetPos_WidgetButton()")
Panel_PvpMode:SetPosX(Panel_MainStatus_User_Bar:GetPosX() - 20)
Panel_PvpMode:SetPosY(Panel_MainStatus_User_Bar:GetPosY() + Panel_MainStatus_User_Bar:GetSizeY() - 40)
posX = Panel_PvpMode:GetPosX()
posY = Panel_PvpMode:GetPosY()
local isPvPOn = true
local PvPOnCount = 0
local prePvp = false
local calculateTime = 0
function Panel_PvpMode_unRenderInInstance()
  if nil == Panel_PvpMode then
    _PA_ASSERT_NAME(false, "Panel_PvpMode\236\157\180 nil \236\158\133\235\139\136\235\139\164.", "\234\185\128\234\183\188\236\154\176")
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
    Panel_PvpMode:SetRenderAndEventHide(true)
  else
    Panel_PvpMode:SetRenderAndEventHide(false)
  end
end
function Panel_PvpMode_ChangeTexture_On()
  audioPostEvent_SystemUi(0, 10)
  _AudioPostEvent_SystemUiForXBOX(0, 10)
  Panel_PvpMode:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_drag.dds")
  pvpText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPMODE_UI_MOVE"))
end
function Panel_PvpMode_ChangeTexture_Off()
  if Panel_UIControl:IsShow() then
    Panel_PvpMode:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_isWidget.dds")
    pvpText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PVPMODE_UI"))
  else
    Panel_PvpMode:ChangeTextureInfoName("new_ui_common_forlua/default/window_sample_empty.dds")
  end
end
function Panel_PvpMode_EnableSimpleUI()
  pvpText:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
  _pvpButton:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
  _bubbleNotice:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
end
function Panel_PvpMode_DisableSimpleUI()
  pvpText:SetAlpha(1)
  _pvpButton:SetAlpha(1)
  _bubbleNotice:SetAlpha(1)
end
function Panel_PvpMode_UpdateSimpleUI(fDeltaTime)
  pvpText:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
  _pvpButton:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
  _bubbleNotice:SetAlpha(Panel_MainStatus_User_Bar:GetAlpha())
end
registerEvent("SimpleUI_UpdatePerFrame", "Panel_PvpMode_UpdateSimpleUI")
registerEvent("EventSimpleUIEnable", "Panel_PvpMode_EnableSimpleUI")
registerEvent("EventSimpleUIDisable", "Panel_PvpMode_DisableSimpleUI")
function PvpModeButton_RefreshPosition()
  pvpText.posX = Panel_PvpMode:GetPosX()
  pvpText.posY = Panel_PvpMode:GetPosY()
  _bubbleNotice.posX = Panel_PvpMode:GetPosX()
  _bubbleNotice.posY = Panel_PvpMode:GetPosY()
  _pvpButton.posX = Panel_PvpMode:GetPosX()
  _pvpButton.posY = Panel_PvpMode:GetPosY()
end
function pvpMode_changedMode(actorKeyRaw)
  FromClient_PvpMode_changeMode(nil, actorKeyRaw)
end
function pvpMode_changedMode1(actorKeyRaw)
  if nil ~= actorKeyRaw then
    FromClient_PvpMode_changeMode(nil, actorKeyRaw)
  end
end
function FromClient_PvpMode_changeMode(where, actorKeyRaw)
  if nil ~= actorKeyRaw then
    local actorProxyWrapper = getActor(actorKeyRaw)
    if nil == actorProxyWrapper then
      return
    end
    if not actorProxyWrapper:get():isSelfPlayer() then
      return
    end
  end
  if true == ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting) then
    return
  end
  if isPvpEnable() and false == isFlushedUI() then
    PvpMode_ShowButton(true)
    if getPvPMode() then
      audioPostEvent_SystemUi(0, 9)
      audioPostEvent_SystemUi(9, 0)
      _AudioPostEvent_SystemUiForXBOX(0, 9)
      _AudioPostEvent_SystemUiForXBOX(9, 0)
      _pvpButton:EraseAllEffect()
      _pvpButton:AddEffect("fUI_SkillButton02", true, 0, 0)
      _pvpButton:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
      if nil == where then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_ON"))
      end
      isPvPOn = true
    elseif isPvPOn then
      audioPostEvent_SystemUi(0, 11)
      _AudioPostEvent_SystemUiForXBOX(0, 11)
      _pvpButton:EraseAllEffect()
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PVP_BUTTON_OFF"))
      isPvPOn = false
    end
    FGlobal_MainStatus_FadeIn(5)
    PvpMode_Resize()
  else
    PvpMode_ShowButton(false)
  end
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 and true == ToClient_isBattleFocusModeOn() then
    local isCurrentBattleFocusUI = ToClient_getLastSentBattleFocusValue()
    if true == isCurrentBattleFocusUI then
      PaGlobal_UIModify:hideDefaultUI()
    else
      PaGlobal_UIModify:showDefaultUI()
    end
  end
end
function PvpMode_PlayerPvPAbleChanged(actorKeyRaw)
  local selfWrapper = getSelfPlayer()
  if nil == selfWrapper then
    return
  end
  if selfWrapper:getActorKey() == actorKeyRaw then
    FromClient_PvpMode_changeMode(selfWrapper)
  end
end
function HandleClicked_PvpModeChange()
  _pvpButton:SetCheck(isPvPOn)
  requestTogglePvP()
end
function PaGlobalFunc_PvpMode_ShowButton(isShow)
  if false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    _pvpButton:SetShow(false)
    return
  end
  if _pvpButton:GetShow() == isShow then
    return
  end
  _pvpButton:ResetVertexAni()
  if isShow then
    _pvpButton:SetShow(true)
    Panel_PvpMode_EnableSimpleUI()
  else
    Panel_PvpMode_DisableSimpleUI()
  end
end
function PvpMode_Resize()
  if Panel_PvpMode:GetRelativePosX() == -1 and Panel_PvpMode:GetRelativePosY() == -1 then
    local initPosX = Panel_MainStatus_User_Bar:GetPosX() - 20
    local initPosY = Panel_MainStatus_User_Bar:GetPosY() + Panel_MainStatus_User_Bar:GetSizeY() - 40
    Panel_PvpMode:SetPosX(initPosX)
    Panel_PvpMode:SetPosY(initPosY)
    changePositionBySever(Panel_PvpMode, CppEnums.PAGameUIType.PAGameUIPanel_PvpMode, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_PvpMode, initPosX, initPosY)
  elseif Panel_PvpMode:GetRelativePosX() == 0 and Panel_PvpMode:GetRelativePosY() == 0 then
    Panel_PvpMode:SetPosX(getScreenSizeX() / 2 - Panel_MainStatus_User_Bar:GetSizeX() / 2 - 20)
    Panel_PvpMode:SetPosY(getScreenSizeY() - Panel_QuickSlot:GetSizeY() - Panel_PvpMode:GetSizeY() + 6)
  else
    Panel_PvpMode:SetPosX(Panel_PvpMode:GetRelativePosX() * getScreenSizeX() - Panel_PvpMode:GetSizeX() / 2)
    Panel_PvpMode:SetPosY(Panel_PvpMode:GetRelativePosY() * getScreenSizeY() - Panel_PvpMode:GetSizeY() / 2)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_PvpMode)
  PaGlobalFunc_PvpMode_SetShow(true, false)
  PaGlobal_GlobalManual_RepositionBulletCount()
end
function FromClient_PaGlobalFunc_PvpMode_SetShow()
  Panel_PvpMode_unRenderInInstance()
  PaGlobalFunc_PvpMode_SetShow(true, false)
end
function PaGlobalFunc_PvpMode_SetShow(isShow, isAni, isForce)
  if false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
    isShow = false
  end
  if true == isForce then
    if Panel_PvpMode:GetShow() == isShow then
      return
    end
    Panel_PvpMode:SetShow(isShow and not isRecordMode)
  else
    local isGetUIInfo = false
    if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_PvpMode, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      isGetUIInfo = true
    else
      isGetUIInfo = false
    end
    Panel_PvpMode:SetShow(isShow and isGetUIInfo and not isRecordMode and not PaGlobalFunc_IsRemasterUIOption())
  end
  Panel_PvpMode_UpdateState()
end
function Panel_PvpMode_UpdateState()
  if isPvpEnable() then
    if false == ToClient_isAdultUser() or true == ToClient_isCantPvPChannel() then
      _pvpButton:SetShow(false)
    else
      _pvpButton:SetShow(true)
    end
    isPvPOn = getPvPMode()
    _pvpButton:EraseAllEffect()
    if true == isPvPOn then
      _pvpButton:AddEffect("fUI_SkillButton02", true, 0, 0)
      _pvpButton:AddEffect("fUI_PvPButtonLoop", true, 0, 0)
    end
    _pvpButton:SetCheck(isPvPOn)
  else
    _pvpButton:SetShow(false)
  end
  if true == _pvpButton:GetShow() then
    Panel_PvpMode_EnableSimpleUI()
  else
    Panel_PvpMode_DisableSimpleUI()
  end
end
registerEvent("EventPvPModeChanged", "pvpMode_changedMode1")
registerEvent("EventPlayerPvPAbleChanged", "PvpMode_PlayerPvPAbleChanged")
registerEvent("onScreenResize", "PvpMode_Resize")
registerEvent("FromClient_ApplyUISettingPanelInfo", "PvpMode_Resize")
registerEvent("FromClient_RenderModeChangeState", "PvpMode_Resize")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobalFunc_PvpMode_SetShow")
changePositionBySever(Panel_PvpMode, CppEnums.PAGameUIType.PAGameUIPanel_PvpMode, true, true, false)
PaGlobalFunc_PvpMode_SetShow(true, false)
