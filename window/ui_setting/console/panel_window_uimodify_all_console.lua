PaGlobal_UIModify = {
  _panelID = {
    MainStatusRemaster = 1,
    LeftIcon = 2,
    ServantIcon = 3,
    TimeBar = 4,
    Radar = 5,
    MainQuest = 6,
    Chat = 7,
    SkillCoolTime = 8,
    AppliedBuffList = 9,
    QuickMenu = 10,
    ItemCountingWidget = 11,
    SkillCommand = 12,
    SkillLog = 13
  },
  _panel = {
    [1] = {
      control = Panel_MainStatus_Remaster,
      index = CppEnums.PAGameUIType.PAGameUIPanel_MainStatusRemaster,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_1"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = true
    },
    [2] = {
      control = Panel_PersonalIcon_Left,
      index = CppEnums.PAGameUIType.PAGameUIPanel_LeftIcon,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_FAMILYBUFF_NAME"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = true
    },
    [3] = {
      control = Panel_Window_Servant,
      index = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_2"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    },
    [4] = {
      control = Panel_TimeBar,
      index = CppEnums.PAGameUIType.PAGameUIPanel_TimeBar,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_20"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = true
    },
    [5] = {
      control = Panel_Radar,
      index = CppEnums.PAGameUIType.PAGameUIPanel_RadarMap,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_3"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = true
    },
    [6] = {
      control = Panel_MainQuest,
      index = CppEnums.PAGameUIType.PAGameUIPanel_MainQuest,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PANELCONTROL_4"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    },
    [7] = {
      control = Panel_Widget_ChattingViewer_Renew,
      index = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleChattingViewer,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_CHATTING"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    },
    [8] = {
      control = Panel_SkillCooltime,
      index = CppEnums.PAGameUIType.PAGameUIPanel_SkillCoolTime,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLCOOLTIME"),
      isChange = false,
      isShow = false,
      showFixed = false,
      posFixed = false
    },
    [9] = {
      control = Panel_AppliedBuffList,
      index = CppEnums.PAGameUIType.PAGameUIPanel_AppliedBuffList,
      name = PAGetString(Defines.StringSheet_GAME, "BUFF_LIST"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    },
    [10] = {
      control = Panel_Widget_QuickMenu,
      index = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleQuickMenu,
      name = PAGetString(Defines.StringSheet_GAME, "GAME_CONSOLE_RINGMENU"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = true
    },
    [11] = {
      control = Panel_WhereUseItemDirection,
      index = CppEnums.PAGameUIType.PAGameUIPanel_ConsoleItemCountingWidget,
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WIDGET_BTN"),
      isChange = false,
      isShow = false,
      showFixed = true,
      posFixed = false
    },
    [12] = {
      control = Panel_SkillCommand,
      index = CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLCOMMANDGUIDE"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    },
    [13] = {
      control = Panel_Widget_SkillLog,
      index = CppEnums.PAGameUIType.PAGameUIPanel_SkillLog,
      name = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_SKILLLOG"),
      isChange = false,
      isShow = true,
      showFixed = false,
      posFixed = false
    }
  },
  _panelCount = 13,
  _panelPoolBG = nil,
  _panelPool = {},
  _ui = {
    stc_subBG = nil,
    list2_panelList = nil,
    stc_keyGuideBG = nil,
    txt_keyGuideLSClick = nil,
    txt_keyGuideY = nil,
    txt_keyGuideX = nil,
    txt_keyGuideA = nil,
    txt_keyGuideB = nil,
    txt_keyGuideLTX = nil,
    txt_keyGuideRS = nil
  },
  _BG_Texture = {
    {
      107,
      1,
      159,
      54
    },
    {
      1,
      1,
      53,
      54
    },
    {
      53,
      1,
      106,
      54
    }
  },
  _keyGuideType = {Default = 1, MoveUI = 2},
  _beforeUiMode = Defines.UIMode.eUIMode_Default,
  _renderMode = nil,
  _isMoveUIMode = false,
  _isFixPanelPos = false,
  _currentMoveIndex = nil,
  _selectAll = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_UIModify_All_Console_1.lua")
runLua("UI_Data/Script/Window/UI_Setting/Console/Panel_Window_UIModify_All_Console_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_UISettingInit")
function FromClient_UISettingInit()
  PaGlobal_UIModify:initialize()
end
