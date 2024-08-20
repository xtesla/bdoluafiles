Panel_SeasonTexture:SetShow(false)
local currentSeasonUIType = ToClient_GetCurrentSeasonUIType()
local contentOpen = ToClient_GetIsEnableSeasonUIMode()
local cruRandomPosX = {}
local objectParentsSizeY = 62
local isConsoleMode = ToClient_isConsole()
local panelList = {
  [0] = {
    [0] = Panel_EnableSkill,
    [1] = nil,
    [2] = Panel_ItemMarket_Alarm
  },
  [1] = {
    [0] = Panel_Window_Inventory,
    [1] = Panel_Window_Warehouse,
    [2] = Panel_Window_Option,
    [3] = Panel_Window_Quest_New,
    [4] = Panel_Equipment,
    [6] = Panel_ChannelSelect,
    [7] = Panel_Window_PetListNew,
    [8] = Panel_AlchemyFigureHead,
    [9] = Panel_AlchemyStone,
    [10] = Panel_DyePalette,
    [11] = Panel_FriendList,
    [12] = Panel_Mail_Main,
    [13] = Panel_WorkerManager,
    [14] = Panel_GuildWarInfo,
    [15] = Panel_Chatting_Filter,
    [17] = Panel_Window_ServantInfo,
    [18] = Panel_ShipInfo,
    [19] = Panel_WorkerShipInfo,
    [21] = Panel_NewKnowledge,
    [22] = Panel_Win_System,
    [23] = Panel_Window_ItemMarket_Favorite,
    [24] = Panel_Window_GuildWarInfo,
    [25] = Panel_Chat_SocialMenu,
    [26] = Panel_Window_MasterpieceAuction,
    [27] = Panel_Memo_List,
    [28] = Panel_Window_DropItem,
    [29] = Panel_ButtonShortcuts,
    [30] = Panel_SaveSetting,
    [31] = Panel_Window_BlackDesertLab,
    [32] = Panel_BossAlert_SettingV2,
    [33] = Panel_FairyInfo,
    [34] = Panel_CharacterTag,
    [35] = Panel_Window_ItemMarketAlarmList_New,
    [36] = Panel_CheckedQuestInfo,
    [37] = Panel_NpcNavi,
    [39] = Panel_Window_Extraction_EnchantStone,
    [40] = Panel_Window_Extraction_Caphras,
    [41] = Panel_Window_Extraction_Crystal,
    [42] = Panel_Window_Extraction_Cloth,
    [43] = Panel_FixEquip,
    [44] = Panel_Interest_Knowledge,
    [45] = Panel_GuildServantList,
    [46] = Panel_Window_Camp,
    [47] = Panel_WorkerShipInfo,
    [48] = Panel_Window_UnknownRandomSelect,
    [49] = Panel_ItemMarket_PreBid_Manager,
    [50] = Panel_ItemMarket_AlarmList,
    [51] = Panel_IngameCashShop_EasyPayment,
    [52] = Panel_Window_Delivery_Information,
    [54] = Panel_SetVoiceChat,
    [55] = Panel_NodeWarMenu,
    [56] = Panel_Window_Delivery_InformationView,
    [57] = Panel_Window_Enchant,
    [58] = Panel_Window_Socket,
    [59] = Panel_Improvement,
    [60] = Panel_Exchange_Item,
    [61] = Panel_Window_Extraction_System_All,
    [62] = Panel_CharacterInfo_All,
    [63] = Panel_Window_BlackspiritPass
  },
  [2] = {
    [2] = Panel_WebControl,
    [3] = Panel_KeyboardHelp,
    [4] = Panel_ProductNote,
    [5] = Panel_Window_Skill,
    [6] = Panel_Manufacture,
    [7] = Panel_FishEncyclopedia,
    [8] = Panel_Window_ItemMarket,
    [9] = Panel_GuildRank_Web,
    [10] = Panel_LifeRanking,
    [11] = Panel_EventNotify,
    [13] = Panel_Window_BlackSpiritAdventure,
    [14] = Panel_LocalWarInfo,
    [15] = Panel_GameExit,
    [16] = Panel_CustomizingAlbum,
    [17] = Panel_ScreenShotAlbum,
    [18] = Panel_Window_MonsterRanking,
    [19] = Panel_Window_BlackSpiritAdventure_2,
    [20] = Panel_Window_PersonalBattle,
    [21] = Panel_SavageDefenceInfo,
    [22] = Panel_Window_Mercenary,
    [23] = Panel_PartyList,
    [24] = Panel_Window_CardGame,
    [25] = Panel_ArmyUnitSetting,
    [26] = Panel_Window_MarketPlace_Main,
    [27] = Panel_HarvestList,
    [28] = Panel_Window_NpcShop,
    [29] = Panel_TradeEventNotice_Renewal,
    [30] = nil,
    [31] = Panel_Window_DailyChallenge,
    [32] = Panel_HousingList,
    [33] = Panel_Window_MaidList,
    [34] = Panel_Window_ItemMarket_ItemSet,
    [35] = Panel_Worker_Auction,
    [36] = Panel_GuildHouse_Auction,
    [37] = Panel_HouseControl,
    [38] = Panel_Window_ReinforceSkill,
    [39] = Panel_Window_StableMarket,
    [40] = Panel_Quest_Window_160525,
    [41] = Panel_QuestInfo,
    [42] = Panel_MainQuest,
    [43] = Panel_Window_TotalReward,
    [44] = Panel_Guild_NoneJoinMember,
    [45] = nil
  }
}
local isCombinePanel = {
  [0] = {},
  [1] = {},
  [2] = {}
}
if _ContentsGroup_NewUI_Inventory_All then
  panelList[1][0] = Panel_Window_Inventory_All
  isCombinePanel[1][0] = true
