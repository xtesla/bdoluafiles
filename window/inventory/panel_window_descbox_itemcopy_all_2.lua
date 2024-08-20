function PaGlobal_DescBox_ItemCopy_Open()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  PaGlobal_DescBox_ItemCopy:prepareOpen()
end
function PaGlobal_DescBox_ItemCopy_Close()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  PaGlobal_DescBox_ItemCopy:prepareClose()
  PaGlobal_Equip_CharacterTag_ItemCopy_ChangeDescIcon(false)
end
function PaGlobal_DescBox_ItemCopy_Close_AnotherPanel()
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  PaGlobal_DescBox_ItemCopy:prepareClose()
end
function PaGlobal_DescBox_ItemCopy_SetDescText(descText)
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  if nil == descText then
    return
  end
  PaGlobal_DescBox_ItemCopy._ui._txt_Desc:SetText(descText)
  local gapY = 20
  local textSizeY = PaGlobal_DescBox_ItemCopy._ui._txt_Desc:GetTextSizeY() + gapY
  PaGlobal_DescBox_ItemCopy._ui._frame_content1:SetSize(PaGlobal_DescBox_ItemCopy._ui._frame_content1:GetSizeX(), textSizeY)
  PaGlobal_DescBox_ItemCopy._ui._txt_Desc:SetSize(PaGlobal_DescBox_ItemCopy._ui._txt_Desc:GetSizeX(), textSizeY)
  PaGlobal_DescBox_ItemCopy._ui._frame_scroll:SetControlTop()
  PaGlobal_DescBox_ItemCopy._ui._frame1:UpdateContentScroll()
  PaGlobal_DescBox_ItemCopy._ui._frame1:UpdateContentPos()
end
function PaGlobal_DescBox_ItemCopy_SetPanelPosition(basePanelPosX, basePanelPosY)
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  if nil == basePanelPosX or nil == basePanelPosY then
    return
  end
  local descPanelSizeX = Panel_Window_DescBox_ItemCopy:GetSizeX()
  local gapX = 10
  Panel_Window_DescBox_ItemCopy:SetPosX(basePanelPosX - descPanelSizeX - gapX)
  Panel_Window_DescBox_ItemCopy:SetPosY(basePanelPosY)
end
function HandleRSticEvent_DescBox_ItemCopy_MoveScroll(isUp)
  if nil == Panel_Window_DescBox_ItemCopy then
    return
  end
  if nil == PaGlobal_DescBox_ItemCopy._ui._frame1 then
    return
  end
  if false == PaGlobal_DescBox_ItemCopy._ui._frame1:GetShow() then
    return
  end
  if true == isUp then
    PaGlobal_DescBox_ItemCopy._ui._frame_scroll:ControlButtonUp()
  elseif false == isUp then
    PaGlobal_DescBox_ItemCopy._ui._frame_scroll:ControlButtonDown()
  end
  PaGlobal_DescBox_ItemCopy._ui._frame1:UpdateContentScroll()
  PaGlobal_DescBox_ItemCopy._ui._frame1:UpdateContentPos()
end
