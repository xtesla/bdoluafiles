PaGlobal_Atoraxion_MapSelecter = {
  _ui = {
    stc_Bg = nil,
    stc_controlBg = nil,
    stc_Line = nil,
    stc_Shadow = nil,
    stc_LeftTop = nil,
    btn_Close = nil,
    btn_Enter = nil,
    stc_SlotBg = nil,
    stc_Icon = {},
    mapSelectBtn = {},
    stc_KeyguideBG = nil,
    stc_Keyguide_A = nil,
    stc_Keyguide_B = nil,
    stc_Keyguide_X = nil,
    txt_Title = nil,
    multiline_Desc = nil
  },
  _mapData = {
    [__eInstanceAtoraxion_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_0"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_0"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_01.dds"
    },
    [__eInstanceAtoraxionSea_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_1"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_1"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_02.dds"
    }
  },
  _slotConfig = {createIcon = true, createCount = true},
  _initializeAnimation = false,
  _initializeScaleChange = false,
  _currentScale = 1,
  _leftTopDescOriginSpanX = 0,
  _currentSelect = __eInstanceAtoraxion_Hadum,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_MapSelecter_Init")
function FromClient_Atoraxion_MapSelecter_Init()
  PaGlobal_Atoraxion_MapSelecter:initialize()
end
function PaGlobal_Atoraxion_MapSelecter:initialize()
  if true == PaGlobal_Atoraxion_MapSelecter._initialize or nil == Panel_Atoraxion_Select then
    return
  end
  self._ui.stc_Bg = UI.getChildControl(Panel_Atoraxion_Select, "Static_BG")
  self._ui.stc_controlBg = UI.getChildControl(Panel_Atoraxion_Select, "Static_Select_Set")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_controlBg, "StaticText_TItle")
  self._ui.stc_Line = UI.getChildControl(self._ui.stc_controlBg, "Static_Line")
  self._ui.stc_Shadow = UI.getChildControl(self._ui.stc_controlBg, "Static_Shadow")
  self._ui.stc_LeftTop = UI.getChildControl(self._ui.stc_controlBg, "Static_LeftTop")
  local descBG = UI.getChildControl(self._ui.stc_controlBg, "Static_Desc")
  self._ui.multiline_Desc = UI.getChildControl(descBG, "MultilineEdit_1")
  self._ui.btn_Enter = UI.getChildControl(self._ui.stc_controlBg, "Button_Enter")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_controlBg, "Button_Close")
  local rdoBG = UI.getChildControl(self._ui.stc_controlBg, "Static_SelectArea_Group")
  for idx = 1, 4 do
    local tempTable = {}
    tempTable._lock = UI.getChildControl(rdoBG, "Static_LockedArea_" .. tostring(idx))
    tempTable._rdoBtn = UI.getChildControl(rdoBG, "RadioButton_" .. tostring(idx))
    self._ui.mapSelectBtn[idx] = tempTable
  end
  self._ui.mapSelectBtn[1]._lock:SetShow(false == ToClient_IsContentsGroupOpen("772"))
  self._ui.mapSelectBtn[2]._lock:SetShow(false == ToClient_IsContentsGroupOpen("773"))
  self._ui.mapSelectBtn[3]._lock:SetShow(false == ToClient_IsContentsGroupOpen("774"))
  self._ui.mapSelectBtn[4]._lock:SetShow(false == ToClient_IsContentsGroupOpen("775"))
  if true == self._isConsole then
    self._ui.mapSelectBtn[2]._rdoBtn:SetIgnore(false == ToClient_IsContentsGroupOpen("773"))
    self._ui.mapSelectBtn[3]._rdoBtn:SetIgnore(false == ToClient_IsContentsGroupOpen("774"))
    self._ui.mapSelectBtn[4]._rdoBtn:SetIgnore(false == ToClient_IsContentsGroupOpen("775"))
    self._ui.mapSelectBtn[2]._lock:SetIgnore(false == ToClient_IsContentsGroupOpen("773"))
    self._ui.mapSelectBtn[3]._lock:SetIgnore(false == ToClient_IsContentsGroupOpen("774"))
    self._ui.mapSelectBtn[4]._lock:SetIgnore(false == ToClient_IsContentsGroupOpen("775"))
  end
  self._ui.stc_KeyguideBG = UI.getChildControl(self._ui.stc_controlBg, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_Keyguide_A = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_Keyguide_B = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_B_ConsoleUI")
  self._ui.stc_Keyguide_X = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_X_ConsoleUI")
  local itemIconBg = UI.getChildControl(self._ui.stc_controlBg, "Static_ItemSlot_1")
  self._ui.stc_SlotBg = UI.getChildControl(itemIconBg, "Static_Icon")
  self._ui.stc_Icon = {}
  local temp = {}
  SlotItem.new(temp, "AtoraxionSelectICon_Enter", 0, self._ui.stc_SlotBg, self._slotConfig)
  temp:createChild()
  temp.icon:ComputePos()
  temp.count:ComputePos()
  self._ui.stc_Icon = temp
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Atoraxion_MapSelecter:validate()
  PaGlobal_Atoraxion_MapSelecter:registEventHandler()
  PaGlobal_Atoraxion_MapSelecter:swichPlatform(self._isConsole)
  PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize()
  self._leftTopDescOriginSpanX = self._ui.stc_LeftTop:GetSpanSize().x
  PaGlobal_Atoraxion_MapSelecter._initialize = true
end
function PaGlobal_Atoraxion_MapSelecter:registEventHandler()
  self._ui.stc_Icon.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Atoraxion_MapSelecter_IconTooltip(true)")
  self._ui.stc_Icon.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Atoraxion_MapSelecter_IconTooltip(false)")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Atoraxion_MapSelecter_Close()")
  self._ui.btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_Enter()")
  self._ui.mapSelectBtn[1]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxion_Hadum .. ")")
  if true == ToClient_IsContentsGroupOpen("773") then
    self._ui.mapSelectBtn[2]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxionSea_Hadum .. ")")
  end
  registerEvent("FromClient_InstanceContentsMapSelectOpen", "PaGlobalFunc_Atoraxion_MapSelecter_Open")
  registerEvent("onScreenResize", "PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize")
  Panel_Atoraxion_Select:RegisterShowEventFunc(true, "PaGlobal_Atoraxion_MapSelecter_ShowAni()")
  if true == self._isConsole then
    Panel_Atoraxion_Select:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Atoraxion_MapSelecter_Enter()")
  end
