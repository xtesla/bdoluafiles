local renewalUiOpen = false
local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
isRecordMode = false
isLuaLoadingComplete = false
local UIFontType = ToClient_getGameOptionControllerWrapper():getUIFontSizeType()
preloadUI_cahngeUIFontSize(UIFontType)
function loadLoadingUI_Instance()
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_LoadingProgress.XML", "Panel_Loading", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  runLua("UI_Data/Script/Panel_Loading_BattleRoyal.lua")
  basicLoadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeName.XML", "Panel_NodeName", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_InSideNode.XML", "Panel_NodeMenu", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_InSideNode_Guild.XML", "Panel_NodeOwnerInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_All.XML", "Panel_WorldMap_NodeTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_WarInfo.XML", "Panel_Win_Worldmap_WarInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeWarInfo.XML", "Panel_Win_Worldmap_NodeWarInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NavigationButton.XML", "Panel_NaviButton", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_ResultDetectUser.XML", "Panel_DetectUserButton", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_WarInfoMessage.XML", "Panel_WarInfoMessage", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWarKillingScore.XML", "Panel_TerritoryWarKillingScore", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/HouseInfo/Panel_WolrdHouseInfo.XML", "Panel_WolrdHouseInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  ToClient_initializeWorldMap("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_Base.XML")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PopupManager.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Grand_WorldMap_NodeMenu.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WarInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_HouseHold.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Knowledge.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Delivery.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PinGuide.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
