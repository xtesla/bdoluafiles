local initialize = false
function PaGlobal_Kr_Transfer_Init()
  if true == initialize then
    return
  end
  local close = true
  if true == close then
    return
  end
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eJPTransfer)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if _year == savedYear and _month == savedMonth and _day == savedDay and nil == isLevelUp then
      return
    end
  end
  local _stc_Black = UI.getChildControl(Panel_Kr_Transfer, "Static_Black")
  local _stc_Banner = UI.getChildControl(Panel_Kr_Transfer, "Static_Banner")
  local _btn_TodayClose = UI.getChildControl(_stc_Banner, "Button_1")
  local _btn_Join = UI.getChildControl(_stc_Banner, "Button_2")
  Panel_Kr_Transfer:SetShow(true)
  _stc_Black:SetShow(true)
  _stc_Banner:SetShow(true)
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  local buttonPercent = sizeY / Panel_Kr_Transfer:GetSizeY()
  if tonumber(1.7777777777777777) <= tonumber(sizeX / sizeY) then
    local changeSizeX = 16 * sizeY / 9
    _stc_Banner:SetSize(changeSizeX * 0.8, sizeY * 0.8)
  else
    local changeSizeY = 9 * sizeX / 16
    _stc_Banner:SetSize(sizeX * 0.8, changeSizeY * 0.8)
    buttonPercent = sizeX / Panel_Kr_Transfer:GetSizeX()
  end
  _btn_TodayClose:SetEnableArea(-(_btn_TodayClose:GetSizeX() + _btn_TodayClose:GetTextSizeX() + 20), -20, _btn_TodayClose:GetSizeX(), 70)
  _btn_Join:SetSize(_btn_Join:GetSizeX() * buttonPercent, _btn_Join:GetSizeY() * buttonPercent)
  _btn_Join:SetSpanSize(_btn_Join:GetSpanSize().x * buttonPercent, _btn_Join:GetSpanSize().y * buttonPercent)
  _stc_Black:SetSize(sizeX, sizeY)
  Panel_Kr_Transfer:ComputePos()
  _stc_Banner:ComputePos()
  _stc_Black:ComputePos()
  _btn_TodayClose:ComputePos()
  _btn_Join:ComputePos()
  _stc_Black:addInputEvent("Mouse_LUp", "PaGlobal_Kr_Transfer_Close()")
  _btn_Join:addInputEvent("Mouse_LUp", "PaGlobal_NA_Common_TransferLink()")
  _btn_TodayClose:addInputEvent("Mouse_LUp", "PaGlobal_Kr_Transfer_TodayClose()")
  initialize = true
end
function PaGlobal_Kr_Transfer_TodayClose()
  local _year = ToClient_GetThisYear()
  local _month = ToClient_GetThisMonth()
  local _day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eJPTransfer, _year, _month, _day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  Panel_Kr_Transfer:SetShow(false)
end
function PaGlobal_Kr_Transfer_Close()
  Panel_Kr_Transfer:SetShow(false)
end
function PaGlobal_JP_Common_TransferLink()
  local url = "https://www.jp.playblackdesert.com/Event/NewAdventureTransfer#transfer"
  ToClient_OpenChargeWebPage(url, false)
end
function PaGlobal_NA_Common_TransferLink()
  local url = "https://www.naeu.playblackdesert.com/"
  local languageType = ToClient_getResourceType()
  if nil == languageType then
    return
  end
  local languageTypeString = Defines.LanguageTypeToString[languageType]
  if nil == languageTypeString then
    return
  end
  if "DV" == languageTypeString then
    languageTypeString = "KR"
  end
  if CppEnums.ServiceResourceType.eServiceResourceType_ID == languageType then
    languageTypeString = "EN"
  end
  local nationType = ""
  if "KR" == languageTypeString then
  elseif "EN" == languageTypeString then
    nationType = "en-US"
  elseif "DE" == languageTypeString then
    nationType = "de-DE"
  elseif "FR" == languageTypeString then
    nationType = "fr-FR"
  else
    if "ES" == languageTypeString or "SP" == languageTypeString then
      nationType = "es-ES"
    else
    end
  end
  if "" ~= nationType then
    url = url .. nationType
    url = url .. "/News/Detail?groupContentNo=927" .. "&countryType=" .. nationType
  else
    url = url .. "/News/Detail?groupContentNo=927"
  end
  ToClient_OpenChargeWebPage(url, false)
end
registerEvent("onScreenResize", "PaGlobal_Kr_Transfer_Init")
PaGlobal_Kr_Transfer_Init()