end
if _ContentsGroup_NewUI_Pet_All then
  panelList[1][7] = Panel_Window_PetList_All
  isCombinePanel[1][7] = true
end
if _ContentsGroup_NewUI_GameOption_All then
  panelList[1][2] = Panel_Window_GameOption_All
elseif _ContentsGroup_isNewOption then
  panelList[1][2] = Panel_Window_cOption
end
if _ContentsGroup_isUsedNewTradeEventNotice then
  panelList[2][31] = Panel_TradeEventNotice_Renewal
  if _ContentsGroup_NewUI_TradeEventNotice_All then
    panelList[2][31] = Panel_TradeEventNotice_Renewal_All
    isCombinePanel[2][31] = true
  end
else
  panelList[0][1] = Panel_TradeMarket_EventInfo
end
if _ContentsGroup_NewUI_MessageBox_All then
  panelList[1][22] = Panel_Window_MessageBox_All
  isCombinePanel[1][22] = true
end
if _ContentsGroup_NewUI_Equipment_All then
  panelList[1][4] = Panel_Window_Equipment_All
  isCombinePanel[1][4] = true
end
if _ContentsGroup_NewUI_AlchemyFigureHead_All then
  panelList[1][8] = Panel_AlchemyFigureHead_All
  isCombinePanel[1][8] = true
end
if _ContentsGroup_NewUI_AlchemyStone_All then
  panelList[1][9] = Panel_Window_AlchemyStone_All
  isCombinePanel[1][9] = true
end
if _ContentsGroup_NewUI_Friend_All then
  panelList[1][11] = Panel_FriendList_All
  isCombinePanel[1][11] = true
end
if _ContentsGroup_NewUI_Mail_All then
  panelList[1][12] = Panel_Window_Mail_All
  isCombinePanel[1][12] = true
end
if _ContentsGroup_NewUI_WorkerManager_All then
  panelList[1][13] = Panel_Window_WorkerManager_All
  isCombinePanel[1][13] = true
end
if _ContentsGroup_NewUI_ServantInfo_All then
  panelList[1][17] = Panel_Window_VehicleInfo_All
  isCombinePanel[1][17] = true
end
if _ContentsGroup_NewUI_Masterpiece_Auction_All then
  panelList[1][26] = Panel_Masterpiece_Auction_All
  isCombinePanel[1][26] = true
end
if _ContentsGroup_NewUI_Memo_All then
  panelList[1][27] = Panel_Window_Memo_Main_All
  isCombinePanel[1][27] = true
end
if _ContentsGroup_NewUI_DropItem_All then
  panelList[1][28] = Panel_Window_Dropitem_All
  isCombinePanel[1][28] = true
end
if _ContentsGroup_NewUI_ButtonShortcuts_All then
  panelList[1][29] = Panel_Window_ButtonShortcuts_All
  isCombinePanel[1][29] = true
end
if _ContentsGroup_NewUI_BossAlert_SettingV2_All then
  panelList[1][32] = Panel_BossAlert_SettingV2_All
  isCombinePanel[1][32] = true
end
if _ContentsGroup_NewUI_Fairy_All then
  panelList[1][33] = Panel_FairyInfo_All
  isCombinePanel[1][33] = true
end
if _ContentsGroup_NewUI_BlackSmith_All then
  panelList[1][39] = Panel_Window_Extraction_EnchantStone_All
  panelList[1][40] = Panel_Window_Extraction_Caphras_All
  panelList[1][41] = Panel_Window_Extraction_Crystal_All
  panelList[1][42] = Panel_Window_Extraction_Costume_All
  panelList[1][43] = Panel_Window_Endurance_Recovery_All
  panelList[1][61] = Panel_Window_Extraction_System_All
  isCombinePanel[1][39] = true
  isCombinePanel[1][40] = true
  isCombinePanel[1][41] = true
  isCombinePanel[1][42] = true
  isCombinePanel[1][43] = true
  isCombinePanel[1][61] = true
end
if _ContentsGroup_NewUI_Dialog_All then
  panelList[1][44] = Panel_Interest_Knowledge_All
  isCombinePanel[1][44] = true
