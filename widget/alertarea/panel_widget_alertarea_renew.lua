function ResetPos_WidgetButton()
end
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local AlwaysOpenType = {
  eALERT_Menu = 0,
  eALERT_Setting = 1,
  eALERT_PearlShop = 2,
  eALERT_PcRoomReward = 3,
  eALERT_MarketPlace = 4,
  eALERT_Spread = 5,
  eALERT_PearlShop_HotDeal = 6,
  eALERT_QuestList = 7,
  eALERT_TimeChallengeReward = 8,
  count = 9
}
local AlertType = {
  eALERT_Hunting = 0,
  eALERT_Coupon = 1,
  eALERT_LearnSkill = 2,
  eALERT_NewStoryKnowledge = 3,
  eALERT_NewKnowledge = 4,
  eALERT_Mail = 5,
  eALERT_ChallengeReward = 6,
  eALERT_NewFriend = 7,
  eALERT_BlackSpiritQuest = 8,
  eALERT_WeightOver = 9,
  eALERT_EndurancePc = 10,
  eALERT_EnduranceHorse = 11,
  eALERT_EnduranceCarriage = 12,
  eALERT_EnduranceShip = 13,
  eALERT_BatterEquipment = 14,
  eALERT_MyBossMonster = 15,
  eALERT_OfflineMode = 16,
  eALERT_TotalReward = 17,
  eALERT_Acquire_Title = 18,
  eALERT_BlackSpiritAdventureDice = 19,
  eALERT_SeasonBanner = 20,
  eALERT_Count = 21,
  eALERT_CashProductDiscount = 22,
  eALERT_MarketPlace_MyBiddingUpdate = 23
}
local Panel_Widget_Alert_info = {
  _ui = {
    Static_Bg = nil,
    Button_Spread = nil,
    StaticText_SpreadCount = nil,
    Button_Hunting = nil,
    StaticText_HuntingCount = nil,
    Button_Coupon = nil,
    StaticText_CouponCount = nil,
    Button_LearnSkill = nil,
    StaticText_LearnSkillCount = nil,
    Button_NewStoryKnowledge = nil,
    StaticText_NewStoryKnowledgeCount = nil,
    Button_NewKnowledge = nil,
    StaticText_NewKnowledgeCount = nil,
    Button_Mail = nil,
    Button_ChallengeReward = nil,
    StaticText_ChallengeRewardCount = nil,
    Button_NewFriend = nil,
    StaticText_FriendRequestCount = nil,
    Button_BlackSpiritQuest = nil,
    Button_WeightOver = nil,
    Button_EndurancePc = nil,
    Button_EnduranceHorse = nil,
    Button_EnduranceCarriage = nil,
    Button_EnduranceShip = nil,
    Button_BatterEquipment = nil,
    Button_Menu = nil,
    Button_CashShop = nil,
    Button_CashShop_HotDeal = nil,
    StaticText_HotDealTime = nil,
    Button_PcRoomReward = nil,
    StaticText_PcRoomRewardTime = nil,
    Button_TimeChallengeReward = nil,
    StaticText_TimeChallengeRewardTime = nil,
    Button_MarketPlace = nil,
    StaticText_MarketPlaceCount = nil,
    Button_MyBossMonster = nil,
    StaticText_BossMonsterCount = nil,
    Button_QuestList = nil,
    StaticText_QuestListCount = nil,
    Button_TotalReward = nil,
    StaticText_TotalRewardCount = nil,
    Button_TitleAlert = nil,
    StaticText_TitleCount = nil,
    Button_BlackSpiritAdventureDice = nil,
    Button_SeasonBanner = nil,
    MessageBg = nil,
    MsgCloseButton = nil,
    MsgIcon = nil,
    MsgTime = nil,
    MsgContent = nil,
    Static_BlackSpiritAdvBanner = nil,
    Button_BannerPlay = nil,
    Static_SeasonBanner = nil,
    Button_notShowToday = nil,
    Static_Bubbles = {}
  },
  _pos = {
    baseSpcae = 5,
    buttonBasePosY = 0,
    buttonSizeY = 35
  },
  _speadCount = 0,
  _alramTime = 0,
  _alertShow = {
    [AlertType.eALERT_Hunting] = false,
    [AlertType.eALERT_Coupon] = false,
    [AlertType.eALERT_LearnSkill] = false,
    [AlertType.eALERT_NewStoryKnowledge] = false,
    [AlertType.eALERT_NewKnowledge] = false,
    [AlertType.eALERT_Mail] = false,
    [AlertType.eALERT_ChallengeReward] = false,
    [AlertType.eALERT_NewFriend] = false,
    [AlertType.eALERT_BlackSpiritQuest] = false,
    [AlertType.eALERT_WeightOver] = false,
    [AlertType.eALERT_EndurancePc] = false,
    [AlertType.eALERT_EnduranceHorse] = false,
    [AlertType.eALERT_EnduranceCarriage] = false,
    [AlertType.eALERT_EnduranceShip] = false,
    [AlertType.eALERT_BatterEquipment] = false,
    [AlertType.eALERT_MyBossMonster] = false,
    [AlertType.eALERT_OfflineMode] = false,
    [AlertType.eALERT_TotalReward] = false,
    [AlertType.eALERT_CashProductDiscount] = false,
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = false,
    [AlertType.eALERT_Acquire_Title] = false,
    [AlertType.eALERT_BlackSpiritAdventureDice] = false,
    [AlertType.eALERT_SeasonBanner] = false
  },
  _alertNeedUpdate = {
    [AlertType.eALERT_Hunting] = false,
    [AlertType.eALERT_Coupon] = false,
    [AlertType.eALERT_LearnSkill] = false,
    [AlertType.eALERT_NewStoryKnowledge] = false,
    [AlertType.eALERT_NewKnowledge] = false,
    [AlertType.eALERT_Mail] = false,
    [AlertType.eALERT_ChallengeReward] = false,
    [AlertType.eALERT_NewFriend] = false,
    [AlertType.eALERT_BlackSpiritQuest] = false,
    [AlertType.eALERT_WeightOver] = false,
    [AlertType.eALERT_EndurancePc] = false,
    [AlertType.eALERT_EnduranceHorse] = false,
    [AlertType.eALERT_EnduranceCarriage] = false,
    [AlertType.eALERT_EnduranceShip] = false,
    [AlertType.eALERT_BatterEquipment] = false,
    [AlertType.eALERT_MyBossMonster] = false,
    [AlertType.eALERT_OfflineMode] = false,
    [AlertType.eALERT_TotalReward] = false,
    [AlertType.eALERT_CashProductDiscount] = false,
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = false,
    [AlertType.eALERT_Acquire_Title] = false,
    [AlertType.eALERT_BlackSpiritAdventureDice] = false,
    [AlertType.eALERT_SeasonBanner] = false
  },
  _alertButton = {
    [AlertType.eALERT_Hunting] = nil,
    [AlertType.eALERT_Coupon] = nil,
    [AlertType.eALERT_LearnSkill] = nil,
    [AlertType.eALERT_NewStoryKnowledge] = nil,
    [AlertType.eALERT_NewKnowledge] = nil,
    [AlertType.eALERT_Mail] = nil,
    [AlertType.eALERT_ChallengeReward] = nil,
    [AlertType.eALERT_NewFriend] = nil,
    [AlertType.eALERT_BlackSpiritQuest] = nil,
    [AlertType.eALERT_WeightOver] = nil,
    [AlertType.eALERT_EndurancePc] = nil,
    [AlertType.eALERT_EnduranceHorse] = nil,
    [AlertType.eALERT_EnduranceCarriage] = nil,
    [AlertType.eALERT_EnduranceShip] = nil,
    [AlertType.eALERT_BatterEquipment] = nil,
    [AlertType.eALERT_MyBossMonster] = nil,
    [AlertType.eALERT_OfflineMode] = nil,
    [AlertType.eALERT_TotalReward] = nil,
    [AlertType.eALERT_CashProductDiscount] = nil,
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = nil,
    [AlertType.eALERT_Acquire_Title] = nil,
    [AlertType.eALERT_BlackSpiritAdventureDice] = nil,
    [AlertType.eALERT_SeasonBanner] = nil
  },
  _alertClosedButton = {
    [AlertType.eALERT_Hunting] = nil,
    [AlertType.eALERT_Coupon] = nil,
    [AlertType.eALERT_LearnSkill] = nil,
    [AlertType.eALERT_NewStoryKnowledge] = nil,
    [AlertType.eALERT_NewKnowledge] = nil,
    [AlertType.eALERT_Mail] = nil,
    [AlertType.eALERT_ChallengeReward] = nil,
    [AlertType.eALERT_NewFriend] = nil,
    [AlertType.eALERT_BlackSpiritQuest] = nil,
    [AlertType.eALERT_WeightOver] = nil,
    [AlertType.eALERT_EndurancePc] = nil,
    [AlertType.eALERT_EnduranceHorse] = nil,
    [AlertType.eALERT_EnduranceCarriage] = nil,
    [AlertType.eALERT_EnduranceShip] = nil,
    [AlertType.eALERT_BatterEquipment] = nil,
    [AlertType.eALERT_MyBossMonster] = nil,
    [AlertType.eALERT_OfflineMode] = nil,
    [AlertType.eALERT_TotalReward] = nil,
    [AlertType.eALERT_CashProductDiscount] = nil,
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = nil,
    [AlertType.eALERT_Acquire_Title] = nil,
    [AlertType.eALERT_BlackSpiritAdventureDice] = nil,
    [AlertType.eALERT_SeasonBanner] = nil
  },
  _alertData = {
    [AlertType.eALERT_Hunting] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_Coupon] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_LearnSkill] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_NewStoryKnowledge] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_NewKnowledge] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_Mail] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_ChallengeReward] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_NewFriend] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_BlackSpiritQuest] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_WeightOver] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_EndurancePc] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_EnduranceHorse] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_EnduranceCarriage] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_EnduranceShip] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_BatterEquipment] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_MyBossMonster] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_OfflineMode] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_TotalReward] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_CashProductDiscount] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_Acquire_Title] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_BlackSpiritAdventureDice] = {
      name = "",
      desc = "",
      count = 0
    },
    [AlertType.eALERT_SeasonBanner] = {
      name = "",
      desc = "",
      count = 0
    }
  },
  _alertIconPath = {
    [AlertType.eALERT_Hunting] = {
      _x1 = 73,
      _y1 = 301,
      _x2 = 108,
      _y2 = 336
    },
    [AlertType.eALERT_Coupon] = {
      _x1 = 325,
      _y1 = 301,
      _x2 = 360,
      _y2 = 336
    },
    [AlertType.eALERT_LearnSkill] = {
      _x1 = 253,
      _y1 = 301,
      _x2 = 288,
      _y2 = 336
    },
    [AlertType.eALERT_NewStoryKnowledge] = {
      _x1 = 37,
      _y1 = 301,
      _x2 = 72,
      _y2 = 336
    },
    [AlertType.eALERT_NewKnowledge] = {
      _x1 = 1,
      _y1 = 301,
      _x2 = 36,
      _y2 = 336
    },
    [AlertType.eALERT_Mail] = {
      _x1 = 289,
      _y1 = 301,
      _x2 = 324,
      _y2 = 336
    },
    [AlertType.eALERT_ChallengeReward] = {
      _x1 = 361,
      _y1 = 301,
      _x2 = 396,
      _y2 = 336
    },
    [AlertType.eALERT_NewFriend] = {
      _x1 = 37,
      _y1 = 409,
      _x2 = 72,
      _y2 = 444
    },
    [AlertType.eALERT_BlackSpiritQuest] = {
      _x1 = 1,
      _y1 = 409,
      _x2 = 36,
      _y2 = 444
    },
    [AlertType.eALERT_WeightOver] = {
      _x1 = 217,
      _y1 = 193,
      _x2 = 252,
      _y2 = 228
    },
    [AlertType.eALERT_EndurancePc] = {
      _x1 = 217,
      _y1 = 157,
      _x2 = 252,
      _y2 = 192
    },
    [AlertType.eALERT_EnduranceHorse] = {
      _x1 = 253,
      _y1 = 193,
      _x2 = 288,
      _y2 = 228
    },
    [AlertType.eALERT_EnduranceCarriage] = {
      _x1 = 253,
      _y1 = 157,
      _x2 = 288,
      _y2 = 192
    },
    [AlertType.eALERT_EnduranceShip] = {
      _x1 = 217,
      _y1 = 229,
      _x2 = 252,
      _y2 = 264
    },
    [AlertType.eALERT_BatterEquipment] = {
      _x1 = 433,
      _y1 = 301,
      _x2 = 468,
      _y2 = 336
    },
    [AlertType.eALERT_MyBossMonster] = {
      _x1 = 289,
      _y1 = 409,
      _x2 = 324,
      _y2 = 444
    },
    [AlertType.eALERT_OfflineMode] = {
      _x1 = 253,
      _y1 = 373,
      _x2 = 288,
      _y2 = 408
    },
    [AlertType.eALERT_TotalReward] = {
      _x1 = 397,
      _y1 = 409,
      _x2 = 432,
      _y2 = 444
    },
    [AlertType.eALERT_CashProductDiscount] = {
      _x1 = 132,
      _y1 = 1,
      _x2 = 174,
      _y2 = 43
    },
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = {
      _x1 = 289,
      _y1 = 301,
      _x2 = 324,
      _y2 = 336
    },
    [AlertType.eALERT_Acquire_Title] = {
      _x1 = 37,
      _y1 = 481,
      _x2 = 72,
      _y2 = 516
    },
    [AlertType.eALERT_BlackSpiritAdventureDice] = {
      _x1 = 0,
      _y1 = 0,
      _x2 = 1,
      _y2 = 1
    },
    [AlertType.eALERT_SeasonBanner] = {
      _x1 = 0,
      _y1 = 0,
      _x2 = 1,
      _y2 = 1
    }
  },
  _alertMessage = {
    [AlertType.eALERT_Hunting] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_0"),
    [AlertType.eALERT_Coupon] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_1"),
    [AlertType.eALERT_LearnSkill] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_2"),
    [AlertType.eALERT_NewStoryKnowledge] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_3"),
    [AlertType.eALERT_NewKnowledge] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_4"),
    [AlertType.eALERT_Mail] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_5"),
    [AlertType.eALERT_ChallengeReward] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_6"),
    [AlertType.eALERT_NewFriend] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_7"),
    [AlertType.eALERT_BlackSpiritQuest] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_8"),
    [AlertType.eALERT_WeightOver] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_9"),
    [AlertType.eALERT_EndurancePc] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_10"),
    [AlertType.eALERT_EnduranceHorse] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_11"),
    [AlertType.eALERT_EnduranceCarriage] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_12"),
    [AlertType.eALERT_EnduranceShip] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_13"),
    [AlertType.eALERT_BatterEquipment] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_14"),
    [AlertType.eALERT_MyBossMonster] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_15"),
    [AlertType.eALERT_OfflineMode] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_16"),
    [AlertType.eALERT_TotalReward] = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_17"),
    [AlertType.eALERT_CashProductDiscount] = "",
    [AlertType.eALERT_MarketPlace_MyBiddingUpdate] = "",
    [AlertType.eALERT_Acquire_Title] = "",
    [AlertType.eALERT_BlackSpiritAdventureDice] = "",
    [AlertType.eALERT_SeasonBanner] = ""
  },
  _currentAlertType = AlertType.eALERT_Count,
  _isDiscountPeriodFirstAlert = false,
  pcChallengeName = "",
  normalChallengeName = "",
  pcChallengeTimeString = "",
  normalChallengeTimeString = "",
  _defaultBgSizeY = 0,
  _linkLastTitleKey = 0,
  _linkLastTitleCategory = 0,
  _progressQuestCount = 0,
  _effectTime = 2.95,
  _effectCheckTime = 2.95,
  _isAcquireDiceEffect = true,
  _alertBubbleOnTime = {},
  _alertBubbleAutoHideTime = 20,
  _alertIsShowMyBossMonster = false,
  _screenSizeX = 0,
  _initialize = false
}
local equipCount = CppEnums.EquipSlotNo.equipSlotNoCount
local cardListNormal = {}
local cardListImportant = {}
local haveBatterEquip = false
function Panel_Widget_Alert_info:registEventHandler()
  self._ui.Button_Spread:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_ClickSpread()")
  self._ui.Button_Spread:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_Spread .. ")")
  self._ui.Button_Spread:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertButton[index] then
      self._alertButton[index]:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_HandleOver(" .. index .. ")")
      self._alertButton[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_HandleLClick(" .. index .. ")")
      self._alertButton[index]:addInputEvent("Mouse_RUp", "PaGlobalFunc_Widget_Alert_HandleRClick(" .. index .. ")")
      self._alertButton[index]:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_HandleOut()")
      if nil ~= self._alertClosedButton[index] then
        self._alertClosedButton[index]:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_HandleOver(" .. index .. ")")
        self._alertClosedButton[index]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_HandleLClick(" .. index .. ")")
        self._alertClosedButton[index]:addInputEvent("Mouse_RUp", "PaGlobalFunc_Widget_Alert_HandleRClick(" .. index .. ")")
        self._alertClosedButton[index]:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_HandleOut()")
      end
    end
  end
  self._ui.Button_Menu:addInputEvent("Mouse_LUp", "Panel_Menu_ShowToggle()")
  self._ui.Button_Menu:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_Menu .. ")")
  self._ui.Button_Menu:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_Setting:addInputEvent("Mouse_LUp", "showGameOption()")
  self._ui.Button_Setting:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_Setting .. ")")
  self._ui.Button_Setting:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_CashShop:addInputEvent("Mouse_LUp", "GlobalKeyBinder_MouseKeyMap(18)")
  self._ui.Button_CashShop:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_PearlShop .. ")")
  self._ui.Button_CashShop:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_CashShop_HotDeal:addInputEvent("Mouse_LUp", "Process_UIMode_CommonWindow_CashShop_HotDeal()")
  self._ui.Button_CashShop_HotDeal:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_PearlShop_HotDeal .. ")")
  self._ui.Button_CashShop_HotDeal:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_PcRoomReward:addInputEvent("Mouse_LUp", "HandleClicked_PcRoomReward()")
  self._ui.Button_PcRoomReward:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_PcRoomReward .. ")")
  self._ui.Button_PcRoomReward:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_TimeChallengeReward:addInputEvent("Mouse_LUp", "HandleClicked_NormalChallengeReward()")
  self._ui.Button_TimeChallengeReward:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_TimeChallengeReward .. ")")
  self._ui.Button_TimeChallengeReward:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.Button_MarketPlace:addInputEvent("Mouse_LUp", "FGlobal_ItemMarketAlarmList_New_Open()")
  self._ui.Button_MarketPlace:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_MarketPlace .. ")")
  self._ui.Button_MarketPlace:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  if true == _ContentsGroup_NewUI_Quest_All then
    self._ui.Button_QuestList:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_Open()")
  else
    self._ui.Button_QuestList:addInputEvent("Mouse_LUp", "Panel_Window_QuestNew_Show(true)")
  end
  self._ui.Button_QuestList:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_Alert_ButtonTooltipShow(" .. AlwaysOpenType.eALERT_QuestList .. ")")
  self._ui.Button_QuestList:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_Alert_ButtonTooltipHide()")
  self._ui.btn_blackEffect:addInputEvent("Mouse_LUp", "PaGlobalFunc_PersonalMonster_PanelOpen()")
  self._ui.stc_blackBubbleBG:addInputEvent("Mouse_LUp", "PaGlobalFunc_PersonalMonster_PanelOpen()")
  self._ui.Button_TitleAlert:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_ButtonTitleAcquire()")
  self._ui.Button_BlackSpiritAdventureDice:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_AlertArea_BlackSpiritAdventureOpen()")
  self._ui.MsgCloseButton:addInputEvent("Mouse_LUp", "Panel_Widget_Alert_info_AlramHide()")
  self._ui.Static_BlackSpiritAdvBanner:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Alert_BlackSpiritAdv_BannerClick()")
  self._ui.Button_BannerPlay:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Alert_BlackSpiritAdv_BannerClick()")
  self._ui.Button_notShowToday:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Alert_SeasonBanner_SaveToday()")
  self._ui.Static_SeasonBanner:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_Alert_SeasonBanner()")
