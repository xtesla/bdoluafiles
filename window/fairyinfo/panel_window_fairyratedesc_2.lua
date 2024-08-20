function HandleRSticEvent_FairyRateDesc_MoveScroll(flag)
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  if nil == PaGlobal_Window_FairyRateDesc._ui._frame_1 then
    return
  end
  if false == PaGlobal_Window_FairyRateDesc._ui._frame_1:GetShow() then
    return
  end
  if 1 == flag then
    PaGlobal_Window_FairyRateDesc._ui._frame_scroll:ControlButtonUp()
  elseif -1 == flag then
    PaGlobal_Window_FairyRateDesc._ui._frame_scroll:ControlButtonDown()
  end
  PaGlobal_Window_FairyRateDesc._ui._frame_1:UpdateContentScroll()
  PaGlobal_Window_FairyRateDesc._ui._frame_1:UpdateContentPos()
end
function PaGlobal_Window_FairyRateDesc_Open()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  if false == _ContentsGroup_FairySkillChangeRateView then
    return
  end
  PaGlobal_Window_FairyRateDesc:prepareOpen()
end
function PaGlobal_Window_FairyRateDesc_Close()
  if nil == Panel_Window_FairyRateDesc then
    return
  end
  if false == _ContentsGroup_FairySkillChangeRateView then
    return
  end
  PaGlobal_Window_FairyRateDesc:prepareClose()
end