end
if _ContentsGroup_NewUI_RandomShop_All then
  panelList[1][48] = Panel_Window_RandomShop_All
  isCombinePanel[1][48] = true
end
if _ContentsGroup_NewUI_Delivery_All then
  panelList[1][52] = Panel_Window_Delivery_All
  isCombinePanel[1][52] = true
end
if _ContentsGroup_NewUI_SetVoiceChat_All then
  panelList[1][54] = Panel_Window_SetVoiceChat_All
  isCombinePanel[1][54] = true
end
if _ContentsGroup_NewUI_SpiritEnchant_All then
  panelList[1][57] = Panel_Window_StackExtraction_All
  isCombinePanel[1][57] = true
end
if _ContentsGroup_NewUI_Socket_All then
  panelList[1][58] = Panel_Window_Socket_All
  isCombinePanel[1][58] = true
end
if _ContentsGroup_NewUI_Improvement_All then
  panelList[1][59] = Panel_Improvement_All
  isCombinePanel[1][59] = true
end
if _ContentsGroup_NewUI_Manufacture_All then
  panelList[2][6] = Panel_Window_Manufacture_All
  isCombinePanel[2][6] = true
end
if _ContentsGroup_NewUI_FishEncyclopedia_All then
  panelList[2][7] = Panel_Window_Manufacture_All
  isCombinePanel[2][7] = true
end
if _ContentsGroup_NewUI_LifeRanking_All then
  panelList[2][10] = Panel_LifeRanking_All
  isCombinePanel[2][10] = true
end
if _ContentsGroup_NewUI_EventNotify_All then
  panelList[2][11] = Panel_EventNotify_All
  isCombinePanel[2][11] = true
end
if _ContentsGroup_NewUI_GameExit then
  panelList[2][15] = Panel_Window_GameExit_All
  isCombinePanel[2][15] = true
end
if _ContentsGroup_NewUI_PartyFind_All then
  panelList[2][23] = Panel_PartyList_All
  isCombinePanel[2][23] = true
end
if _ContentsGroup_NewUI_NpcShop_All then
  panelList[2][28] = Panel_Dialog_NPCShop_All
  isCombinePanel[2][28] = true
end
if _ContentsGroup_NewUI_Maid_All then
  panelList[2][33] = Panel_Window_MaidList_All
  isCombinePanel[2][33] = true
end
if _ContentsGroup_NewUI_WorkerAuction_All then
  panelList[2][35] = Panel_Window_WorkerAuction_All
  isCombinePanel[2][35] = true
end
if _ContentsGroup_NewUI_GuildHouse_Auction_All then
  panelList[2][36] = Panel_GuildHouse_Auction_All
  isCombinePanel[2][36] = true
end
if _ContentsGroup_NewUI_ChannelSelect_All then
  panelList[2][37] = Panel_ChannelSelect_All
  isCombinePanel[2][37] = true
end
if _ContentsGroup_NewUI_NpcNavi_All then
  panelList[1][37] = Panel_NpcNavi_All
  isCombinePanel[1][37] = true
end
if _ContentsGroup_NewUI_CharacterTag_All then
  panelList[1][34] = Panel_CharacterTag_All
  isCombinePanel[1][34] = true
end
if _ContentsGroup_HarvestList_All then
  panelList[2][27] = Panel_HarvestList_All
  isCombinePanel[2][27] = true
end
if _ContentsGroup_NewUI_Quest_All then
  panelList[2][40] = Panel_Window_Quest_All
  panelList[2][41] = Panel_Window_QuestInfo_All
  isCombinePanel[2][40] = true
  isCombinePanel[2][41] = true
end
if _ContentsGroup_NewUI_TotalReward_All then
  panelList[2][43] = Panel_Window_TotalReward_All
  isCombinePanel[2][43] = true
end
if _ContentsGroup_Guild_JoinRequest then
  panelList[2][44] = Panel_Guild_NoneGuild
  isCombinePanel[2][44] = true
end
if _ContentsGroup_NewUI_Guild_All then
  panelList[2][45] = Panel_GuildMain_All
  isCombinePanel[2][45] = true
end
local textureLink = {
  spring = "",
  summer = "Combine/Etc/Combine_Etc_Deco_Summer.dds",
  autumn = "",
  winter = "renewal/etc/Remaster_ETC_WinterUI.dds"
}
local ddsLink = ""
if __eSeasonUIType_Spring == currentSeasonUIType then
  ddsLink = textureLink.spring
elseif __eSeasonUIType_Summer == currentSeasonUIType then
  ddsLink = textureLink.summer
elseif __eSeasonUIType_Autumn == currentSeasonUIType then
  ddsLink = textureLink.autumn
elseif __eSeasonUIType_Winter == currentSeasonUIType then
  ddsLink = textureLink.winter