end
function preLoadGameUI_Instance()
  loadUI("UI_Data/Instance/IngameWidget/SA_OnlyPerframeUsed.XML", "Panel_SA_OnlyPerframeUsed", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_NakMessage.XML", "Panel_SA_NakMessage", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Party.XML", "Panel_SA_Widget_Party", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Looting_Equip.XML", "Panel_SA_Looting_Equip", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Looting_Equip_Combination.XML", "Panel_SA_Looting_Equip_Combination", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_MainFrame.XML", "Panel_SA_MainFrame", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Survival.XML", "Panel_SA_Widget_Survival", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Wait.XML", "Panel_SA_Widget_Wait", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_Minimap.XML", "Panel_SA_Widget_Minimap", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Interaction.XML", "Panel_SA_Interaction", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Looting.XML", "Panel_SA_Looting", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_Quest.XML", "Panel_SA_Widget_Quest", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_EnemyGauge.XML", "Panel_SA_Widget_EnemyGauge", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_KillLog.XML", "Panel_SA_KillLog", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_SkillList.XML", "Panel_SA_SkillList", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Scoreboard.XML", "Panel_SA_Widget_ScoreBoard", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Scoreboard_Detail.XML", "Panel_SA_Widget_ScoreBoard_Detail", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_GuardGauge.XML", "Panel_SA_Widget_GuardGauge", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Instance/IngameWidget/SA_Window_WorldMap.XML", "Panel_SA_Window_WorldMap", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Respon_Message.XML", "Panel_SA_Widget_Respon_Message", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Instance/IngameWidget/SA_Widget_Respon_Time.XML", "Panel_SA_Widget_Respon_Time", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Count.XML", "Panel_SA_Widget_Count", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_ESCMenu.XML", "Panel_SA_Widget_ESCMenu", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_Inventory.XML", "Panel_SA_Widget_Inventory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Window_NumberPad.XML", "Instance_Window_NumberPad", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Chatting_Filter.XML", "Instance_Chatting_Filter", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_KillMark.XML", "Panel_SA_Widget_KillMark", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_CoolTime_Effect.XML", "Panel_SA_CoolTime_Effect", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Widget_SkillCooltime.XML", "Panel_SA_Widget_SkillCooltime", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Actor_NameTag_OtherPlayer.XML", "Panel_Copy_OtherPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/IngameWidget/SA_Actor_NameTag_Monster.XML", "Panel_Copy_Monster", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Instance/Instance_RewardSelect_NakMessage.XML", "Instance_RewardSelect_NakMessage", UIGroup.PAGameUIGroup_Chatting, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Chat.XML", "Instance_Chat", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_Chatting_Input.XML", "Instance_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SniperGame
  }))
  loadUI("UI_Data/Instance/Instance_Chatting_Macro.XML", "Instance_Chatting_Macro", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_Chat_SocialMenu.XML", "Instance_Chat_SocialMenu", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_Chat_SubMenu.XML", "Instance_Chat_SubMenu", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_Chatting_Color.XML", "Instance_Chatting_Color", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_ChatOption.XML", "Instance_ChatOption", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_ChatOptionPart.XML", "Instance_ChatOptionPart", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Instance/Instance_Chat_Emoticon.XML", "Instance_Chat_Emoticon", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SniperGame
  }))
  loadUI("UI_Data/Instance/Instance_Window_Equipment.XML", "Instance_Window_Equipment", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Window_Inventory.xml", "Instance_Window_Inventory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_Popup.XML", "Panel_SA_Window_MessageBox", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/Instance_Casting_Bar.XML", "Instance_Casting_Bar", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/Instance_Collect_Bar.XML", "Instance_Collect_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Instance/Instance_Product_Bar.XML", "Instance_Product_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Instance/Instance_Enchant_Bar.XML", "Instance_Enchant_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/c_Option/Panel_Option_Main.XML", "Panel_Window_cOption", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Camera.XML", "Panel_Performance_Camera", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Performance_GraphicQuality.XML", "Panel_Performance_GraphicQuality", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Npc.XML", "Panel_Performance_Npc", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Optimize.XML", "Panel_Performance_Optimize", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Alert.XML", "Panel_Function_Alert", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Convenience.XML", "Panel_Function_Convenience", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Etc.XML", "Panel_Function_Etc", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Interaction.XML", "Panel_Function_Interaction", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Nation.XML", "Panel_Function_Nation", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_View.XML", "Panel_Function_View", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Function_Worldmap.XML", "Panel_Function_Worldmap", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Camera.XML", "Panel_Graphic_Camera", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Effect.XML", "Panel_Graphic_Effect", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Quality.XML", "Panel_Graphic_Quality", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_ScreenShot.XML", "Panel_Graphic_ScreenShot", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Window.XML", "Panel_Graphic_Window", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Hdr.XML", "Panel_Graphic_HDR", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Action.XML", "Panel_Interface_Action", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Function.XML", "Panel_Interface_Function", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Mouse.XML", "Panel_Interface_Mouse", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Pad.XML", "Panel_Interface_Pad", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Interface_QuickSlot.XML", "Panel_Interface_QuickSlot", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Instance/MainLobby/SA_Widget_Lobby_Option_Interface_UI.XML", "Panel_Interface_UI", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Sound_OnOff.XML", "Panel_Sound_OnOff", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/c_Option/Option_Alert_Alarm.XML", "Panel_Alert_Alarm", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/SaveSetting/Panel_SaveSetting.XML", "Panel_SaveSetting", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Lobby/LobbyInstance_HelpMessage.XML", "LobbyInstance_HelpMessage", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Lobby/LobbyInstance_WebControl.XML", "LobbyInstance_WebControl", UIGroup.PAGameUIGroup_DeadMessage, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Instance/Instance_CounterAttack.XML", "Instance_CounterAttack", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Instance/Instance_Damage.XML", "Instance_Damage", UIGroup.PAGameUIGroup_Dialog)
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill.XML", "Instance_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill_forLearning.XML", "Instance_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Skill_forBlackSpirit.XML", "Instance_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item.XML", "Instance_Tooltip_Item", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_chattingLinkedItem.XML", "Instance_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_chattingLinkedItemClick.XML", "Instance_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_Item_equipped.XML", "Instance_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Instance/Instance_Tooltip_SimpleText.XML", "Instance_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Instance/Instance_Tooltip_Common.XML", "Instance_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  basicLoadUI("UI_Data/Instance/Instance_Widget_GameTips.XML", "Instance_Widget_GameTips", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Instance/Instance_Widget_GameTipMask.XML", "Instance_Widget_GameTipMask", UIGroup.PAGameUIGroup_Widget)
end
function loadGameUI_Instance()
  runLua("UI_Data/Script/Instance/IngameWidget/SA_DragManager.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Common_UIMode.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_Reconnect.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_NakMessage.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Skill.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Item.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_Common.lua")
  runLua("UI_Data/Script/Instance/Instance_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Party.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting_Equip_Combination.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_MainFrame.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Survival.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Wait.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Radar_GlobalValue.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Radar_Background.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Radar_Pin.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Radar.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Interaction.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Looting.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Quest.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_EnemyGauge.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillLog.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillList.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Scoreboard_Detail.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_GuardGauge.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_WorldMap.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Message.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Count.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Respon_Time.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_ESCMenu.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_Inventory.lua")
  runLua("UI_Data/Script/Instance/Instance_Window_NumberPad.lua")
  runLua("UI_Data/Script/Instance/Instance_Chatting_Filter.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_KillMark.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_SkillCooltime.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Widget_CharacterNameTag.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_MessageBox.lua")
  runLua("UI_Data/Script/Instance/Instance_RewardSelect_NakMessage.lua")
  runLua("UI_Data/Script/Instance/Instance_ChatOption.lua")
  runLua("UI_Data/Script/Instance/Instance_Chat.lua")
  runLua("UI_Data/Script/Instance/Instance_Chatting_Input.lua")
  runLua("UI_Data/Script/Instance/Instance_Chatting_Macro.lua")
  runLua("UI_Data/Script/Instance/Instance_Chat_SocialMenu.lua")
  runLua("UI_Data/Script/Instance/Instance_CreateChattingContent.lua")
  runLua("UI_Data/Script/Instance/Instance_Chat_Emoticon.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Window_Equipment.lua")
  runLua("UI_Data/Script/Instance/Instance_Window_Skill_Awaken.lua")
  runLua("UI_Data/Script/Instance/Instance_ProgressBar.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_GameOptionHeader.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_GameOptionMain.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_GameOptionUtil.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_Panel_Option_Main.lua")
  runLua("UI_Data/Script/Window/SaveSetting/Panel_SaveSetting.lua")
  runLua("UI_Data/Script/Instance/Lobby/LobbyInstance_Empty.lua")
  runLua("UI_Data/Script/Instance/Lobby/LobbyInstance_HelpMessage.lua")
  runLua("UI_Data/Script/Instance/Lobby/LobbyInstance_WebControl.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_OnlyPerframeUsed.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalCloseManager_ExceptionList.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalCloseManager_Renew.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalKeyBinderUiInputType.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalKeyBinderManager.lua")
  runLua("UI_Data/Script/Instance/IngameWidget/SA_globalKeyBinder.lua")
  isLuaLoadingComplete = true
