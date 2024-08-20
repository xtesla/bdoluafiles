function PaGlobal_GuildPoint_SkillLog_Close()
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  PaGlobal_GuildPoint_SkillLog:prepareClose()
end
function PaGlobal_GuildPoint_SkillLog_Open(territoryKey)
  if nil == Panel_GuildPoint_SkillLog then
    return
  end
  if true == Panel_GuildPoint_SkillLog:GetShow() then
    PaGlobal_GuildPoint_SkillLog:prepareClose()
  else
    PaGlobal_GuildPoint_SkillLog:prepareOpen(territoryKey)
  end
end
function FromClient_ChangeActivePolicyTimeLog(count, skillNo, time)
  PaGlobal_GuildPoint_SkillLog:createFrameContent(skillNo, count, time)
end