end
function Panel_Widget_Alert_info:registerMessageHandler()
  Panel_UIMain:RegisterUpdateFunc("FromClient_Widget_Alert_UpdatePerFrame")
  registerEvent("onScreenResize", "FromClient_Widget_Alert_Resize")
  registerEvent("FromClient_UpdateCouponInfo", "FromClient_Widget_Alert_UpdateCoupon")
  registerEvent("FromClient_RegisterCoupon", "FromClient_Widget_Alert_UpdateCoupon")
  registerEvent("EventSkillWindowUpdate", "FromClient_Widget_Alert_EventSkillWindowUpdate")
  registerEvent("EventSkillWindowClearSkillAll", "FromClient_Widget_Alert_EventSkillWindowUpdate")
  registerEvent("EventSkillWindowClearSkill", "FromClient_Widget_Alert_EventSkillWindowUpdate")
  registerEvent("EventSkillWindowClearSkillByPoint", "FromClient_Widget_Alert_EventSkillWindowUpdate")
  registerEvent("FromClient_NewKnowledge", "FromClient_Widget_Alert_NewKnowledge")
  registerEvent("FromClient_NewMail", "FromClient_Widget_Alert_NewMail")
  registerEvent("ResponseMail_showList", "FromClient_Widget_Alert_NewMailRead")
  registerEvent("FromClient_CompleteBenefitReward", "FromClient_Widget_Alert_CompleteBenefitReward")
  registerEvent("FromClient_ChallengeReward_UpdateText", "FromClient_Widget_Alert_CompleteBenefitReward")
  registerEvent("FromClient_NewFriend", "FromClient_Widget_Alert_NewFriendAlert")
  registerEvent("ResponseFriendList_updateAddFriends", "FromClient_Widget_Alert_Update_NewFriend")
  registerEvent("FromClient_NoticeNewMessage", "FromClient_Widget_Alert_NoticeNewMessage")
  registerEvent("FromClient_UpdateQuestList", "FromClient_Widget_Alert_BlackSpiritQuest")
  registerEvent("FromClient_WeightPenaltyChanged", "FromClient_Widget_Alert_WeightOver")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Widget_Alert_WeightOver")
  registerEvent("FromClient_GetEquipableItem", "FromClient_Widget_Alert_BatterEquipment")
  registerEvent("EventEquipmentUpdate", "FromClient_Widget_Alert_BatterEquipment")
  registerEvent("FromClient_AttendanceUpdate", "FromClient_Widget_Alert_AttendanceUpdate")
  registerEvent("FromClient_AttendanceUpdateAll", "FromClient_Widget_Alert_AttendanceUpdateAll")
  registerEvent("FromClient_PendingRewardLogUpdated", "FromClient_Widget_Alert_TotalRewardUpdated")
  registerEvent("FromClient_PendingRewardUpdated", "FromClient_PendingRewardUpdated")
  if true == ToClient_IsContentsGroupOpen("500") then
    registerEvent("FromClient_notifyReservePersonalMonster", "FromClient_notifyReservePersonalMonster")
    registerEvent("FromClient_notifySpawnPersonalMonster", "FromClient_notifySpawnPersonalMonster")
    registerEvent("FromClient_notifyDeathPersonalMonster", "FromClient_notifyDeathPersonalMonster")
  end
  registerEvent("EventSelfPlayerLevelUp", "PaGlobalFunc_Widget_Alert_Check_MyBossMonster()")
  registerEvent("FromClient_Widget_Alert_ResetTime", "FromClient_Widget_Alert_ResetTime")
  registerEvent("FromClient_CompleteShowIconChallengeReward", "FromClient_CompleteShowIconChallengeReward")
  registerEvent("FromClient_Aquire_LastTitle", "FromClient_Widget_Alert_Title")
  registerEvent("FromClient_NotifyBlackSpiritAdvAlert", "FromClient_Widget_Alert_BlackSpiritAdventrueDice")
  registerEvent("FromClient_NotifyBlackSpiritAdvNoDice", "FromClient_Widget_Alert_BlackSpiritAdventrueNoDice")
  registerEvent("FromClient_NotifySeasonBanner", "FromClient_NotifySeasonBanner")
end
function Panel_Widget_Alert_info:initialize()
  self:childControl()
  self:resize()
  self:setButton()
  self:registerMessageHandler()
  self:registEventHandler()
  self:initBubble()
  self._defaultBgSizeY = 60
  self._initialize = true
end
function Panel_Widget_Alert_info:initBubble()
  self._ui.Static_Bubbles = {}
  self._ui.Static_Bubbles[AlertType.eALERT_TotalReward] = UI.getChildControl(self._ui.Button_TotalReward, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_MyBossMonster] = UI.getChildControl(self._ui.Button_MyBossMonster, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_BatterEquipment] = UI.getChildControl(self._ui.Button_BatterEquipment, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_Acquire_Title] = UI.getChildControl(self._ui.Button_TitleAlert, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_ChallengeReward] = UI.getChildControl(self._ui.Button_ChallengeReward, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_NewKnowledge] = UI.getChildControl(self._ui.Button_NewKnowledge, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_NewStoryKnowledge] = UI.getChildControl(self._ui.Button_NewStoryKnowledge, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_LearnSkill] = UI.getChildControl(self._ui.Button_LearnSkill, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_Coupon] = UI.getChildControl(self._ui.Button_Coupon, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_Mail] = UI.getChildControl(self._ui.Button_Mail, "Static_Bubble_Tail")
  self._ui.Static_Bubbles[AlertType.eALERT_NewFriend] = UI.getChildControl(self._ui.Button_NewFriend, "Static_Bubble_Tail")
  self._screenSizeX = getScreenSizeX()
  self._alertBubbleOnTime = {}
  for index = 0, AlertType.eALERT_Count - 1 do
    self._alertBubbleOnTime[index] = 0
    if nil ~= self._ui.Static_Bubbles[index] then
      self._ui.Static_Bubbles[index]:SetShow(false)
    end
  end
  PaGlobalFunc_Widget_Alert_SetUnReadMailCount()
  PaGlobalFunc_Widget_Alert_SetExpiredMailBubble()
end
function Panel_Widget_Alert_info:resize()
  Panel_UIMain:ComputePos()
  local diceAlertButton = Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritAdventureDice]
  if nil ~= diceAlertButton and true == diceAlertButton:GetShow() then
    diceAlertButton:EraseAllEffect()
    diceAlertButton:AddEffect("UI_BlackSpirit_Dice_02A", true, 0, 0)
  end
  ToClient_RequestSeasonBannerForNoSeasonUser()
end
function Panel_Widget_Alert_info:setButton()
  self._alertButton[AlertType.eALERT_Hunting] = self._ui.Button_Hunting
  self._alertButton[AlertType.eALERT_Coupon] = self._ui.Button_Coupon
  self._alertButton[AlertType.eALERT_LearnSkill] = self._ui.Button_LearnSkill
  self._alertButton[AlertType.eALERT_NewStoryKnowledge] = self._ui.Button_NewStoryKnowledge
  self._alertButton[AlertType.eALERT_NewKnowledge] = self._ui.Button_NewKnowledge
  self._alertButton[AlertType.eALERT_Mail] = self._ui.Button_Mail
  self._alertButton[AlertType.eALERT_ChallengeReward] = self._ui.Button_ChallengeReward
  self._alertButton[AlertType.eALERT_NewFriend] = self._ui.Button_NewFriend
  self._alertButton[AlertType.eALERT_BlackSpiritQuest] = self._ui.Button_BlackSpiritQuest
  self._alertButton[AlertType.eALERT_WeightOver] = self._ui.Button_WeightOver
  self._alertButton[AlertType.eALERT_EndurancePc] = self._ui.Button_EndurancePc
  self._alertButton[AlertType.eALERT_EnduranceHorse] = self._ui.Button_EnduranceHorse
  self._alertButton[AlertType.eALERT_EnduranceCarriage] = self._ui.Button_EnduranceCarriage
  self._alertButton[AlertType.eALERT_EnduranceShip] = self._ui.Button_EnduranceShip
  self._alertButton[AlertType.eALERT_BatterEquipment] = self._ui.Button_BatterEquipment
  self._alertButton[AlertType.eALERT_MyBossMonster] = self._ui.Button_MyBossMonster
  self._alertButton[AlertType.eALERT_OfflineMode] = self._ui.Button_OfflineMode
  self._alertButton[AlertType.eALERT_TotalReward] = self._ui.Button_TotalReward
  self._alertButton[AlertType.eALERT_Acquire_Title] = self._ui.Button_TitleAlert
  self._alertButton[AlertType.eALERT_CashProductDiscount] = self._ui.Button_CashShop
  self._alertButton[AlertType.eALERT_SeasonBanner] = self._ui.Button_SeasonBanner
  self._alertButton[AlertType.eALERT_MarketPlace_MyBiddingUpdate] = self._ui.Button_MarketPlace
  self._alertButton[AlertType.eALERT_BlackSpiritAdventureDice] = self._ui.Button_BlackSpiritAdventureDice
end
function Panel_Widget_Alert_info:childControl()
  self._ui.Static_Bg = UI.getChildControl(Panel_UIMain, "Static_Bg")
  self._ui.Button_Spread = UI.getChildControl(self._ui.Static_Bg, "Button_Spread")
  self._ui.StaticText_SpreadCount = UI.getChildControl(self._ui.Button_Spread, "StaticText_Count")
  self._ui.Button_Hunting = UI.getChildControl(self._ui.Static_Bg, "Button_Hunting")
  self._ui.StaticText_HuntingCount = UI.getChildControl(self._ui.Button_Hunting, "StaticText_HuntingCount")
  self._ui.Button_Coupon = UI.getChildControl(self._ui.Static_Bg, "Button_Coupon")
  self._ui.StaticText_CouponCount = UI.getChildControl(self._ui.Button_Coupon, "StaticText_CouponCount")
  self._ui.Button_LearnSkill = UI.getChildControl(self._ui.Static_Bg, "Button_LearnSkill")
  self._ui.StaticText_LearnSkillCount = UI.getChildControl(self._ui.Button_LearnSkill, "StaticText_LearnSkillCount")
  self._ui.Button_NewStoryKnowledge = UI.getChildControl(self._ui.Static_Bg, "Button_NewStoryKnowledge")
  self._ui.StaticText_NewStoryKnowledgeCount = UI.getChildControl(self._ui.Button_NewStoryKnowledge, "StaticText_NewStoryKnowledgeCount")
  self._ui.Button_NewKnowledge = UI.getChildControl(self._ui.Static_Bg, "Button_NewKnowledge")
  self._ui.StaticText_NewKnowledgeCount = UI.getChildControl(self._ui.Button_NewKnowledge, "StaticText_NewKnowledgeCount")
  self._ui.Button_Mail = UI.getChildControl(self._ui.Static_Bg, "Button_Mail")
  self._ui.Button_ChallengeReward = UI.getChildControl(self._ui.Static_Bg, "Button_ChallengeReward")
  self._ui.StaticText_ChallengeRewardCount = UI.getChildControl(self._ui.Button_ChallengeReward, "StaticText_ChallengeRewardCount")
  self._ui.Button_NewFriend = UI.getChildControl(self._ui.Static_Bg, "Button_NewFriend")
  self._ui.StaticText_FriendRequestCount = UI.getChildControl(self._ui.Button_NewFriend, "StaticText_FriendCount")
  self._ui.Button_BlackSpiritQuest = UI.getChildControl(self._ui.Static_Bg, "Button_BlackSpiritQuest")
  self._ui.Button_WeightOver = UI.getChildControl(self._ui.Static_Bg, "Button_WeightOver")
  self._ui.Button_EndurancePc = UI.getChildControl(self._ui.Static_Bg, "Button_EndurancePc")
  self._ui.Button_EnduranceHorse = UI.getChildControl(self._ui.Static_Bg, "Button_EnduranceHorse")
  self._ui.Button_EnduranceCarriage = UI.getChildControl(self._ui.Static_Bg, "Button_EnduranceCarriage")
  self._ui.Button_EnduranceShip = UI.getChildControl(self._ui.Static_Bg, "Button_EnduranceShip")
  self._ui.Button_BatterEquipment = UI.getChildControl(self._ui.Static_Bg, "Button_BatterEquipment")
  self._ui.Button_OfflineMode = UI.getChildControl(self._ui.Static_Bg, "Button_OfflineMode")
  self._ui.Button_TotalReward = UI.getChildControl(self._ui.Static_Bg, "Button_TotalReward")
  self._ui.txt_TotalRewardCount = UI.getChildControl(self._ui.Button_TotalReward, "StaticText_TotalRewardCount")
  self._ui.Button_TitleAlert = UI.getChildControl(self._ui.Static_Bg, "Button_TitleAlert")
  self._ui.StaticText_TitleCount = UI.getChildControl(self._ui.Button_TitleAlert, "StaticText_TitleCount")
  self._ui.Button_BlackSpiritAdventureDice = UI.getChildControl(self._ui.Static_Bg, "Button_BlackspiritAdventureDice_Alert")
  self._ui.Button_SeasonBanner = UI.getChildControl(self._ui.Static_Bg, "Button_SeasonBanner")
  self._ui.Button_Menu = UI.getChildControl(self._ui.Static_Bg, "Button_Menu")
  self._ui.Button_Setting = UI.getChildControl(self._ui.Static_Bg, "Button_Setting")
  self._ui.Button_CashShop = UI.getChildControl(self._ui.Static_Bg, "Button_CashShop")
  self._ui.Button_CashShop_HotDeal = UI.getChildControl(self._ui.Static_Bg, "Button_CashShop_HotDeal")
  self._ui.StaticText_HotDealTime = UI.getChildControl(self._ui.Button_CashShop_HotDeal, "StaticText_Desc")
  self._ui.Button_PcRoomReward = UI.getChildControl(self._ui.Static_Bg, "Button_PCRoomReward")
  self._ui.StaticText_PcRoomRewardTime = UI.getChildControl(self._ui.Button_PcRoomReward, "StaticText_Desc")
  self._ui.Button_TimeChallengeReward = UI.getChildControl(self._ui.Static_Bg, "Button_TimeChallengeReward")
  self._ui.StaticText_TimeChallengeRewardTime = UI.getChildControl(self._ui.Button_TimeChallengeReward, "StaticText_Desc")
  self._ui.Button_MarketPlace = UI.getChildControl(self._ui.Static_Bg, "Button_MarketPlaceAlert")
  self._ui.StaticText_MarketPlaceCount = UI.getChildControl(self._ui.Button_MarketPlace, "StaticText_Count")
  self._ui.Button_QuestList = UI.getChildControl(self._ui.Static_Bg, "Button_QuestListAlert")
  self._ui.StaticText_QuestListCount = UI.getChildControl(self._ui.Button_QuestList, "StaticText_Count")
  self._ui.Button_MyBossMonster = UI.getChildControl(self._ui.Static_Bg, "Button_MyBossMonster")
  self._ui.StaticText_BossMonsterCount = UI.getChildControl(self._ui.Button_MyBossMonster, "StaticText_BossMonsterCount")
  self._ui.btn_blackEffect = UI.getChildControl(self._ui.Button_MyBossMonster, "Button_blackSpiritEffect")
  local stc_bossmonsterTail = UI.getChildControl(self._ui.Button_MyBossMonster, "Static_Bubble_Tail")
  self._ui.stc_blackBubbleBG = UI.getChildControl(stc_bossmonsterTail, "Static_blackBubble")
  self._ui.txt_blakcDesc = UI.getChildControl(self._ui.stc_blackBubbleBG, "StaticText_Desc")
  self._ui.txt_blakcDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_BLACKSPIRIT1"))
  self._ui.MessageBg = UI.getChildControl(Panel_UIMain, "Static_AlertMessageBg")
  self._ui.MsgCloseButton = UI.getChildControl(self._ui.MessageBg, "Button_Win_Close")
  self._ui.MsgIcon = UI.getChildControl(self._ui.MessageBg, "Static_Icon")
  self._ui.MsgTime = UI.getChildControl(self._ui.MessageBg, "StaticText_Time")
  self._ui.MsgContent = UI.getChildControl(self._ui.MessageBg, "StaticText_Message")
  self._ui.MsgContent:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.Static_BlackSpiritAdvBanner = UI.getChildControl(Panel_UIMain, "Static_BlackSpiritAdvBanner")
  self._ui.Button_BannerPlay = UI.getChildControl(self._ui.Static_BlackSpiritAdvBanner, "Button_Play")
  self._ui.Static_SeasonBanner = UI.getChildControl(Panel_UIMain, "Static_SeasonBanner")
  self._ui.Button_notShowToday = UI.getChildControl(self._ui.Static_SeasonBanner, "CheckButton_1")
