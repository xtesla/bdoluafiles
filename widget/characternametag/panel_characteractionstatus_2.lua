function FromClient_NotifyPlayerGuardType(actorKey, guardType)
  PaGlobal_CharacterActionStatus:update(actorKey, guardType)
end
function FromClient_NotifyPlayerAvoid(actorKey, guardType)
  PaGlobal_CharacterActionStatus:updateAvoid(actorKey, guardType)
end
