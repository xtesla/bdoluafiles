Defines = {}
Defines.UIGroup = {
  PAGameUIGroup_ScreenEffect = 0,
  PAGameUIGroup_Widget = 50,
  PAGameUIGroup_MiniGameUI = 90,
  PAGameUIGroup_MainUI = 100,
  PAGameUIGroup_MiniGameUpUI = 150,
  PAGameUIGroup_MapRegion = 200,
  PAGameUIGroup_SkillAndBuff = 300,
  PAGameUIGroup_ProgressBar = 400,
  PAGameUIGroup_CrossHair = 500,
  PAGameUIGroup_CharacterAction = 600,
  PAGameUIGroup_Party = 700,
  PAGameUIGroup_Chatting = 800,
  PAGameUIGroup_Quest = 900,
  PAGameUIGroup_Dialog = 1000,
  PAGameUIGroup_QuestLog = 1100,
  PAGameUIGroup_Housing = 1150,
  PAGameUIGroup_Interaction = 1180,
  PAGameUIGroup_Windows = 1200,
  PAGameUIGroup_Window_Progress = 1250,
  PAGameUIGroup_InstanceMission = 1300,
  PAGameUIGroup_Siege = 1400,
  PAGameUIGroup_HouseInfo = 1460,
  PAGameUIGroup_EtcIcon = 1500,
  PAGameUIGroup_Alert = 1600,
  PAGameUIGroup_BattleAlert = 1700,
  PAGameUIGroup_WorldMap = 1800,
  PAGameUIGroup_WorldMap_Popups = 1850,
  PAGameUIGroup_WorldMap_Contents = 1880,
  PAGameUIGroup_GameMenu = 1900,
  PAGameUIGroup_DeadMessage = 2000,
  PAGameUIGroup_GameSystemMenu = 2100,
  PAGameUIGroup_ModalDialog = 2200,
  PAGameUIGroup_SimpleTooltip = 2250,
  PAGameUIGroup_Movie = 3000,
  PAGameUIGroup_FadeScreen = 5000,
  PAGameUIGroup_IntroMovie = 5001,
  PAGameUIGroup_Production_Modify = 5002,
  PAGameUIGroup_Tutorial = 6000
}
Defines.UIMode = {
  eUIMode_Default = 0,
  eUIMode_Housing = 1,
  eUIMode_Mental = 2,
  eUIMode_MentalGame = 3,
  eUIMode_NpcDialog = 4,
  eUIMode_NpcDialog_Dummy = 5,
  eUIMode_Trade = 6,
  eUIMode_WorldMap = 7,
  eUIMode_Stable = 8,
  eUIMode_MiniGame = 9,
  eUIMode_DeadMessage = 10,
  eUIMode_PreventMoveNSkill = 11,
  eUIMode_Movie = 12,
  eUIMode_GameExit = 13,
  eUIMode_Repair = 14,
  eUIMode_KeyCustom_Wait = 15,
  eUIMode_KeyCustom_ActionKey = 16,
  eUIMode_KeyCustom_ActionPad = 17,
  eUIMode_KeyCustom_UiKey = 18,
  eUIMode_KeyCustom_UiPad = 19,
  eUIMode_KeyCustom_ActionPadFunc1 = 20,
  eUIMode_KeyCustom_ActionPadFunc2 = 21,
  eUIMode_PopupItem = 22,
  eUIMode_Extraction = 23,
  eUIMode_InGameCustomize = 24,
  eUIMode_InGameCashShop = 25,
  eUIMode_DyeNew = 26,
  eUIMode_ItemMarket = 27,
  eUIMode_ProductNote = 28,
  eUIMode_QnAWebLink = 29,
  eUIMode_TradeGame = 30,
  eUIMode_Cutscene = 31,
  eUIMode_UiSetting = 32,
  eUIMode_Gacha_Roulette = 33,
  eUIMode_EventNotify = 34,
  eUIMode_WoldMapSearch = 36,
  eUIMode_ScreenShotMode = 37,
  eUIMode_InGameDance = 38,
  eUIMode_KeyCustom_ButtonShortcuts = 39,
  eUIMode_SkillWindow = 40,
  eUIMode_KeyCustom_ActionPad_XBOX = 41,
  eUIMode_Arsha_Replay = 42,
  eUIMode_GroupCamera = 43,
  eUIMode_ProductionModify = 44,
  eUIMode_SiegeInstallMode = 45,
  eUIMode_Tutorial = 46,
  eUIMode_Count = 47
}
Defines.u64_const = {
  u64_0 = toUint64(0, 0),
  u64_1 = toUint64(0, 1),
  u64_100 = toUint64(0, 100),
  u64_1000 = toUint64(0, 1000),
  u64_10000 = toUint64(0, 10000)
}
Defines.u64_const.u64_max = Defines.u64_const.u64_0 - Defines.u64_const.u64_1
Defines.u64_const.u64_max_m1 = Defines.u64_const.u64_max - Defines.u64_const.u64_1
Defines.s64_const = {
  s64_m1 = toInt64(0, -1),
  s64_0 = toInt64(0, 0),
  s64_1 = toInt64(0, 1),
  s64_100 = toInt64(0, 100),
  s64_1000 = toInt64(0, 1000),
  s64_10000 = toInt64(0, 10000)
}
local u64_max_half = Defines.u64_const.u64_max / toUint64(0, 2)
Defines.s64_const.s64_min = Defines.s64_const.s64_1 + u64_max_half
Defines.s64_const.s64_max = Defines.s64_const.s64_min - Defines.s64_const.s64_1
function Defines.s64_max(...)
  local argLength = #arg
  if argLength > 0 then
    local maxValue = arg[1]
    for ii = 2, argLength do
      local compValue = arg[ii]
      if maxValue < compValue then
        maxValue = compValue
      end
    end
    return maxValue
  end
