PaGlobal_FriendInfoList_All = {
  _ui = {
    stc_PartLine = nil,
    btn_Close = nil,
    btn_Question = nil,
    list2_Friend = nil,
    stc_AddGroup = nil,
    btn_AddFriend = nil,
    btn_AddGroup = nil,
    btn_Request = nil,
    stc_SoundOptionBg = nil,
    btn_Sound = nil,
    btn_Effect = nil,
    btn_ScaleResize = nil,
    stc_Function = nil,
    stc_XBFunctionBG = nil,
    stc_XBFunctionList = {},
    stc_FriendFunctionBG = nil,
    stc_FriendFunctionList = {},
    stc_GroupListFunctionBG = nil,
    stc_GroupListFunctionList = {},
    stc_GroupFunctionBG = nil,
    stc_GroupFunctionList = {},
    stc_Emoticon_BG = nil,
    stc_Chat_TitleBar = nil,
    btn_Back = nil,
    stc_ChatName = nil,
    btn_Drop = nil,
    btn_Alarm = nil,
    Frame_Chat = nil,
    FrameContent = nil,
    FrameScroll = nil,
    stc_EditGroup = nil,
    stc_Edit = nil,
    btn_Enter = nil,
    stc_Emo = nil,
    stc_KeyX = nil,
    stc_Tab_Console = nil,
    btn_PCFriend = nil,
    btn_ConsoleFriend = nil,
    stc_KeyGuide_LB = nil,
    stc_KeyGuide_RB = nil,
    stc_BottomBg = nil,
    txt_KeyGuide_X = nil,
    txt_KeyGuide_Y = nil,
    txt_KeyGuide_A = nil,
    txt_KeyGuide_B = nil,
    txt_KeyGuide_LT = nil,
    txt_KeyGuide_LB = nil,
    txt_RequestNew = nil
  },
  _groupListData = {
    _defaultGroupIndex = -1,
    _partyplayGroupIndex = -1,
    _selectedGroupIndex = -1,
    _uiGroups = {},
    _groupInfo = {},
    _groupInfoByGroupIndex = {},
    _groupCount = 0
  },
  _friendListData = {
    _selectedFriendIndex = -1,
    _selectedFriendUserNo = -1,
    _uiFriends = {},
    _friendInfo = {}
  },
  _keyGuideType = {
    _DefaultGroup = 1,
    _Group = 2,
    _Friend = 3,
    _XBFriend = 4,
    _Popup = 5,
    _AddGroup = 6,
    _Popup2 = 7,
    _None = 8
  },
  _tab = {_pcFriendTab = 0, _consoleFriendTab = 1},
  _friendFunction = {
    PARTY_INVITE = 0,
    FRIEND_DELETE = 1,
    GROUP_MOVE = 2,
    MESSANGER = 3,
    WHISPER = 4
  },
  _groupFunction = {GROUP_RENAME = 0, GROUP_DELETE = 1},
  _MAX_FUNCTION_COUNT = 5,
  _MAX_GROUP_COUNT = 5,
  _MAX_FRIEND_COUNT = 50,
  _currentKeyGuideType = 1,
  _currentTab = 0,
  _selectedXBFriendIndex = -1,
  _panelOpenPosX = 0,
  _panelOpenPosY = 0,
  _listMoveIndex = nil,
  _StaticBg = {},
  _StaticText = {},
  _StaticTime = {},
  _StaticClass = {},
  _currentOpenMessangerId = nil,
  _messageCount = 0,
  _isPS4 = false,
  _initialize = false
}
PaGlobal_AddFriend_All = {
  _ui = {
    btn_Close = nil,
    txt_Desc = nil,
    stc_keyGuide_X = nil,
    edit_Name = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _isFamilyName = true,
  _initialize = false
}
PaGlobal_FriendRequest_All = {
  _ui = {
    btn_Close = nil,
    list2_requested = nil,
    list2_request = nil,
    stc_noRequest = nil,
    requestedList = {},
    requestList = {},
    rdo_ReceiveList = nil,
    rdo_SendList = nil,
    stc_selectBar = nil,
    stc_keyGuideRB = nil,
    stc_keyGuideLB = nil,
    stc_keyGuideBG = nil,
    stc_keyGuide_X = nil,
    stc_KeyGuide_A = nil,
    stc_keyGuide_B = nil,
    stc_keyGuide_LS = nil,
    btn_RefuseAll = nil
  },
  _maxFriendCount = 30,
  _selectFriendIndex = 0,
  _initialize = false
}
PaGlobal_Friend_GroupRename_All = {
  _ui = {
    btn_Close = nil,
    txt_title = nil,
    txt_groupDesc = nil,
    edit_GroupName = nil,
    stc_keyGuide_X = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_keyGuideBG = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _isAddGroup = false,
  _initialize = false
}
PaGlobal_FriendMessanger_All = {
  _currentMessangerId = toInt64(0, -1),
  _messangerList = {},
  _messangerMinSizeX = 436,
  _messangerMaxSizeX = 800,
  _messangerMinSizeY = 382,
  _messangerMaxSizeY = 800
}
PaGlobal_FriendMessangerFloating_All = {
  _messangerList = {}
}
PaGlobal_FriendMessangerFloatingAlert_All = {
  _messangerAlertCount = 3,
  _messangerAlert = {},
  _messangerPosY = {},
  _initialize = false
}
PaGlobal_FriendClassTextureInfo = {
  [__eClassType_Warrior] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    1,
    124,
    44,
    167
  },
  [__eClassType_Giant] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    133,
    124,
    176,
    167
  },
  [__eClassType_ElfRanger] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    45,
    124,
    88,
    167
  },
  [__eClassType_RangerMan] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    89,
    212,
    132,
    255
  },
  [__eClassType_Sorcerer] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    89,
    124,
    132,
    167
  },
  [__eClassType_WizardWoman] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    177,
    168,
    220,
    211
  },
  [__eClassType_WizardMan] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    133,
    168,
    176,
    211
  },
  [__eClassType_Valkyrie] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    1,
    168,
    44,
    211
  },
  [__eClassType_Tamer] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    177,
    124,
    220,
    167
  },
  [__eClassType_Lhan] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    45,
    212,
    88,
    255
  },
  [__eClassType_Combattant] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    265,
    168,
    308,
    211
  },
  [__eClassType_Mystic] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    1,
    212,
    44,
    255
  },
  [__eClassType_BladeMaster] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    221,
    124,
    264,
    167
  },
  [__eClassType_BladeMasterWoman] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    265,
    124,
    308,
    167
  },
  [__eClassType_Kunoichi] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    45,
    168,
    88,
    211
  },
  [__eClassType_NinjaMan] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    89,
    168,
    132,
    211
  },
  [__eClassType_ShyWaman] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    133,
    212,
    176,
    255
  },
  [__eClassType_DarkElf] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    221,
    168,
    264,
    211
  },
  [__eClassType_Guardian] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    177,
    212,
    220,
    255
  },
  [__eClassType_Hashashin] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    221,
    212,
    264,
    255
  },
  [__eClassType_Nova] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    265,
    212,
    308,
    255
  },
  [__eClassType_ReservedBlackSpirit] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    1,
    256,
    44,
    299
  },
  [__eClassType_Sorcerer_Reserved1] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    45,
    256,
    88,
    299
  },
  [__eClassType_Count] = {
    "Combine/Etc/Combine_Etc_Chatting.dds",
    89,
    256,
    132,
    299
  }
}
runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All_1.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All_2.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendList_All_3.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendList_All_4.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendList_All_5.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All_6.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All_7.lua")
runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All_8.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FriendInfoList_All")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_AddFriend_All_Init")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_FriendRequest_All_Init")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Friend_GroupRename_All_Init")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Friend_MessangerFloatingAlert_All_Init")
function FromClient_FriendInfoList_All()
  PaGlobal_FriendInfoList_All:initialize()
end
function FromClient_PaGlobal_AddFriend_All_Init()
  PaGlobal_AddFriend_All:initialize()
end
function FromClient_PaGlobal_FriendRequest_All_Init()
  PaGlobal_FriendRequest_All:initialize()
end
function FromClient_PaGlobal_Friend_GroupRename_All_Init()
  PaGlobal_Friend_GroupRename_All:initialize()
end
function FromClient_PaGlobal_Friend_MessangerFloatingAlert_All_Init()
  PaGlobal_FriendMessangerFloatingAlert_All:initialize()
end
