PaGlobal_AwakenSkill = {
  awakenWeapon = {
    [__eClassType_Warrior] = ToClient_IsContentsGroupOpen("901"),
    [__eClassType_ElfRanger] = ToClient_IsContentsGroupOpen("902"),
    [__eClassType_Sorcerer] = ToClient_IsContentsGroupOpen("903"),
    [__eClassType_Giant] = ToClient_IsContentsGroupOpen("904"),
    [__eClassType_Tamer] = ToClient_IsContentsGroupOpen("905"),
    [__eClassType_BladeMaster] = ToClient_IsContentsGroupOpen("906"),
    [__eClassType_BladeMasterWoman] = ToClient_IsContentsGroupOpen("907"),
    [__eClassType_Valkyrie] = ToClient_IsContentsGroupOpen("908"),
    [__eClassType_WizardMan] = ToClient_IsContentsGroupOpen("909"),
    [__eClassType_WizardWoman] = ToClient_IsContentsGroupOpen("910"),
    [__eClassType_NinjaMan] = ToClient_IsContentsGroupOpen("911"),
    [__eClassType_Kunoichi] = ToClient_IsContentsGroupOpen("912"),
    [__eClassType_DarkElf] = ToClient_IsContentsGroupOpen("913"),
    [__eClassType_Combattant] = ToClient_IsContentsGroupOpen("914"),
    [__eClassType_Mystic] = ToClient_IsContentsGroupOpen("918"),
    [__eClassType_Lhan] = ToClient_IsContentsGroupOpen("916"),
    [__eClassType_RangerMan] = ToClient_IsContentsGroupOpen("942"),
    [__eClassType_ShyWaman] = ToClient_IsContentsGroupOpen("1366"),
    [__eClassType_Guardian] = ToClient_IsContentsGroupOpen("1317"),
    [__eClassType_Hashashin] = ToClient_IsContentsGroupOpen("1136"),
    [__eClassType_Nova] = ToClient_IsContentsGroupOpen("1466"),
    [__eClassType_ReservedBlackSpirit] = ToClient_IsContentsGroupOpen("1579"),
    [__eClassType_Sorcerer_Reserved1] = ToClient_IsContentsGroupOpen("1590")
  },
  isAwakenWeaponContentsOpen = false
}
function PaGlobal_AwakenSkill:initalize()
  self.isAwakenWeaponContentsOpen = self.awakenWeapon[getSelfPlayer():getClassType()]
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_AWAKEN_WEAPONS"))
    if self.isAwakenWeaponContentsOpen then
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetShow(true)
    else
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetShow(false)
    end
  else
  end
end