end
function Defines.s64_min(...)
  local argLength = #arg
  if argLength > 0 then
    local minValue = arg[1]
    for ii = 2, argLength do
      local compValue = arg[ii]
      if minValue > compValue then
        minValue = compValue
      end
    end
    return minValue
  end
end
Defines.Color = {
  C_00000000 = 0,
  C_FF000000 = 4278190080,
  C_70FFFFFF = 1895825407,
  C_00FF0000 = 16711680,
  C_FFFF0000 = 4294901760,
  C_FFD20000 = 4291952640,
  C_FFF26A6A = 4294077034,
  C_FF775555 = 4286010709,
  C_00FFD46D = 16766061,
  C_FFFFD46D = 4294956141,
  C_FFFFF3AF = 4294964143,
  C_FFEDE699 = 4293781145,
  C_FFEF9C7F = 4293690196,
  C_FFEE7001 = 4293816321,
  C_00FF4729 = 16729897,
  C_FFFF4729 = 4294919977,
  C_00FFFFFF = 16777215,
  C_55FFFFFF = 1442840575,
  C_88FFFFFF = 2298478591,
  C_AAFFFFFF = 2868903935,
  C_FFFFFFFF = 4293914607,
  C_FF858585 = 4286940549,
  C_FFDFDFDF = 4292861919,
  C_99FFFFFF = 2583691263,
  C_00B5FF6D = 11927405,
  C_FFB5FF6D = 4290117485,
  C_FFC8FFC8 = 4291362760,
  C_006DC6FF = 7194367,
  C_FF6C7DE4 = 4285300196,
  C_FF6DC6FF = 4285384447,
  C_FF96D4FC = 4288075004,
  C_FF002A56 = 4278200918,
  C_FF00C0D7 = 4278239447,
  C_00C4BEBE = 12893886,
  C_FFC4BEBE = 4291083966,
  C_00FFAB6D = 16755565,
  C_FFFFAB6D = 4294945645,
  C_00B75EDD = 12017373,
  C_FFB75EDD = 4290207453,
  C_00FFCE22 = 16764450,
  C_FFFFCE22 = 4294954530,
  C_FFFFEEA0 = 4294962848,
  C_FFFAE696 = 4294633110,
  C_FFF0EF9D = 4293980061,
  C_FFD8CABA = 4292397754,
  C_FFEEBA3E = 4293835326,
  C_FF69BB4C = 4285119308,
  C_0088DF00 = 16764450,
  C_FF88DF00 = 4287160064,
  C_FF888888 = 4287137928,
  C_FF515151 = 4283519313,
  C_00444444 = 4473924,
  C_FF444444 = 4282664004,
  C_00626262 = 6447714,
  C_FF626262 = 4284637794,
  C_00797979 = 7960953,
  C_FF797979 = 4291414473,
  C_FFC1FFC2 = 4290904002,
  C_00BBFF84 = 12320644,
  C_FFBBFF84 = 4290510724,
  C_FFACE400 = 4289520640,
  C_008484FF = 8684799,
  C_FF8484FF = 4286874879,
  C_00FF8484 = 16745604,
  C_FFFF8484 = 4294935684,
  C_00FFFB84 = 16776068,
  C_FFFFFB84 = 4294966148,
  C_00FF973A = 16750394,
  C_FFFF973A = 4294940474,
  C_0084D2FF = 8704767,
  C_FF84D2FF = 4286894847,
  C_FF008AFF = 4278225663,
  C_FF0054FF = 4278211839,
  C_FF67FFA4 = 4285005732,
  C_FFFF7C67 = 4294933607,
  C_00341A1B = 3414555,
  C_FF76CAFF = 4285975295,
  C_FFFF5F5F = 4294926175,
  C_FFFF3BF8 = 4294917112,
  C_FFFFBC3A = 4294949946,
  C_FFB10000 = 4289789952,
  C_FF7F7F7F = 4286545791,
  C_FF2478FF = 4280580351,
  C_FFEFEFEF = 4293914607,
  C_FFBFBFBF = 4290756543,
  C_FFF03838 = 4293933112,
  C_FFEF5378 = 4293874552,
  C_FFFF8957 = 4294936919,
  C_FF6A0000 = 4285136896,
  C_FF00f0ff = 4278251775,
  C_FFA3A3A3 = 4288914339,
  C_FF58FAFF = 4284021503,
  C_FFC2313D = 4290916669,
  C_FFD16400 = 4291912704,
  C_FF62B15B = 4284658011,
  C_FF468ADA = 4282813146,
  C_FFDBB038 = 4292587576,
  C_FF5DFF70 = 4284350320,
  C_FF4B97FF = 4283144191,
  C_FFFFC832 = 4294953010,
  C_FFFF6C00 = 4294929408,
  C_FF686868 = 4285032552,
  C_FF6F6D10 = 4285492496,
  C_FF3B6491 = 4282082449,
  C_FFB68827 = 4290152487,
  C_FFC95A40 = 4291385920,
  C_FF3BD3FF = 4282110975,
  C_FFC4A68A = 4291077770,
  C_FF748CAB = 4285828267,
  C_FFBC56E1 = 4290533089,
  C_FFA8FC00 = 4289264640,
  C_FFFBFF8A = 4294705034,
  C_FFFF8A8A = 4294937226,
  C_FFFF3636 = 4294915638,
  C_FF7800D5 = 4286054613,
  C_FFFFAE00 = 4294946304,
  C_FFD98F00 = 4292448000,
  C_FFD96100 = 4292436224,
  C_FFCE3A00 = 4291705344,
  C_FFC00000 = 4290772992,
  C_FFF4D35D = 4294234973,
  C_FF5578B4 = 4283791540,
  C_FF00C2EA = 4278239978,
  C_FF844BE3 = 4286860259,
  C_FFE37F4B = 4293099339,
  C_FFDA0000 = 4292476928,
  C_FFBCF44B = 4290573387,
  C_FF4BF4B5 = 4283167925,
  C_FFFF4C4C = 4294921292,
  C_FFFF874C = 4294936396,
  C_FFAEFF9B = 4289658779,
  C_FF9B9BFF = 4288388095,
  C_FF8737FF = 4287051775,
  C_FFE7E7E7 = 4293388263,
  C_FFD2B4FF = 4291998975,
  C_FFFF9BFE = 4294941694,
  C_FF6B6B6B = 4285229931,
  C_FF999999 = 4288256409,
  C_FFFFEF82 = 4294963074,
  C_FFFF4B4B = 4294921035,
  C_FF84FFF5 = 4286906357,
  C_FF00B4FF = 4278236415,
  C_FFAAAAAA = 4289374890,
  C_FF926CFF = 4287786239,
  C_FFF601FF = 4294312447,
  C_FF8EBD00 = 4287544576,
  C_FFFFCF4C = 4294954828,
  C_FF00F3A0 = 4278252448,
  C_FFB97FEF = 4290346991,
  C_FFFF4EB2 = 4294921906,
  C_FFC694FF = 4291204351,
  C_FF97FFF8 = 4288151544,
  C_FF804040 = 4286595136,
  C_FF40D7FD = 4282439677,
  C_FFDCD489 = 4292662409,
  C_FFFFE069 = 4294959209,
  C_FF3DB298 = 4282233496,
  C_FFFFDD81 = 4294958465,
  C_FFFFCE57 = 4294954583,
  C_FFF4A72D = 4294223661,
  C_FFE26A13 = 4293028371,
  C_FFE03A0D = 4292885005,
  C_FFF68383 = 4294345603,
  C_FFECADAD = 4293701037,
  C_FFE5C6C6 = 4293248710,
  C_FFCECECE = 4291743438,
  C_ffff8181 = 4294934913,
  C_ffdeff6d = 4292804461,
  C_FF387f14 = 4281892628,
  C_FFf570a1 = 4294275233,
  C_FF25c28b = 4280664715,
  C_FF3E5CFF = 4282277119,
  C_FFBE4A00 = 4290660864,
  C_FF00A1FF = 4278231551,
  C_FFA3EF00 = 4288933632,
  C_FF367CFE = 4281761022,
  C_FF8B4DFF = 4287319551,
  C_FFBFBFB7 = 4290756535,
  C_FFF0D147 = 4293972295,
  C_FF81CE1C = 4286696988,
  C_FFC4C4C4 = 4291085508,
  C_FF76B24D = 4285968973,
  C_FF3B8BBE = 4282092478,
  C_FFEBC467 = 4293641319,
  C_FFD04D47 = 4291841351,
  C_FFB23BC7 = 4289870791,
  C_FF6E5846 = 4285421638,
  C_FFC78045 = 4291264581,
  C_FF979CFF = 4288126207,
  C_FFA1A1A1 = 4288782753,
  C_FF6C75A8 = 4285298088,
  C_FFFFE050 = 4294959184,
  C_FF75FF50 = 4285923152,
  C_FF00FFD8 = 4278255576,
  C_FFFF00D8 = 4294901976,
  C_FFFF7200 = 4294930944,
  C_FF00FFFC = 4278255612,
  C_FFD70000 = 4292280320,
  C_FFE50D0D = 4293201165,
  C_FFD29A04 = 4291992068,
  C_FF74CB0E = 4285844238,
  C_FFB82929 = 4290259241,
  C_FFCB801E = 4291526686,
  C_FFD4AF4B = 4292128587,
  C_FF39A07D = 4281966717,
  C_FF2F77AB = 4281300907,
  C_FF312A55 = 4281412181,
  C_FF7D0084 = 4286382212,
  C_FFFFD237 = 4294955575,
  C_FFd5c8e8 = 4292200680,
  C_FFc6b4e0 = 4291212512,
  C_FFac91d1 = 4289499601,
  C_FF906bc1 = 4287654849,
  C_FF8359ba = 4286798266,
  C_FF5922a3 = 4284031651,
  C_FF43197a = 4282587514,
  C_FF3c176d = 4282128237,
  C_FF2c1151 = 4281078097,
  C_FF1e0c38 = 4280159288,
  C_FF160929 = 4279634217,
  C_FFfdc9c8 = 4294822344,
  C_FFfdb5b4 = 4294817204,
  C_FFfc9391 = 4294742929,
  C_FFfa6e6b = 4294602347,
  C_FFfa5d59 = 4294597977,
  C_FFf82722 = 4294453026,
  C_FFba1d19 = 4290387225,
  C_FFa61a17 = 4289075735,
  C_FF7c1311 = 4286321425,
  C_FF550d0c = 4283763980,
  C_FF3e0a09 = 4282255881,
  C_FFbfdcf2 = 4290764018,
  C_FFa8cfee = 4289253358,
  C_FF80b9e6 = 4286626278,
  C_FF55a1dd = 4283802077,
  C_FF4196d9 = 4282488537,
  C_FF0173cc = 4278285260,
  C_FF015699 = 4278277785,
  C_FF014d89 = 4278275465,
  C_FF003966 = 4278204774,
  C_FF002746 = 4278200134,
  C_FF001d33 = 4278197555,
  C_FFfef5c7 = 4294899143,
  C_FFfef2b2 = 4294898354,
  C_FFfeec8f = 4294896783,
  C_FFfee568 = 4294894952,
  C_FFfee256 = 4294894166,
  C_FFfdd81e = 4294826014,
  C_FFbea216 = 4290683414,
  C_FFaa9114 = 4289368340,
  C_FF7e6c0f = 4286475279,
  C_FF564a0a = 4283845130,
  C_FF3f3608 = 4282332680,
  C_FFc1f8d1 = 4290902225,
  C_FFabf6c0 = 4289459904,
  C_FF84f2a3 = 4286902947,
  C_FF5aed84 = 4284149124,
  C_FF47eb75 = 4282903413,
  C_FF09e447 = 4278838343,
  C_FF07ab35 = 4278692661,
  C_FF069930 = 4278622512,
  C_FF047223 = 4278481443,
  C_FF034e18 = 4278406680,
  C_FF023912 = 4278335762,
  C_FFfec8dc = 4294887644,
  C_FFfeb4cf = 4294882511,
  C_FFfd92b9 = 4294808249,
  C_FFfc6ca0 = 4294732960,
  C_FFfc5b95 = 4294728597,
  C_FFfb2472 = 4294648946,
  C_FFbc1b55 = 4290517845,
  C_FFa8184c = 4289206348,
  C_FF7d1239 = 4286386745,
  C_FF560c27 = 4283829287,
  C_FF3f091d = 4282321181,
  C_FFffd9c8 = 4294957512,
  C_FFffccb4 = 4294954164,
  C_FFffb491 = 4294947985,
  C_FFff9a6b = 4294941291,
  C_FFff8f59 = 4294938457,
  C_FFff6922 = 4294928674,
  C_FFbf4f19 = 4290727705,
  C_FFab4617 = 4289414679,
  C_FF7f3411 = 4286526481,
  C_FF57240c = 4283900940,
  C_FF401a09 = 4282391049,
  C_FFfefefe = 4294901502,
  C_FFcbcbcb = 4291546059,
  C_FFa2a2a2 = 4288848546,
  C_FF828282 = 4286743170,
  C_FF656565 = 4284835173,
  C_FF474747 = 4282861383,
  C_FF323232 = 4281479730,
  C_FF232323 = 4280492835,
  C_FF181818 = 4279769112,
  C_FF111111 = 4279308561,
  C_FF000000 = 4278190080,
  C_AA000033 = 2852126771,
  C_FF24e8ff = 4280609023,
  C_FFF5DA6F = 4294302319,
  C_FFB22300 = 4289864448,
  C_FFEE9900 = 4293826816,
  C_FFD85300 = 4292367104,
  C_FFFFE866 = 4294961254,
  C_FFD82800 = 4292356096,
  C_FFFFE866 = 4294961254,
  C_FF0096FF = 4278228735,
  C_FFEE5555 = 4293809493,
  C_FFFFF369 = 4294964073,
  C_FFFFE59E = 4294960542,
  C_FF505DEC = 4283457004,
  C_FF07C1E3 = 4278698467,
  C_FF8B7455 = 4287329365,
  C_FFEDEDEE = 4293783022,
  C_FFEEEEEE = 4293848814,
  C_FF525B6D = 4283587437,
  C_FF5F5F6B = 4284440427,
  C_FF8DB245 = 4287476293,
  C_FF309BF5 = 4281375733,
  C_FFF0D147 = 4293972295,
  C_FFFF6244 = 4294926916,
  C_FFBA2737 = 4290389815,
  C_FFF55839 = 4294268985,
  C_FF92BDED = 4287806957,
  C_FF9397A7 = 4287862695,
  C_FFDDA309 = 4292715273,
  C_FFF5BA3A = 4294294074,
  C_FF76747D = 4285953149,
  C_FFE6B757 = 4293310295,
  C_FFBEC4DA = 4290692314,
  C_FFCCD1E4 = 4291613156,
  C_FFFFD691 = 4294956689,
  C_FFB2B9D4 = 4289903060,
  C_FFC4000C = 4291035148,
  C_FFFF8030 = 4294934576,
  C_FF89CB4A = 4287220554,
  C_FF0075C9 = 4278220233,
  C_FFB1B118 = 4289835287,
  C_FF65AED6 = 4284853974,
  C_FFCC9AD5 = 4291599061,
  C_FFB68827 = 4290152487,
  C_FFD56045 = 4292173893,
  C_FF96B8DF = 4288067807,
  C_FFFE475B = 4294854491,
  C_FFFFC4C4 = 4294952132,
  C_FF76B24D = 4285968973,
  C_FF3B8BBE = 4282092478,
  C_FFEBC467 = 4293641319,
  C_FFD04D47 = 4291841351,
  C_FFB23BC7 = 4289870791,
  C_FFC78045 = 4291264581,
  C_FFD05D48 = 4291849544,
  C_FFF5BA3A = 4294294074,
  C_FF83A543 = 4286817603,
  C_FF4898D0 = 4282947792,
  C_FFB9C2DC = 4290364124,
  C_FFFFDD00 = 4294958336,
  C_FFD7E6F4 = 4292339444,
  C_FFF5BA3A = 4294294074,
  C_FFC4C4C4 = 4291085508,
  C_FF83A543 = 4286817603,
  C_FF438DCC = 4282617292,
  C_FFF5BA3A = 4294294074,
  C_FFD05D48 = 4291845448,
  C_FFFFEDD4 = 4294962644,
  C_FF585453 = 4283978835,
  C_FF988D83 = 4288187779,
  C_FFFFEDD4 = 4294962644,
  C_FFDDC39E = 4292723614,
  C_FFD8AD70 = 4292390256,
  C_FFA78E6A = 4289171050,
  C_FFF5BA3A = 4294294074,
  C_FFD05D48 = 4291845448,
  C_FF5A5A5A = 4284111450,
  C_FFE0E0E0 = 4292927712,
  C_FFC0A989 = 4290816393,
  C_FF5C5C5C = 4284243036,
  C_FF59473B = 4284041019,
  C_FF4D4256 = 4283253334,
  C_FF5A393B = 4284102971,
  C_FF3E4558 = 4282271064,
  C_FF43503E = 4282601534,
  C_FF3F3F46 = 4282335046,
  C_FF6C6C6C = 4285295724,
  C_FFCEA057 = 4291731543,
  C_FFA997CD = 4289304525,
  C_FFFFCE89 = 4294954633,
  C_FFBBA6FF = 4290488063,
  C_FFFFF1B7 = 4294963639,
  C_FFE7D4FF = 4293383423,
  C_FFFCF422 = 4294767650,
  C_FF57F426 = 4283954214,
  C_00FFCC1B = 16763931,
  C_FFFFCC1B = 4294954011
}
Defines.RenderMode = {
  eRenderMode_Default = 0,
  eRenderMode_Loading = 1,
  eRenderMode_WorldMap = 2,
  eRenderMode_Knowledge = 3,
  eRenderMode_Dialog = 4,
  eRenderMode_UISetting = 5,
  eRenderMode_PowerSave = 6,
  eRenderMode_GroupCamera = 7,
  eRenderMode_Production = 8,
  eRenderMode_Count = 9
}
Defines.TooltipDataType = {
  ItemWrapper = 1,
  ItemSSWrapper = 2,
  CashBuffData = 3,
  PlainText = 4
}
Defines.TooltipTargetType = {
  Item = 1,
  ItemWithoutCompare = 2,
  ItemWithCraftNote = 3,
  ItemNameOnly = 4,
  CashBuff = 5,
  PlainText = 6,
  NameAndWeight = 7,
  ItemWithCraftNoteNoLock = 8
}
Defines.ConsoleBannerLinkType = {InGameWeb = 0, PearlShopItem = 1}
CONSOLEKEYGUID_ALIGN_TYPE = {
  eALIGN_TYPE_LEFT = 0,
  eALIGN_TYPE_RIGHT = 1,
  eALIGN_TYPE_CENTER = 2,
  eALIGN_TYPE_TOP = 3,
  eALIGN_TYPE_MIDDLE = 4,
  eALIGN_TYPE_BOTTOM = 5,
  eALIGN_TYPE_AUTO_WRAP_LEFT = 6,
  eALIGN_TYPE_RIGHTAUTOWRAP = 7,
  eALIGN_TYPE_COUNT = 8
}
Defines.CloseType = {
  eCloseType_CantClose = 0,
  eCloseType_Escape = 1,
  eCloseType_Attacked = 2,
  eCloseType_Force = 3,
  eCloseType_Count = 4
}
Defines.ConsoleKeyGuideType = {
  searchMode = 0,
  common = 1,
  screenshotGuide = 2,
  pearlShop = 3,
  observeMode = 4,
  crouch = 5,
  creep = 6,
  rideHorse = 7,
  rideShip = 8,
  matchlock = 9,
  packing = 10,
  rideCarriage = 11,
  shipCannon = 12,
  cannon = 13,
  flameTower = 14,
  hwacha = 15,
  battle = 16,
  cattlegate = 17,
  elephantHead = 18,
  elephantBack = 19,
  rideShipDriver = 20,
  rideRepairableCarriage = 21,
  rideShyDonkey = 22,
  rideBabyElephant = 23,
  rideDonkey = 24,
  rideCamel = 25,
  undefined = 999
}
Defines.ServiceTypeToString = {
  "DV",
  "KR",
  "KR",
  "KR",
  "JP",
  "JP",
  "RU",
  "RU",
  "CH",
  "CH",
  "NA",
  "NA",
  "TW",
  "TW",
  "SA",
  "SA",
  "TH",
  "TH",
  "ID",
  "ID",
  "TR",
  "TR",
  "PS",
  "PS",
  "XB",
  "XB",
  "GT",
  "GT"
}
Defines.LanguageTypeToString = {
  [0] = "DV",
  "KR",
  "EN",
  "JP",
  "CH",
  "RU",
  "FR",
  "DE",
  "ES",
  "TW",
  "SA",
  "PT",
  "TH",
  "ID",
  "TR",
  "AE",
  "PS",
  "XB",
  "SP",
  "XX"
}
Defines.RenderMode.eRenderMode_LuaMode = Defines.RenderMode.eRenderMode_Count
Defines.RenderMode.eRenderMode_Dye = Defines.RenderMode.eRenderMode_LuaMode + 0
Defines.RenderMode.eRenderMode_InGameCashShop = Defines.RenderMode.eRenderMode_LuaMode + 1
Defines.RenderMode.eRenderMode_customScreenShot = Defines.RenderMode.eRenderMode_LuaMode + 2
Defines.RenderMode.eRenderMode_IngameCustomize = Defines.RenderMode.eRenderMode_LuaMode + 3
Defines.RenderMode.eRenderMode_HouseInstallation = Defines.RenderMode.eRenderMode_LuaMode + 4
Defines.RenderMode.eRenderMode_CutScene = Defines.RenderMode.eRenderMode_LuaMode + 5
Defines.RenderMode.eRenderMode_BlackSpirit = Defines.RenderMode.eRenderMode_LuaMode + 6
Defines.RenderMode.eRenderMode_MentalGame = Defines.RenderMode.eRenderMode_LuaMode + 7
Defines.RenderMode.eRenderMode_Tutorial = Defines.RenderMode.eRenderMode_LuaMode + 8
Defines.RenderMode.eRenderMode_SkillWindow = Defines.RenderMode.eRenderMode_LuaMode + 9
Defines.RenderMode.eRenderMode_SniperGame = Defines.RenderMode.eRenderMode_LuaMode + 10
Defines.StringSheet_GAME = "GAME"
Defines.StringSheet_RESOURCE = "RESOURCE"
Defines.StringSheet_SymbolNo = "SymbolNo"
function PaGlobal_Homepage_Open()
  local url = "https://www.kr.playblackdesert.com/"
  if true == isGameTypeKorea() then
    url = "https://www.kr.playblackdesert.com/"
  elseif true == isGameTypeJapan() then
    url = "https://www.jp.playblackdesert.com/"
  elseif true == isGameTypeRussia() then
    url = "https://www.ru.playblackdesert.com/"
  elseif true == isGameTypeEnglish() then
    url = "https://www.naeu.playblackdesert.com/"
  elseif true == isGameTypeTaiwan() then
    url = "https://www.tw.playblackdesert.com/"
  elseif true == isGameTypeSA() then
    url = "https://blackdesert.playredfox.com/"
  elseif true == isGameTypeTR() then
    url = "https://www.tr.playblackdesert.com/"
  elseif true == isGameTypeTH() then
    url = "https://www.th.playblackdesert.com/"
  elseif true == isGameTypeID() then
    url = "https://www.sea.playblackdesert.com/"
  elseif true == isGameTypeGT() then
    url = "https://www.global-lab.playblackdesert.com/"
  elseif true == isGameTypeKR2() then
    url = "https://bd.woniu.com"
  end
  ToClient_OpenChargeWebPage(url, false)