end
function PaGlobal_Atoraxion_MapSelecter:swichPlatform(isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyguideBG:SetShow(isConsole)
end
function PaGlobal_Atoraxion_MapSelecter:prepareOpen()
  self._initializeAnimation = false
  self._initializeScaleChange = false
  PaGlobal_Atoraxion_MapSelecter:initializeControlSetForAni(0)
  Panel_Atoraxion_Select:RegisterUpdateFunc("FromClient_Atoraxion_MapSelecter_PerframeEvent")
  for idx = 1, 4 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:SetCheck(1 == idx)
    end
  end
  HandleEventLUp_Atoraxion_MapSelecter_MapSelect(__eInstanceAtoraxion_Hadum)
  PaGlobal_Atoraxion_MapSelecter:open()
end
function PaGlobal_Atoraxion_MapSelecter:open()
  Panel_Atoraxion_Select:SetShow(true, true)
end
function PaGlobal_Atoraxion_MapSelecter:prepareClose()
  Panel_Atoraxion_Select:ClearUpdateLuaFunc()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Atoraxion_MapSelecter:close()
end
function PaGlobal_Atoraxion_MapSelecter:close()
  Panel_Atoraxion_Select:SetShow(false)
end
function PaGlobal_Atoraxion_MapSelecter:initializeControlSetForAni(value)
  self._ui.txt_Title:SetFontAlpha(value)
  self._ui.multiline_Desc:SetFontAlpha(value)
  self._ui.btn_Enter:SetAlpha(value)
  self._ui.btn_Close:SetAlpha(value)
  self._ui.stc_Line:SetAlpha(value)
  self._ui.stc_Shadow:SetAlpha(value)
  self._ui.stc_LeftTop:SetAlpha(value)
  self._ui.stc_SlotBg:SetAlpha(value)
  self._ui.stc_Icon.icon:SetAlpha(value)
  self._ui.stc_Icon.count:SetFontAlpha(value)
  for idx = 1, 4 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:SetAlpha(value)
      self._ui.mapSelectBtn[idx]._lock:SetAlpha(value)
    end
  end
  if value <= 0 then
    self._ui.stc_Line:SetShow(false)
    self._ui.stc_Shadow:SetShow(false)
    self._ui.stc_LeftTop:SetShow(false)
    self._ui.txt_Title:SetShow(false)
    self._ui.multiline_Desc:SetShow(false)
    self._ui.stc_SlotBg:SetShow(false)
    self._ui.btn_Enter:SetShow(false)
    if false == self._isConsole then
      self._ui.btn_Close:SetShow(false)
    end
    self._ui.stc_LeftTop:SetSpanSize(self._leftTopDescOriginSpanX - self._ui.stc_LeftTop:GetSizeX(), self._ui.stc_LeftTop:GetSpanSize().y)
  end
end
function PaGlobalFunc_Atoraxion_MapSelecter_Open(type, mode)
  if true == Panel_Atoraxion_Select:GetShow() then
    return
  end
  if __eInstanceContentsType_AtoraxionBoss ~= type then
    return
  end
  PaGlobal_Atoraxion_MapSelecter:prepareOpen()
end
function PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize()
  Panel_Atoraxion_Select:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Atoraxion_MapSelecter._ui.stc_Bg:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Atoraxion_MapSelecter._ui.stc_controlBg:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Atoraxion_Select:ComputePosAllChild()
  PaGlobal_Atoraxion_MapSelecter._ui.stc_Bg:ComputePosAllChild()
  PaGlobal_Atoraxion_MapSelecter._ui.stc_controlBg:ComputePosAllChild()
  if true == PaGlobal_Atoraxion_MapSelecter._isConsole then
    local tempTable = {
      PaGlobal_Atoraxion_MapSelecter._ui.stc_Keyguide_A,
      PaGlobal_Atoraxion_MapSelecter._ui.stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempTable, PaGlobal_Atoraxion_MapSelecter._ui.stc_KeyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function PaGlobalFunc_Atoraxion_MapSelecter_Close()
  PaGlobal_Atoraxion_MapSelecter:prepareClose()
end
function HandleEventOnOut_Atoraxion_MapSelecter_IconTooltip(show)
  if false == show or nil == show then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[self._currentSelect] then
    return
  end
  local mapData = self._mapData[self._currentSelect]
  local itemEnchantKey = ItemEnchantKey(mapData._itemKey, 0)
  if nil == itemEnchantKey then
    return
  end
  if false == itemEnchantKey:isDefined() then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, self._ui.stc_Icon.icon, true, false, nil)
end
function HandleEventLUp_Atoraxion_MapSelecter_MapSelect(mapType)
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[mapType] then
    return
  end
  local mapData = self._mapData[mapType]
  local itemEnchantKey = ItemEnchantKey(mapData._itemKey, 0)
  if nil == itemEnchantKey then
    return
  end
  if false == itemEnchantKey:isDefined() then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemWrapper then
    return
  end
  self._initializeScaleChange = false
  self._ui.stc_Icon:clearItem()
  self._ui.stc_Icon:setItemByStaticStatus(itemWrapper, 1)
  self._ui.txt_Title:SetText(mapData._title)
  self._ui.multiline_Desc:SetText(mapData._desc)
  self._ui.stc_Bg:ChangeTextureInfoName(mapData._bg)
  x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Bg, 0, 0, 1920, 1080)
  self._ui.stc_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_Bg:setRenderTexture(self._ui.stc_Bg:getBaseTexture())
  self._ui.stc_Bg:ComputePos()
  self._currentSelect = mapType
  local aniInfo1 = self._ui.stc_Bg:addScaleAnimation(0, 20, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1.AxisX = 1
  aniInfo1.AxisY = 1
  aniInfo1.ScaleType = 0
  aniInfo1:SetStartScale(1)
  aniInfo1:SetEndScale(1.025)
end
function HandleEventLUp_Atoraxion_MapSelecter_Enter()
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[self._currentSelect] then
    return
  end
  ToClient_InstanceContentNormalFieldEnter(15, 0, self._currentSelect)
end
function FromClient_Atoraxion_MapSelecter_PerframeEvent(deltaTime)
  if false == Panel_Atoraxion_Select:GetShow() then
    return
  end
  local self = PaGlobal_Atoraxion_MapSelecter
  if false == self._initializeAnimation and nil ~= self._ui.mapSelectBtn then
    local value = 0.5 * deltaTime
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[1]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[2]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[3]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[4]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[1]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[2]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[3]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[4]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.btn_Enter, 2.8 * deltaTime)
    if false == self._isConsole then
      UIAni.perFrameAlphaAnimation(1, self._ui.btn_Close, 2.8 * deltaTime)
    end
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_Line, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_Shadow, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_LeftTop, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_SlotBg, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.stc_Icon.icon, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.stc_Icon.count, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.txt_Title, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.multiline_Desc, 1.8 * deltaTime)
    local pos = self._ui.stc_LeftTop:GetSpanSize().x + 340 * deltaTime
    self._ui.stc_LeftTop:SetSpanSize(pos, self._ui.stc_LeftTop:GetSpanSize().y)
    if self._leftTopDescOriginSpanX <= self._ui.stc_LeftTop:GetSpanSize().x then
      self._initializeAnimation = true
    end
  end
