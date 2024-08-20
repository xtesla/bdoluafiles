local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_DS = CppEnums.DialogState
local UI_color = Defines.Color
local UI_PSFT = CppEnums.PAUI_SHOW_FADE_TYPE
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local skillLog_Bg = UI.getChildControl(Panel_Widget_SkillLog, "Static_SkillLogBg")
local skillLog_Icon = UI.getChildControl(skillLog_Bg, "Static_C_SkillIcon")
local skillLog = UI.getChildControl(skillLog_Bg, "StaticText_UsedSkill")
local notifySkillMsg = {}
local panelPosX = Panel_Widget_SkillLog:GetPosX()
local panelPosY = Panel_Widget_SkillLog:GetPosY()
local iconSizeX = skillLog_Icon:GetSizeX()
local iconSizeY = skillLog_Icon:GetSizeY()
local logPosX = skillLog:GetPosX()
notifySkillMsg[0] = UI.createControl(__ePAUIControl_StaticText, skillLog_Bg, "StaticText_SkillMsg_1")
CopyBaseProperty(skillLog, notifySkillMsg[0])
notifySkillMsg[1] = UI.createControl(__ePAUIControl_StaticText, skillLog_Bg, "StaticText_SkillMsg_2")
CopyBaseProperty(skillLog, notifySkillMsg[1])
notifySkillMsg[2] = UI.createControl(__ePAUIControl_StaticText, skillLog_Bg, "StaticText_SkillMsg_3")
CopyBaseProperty(skillLog, notifySkillMsg[2])
local displayTime = 2
local _displayRunningTime = 0
local index = 0
function Panel_Widget_SkillLog_BgShowAni()
  if true == skillLog_Bg:GetShow() then
    return
  end
  skillLog_Bg:SetShow(true)
  Panel_Widget_SkillLog:ChangeSpecialTextureInfoName("new_ui_common_forlua/Default/Mask_Gradient_toTop.dds")
  local FadeMaskAni = Panel_Widget_SkillLog:addTextureUVAnimation(0, 0.55, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  FadeMaskAni:SetTextureType(UI_TT.PAUI_TEXTURE_TYPE_MASK)
  FadeMaskAni:SetStartUV(0, 0.1, 0)
  FadeMaskAni:SetEndUV(0, 0.6, 0)
  FadeMaskAni:SetStartUV(1, 0.1, 1)
  FadeMaskAni:SetEndUV(1, 0.6, 1)
  FadeMaskAni:SetStartUV(0, 0.4, 2)
  FadeMaskAni:SetEndUV(0, 1, 2)
  FadeMaskAni:SetStartUV(1, 0.4, 3)
  FadeMaskAni:SetEndUV(1, 1, 3)
  Panel_Widget_SkillLog:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo3 = Panel_Widget_SkillLog:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo8 = Panel_Widget_SkillLog:addColorAnimation(0.12, 0.23, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo8:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(3)
  aniInfo8:SetEndIntensity(1)
end
function Panel_Widget_SkillLog_BgHideAni()
  if false == skillLog_Bg:GetShow() then
    return
  end
  local SkillLog_Alpha = skillLog_Bg:addColorAnimation(0, 0.6, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  SkillLog_Alpha:SetStartColor(UI_color.C_FFFFFFFF)
  SkillLog_Alpha:SetEndColor(UI_color.C_00FFFFFF)
  SkillLog_Alpha.IsChangeChild = true
  SkillLog_Alpha:SetHideAtEnd(true)
  SkillLog_Alpha:SetDisableWhileAni(true)
end
function SkillLog_Clear()
  _displayRunningTime = 0
  notifySkillMsg[0]:SetText("")
  notifySkillMsg[1]:SetText("")
  notifySkillMsg[2]:SetText("")
  index = 0
end
function FromClient_EventSelfPlayerUsedSkill()
  local autoUIPosY = 0
  if ToClient_getAutoMode() == CppEnums.Client_AutoControlStateType.BATTLE then
    Panel_Widget_SkillLog:SetPosX(Panel_Movie_KeyViewer:GetPosX() + 50)
    Panel_Widget_SkillLog:SetPosY(Panel_Movie_KeyViewer:GetPosY() - 100)
    skillLog_Icon:SetSize(70, 70)
    notifySkillMsg[0]:SetPosX(90)
    notifySkillMsg[1]:SetPosX(90)
    notifySkillMsg[2]:SetPosX(90)
    autoUIPosY = 32
  else
    skillLog_Icon:SetSize(iconSizeX, iconSizeY)
    notifySkillMsg[0]:SetPosX(logPosX)
    notifySkillMsg[1]:SetPosX(logPosX)
    notifySkillMsg[2]:SetPosX(logPosX)
  end
  if false == PaGlobalFunc_UiSet_GetSkillLogIsShow() then
    local skillWrapper = selfPlayerUsedSkillFront()
    PaGlobal_TutorialManager:handleEventSelfPlayerUsedSkill(skillWrapper)
    Tutorial_CheckUsedSkill(skillWrapper)
    selfPlayerUsedSkillPopFront()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local pcPosition = selfPlayer:get():getPosition()
    local regionInfo = getRegionInfoByPosition(pcPosition)
    if nil ~= regionInfo then
      local isSafeZone = regionInfo:get():isSafeZone()
      if true == isSafeZone then
        local skillWrapper = selfPlayerUsedSkillFront()
        PaGlobal_TutorialManager:handleEventSelfPlayerUsedSkill(skillWrapper)
        Tutorial_CheckUsedSkill(skillWrapper)
        selfPlayerUsedSkillPopFront()
        return
      end
    end
  end
  Panel_Widget_SkillLog_BgShowAni()
  local skillWrapper = selfPlayerUsedSkillFront()
  if nil ~= skillWrapper then
    local local_index = index % 3
    PaGlobal_TutorialManager:handleEventSelfPlayerUsedSkill(skillWrapper)
    Tutorial_CheckUsedSkill(skillWrapper)
    local iconPath = skillWrapper:getSkillTypeStaticStatusWrapper():getIconPath()
    skillLog_Icon:ChangeTextureInfoNameAsync("Icon/" .. iconPath)
    skillLog_Icon:SetShow(true)
    local skillName = skillWrapper:getName()
    SkillName_fadeIn(notifySkillMsg[local_index])
    notifySkillMsg[local_index]:SetText(skillName)
    notifySkillMsg[local_index]:SetShow(true)
    notifySkillMsg[local_index]:SetPosY(58 + autoUIPosY)
    selfPlayerUsedSkillPopFront()
    notifySkillMsg[(index - 1) % 3]:SetPosY(30 + autoUIPosY)
    notifySkillMsg[(index - 2) % 3]:SetPosY(2 + autoUIPosY)
    _displayRunningTime = 0
    index = index + 1
    if nil ~= SkillCommand_Effect then
      SkillCommand_Effect(skillWrapper)
    end
  end
end
function SkillName_fadeOut(control)
  local aniInfo = control:addColorAnimation(2, 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetHideAtEnd(false)
end
function SkillName_fadeIn(control)
  local aniInfo = control:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
end
function SkillName_ScaleAni(control)
  local aniInfo = control:addScaleAnimation(0, 0.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartScale(0)
  aniInfo:SetEndScale(1)
  aniInfo.AxisX = 0
  aniInfo.AxisY = 0
  aniInfo.ScaleType = 4
end
function SkillLog_TimeCheck(deltaTime)
  _displayRunningTime = _displayRunningTime + deltaTime
  if displayTime < _displayRunningTime then
    Panel_Widget_SkillLog_BgHideAni()
    SkillLog_Clear()
  end
end
function Panel_Widget_SkillLog_SetPos()
  local scrX = getOriginScreenSizeX()
  local scrY = getOriginScreenSizeY()
  local panelSizeX = Panel_Widget_SkillLog:GetSizeX()
  local panelSizeY = Panel_Widget_SkillLog:GetSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillLog, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillLog, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  local initPosX = scrX / 2 - panelSizeX * 1.3
  local initPosY = scrY / 2 + panelSizeY / 2
  if (relativePosX == -1 and relativePosY) == -1 or relativePosX == 0 and relativePosY == 0 then
    Panel_Widget_SkillLog:SetPosX(initPosX)
    Panel_Widget_SkillLog:SetPosY(initPosY)
  else
    Panel_Widget_SkillLog:SetRelativePosX(relativePosX)
    Panel_Widget_SkillLog:SetRelativePosY(relativePosY)
    Panel_Widget_SkillLog:SetPosX(scrX * relativePosX - Panel_Widget_SkillLog:GetSizeX() / 2)
    Panel_Widget_SkillLog:SetPosY(scrY * relativePosY - Panel_Widget_SkillLog:GetSizeY() / 2)
  end
end
function SkillLog_Initialize()
  SkillLog_Clear()
  Panel_Widget_SkillLog:setGlassBackground(true)
  Panel_Widget_SkillLog:setMaskingChild(true)
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillLog, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    local savedShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillLog, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if -1 == savedShow then
      Panel_Widget_SkillLog:SetShow(true)
    else
      Panel_Widget_SkillLog:SetShow(savedShow)
    end
  else
    Panel_Widget_SkillLog:SetShow(true)
  end
  Panel_Widget_SkillLog:RegisterUpdateFunc("SkillLog_TimeCheck")
  registerEvent("EventSelfPlayerUsedSkill", "FromClient_EventSelfPlayerUsedSkill")
  registerEvent("onScreenResize", "Panel_Widget_SkillLog_SetPos")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "Panel_Widget_SkillLog_SetPos")
  registerEvent("FromClient_RenderModeChangeState", "Panel_Widget_SkillLog_SetPos")
end
function FromClient_SkillLog_Initialize()
  SkillLog_Initialize()
  Panel_Widget_SkillLog_SetPos()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillLog_Initialize")