end
function PaGlobal_Homepage_SeasonGMNoteOpen()
  local url = ToClient_getSeasonNoticeURL()
  if "" == url then
    return
  end
  ToClient_OpenChargeWebPage(url, false)
end
function PaGlobal_TransferPage_Open()
  if false == _ContentsGroup_TransferEventBuff then
    return
  end
  local url = "https://www.naeu.playblackdesert.com/"
  local languageType = ToClient_getResourceType()
  if nil == languageType then
    return
  end
  local languageTypeString = Defines.LanguageTypeToString[languageType]
  if nil == languageTypeString then
    return
  end
  if "DV" == languageTypeString then
    languageTypeString = "KR"
  end
  if CppEnums.ServiceResourceType.eServiceResourceType_ID == languageType then
    languageTypeString = "EN"
  end
  if "KR" == languageTypeString then
    url = url .. "ko-kr"
  elseif "EN" == languageTypeString then
    url = url .. "en-US"
  elseif "DE" == languageTypeString then
    url = url .. "de-DE"
  elseif "FR" == languageTypeString then
    url = url .. "fr-FR"
  else
    if "ES" == languageTypeString or "SP" == languageTypeString then
      url = url .. "es-ES"
    else
    end
  end
  ToClient_OpenChargeWebPage(url, false)
end
function ConvertFromGradeToColor(grade, printType)
  local returnValue
  if nil == printType then
    if 0 == grade then
      returnValue = Defines.Color.C_FFC4BEBE
    elseif 1 == grade then
      returnValue = Defines.Color.C_FF5DFF70
    elseif 2 == grade then
      returnValue = Defines.Color.C_FF4B97FF
    elseif 3 == grade then
      returnValue = Defines.Color.C_FFFFC832
    elseif 4 == grade then
      returnValue = Defines.Color.C_FFFF6C00
    else
      returnValue = Defines.Color.C_FFC4BEBE
    end
  elseif 0 == grade then
    returnValue = "<PAColor0xffc4bebe>"
  elseif 1 == grade then
    returnValue = "<PAColor0xFF5DFF70>"
  elseif 2 == grade then
    returnValue = "<PAColor0xFF4B97FF>"
  elseif 3 == grade then
    returnValue = "<PAColor0xFFFFC832>"
  elseif 4 == grade then
    returnValue = "<PAColor0xFFFF6C00>"
  else
    returnValue = "<PAColor0xffc4bebe>"
  end
  return returnValue
end