end
function PaGlobal_Atoraxion_MapSelecter:validate()
  self._ui.stc_Bg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.multiline_Desc:isValidate()
  self._ui.btn_Enter:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Line:isValidate()
  self._ui.stc_Shadow:isValidate()
  self._ui.stc_LeftTop:isValidate()
  for idx = 1, 4 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:isValidate()
      self._ui.mapSelectBtn[idx]._lock:isValidate()
    end
  end
  self._ui.stc_KeyguideBG:isValidate()
  self._ui.stc_Keyguide_A:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
  self._ui.stc_Keyguide_X:isValidate()
end
function PaGlobal_Atoraxion_MapSelecter_ShowAni()
  Panel_Atoraxion_Select:ChangeSpecialTextureInfoName("new_ui_common_forlua/Default/Mask_Gradient_toBottom.dds")
  local FadeMaskAni = Panel_Atoraxion_Select:addTextureUVAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  FadeMaskAni:SetTextureType(CppEnums.PAUI_TEXTURE_TYPE.PAUI_TEXTURE_TYPE_MASK)
  FadeMaskAni:SetStartUV(0, 0.6, 0)
  FadeMaskAni:SetEndUV(0, 0.1, 0)
  FadeMaskAni:SetStartUV(1, 0.6, 1)
  FadeMaskAni:SetEndUV(1, 0.1, 1)
  FadeMaskAni:SetStartUV(0, 1, 2)
  FadeMaskAni:SetEndUV(0, 0.4, 2)
  FadeMaskAni:SetStartUV(1, 1, 3)
  FadeMaskAni:SetEndUV(0, 0.4, 3)
  local aniInfo3 = Panel_Atoraxion_Select:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
  local aniInfo8 = Panel_Atoraxion_Select:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo8:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(3)
  aniInfo8:SetEndIntensity(1)
end
