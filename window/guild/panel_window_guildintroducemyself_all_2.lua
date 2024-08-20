function PaGlobal_GuildIntroduceMySelf_Open(category, index, isSearchList)
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  PaGlobal_GuildIntroduceMySelf_All:prepareOpen(category, index, isSearchList)
end
function PaGlobal_GuildIntroduceMySelf_ApplicantOpen(index)
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  PaGlobal_GuildIntroduceMySelf_All:prepareOpen(nil, index)
end
function PaGlobal_GuildIntroduceMySelf_Close()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  PaGlobal_GuildIntroduceMySelf_All:prepareClose()
end
function HandleEventLUp_PaGlobal_GuildIntroduceMySelf_Apply()
  if nil == PaGlobal_GuildIntroduceMySelf_All._category then
    return
  end
  if nil == PaGlobal_GuildIntroduceMySelf_All._index then
    return
  end
  ToClient_requestUpdateGuildApplicant(__eGuildApplicantType_Insert, PaGlobal_GuildIntroduceMySelf_All._category, PaGlobal_GuildIntroduceMySelf_All._index, PaGlobal_GuildIntroduceMySelf_All._ui.txt_edit:GetEditText(), PaGlobal_GuildIntroduceMySelf_All._isSearchList)
  PaGlobal_GuildIntroduceMySelf_Close()
end
function PaGlobalFunc_GuildIntroduceMySelf_EditName()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  PaGlobal_GuildIntroduceMySelf_All._ui.txt_desc:SetText("")
  PaGlobal_GuildIntroduceMySelf_All._ui.txt_edit:SetEditText("")
  SetFocusEdit(PaGlobal_GuildIntroduceMySelf_All._ui.txt_edit)
end
function PaGlobalFunc_GuildIntroduceMySelf_DeleteApplicant()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  PaGlobal_GuildJoinRequestList_All:requestDeleteApplicant(PaGlobal_GuildIntroduceMySelf_All._index)
  PaGlobal_GuildIntroduceMySelf_Close()
end
function PaGlobalFunc_GuildIntroduceMySelf_InviteGuild()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  ToClient_inviteGuildApplicantWrapper(PaGlobal_GuildIntroduceMySelf_All._index)
  PaGlobal_GuildIntroduceMySelf_Close()
end
function PaGlobal_GuildIntroduceMySelf_All_ShowAni()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
end
function PaGlobal_GuildIntroduceMySelf_All_HideAni()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
end