end
function Panel_Widget_Alert_info:updateIcons(forced, ignoerSetDataType1)
  local spreadCount = 0
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertShow[index] then
      self:setData(index)
      if self._alertShow[index] then
        spreadCount = spreadCount + 1
      end
    end
  end
  if self._ui.Button_Spread:IsCheck() then
    self._ui.StaticText_SpreadCount:SetText(spreadCount)
    self._ui.StaticText_SpreadCount:SetShow(true)
    return
  else
    self._ui.StaticText_SpreadCount:SetShow(false)
  end
  self:updateIconPos()
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertShow[index] then
      self._alertButton[index]:SetShow(self._alertShow[index])
    end
  end
  if true == isGameTypeKR2() then
    self._alertButton[AlertType.eALERT_MarketPlace_MyBiddingUpdate]:SetShow(false)
  end
end
function Panel_Widget_Alert_info:updateIconsSpecifyIcon(index)
  if nil ~= self._alertShow[index] then
    self:setData(index)
  end
  local spreadCount = 0
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertShow[index] and self._alertShow[index] then
      spreadCount = spreadCount + 1
    end
  end
  if self._ui.Button_Spread:IsCheck() then
    self._ui.StaticText_SpreadCount:SetText(spreadCount)
    self._ui.StaticText_SpreadCount:SetShow(true)
    return
  else
    self._ui.StaticText_SpreadCount:SetShow(false)
  end
  self:updateIconPos()
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertShow[index] then
      self._alertButton[index]:SetShow(self._alertShow[index])
    end
  end
end
function Panel_Widget_Alert_info:updateIconPos()
  local basePosXRight = self._ui.Button_Spread:GetPosX() - self._ui.Button_Spread:GetSizeX() - self._pos.baseSpcae
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._alertShow[index] and true == self._alertShow[index] then
      self._alertButton[index]:SetPosX(basePosXRight)
      basePosXRight = basePosXRight - 35 - self._pos.baseSpcae
    end
  end
end
function Panel_Widget_Alert_info:showAllButton()
  self:updateIcons(true)
  self._ui.Button_Spread:SetCheck(false)
end
function Panel_Widget_Alert_info:setButtonShow(alertType, value, alertOtherText)
  if nil == alertType then
    return
  end
  if alertType < 0 or alertType >= AlertType.eALERT_Count then
    return
  end
  if nil == self._alertShow[alertType] then
    return
  end
  if self._currentAlertType == alertType and not value then
    Panel_Widget_Alert_info_AlramHide()
  end
  if not self._alertShow[alertType] and value then
    Panel_Widget_Alert_info:AlramShow(alertType, alertOtherText, __eTextMode_Limit_AutoWrap)
  end
  self._alertShow[alertType] = value
end
function PaGlobalFunc_UiMain_SetShow(isShow)
  Panel_UIMain:SetShow(true, false)
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_UIMenu, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    Panel_UIMain:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_UIMenu, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
end
function Panel_Widget_Alert_info:open()
  PaGlobalFunc_UiMain_SetShow(true)
end
function Panel_Widget_Alert_info:close()
  PaGlobalFunc_UiMain_SetShow(false)
end
function Panel_Widget_Alert_info:setData(alertType)
  if alertType == AlertType.eALERT_Hunting then
    PaGlobalFunc_Widget_Alert_Check_Hunting()
  elseif alertType == AlertType.eALERT_Coupon then
    PaGlobalFunc_Widget_Alert_Check_Coupon()
  elseif alertType == AlertType.eALERT_LearnSkill then
    PaGlobalFunc_Widget_Alert_Check_LearnSkill()
  elseif alertType == AlertType.eALERT_NewStoryKnowledge then
    PaGlobalFunc_Widget_Alert_Check_NewStoryKnowledge()
  elseif alertType == AlertType.eALERT_NewKnowledge then
    PaGlobalFunc_Widget_Alert_Check_NewKnowledge()
  elseif alertType == AlertType.eALERT_Mail then
    PaGlobalFunc_Widget_Alert_Check_Mail()
  elseif alertType == AlertType.eALERT_ChallengeReward then
    PaGlobalFunc_Widget_Alert_Check_ChallengeReward()
  elseif alertType == AlertType.eALERT_NewFriend then
    PaGlobalFunc_Widget_Alert_Check_NewFriend()
  elseif alertType == AlertType.eALERT_BlackSpiritQuest then
    PaGlobalFunc_Widget_Alert_Check_BlackSpiritQuest()
  elseif alertType == AlertType.eALERT_WeightOver then
    PaGlobalFunc_Widget_Alert_Check_WeightOver()
  elseif alertType == AlertType.eALERT_EndurancePc then
  elseif alertType == AlertType.eALERT_EnduranceHorse then
  elseif alertType == AlertType.eALERT_EnduranceCarriage then
  elseif alertType == AlertType.eALERT_EnduranceShip then
  elseif alertType == AlertType.eALERT_BatterEquipment then
    PaGlobalFunc_Widget_Alert_Check_BatterEquipment()
  elseif alertType == AlertType.eALERT_MyBossMonster then
    PaGlobalFunc_Widget_Alert_Check_MyBossMonster()
  elseif alertType == AlertType.eALERT_TotalReward then
    PaGlobalFunc_Widget_Alert_Check_RewardList()
  elseif alertType == AlertType.eALERT_OfflineMode then
    PaGlobalFunc_Widget_Alert_Check_OfflineMode()
  elseif alertType == AlertType.eALERT_MarketPlace_MyBiddingUpdate then
  elseif alertType == AlertType.eALERT_Acquire_Title then
    PaGlobalFunc_Widget_Alert_Check_AcquireTitle()
  elseif alertType == AlertType.eALERT_BlackSpiritAdventureDice then
    PaGlobalFunc_Widget_Alert_Check_BlackSpiritAdventureDice()
  elseif alertType == AlertType.eALERT_SeasonBanner then
  else
    _PA_LOG("mingu", "wrong alert type!")
  end
end
function Panel_Widget_Alert_info:handleLClick(alertType)
  if alertType == AlertType.eALERT_Hunt then
  elseif alertType == AlertType.eALERT_Coupon then
    IngameCashShopCoupon_Open()
  elseif alertType == AlertType.eALERT_LearnSkill then
    if false == _ContentsGroup_RenewUI_Skill then
      HandleMLUp_SkillWindow_OpenForLearn()
    else
      PaGlobalFunc_Skill_Open()
    end
  elseif alertType == AlertType.eALERT_NewStoryKnowledge then
    PaGlobalFunc_Widget_Alert_NewKnowledge(0)
  elseif alertType == AlertType.eALERT_NewKnowledge then
    PaGlobalFunc_Widget_Alert_NewKnowledge(1)
  elseif alertType == AlertType.eALERT_Mail then
    if true == _ContentsGroup_NewUI_Mail_All then
      PaGlobal_Window_Mail_All_WithRewardOpen(false)
    end
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Mail)
    self:setButtonShow(AlertType.eALERT_Mail, true, true)
  elseif alertType == AlertType.eALERT_ChallengeReward then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Present)
  elseif alertType == AlertType.eALERT_NewFriend then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_FriendList)
  elseif alertType == AlertType.eALERT_BlackSpiritQuest then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_BlackSpirit)
  elseif alertType == AlertType.eALERT_WeightOver then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
  elseif alertType == AlertType.eALERT_EndurancePc then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
  elseif alertType == AlertType.eALERT_EnduranceHorse then
  elseif alertType == AlertType.eALERT_EnduranceCarriage then
  elseif alertType == AlertType.eALERT_EnduranceShip then
  elseif alertType == AlertType.eALERT_BatterEquipment then
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_Inventory)
  elseif alertType == AlertType.eALERT_CashProductDiscount then
    PaGlobalFunc_InGameCashShop_ForcedOpenSaleTab()
    GlobalKeyBinder_MouseKeyMap(__eUiInputType_CashShop)
  elseif alertType == AlertType.eALERT_MarketPlace_MyBiddingUpdate then
    PaGlobalFunc_MarketPlace_Open()
    InputMLUp_MarketPlace_OpenMyWalletTab()
  elseif alertType == AlertType.eALERT_MyBossMonster then
    PaGlobalFunc_PersonalMonster_PanelOpen()
  elseif alertType == AlertType.eALERT_TotalReward then
    if true == _ContentsGroup_NewUI_TotalReward_All then
      PaGlobal_TotalReward_All_Open()
    else
      PaGlobal_TotalReward_Open()
    end
  elseif alertType == AlertType.eALERT_OfflineMode then
  elseif alertType == AlertType.eALERT_Acquire_Title then
    PaGlobalFunc_Widget_Alert_ButtonTitleAcquire()
  elseif alertType == AlertType.eALERT_BlackSpiritAdventureDice then
    FGlobal_BlackSpiritAdventure_Open()
    PaGlobalFunc_Menu_All_AddRecentMenuBlackSpiritAdventure()
  elseif alertType == AlertType.eALERT_SeasonBanner then
    HandleEventLUp_Widget_Alert_SeasonBanner()
  else
    _PA_LOG("mingu", "wrong alert type!")
  end
  self:setBubbleShow(false, alertType, true, true)
  audioPostEvent_SystemUi(0, 5)
  TooltipSimple_Hide()
end
function Panel_Widget_Alert_info:handleRClick(alertType)
  if alertType == AlertType.eALERT_Hunt then
  elseif alertType == AlertType.eALERT_Coupon then
  elseif alertType == AlertType.eALERT_LearnSkill then
  elseif alertType == AlertType.eALERT_NewStoryKnowledge then
  elseif alertType == AlertType.eALERT_NewKnowledge then
  elseif alertType == AlertType.eALERT_Mail then
  elseif alertType == AlertType.eALERT_ChallengeReward then
  elseif alertType == AlertType.eALERT_NewFriend then
  elseif alertType == AlertType.eALERT_BlackSpiritQuest then
  elseif alertType == AlertType.eALERT_WeightOver then
  elseif alertType == AlertType.eALERT_EndurancePc then
  elseif alertType == AlertType.eALERT_EnduranceHorse then
  elseif alertType == AlertType.eALERT_EnduranceCarriage then
  elseif alertType == AlertType.eALERT_EnduranceShip then
  elseif alertType == AlertType.eALERT_BatterEquipment then
  elseif alertType == AlertType.eALERT_MyBossMonster then
  elseif alertType == AlertType.eALERT_OfflineMode then
  else
    _PA_LOG("mingu", "wrong alert type!")
  end
end
function Panel_Widget_Alert_info:handleOver(alertType)
  local name = self._alertData[alertType].name
  local desc = self._alertData[alertType].desc
  local uiControl = self._alertButton[alertType]
  local showToolTip = false
  if alertType == AlertType.eALERT_Hunting then
    showToolTip = true
    PaGlobalFunc_Widget_Alert_Check_Hunting()
  elseif alertType == AlertType.eALERT_Coupon then
    showToolTip = true
  elseif alertType == AlertType.eALERT_LearnSkill then
    showToolTip = true
  elseif alertType == AlertType.eALERT_NewStoryKnowledge then
    showToolTip = true
  elseif alertType == AlertType.eALERT_NewKnowledge then
    showToolTip = true
  elseif alertType == AlertType.eALERT_Mail then
    showToolTip = true
  elseif alertType == AlertType.eALERT_ChallengeReward then
    showToolTip = true
  elseif alertType == AlertType.eALERT_NewFriend then
    showToolTip = true
  elseif alertType == AlertType.eALERT_BlackSpiritQuest then
    showToolTip = true
  elseif alertType == AlertType.eALERT_WeightOver then
    showToolTip = true
  elseif alertType == AlertType.eALERT_EndurancePc then
    showToolTip = true
  elseif alertType == AlertType.eALERT_EnduranceHorse then
    showToolTip = true
  elseif alertType == AlertType.eALERT_EnduranceCarriage then
    showToolTip = true
  elseif alertType == AlertType.eALERT_EnduranceShip then
    showToolTip = true
  elseif alertType == AlertType.eALERT_BatterEquipment then
    showToolTip = true
  elseif alertType == AlertType.eALERT_MyBossMonster then
    showToolTip = true
  elseif alertType == AlertType.eALERT_TotalReward then
    showToolTip = true
  elseif alertType == AlertType.eALERT_OfflineMode then
    showToolTip = true
  elseif alertType == AlertType.eALERT_Acquire_Title then
    showToolTip = true
  elseif alertType == AlertType.eALERT_BlackSpiritAdventureDice then
    showToolTip = true
  else
    _PA_LOG("mingu", "wrong alert type!")
  end
  if true == showToolTip then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function PaGlobalFunc_Widget_Alert_ButtonTooltipShow(buttonType)
  local self = Panel_Widget_Alert_info
  local name, desc, uiControl
  if AlwaysOpenType.eALERT_Spread == buttonType then
    uiControl = self._ui.Button_Spread
    local count = self._ui.StaticText_SpreadCount:GetText()
    if not self._ui.Button_Spread:IsCheck() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_0")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_1")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_2")
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_3", "count", count)
    end
  elseif AlwaysOpenType.eALERT_PearlShop == buttonType then
    uiControl = self._ui.Button_CashShop
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_4")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_5")
    local timeData = getDiscountPeriodRemainDiscountTime()
    local remainTime = convertStringFromDatetime(timeData)
    local remainDay = calculateDayFromDateDay(timeData)
    if 0 < Int64toInt32(timeData) and Int64toInt32(remainDay) < 3 then
      desc = desc .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CASHPRODUCTDISCOUNT_REMAINTIME", "remainTime", remainTime)
    end
  elseif AlwaysOpenType.eALERT_PearlShop_HotDeal == buttonType then
    uiControl = self._ui.Button_CashShop_HotDeal
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIPNAME_HOTDEAL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIPDESC_HOTDEAL")
    local timeData = ToClient_getRemainHotDealTime()
    local remainTime = convertStringFromDatetime(timeData)
    if 0 < Int64toInt32(timeData) then
      desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_11")
    end
  elseif AlwaysOpenType.eALERT_PcRoomReward == buttonType then
    uiControl = self._ui.Button_PcRoomReward
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_6")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_7")
    SetPcChallengeRemainedTimeInfo()
    if "" ~= self.pcChallengeName then
      desc = self.pcChallengeName .. "  (" .. self.pcChallengeTimeString .. ")\n" .. desc
    end
  elseif AlwaysOpenType.eALERT_MarketPlace == buttonType then
    uiControl = self._ui.Button_MarketPlace
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_8")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_9")
  elseif AlwaysOpenType.eALERT_QuestList == buttonType then
    uiControl = self._ui.Button_QuestList
    name = PAGetString(Defines.StringSheet_RESOURCE, "QUESTLIST_TXT_LIST")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_QUESTLIST_DESC")
  elseif AlwaysOpenType.eALERT_Menu == buttonType then
    uiControl = self._ui.Button_Setting
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_TITLE")
    desc = nil
  elseif AlwaysOpenType.eALERT_Setting == buttonType then
    uiControl = self._ui.Button_Setting
    name = PAGetString(Defines.StringSheet_RESOURCE, "OPTION_TEXT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_TOOLTIP_10")
  elseif AlwaysOpenType.eALERT_TimeChallengeReward == buttonType then
    uiControl = self._ui.Button_TimeChallengeReward
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_CHALLENGETITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_CHALLENGEDESC")
    SetNormalChallengeRemainedTimeInfo()
    if "" ~= self.normalChallengeName then
      desc = self.normalChallengeName .. "  (" .. self.normalChallengeTimeString .. ")\n" .. desc
    end
  else
    return
  end
  TooltipSimple_Show(uiControl, name, desc)
