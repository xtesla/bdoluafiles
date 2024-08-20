function PaGlobal_Window_Stat_All:initialize()
  if true == PaGlobal_Window_Stat_All._initialize then
    return
  end
  PaGlobal_Window_Stat_All._ui._btn_Close = UI.getChildControl(Panel_Window_Stat_All, "Button_Close")
  PaGlobal_Window_Stat_All._ui._stc_bounusStatBG = UI.getChildControl(Panel_Window_Stat_All, "Static_EquipBonusStatBg")
  PaGlobal_Window_Stat_All._ui._txt_desc = UI.getChildControl(Panel_Window_Stat_All, "StaticText_Desc2")
  PaGlobal_Window_Stat_All._ui._stc_line = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "Static_Line_Deco_3")
  PaGlobal_Window_Stat_All._ui._txt_addDamageTemplate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_Templete")
  PaGlobal_Window_Stat_All._ui._txt_offence = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackTitle")
  PaGlobal_Window_Stat_All._ui._txt_awakenOffence = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackTitle")
  PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Title")
  PaGlobal_Window_Stat_All._ui._txt_hit = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitTitle")
  PaGlobal_Window_Stat_All._ui._txt_hitRate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitTitle_1")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_Val")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToKama = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_1_Val")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToAin = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_2_Val")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_3_Val")
  PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_4_Val")
  PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_5_Val")
  PaGlobal_Window_Stat_All._ui._txt_StunRegist = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Stun_Reg_Val")
  PaGlobal_Window_Stat_All._ui._txt_GrabRegist = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Grab_Reg_Val")
  PaGlobal_Window_Stat_All._ui._txt_DownRegist = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Down_Reg_Val")
  PaGlobal_Window_Stat_All._ui._txt_AirRegist = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Air_Reg_Val")
  PaGlobal_Window_Stat_All._ui._txt_consoleKeyGuide = UI.getChildControl(Panel_Window_Stat_All, "Static_BottomBg_ConsoleUI_Import")
  PaGlobal_Window_Stat_All._ui._txt_dDv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_P")
  PaGlobal_Window_Stat_All._ui._txt_dDvRate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_1_P")
  PaGlobal_Window_Stat_All._ui._txt_dPv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVTitle_P")
  PaGlobal_Window_Stat_All._ui._txt_rDv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_R")
  PaGlobal_Window_Stat_All._ui._txt_rDvRate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_1_R")
  PaGlobal_Window_Stat_All._ui._txt_rPv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVTitle_R")
  PaGlobal_Window_Stat_All._ui._txt_mDv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_M")
  PaGlobal_Window_Stat_All._ui._txt_mDvRate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVTitle_1_M")
  PaGlobal_Window_Stat_All._ui._txt_mPv = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVTitle_M")
  PaGlobal_Window_Stat_All._ui._txt_reduceRate = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceTitle")
  PaGlobal_Window_Stat_All._ui._txt_characterStat_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Basic_Title")
  PaGlobal_Window_Stat_All._ui._txt_specialStat_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Familly_Title")
  PaGlobal_Window_Stat_All._ui._txt_equipStat_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Item_Title")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Hid_Title")
  PaGlobal_Window_Stat_All._ui._txt_added_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Add_Title")
  PaGlobal_Window_Stat_All._ui._txt_bonus_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Bonus_Title")
  PaGlobal_Window_Stat_All._ui._txt_result_desc = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Total_Title")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_Templete")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToKama_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_1")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToAin_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_2")
  PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_3")
  PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_4")
  PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_TribeAdd_Damage_5")
  PaGlobal_Window_Stat_All._ui._txt_StunRegist_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Stun_Reg")
  PaGlobal_Window_Stat_All._ui._txt_GrabRegist_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Grab_Reg")
  PaGlobal_Window_Stat_All._ui._txt_DownRegist_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Down_Reg")
  PaGlobal_Window_Stat_All._ui._txt_AirRegist_title = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_Air_Reg")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic_R")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Basic_R")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic_M")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Basic_M")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Basic")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Basic_1")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic_1")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic_1_R")
  PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Basic_1_M")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly_R")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Familly_R")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly_M")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Familly_M")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Familly")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Familly_1")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly_1")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly_1_R")
  PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Familly_1_M")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item_R")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Item_R")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item_M")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Item_M")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Item")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Item_1")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item_1")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item_1_R")
  PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Item_1_M")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid_R")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Hid_R")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid_M")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Hid_M")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Hid")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Hid_1")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid_1")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid_1_R")
  PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Hid_1_M")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add_R")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Add_R")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add_M")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Add_M")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Add")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Add_1")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add_1")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add_1_R")
  PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Add_1_M")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus_R")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Bonus_R")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus_M")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Bonus_M")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Bonus")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Bonus_1")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus_1")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus_1_R")
  PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Bonus_1_M")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_DD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AttackValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_ADD] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_AwakenAttackValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_DDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_DPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_RDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total_R")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_RPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Total_R")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_MDV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total_M")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_MPV] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HPVValue_Total_M")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_REDUCE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ReduceValue_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_SHYSTAT1] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat1_Value_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_SHYSTAT2] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat2_Value_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_SHYSTAT3] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_ShyStat3_Value_Total")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HitValue_Total_1")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_DDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total_1")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_RDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total_1_R")
  PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_MDV_RATE] = UI.getChildControl(PaGlobal_Window_Stat_All._ui._stc_bounusStatBG, "StaticText_HDVValue_Total_1_M")
  PaGlobal_Window_Stat_All:registEventHandler()
  PaGlobal_Window_Stat_All._bgSize = Panel_Window_Stat_All:GetSizeY()
  PaGlobal_Window_Stat_All._statBGSize = PaGlobal_Window_Stat_All._ui._stc_bounusStatBG:GetSizeY()
  PaGlobal_Window_Stat_All._descPosY = PaGlobal_Window_Stat_All._ui._txt_desc:GetPosY()
  PaGlobal_Window_Stat_All._aDDPosY = PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_ADD]:GetPosY()
  PaGlobal_Window_Stat_All._hitPosY = PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT]:GetPosY()
  PaGlobal_Window_Stat_All._hitRatePosY = PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT_RATE]:GetPosY()
  PaGlobal_Window_Stat_All:validate()
  PaGlobal_Window_Stat_All._defaultDescSizeY = PaGlobal_Window_Stat_All._ui._txt_desc:GetTextSizeY()
  PaGlobal_Window_Stat_All._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Window_Stat_All._ui._txt_desc:SetText(PaGlobal_Window_Stat_All._ui._txt_desc:GetText())
  if PaGlobal_Window_Stat_All._defaultDescSizeY < PaGlobal_Window_Stat_All._ui._txt_desc:GetTextSizeY() then
    local diff = PaGlobal_Window_Stat_All._ui._txt_desc:GetTextSizeY() - PaGlobal_Window_Stat_All._defaultDescSizeY
    Panel_Window_Stat_All:SetSize(Panel_Window_Stat_All:GetSizeX(), Panel_Window_Stat_All:GetSizeY() + diff)
  end
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_dDv, 1, "", PaGlobal_Window_Stat_All._ui._txt_dDv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_dDvRate, 1, "", PaGlobal_Window_Stat_All._ui._txt_dDvRate:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_dPv, 1, "", PaGlobal_Window_Stat_All._ui._txt_dPv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_rDv, 1, "", PaGlobal_Window_Stat_All._ui._txt_rDv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_rDvRate, 1, "", PaGlobal_Window_Stat_All._ui._txt_rDvRate:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_rPv, 1, "", PaGlobal_Window_Stat_All._ui._txt_rPv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_mDv, 1, "", PaGlobal_Window_Stat_All._ui._txt_mDv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_mDvRate, 1, "", PaGlobal_Window_Stat_All._ui._txt_mDvRate:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_mPv, 1, "", PaGlobal_Window_Stat_All._ui._txt_mPv:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_reduceRate, 1, "", PaGlobal_Window_Stat_All._ui._txt_reduceRate:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_offence, 1, "", PaGlobal_Window_Stat_All._ui._txt_offence:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_awakenOffence, 1, "", PaGlobal_Window_Stat_All._ui._txt_awakenOffence:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence, 1, "", PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_characterStat_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_characterStat_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_specialStat_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_specialStat_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_equipStat_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_equipStat_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_hiddenStat_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_hiddenStat_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_added_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_added_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_bonus_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_bonus_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_result_desc, 1, "", PaGlobal_Window_Stat_All._ui._txt_result_desc:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_addedDDToKama_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_addedDDToKama_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_addedDDToAin_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_addedDDToAin_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_StunRegist_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_StunRegist_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_GrabRegist_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_GrabRegist_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_DownRegist_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_DownRegist_title:GetText())
  UI.setLimitAutoWrapTextAndAddTooltip(PaGlobal_Window_Stat_All._ui._txt_AirRegist_title, 1, "", PaGlobal_Window_Stat_All._ui._txt_AirRegist_title:GetText())
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Window_Stat_All._ui._txt_consoleKeyGuide:SetShow(true)
    PaGlobal_Window_Stat_All._ui._btn_Close:SetShow(false)
    Panel_Window_Stat_All:ignorePadSnapMoveToOtherPanel()
  else
    PaGlobal_Window_Stat_All._ui._txt_consoleKeyGuide:SetShow(false)
    PaGlobal_Window_Stat_All._ui._btn_Close:SetShow(true)
  end
  PaGlobal_Window_Stat_All._initialize = true
