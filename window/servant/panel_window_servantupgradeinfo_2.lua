function PaGlobal_ServantUpgradeInfo_Close()
  if true == PaGlobal_ServantUpgradeInfo._isConsole then
    return
  end
  PaGlobal_ServantUpgradeInfo:close()
end