end
function PaGlobalFunc_Widget_Alert_ButtonTooltipHide()
  TooltipSimple_Hide()
end
function PaGlobalFunc_Widget_Alert_GetShow()
  return Panel_Widget_Alert_info:GetShow()
end
function PaGlobalFunc_Widget_Alert_Open()
  local self = Panel_Widget_Alert_info
  self:open()
end
function PaGlobalFunc_Widget_Alert_Close()
  local self = Panel_Widget_Alert_info
  self:close()
end
function PaGlobalFunc_Widget_Alert_Show()
  local self = Panel_Widget_Alert_info
  self:open()
  self:showAllButton()
end
function PaGlobalFunc_Widget_Alert_Exit()
  local self = Panel_Widget_Alert_info
  self:close()
end
function PaGlobalFunc_Widget_Alert_HandleOver(alertType)
  local self = Panel_Widget_Alert_info
  self:handleOver(alertType)
end
function PaGlobalFunc_Widget_Alert_HandleLClick(alertType)
  local self = Panel_Widget_Alert_info
  self:handleLClick(alertType)
end
function PaGlobalFunc_Widget_Alert_HandleRClick(alertType)
  local self = Panel_Widget_Alert_info
  self:handleRClick(alertType)
end
function PaGlobalFunc_Widget_Alert_HandleOut()
  TooltipSimple_Hide()
end
function PaGlobalFunc_Widget_Alert_ClickSpread()
  local self = Panel_Widget_Alert_info
  local rotateAni = self._ui.Button_Spread:addRotateAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  rotateAni:SetStartRotate(0)
  rotateAni:SetEndRotate(0)
  rotateAni:SetRotateCount(1)
  local showIndex = 0
  if not self._ui.Button_Spread:IsCheck() then
    for index = 0, AlertType.eALERT_Count - 1 do
      if self._alertShow[index] then
        showIndex = showIndex + 1
        local control = self._alertButton[index]
        local MoveAni = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        MoveAni:SetStartPosition(self._ui.Button_Spread:GetPosX(), 0)
        MoveAni:SetEndPosition(self._ui.Button_Spread:GetPosX() + (control:GetSizeX() + 5) * showIndex * -1, 0)
        MoveAni:SetDisableWhileAni(true)
        control:SetShow(true)
      end
    end
    self._ui.StaticText_SpreadCount:SetShow(false)
  else
    for index = 0, AlertType.eALERT_Count - 1 do
      if self._alertShow[index] then
        showIndex = showIndex + 1
        local control = self._alertButton[index]
        local MoveAni = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        MoveAni:SetStartPosition(control:GetPosX(), 0)
        MoveAni:SetEndPosition(self._ui.Button_Spread:GetPosX(), 0)
        MoveAni:SetHideAtEnd(true)
        MoveAni:SetDisableWhileAni(true)
      end
    end
    self._ui.StaticText_SpreadCount:SetText(showIndex)
    self._ui.StaticText_SpreadCount:SetShow(true)
  end
  self._speadCount = showIndex
  TooltipSimple_Hide()
end
function Panel_Widget_Alert_info:AlramShow(alertType, alertOtherText, textMode)
  if false == ToClient_getShowRightBottomAlarm() then
    return
  end
  if nil == self._ui.MsgContent then
    return
  end
  if self._currentAlertType == AlertType.eALERT_CashProductDiscount then
    return
  end
  if true == ToClient_IsContentsGroupOpen("500") and alertType == AlertType.eALERT_MyBossMonster then
    return
  end
  if alertType == AlertType.eALERT_TotalReward then
    local rewardCnt = ToClient_GetPendingRewardCount()
    if nil == rewardCnt then
      return
    end
    rewardCnt = Int64toInt32(rewardCnt)
    if 0 == rewardCnt then
      return
    end
  elseif alertType == AlertType.eALERT_BlackSpiritAdventureDice then
    return
  elseif alertType == AlertType.eALERT_SeasonBanner then
    return
  end
  self._ui.MsgContent:SetTextMode(textMode)
  if __eTextMode_Limit_AutoWrap == textMode then
    self._ui.MsgContent:setLineCountByLimitAutoWrap(2)
  else
    self._ui.MsgContent:setLineCountByLimitAutoWrap(1)
  end
  self._currentAlertType = alertType
  local currentTime = ""
  self._ui.MsgTime:SetText(currentTime)
  if nil == alertOtherText then
    self._ui.MsgContent:SetText(self._alertMessage[alertType])
  else
    self._ui.MsgContent:SetText(alertOtherText)
  end
  local texture = self._alertIconPath[alertType]
  if alertType == AlertType.eALERT_CashProductDiscount then
    self._ui.MsgIcon:ChangeTextureInfoNameAsync("renewal/button/pc_btn_alert00.dds")
    self._ui.Button_CashShop:ResetVertexAni()
    self._ui.Button_CashShop:SetVertexAniRun("Ani_Color_New", true)
  else
    self._ui.MsgIcon:ChangeTextureInfoNameAsync("renewal/button/console_btn_main.dds")
  end
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.MsgIcon, texture._x1, texture._y1, texture._x2, texture._y2)
  self._ui.MsgIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.MsgIcon:setRenderTexture(self._ui.MsgIcon:getBaseTexture())
  local control = self._ui.MessageBg
  local moveAni1 = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni1:SetStartPosition(-40, control:GetPosY())
  moveAni1:SetEndPosition(40 - control:GetSizeX(), control:GetPosY())
  moveAni1:SetDisableWhileAni(true)
  control:SetShow(true)
  self._alramTime = 0
  self._ui.MessageBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlertMessageBg_HandleLClick(" .. alertType .. ")")
  if false == _ContentsGroup_RenewUI_ItemMarketPlace then
    FGlobal_MarketAlertMsg_ResetPos(true)
  end
end
function Panel_Widget_Alert_info:AlramHide()
  local control = self._ui.MessageBg
  local moveAni2 = control:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  moveAni2:SetStartPosition(control:GetPosX(), control:GetPosY())
  moveAni2:SetEndPosition(-40, control:GetPosY())
  moveAni2:SetHideAtEnd(true)
  moveAni2:SetDisableWhileAni(true)
  if false == _ContentsGroup_RenewUI_ItemMarketPlace then
    FGlobal_MarketAlertMsg_ResetPos(false)
  end
  self._ui.Button_CashShop:ResetVertexAni()
  self._ui.Button_CashShop:SetVertexAniRun("Ani_Colo_Reset", true)
  self._currentAlertType = AlertType.eALERT_Count
end
function Panel_Widget_Alert_info:setBubbleShow(isShow, alertType, param, isForce)
  if nil == alertType or alertType >= AlertType.eALERT_Count then
    return
  end
  local function setBubble(aShow, aType)
    self._alertBubbleOnTime[aType] = 0
    if nil ~= self._ui.Static_Bubbles[aType] then
      self._ui.Static_Bubbles[aType]:SetShow(aShow)
    end
  end
  if false == isShow then
    if AlertType.eALERT_MyBossMonster == alertType then
      self._alertBubbleOnTime[alertType] = -1
      if true == isForce then
        setBubble(false, alertType)
      end
      return
    end
    local isShown = false
    if nil ~= self._ui.Static_Bubbles[alertType] and true == self._ui.Static_Bubbles[alertType]:GetShow() then
      isShown = true
    end
    setBubble(false, alertType)
    if true == isShown and true == self._alertIsShowMyBossMonster then
      self._alertIsShowMyBossMonster = false
      setBubble(true, AlertType.eALERT_MyBossMonster)
    end
    return
  end
  if nil ~= self._ui.Static_Bubbles[AlertType.eALERT_MyBossMonster] and true == self._ui.Static_Bubbles[AlertType.eALERT_MyBossMonster]:GetShow() then
    self._alertIsShowMyBossMonster = true
  end
  if nil == self._alertButton[alertType] or false == self._alertButton[alertType]:GetShow() then
    return
  end
  local mailBubbleTxt = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALERTAREA_TOOLTIP_MAIL")
  local mailBubbleColor = Defines.Color.C_FFFFEDD4
  if AlertType.eALERT_Mail == alertType and nil ~= param and true == param then
    mailBubbleTxt = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALERTAREA_TOOLTIP_MAIL_1")
    mailBubbleColor = Defines.Color.C_FFD05D48
  end
  for index = 0, AlertType.eALERT_Count - 1 do
    setBubble(false, index)
  end
  setBubble(true, alertType)
  if nil ~= self._ui.Static_Bubbles[alertType] and true == self._ui.Static_Bubbles[alertType]:GetShow() then
    local gabX = 20
    local bubbleBg = UI.getChildControl(self._ui.Static_Bubbles[alertType], "Static_blackBubble")
    local bubbleTxt = UI.getChildControl(bubbleBg, "StaticText_Desc")
    if AlertType.eALERT_Mail == alertType then
      bubbleTxt:SetText(mailBubbleTxt)
      bubbleTxt:SetFontColor(mailBubbleColor)
    end
    bubbleBg:ComputePos()
    if bubbleTxt:GetTextSizeY() < bubbleBg:GetSizeX() then
      bubbleBg:SetSize(bubbleTxt:GetTextSizeX() + gabX, bubbleBg:GetSizeY())
    end
    local bubbleStartPosX = bubbleBg:GetParentPosX()
    local bubbleBgSizeX = bubbleBg:GetSizeX()
    if self._screenSizeX < bubbleStartPosX + bubbleBgSizeX then
      local movePosX = bubbleStartPosX + bubbleBgSizeX - self._screenSizeX + gabX
      bubbleBg:SetPosX(bubbleBg:GetPosX() - movePosX)
    end
  end
end
function Panel_Widget_Alert_info_AlramHide()
  Panel_Widget_Alert_info:AlramHide()
end
function PaGlobalFunc_AlertMessageBg_HandleLClick(alertType)
  Panel_Widget_Alert_info_AlramHide()
  PaGlobalFunc_Widget_Alert_HandleLClick(alertType)
end
function FGlobal_AlertMsgBg_ShowCheck()
  return Panel_Widget_Alert_info._ui.MessageBg:GetShow()
end
function PaGlobalFunc_PersonalMonster_EffectHide()
  local self = Panel_Widget_Alert_info
  self._ui.btn_blackEffect:SetShow(false)
  self._ui.btn_blackEffect:EraseAllEffect()
end
function PaGlobalFunc_Widget_Alert_Check_Hunting()
  local self = Panel_Widget_Alert_info
  local msg = {name = "", desc = ""}
  local whaleCount = ToClient_worldmapActorManagerGetActorRegionList(2)
  if whaleCount > 0 then
    for index = 0, whaleCount - 1 do
      local areaName = ToClient_worldmapActorManagerGetActorRegionByIndex(index)
      local count = ToClient_worldmapActorManagerGetActorCountByIndex(index)
      if nil ~= areaName then
        if 0 == index then
          msg.desc = msg.desc .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_FIND", "areaName", tostring(areaName), "count", count)
        else
          msg.desc = msg.desc .. "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_FIND", "areaName", tostring(areaName), "count", count)
        end
      end
    end
    msg.name = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_FIND_NAME")
  end
  local gargoyleCount = ToClient_worldmapActorManagerGetActorRegionList(3)
  if gargoyleCount > 0 then
    for index = 0, gargoyleCount - 1 do
      local areaName = ToClient_worldmapActorManagerGetActorRegionByIndex(index)
      local count = ToClient_worldmapActorManagerGetActorCountByIndex(index)
      if nil ~= areaName then
        if 0 == index then
          if whaleCount > 0 then
            msg.desc = msg.desc .. "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_GARGOYLE", "areaName", tostring(areaName), "count", count)
          else
            msg.desc = msg.desc .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_GARGOYLE", "areaName", tostring(areaName), "count", count)
          end
        else
          msg.desc = msg.desc .. "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_GARGOYLE", "areaName", tostring(areaName), "count", count)
        end
      end
    end
    msg.name = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_FIND_NAME")
  end
  local griffonCount = 0
  griffonCount = ToClient_worldmapActorManagerGetActorRegionList(4)
  if griffonCount > 0 then
    for index = 0, griffonCount - 1 do
      local areaName = ToClient_worldmapActorManagerGetActorRegionByIndex(index)
      local count = ToClient_worldmapActorManagerGetActorCountByIndex(index)
      if nil ~= areaName then
        if 0 == index then
          if "" == msg.desc then
            msg.desc = msg.desc .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_GRIFFON_DESC", "areaName", tostring(areaName), "count", count)
          else
            msg.desc = msg.desc .. "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_WILDGRIFFON_DESC", "areaName", tostring(areaName), "count", count)
          end
        else
          msg.desc = msg.desc .. "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_HUNTING_WILDGRIFFON_DESC", "areaName", tostring(areaName), "count", count)
        end
      end
    end
    msg.name = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_FIND_NAME")
  end
  if 0 == gargoyleCount + whaleCount + griffonCount then
    msg.name = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE")
    msg.desc = PAGetString(Defines.StringSheet_GAME, "LUA_MOVIEGUIDE_WHALE_NOT_FIND")
  end
  local totalCount = gargoyleCount + whaleCount + griffonCount
  local isHuntingButtonShow = totalCount > 0
  self._alertData[AlertType.eALERT_Hunting].name = msg.name
  self._alertData[AlertType.eALERT_Hunting].desc = msg.desc
  self._alertData[AlertType.eALERT_Hunting].count = totalCount
  if false == ToClient_IsContentsGroupOpen("28") then
    isHuntingButtonShow = false
  end
  self:setButtonShow(AlertType.eALERT_Hunting, isHuntingButtonShow)
  self._ui.StaticText_HuntingCount:SetText(totalCount)
end
function PaGlobalFunc_Widget_Alert_Check_CashProductDiscount()
  local self = Panel_Widget_Alert_info
  if false == self._isDiscountPeriodFirstAlert then
    return
  end
  local timeData = getDiscountPeriodRemainDiscountTime()
  local remainTime = convertStringFromDatetime(timeData)
  local remainDay = calculateDayFromDateDay(timeData)
  if 0 < Int64toInt32(timeData) and Int64toInt32(remainDay) < 3 then
    self._isDiscountPeriodFirstAlert = false
    local messageStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALERT_CASHPRODUCTDISCOUNT_REMAINTIME", "remainTime", remainTime)
    Panel_Widget_Alert_info:AlramShow(AlertType.eALERT_CashProductDiscount, messageStr, __eTextMode_Limit_AutoWrap)
  end
end
function PaGlobalFunc_Widget_Alert_Check_Coupon()
  local self = Panel_Widget_Alert_info
  self._alertButton[AlertType.eALERT_Coupon]:EraseAllEffect()
  local count = ToClient_GetCouponInfoUsableCount()
  if count <= 0 then
    self:setButtonShow(AlertType.eALERT_Coupon, false)
    return
  else
    self._alertButton[AlertType.eALERT_Coupon]:AddEffect("fUI_Coupon_01A", true, 2, 2)
    self:setButtonShow(AlertType.eALERT_Coupon, true)
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_COUPONTITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_COUPONDESC")
  self._alertData[AlertType.eALERT_Coupon].name = name
  self._alertData[AlertType.eALERT_Coupon].desc = desc
  self._ui.StaticText_CouponCount:SetText(count)
end
function PaGlobalFunc_Widget_Alert_Check_LearnSkill()
  local self = Panel_Widget_Alert_info
  local skillCount = FGlobal_EnableSkillReturn()
  if skillCount <= 0 then
    self:setButtonShow(AlertType.eALERT_LearnSkill, false)
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_SKILLTITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_SKILLDESC")
  self._alertData[AlertType.eALERT_LearnSkill].name = name
  self._alertData[AlertType.eALERT_LearnSkill].desc = desc
  self._ui.StaticText_LearnSkillCount:SetText(skillCount)
  self:setButtonShow(AlertType.eALERT_LearnSkill, true)