end
function PaGlobal_Window_Stat_All:registEventHandler()
  if nil == Panel_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All._ui._btn_Close:addInputEvent("Mouse_LUp", "HandleEventOnOut_Window_Stat_All_Show(false)")
end
function PaGlobal_Window_Stat_All:prepareOpen()
  if nil == Panel_Window_Stat_All then
    return
  end
  self:update()
  self:changeUIPos()
  PaGlobal_Window_Stat_All:open()
end
function PaGlobal_Window_Stat_All:open()
  if nil == Panel_Window_Stat_All then
    return
  end
  Panel_Window_Stat_All:SetShow(true)
end
function PaGlobal_Window_Stat_All:prepareClose()
  if nil == Panel_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All:close()
end
function PaGlobal_Window_Stat_All:close()
  if nil == Panel_Window_Stat_All then
    return
  end
  Panel_Window_Stat_All:SetShow(false)
end
function PaGlobal_Window_Stat_All:update()
  if nil == Panel_Window_Stat_All then
    return
  end
  if false == PaGlobal_Window_Stat_All._initialize then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  local mainAttackType = 0
  local classType = 0
  if nil ~= selfPlayerWrapper then
    mainAttackType = selfPlayerWrapper:getMainAttckType()
    classtype = selfPlayerWrapper:getClassType()
  end
  if nil ~= PaGlobal_Equipment_All then
    local isSetAwakenWeapon = ToClient_getEquipmentItem(CppEnums.EquipSlotNo.awakenWeapon)
    if true == PaGlobal_Equipment_All._awakenWeaponContentsOpen and nil ~= isSetAwakenWeapon then
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_ADD]:SetShow(true)
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
      if __eClassType_ShyWaman == classtype then
        PaGlobal_Window_Stat_All._ui._txt_awakenOffence:SetShow(false)
        PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence:SetShow(true)
      else
        PaGlobal_Window_Stat_All._ui._txt_awakenOffence:SetShow(true)
        PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence:SetShow(false)
      end
      PaGlobal_Window_Stat_All._ui._txt_hit:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_hitRate:SetPosY(PaGlobal_Window_Stat_All._hitRatePosY)
    else
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_ADD]:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT]:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_characterStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_specialStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_equipStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_added[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_bonus[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_result[self._INDEX_HIT_RATE]:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
      PaGlobal_Window_Stat_All._ui._txt_awakenOffence:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence:SetShow(false)
      PaGlobal_Window_Stat_All._ui._txt_hit:SetPosY(PaGlobal_Window_Stat_All._aDDPosY)
      PaGlobal_Window_Stat_All._ui._txt_hitRate:SetPosY(PaGlobal_Window_Stat_All._hitPosY)
    end
  end
  local result = {}
  local tempValue = 0
  local reduceTxt = ""
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    result[ii] = 0
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    self._totalStatList[ii] = 0
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
      tempValue = ToClient_getCharacteOffenceBasic()
    elseif ii == self._INDEX_ADD then
      tempValue = ToClient_getCharacteOffenceBasic()
    elseif ii == self._INDEX_HIT then
      tempValue = ToClient_getCharacteHitBasic()
    elseif ii == self._INDEX_DDV then
      tempValue = ToClient_getCharacteDvBasic(0) + ToClient_getCharacteHDvBasic(0)
    elseif ii == self._INDEX_DPV then
      tempValue = ToClient_getCharactePvBasic(0) + ToClient_getCharacteHPvBasic(0)
    elseif ii == self._INDEX_RDV then
      tempValue = ToClient_getCharacteDvBasic(1) + ToClient_getCharacteHDvBasic(1)
    elseif ii == self._INDEX_RPV then
      tempValue = ToClient_getCharactePvBasic(1) + ToClient_getCharacteHPvBasic(1)
    elseif ii == self._INDEX_MDV then
      tempValue = ToClient_getCharacteDvBasic(2) + ToClient_getCharacteHDvBasic(2)
    elseif ii == self._INDEX_MPV then
      tempValue = ToClient_getCharactePvBasic(2) + ToClient_getCharacteHPvBasic(2)
    elseif ii == self._INDEX_REDUCE then
      tempValue = 0
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
    elseif ii == self._INDEX_DDV_RATE then
    elseif ii == self._INDEX_RDV_RATE then
    elseif ii == self._INDEX_MDV_RATE then
    end
    result[ii] = result[ii] + tempValue
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      PaGlobal_Window_Stat_All._ui._txt_characterStat[ii]:SetText("+0%")
    else
      PaGlobal_Window_Stat_All._ui._txt_characterStat[ii]:SetText(tostring(tempValue))
    end
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
      tempValue = ToClient_getOffenceBasic()
    elseif ii == self._INDEX_ADD then
      tempValue = ToClient_getAwakenOffenceBasic()
    elseif ii == self._INDEX_HIT then
      tempValue = ToClient_getHitBasic()
    elseif ii == self._INDEX_DDV then
      tempValue = ToClient_getDvBasic()
    elseif ii == self._INDEX_DPV then
      tempValue = ToClient_getPvBasic()
    elseif ii == self._INDEX_RDV then
      tempValue = ToClient_getDvBasic()
    elseif ii == self._INDEX_RPV then
      tempValue = ToClient_getPvBasic()
    elseif ii == self._INDEX_MDV then
      tempValue = ToClient_getDvBasic()
    elseif ii == self._INDEX_MPV then
      tempValue = ToClient_getPvBasic()
    elseif ii == self._INDEX_REDUCE then
      tempValue = 0
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
    elseif ii == self._INDEX_DDV_RATE then
    elseif ii == self._INDEX_RDV_RATE then
    elseif ii == self._INDEX_MDV_RATE then
    end
    result[ii] = result[ii] + tempValue
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      PaGlobal_Window_Stat_All._ui._txt_specialStat[ii]:SetText("+0%")
    else
      PaGlobal_Window_Stat_All._ui._txt_specialStat[ii]:SetText(tostring(tempValue))
    end
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
      tempValue = ToClient_getOffence() - ToClient_getOffenceBasic()
    elseif ii == self._INDEX_ADD then
      tempValue = ToClient_getAwakenOffence() - ToClient_getAwakenOffenceBasic()
    elseif ii == self._INDEX_HIT then
      tempValue = ToClient_getHit() - ToClient_getHitBasic()
    elseif ii == self._INDEX_DDV then
      tempValue = ToClient_getDv() - ToClient_getDvBasic()
    elseif ii == self._INDEX_DPV then
      tempValue = ToClient_getPv() - ToClient_getPvBasic()
    elseif ii == self._INDEX_RDV then
      tempValue = ToClient_getDv() - ToClient_getDvBasic()
    elseif ii == self._INDEX_RPV then
      tempValue = ToClient_getPv() - ToClient_getPvBasic()
    elseif ii == self._INDEX_MDV then
      tempValue = ToClient_getDv() - ToClient_getDvBasic()
    elseif ii == self._INDEX_MPV then
      tempValue = ToClient_getPv() - ToClient_getPvBasic()
    elseif ii == self._INDEX_REDUCE then
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
    elseif ii == self._INDEX_DDV_RATE then
    elseif ii == self._INDEX_RDV_RATE then
    elseif ii == self._INDEX_MDV_RATE then
    end
    result[ii] = result[ii] + tempValue
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      PaGlobal_Window_Stat_All._ui._txt_equipStat[ii]:SetText("+0%")
    else
      PaGlobal_Window_Stat_All._ui._txt_equipStat[ii]:SetText(tostring(tempValue))
    end
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
    elseif ii == self._INDEX_ADD then
    elseif ii == self._INDEX_HIT then
    elseif ii == self._INDEX_DDV then
      tempValue = self:getHDVEquipBonus()
    elseif ii == self._INDEX_DPV then
      tempValue = self:getHPVEquipBonus()
    elseif ii == self._INDEX_RDV then
      tempValue = self:getHDVEquipBonus()
    elseif ii == self._INDEX_RPV then
      tempValue = self:getHPVEquipBonus()
    elseif ii == self._INDEX_MDV then
      tempValue = self:getHDVEquipBonus()
    elseif ii == self._INDEX_MPV then
      tempValue = self:getHPVEquipBonus()
    elseif ii == self._INDEX_REDUCE then
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
    elseif ii == self._INDEX_DDV_RATE then
    elseif ii == self._INDEX_RDV_RATE then
    elseif ii == self._INDEX_MDV_RATE then
    end
    result[ii] = result[ii] + tempValue
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[ii]:SetText("+0%")
    else
      PaGlobal_Window_Stat_All._ui._txt_hiddenStat[ii]:SetText(tostring(tempValue))
    end
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
      tempValue = ToClient_GetDDBonus(ToClient_getOffence())
    elseif ii == self._INDEX_ADD then
      tempValue = ToClient_GetDDBonus(ToClient_getAwakenOffence())
    elseif ii == self._INDEX_HIT then
    elseif ii == self._INDEX_DDV then
    elseif ii == self._INDEX_DPV then
    elseif ii == self._INDEX_RDV then
    elseif ii == self._INDEX_RPV then
    elseif ii == self._INDEX_MDV then
    elseif ii == self._INDEX_MPV then
    elseif ii == self._INDEX_REDUCE then
      tempValue = ToClient_GetAddedDefenceRateFromDefencePoint(ToClient_getDefence())
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
    elseif ii == self._INDEX_DDV_RATE then
    elseif ii == self._INDEX_RDV_RATE then
    elseif ii == self._INDEX_MDV_RATE then
    end
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      reduceTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADDED_DEFENCERATE_VALUE", "value", self:getRateText(tempValue))
      PaGlobal_Window_Stat_All._ui._txt_added[ii]:SetText(reduceTxt)
      result[ii] = result[ii] + tempValue
    else
      PaGlobal_Window_Stat_All._ui._txt_added[ii]:SetText(tostring(tempValue))
      result[ii] = result[ii] + tempValue
    end
  end
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_DD then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DD, 0) - ToClient_getAddedDDEquipStat()
    elseif ii == self._INDEX_ADD then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DD, 0) - ToClient_getAddedDDEquipStat()
    elseif ii == self._INDEX_HIT then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_Hit, 0) - ToClient_getCharacteHitBasic() - ToClient_getHit() + ToClient_getHitBasic()
    elseif ii == self._INDEX_DDV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DV, self._ATTACK_TYPE._DISTANCE) - ToClient_getCharacteDvBasic(self._ATTACK_TYPE._DISTANCE) - ToClient_getCharacteHDvBasic(self._ATTACK_TYPE._DISTANCE) - ToClient_getDv() + ToClient_getDvBasic()
    elseif ii == self._INDEX_DPV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_PV, self._ATTACK_TYPE._DISTANCE) - ToClient_getCharactePvBasic(self._ATTACK_TYPE._DISTANCE) - ToClient_getCharacteHPvBasic(self._ATTACK_TYPE._DISTANCE) - ToClient_getPv() + self:getExtraPv(self._ATTACK_TYPE._DISTANCE) + ToClient_getPvBasic()
    elseif ii == self._INDEX_RDV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DV, self._ATTACK_TYPE._RANGE) - ToClient_getCharacteDvBasic(self._ATTACK_TYPE._RANGE) - ToClient_getCharacteHDvBasic(self._ATTACK_TYPE._RANGE) - ToClient_getDv() + ToClient_getDvBasic()
    elseif ii == self._INDEX_RPV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_PV, self._ATTACK_TYPE._RANGE) - ToClient_getCharactePvBasic(self._ATTACK_TYPE._RANGE) - ToClient_getCharacteHPvBasic(self._ATTACK_TYPE._RANGE) - ToClient_getPv() + self:getExtraPv(self._ATTACK_TYPE._RANGE) + ToClient_getPvBasic()
    elseif ii == self._INDEX_MDV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DV, self._ATTACK_TYPE._MAGIC) - ToClient_getCharacteDvBasic(self._ATTACK_TYPE._MAGIC) - ToClient_getCharacteHDvBasic(self._ATTACK_TYPE._MAGIC) - ToClient_getDv() + ToClient_getDvBasic()
    elseif ii == self._INDEX_MPV then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_PV, self._ATTACK_TYPE._MAGIC) - ToClient_getCharactePvBasic(self._ATTACK_TYPE._MAGIC) - ToClient_getCharacteHPvBasic(self._ATTACK_TYPE._MAGIC) - ToClient_getPv() + self:getExtraPv(self._ATTACK_TYPE._MAGIC) + ToClient_getPvBasic()
    elseif ii == self._INDEX_REDUCE then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_ResistanceBuff, 0)
    elseif ii == self._INDEX_SHYSTAT1 then
    elseif ii == self._INDEX_SHYSTAT2 then
    elseif ii == self._INDEX_SHYSTAT3 then
    elseif ii == self._INDEX_HIT_RATE then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_HitRate, 0)
    elseif ii == self._INDEX_DDV_RATE then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DVRate, self._ATTACK_TYPE._DISTANCE)
    elseif ii == self._INDEX_RDV_RATE then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DVRate, self._ATTACK_TYPE._RANGE)
    elseif ii == self._INDEX_MDV_RATE then
      tempValue = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DVRate, self._ATTACK_TYPE._MAGIC)
    end
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      if tempValue < 0 then
        PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:SetText(self:getRateText(tempValue) .. "%")
      else
        PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:SetText("+" .. self:getRateText(tempValue) .. "%")
      end
    else
      PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:SetText(tostring(tempValue))
    end
    result[ii] = result[ii] + tempValue
    if tempValue >= 0 then
      PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:SetFontColor(Defines.Color.C_FF57F426)
    else
      PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:SetFontColor(Defines.Color.C_FFD05D48)
    end
  end
  local posY = 0
  local sizeY = 0
  local variedDDToMonster = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DDToMonster, 0)
  local paddingSize = 0
  PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster:SetText(tostring(variedDDToMonster))
  local variedPVToMonster = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_PVFromMonster, 0)
  PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster:SetText(tostring(variedPVToMonster))
  local variedResistanceToMonster = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_DamageResistanceFromMonster, 0)
  PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster:SetText(tostring(math.floor(variedResistanceToMonster / 10000)) .. "%")
  local tribe0 = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_Tribe, 0)
  PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman:SetText(tostring(tribe0))
  local tribe1 = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_Tribe, 1)
  PaGlobal_Window_Stat_All._ui._txt_addedDDToAin:SetText(tostring(tribe1))
  local tribe3 = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_Tribe, 3)
  PaGlobal_Window_Stat_All._ui._txt_addedDDToKama:SetText(tostring(tribe3))
  PaGlobal_Window_Stat_All._ui._txt_StunRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getStunResistance() / 10000) .. "%")
  PaGlobal_Window_Stat_All._ui._txt_GrabRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getCatchResistance() / 10000) .. "%")
  PaGlobal_Window_Stat_All._ui._txt_DownRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getKnockdownResistance() / 10000) .. "%")
  PaGlobal_Window_Stat_All._ui._txt_AirRegist:SetText(math.floor(PaGlobal_CharInfoBasic_All._selfPlayer:getKnockbackResistance() / 10000) .. "%")
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    tempValue = 0
    if ii == self._INDEX_REDUCE or ii == self._INDEX_HIT_RATE or ii == self._INDEX_DDV_RATE or ii == self._INDEX_RDV_RATE or ii == self._INDEX_MDV_RATE then
      if result[ii] < 0 then
        reduceTxt = self:getRateText(result[ii]) .. "%"
      else
        reduceTxt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ADDED_DEFENCERATE_VALUE", "value", self:getRateText(result[ii]))
      end
      PaGlobal_Window_Stat_All._ui._txt_result[ii]:SetText(reduceTxt)
    else
      PaGlobal_Window_Stat_All._ui._txt_result[ii]:SetText(tostring(result[ii]))
    end
    self._totalStatList[ii] = result[ii]
  end