end
local windowTopTextureList = {
  [0] = {
    [0] = {
      _x1 = 1,
      _y1 = 286,
      _x2 = 403,
      _y2 = 348
    },
    [1] = {
      _x1 = 484,
      _y1 = 314,
      _x2 = 886,
      _y2 = 376
    },
    [2] = {
      _x1 = 1,
      _y1 = 286,
      _x2 = 403,
      _y2 = 348
    },
    [3] = {
      _x1 = 1,
      _y1 = 286,
      _x2 = 403,
      _y2 = 348
    },
    [4] = {
      _x1 = 1,
      _y1 = 286,
      _x2 = 403,
      _y2 = 348
    }
  },
  [1] = {
    [0] = {
      _x1 = 1,
      _y1 = 131,
      _x2 = 701,
      _y2 = 207
    },
    [1] = {
      _x1 = 1,
      _y1 = 208,
      _x2 = 701,
      _y2 = 284
    },
    [2] = {
      _x1 = 1,
      _y1 = 131,
      _x2 = 701,
      _y2 = 207
    },
    [3] = {
      _x1 = 1,
      _y1 = 131,
      _x2 = 701,
      _y2 = 207
    },
    [4] = {
      _x1 = 1,
      _y1 = 131,
      _x2 = 701,
      _y2 = 207
    }
  },
  [2] = {
    [0] = {
      _x1 = 1,
      _y1 = 1,
      _x2 = 1001,
      _y2 = 65
    },
    [1] = {
      _x1 = 1,
      _y1 = 66,
      _x2 = 1001,
      _y2 = 130
    },
    [2] = {
      _x1 = 1,
      _y1 = 1,
      _x2 = 1001,
      _y2 = 65
    },
    [3] = {
      _x1 = 1,
      _y1 = 1,
      _x2 = 1001,
      _y2 = 65
    },
    [4] = {
      _x1 = 1,
      _y1 = 1,
      _x2 = 1001,
      _y2 = 65
    }
  }
}
local objectList = {
  spring = {},
  summer = {
    [0] = {
      sizeX = 134,
      sizeY = 43,
      posX = 390,
      posY = 0,
      _x1 = 1,
      _y1 = 1,
      _x2 = 135,
      _y2 = 44
    },
    [1] = {
      sizeX = 190,
      sizeY = 84,
      posX = 85,
      posY = 0,
      _x1 = 1,
      _y1 = 130,
      _x2 = 191,
      _y2 = 214
    },
    [2] = {
      sizeX = 176,
      sizeY = 84,
      posX = 90,
      posY = 0,
      _x1 = 1,
      _y1 = 45,
      _x2 = 177,
      _y2 = 129
    },
    [3] = {
      sizeX = 200,
      sizeY = 88,
      posX = 250,
      posY = 0,
      _x1 = 1,
      _y1 = 215,
      _x2 = 201,
      _y2 = 303
    },
    [4] = {
      sizeX = 53,
      sizeY = 34,
      posX = 180,
      posY = 0,
      _x1 = 1,
      _y1 = 304,
      _x2 = 54,
      _y2 = 338
    }
  },
  autumn = {},
  winter = {
    [0] = {
      sizeX = 387,
      sizeY = 39,
      posX = 390,
      posY = 0,
      _x1 = 1,
      _y1 = 349,
      _x2 = 388,
      _y2 = 388
    },
    [1] = {
      sizeX = 67,
      sizeY = 63,
      posX = 85,
      posY = 0,
      _x1 = 752,
      _y1 = 223,
      _x2 = 819,
      _y2 = 286
    },
    [2] = {
      sizeX = 49,
      sizeY = 67,
      posX = 90,
      posY = 0,
      _x1 = 702,
      _y1 = 223,
      _x2 = 751,
      _y2 = 290
    },
    [3] = {
      sizeX = 90,
      sizeY = 56,
      posX = 250,
      posY = 0,
      _x1 = 896,
      _y1 = 145,
      _x2 = 986,
      _y2 = 201
    },
    [4] = {
      sizeX = 84,
      sizeY = 57,
      posX = 180,
      posY = 0,
      _x1 = 811,
      _y1 = 145,
      _x2 = 810,
      _y2 = 202
    },
    [5] = {
      sizeX = 108,
      sizeY = 77,
      posX = 250,
      posY = 0,
      _x1 = 702,
      _y1 = 145,
      _x2 = 810,
      _y2 = 222
    },
    [6] = {
      sizeX = 79,
      sizeY = 90,
      posX = 130,
      posY = 0,
      _x1 = 404,
      _y1 = 286,
      _x2 = 483,
      _y2 = 376
    },
    [7] = {
      sizeX = 118,
      sizeY = 53,
      posX = 350,
      posY = 0,
      _x1 = 820,
      _y1 = 203,
      _x2 = 938,
      _y2 = 256
    },
    [8] = {
      sizeX = 141,
      sizeY = 48,
      posX = 130,
      posY = 0,
      _x1 = 820,
      _y1 = 257,
      _x2 = 961,
      _y2 = 305
    },
    [9] = {
      sizeX = 52,
      sizeY = 50,
      posX = 350,
      posY = 0,
      _x1 = 939,
      _y1 = 202,
      _x2 = 991,
      _y2 = 252
    }
  }
}
local currentSeasonObjectList
local objectIndex_min = -1
local objectIndex_max = -1
if __eSeasonUIType_Spring == currentSeasonUIType then
  currentSeasonObjectList = objectList.spring
  objectIndex_min = -1
  objectIndex_max = -1