end
function PaGlobalFunc_Widget_Alert_Check_NewStoryKnowledge()
  local self = Panel_Widget_Alert_info
  local count = #cardListImportant
  if count == 0 then
    self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, false)
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_IMPORTANTKNOWLEDGETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_IMPORTANTKNOWLEDGEDESC")
  self._alertData[AlertType.eALERT_NewStoryKnowledge].name = name
  self._alertData[AlertType.eALERT_NewStoryKnowledge].desc = desc
  self._alertData[AlertType.eALERT_NewStoryKnowledge].count = count
  self._ui.StaticText_NewStoryKnowledgeCount:SetText(count)
  self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, true)
end
function PaGlobalFunc_Widget_Alert_Check_NewKnowledge()
  local self = Panel_Widget_Alert_info
  local count = #cardListNormal
  if count == 0 then
    self:setButtonShow(AlertType.eALERT_NewKnowledge, false)
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_NORMALKNOWLEDGETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_IMPORTANTKNOWLEDGEDESC")
  self._alertData[AlertType.eALERT_NewKnowledge].name = name
  self._alertData[AlertType.eALERT_NewKnowledge].desc = desc
  self._alertData[AlertType.eALERT_NewKnowledge].count = count
  self._ui.StaticText_NewKnowledgeCount:SetText(count)
  self:setButtonShow(AlertType.eALERT_NewKnowledge, true)
end
function PaGlobalFunc_Widget_Alert_Check_Mail()
  local self = Panel_Widget_Alert_info
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_MAILTITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_MAILDESC")
  self._alertButton[AlertType.eALERT_Mail]:EraseAllEffect()
  self:setButtonShow(AlertType.eALERT_Mail, true)
  self._alertData[AlertType.eALERT_Mail].name = name
  self._alertData[AlertType.eALERT_Mail].desc = desc
end
function PaGlobalFunc_Widget_Alert_Check_ChallengeReward()
  local self = Panel_Widget_Alert_info
  local challengeRWCount = ToClient_GetChallengeRemainRewardCount()
  if challengeRWCount <= 0 then
    self:setButtonShow(AlertType.eALERT_ChallengeReward, false)
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_CHALLENGETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_CHALLENGEDESC")
  self._alertData[AlertType.eALERT_ChallengeReward].name = name
  self._alertData[AlertType.eALERT_ChallengeReward].desc = desc
  self._alertData[AlertType.eALERT_ChallengeReward].count = challengeRWCount
  self._ui.StaticText_ChallengeRewardCount:SetText(challengeRWCount)
  self:setButtonShow(AlertType.eALERT_ChallengeReward, true)
end
function PaGlobalFunc_Widget_Alert_GetRemainRewardCount()
  local GetChallengeRewardFirstIndex = function(groupIndex)
    local length = ToClient_GetChallengeRewardInfoCount()
    local count = -1
    local prevGroup = -1
    for index = 0, length - 1 do
      local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(index)
      if nil ~= rewardWrapper and (prevGroup ~= rewardWrapper:getOptionalType() or 0 == rewardWrapper:getOptionalType()) then
        count = count + 1
        prevGroup = rewardWrapper:getOptionalType()
      end
      if count == groupIndex then
        return index
      end
    end
    return -1
  end
  local GetChallengeRewardGroupCount = function()
    local length = ToClient_GetChallengeRewardInfoCount()
    local count = 0
    local prevGroup = -1
    local optionalCount = 0
    for index = 0, length - 1 do
      local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(index)
      if nil ~= rewardWrapper and (prevGroup ~= rewardWrapper:getOptionalType() or 0 == rewardWrapper:getOptionalType()) then
        count = count + 1
        prevGroup = rewardWrapper:getOptionalType()
      end
    end
    return count
  end
  local remainRewardGroupCount = GetChallengeRewardGroupCount()
  local count = 0
  for index = 0, remainRewardGroupCount - 1 do
    local firstIndex = GetChallengeRewardFirstIndex(index)
    local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(firstIndex)
    if 0 == rewardWrapper:getOptionalType() then
      count = count + rewardWrapper:getRewardCount()
    else
      count = count + ToClient_GetChallengeRewardCountByOptionalType(rewardWrapper:getOptionalType())
    end
  end
  return count
end
local nextPcRoomGiftRewardTime = toInt64(0, 0)
function PaGlobalFunc_Widget_Alert_Check_PcRoomReward()
  local self = Panel_Widget_Alert_info
  local needUpdate = false
  local pcRoomRewardCount = 0
  local rewardCount = ToClient_GetChallengeRewardInfoCount()
  for index = 0, rewardCount - 1 do
    local rewardWrapper = ToClient_GetChallengeRewardInfoWrapper(index)
    if nil ~= rewardWrapper then
      local rewardType = rewardWrapper:getType()
      if rewardType == CppEnums.ChallengeType.eChallengeType_Benefit or rewardType == CppEnums.ChallengeType.eChallengeType_PcRoom or rewardType == CppEnums.ChallengeType.eChallengeType_EnchantPcRoomCount then
        pcRoomRewardCount = pcRoomRewardCount + 1
      end
    end
  end
  if pcRoomRewardCount == 0 then
    return needUpdate
  else
    needUpdate = true
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_REWARD_ALARMICON_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SPECIAL_REWARD_ALARMICON_TOOLTIP_DESC")
  self._alertData[AlertType.eALERT_PcRoomReward].name = name
  self._alertData[AlertType.eALERT_PcRoomReward].desc = desc
  self._alertData[AlertType.eALERT_PcRoomReward].count = pcRoomRewardCount
  return needUpdate
end
function PaGlobalFunc_Widget_Alert_Check_NewFriend()
  local self = Panel_Widget_Alert_info
  local addFrientCount = RequestFriends_getAddFriendCount()
  local newRequestFriend = ToClient_GetFriendNewRequest()
  if addFrientCount > 0 or true == newRequestFriend then
    self:setButtonShow(AlertType.eALERT_NewFriend, true)
  else
    self:setButtonShow(AlertType.eALERT_NewFriend, false)
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_MENUBUTTONTEXTID_FRIENDLIST")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_FRIEND_ALERT")
  self._alertData[AlertType.eALERT_NewFriend].name = name
  self._alertData[AlertType.eALERT_NewFriend].desc = desc
  self._alertData[AlertType.eALERT_NewFriend].count = addFrientCount
end
function PaGlobalFunc_Widget_Alert_Check_BlackSpiritQuest()
  local self = Panel_Widget_Alert_info
  local IsNormalBlackSpiritQuest = function(group, quest)
    local questList = ToClient_GetQuestList()
    if nil == questList then
      return true
    end
    local accesoryQuestCount = questList:getRegionMonsterKillQuestCount()
    for ii = 0, accesoryQuestCount - 1 do
      local accesoryQuestNo = questList:getRegionMonsterKillQuestAt(ii)
      if group == accesoryQuestNo._group and quest == accesoryQuestNo._quest then
        return false
      end
    end
    return true
  end
  local ProgressQuestCount = questList_getCheckedProgressQuestCount()
  local completeString = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_COMPLETEBLACKSPIRIT")
  if ProgressQuestCount > 0 then
    for index = 0, ProgressQuestCount - 1 do
      local progressQuestInfo = questList_getCheckedProgressQuestAt(index)
      local questNo = progressQuestInfo:getQuestNo()
      if progressQuestInfo:isSatisfied() then
        local uiQuestInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
        if uiQuestInfo:isCompleteBlackSpirit() and true == IsNormalBlackSpiritQuest(questNo._group, questNo._quest) then
          local name = PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_BLACKSOUL")
          local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_COMPLETEBLACKSPIRIT")
          self._alertData[AlertType.eALERT_BlackSpiritQuest].name = name
          self._alertData[AlertType.eALERT_BlackSpiritQuest].desc = desc
          self:setButtonShow(AlertType.eALERT_BlackSpiritQuest, true, completeString)
          return
        end
      end
    end
  end
  local newQuest = questList_doHaveNewQuest()
  local blackSpiritQuest = true
  if true == newQuest then
    self:setButtonShow(AlertType.eALERT_BlackSpiritQuest, true)
  else
    self:setButtonShow(AlertType.eALERT_BlackSpiritQuest, false)
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  local name = PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_BLACKSOUL")
  local desc = PAGetString(Defines.StringSheet_GAME, "PANEL_QUESTLIST_CALLINGYOUT")
  self._alertData[AlertType.eALERT_BlackSpiritQuest].name = name
  self._alertData[AlertType.eALERT_BlackSpiritQuest].desc = desc
end
function PaGlobal_Widget_Alert_BlackSpiritIcon_Effect()
  if nil == Panel_UIMain then
    return
  end
  if false == Panel_UIMain:GetShow() then
    return
  end
  if nil == Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritQuest] then
    _PA_ASSERT_NAME(false, "\236\149\132\236\157\180\236\189\152\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritQuest]:EraseAllEffect()
  Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritQuest]:AddEffect("UI_DarkSprit_Summon", false, 0, 0)
end
function PaGlobalFunc_Widget_Alert_TotalRewardIcon_Effect()
  if nil == Panel_UIMain then
    return
  end
  if false == Panel_UIMain:GetShow() then
    return
  end
  if nil == Panel_Widget_Alert_info._alertButton[AlertType.eALERT_TotalReward] then
    _PA_ASSERT_NAME(false, "\236\149\132\236\157\180\236\189\152\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  Panel_Widget_Alert_info._alertButton[AlertType.eALERT_TotalReward]:EraseAllEffect()
  Panel_Widget_Alert_info._alertButton[AlertType.eALERT_TotalReward]:AddEffect("fUI_BlackSpirit_Pass_Icon_Cast_01B", false, 0, 0)
  Panel_Widget_Alert_info._alertButton[AlertType.eALERT_TotalReward]:AddEffect("UI_BlackSpirit_Pass_Icon_Cast_01B", false, 0, 0)
end
function PaGlobalFunc_Widget_Alert_CheckFamilyCharacterLevel(compLevel)
  local characterDataCount = getCharacterDataCount()
  for index = 0, characterDataCount - 1 do
    local characterData = getCharacterDataByIndex(index)
    if compLevel <= characterData._level then
      return true
    end
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local curLevel = selfPlayer:get():getLevel()
    if compLevel <= curLevel then
      return true
    end
  end
  return false
end
local lastTotalWeight = 0
function PaGlobalFunc_Widget_Alert_Check_WeightOver()
  local self = Panel_Widget_Alert_info
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  FGlobal_Inventory_WeightCheck()
  local selfPlayer = selfPlayerWrapper:get()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local sumtotalWeight = allWeight / maxWeight * 100
  local totalWeightInt = sumtotalWeight / 1
  if lastTotalWeight == totalWeightInt then
    return false
  else
    lastTotalWeight = totalWeightInt
  end
  local totalWeight = string.format("%.0f", sumtotalWeight)
  local decreaseFairyWeight = Int64toInt32(ToClient_getDecreaseWeightByFairy()) / 10000
  local weightText = 100 + decreaseFairyWeight
  if sumtotalWeight - decreaseFairyWeight >= 90 then
    self:setButtonShow(AlertType.eALERT_WeightOver, true)
  else
    self:setButtonShow(AlertType.eALERT_WeightOver, false)
  end
  if sumtotalWeight >= 100 then
    self._alertButton[AlertType.eALERT_WeightOver]:EraseAllEffect()
    self._alertButton[AlertType.eALERT_WeightOver]:AddEffect("fUI_Weight_01A", true, -0.5, -1.3)
    if nil ~= self._alertClosedButton[AlertType.eALERT_WeightOver] then
      self._alertClosedButton[AlertType.eALERT_WeightOver]:EraseAllEffect()
      self._alertClosedButton[AlertType.eALERT_WeightOver]:AddEffect("fUI_Weight_01A", true, -0.5, -1.3)
    end
  elseif sumtotalWeight < 100 then
    self._alertButton[AlertType.eALERT_WeightOver]:EraseAllEffect()
    if nil ~= self._alertClosedButton[AlertType.eALERT_WeightOver] then
      self._alertClosedButton[AlertType.eALERT_WeightOver]:EraseAllEffect()
    end
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_WIGHTOVERTITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_TOOLTIP_WIGHTOVERDESC")
  if decreaseFairyWeight > 0 then
    desc = desc .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WEIGHT_MAIN_DEFAULT_VISUAL_WITH_FAIRY", "weight", tostring(weightText))
  end
  self._alertData[AlertType.eALERT_WeightOver].name = name
  self._alertData[AlertType.eALERT_WeightOver].desc = desc
  self._alertButton[AlertType.eALERT_WeightOver]:SetText(totalWeight .. "%")
  if nil ~= self._alertClosedButton[AlertType.eALERT_WeightOver] then
    self._alertClosedButton[AlertType.eALERT_WeightOver]:SetText(totalWeight .. "%")
  end
end
function PaGlobalFunc_Widget_Alert_Show_EndurancePc()
  local self = Panel_Widget_Alert_info
  if false == self._initialize then
    return
  end
  self:AlramShow(AlertType.eALERT_EndurancePc, nil, __eTextMode_Limit_AutoWrap)
end
function PaGlobalFunc_Widget_Alert_Show_EnduranceHorse()
  local self = Panel_Widget_Alert_info
  if false == self._initialize then
    return
  end
  self:AlramShow(AlertType.eALERT_EnduranceHorse, nil, __eTextMode_Limit_AutoWrap)
end
function PaGlobalFunc_Widget_Alert_Show_EnduranceCarriage()
  local self = Panel_Widget_Alert_info
  if false == self._initialize then
    return
  end
  self:AlramShow(AlertType.eALERT_EnduranceCarriage, nil, __eTextMode_Limit_AutoWrap)
end
function PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
  local self = Panel_Widget_Alert_info
  if false == self._initialize then
    return
  end
  self:AlramShow(AlertType.eALERT_EnduranceShip, nil, __eTextMode_Limit_AutoWrap)
end
function PaGlobalFunc_Widget_Alert_Check_BatterEquipment()
  local self = Panel_Widget_Alert_info
  if true == haveBatterEquip then
    self:setButtonShow(AlertType.eALERT_BatterEquipment, true)
  else
    self:setButtonShow(AlertType.eALERT_BatterEquipment, false)
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NEWEQUIP_TITLE")
  local desc = ""
  self._alertData[AlertType.eALERT_BatterEquipment].name = name
  self._alertData[AlertType.eALERT_BatterEquipment].desc = desc
end
function PaGlobalFunc_Widget_Alert_CheckReal_BatterEquipment()
  local self = Panel_Widget_Alert_info
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local existBatterEquip = false
  local selfPlayer = selfPlayerWrapper:get()
  local inventory = selfPlayer:getInventoryByType(CppEnums.ItemWhereType.eInventory)
  local invenUseSize = selfPlayer:getInventorySlotCount(not isNormalInventory)
  local invenMaxSize = inventory:sizeXXX()
  local whereType = CppEnums.ItemWhereType.eInventory
  for index = 0, invenUseSize - 1 do
    local slotNo = index + 1
    local itemWrapper = getInventoryItemByType(whereType, slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      if nil ~= itemSSW then
        local isServantEquip = itemSSW:isUsableServant()
        local isEquip = itemSSW:isEquipable()
        if not isServantEquip and true == isEquip and true == itemWrapper:checkConditions() then
          local currentEndurance = itemWrapper:get():getEndurance()
          local offencePoint = 0
          local defencePoint = 0
          local equipOffencePoint = 0
          local equipDefencePoint = 0
          local matchEquip = false
          local isAccessory = false
          if true == _ContentsGroup_NewUI_Inventory_All then
            offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = PaGlobalFunc_Inventory_All_CompareSpec(whereType, slotNo, isAccessory)
          elseif true == _ContentsGroup_RenewUI_Inventory then
            offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = PaGlobalFunc_Inventory_CompareSpec(whereType, slotNo, isAccessory)
          else
            offencePoint, defencePoint, equipOffencePoint, equipDefencePoint, matchEquip, isAccessory = _inventory_updateSlot_compareSpec(whereType, slotNo, isAccessory)
          end
          if nil ~= defencePoint and nil ~= offencePoint and currentEndurance > 0 and true == matchEquip and true == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) and defencePoint + offencePoint > equipDefencePoint + equipOffencePoint then
            existBatterEquip = true
            break
          end
        end
      end
    end
  end
  if true == existBatterEquip then
    haveBatterEquip = true
    self._alertButton[AlertType.eALERT_BatterEquipment]:EraseAllEffect()
    self._alertButton[AlertType.eALERT_BatterEquipment]:AddEffect("fUI_ItemBatter01", true, 0, 0)
    self:setButtonShow(AlertType.eALERT_BatterEquipment, true)
    self:setBubbleShow(true, AlertType.eALERT_BatterEquipment)
  else
    haveBatterEquip = false
    self:setButtonShow(AlertType.eALERT_BatterEquipment, false)
  end
end
function PaGlobalFunc_Widget_Alert_Check_Pos()
  local self = Panel_Widget_Alert_info
  local spanX = 0
  if getGamePadEnable() then
    self._ui.Button_Menu:SetShow(true)
    spanX = spanX + 40
  else
    self._ui.Button_Menu:SetShow(false)
  end
  if self._ui.Button_Setting:GetShow() then
    self._ui.Button_Setting:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  if self._ui.Button_CashShop:GetShow() or self._ui.Button_CashShop_HotDeal:GetShow() then
    self._ui.Button_CashShop:SetSpanSize(spanX, 0)
    self._ui.Button_CashShop_HotDeal:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  if self._ui.Button_MarketPlace:GetShow() then
    self._ui.Button_MarketPlace:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  if self._ui.Button_QuestList:GetShow() then
    self._ui.Button_QuestList:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  if self._ui.Button_TimeChallengeReward:GetShow() then
    self._ui.Button_TimeChallengeReward:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  if self._ui.Button_PcRoomReward:GetShow() then
    self._ui.Button_PcRoomReward:SetSpanSize(spanX, 0)
    spanX = spanX + 40
  end
  self._ui.Button_Spread:SetSpanSize(spanX, 0)
  self:updateIconPos()
end
function PaGlobalFunc_Widget_Alert_Check_MyBossMonster()
  if false == ToClient_IsContentsGroupOpen("500") then
    return
  end
  local self = Panel_Widget_Alert_info
  local desc = ""
  if 0 < ToClient_GetReservedPersonalMonsterCount() then
    self._ui.btn_blackEffect:SetShow(true)
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_MOUSEON_DESC")
  else
    self._ui.btn_blackEffect:SetShow(false)
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_ALERT_NOTACTIVATE")
  end
  if true == PaGlobal_Widget_AlertFamilyLevelCheck() then
    self:setButtonShow(AlertType.eALERT_MyBossMonster, true)
  end
  self._alertData[AlertType.eALERT_MyBossMonster].name = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALMONSTER_MOUSEON_TITLE")
  self._alertData[AlertType.eALERT_MyBossMonster].desc = desc
  FromClient_notifyDeathPersonalMonster()
end
function PaGlobal_Widget_AlertFamilyLevelCheck()
  for idx = 0, getCharacterDataCount() - 1 do
    local characterData = getCharacterDataByIndex(idx)
    if nil ~= characterData and 56 <= characterData._level then
      return true
    end
  end
  return false
end
function PaGlobalFunc_Widget_Alert_Check_RewardList()
  local self = Panel_Widget_Alert_info
  local rewardCnt = ToClient_GetPendingRewardCount()
  if nil == rewardCnt then
    self._ui.txt_TotalRewardCount:SetShow(false)
    return
  end
  rewardCnt = Int64toInt32(rewardCnt)
  local itemCount = 0
  local silverFlag = false
  if rewardCnt > 0 then
    for ii = 1, rewardCnt do
      local itemCnt = ToClient_GetPendingRewardItemCountByIndex(ii - 1)
      local itemKey = ToClient_GetPendingRewardItemKeyByIndex(ii - 1)
      if nil ~= itemCnt and nil ~= itemKey then
        if 1 ~= itemKey then
          itemCount = itemCount + 1
        elseif false == silverFlag then
          itemCount = itemCount + 1
          silverFlag = true
        end
      end
    end
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOTALREWARD_TITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOTALREWARD_TOOLTIP_DESC")
  if itemCount > 0 then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.Button_TotalReward, 397, 409, 432, 444)
    self._ui.Button_TotalReward:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.Button_TotalReward:setRenderTexture(self._ui.Button_TotalReward:getBaseTexture())
    self._ui.txt_TotalRewardCount:SetText(tostring(itemCount))
    self._ui.txt_TotalRewardCount:SetShow(true)
  else
    self._alertButton[AlertType.eALERT_TotalReward]:EraseAllEffect()
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.Button_TotalReward, 397, 373, 432, 408)
    self._ui.Button_TotalReward:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.Button_TotalReward:setRenderTexture(self._ui.Button_TotalReward:getBaseTexture())
    self._ui.txt_TotalRewardCount:SetShow(false)
  end
  if true == _ContentsGroup_TotalReward then
    self:setButtonShow(AlertType.eALERT_TotalReward, true)
  end
  self._alertData[AlertType.eALERT_TotalReward].name = name
  self._alertData[AlertType.eALERT_TotalReward].desc = desc