end
function PaGlobal_Window_Stat_All:getRateText(value)
  local tempValue = math.floor(value / 100)
  local floorValue = math.floor(tempValue / 100)
  local notFloorValue = tempValue / 100
  if floorValue == notFloorValue then
    return tostring(floorValue)
  else
    return string.format("%.2f", notFloorValue)
  end
  return tostring(floorValue)
end
function PaGlobal_Window_Stat_All:getExtraPv(attackType)
  local pv = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_PV, attackType) + self:getHPVEquipBonus() + ToClient_getPvBasic()
  local extraPv = ToClient_getBonusBuffStat(__eSendToClientBuffStatType_ExtraPvPercent, attackType)
  extraPv = extraPv / self._PERCENT_TO_RATIO
  pv = math.floor(pv * extraPv)
  return pv
end
function PaGlobal_Window_Stat_All:getTotalStat(index)
  if nil == Panel_Window_Stat_All then
    return 0
  end
  return self._totalStatList[index]
end
function PaGlobal_Window_Stat_All:changeUIPos()
  if nil == Panel_Window_Stat_All then
    return
  end
  local posX = getScreenSizeX() / 2 - Panel_Window_Stat_All:GetSizeX() / 2
  local posY = getScreenSizeY() / 2 - Panel_Window_Stat_All:GetSizeY() / 2
  Panel_Window_Stat_All:SetPosXY(posX, posY)