elseif __eSeasonUIType_Summer == currentSeasonUIType then
  currentSeasonObjectList = objectList.summer
  objectIndex_min = 0
  objectIndex_max = 4
elseif __eSeasonUIType_Autumn == currentSeasonUIType then
  currentSeasonObjectList = objectList.autumn
  objectIndex_min = -1
  objectIndex_max = -1
elseif __eSeasonUIType_Winter == currentSeasonUIType then
  currentSeasonObjectList = objectList.winter
  objectIndex_min = 0
  objectIndex_max = 9
end
if true == _ContentsGroup_SeasonUI then
  registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_TextureChange")
end
local textureControl = {}
local publicOjectControl = {}
function FromClient_luaLoadComplete_TextureChange()
  if false == contentOpen then
    return
  end
  if "" == ddsLink then
    return
  end
  if nil == currentSeasonObjectList then
    return
  end
  if __eSeasonUIType_Default == currentSeasonUIType then
    return
  end
  PaGlobal_SeasonTexture_ContentsGroupAddPanel()
  for index = 0, #panelList do
    textureControl[index] = {}
    publicOjectControl[index] = {}
    for pIndex, panel in pairs(panelList[index]) do
      local temp = UI.createControl(__ePAUIControl_Static, panel, "textureControl_" .. index .. "_" .. pIndex)
      temp:SetShow(true)
      temp:SetSize(panel:GetSizeX(), objectParentsSizeY)
      temp:SetHorizonLeft()
      temp:SetVerticalTop()
      temp:SetSpanSize(0, -temp:GetSizeY())
      temp:SetIgnore(true)
      textureControl[index][pIndex] = temp
      publicOjectControl[index][pIndex] = {}
      if __eSeasonUIType_Spring == currentSeasonUIType then
      elseif __eSeasonUIType_Summer == currentSeasonUIType then
        publicOjectControl[index][pIndex].wave = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlWave_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].watermelonA = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlWatermelonA_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].watergun = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlWaterGun_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].juice = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlJuice_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].watermelonB = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlWatermelonB_" .. index .. "_" .. pIndex)
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].wave, 0, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].watermelonA, 1, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].watergun, 2, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].juice, 3, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].watermelonB, 4, panel:GetSizeX())
      elseif __eSeasonUIType_Autumn == currentSeasonUIType then
      elseif __eSeasonUIType_Winter == currentSeasonUIType then
        publicOjectControl[index][pIndex].snow = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlSnow_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].tree = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlTree_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].blackSpirit = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlSpirit_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].town = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlTown_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].penguin = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlPenguin_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].snowman = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlSnowman_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].cloud = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlCloud_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].fishing = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlFishing_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].bear = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlBear_" .. index .. "_" .. pIndex)
        publicOjectControl[index][pIndex].bird = UI.createControl(__ePAUIControl_Static, textureControl[index][pIndex], "publicTexture_ObjectControlBird_" .. index .. "_" .. pIndex)
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].snow, 0, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].tree, 1, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].blackSpirit, 2, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].town, 3, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].penguin, 4, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].snowman, 5, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].cloud, 6, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].fishing, 7, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].bear, 8, panel:GetSizeX())
        SeasonTexture_ObjectCreate(publicOjectControl[index][pIndex].bird, 9, panel:GetSizeX())
      end
      panel:RegisterShowPreUpdateFunc("seasonTexturChangebyPanelName")
    end
  end
  seasonTexturChangebyPanelName()