end
function PaGlobalFunc_Widget_Alert_Check_OfflineMode()
  local self = Panel_Widget_Alert_info
  if nil == self then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ENTERTOFIELDMODE_OFFLINE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_16")
  self._alertData[AlertType.eALERT_OfflineMode].name = name
  self._alertData[AlertType.eALERT_OfflineMode].desc = desc
  local isGhostMode = ToClient_getGhostMode()
  if true == isGhostMode then
    self:setButtonShow(AlertType.eALERT_OfflineMode, true)
  else
    self:setButtonShow(AlertType.eALERT_OfflineMode, false)
  end
end
function PaGlobalFunc_Widget_Alert_Check_AcquireTitle()
  local self = Panel_Widget_Alert_info
  if nil == self then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ACQUIRE_TITLE_ALERT_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ACQUIRE_TITLE_ALERT_DESC")
  self._alertData[AlertType.eALERT_Acquire_Title].name = name
  self._alertData[AlertType.eALERT_Acquire_Title].desc = desc
  local acquireTitleForPlaying = ToClient_GetAcquireTitleCountForPlaying()
  if acquireTitleForPlaying > 0 then
    self:setButtonShow(AlertType.eALERT_Acquire_Title, true)
    Panel_Widget_Alert_info._ui.StaticText_TitleCount:SetText(tostring(acquireTitleForPlaying))
  else
    self:setButtonShow(AlertType.eALERT_Acquire_Title, false)
    Panel_Widget_Alert_info._ui.StaticText_TitleCount:SetText(tostring(0))
  end
end
function PaGlobalFunc_Widget_Alert_Check_MarketPlaceMyBiddingUpdate(messageStr)
  local self = Panel_Widget_Alert_info
  if nil == self then
    return
  end
  if FGlobal_ItemMarket_AlarmList_SoundCheck() then
    audioPostEvent_SystemUi(10, 1)
    _AudioPostEvent_SystemUiForXBOX(10, 1)
  end
  Panel_Widget_Alert_info:AlramShow(AlertType.eALERT_MarketPlace_MyBiddingUpdate, messageStr, __eTextMode_Limit_AutoWrap)
end
function PaGlobalFunc_Widget_Alert_Check_BlackSpiritAdventureDice()
  if nil == Panel_Widget_Alert_info then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITADVENTURE_ALERT_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSPIRITADVENTURE_ALERT_DESC")
  Panel_Widget_Alert_info._alertData[AlertType.eALERT_BlackSpiritAdventureDice].name = name
  Panel_Widget_Alert_info._alertData[AlertType.eALERT_BlackSpiritAdventureDice].desc = desc
  local haveDice = ToClient_HaveBlackSpiritAdvDice()
  if true == haveDice then
    local diceAlertButton = Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritAdventureDice]
    if nil ~= diceAlertButton and false == diceAlertButton:GetShow() then
      Panel_Widget_Alert_info._isAcquireDiceEffect = true
      Panel_Widget_Alert_info._effectCheckTime = 0
      diceAlertButton:EraseAllEffect()
      diceAlertButton:AddEffect("UI_BlackSpirit_Dice_01A", true, 0, 0)
      local bannerControl = Panel_Widget_Alert_info._ui.Static_BlackSpiritAdvBanner
      if nil ~= bannerControl then
        bannerControl:SetShow(true)
        local showAni = bannerControl:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
        showAni.IsChangeChild = true
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        showAni:SetDisableWhileAni(true)
      end
    end
    Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_BlackSpiritAdventureDice, true)
  else
    Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_BlackSpiritAdventureDice, false)
  end
end
function PaGlobalFunc_Widget_Alert_SetUnReadMailCount()
  local self = Panel_Widget_Alert_info
  if nil == Panel_UIMain then
    return
  end
  if nil == self._ui.Button_Mail then
    return
  end
  local unReadMailCount = RequestMail_getUnReadMailCount()
  local unReadMassMailCount = ToClient_GetUnReadMailCount()
  local mailCount = UI.getChildControl(self._ui.Button_Mail, "StaticText_MailCount")
  if nil ~= mailCount then
    if unReadMailCount + unReadMassMailCount > 0 then
      mailCount:SetShow(true)
      mailCount:SetText(tostring(unReadMailCount + unReadMassMailCount))
    else
      mailCount:SetShow(false)
    end
  end
end
function PaGlobalFunc_Widget_Alert_SetExpiredMailBubble()
  local self = Panel_Widget_Alert_info
  if nil == Panel_UIMain then
    return
  end
  if nil == self._ui.Button_Mail then
    return
  end
  local isHasExpiredMail = RequestMail_getHasExpiredMail()
  local isHasExpiredMassMail = ToClient_GetHasExpiredMail()
  if true == isHasExpiredMail or true == isHasExpiredMassMail then
    self:setBubbleShow(true, AlertType.eALERT_Mail, true)
  end
end
function PaGlobalFunc_Widget_Alert_SetProgressQuestCount()
  local self = Panel_Widget_Alert_info
  if nil == Panel_UIMain then
    return
  end
  if nil == self._ui.Button_QuestList then
    return
  end
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return
  end
  self._progressQuestCount = 0
  local questGroupCount = questListInfo:getQuestGroupCount()
  for questGroupIndex = 0, questGroupCount - 1 do
    PaGlobalFunc_Widget_Alert_UpdateProgressQuestCount(questGroupIndex)
  end
  if nil ~= self._ui.StaticText_QuestListCount then
    self._ui.StaticText_QuestListCount:SetText(self._progressQuestCount)
  end
end
function PaGlobalFunc_Widget_Alert_UpdateProgressQuestCount(questGroupIndex)
  local self = Panel_Widget_Alert_info
  local questListInfo = ToClient_GetQuestList()
  if nil == questListInfo then
    return nil
  end
  local questGroupInfo = questListInfo:getQuestGroupAt(questGroupIndex)
  if true == questGroupInfo:isGroupQuest() then
    local questCount = questGroupInfo:getQuestCount()
    local startIdx = 0
    if questCount >= 2 then
      startIdx = questCount - 2
    end
    for questIdx = startIdx, questCount - 1 do
      local uiQuestInfo = questGroupInfo:getQuestAt(questIdx)
      if true == uiQuestInfo._isProgressing then
        self._progressQuestCount = self._progressQuestCount + 1
      end
    end
  else
    local uiQuestInfo = questGroupInfo:getQuestAt(0)
    if true == uiQuestInfo:isNormalQuest() and true == uiQuestInfo._isProgressing then
      self._progressQuestCount = self._progressQuestCount + 1
    end
  end
end
local updateTime = 30
local currentTime = 0
local nextPcRoomGiftRewardTime = toInt64(0, 0)
local nextGamePlayRewardTime = toInt64(0, 0)
function FromClient_Widget_Alert_UpdatePerFrame(deltaTime)
  local self = Panel_Widget_Alert_info
  currentTime = currentTime + deltaTime
  if updateTime < currentTime then
    self:updateIconPos()
    currentTime = 0
    PaGlobalFunc_Widget_Alert_Check_CashProductDiscount()
  end
  if not self._ui.MessageBg:GetShow() or self._currentAlertType == AlertType.eALERT_MarketPlace_MyBiddingUpdate and FGlobal_ItemMarketAlarm_CheckState() then
  else
    self._alramTime = self._alramTime + deltaTime
    if self._alramTime > 5 then
      self:AlramHide()
      self._alramTime = 0
    end
  end
  if true == ToClient_IsHotDealTime() then
    self._ui.Button_CashShop:SetShow(false)
    self._ui.Button_CashShop_HotDeal:SetShow(true)
    local hotDealtimeData = ToClient_getRemainHotDealTime()
    local hotDealremainTime = convertStringFromDatetime(hotDealtimeData)
    self._ui.StaticText_HotDealTime:SetText(hotDealremainTime)
  else
    self._ui.Button_CashShop:SetShow(true)
    self._ui.Button_CashShop_HotDeal:SetShow(false)
  end
  for index = 0, AlertType.eALERT_Count - 1 do
    if nil ~= self._ui.Static_Bubbles[index] and true == self._ui.Static_Bubbles[index]:GetShow() then
      self._alertBubbleOnTime[index] = self._alertBubbleOnTime[index] + deltaTime
      if -1 ~= self._alertBubbleOnTime[index] and self._alertBubbleAutoHideTime < self._alertBubbleOnTime[index] then
        self:setBubbleShow(false, index)
      end
    end
  end
  FGlobal_CashShopAlert_UpdatePerFrame(deltaTime)
  PaGlobalFunc_Widget_Alert_BlackSpiritAdventure_DiceEffect_UpdatePerFrame(deltaTime)
end
function PcRoomGift_TimeCheck()
  local self = Panel_Widget_Alert_info
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  local isRussiaPremiumPack = false
  if isGameTypeRussia() then
    isRussiaPremiumPack = selfPlayer:get():isApplyChargeSkill(9)
  end
  local nowPlayedTime = 0
  local challengeType = 4
  if isPremiumPcRoom then
    nowPlayedTime = ToClient_GetPcRoomPlayTime()
    challengeType = 4
  end
  if isRussiaPremiumPack then
    nowPlayedTime = ToClient_GetUserPlayTimePerDay()
    challengeType = 7
  end
  local checkCount = ToClient_GetProgressChallengeCount(challengeType)
  if 0 == checkCount then
    nextPcRoomGiftRewardTime = toInt64(0, 0)
    self._ui.Button_PcRoomReward:SetShow(false)
  end
  local remainedChallengeCount = 0
  for checkIdx = 0, checkCount - 1 do
    local progressInfo = ToClient_GetProgressChallengeAt(challengeType, checkIdx)
    local remainedTime = toInt64(0, 0)
    local isShowIcon = progressInfo:getIsShowIcon()
    if true == isShowIcon then
      if isPremiumPcRoom then
        remainedTime = toInt64(0, progressInfo:getNeedTimeForPcRoom() * 60) - nowPlayedTime
      end
      if isRussiaPremiumPack then
        remainedTime = toInt64(0, progressInfo:getNeedTimeForDay() * 60) - nowPlayedTime
      end
      if remainedTime > toInt64(0, 0) then
        remainedChallengeCount = remainedChallengeCount + 1
        if toInt64(0, 0) == nextPcRoomGiftRewardTime then
          nextPcRoomGiftRewardTime = remainedTime
          self.pcChallengeName = tostring(progressInfo:getName())
        elseif remainedTime < nextPcRoomGiftRewardTime then
          nextPcRoomGiftRewardTime = remainedTime
          self.pcChallengeName = tostring(progressInfo:getName())
        end
      end
    end
  end
  if (isPremiumPcRoom or isRussiaPremiumPack) and not Panel_NewEventProduct_Alarm:GetShow() and 0 ~= remainedChallengeCount then
    self._ui.Button_PcRoomReward:SetShow(true)
  elseif 0 == remainedChallengeCount then
    self._ui.Button_PcRoomReward:SetShow(false)
  end
  PaGlobalFunc_Widget_Alert_Check_Pos()
end
function PlayTime_TimeCheck()
  local self = Panel_Widget_Alert_info
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local nowPlayedTime = ToClient_GetUserPlayTimePerDay()
  local challengeType = 2
  local checkCount = ToClient_GetProgressChallengeCount(challengeType)
  if 0 == checkCount then
    nextGamePlayRewardTime = toInt64(0, 0)
    self._ui.Button_TimeChallengeReward:SetShow(false)
  end
  local remainedChallengeCount = 0
  for checkIdx = 0, checkCount - 1 do
    local progressInfo = ToClient_GetProgressChallengeAt(challengeType, checkIdx)
    local remainedTime = toInt64(0, 0)
    local isShowIcon = progressInfo:getIsShowIcon()
    if true == isShowIcon then
      remainedTime = toInt64(0, progressInfo:getNeedTimeForDay() * 60) - nowPlayedTime
      if remainedTime > toInt64(0, 0) then
        remainedChallengeCount = remainedChallengeCount + 1
        if toInt64(0, 0) == nextGamePlayRewardTime then
          nextGamePlayRewardTime = remainedTime
          self.normalChallengeName = tostring(progressInfo:getName())
        elseif remainedTime < nextGamePlayRewardTime then
          nextGamePlayRewardTime = remainedTime
          self.normalChallengeName = tostring(progressInfo:getName())
        end
      end
    end
  end
  if Panel_NewEventProduct_Alarm:GetShow() and 0 ~= remainedChallengeCount then
    self._ui.Button_TimeChallengeReward:SetShow(true)
  elseif 0 == remainedChallengeCount then
    self._ui.Button_TimeChallengeReward:SetShow(false)
  end
  PaGlobalFunc_Widget_Alert_Check_Pos()
end
function FromClient_Widget_Alert_ResetTime()
  PcRoomGift_TimeCheck()
  PlayTime_TimeCheck()
end
function FromClient_CompleteShowIconChallengeReward(challengeKey)
  local listCount = ToClient_GetOptionalCompletedChallengeCount()
  if nil ~= challengeKey then
    for checkIdx = 0, listCount - 1 do
      local completeInfo = ToClient_GetOptionalCompletedChallengeAt(checkIdx)
      if nil ~= completeInfo and challengeKey:get() == completeInfo:getKey():get() then
        local alarmStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TARGET_CHALLENGE_ALRAM_MESSAGE", "challengeName", completeInfo:getName())
        Panel_Widget_Alert_info:AlramShow(AlertType.eALERT_ChallengeReward, alarmStr, __eTextMode_Limit_AutoWrap)
      end
    end
  end
  FromClient_Widget_Alert_ResetTime()