end
function PaGlobal_Window_Stat_All:getHDVEquipBonus()
  local totalHdv = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    local canEquip = Toclient_checkEquipItem(equipNo)
    if nil ~= itemWrapper and true == canEquip then
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      local dv, hdv = 0, 0
      if 1 == item_type then
        for idx = 0, 2 do
          local currnetDv = itemSSW:ToClient_getDV(idx)
          if dv < currnetDv then
            dv = currnetDv
          end
          local currentHDV = itemSSW:ToClient_getHDV(idx)
          if hdv < currentHDV then
            hdv = currentHDV
          end
        end
      end
      local cronKey = itemSSW:getCronKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local gradeCount = ToClient_GetCronEnchnatInfoCount(cronKey, enchantLevel)
      local lastCount = 0
      local currentGrade = 0
      local lastIndex = gradeCount - 1
      local currentEnchantFailCount = itemWrapper:getCronEnchantFailCount()
      if currentEnchantFailCount > 0 and gradeCount > 0 then
        local itemaddedDV = itemWrapper:getAddedDV()
        local itemaddedHDV = itemWrapper:getCronHDV()
        dv = dv + itemaddedDV
        hdv = hdv + itemaddedHDV
      end
      totalHdv = totalHdv + hdv
    end
  end
  return tostring(totalHdv)