end
function SeasonTexture_ObjectCreate(control, index, panelSizeX)
  local randomPosX = 0
  if __eSeasonUIType_Spring == currentSeasonUIType then
  elseif __eSeasonUIType_Summer == currentSeasonUIType then
    if 0 == index or 1 == index then
      randomPosX = -currentSeasonObjectList[index].sizeX
    elseif 2 == index or 3 == index or 4 == index then
      randomPosX = panelSizeX
    end
  elseif __eSeasonUIType_Autumn == currentSeasonUIType then
  elseif __eSeasonUIType_Winter == currentSeasonUIType then
    randomPosX = panelSizeX / math.ceil(math.random(1, 10))
  end
  cruRandomPosX[index] = randomPosX
  local posX = math.min(randomPosX + currentSeasonObjectList[index].sizeX, panelSizeX - currentSeasonObjectList[index].sizeX)
  control:SetSize(currentSeasonObjectList[index].sizeX, currentSeasonObjectList[index].sizeY)
  control:SetHorizonLeft()
  control:SetVerticalBottom()
  control:SetSpanSize(posX, currentSeasonObjectList[index].posY)
  control:SetShow(false)
  control:SetIgnore(true)
  control:ChangeTextureInfoName(ddsLink)
  local x1, y1, x2, y2 = setTextureUV_Func(control, currentSeasonObjectList[index]._x1, currentSeasonObjectList[index]._y1, currentSeasonObjectList[index]._x2, currentSeasonObjectList[index]._y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function seasonTexturChangebyPanelName(currentPanelName)
  if false == contentOpen then
    return
  end
  local isValidParam = true
  if nil == currentPanelName then
    isValidParam = false
  end
  for index = 0, #panelList do
    for pIndex, panel in pairs(panelList[index]) do
      if nil == currentPanelName or panel:GetID() == currentPanelName then
        local temp = textureControl[index][pIndex]
        if temp:GetSizeX() ~= panel:GetSizeX() then
          if temp:GetSizeX() < panel:GetSizeX() then
            temp:SetSize(panel:GetSizeX(), objectParentsSizeY)
          elseif panel:GetSizeX() < temp:GetSizeX() then
            temp:SetSize(panel:GetSizeX(), objectParentsSizeY)
          end
        end
        if __eSeasonUIType_Spring == currentSeasonUIType then
        elseif __eSeasonUIType_Summer == currentSeasonUIType then
          publicOjectControl[index][pIndex].wave:SetShow(false)
          publicOjectControl[index][pIndex].watermelonA:SetShow(false)
          publicOjectControl[index][pIndex].watergun:SetShow(false)
          publicOjectControl[index][pIndex].juice:SetShow(false)
          publicOjectControl[index][pIndex].watermelonB:SetShow(false)
          if 1 == index and 6 == pIndex then
            break
          elseif 2 == index and 42 == pIndex then
            publicOjectControl[index][pIndex].watermelonB:SetShow(true)
            break
          end
          local leftObjectRandomValue = math.floor(math.random(0, 1))
          if 0 == leftObjectRandomValue then
            publicOjectControl[index][pIndex].wave:SetShow(true)
          elseif 1 == leftObjectRandomValue then
            publicOjectControl[index][pIndex].watermelonA:SetShow(true)
          end
          local rightObjectRandomValue = math.floor(math.random(2, 3))
          if 2 == rightObjectRandomValue then
            publicOjectControl[index][pIndex].watergun:SetShow(true)
          elseif 3 == rightObjectRandomValue then
            publicOjectControl[index][pIndex].juice:SetShow(true)
          end
        elseif __eSeasonUIType_Autumn == currentSeasonUIType then
        elseif __eSeasonUIType_Winter == currentSeasonUIType then
          local rndIndex = math.floor(math.random(0, 4))
          temp:ChangeTextureInfoName(ddsLink)
          local x1, y1, x2, y2 = setTextureUV_Func(temp, windowTopTextureList[index][rndIndex]._x1, windowTopTextureList[index][rndIndex]._y1, windowTopTextureList[index][rndIndex]._x2, windowTopTextureList[index][rndIndex]._y2)
          temp:getBaseTexture():setUV(x1, y1, x2, y2)
          temp:setRenderTexture(temp:getBaseTexture())
          publicOjectControl[index][pIndex].snow:SetShow(false)
          publicOjectControl[index][pIndex].tree:SetShow(false)
          publicOjectControl[index][pIndex].blackSpirit:SetShow(false)
          publicOjectControl[index][pIndex].town:SetShow(false)
          publicOjectControl[index][pIndex].penguin:SetShow(false)
          publicOjectControl[index][pIndex].snowman:SetShow(false)
          publicOjectControl[index][pIndex].cloud:SetShow(false)
          publicOjectControl[index][pIndex].fishing:SetShow(false)
          publicOjectControl[index][pIndex].bear:SetShow(false)
          publicOjectControl[index][pIndex].bird:SetShow(false)
          if 1 == index and 6 == pIndex then
            break
          end
          local objectRandomValue = math.floor(math.random(objectIndex_min, objectIndex_max))
          if 0 == objectRandomValue then
          elseif 1 == objectRandomValue then
            publicOjectControl[index][pIndex].tree:SetShow(true)
          elseif 2 == objectRandomValue then
            publicOjectControl[index][pIndex].blackSpirit:SetShow(true)
          elseif 3 == objectRandomValue then
            publicOjectControl[index][pIndex].town:SetShow(true)
          elseif 4 == objectRandomValue then
            publicOjectControl[index][pIndex].penguin:SetShow(true)
          elseif 5 == objectRandomValue then
            publicOjectControl[index][pIndex].snowman:SetShow(true)
          elseif 6 == objectRandomValue then
            publicOjectControl[index][pIndex].cloud:SetShow(true)
          elseif 7 == objectRandomValue then
            publicOjectControl[index][pIndex].fishing:SetShow(true)
          elseif 8 == objectRandomValue then
            publicOjectControl[index][pIndex].bear:SetShow(true)
          elseif 9 == objectRandomValue then
            publicOjectControl[index][pIndex].bird:SetShow(true)
          end
        end
        if true == isValidParam then
          return
        end
      end
    end
  end
end
function FGlobal_SeasonTexture_ChannelSelectPanelSizeCahnge(sizeX)
  if false == contentOpen then
    return
  end
  if false == isLuaLoadingComplete then
    return
  end
  if nil ~= textureControl[1][6] then
    textureControl[1][6]:SetSize(sizeX, textureControl[1][6]:GetSizeY())
  end
end
function PaGlobal_SeasonTexture_ContentsGroupAddPanel()
  if false == _ContentsGroup_PanelReload_Develop then
    panelList[2][0] = Panel_Window_Guild
    panelList[2][1] = Panel_Window_CharInfo_Status
    if false == _ContentsGroup_NewUI_DailyStamp_All then
      panelList[2][12] = Panel_Window_DailyStamp
    else
      panelList[2][12] = Panel_Window_DailyStamp_All
      isCombinePanel[2][12] = true
    end
    panelList[1][38] = Panel_Window_ServantInventory
    panelList[1][20] = Panel_Guild_NoneJoinMember
    if false == _ContentsGroup_NewUI_CreateClan_All then
      panelList[1][53] = Panel_CreateClan
    else
      panelList[1][53] = Panel_CreateClan_All
      isCombinePanel[1][53] = true
    end
    panelList[1][16] = Panel_CompetitionGame_JoinDesc
  end
  if false == _ContentsGroup_SeasonContents then
    panelList[1][63] = nil
    isCombinePanel[1][63] = true
  end
  if true == isConsoleMode then
    panelList[2][42] = nil
  end
end
local textureIndexList = {
  Panel_Window_Guild = 2,
  Panel_Window_CharInfo_Status = 2,
  Panel_Window_DailyStamp = 2,
  Panel_Window_ServantInventory = 1,
  Panel_Guild_NoneJoinMember = 1,
  Panel_CreateClan = 1,
  Panel_CompetitionGame_JoinDesc = 1
}
local seasonList = {}
function PaGlobal_SeasonTexture_SetPanel(panel)
  if nil == panel then
    return
  end
  local seasonData = {
    _panel = nil,
    _control = nil,
    _objectControl = nil
  }
  seasonData._panel = panel
  seasonData._control = seasonList:getTextureControl(panel)
  seasonData._objectControl = seasonList:getObjectControl(panel, seasonData._control)
  panel:RegisterShowPreUpdateFunc("PaGlobal_SeasonTexture_ShowChangePanelTexture")
  seasonList[panel:GetID()] = seasonData
end
function seasonList:getTextureControl(panel)
  UI.ASSERT_NAME(nil ~= panel, "seasonList:getTextureControl panel nil", "\236\178\156\235\167\140\234\184\176")
  local panelId = panel:GetID()
  local control = UI.createControl(__ePAUIControl_Static, panel, "textureControl_" .. panelId)
  control:SetShow(true)
  control:SetSize(panel:GetSizeX(), objectParentsSizeY)
  control:SetPosX(0)
  control:SetPosY(-objectParentsSizeY)
  control:SetIgnore(true)
  return control
end
function seasonList:getObjectControl(panel, control)
  UI.ASSERT_NAME(nil ~= panel, "seasonList:getObjectControl panel nil", "\236\178\156\235\167\140\234\184\176")
  UI.ASSERT_NAME(nil ~= control, "seasonList:getObjectControl control nil", "\236\178\156\235\167\140\234\184\176")
  local panelId = panel:GetID()
  local objectControl = {}
  if __eSeasonUIType_Spring == currentSeasonUIType then
  elseif __eSeasonUIType_Summer == currentSeasonUIType then
    objectControl.wave = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlWave_" .. panelId)
    objectControl.watermelonA = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlWatermelonA_" .. panelId)
    objectControl.watergun = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlWaterGun_" .. panelId)
    objectControl.juice = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlJuice_" .. panelId)
    objectControl.watermelonB = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlWatermelonB_" .. panelId)
    SeasonTexture_ObjectCreate(objectControl.wave, 0, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.watermelonA, 1, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.watergun, 2, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.juice, 3, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.watermelonB, 4, panel:GetSizeX())
  elseif __eSeasonUIType_Autumn == currentSeasonUIType then
  elseif __eSeasonUIType_Winter == currentSeasonUIType then
    objectControl.snow = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlSnow_" .. panelId)
    objectControl.tree = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlTree_" .. panelId)
    objectControl.blackSpirit = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlSpirit_" .. panelId)
    objectControl.town = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlTown_" .. panelId)
    objectControl.penguin = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlPenguin_" .. panelId)
    objectControl.snowman = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlSnowman_" .. panelId)
    objectControl.cloud = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlCloud_" .. panelId)
    objectControl.fishing = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlFishing_" .. panelId)
    objectControl.bear = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlBear_" .. panelId)
    objectControl.bird = UI.createControl(__ePAUIControl_Static, control, "publicTexture_ObjectControlBird_" .. panelId)
    SeasonTexture_ObjectCreate(objectControl.snow, 0, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.tree, 1, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.blackSpirit, 2, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.town, 3, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.penguin, 4, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.snowman, 5, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.cloud, 6, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.fishing, 7, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.bear, 8, panel:GetSizeX())
    SeasonTexture_ObjectCreate(objectControl.bird, 9, panel:GetSizeX())
  end
  return objectControl
end
function PaGlobal_SeasonTexture_ShowChangePanelTexture(currentPanelName)
  if false == contentOpen then
    return
  end
  UI.ASSERT_NAME(nil ~= currentPanelName, "PaGlobal_SeasonTexture_ShowChangePanelTexture currentPanelName nil", "\236\178\156\235\167\140\234\184\176")
  if nil == currentPanelName or nil == seasonList[currentPanelName] then
    return
  end
  local seasonData = seasonList[currentPanelName]
  if nil == seasonData then
    return
  end
  local panel = seasonData._panel
  if nil == panel then
    return
  end
  local control = seasonData._control
  if nil == control then
    return
  end
  local objectControl = seasonData._objectControl
  if nil == objectControl then
    return
  end
  if control:GetSizeX() ~= panel:GetSizeX() then
    if control:GetSizeX() < panel:GetSizeX() then
      control:SetSize(panel:GetSizeX(), objectParentsSizeY)
    elseif panel:GetSizeX() < control:GetSizeX() then
      control:SetSize(panel:GetSizeX(), objectParentsSizeY)
    end
  end
  local rndIndex = math.floor(math.random(0, 4))
  local index = textureIndexList[currentPanelName]
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_SeasonTexture_ShowChangePanelTexture index nil", "\236\178\156\235\167\140\234\184\176")
  control:ChangeTextureInfoName(ddsLink)
  local x1, y1, x2, y2 = setTextureUV_Func(control, windowTopTextureList[index][rndIndex]._x1, windowTopTextureList[index][rndIndex]._y1, windowTopTextureList[index][rndIndex]._x2, windowTopTextureList[index][rndIndex]._y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  if __eSeasonUIType_Spring == currentSeasonUIType then
  elseif __eSeasonUIType_Summer == currentSeasonUIType then
    objectControl.wave:SetShow(false)
    objectControl.watermelonA:SetShow(false)
    objectControl.watergun:SetShow(false)
    objectControl.juice:SetShow(false)
    objectControl.watermelonB:SetShow(false)
    if panel == panelList[1][6] then
      return
    elseif panel == panelList[2][42] then
      objectControl.watermelonB:SetShow(true)
      return
    end
    local leftObjectRandomValue = math.floor(math.random(0, 1))
    if 0 == leftObjectRandomValue then
      objectControl.wave:SetShow(true)
    elseif 1 == leftObjectRandomValue then
      objectControl.watermelonA:SetShow(true)
    end
    local rightObjectRandomValue = math.floor(math.random(2, 3))
    if 2 == rightObjectRandomValue then
      objectControl.watergun:SetShow(true)
    elseif 3 == rightObjectRandomValue then
      objectControl.juice:SetShow(true)
    end
  elseif __eSeasonUIType_Autumn == currentSeasonUIType then
  elseif __eSeasonUIType_Winter == currentSeasonUIType then
    objectControl.snow:SetShow(false)
    objectControl.tree:SetShow(false)
    objectControl.blackSpirit:SetShow(false)
    objectControl.town:SetShow(false)
    objectControl.penguin:SetShow(false)
    objectControl.snowman:SetShow(false)
    objectControl.cloud:SetShow(false)
    objectControl.fishing:SetShow(false)
    objectControl.bear:SetShow(false)
    objectControl.bird:SetShow(false)
    if panel == panelList[1][6] then
      return
    end
    local objectRandomValue = math.floor(math.random(objectIndex_min, objectIndex_max))
    if 0 == objectRandomValue then
    elseif 1 == objectRandomValue then
      objectControl.tree:SetShow(true)
    elseif 2 == objectRandomValue then
      objectControl.blackSpirit:SetShow(true)
    elseif 3 == objectRandomValue then
      objectControl.town:SetShow(true)
    elseif 4 == objectRandomValue then
      objectControl.penguin:SetShow(true)
    elseif 5 == objectRandomValue then
      objectControl.snowman:SetShow(true)
    elseif 6 == objectRandomValue then
      objectControl.cloud:SetShow(true)
    elseif 7 == objectRandomValue then
      objectControl.fishing:SetShow(true)
    elseif 8 == objectRandomValue then
      objectControl.bear:SetShow(true)
    elseif 9 == objectRandomValue then
      objectControl.bird:SetShow(true)
    end
  end
end
