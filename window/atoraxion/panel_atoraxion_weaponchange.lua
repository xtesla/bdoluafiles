PaGlobal_Atoraxion_WeaponChange = {
  _ui = {
    _stc_MainWeapon = nil,
    _stc_Firelock = nil,
    _txt_State = nil
  },
  _initialize = false,
  _currentTime = 0,
  _currentAniPhase = 1,
  _currentType = -1,
  _emptyToEquipFadeSpeed = 1.2,
  _moveControlMaxTime = 0.75,
  _spanControlForce = 135,
  _maxSpanPos = 100,
  _fadeOutSpeed = 100,
  _showControlTime = 2
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_WeaponChange_Init")
function FromClient_Atoraxion_WeaponChange_Init()
  PaGlobal_Atoraxion_WeaponChange:initialize()
end
function PaGlobal_Atoraxion_WeaponChange:initialize()
  if true == PaGlobal_Atoraxion_WeaponChange._initialize or nil == Panel_Atoraxion_WeaponChange then
    return
  end
  self._ui._stc_MainWeapon = UI.getChildControl(Panel_Atoraxion_WeaponChange, "Static_MainWeapon")
  self._ui._stc_Firelock = UI.getChildControl(Panel_Atoraxion_WeaponChange, "Static_FirelockMode")
  self._ui._txt_State = UI.getChildControl(Panel_Atoraxion_WeaponChange, "StaticText_Text")
  PaGlobal_Atoraxion_WeaponChange:validate()
  PaGlobal_Atoraxion_WeaponChange:registEventHandler()
  self._initialize = true
end
function PaGlobal_Atoraxion_WeaponChange:registEventHandler()
  registerEvent("FromClient_ChangeAtoraxionWeapon", "FromClient_Atoraxion_WeaponChange_Open")
end
function PaGlobal_Atoraxion_WeaponChange:prepareOpen()
  Panel_Atoraxion_WeaponChange:RegisterUpdateFunc("FromClient_Atoraxion_WeaponChange_UpdatePerFrame")
  Panel_Atoraxion_WeaponChange:ComputePos()
  PaGlobal_Atoraxion_WeaponChange:open()
end
function PaGlobal_Atoraxion_WeaponChange:open()
  Panel_Atoraxion_WeaponChange:SetShow(true)
end
function PaGlobal_Atoraxion_WeaponChange:prepareClose()
  Panel_Atoraxion_WeaponChange:ClearUpdateLuaFunc()
  PaGlobal_Atoraxion_WeaponChange:close()
end
function PaGlobal_Atoraxion_WeaponChange:clear()
  self._ui._stc_MainWeapon:SetShow(false)
  self._ui._stc_Firelock:SetShow(false)
  self._ui._txt_State:SetShow(false)
  self._ui._stc_MainWeapon:SetSpanSize(0, self._ui._stc_MainWeapon:GetSpanSize().y)
  self._ui._stc_Firelock:SetSpanSize(0, self._ui._stc_Firelock:GetSpanSize().y)
  self._ui._stc_MainWeapon:ComputePos()
  self._ui._stc_Firelock:ComputePos()
  self._ui._stc_MainWeapon:SetAlpha(0)
  self._ui._stc_Firelock:SetAlpha(0)
  self._ui._txt_State:SetFontAlpha(0)
  self._currentTime = 0
  self._currentAniPhase = 1
  self._currentType = -1
end
function PaGlobal_Atoraxion_WeaponChange:close()
  Panel_Atoraxion_WeaponChange:SetShow(false)
end
function PaGlobal_Atoraxion_WeaponChange:validate()
  self._ui._stc_MainWeapon:isValidate()
  self._ui._stc_Firelock:isValidate()
  self._ui._txt_State:isValidate()
end
function FromClient_Atoraxion_WeaponChange_UpdatePerFrame(deltaTime)
  if nil == Panel_Atoraxion_WeaponChange then
    return
  end
  if -1 == PaGlobal_Atoraxion_WeaponChange._currentType then
    return
  end
  local self = PaGlobal_Atoraxion_WeaponChange
  if 0 == self._currentType then
    if 1 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_MainWeapon, self._fadeOutSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(1, self._ui._txt_State, self._fadeOutSpeed * deltaTime)
      if 1 <= self._ui._stc_MainWeapon:GetAlpha() then
        self._currentAniPhase = 2
        self._currentTime = 0
      end
    elseif 2 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_Firelock, 5 * deltaTime)
      if -self._maxSpanPos <= self._ui._stc_MainWeapon:GetSpanSize().x then
        self._ui._stc_MainWeapon:SetSpanSize(self._ui._stc_MainWeapon:GetSpanSize().x - self._spanControlForce * deltaTime, self._ui._stc_MainWeapon:GetSpanSize().y)
      else
        self._ui._stc_MainWeapon:SetSpanSize(-self._maxSpanPos, self._ui._stc_MainWeapon:GetSpanSize().y)
      end
      if self._ui._stc_Firelock:GetSpanSize().x <= self._maxSpanPos then
        self._ui._stc_Firelock:SetSpanSize(self._ui._stc_Firelock:GetSpanSize().x + self._spanControlForce * deltaTime, self._ui._stc_Firelock:GetSpanSize().y)
      else
        self._ui._stc_Firelock:SetSpanSize(self._maxSpanPos, self._ui._stc_Firelock:GetSpanSize().y)
      end
      self._currentTime = self._currentTime + deltaTime
      if self._moveControlMaxTime <= self._currentTime then
        self._currentAniPhase = 3
        self._currentTime = 0
      end
    elseif 3 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_MainWeapon, 2.45 * deltaTime)
      if 0 >= self._ui._stc_MainWeapon:GetSpanSize().x then
        self._ui._stc_MainWeapon:SetSpanSize(self._ui._stc_MainWeapon:GetSpanSize().x + self._spanControlForce * deltaTime, self._ui._stc_MainWeapon:GetSpanSize().y)
      else
        self._ui._stc_MainWeapon:SetSpanSize(0, self._ui._stc_MainWeapon:GetSpanSize().y)
      end
      if 0 <= self._ui._stc_Firelock:GetSpanSize().x then
        self._ui._stc_Firelock:SetSpanSize(self._ui._stc_Firelock:GetSpanSize().x - self._spanControlForce * deltaTime, self._ui._stc_Firelock:GetSpanSize().y)
      else
        self._ui._stc_Firelock:SetSpanSize(0, self._ui._stc_Firelock:GetSpanSize().y)
      end
      self._currentTime = self._currentTime + deltaTime
      if self._moveControlMaxTime <= self._currentTime then
        self._currentAniPhase = 4
        self._currentTime = 0
      end
    elseif 4 == self._currentAniPhase then
      self._currentTime = self._currentTime + deltaTime
      if self._showControlTime <= self._currentTime then
        self._currentAniPhase = 5
        self._currentTime = 0
      end
    elseif 5 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_Firelock, self._fadeOutSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(0, self._ui._txt_State, self._fadeOutSpeed * deltaTime)
      if 0 >= self._ui._stc_Firelock:GetAlpha() then
        Panel_Atoraxion_WeaponChange:ClearUpdateLuaFunc()
        PaGlobal_Atoraxion_WeaponChange:prepareClose()
      end
    end
  elseif 1 == self._currentType then
    if 1 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_Firelock, self._fadeOutSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(1, self._ui._txt_State, self._fadeOutSpeed * deltaTime)
      if 1 <= self._ui._stc_Firelock:GetAlpha() then
        self._currentAniPhase = 2
        self._currentTime = 0
      end
    elseif 2 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_MainWeapon, 5 * deltaTime)
      if -self._maxSpanPos <= self._ui._stc_Firelock:GetSpanSize().x then
        self._ui._stc_Firelock:SetSpanSize(self._ui._stc_Firelock:GetSpanSize().x - self._spanControlForce * deltaTime, self._ui._stc_Firelock:GetSpanSize().y)
      else
        self._ui._stc_Firelock:SetSpanSize(-self._maxSpanPos, self._ui._stc_Firelock:GetSpanSize().y)
      end
      if self._ui._stc_MainWeapon:GetSpanSize().x <= self._maxSpanPos then
        self._ui._stc_MainWeapon:SetSpanSize(self._ui._stc_MainWeapon:GetSpanSize().x + self._spanControlForce * deltaTime, self._ui._stc_MainWeapon:GetSpanSize().y)
      else
        self._ui._stc_MainWeapon:SetSpanSize(self._maxSpanPos, self._ui._stc_MainWeapon:GetSpanSize().y)
      end
      self._currentTime = self._currentTime + deltaTime
      if self._moveControlMaxTime <= self._currentTime then
        self._currentAniPhase = 3
        self._currentTime = 0
      end
    elseif 3 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_Firelock, 2.45 * deltaTime)
      if 0 >= self._ui._stc_Firelock:GetSpanSize().x then
        self._ui._stc_Firelock:SetSpanSize(self._ui._stc_Firelock:GetSpanSize().x + self._spanControlForce * deltaTime, self._ui._stc_Firelock:GetSpanSize().y)
      else
        self._ui._stc_Firelock:SetSpanSize(0, self._ui._stc_Firelock:GetSpanSize().y)
      end
      if 0 <= self._ui._stc_MainWeapon:GetSpanSize().x then
        self._ui._stc_MainWeapon:SetSpanSize(self._ui._stc_MainWeapon:GetSpanSize().x - self._spanControlForce * deltaTime, self._ui._stc_MainWeapon:GetSpanSize().y)
      else
        self._ui._stc_MainWeapon:SetSpanSize(0, self._ui._stc_MainWeapon:GetSpanSize().y)
      end
      self._currentTime = self._currentTime + deltaTime
      if self._moveControlMaxTime <= self._currentTime then
        self._currentAniPhase = 4
        self._currentTime = 0
      end
    elseif 4 == self._currentAniPhase then
      self._currentTime = self._currentTime + deltaTime
      if self._showControlTime <= self._currentTime then
        self._currentAniPhase = 5
        self._currentTime = 0
      end
    elseif 5 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_MainWeapon, self._fadeOutSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(0, self._ui._txt_State, self._fadeOutSpeed * deltaTime)
      if 0 >= self._ui._stc_MainWeapon:GetAlpha() then
        Panel_Atoraxion_WeaponChange:ClearUpdateLuaFunc()
        PaGlobal_Atoraxion_WeaponChange:prepareClose()
      end
    end
  elseif 2 == self._currentType then
    if 1 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_Firelock, self._emptyToEquipFadeSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(1, self._ui._txt_State, self._emptyToEquipFadeSpeed * deltaTime)
      if 1 <= self._ui._stc_Firelock:GetAlpha() then
        self._currentAniPhase = 2
        self._currentTime = 0
      end
    elseif 2 == self._currentAniPhase then
      self._currentTime = self._currentTime + deltaTime
      if self._showControlTime <= self._currentTime then
        self._currentAniPhase = 3
        self._currentTime = 0
      end
    elseif 3 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_Firelock, self._emptyToEquipFadeSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(0, self._ui._txt_State, self._emptyToEquipFadeSpeed * deltaTime)
      self._currentTime = self._currentTime + deltaTime
      if 0 >= self._ui._stc_Firelock:GetAlpha() then
        self._currentTime = 0
        PaGlobal_Atoraxion_WeaponChange:prepareClose()
      end
    end
  elseif 3 == self._currentType then
    if 1 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(1, self._ui._stc_MainWeapon, self._emptyToEquipFadeSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(1, self._ui._txt_State, self._emptyToEquipFadeSpeed * deltaTime)
      if 1 <= self._ui._stc_MainWeapon:GetAlpha() then
        self._currentAniPhase = 2
        self._currentTime = 0
      end
    elseif 2 == self._currentAniPhase then
      self._currentTime = self._currentTime + deltaTime
      if self._showControlTime <= self._currentTime then
        self._currentAniPhase = 3
        self._currentTime = 0
      end
    elseif 3 == self._currentAniPhase then
      UIAni.perFrameAlphaAnimation(0, self._ui._stc_MainWeapon, self._emptyToEquipFadeSpeed * deltaTime)
      UIAni.perFrameFontAlphaAnimation(0, self._ui._txt_State, self._emptyToEquipFadeSpeed * deltaTime)
      self._currentTime = self._currentTime + deltaTime
      if 0 >= self._ui._stc_MainWeapon:GetAlpha() then
        self._currentTime = 0
        PaGlobal_Atoraxion_WeaponChange:prepareClose()
      end
    end
  end
end
function FromClient_Atoraxion_WeaponChange_Open(bisEmptyToEquip, isGun)
  if nil == Panel_Atoraxion_WeaponChange then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Atoraxion_WeaponChange:clear()
  if true == isGun then
    PaGlobal_Atoraxion_WeaponChange._ui._txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WEAPONCHANGE_00"))
  else
    PaGlobal_Atoraxion_WeaponChange._ui._txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WEAPONCHANGE_01"))
  end
  if true == bisEmptyToEquip then
    if true == isGun then
      Panel_Atoraxion_WeaponChange:SetChildIndex(PaGlobal_Atoraxion_WeaponChange._ui._stc_Firelock, 9999)
      PaGlobal_Atoraxion_WeaponChange._currentType = 0
    else
      Panel_Atoraxion_WeaponChange:SetChildIndex(PaGlobal_Atoraxion_WeaponChange._ui._stc_MainWeapon, 9999)
      PaGlobal_Atoraxion_WeaponChange._currentType = 1
    end
  elseif true == isGun then
    Panel_Atoraxion_WeaponChange:SetChildIndex(PaGlobal_Atoraxion_WeaponChange._ui._stc_Firelock, 9999)
    PaGlobal_Atoraxion_WeaponChange._currentType = 2
  else
    Panel_Atoraxion_WeaponChange:SetChildIndex(PaGlobal_Atoraxion_WeaponChange._ui._stc_MainWeapon, 9999)
    PaGlobal_Atoraxion_WeaponChange._currentType = 3
  end
  PaGlobal_Atoraxion_WeaponChange:prepareOpen()
end
