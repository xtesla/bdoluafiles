function PaGlobalFunc_RandomQuestInfo_All_Open()
  PaGlobal_RandomQuestInfo_All:prepareOpen()
end
function PaGlobalFunc_RandomQuestInfo_All_Close()
  PaGlobal_RandomQuestInfo_All:prepareClose()
end
function PaGlobalFunc_RandomQuestInfo_All_GetShow()
  if nil == Panel_Widget_RandomQuestInfo_All then
    return false
  end
  return Panel_Widget_RandomQuestInfo_All:GetShow()
end
function FromClient_RandomQuestInfo_All_RandomQuestOver(isShow, groupId, questId, monsterBtn)
  if false == isShow then
    PaGlobal_RandomQuestInfo_All:prepareClose()
    return
  end
  if false == _ContentsGroup_FeverQuest or false == _ContentsGroup_WorldmapFeverQuest then
    return
  end
  if nil == monsterBtn or false == monsterBtn:GetShow() then
    return
  end
  local posX = monsterBtn:GetPosX()
  local posY = monsterBtn:GetPosY()
  local sizeX = monsterBtn:GetSizeX()
  local sizeY = monsterBtn:GetSizeY()
  PaGlobal_RandomQuestInfo_All:setPanelPos(posX, posY, sizeX, sizeY)
  PaGlobal_RandomQuestInfo_All:prepareOpen(groupId, questId)
end
