PaGlobal_AppliedBuffList_Console = {
  _ui = {
    stc_buffTempleate = nil,
    stc_buffListArea = nil,
    txt_noBuffExist = nil,
    stc_KeyGuide = nil,
    stc_buff = {}
  },
  _buffListBgSizeX = 0,
  _buffListBgEndPosY = 0,
  _maxColumCount = 0,
  _columSize = 0,
  _currentIdx = 0,
  _currentColCount = 0,
  _currentPosY = 0,
  _MAX_CONTROL_COUNT = 50,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_AppliedBuffList_Console_Init")
function FromClient_AppliedBuffList_Console_Init()
  PaGlobal_AppliedBuffList_Console:initialize()
end
function PaGlobal_AppliedBuffList_Console:initialize()
  self._ui.stc_buffListArea = UI.getChildControl(Panel_AppliedBuffList_Console, "Static_BuffList_Area")
  self._ui.stc_buffTempleate = UI.getChildControl(self._ui.stc_buffListArea, "Static_Buff")
  self._ui.stc_KeyGuide = UI.getChildControl(Panel_AppliedBuffList_Console, "Static_Console_KeyGuide")
  self._ui.txt_noBuffExist = UI.getChildControl(Panel_AppliedBuffList_Console, "StaticText_NoBuff")
  self._buffListBgSizeX = self._ui.stc_buffListArea:GetSizeX()
  self._buffListBgEndPosY = Panel_AppliedBuffList_Console:GetPosY() + self._ui.stc_buffListArea:GetPosY() + self._ui.stc_buffListArea:GetSizeY()
  self._columSize = self._ui.stc_buffTempleate:GetSizeX() + 10
  self._maxColumCount = math.ceil(self._buffListBgSizeX / self._columSize)
  for idx = 0, self._MAX_CONTROL_COUNT - 1 do
    local tempTable = {
      _bg = nil,
      _icon = nil,
      _name = nil,
      _desc = nil,
      _buffKey = nil,
      _buffType = -1
    }
    local buffControl = UI.cloneControl(self._ui.stc_buffTempleate, self._ui.stc_buffListArea, "Copied_BuffControl_Console_" .. idx)
    tempTable._bg = buffControl
    tempTable._icon = UI.getChildControl(buffControl, "Static_BuffIcon")
    tempTable._name = UI.getChildControl(buffControl, "StaticText_Buff_Name")
    tempTable._desc = UI.getChildControl(buffControl, "StaticText_Buff_Eff")
    tempTable._name:SetTextMode(__eTextMode_Limit_AutoWrap)
    tempTable._desc:SetTextMode(__eTextMode_AutoWrap)
    tempTable._bg:ComputePos()
    PaGlobal_AppliedBuffList_Console._ui.stc_buff[idx] = tempTable
  end
  self._ui.stc_buffTempleate:SetShow(false)
  PaGlobal_AppliedBuffList_Console:registerEvent()
end
function PaGlobal_AppliedBuffList_Console:registerEvent()
  registerEvent("ResponseBuff_changeBuffList", "FromClient_AppliedBuffList_Console_UpdateBuff")
  registerEvent("onScreenResize", "FromClient_AppliedBuffList_Console_OnScreenResize")
end
function PaGlobal_AppliedBuffList_Console:prepareOpen()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  FromClient_AppliedBuffList_Console_OnScreenResize()
  PaGlobal_AppliedBuffList_Console:update()
  PaGlobal_AppliedBuffList_Console:open()
end
function PaGlobal_AppliedBuffList_Console:open()
  Panel_AppliedBuffList_Console:SetShow(true)
end
function PaGlobal_AppliedBuffList_Console:prepareClose()
  PaGlobal_AppliedBuffList_Console:close()
end
function PaGlobal_AppliedBuffList_Console:close()
  Panel_AppliedBuffList_Console:SetShow(false)
end
function PaGlobal_AppliedBuffList_Console:update()
  for idx = 0, self._MAX_CONTROL_COUNT - 1 do
    if nil ~= self._ui.stc_buff[idx] then
      self._ui.stc_buff[idx]._bg:SetSpanSize(0, 0)
      self._ui.stc_buff[idx]._bg:ComputePos()
      self._ui.stc_buff[idx]._bg:SetShow(false)
      self._ui.stc_buff[idx]._name:SetShow(false)
    end
  end
  self._currentIdx = 0
  self._currentColCount = 0
  self._currentPosY = 0
  PaGlobal_AppliedBuffList_Console:setUpBuff(__eBuffDisplayType_DeBuff)
  PaGlobal_AppliedBuffList_Console:setUpBuff(__eBuffDisplayType_ShortBuff)
  PaGlobal_AppliedBuffList_Console:setUpBuff(__eBuffDisplayType_Buff)
end
function PaGlobal_AppliedBuffList_Console:setUpBuff(buffType)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if nil == buffType then
    return
  end
  local startPosY = self._ui.stc_buffTempleate:GetPosY()
  local startPosX = self._ui.stc_buffTempleate:GetPosX()
  local bgSizeX = self._ui.stc_buffTempleate:GetSizeX()
  local appliedBuff = selfPlayer:getAppliedBuffBeginByOrder(buffType)
  while nil ~= appliedBuff do
    if self._MAX_CONTROL_COUNT - 1 < self._currentIdx then
      return
    end
    if nil == self._ui.stc_buff and nil == self._ui.stc_buff[self._currentIdx] then
      return
    end
    local parentBgStartPosY = self._ui.stc_buffListArea:GetPosY()
    self._ui.stc_buff[self._currentIdx]._bg:SetShow(true)
    self._ui.stc_buff[self._currentIdx]._icon:ChangeTextureInfoNameAsync("icon/" .. appliedBuff:getIconName())
    self._ui.stc_buff[self._currentIdx]._desc:SetText(appliedBuff:getBuffDesc())
    self._ui.stc_buff[self._currentIdx]._buffKey = appliedBuff:getBuffKey()
    self._ui.stc_buff[self._currentIdx]._buffType = buffType
    local descSizeY = self._ui.stc_buff[self._currentIdx]._desc:GetTextSizeY()
    local totalControlSizeY = self._ui.stc_buff[self._currentIdx]._icon:GetSizeY() + 30 + descSizeY
    self._ui.stc_buff[self._currentIdx]._bg:SetSize(bgSizeX, self._ui.stc_buff[self._currentIdx]._icon:GetSizeY() + 30 + descSizeY)
    local bgSizeY = self._ui.stc_buff[self._currentIdx]._bg:GetSizeY()
    if self._buffListBgEndPosY < parentBgStartPosY + self._currentPosY + bgSizeY + 5 then
      self._currentPosY = startPosY
      if self._currentColCount < self._maxColumCount - 1 then
        self._currentColCount = self._currentColCount + 1
      else
        self._ui.stc_buff[self._currentIdx]._bg:SetShow(false)
        return
      end
    end
    local posX = startPosX + (self._currentColCount - 1) * (bgSizeX + 5)
    self._ui.stc_buff[self._currentIdx]._bg:SetPosXY(posX, self._currentPosY)
    self._currentPosY = self._currentPosY + startPosY + (bgSizeY + 5)
    self._currentIdx = self._currentIdx + 1
    appliedBuff = selfPlayer:getAppliedBuffNextByOrder(buffType)
  end
  self._ui.txt_noBuffExist:SetShow(0 == self._currentIdx)
end
function FromClient_AppliedBuffList_Console_UpdateBuff()
  PaGlobal_AppliedBuffList_Console:update()
end
function PaGlobalFunc_AppliedBuffList_Console_Open()
  PaGlobal_AppliedBuffList_Console:prepareOpen()
end
function PaGlobalFunc_AppliedBuffList_Console_Close()
  PaGlobal_AppliedBuffList_Console:prepareClose()
end
function FromClient_AppliedBuffList_Console_OnScreenResize()
  Panel_AppliedBuffList_Console:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_AppliedBuffList_Console:ComputePosAllChild()
end