end
function PaGlobal_Window_Stat_All:getHPVEquipBonus()
  local totalHpv = 0
  local EquipNoMin = CppEnums.EquipSlotNo.rightHand
  local EquipNoMax = CppEnums.EquipSlotNo.equipSlotNoCount
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    local canEquip = Toclient_checkEquipItem(equipNo)
    if nil ~= itemWrapper and true == canEquip then
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      local pv, hpv = 0, 0
      if 1 == item_type then
        for idx = 0, 2 do
          local currnetPv = itemSSW:ToClient_getPV(idx)
          if pv < currnetPv then
            pv = currnetPv
          end
          local currentHPV = itemSSW:ToClient_getHPV(idx)
          if hpv < currentHPV then
            hpv = currentHPV
          end
        end
      end
      local cronKey = itemSSW:getCronKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local gradeCount = ToClient_GetCronEnchnatInfoCount(cronKey, enchantLevel)
      local lastCount = 0
      local currentGrade = 0
      local lastIndex = gradeCount - 1
      local currentEnchantFailCount = itemWrapper:getCronEnchantFailCount()
      if currentEnchantFailCount > 0 and gradeCount > 0 then
        local itemaddedPV = itemWrapper:getAddedPV()
        local itemaddedHPV = itemWrapper:getCronHPV()
        pv = pv + itemaddedPV
        hpv = hpv + itemaddedHPV
      end
      totalHpv = totalHpv + hpv
    end
  end
  return tostring(totalHpv)
end
function PaGlobal_Window_Stat_All:validate()
  if nil == Panel_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All._ui._btn_Close:isValidate()
  PaGlobal_Window_Stat_All._ui._stc_bounusStatBG:isValidate()
  PaGlobal_Window_Stat_All._ui._stc_line:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addDamageTemplate:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_desc:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_awakenOffence:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_shyAwakenOffence:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_hit:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_hitRate:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_consoleKeyGuide:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addedDDToMonster:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addedDDToKama:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addedDDToAin:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addedDDToHuman:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_addedPVFromMonster:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_resistanceFromMonster:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_StunRegist:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_GrabRegist:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_DownRegist:isValidate()
  PaGlobal_Window_Stat_All._ui._txt_AirRegist:isValidate()
  for ii = 1, PaGlobal_Window_Stat_All._INDEX_COUNT - 1 do
    PaGlobal_Window_Stat_All._ui._txt_characterStat[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_specialStat[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_equipStat[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_hiddenStat[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_added[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_bonus[ii]:isValidate()
    PaGlobal_Window_Stat_All._ui._txt_result[ii]:isValidate()
  end
end
