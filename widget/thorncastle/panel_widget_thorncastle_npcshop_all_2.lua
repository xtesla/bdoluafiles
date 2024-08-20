function PaGlobal_ThornCastle_NpcShop_All_Close()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:prepareClose()
end
function PaGlobal_ThornCastle_NpcShop_All_Open()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:prepareOpen()
end
function PaGlobal_ThornCastle_NpcShop_All_CreateListControl(control, key)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:createItemList(control, key)
end
function HandleEventLUp_ThornCastle_NpcShop_SelectItem(index)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:selectItem(index)
end
function HandleEventLUp_ThornCastle_NpcShop_BuyButton()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:buy()
end
function HandleEventLUp_ThornCastle_NpcShop_BuyValueButton()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:buyValueButton()
end
function HandleEventRUp_ThornCastle_NpcShop_BuyItem(index)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:buyNow(index)
end
function PaGlobal_ThornCastle_NpcShop_All_BuyValue(count)
  if nil == Panel_ThornCastle_Shop then
    return
  end
  PaGlobal_ThornCastle_NpcShop_All:buyValue(count)
end
function FromClient_PaGlobal_ThornCastle_NpcShop_All_updateAppleList(param1)
  if nil == Panel_ThornCastle_Shop then
    return
  end
end
function PaGloabl_ThornCastle_NpcShop_All_ShowAni()
  if nil == Panel_ThornCastle_Shop then
    return
  end
end
function PaGloabl_ThornCastle_NpcShop_All_HideAni()
  if nil == Panel_ThornCastle_Shop then
    return
  end
end
function PaGlobal_ThornCastle_NpcShop_All_ChangePoint()
  if nil == Panel_ThornCastle_Shop then
    return
  end
  local point = ToClient_OthilitaDungeonMyPoint()
  PaGlobal_ThornCastle_NpcShop_All._ui.txt_point:SetText(tostring(point))
end
