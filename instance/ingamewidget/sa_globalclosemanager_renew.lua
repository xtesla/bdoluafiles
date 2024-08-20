local closeTypeBitSet = {
  none = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_CantClose
  }),
  attacked = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape,
    Defines.CloseType.eCloseType_Attacked
  }),
  attackedOnly = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Attacked
  }),
  default = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Escape
  }),
  forceOnly = PAUIRenderModeBitSet({
    Defines.CloseType.eCloseType_Force
  })
}
function addCloseExceptionList()
  if nil ~= PaGlobalFunc_GetDamagePanel_Count then
    for index = 1, PaGlobalFunc_GetDamagePanel_Count() do
      if nil ~= PaGlobalFunc_GetDamagePanel(index) then
        table.insert(panel_exceptionList, PaGlobalFunc_GetDamagePanel(index))
      end
    end
  end
end
function closeExceptionListInitialize()
  for index, panel in pairs(PaGlobal_panelExceptionList) do
    if nil ~= panel then
      panel:RegisterCloseLuaFunc(closeTypeBitSet.none, "")
    end
  end
  panel_exceptionList = nil
  PaGlobal_panelExceptionList = nil
end
function registerCloseLuaEvent(panel, closeFlag, closeFunc)
  if nil == panel or nil == closeFlag or nil == closeFunc then
    return
  end
  panel:RegisterCloseLuaFunc(closeFlag, closeFunc)
end
function registerClosePanelList()
  registerCloseLuaEvent(Instance_ChatOption, closeTypeBitSet.default, "PanelCloseFunc_ChatOption()")
  registerCloseLuaEvent(Instance_Chatting_Input, closeTypeBitSet.default, "PanelCloseFunc_ChattingInput()")
  registerCloseLuaEvent(Instance_Window_Inventory, closeTypeBitSet.default, "PanelCloseFunc_Inventory()")
  registerCloseLuaEvent(Panel_SA_Window_MessageBox, closeTypeBitSet.default, "PaGlobal_SA_Window_MessageBox_Close()")
  registerCloseLuaEvent(Instance_Scroll, closeTypeBitSet.default, "UIScrollButton.Close()")
  registerCloseLuaEvent(Panel_SkillAwaken, closeTypeBitSet.default, "SkillAwaken_Close()")
  registerCloseLuaEvent(Instance_Tooltip_Item_chattingLinkedItem, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItem_hideTooltip()")
  registerCloseLuaEvent(Instance_Chatting_Color, closeTypeBitSet.default, "ChattingColor_Hide()")
  registerCloseLuaEvent(Instance_Tooltip_Item_chattingLinkedItemClick, closeTypeBitSet.default, "Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()")
  registerCloseLuaEvent(Instance_Window_Equipment, closeTypeBitSet.default, "PanelCloseFunc_Equip_Close()")
  registerCloseLuaEvent(Instance_Window_Skill, closeTypeBitSet.default, "PanelCloseFunc_Skill()")
  registerCloseLuaEvent(Instance_Window_NumberPad, closeTypeBitSet.default, "Panel_NumberPad_Close()")
  registerCloseLuaEvent(Instance_RoomMemberList, closeTypeBitSet.default, "PaGlobalFunc_roomMemberList_Close()")
  registerCloseLuaEvent(Instance_TrayConfirm, closeTypeBitSet.default, "PanelCloseFunc_TrayConfirm()")
  registerCloseLuaEvent(Panel_SA_Window_WorldMap, closeTypeBitSet.default, "PaGlobal_SA_Window_WorldMap_Close()")
  registerCloseLuaEvent(Panel_SA_Widget_Inventory, closeTypeBitSet.default, "PaGlobal_SA_Widget_Inventory_Close()")
  registerCloseLuaEvent(Panel_SA_Widget_ESCMenu, closeTypeBitSet.default, "PaGlobal_SA_Widget_ESCMenu_Close()")
  registerCloseLuaEvent(Panel_Window_cOption, closeTypeBitSet.default, "PanelCloseFunc_Option()")
  registerCloseLuaEvent(Panel_SaveSetting, closeTypeBitSet.default, "PanelCloseFunc_SaveSetting()")
  registerCloseLuaEvent(Panel_HelpMessage, closeTypeBitSet.default, "HelpMessageQuestion_Out()")
  registerCloseLuaEvent(Instance_MessageBox, closeTypeBitSet.attacked, "MessageBox_Empty_function()")
  registerCloseLuaEvent(Instance_ChatOption, closeTypeBitSet.attacked, "ChattingOption_Close()")
  registerCloseLuaEvent(Instance_Chat_SocialMenu, closeTypeBitSet.default, "FGlobal_SocialAction_ShowToggle()")
  registerCloseLuaEvent(Instance_Chat_Emoticon, closeTypeBitSet.attacked, "PaGlobalFunc_ChatEmoticon_Close()")
  registerCloseLuaEvent(Instance_Chatting_Filter, closeTypeBitSet.default, "FGlobal_ChattingFilterList_Close()")
  registerCloseLuaEvent(LobbyInstance_Window_ModeBranch, closeTypeBitSet.default, "PaGlobal_ModeBranch_Close()")
end
function PaGlobalFunc_KeyboardHelpClose()
  Panel_KeyboardHelp:SetShow(false)
end
function PaGlobalFunc_Panel_QuickMenuCustomClose()
  Panel_QuickMenuCustom:SetShow(false)
  Panel_QuickMenuCustom_RightRing:SetShow(false)
end
function PaGlobalFunc_GameExitClose()
  GameExitShowToggle(true)
  FGlobal_ChannelSelect_Hide()
  Panel_GameExit_sendGameDelayExitCancel()
end
registerEvent("FromClient_luaLoadComplete", "initCloseFunction")
function initCloseFunction()
  _PA_LOG("\236\157\180\235\139\164\237\152\156", "initCloseFunction Start")
  CloseManager_RegisterExeptionList()
  closeExceptionListInitialize()
  registerClosePanelList()
end
function checkAllPanelSetCloseFunction()
  local result = Toclient_checkCloseEventSet()
  if true ~= result then
    UI.ASSERT(false, " \237\140\168\235\132\144\236\151\144 ,close \237\149\168\236\136\152\234\176\128 \236\133\139\237\140\133\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164 !! close \234\176\128 \236\160\149\236\131\129\236\158\145\235\143\153\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164 ")
    UI.ASSERT(false, " \237\149\180\235\139\185 \237\140\168\235\132\144\236\157\132 globalCloseManager_Renew.lua \236\152\136\236\153\184 \235\166\172\236\138\164\237\138\184\236\151\144 \236\182\148\234\176\128\237\149\152\234\177\176\235\130\152 close \237\149\168\236\136\152\235\165\188 \235\147\177\235\161\157\237\149\180\236\163\188\236\132\184\236\154\148 ")
  end
  _PA_LOG("\236\157\180\235\139\164\237\152\156", "\236\156\160\237\154\168\236\132\177 \234\178\128\236\130\172 \235\129\157")
end
function FromClient_EscapeEtcClose()
  if Panel_LowLevelGuide_Value_IsCheckMoviePlay == 1 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindWay()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 2 then
    FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 3 then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 4 then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
  elseif Panel_LowLevelGuide_Value_IsCheckMoviePlay == 99 then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
  end
end
function FromClient_CancelByAttacked()
  close_attacked_WindowPanelList()
end
function check_ShowWindow()
  return ToClient_isShownClosePanel()
end
function close_WindowPanelList()
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Escape, false)
end
function close_force_WindowPanelList()
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Force, true)
end
function close_escape_WindowPanelList()
  Toclient_processCheckEscapeKey()
  if true == isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) then
  end