end
function loadLoginUI_InstanceLobby()
  basicLoadUI("UI_Data/UI_Lobby/UI_TermsofGameUse.XML", "Panel_TermsofGameUse", UIGroup.PAGameUIGroup_Movie)
  if true == _ContentsGroup_RemasterUI_Lobby then
    basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_Login_Remaster.xml", "Panel_Login_Remaster", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/UI_Lobby/UI_Login_Nickname.XML", "Panel_Login_Nickname", UIGroup.PAGameUIGroup_GameSystemMenu)
  else
    basicLoadUI("UI_Data/UI_Lobby/UI_Login.xml", "Panel_Login", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/UI_Lobby/UI_Login_Nickname.XML", "Panel_Login_Nickname", UIGroup.PAGameUIGroup_GameSystemMenu)
  end
  basicLoadUI("UI_Data/UI_Lobby/UI_Login_Password.XML", "Panel_Login_Password", UIGroup.PAGameUIGroup_GameSystemMenu)
  if false == _ContentsGroup_NewUI_MessageBox_All then
    basicLoadUI("UI_Data/Window/MessageBox/UI_Win_System.XML", "Panel_Win_System", UIGroup.PAGameUIGroup_ModalDialog)
  else
    basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  end
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/HelpMessage/Panel_HelpMessage.xml", "Panel_HelpMessage", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  basicLoadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Panel_TermsofGameUse.lua")
  if true == _ContentsGroup_RemasterUI_Lobby then
    runLua("UI_Data/Script/Panel_Login_Remaster.lua")
  else
    runLua("UI_Data/Script/Panel_Login.lua")
  end
  runLua("UI_Data/Script/Panel_Login_Nickname.lua")
  runLua("UI_Data/Script/Panel_Login_Password.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  if false == _ContentsGroup_NewUI_MessageBox_All then
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox.lua")
  else
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/HelpMessage/Panel_HelpMessage.lua")
  preLoadGameOptionUI()
  loadGameOptionUI()
end
PaGlobal_SetLoadUIFunc(loadLoginUI_InstanceLobby, LOADUI_TYPE.loginUI)
PaGlobal_SetLoadUIFunc(loadLoadingUI_Instance, LOADUI_TYPE.loadingUI)
PaGlobal_SetLoadUIFunc(preLoadGameUI_Instance, LOADUI_TYPE.preLoadGameUI)
PaGlobal_SetLoadUIFunc(loadGameUI_Instance, LOADUI_TYPE.GameUI)
