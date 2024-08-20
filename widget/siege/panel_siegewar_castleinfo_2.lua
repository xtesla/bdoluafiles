function FromClient_SiegeWarCastleInfoOpen()
  if nil == Panel_SiegeWar_CastleInfo or nil == PaGlobal_SiegeWar_CastleInfo then
    return
  end
  PaGlobal_SiegeWar_CastleInfo:prepareOpen()
end
function FromClient_SiegeWarCastleInfoClose()
  if nil == Panel_SiegeWar_CastleInfo or nil == PaGlobal_SiegeWar_CastleInfo then
    return
  end
  PaGlobal_SiegeWar_CastleInfo:prepareClose()
end
function FromClient_SiegeWarCastleInfoAttackSiegeTent(householdNo, hpRate)
  if nil == Panel_SiegeWar_CastleInfo or nil == PaGlobal_SiegeWar_CastleInfo then
    return
  end
  PaGlobal_SiegeWar_CastleInfo:attackSiegeTent(householdNo, hpRate)
end
function FromClient_SiegeWarCastleInfoSetHpSiegeTent(householdNo, hpRate)
  if nil == Panel_SiegeWar_CastleInfo or nil == PaGlobal_SiegeWar_CastleInfo then
    return
  end
  PaGlobal_SiegeWar_CastleInfo:setHpSiegeTent(householdNo, hpRate)
end
function FromClient_SiegeWar_CastleInfo_ResponseParticipateSiege(isParticipant, isSelf)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if false == isSelf then
    return
  end
  PaGlobal_SiegeWar_CastleInfo:changeParticipant(isParticipant)
end