end
function SetPcChallengeRemainedTimeInfo()
  local self = Panel_Widget_Alert_info
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
  local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
  local isRussiaPremiumPack = false
  if isGameTypeRussia() then
    isRussiaPremiumPack = selfPlayer:get():isApplyChargeSkill(9)
  end
  local nowPlayedTime = 0
  local challengeType = 4
  if isPremiumPcRoom then
    nowPlayedTime = ToClient_GetPcRoomPlayTime()
    challengeType = 4
  end
  if isRussiaPremiumPack then
    nowPlayedTime = ToClient_GetUserPlayTimePerDay()
    challengeType = 7
  end
  local checkCount = ToClient_GetProgressChallengeCount(challengeType)
  if 0 == checkCount then
    self.pcChallengeName = ""
    self.pcChallengeTimeString = ""
    return
  end
  local targetChallengeTime = toInt64(0, 0)
  for checkIdx = 0, checkCount - 1 do
    local progressInfo = ToClient_GetProgressChallengeAt(challengeType, checkIdx)
    local remainedTime = toInt64(0, 0)
    local isShowIcon = progressInfo:getIsShowIcon()
    if true == isShowIcon then
      if isPremiumPcRoom then
        remainedTime = toInt64(0, progressInfo:getNeedTimeForPcRoom() * 60) - nowPlayedTime
      end
      if isRussiaPremiumPack then
        remainedTime = toInt64(0, progressInfo:getNeedTimeForDay() * 60) - nowPlayedTime
      end
      if remainedTime > toInt64(0, 0) then
        if toInt64(0, 0) == targetChallengeTime then
          targetChallengeTime = remainedTime
          self.pcChallengeName = tostring(progressInfo:getName())
          self.pcChallengeTimeString = Util.Time.timeFormatting_Minute(Int64toInt32(targetChallengeTime))
          pcShowIconChallengeKey = progressInfo:getKey():get()
        elseif remainedTime < targetChallengeTime then
          targetChallengeTime = remainedTime
          self.pcChallengeName = tostring(progressInfo:getName())
          self.pcChallengeTimeString = Util.Time.timeFormatting_Minute(Int64toInt32(targetChallengeTime))
          pcShowIconChallengeKey = progressInfo:getKey():get()
        end
      end
    end
  end
  if "" ~= self.pcChallengeTimeString then
    self.pcChallengeTimeString = string.gsub(self.pcChallengeTimeString, "%s", "")
  end
end
function SetNormalChallengeRemainedTimeInfo()
  local self = Panel_Widget_Alert_info
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local nowPlayedTime = ToClient_GetUserPlayTimePerDay()
  local challengeType = 2
  local checkCount = ToClient_GetProgressChallengeCount(challengeType)
  if 0 == checkCount then
    self._ui.Button_TimeChallengeReward:SetShow(false)
    self.normalChallengeName = ""
    return
  end
  local targetChallengeTime = toInt64(0, 0)
  for checkIdx = 0, checkCount - 1 do
    local progressInfo = ToClient_GetProgressChallengeAt(challengeType, checkIdx)
    local remainedTime = toInt64(0, 0)
    local isShowIcon = progressInfo:getIsShowIcon()
    if true == isShowIcon then
      remainedTime = toInt64(0, progressInfo:getNeedTimeForDay() * 60) - nowPlayedTime
      if remainedTime > toInt64(0, 0) then
        if toInt64(0, 0) == targetChallengeTime then
          targetChallengeTime = remainedTime
          self.normalChallengeName = tostring(progressInfo:getName())
          self.normalChallengeTimeString = Util.Time.timeFormatting_Minute(Int64toInt32(targetChallengeTime))
          normalShowIconChallengeKey = progressInfo:getKey():get()
        elseif remainedTime < targetChallengeTime then
          targetChallengeTime = remainedTime
          self.normalChallengeName = tostring(progressInfo:getName())
          self.normalChallengeTimeString = Util.Time.timeFormatting_Minute(Int64toInt32(targetChallengeTime))
          normalShowIconChallengeKey = progressInfo:getKey():get()
        end
      end
    end
  end
  if "" ~= self.normalChallengeTimeString then
    self.normalChallengeTimeString = string.gsub(self.normalChallengeTimeString, "%s", "")
  end
end
function HandleClicked_PcRoomReward()
  if false == _ContentsGroup_NewUI_CharInfo_All then
    local idx = PaGlobal_CharacterInfo_GetChallengeIdx()
    PaGlobal_CharacterInfo:showWindow(idx)
    HandleClickedTapButton(5)
  elseif nil ~= Panel_CharacterInfo_All then
    if true == Panel_CharacterInfo_All:GetShow() then
      if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
        HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
        HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      else
        PaGlobalFunc_ChracterInfo_All_Close()
      end
    else
      PaGlobalFunc_ChracterInfo_All_Open(true)
      HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
      HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
    end
  end
end
function HandleClicked_NormalChallengeReward()
  if false == _ContentsGroup_NewUI_CharInfo_All then
    local idx = PaGlobal_CharacterInfo_GetChallengeIdx()
    PaGlobal_CharacterInfo:showWindow(idx)
    HandleClickedTapButton(5)
  elseif nil ~= Panel_CharacterInfo_All then
    if true == Panel_CharacterInfo_All:GetShow() then
      if false == PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._challenge) then
        HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
        HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
      else
        PaGlobalFunc_ChracterInfo_All_Close()
      end
    else
      PaGlobalFunc_ChracterInfo_All_Open(true)
      HandleEventLUp_ChracterInfo_All_ClickOtherTab(PaGlobal_CharInfo_All._TABINDEX._challenge)
      HandleEventLUp_CharInfoChallenge_All_ChallengeTabClick(5)
    end
  end
end
local marketPlaceAlertShow = false
function FGlobal_ItemMarket_AlarmIcon_Show()
  if true == isGameTypeKR2() then
    return
  end
  local self = Panel_Widget_Alert_info
  if nil ~= self._ui.Button_MarketPlace then
    self._ui.Button_MarketPlace:SetShow(true)
    FGlobal_ItemMarket_SetCount()
  else
    marketPlaceAlertShow = true
  end
end
function FGlobal_ItemMarket_SetCount()
  local self = Panel_Widget_Alert_info
  if nil == self._ui.StaticText_MarketPlaceCount then
    return
  end
  if false == _ContentsGroup_RenewUI_ItemMarketPlace then
    local alarmCount = FGlobal_ItemMarketAlarm_UnreadCount()
    self._ui.StaticText_MarketPlaceCount:SetText(alarmCount)
    self._ui.StaticText_MarketPlaceCount:SetShow(alarmCount > 0)
    self._ui.Button_MarketPlace:EraseAllEffect()
    if alarmCount > 0 then
      self._ui.Button_MarketPlace:AddEffect("fUI_ItemMarket_Alert_01A", true, 0, 0)
    end
  end
end
function FromClient_Widget_Alert_Init()
  local self = Panel_Widget_Alert_info
  self:initialize()
  PaGlobalFunc_Widget_Alert_Show()
  FromClient_Widget_Alert_CompleteBenefitReward()
  PcRoomGift_TimeCheck()
  PlayTime_TimeCheck()
  PaGlobalFunc_Widget_Alert_Check_RewardList()
  PaGlobalFunc_Widget_Alert_SetProgressQuestCount()
  if marketPlaceAlertShow then
    FGlobal_ItemMarket_AlarmIcon_Show()
  end
end
function FromClient_Widget_Alert_Resize()
  local self = Panel_Widget_Alert_info
  self:resize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_Alert_Init")
function FromClient_Widget_Alert_EventSkillWindowUpdate()
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_Check_LearnSkill()
  self:updateIcons(AlertType.eALERT_LearnSkill, true)
  self:setBubbleShow(true, AlertType.eALERT_LearnSkill)
end
function FromClient_Widget_Alert_UpdateCoupon()
  local self = Panel_Widget_Alert_info
  local count = ToClient_GetCouponInfoUsableCount()
  self._alertButton[AlertType.eALERT_Coupon]:EraseAllEffect()
  if count > 0 then
    self._alertButton[AlertType.eALERT_Coupon]:AddEffect("fUI_Coupon_01A", true, 2, 2)
    self:setButtonShow(AlertType.eALERT_Coupon, true)
    self:setBubbleShow(true, AlertType.eALERT_Coupon)
  else
    self:setButtonShow(AlertType.eALERT_Coupon, false)
  end
  self:updateIcons()
end
local cardKeyRaw
function FromClient_Widget_Alert_NewKnowledge(mentalCardStaticStatusWrapper)
  local self = Panel_Widget_Alert_info
  if nil == mentalCardStaticStatusWrapper then
    return
  end
  local mentalCardType = mentalCardStaticStatusWrapper:getMentalCardType()
  local cardData = {
    cardKeyRaw = mentalCardStaticStatusWrapper:getKey(),
    name = mentalCardStaticStatusWrapper:getName(),
    desc = mentalCardStaticStatusWrapper:getDesc(),
    imagePath = mentalCardStaticStatusWrapper:getImagePath()
  }
  cardKeyRaw = mentalCardStaticStatusWrapper:getKey()
  if 0 == mentalCardType then
    table.insert(cardListNormal, cardData)
  end
  if 1 == mentalCardType then
    table.insert(cardListImportant, cardData)
  end
  if #cardListNormal > 0 then
    self:setButtonShow(AlertType.eALERT_NewKnowledge, true)
    self:setBubbleShow(true, AlertType.eALERT_NewKnowledge)
    self:updateIcons()
  end
  if #cardListImportant > 0 then
    self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, true)
    self:setBubbleShow(true, AlertType.eALERT_NewStoryKnowledge)
    self:updateIcons()
  end
end
function PaGlobalFunc_Widget_Alert_NewKnowledge_CardKeyReturn()
  return cardKeyRaw
end
function PaGlobalFunc_Widget_Alert_NewKnowledge(usingType)
  if nil == usingType or 0 ~= usingType and 1 ~= usingType then
    return
  end
  local self = Panel_Widget_Alert_info
  local control
  if 0 == usingType then
    control = Panel_UIMain
  elseif 1 == usingType then
    control = Panel_UIMain
  else
    return
  end
  local PosX = control:GetPosX()
  local PosY = control:GetPosY() - Panel_NewKnowledge:GetSizeY()
  if getScreenSizeX() < PosX + Panel_NewKnowledge:GetSizeX() then
    PosX = getScreenSizeX() - Panel_NewKnowledge:GetSizeX()
  end
  Panel_NewKnowledge:SetHorizonRight()
  Panel_NewKnowledge:SetVerticalBottom()
  Panel_NewKnowledge:SetPosY(Panel_NewKnowledge:GetPosY() - Panel_UIMain:GetSizeY())
  local dataTable
  if 0 == usingType then
    dataTable = cardListImportant
  elseif 1 == usingType then
    dataTable = cardListNormal
  else
    return
  end
  local buttonCloseAll = UI.getChildControl(Panel_NewKnowledge, "Button_AllClose")
  local buttonClose = UI.getChildControl(Panel_NewKnowledge, "Button_Close")
  local buttonWinClose = UI.getChildControl(Panel_NewKnowledge, "Button_WinClose")
  local staticTitle = UI.getChildControl(Panel_NewKnowledge, "StaticText_Knowledge_Title")
  local staticImage = UI.getChildControl(Panel_NewKnowledge, "Static_Knowledge_Img")
  local buttonNext = UI.getChildControl(Panel_NewKnowledge, "Button_Next")
  local frameKnowledge = UI.getChildControl(Panel_NewKnowledge, "Frame_Knowledge_Desc")
  local frameContent = UI.getChildControl(frameKnowledge, "Frame_1_Content")
  local staticDesc = UI.getChildControl(frameContent, "StaticText_Knowledge_Desc")
  local btn_question = UI.getChildControl(Panel_NewKnowledge, "Button_Question")
  staticDesc:SetTextMode(__eTextMode_AutoWrap)
  staticTitle:SetTextMode(__eTextMode_Limit_AutoWrap)
  local frameScrollV = UI.getChildControl(frameKnowledge, "Frame_1_VerticalScroll")
  local frameScrollVBTN = UI.getChildControl(frameScrollV, "Frame_1_VerticalScroll_CtrlButton")
  buttonCloseAll:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_CloseAll( " .. usingType .. ")")
  buttonClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()")
  buttonWinClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()")
  buttonNext:addInputEvent("Mouse_LUp", "PaGlobalFunc_Widget_Alert_NewKnowledge(" .. usingType .. ")")
  btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelImportantKnowledge\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(btn_question, "\"PanelImportantKnowledge\"")
  local newCount = #dataTable
  if newCount > 0 then
    local cardData = dataTable[newCount]
    staticTitle:SetText(cardData.name)
    staticDesc:SetText(cardData.desc)
    staticDesc:SetSize(staticDesc:GetSizeX(), staticDesc:GetTextSizeY())
    staticImage:ChangeTextureInfoName(cardData.imagePath)
    frameKnowledge:UpdateContentScroll()
    frameScrollV:SetControlTop()
    frameScrollV:SetInterval(2)
    frameKnowledge:UpdateContentPos()
    frameScrollVBTN:SetShow(false)
    frameScrollV:SetShow(false)
    if frameKnowledge:GetSizeY() < staticDesc:GetSizeY() then
      frameScrollVBTN:SetShow(true)
      frameScrollV:SetShow(true)
    end
    table.remove(dataTable)
    buttonNext:SetShow(true)
    if newCount == 1 then
      buttonNext:SetShow(false)
    end
    PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Open()
  else
    PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()
  end
  if 0 == #dataTable then
    if 0 == usingType then
      self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, false)
    elseif 1 == usingType then
      self:setButtonShow(AlertType.eALERT_NewKnowledge, false)
    end
  elseif 0 == usingType then
    self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, true, true)
    self:setBubbleShow(true, AlertType.eALERT_NewStoryKnowledge)
  elseif 1 == usingType then
    self:setButtonShow(AlertType.eALERT_NewKnowledge, true, true)
    self:setBubbleShow(true, AlertType.eALERT_NewKnowledge)
  end
  self:updateIcons()
end
function PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Open()
  Panel_NewKnowledge:SetShow(true)
end
function PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()
  Panel_NewKnowledge:SetShow(false)
end
function PaGlobalFunc_Widget_Alert_NewKnowledgePopup_CloseAll(usingType)
  local self = Panel_Widget_Alert_info
  local dataTable
  if 0 == usingType then
    dataTable = cardListImportant
    self:setButtonShow(AlertType.eALERT_NewStoryKnowledge, false)
  elseif 1 == usingType then
    dataTable = cardListNormal
    self:setButtonShow(AlertType.eALERT_NewKnowledge, false)
  end
  for index = #dataTable, 1, -1 do
    table.remove(dataTable, index)
  end
  PaGlobalFunc_Widget_Alert_NewKnowledgePopup_Close()
  self:updateIcons()
end
function FromClient_Widget_Alert_NewMail()
  local self = Panel_Widget_Alert_info
  local newMailEffectIcon = self._alertButton[AlertType.eALERT_Mail]
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  if 0 == isColorBlindMode then
    newMailEffectIcon:EraseAllEffect()
    newMailEffectIcon:AddEffect("fUI_Letter_01A", true, 0, 2.1)
  elseif 1 == isColorBlindMode then
    newMailEffectIcon:EraseAllEffect()
    newMailEffectIcon:AddEffect("fUI_Letter_01B", true, 0, 2.1)
  elseif 2 == isColorBlindMode then
    newMailEffectIcon:EraseAllEffect()
    newMailEffectIcon:AddEffect("fUI_Letter_01B", true, 0, 2.1)
  end
  self:setButtonShow(AlertType.eALERT_Mail, true)
  self:updateIcons()
  self:setBubbleShow(true, AlertType.eALERT_Mail)
  PaGlobalFunc_Widget_Alert_SetUnReadMailCount()
end
function FromClient_Widget_Alert_NewMailRead(isCheck)
  local self = Panel_Widget_Alert_info
  local newMailEffectIcon = self._alertButton[AlertType.eALERT_Mail]
  newMailEffectIcon:EraseAllEffect()
  PaGlobalFunc_Widget_Alert_SetUnReadMailCount()
end
function FromClient_Widget_Alert_CompleteBenefitReward()
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_Check_ChallengeReward()
  PaGlobalFunc_Widget_Alert_Check_PcRoomReward()
  self:updateIcons(false, AlertType.eALERT_ChallengeReward)
  self:setBubbleShow(true, AlertType.eALERT_ChallengeReward)
end
function FromClient_Widget_Alert_NoticeNewMessage(isSoundNotice, isEffectNotice)
  local self = Panel_Widget_Alert_info
  if false == _ContentsGroup_NewUI_Friend_All then
    if isEffectNotice and false == Panel_FriendList:GetShow() then
      local message = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_7_1")
      self:setButtonShow(AlertType.eALERT_NewFriend, true, message)
      self:updateIcons(false, AlertType.eALERT_NewFriend)
    end
  elseif true == _ContentsGroup_Messenger then
  elseif isEffectNotice and false == Panel_FriendList_All:GetShow() then
    local message = PAGetString(Defines.StringSheet_GAME, "LUA_ALERTWIDGET_MESSAGE_7_1")
    self:setButtonShow(AlertType.eALERT_NewFriend, true, message)
    self:updateIcons(false, AlertType.eALERT_NewFriend)
  end
