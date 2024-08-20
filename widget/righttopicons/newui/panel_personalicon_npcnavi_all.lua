PaGlobal_NpcNavi_All = {
  _ui = {
    stc_TitleArea = nil,
    txt_Title = nil,
    stc_TopAreaBG = nil,
    stc_TabBg = nil,
    stc_TabSelectedLine = nil,
    _rdo_All = nil,
    _rdo_BookMark = nil,
    _rdo_Hunt = nil,
    stc_AllTabBg = nil,
    list2_NpcList = nil,
    stc_BookMarkBg = nil,
    list2_BookMark = nil,
    txt_NoBookMark = nil,
    btn_OpenWorldMap = nil,
    stc_HuntBg = nil,
    list2_HuntList = nil,
    stc_WareHouseBG = nil,
    frame_CityList = nil,
    frame_CityContent = nil,
    frame_HoriScroll = nil,
    stc_frameLeft = nil,
    stc_frameRight = nil,
    _btn_CityList = {},
    stc_SearchBG = nil,
    tree_Npc = nil,
    tree_overStatic = nil,
    scroll = nil,
    edit_Serarch = nil,
    txt_ErrorText = nil,
    txt_Desc = nil
  },
  _ui_pc = {btn_Close = nil, btn_Search = nil},
  _ui_console = {
    txt_TabKeyLB = nil,
    txt_TabKeyRB = nil,
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideDPadVer = nil,
    txt_KeyGuideDPadHor = nil,
    txt_KeyGuideLBRB = nil
  },
  _warehouseCount = 8,
  _warehouseBtns = {},
  _TOWNCOUNT = 8,
  _wareHouseBtnScrollIndex = 0,
  _territoryTownData = {
    [1] = {
      _x = 8489.57,
      _y = -7818.83,
      _z = 82973.3,
      _actorKey = 40044,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_1"),
      _isOpen = true,
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_valenos_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [2] = {
      _x = 40853.2,
      _y = -3474.33,
      _z = -50928,
      _actorKey = 41013,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_2"),
      _isOpen = true,
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_selendia_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [3] = {
      _x = -254083,
      _y = -2754.48,
      _z = -40846.4,
      _actorKey = 42138,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_3"),
      _isOpen = ToClient_IsContentsGroupOpen("2"),
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_calpheon_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [4] = {
      _x = 364177,
      _y = -4957.73,
      _z = -74140.1,
      _actorKey = 44019,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_4"),
      _isOpen = ToClient_IsContentsGroupOpen("3"),
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_mediah_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [5] = {
      _x = 1032890.02,
      _y = 11019.9,
      _z = 190786,
      _actorKey = 45016,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_5"),
      _isOpen = ToClient_IsContentsGroupOpen("4"),
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_valencia_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [6] = {
      _x = -514130,
      _y = 8984.42,
      _z = -455421,
      _actorKey = 45555,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_6"),
      _isOpen = ToClient_IsContentsGroupOpen("5"),
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_kamasylvia_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [7] = {
      _x = -46455.86,
      _y = 22008.5,
      _z = -403908.03,
      _actorKey = 46008,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_WAREHOUSE_7"),
      _isOpen = ToClient_IsContentsGroupOpen("6"),
      _dds = "new_ui_common_forlua/widget/worldmap/territory/territorymark_drigan_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    },
    [8] = {
      _x = -172548.02,
      _y = 19582.9,
      _z = -611631,
      _actorKey = 47008,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNAVI_WAREHOUSE_8"),
      _isOpen = ToClient_IsContentsGroupOpen("7"),
      _dds = "renewal/etc/wordmap/territorymark_odyllita_large.dds",
      _uv = {
        x1 = 0,
        x2 = 256,
        y1 = 0,
        y2 = 265
      }
    }
  },
  lazyUpdate = false,
  selectIndex = -1,
  treeGroupData = {},
  preLoadTextureKey = {},
  preLoadTextureKey_territory = {},
  cacheExecuteDialogData = {},
  filterText = "",
  isMouseOnPanel = false,
  isMouseOnTreeView = false,
  errorMessageShow = true,
  isChecked_AddEffect = 0,
  isChecked_EffectReset = 0,
  _basePanelSizeY = 770,
  _baseTopAreaBGSizeY = 250,
  _eTAB = {
    NPC = 0,
    BOOKMARK = 1,
    HUNT = 2
  },
  _currentTab = 0,
  _useableNpcBtn = {},
  _isConsole = false,
  _initialize = false,
  _iconTextureData = {
    [CppEnums.SpawnType.eSpawnType_SkillTrainer] = {
      x1 = 145,
      y1 = 505,
      x2 = 180,
      y2 = 540,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 24,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_ItemRepairer] = {
      x1 = 37,
      y1 = 109,
      x2 = 72,
      y2 = 144,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 22,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_TradeMerchant] = {
      x1 = 253,
      y1 = 73,
      x2 = 288,
      y2 = 108,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 22,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_WareHouse] = {
      x1 = 116,
      y1 = 116,
      x2 = 171,
      y2 = 171,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_Stable] = {
      x1 = 217,
      y1 = 73,
      x2 = 252,
      y2 = 108,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 22,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Wharf] = {
      x1 = 173,
      y1 = 287,
      x2 = 228,
      y2 = 342,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_guild] = {
      x1 = 2,
      y1 = 287,
      x2 = 57,
      y2 = 342,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_Potion] = {
      x1 = 361,
      y1 = 73,
      x2 = 396,
      y2 = 108,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 23,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Weapon] = {
      x1 = 2,
      y1 = 2,
      x2 = 57,
      y2 = 57,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_Jewel] = {
      x1 = 469,
      y1 = 613,
      x2 = 504,
      y2 = 648,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 30,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Collect] = {
      x1 = 397,
      y1 = 613,
      x2 = 432,
      y2 = 648,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 30,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Fish] = {
      x1 = 401,
      y1 = 287,
      x2 = 456,
      y2 = 342,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_Worker] = {
      x1 = 2,
      y1 = 230,
      x2 = 57,
      y2 = 285,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 28,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_ItemMarket] = {
      x1 = 287,
      y1 = 2,
      x2 = 342,
      y2 = 57,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_TerritorySupply] = {
      x1 = 370,
      y1 = 124,
      x2 = 410,
      y2 = 164,
      dds = "combine/icon/combine_dialogue_icon_00.dds",
      size = 23,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Cook] = {
      x1 = 109,
      y1 = 73,
      x2 = 144,
      y2 = 108,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 28,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_Furniture] = {
      x1 = 433,
      y1 = 613,
      x2 = 468,
      y2 = 648,
      dds = "combine/icon/combine_tab_icon_00.dds",
      size = 25,
      color = Defines.Color.C_FFFFFFFF
    },
    [CppEnums.SpawnType.eSpawnType_transfer] = {
      x1 = 59,
      y1 = 173,
      x2 = 114,
      y2 = 228,
      dds = "combine/icon/combine_title_icon_00.dds",
      size = 36,
      color = Defines.Color.C_FFFFEDD4
    },
    [CppEnums.SpawnType.eSpawnType_Instrument] = {
      x1 = 124,
      y1 = 370,
      x2 = 164,
      y2 = 410,
      dds = "combine/icon/combine_dialogue_icon_00.dds",
      size = 25,
      color = Defines.Color.C_FFFFFFFF
    }
  },
  _list2HuntBtn = {},
  _list2BookMarkBtn = {},
  _currentBookMarkCount = 0,
  _isNewSaved = false,
  _eBTNTYPE = {
    NAVI = 0,
    AUTOMOVE = 1,
    CHANGENAME = 2,
    DELETE = 3,
    ATK = 4
  },
  _tooltipString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_CHECKPOSITION"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_FOLLOWWAY"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_CHANGENAME"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_DELETE"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NPCNAVI_ATKPOINT")
  }
}
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All_1.lua")
runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_NpcNaviInit")
function FromClient_PaGlobal_NpcNaviInit()
  PaGlobal_NpcNavi_All:initialize()
end
