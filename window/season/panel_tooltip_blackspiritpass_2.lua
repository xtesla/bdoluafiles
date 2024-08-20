function TooltipBlackSpiritPass_Show(title, desc, showExpIcon)
  PaGlobal_BlackspiritPassTooltip:prepareOpen(title, desc, showExpIcon)
end
function TooltipBlackSpiritPass_Hide()
  PaGlobal_BlackspiritPassTooltip:prepareClose()
end
function TooltipBlackSpiritPass_IsShow()
  if nil == Panel_Window_BlackspiritPassTooltip then
    return false
  end
  return Panel_Window_BlackspiritPassTooltip:GetShow()
end