end
function FromClient_Widget_Alert_NewFriendAlert(param)
  local self = Panel_Widget_Alert_info
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  self._alertButton[AlertType.eALERT_NewFriend]:EraseAllEffect()
  if 1 == param then
    if 0 == isColorBlindMode then
      self._alertButton[AlertType.eALERT_NewFriend]:AddEffect("fUI_Friend_01A", true, 0, 0)
    elseif 1 == isColorBlindMode then
      self._alertButton[AlertType.eALERT_NewFriend]:AddEffect("fUI_Friend_01B", true, 0, 0)
    elseif 2 == isColorBlindMode then
      self._alertButton[AlertType.eALERT_NewFriend]:AddEffect("fUI_Friend_01B", true, 0, 0)
    end
    local sendMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_FRIEND_ALERT"),
      sub = "",
      addMsg = ""
    }
    if true == _ContentsGroup_Messenger and nil ~= Panel_FriendInfoList_All and true == Panel_FriendInfoList_All:GetShow() then
      PaGlobal_FriendRequest_All_Open(true)
    end
  else
    local sendMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_FRIEND_COMPLETE"),
      sub = "",
      addMsg = ""
    }
    Proc_ShowMessage_Ack_For_RewardSelect(sendMsg, 3, 3)
  end
  self:setButtonShow(AlertType.eALERT_NewFriend, true)
  self:updateIcons(false, AlertType.eALERT_NewFriend)
  if 1 == param then
    if nil ~= self._ui.StaticText_FriendRequestCount:GetText() and "" ~= self._ui.StaticText_FriendRequestCount:GetText() then
      local requestCount = tonumber(self._ui.StaticText_FriendRequestCount:GetText()) + 1
      self._ui.StaticText_FriendRequestCount:SetText(tostring(requestCount))
    else
      self._ui.StaticText_FriendRequestCount:SetText("1")
    end
    self._ui.StaticText_FriendRequestCount:SetShow(true)
    Panel_Widget_Alert_info:setBubbleShow(true, AlertType.eALERT_NewFriend)
  end
end
function FromClient_Widget_Alert_Update_NewFriend()
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_Check_NewFriend()
  self:updateIcons(false, AlertType.eALERT_NewFriend)
  Panel_Widget_Alert_info:setBubbleShow(true, AlertType.eALERT_NewFriend)
  FromClient_Widget_Alert_Update_NewFriendCount()
end
function FromClient_Widget_Alert_Update_NewFriendCount()
  local self = Panel_Widget_Alert_info
  local requestCount = RequestFriends_getAddFriendCount()
  if requestCount > 0 then
    self._ui.StaticText_FriendRequestCount:SetShow(true)
    self._ui.StaticText_FriendRequestCount:SetText(tostring(requestCount))
  else
    self._ui.StaticText_FriendRequestCount:SetShow(false)
    self._ui.StaticText_FriendRequestCount:SetText("0")
  end
end
function FromClient_Widget_Alert_BlackSpiritQuest()
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_Check_BlackSpiritQuest()
  PaGlobalFunc_Widget_Alert_SetProgressQuestCount()
  self:updateIcons(false, AlertType.eALERT_BlackSpiritQuest)
end
function FromClient_Widget_Alert_WeightOver()
  local self = Panel_Widget_Alert_info
  if false == PaGlobalFunc_Widget_Alert_Check_WeightOver() then
    return
  end
  self:updateIconsSpecifyIcon(AlertType.eALERT_WeightOver)
end
function FromClient_Widget_Alert_BatterEquipment()
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_CheckReal_BatterEquipment()
  self:updateIconsSpecifyIcon(AlertType.eALERT_BatterEquipment)
end
function FromClient_Widget_Alert_AttendanceUpdate(attendanceKey)
  local self = Panel_Widget_Alert_info
  if nil ~= PaGlobalFunc_Attendance_GetIsSecondAttendance and true == PaGlobalFunc_Attendance_GetIsSecondAttendance() then
    return
  elseif nil ~= PaGlobalFunc_DailyStamp_All_GetIsSecondAttendance and true == PaGlobalFunc_DailyStamp_All_GetIsSecondAttendance() then
    return
  end
  self._isDiscountPeriodFirstAlert = true
end
function FromClient_Widget_Alert_AttendanceUpdateAll(isNextDay)
  local self = Panel_Widget_Alert_info
  if false == isNextDay then
    return
  end
  self._isDiscountPeriodFirstAlert = true
  if true == isNextDay then
    PaGlobalFunc_Widget_Alert_SetExpiredMailBubble()
  end
end
function PaGlobalFunc_PersonalMonster_PanelOpen()
  if false == _ContentsGroup_NewUI_PersonalMonster_All then
    if nil ~= Panel_Window_PersonalMonster then
      PaGlobalFunc_PersonalMonster_Open()
    end
  elseif nil ~= Panel_PersonalMonster_All then
    HandleEventLUp_PersonalMonster_All_Open()
  end
  Panel_Widget_Alert_info:setBubbleShow(false, AlertType.eALERT_MyBossMonster, nil, true)
end
function FromClient_notifyReservePersonalMonster(characterKey, positionIndex)
  if false == _ContentsGroup_NewUI_PersonalMonster_All and nil ~= Panel_Window_PersonalMonsterMessage then
    PaGlobal_PersonalMonsterMessage_Alram()
  elseif nil ~= Panel_PersonalMonster_All then
    FromClient_PersonalMonsterMessage_ALL_NotifyMonster()
  end
  FromClient_updateReservePersonalMonster(characterKey, positionIndex)
end
function FromClient_updateReservePersonalMonster(characterKey, positionIndex)
  PaGlobalFunc_UiMain_SetShow()
  local self = Panel_Widget_Alert_info
  local showMonsterCount = 0
  for ii = 0, ToClient_GetReservePersonalMonsterListCount() - 1 do
    local monsterKey = ToClient_GetReservePersonalMonsterKey(ii)
    if 0 ~= monsterKey and nil ~= monsterKey then
      showMonsterCount = showMonsterCount + 1
    end
  end
  if showMonsterCount > 0 then
    PaGlobalFunc_Widget_Alert_Check_MyBossMonster()
    Panel_Widget_Alert_info_AlramHide()
    self._ui.StaticText_BossMonsterCount:SetText(showMonsterCount)
    self:setButtonShow(AlertType.eALERT_MyBossMonster, true)
    self._ui.btn_blackEffect:SetShow(true)
    self._ui.btn_blackEffect:EraseAllEffect()
    self._ui.btn_blackEffect:AddEffect("fUI_Personal_Monster_Loop_Alert_01A", true, 0, 0)
    self._ui.btn_blackEffect:AddEffect("fUI_Personal_Monster_Impact_Alert_01A", true, 0, 0)
    self._ui.btn_blackEffect:AddEffect("fUI_Personal_Monster_Ribbon_01A", true, 0, 0)
    self:setBubbleShow(true, AlertType.eALERT_MyBossMonster)
  else
    self:setButtonShow(AlertType.eALERT_MyBossMonster, false)
  end
  Panel_Widget_Alert_info:updateIcons(false, false)
end
function FromClient_notifyDeathPersonalMonster()
  local showMonsterCount = 0
  for ii = 0, ToClient_GetReservePersonalMonsterListCount() - 1 do
    local monsterKey = ToClient_GetReservePersonalMonsterKey(ii)
    if 0 ~= monsterKey and nil ~= monsterKey then
      showMonsterCount = showMonsterCount + 1
    end
  end
  local self = Panel_Widget_Alert_info
  if showMonsterCount > 0 then
    self._ui.StaticText_BossMonsterCount:SetText(showMonsterCount)
    self._ui.StaticText_BossMonsterCount:SetShow(true)
  else
    self._ui.StaticText_BossMonsterCount:SetShow(false)
  end
end
function FromClient_notifySpawnPersonalMonster(key, positionIndex)
  local self = Panel_Widget_Alert_info
  if false == _ContentsGroup_NewUI_PersonalMonster_All and nil ~= Panel_Window_PersonalMonsterMessage then
    PaGlobal_PersonalMonsterMessage_Open(key)
  end
  local isPersonalMonster = false
  local showMonsterCount = 0
  for ii = 0, ToClient_GetReservePersonalMonsterListCount() - 1 do
    local monsterKey = ToClient_GetReservePersonalMonsterKey(ii)
    if 0 ~= monsterKey and nil ~= monsterKey then
      showMonsterCount = showMonsterCount + 1
    end
  end
  if showMonsterCount <= 0 then
    self:setButtonShow(AlertType.eALERT_MyBossMonster, false)
  else
    self:setButtonShow(AlertType.eALERT_MyBossMonster, true)
    self._ui.StaticText_BossMonsterCount:SetText(showMonsterCount)
  end
end
function FromClient_Widget_Alert_TotalRewardUpdated(itemStaticInformationWrapper, rewardTypeStr)
  local self = Panel_Widget_Alert_info
  PaGlobalFunc_Widget_Alert_Check_RewardList()
  self:updateIcons()
  local itemEnchantSSW = itemStaticInformationWrapper:getStaticStatus()
  if nil == itemEnchantSSW then
    return
  end
  local itemName = FGlobal_ChangeItemNameColorByGrade(itemStaticInformationWrapper:getKey())
  local itemCount = itemStaticInformationWrapper:getCount_s64()
  local countString = makeDotMoney(itemCount)
  local alarmStr = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_PENDING_REWARD_ALERT_MESSAGE", "itemStr", itemName, "count", countString, "rewardType", rewardTypeStr)
  Panel_Widget_Alert_info:AlramShow(AlertType.eALERT_TotalReward, alarmStr, __eTextMode_Limit_AutoWrap)
  if false == PaGlobalFunc_Widget_Alert_CheckFamilyCharacterLevel(_ContentsUiCheck_TotalRewardIconEffectLevel) then
    PaGlobalFunc_Widget_Alert_TotalRewardIcon_Effect()
  end
  self:setBubbleShow(true, AlertType.eALERT_TotalReward)
end
function FromClient_PendingRewardUpdated()
  PaGlobalFunc_Widget_Alert_Check_RewardList()
  Panel_Widget_Alert_info:setBubbleShow(true, AlertType.eALERT_TotalReward)
end
function FromClient_Widget_Alert_Title(titleKeyRaw, lastAquireCount)
  Panel_Widget_Alert_info._linkLastTitleKey = titleKeyRaw
  local titleWrapper = ToClient_GetTitleStaticStatusWrapperByTitleKey(titleKeyRaw)
  if nil == titleWrapper then
    return
  end
  Panel_Widget_Alert_info._linkLastTitleCategory = titleWrapper:getTitleCategory()
  local alramStr = ""
  if 1 == lastAquireCount then
    alramStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACQUIRE_TITLE_ALERT_ONE", "titleName", titleWrapper:getName())
  elseif lastAquireCount > 1 then
    alramStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ACQUIRE_TITLE_ALERT_ONE_MORE", "titleCount", lastAquireCount)
  end
  local acquireTitleForPlaying = ToClient_GetAcquireTitleCountForPlaying()
  if acquireTitleForPlaying > 0 then
    Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_Acquire_Title, true)
    Panel_Widget_Alert_info:setBubbleShow(true, AlertType.eALERT_Acquire_Title)
    Panel_Widget_Alert_info._ui.StaticText_TitleCount:SetText(tostring(acquireTitleForPlaying))
  else
    Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_Acquire_Title, false)
    Panel_Widget_Alert_info._ui.StaticText_TitleCount:SetText(tostring(acquireTitleForPlaying))
  end
  Panel_Widget_Alert_info:AlramShow(AlertType.eALERT_Acquire_Title, alramStr, __eTextMode_Limit_AutoWrap)
  Panel_Widget_Alert_info:updateIcons(false, false)
end
function PaGlobalFunc_Widget_Alert_ButtonTitleAcquire()
  PaGlobalFunc_ChracterInfo_All_Link_Title(Panel_Widget_Alert_info._linkLastTitleKey, Panel_Widget_Alert_info._linkLastTitleCategory)
  ToClient_ClearAcquireTitleCountForPlaying()
  Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_Acquire_Title, false)
  Panel_Widget_Alert_info._ui.StaticText_TitleCount:SetText(tostring(0))
  Panel_Widget_Alert_info:updateIcons(false, false)
end
function FromClient_Widget_Alert_BlackSpiritAdventrueDice()
  Panel_Widget_Alert_info:updateIconsSpecifyIcon(AlertType.eALERT_BlackSpiritAdventureDice)
end
function FromClient_Widget_Alert_BlackSpiritAdventrueNoDice()
  PaGlobalFunc_Widget_Alert_BlackSpiritAdventure_BannnerClose()
  Panel_Widget_Alert_info:updateIconsSpecifyIcon(AlertType.eALERT_BlackSpiritAdventureDice)
end
function PaGlobalFunc_Widget_Alert_BlackSpiritAdventure_BannnerClose()
  local bannerControl = Panel_Widget_Alert_info._ui.Static_BlackSpiritAdvBanner
  if nil ~= bannerControl then
    local hideAni = bannerControl:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
    hideAni.IsChangeChild = true
    hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
    hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
    hideAni:SetHideAtEnd(true)
    hideAni:SetDisableWhileAni(true)
  end
end
function PaGlobalFunc_Widget_Alert_BlackSpiritAdventure_DiceEffect_UpdatePerFrame(deltaTime)
  local diceAlertButton = Panel_Widget_Alert_info._alertButton[AlertType.eALERT_BlackSpiritAdventureDice]
  if nil == diceAlertButton then
    return
  end
  if false == diceAlertButton:GetShow() then
    return
  end
  if false == Panel_Widget_Alert_info._isAcquireDiceEffect then
    return
  end
  Panel_Widget_Alert_info._effectCheckTime = Panel_Widget_Alert_info._effectCheckTime + deltaTime
  if Panel_Widget_Alert_info._effectTime < Panel_Widget_Alert_info._effectCheckTime then
    Panel_Widget_Alert_info._isAcquireDiceEffect = false
    Panel_Widget_Alert_info._effectCheckTime = 0
    diceAlertButton:EraseAllEffect()
    diceAlertButton:AddEffect("UI_BlackSpirit_Dice_02A", true, 0, 0)
  end
end
function HandleEventLUp_Widget_Alert_BlackSpiritAdv_BannerClick()
  PaGlobalFunc_Widget_Alert_BlackSpiritAdventure_BannnerClose()
  FGlobal_BlackSpiritAdventure_Open()
end
function HandleEventLUp_Widget_AlertArea_BlackSpiritAdventureOpen()
  FGlobal_BlackSpiritAdventure_Open()
  PaGlobalFunc_Menu_All_AddRecentMenuBlackSpiritAdventure()
end
function FromClient_NotifySeasonBanner()
  if nil == Panel_Widget_Alert_info then
    return
  end
  if false == Panel_Widget_Alert_info:isShowSeasonBannerToday() then
    return
  end
  if nil ~= Panel_Widget_Alert_info._ui.Static_SeasonBanner then
    Panel_Widget_Alert_info:setButtonShow(AlertType.eALERT_SeasonBanner, true)
    Panel_Widget_Alert_info._ui.Static_SeasonBanner:SetShow(true)
  end
end
function HandleEventLUp_Widget_Alert_SeasonBanner()
  if nil == Panel_Widget_Alert_info then
    return
  end
  local url = ToClient_getSeasonNoticeURL()
  ToClient_OpenChargeWebPage(url, false)
  HandleEventLUp_Widget_Alert_SeasonBanner_Close()
end
function HandleEventLUp_Widget_Alert_SeasonBanner_SaveToday()
  if nil == Panel_Widget_Alert_info then
    return
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local UIManager = ToClient_getGameUIManagerWrapper()
  if nil ~= UIManager then
    UIManager:setLuaCacheDataListTime(__eSeasonBannerNotShowToday, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  HandleEventLUp_Widget_Alert_SeasonBanner_Close()
end
function HandleEventLUp_Widget_Alert_SeasonBanner_Close()
  if nil == Panel_Widget_Alert_info then
    return
  end
  local bannerControl = Panel_Widget_Alert_info._ui.Static_SeasonBanner
  if nil == bannerControl then
    return
  end
  bannerControl:SetShow(false)
end
function Panel_Widget_Alert_info:isShowSeasonBannerToday()
  if nil == Panel_Widget_Alert_info then
    return false
  end
  local UIManager = ToClient_getGameUIManagerWrapper()
  if nil == UIManager then
    return false
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = UIManager:getLuaCacheDataListTime(__eSeasonBannerNotShowToday)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay then
      return false
    end
  end
  return true
end
changePositionBySever(Panel_UIMain, CppEnums.PAGameUIType.PAGameUIPanel_UIMenu, true, false, false)
PaGlobalFunc_UiMain_SetShow()