end
local _cancelByAttackIsCalled = false
function PaGlobalFunc_CancelByAttackIsCalled()
  return _cancelByAttackIsCalled
end
function close_attacked_WindowPanelList()
  if false == _ContentsGroup_RenewUI_Chatting and false == AllowChangeInputMode() then
    return
  end
  _cancelByAttackIsCalled = true
  RenderModeAllClose()
  ToClient_PopBlackSpiritFlush()
  Toclient_closeAllPanelByState(Defines.CloseType.eCloseType_Attacked, false)
  _cancelByAttackIsCalled = false
end
function getCurrentCloseType()
  return Toclient_getCurrentCloseType()
end
initCloseFunction()
registerEvent("FromClient_luaLoadCompleteLateUdpate", "checkAllPanelSetCloseFunction")
registerEvent("FromClient_EscapeEtcClose", "FromClient_EscapeEtcClose")
registerEvent("progressEventCancelByAttacked", "FromClient_CancelByAttacked")
function PanelCloseFunc_LocalWarInfo_Close()
  if true == _ContentsGroup_NewUI_LocalWar_All then
    PaGlobal_LocalWarInfo_All_Close()
  elseif false == _ContentsGroup_RenewUI_LocalWar then
    FGlobal_LocalWarInfo_Close()
  else
    PaGlobalFunc_LocalWarInfo_Exit()
  end
end
function PanelCloseFunc_ImprovementInfo_Discard()
  PaGlobalFunc_ImprovementInfo_Discard()
end
function PanelCloseFunc_EventNotify()
  FGlobal_NpcNavi_Hide()
  EventNotify_Close()
end
function PanelCloseFunc_MasterpieceAuction()
  if FGlobal_MasterPieceAuction_IsOpenEscMenu() then
    PaGlobal_MasterpieceAuction:close()
    return
  end
end
function PanelCloseFunc_Skill()
  if false == _ContentsGroup_RenewUI_Skill then
    HandleMLUp_SkillWindow_Close()
  else
    PaGlobalFunc_Skill_Close()
  end
end
function PanelCloseFunc_ChatOption()
  ChattingOption_Close()
end
function PanelCloseFunc_ChattingInput()
  ChatInput_Close()
end
function PanelCloseFunc_Inventory()
  InventoryWindow_Close()
  if Instance_Window_Equipment:GetShow() then
    Equipment_SetShow(false)
  end
end
function PanelCloseFunc_Looting()
end
function PanelCloseFunc_MessageBox()
  messageBox_CloseButtonUp()
end
function PanelCloseFunc_Equip_Close()
  if Instance_Window_Inventory:GetShow(true) then
    PanelCloseFunc_Inventory()
  else
    Equipment_SetShow(false)
  end
end
function PanelCloseFunc_TrayConfirm()
  if nil == PaGlobal_TrayConfirm then
    return
  end
  PaGlobal_TrayConfirm:close()
end
function PanelCloseFunc_Option()
  GameOption_Cancel()
  TooltipSimple_Hide()
end
function PanelCloseFunc_SaveSetting()
  PaGlobal_Panel_SaveSetting_Hide()
end
function FGlobal_Window_Servant_ColorBlindUpdate()
end
function HelpMessageQuestion_Out()
  if nil ~= Panel_HelpMessage then
    Panel_HelpMessage:SetShow(false)
  end
  if nil ~= LobbyInstance_HelpMessage then
    LobbyInstance_HelpMessage:SetShow(false)
  end
end
