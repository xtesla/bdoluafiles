function PaGlobal_BarterInfoSearch_Special_Close()
  PaGlobal_BarterInfoSearch_Special:close()
end
function PaGlobal_BarterInfoSearch_Special_isShow()
  if nil == Panel_Window_Barter_Search_Special then
    return
  end
  return Panel_Window_Barter_Search_Special:GetShow()
end
