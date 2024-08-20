function HandleEventLUp_Widget_ThornCastle_Enter_Join_Othilita()
  if nil == PaGlobal_ThornCastle_Member then
    return
  end
  PaGlobal_ThornCastle_Enter:prepareCloseJoinMessageBox()
  PaGlobal_ThornCastle_Enter:requestJoinRandomMatching()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Cancel()
  PaGlobal_ThornCastle_Enter:prepareCloseJoinMessageBox()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Matching_Cancel()
  PaGlobal_ThornCastle_Enter:prepareCloseMatchingBox()
end
function HandleEventLUp_Widget_ThornCastle_Enter_Open()
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_OthilitaDungeon) then
    PaGlobal_ThornCastle_Enter:prepareOpenJoinMessageBox()
  else
    PaGlobal_ThornCastle_Enter:prepareOpenDisJoinMessageBox()
  end
end
