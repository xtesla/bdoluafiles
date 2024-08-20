function PaGlobalFunc_MansionRank_All_Open()
  PaGlobal_MansionRank_All:prepareOpen()
end
function PaGlobalFunc_MansionRank_All_Close()
  PaGlobal_MansionRank_All:prepareClose()
end
function PaGlobalFunc_MansionRank_All_CreateList(control, listIdx64)
  if nil == Panel_Window_MansionRank_All then
    return
  end
  local listIdx = Int64toInt32(listIdx64)
  local rankInfo = ToClient_GetMansionRankerAt(listIdx)
  if nil == rankInfo then
    control:SetShow(false)
    return
  end
  local rankName = rankInfo:getUserName()
  local rankCharName = rankInfo:getCharacterName()
  local rankGuild = rankInfo:getGuildName()
  local rankPoint = rankInfo:getTotalPoint()
  local txt_rank = UI.getChildControl(control, "StaticText_List2_Rank")
  local txt_name = UI.getChildControl(control, "StaticText_List2_Name")
  local txt_guild = UI.getChildControl(control, "StaticText_List2_Guild")
  local txt_point = UI.getChildControl(control, "StaticText_List2_Point")
  local btn_visit = UI.getChildControl(control, "Button_Visit")
  local rankNum = listIdx + 1
  if nil == rankCharName or 0 == string.len(rankCharName) then
    rankCharName = "-"
  end
  txt_rank:SetText(rankNum)
  txt_name:SetText(rankName .. "(" .. rankCharName .. ")")
  txt_guild:SetText(rankGuild)
  txt_point:SetText(rankPoint)
  btn_visit:SetShow(false)
  txt_point:SetShow(false)
end
function HandleEventLUp_MansionRank_All_Close()
  PaGlobalFunc_MansionRank_All_Close()
end
function HandleEventLUp_MansionRank_All_SetTabMenu(selectIdx)
  if nil == Panel_Window_MansionRank_All then
    return
  end
  if selectIdx < 0 or selectIdx >= PaGlobal_MansionRank_All._rankType.COUNT then
    return
  end
  PaGlobal_MansionRank_All._currentTab = selectIdx
  PaGlobal_MansionRank_All:currentTabUpdate()
  ToClient_RequestMansionRanker(PaGlobal_MansionRank_All._mansionKey, PaGlobal_MansionRank_All._currentTab)
end
function HandlePadEventLTRT_SeasonUiSelect_All_MoveTabMenu(value)
  local selectTab = PaGlobal_MansionRank_All._currentTab + value
  if selectTab < PaGlobal_MansionRank_All._rankType.SERVER then
    selectTab = PaGlobal_MansionRank_All._rankType.WORLD
  elseif selectTab > PaGlobal_MansionRank_All._rankType.WORLD then
    selectTab = PaGlobal_MansionRank_All._rankType.SERVER
  end
  PaGlobal_MansionRank_All._currentTab = selectTab
  PaGlobal_MansionRank_All:currentTabUpdate()
  ToClient_RequestMansionRanker(PaGlobal_MansionRank_All._mansionKey, PaGlobal_MansionRank_All._currentTab)
end
function FromCleint_MansionRank_All_onScreenResize()
  PaGlobal_MansionRank_All:resize()
end
function FromClient_MansionRank_All_UpdateMansionRanking()
  PaGlobal_MansionRank_All:listUpdate()
end
