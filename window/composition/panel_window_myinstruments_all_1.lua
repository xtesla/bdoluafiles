function PaGlobal_MyInstruments_All:initialize()
  if true == PaGlobal_MyInstruments_All._initialize then
    return
  end
  local stc_TitleBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_TitleBG")
  self._ui._btn_Close_PC = UI.getChildControl(stc_TitleBG, "Button_Win_Close_PC")
  local stc_MainBG = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._btn_WayPoint_Shop = UI.getChildControl(stc_MainBG, "Button_WayPoint_Shop")
  local stc_BottomGroup = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_BottomGroup")
  self._ui._btn_Confirm = UI.getChildControl(stc_BottomGroup, "Button_Confirm")
  local stc_MainBg = UI.getChildControl(Panel_Window_MyInstruments_All, "Static_MainBg")
  self._ui._frame = UI.getChildControl(stc_MainBg, "Frame_1")
  self._ui._frame_contents = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._frame_contents_txt = UI.getChildControl(self._ui._frame_contents, "StaticText_Intruments_Slot")
  self._ui._frame_contents_icon = UI.getChildControl(self._ui._frame_contents_txt, "StaticText_Icon_Instruments")
  self._ui._frame_contents_title = UI.getChildControl(self._ui._frame_contents, "StaticText_Title_Temp")
  self._ui._frame_vertical = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._frame_vertical_ctrl = UI.getChildControl(self._ui._frame_vertical, "Frame_1_VerticalScroll_CtrlButton")
  self._ui._frame_horizontal = UI.getChildControl(self._ui._frame, "Frame_1_HorizontalScroll")
  PaGlobal_MyInstruments_All:registEventHandler()
  PaGlobal_MyInstruments_All:validate()
  PaGlobal_MyInstruments_All._initialize = true
end
function PaGlobal_MyInstruments_All:createFrameControl()
  local nextPos = 0
  if true == _ContentsGroup_AdvancedMusic then
    for index = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
      nextPos = self:makeForType(index, nextPos)
    end
  else
    nextPos = self:makeForType(__eInstrumentAdvancedType_Novice, nextPos)
  end
  self._ui._frame_contents:SetSize(self._ui._frame_contents:GetSizeX(), nextPos)
end
function PaGlobal_MyInstruments_All:registEventHandler()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobal_MyInstruments_All_Close()")
  self._ui._btn_WayPoint_Shop:addInputEvent("Mouse_LUp", "HandleClicked_TownNpcIcon_NaviStart(40)")
end
function PaGlobal_MyInstruments_All:prepareOpen()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:createFrameControl()
  PaGlobal_MyInstruments_All:update()
  PaGlobal_MyInstruments_All:open()
end
function PaGlobal_MyInstruments_All:open()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(true)
end
function PaGlobal_MyInstruments_All:prepareClose()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:close()
end
function PaGlobal_MyInstruments_All:close()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  Panel_Window_MyInstruments_All:SetShow(false)
end
function PaGlobal_MyInstruments_All:update()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  local nextPos = 0
  if true == _ContentsGroup_AdvancedMusic then
    for index = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
      nextPos = self:updateFrameControl(index, nextPos)
    end
  else
    nextPos = self:updateFrameControl(__eInstrumentAdvancedType_Novice, nextPos)
  end
  self._ui._frame_contents:SetSize(self._ui._frame_contents:GetSizeX(), nextPos)
  local verticalControlSize = self._ui._frame_vertical:GetSizeY() * (self._ui._frame:GetSizeY() / nextPos)
  self._ui._frame_vertical_ctrl:SetSize(self._ui._frame_vertical_ctrl:GetSizeX(), verticalControlSize)
  self._ui._frame:UpdateContentScroll()
  self._ui._frame:UpdateContentPos()
end
function PaGlobal_MyInstruments_All:validate()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_WayPoint_Shop:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal_MyInstruments_All:resetControl()
  if true == _ContentsGroup_AdvancedMusic then
    for index = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count do
      self._titleTable[index]:SetShow(false)
    end
    for index = 1, #self._controlTable - 1 do
      self._controlTable[index].control:SetShow(false)
    end
  else
    self._titleTable[__eInstrumentAdvancedType_Novice]:SetShow(false)
  end
end
function PaGlobal_MyInstruments_All:updateFrameControl(advancedType, nextPos)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  if nil ~= self._titleTable[advancedType] then
    self._titleTable[advancedType]:SetShow(true)
    self._titleTable[advancedType]:SetPosY(nextPos)
    nextPos = nextPos + self._titleTable[advancedType]:GetSizeY()
  end
  local instrumentCount = Toclient_getInstrumentSize()
  for index = 0, instrumentCount - 1 do
    local midiType = Toclient_getInstrumentByIndex(index)
    if -1 ~= midiType then
      local isOpen = ToClient_getInstrumentIsOpenedByIndex(midiType)
      local advancedTypeClient = ToClient_getAdvancedTypeByIndex(midiType)
      if advancedTypeClient == advancedType and true == isOpen and nil ~= self._controlTable[index] then
        self._controlTable[index].content:SetShow(true)
        self._controlTable[index].content:SetPosY(nextPos)
        self._controlTable[index].title:SetShow(true)
        nextPos = nextPos + self._controlTable[index].content:GetSizeY()
      end
    end
  end
  return nextPos
end
function PaGlobal_MyInstruments_All:makeForType(advancedType, nextPos)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  if nil == self._titleTable[advancedType] then
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui._frame_contents, "StaticText_Title_Temp", self._ui._frame_contents, "StaticText_Title_Temp_" .. advancedType)
    if nil ~= tempContent then
      self._titleTable[advancedType] = tempContent
      self._titleTable[advancedType]:SetShow(false)
      self._titleTable[advancedType]:SetText(PAGetString(Defines.StringSheet_GAME, self._AdvancedTextTable[advancedType + 1]))
      self._titleTable[advancedType]:SetSize(self._ui._frame_contents_txt:GetSizeX(), self._ui._frame_contents_txt:GetSizeY())
      nextPos = nextPos + self._titleTable[advancedType]:GetSizeY()
    end
  end
  local instrumentCount = Toclient_MidiInstrumentTrackCount()
  for index = 0, instrumentCount - 1 do
    local midiType = Toclient_getInstrumentByIndex(index)
    if -1 ~= midiType then
      local isOpen = ToClient_getInstrumentIsOpenedByIndex(midiType)
      local advancedTypeClient = ToClient_getAdvancedTypeByIndex(midiType)
      if advancedTypeClient == advancedType and true == isOpen and nil == self._controlTable[index] then
        local tempContent = UI.createAndCopyBasePropertyControl(self._ui._frame_contents, "StaticText_Intruments_Slot", self._ui._frame_contents, "StaticText_Intruments_Slot_" .. midiType)
        if nil ~= tempContent then
          local tempTitle = UI.createAndCopyBasePropertyControl(self._ui._frame_contents_txt, "StaticText_Icon_Instruments", tempContent, "StaticText_Icon_Instruments" .. midiType)
          if nil ~= tempTitle then
            self._controlTable[index] = {}
            self._controlTable[index].content = tempContent
            self._controlTable[index].content:SetShow(true)
            self._controlTable[index].content:SetSize(self._ui._frame_contents_txt:GetSizeX(), self._ui._frame_contents_txt:GetSizeY())
            self._controlTable[index].content:setNotImpactScrollEvent(true)
            nextPos = nextPos + self._controlTable[index].content:GetSizeY()
            self._controlTable[index].title = tempTitle
            self:setContent(self._controlTable[index].title, midiType)
            self._controlTable[index].title:SetShow(true)
            self._controlTable[index].title:SetSize(self._ui._frame_contents_icon:GetSizeX(), self._ui._frame_contents_icon:GetSizeY())
          end
        end
      end
    end
  end
  return nextPos
end
function PaGlobal_MyInstruments_All:setContent(control, index)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  control:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(index)))
  local normalUV
  if 0 == index then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == index then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == index then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == index then
    normalUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == index then
    normalUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == index then
    normalUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == index then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == index then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == index then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == index then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  elseif 10 == index then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 11 == index then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 12 == index then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 13 == index then
    normalUV = {
      x1 = 311,
      y1 = 242,
      x2 = 341,
      y2 = 272
    }
  elseif 14 == index then
    normalUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 15 == index then
    normalUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 16 == index then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 17 == index then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 18 == index then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 19 == index then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(control, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal__MyInstruments_All_ListControlCreate(control, key)
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  local self = PaGlobal_MyInstruments_All
  local _key = Int64toInt32(key)
  local intrumentsSlot = UI.getChildControl(control, "StaticText_Intruments_Slot")
  local icon = UI.getChildControl(intrumentsSlot, "StaticText_Icon_Instruments")
  icon:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  icon:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(key)))
  local normalUV
  if 0 == _key then
    normalUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == _key then
    normalUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == _key then
    normalUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == _key then
    normalUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == _key then
    normalUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == _key then
    normalUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == _key then
    normalUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == _key then
    normalUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == _key then
    normalUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == _key then
    normalUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV then
    return
  end
  local x1, y1, x2, y2 = setTextureUV_Func(icon, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  icon:getBaseTexture():setUV(x1, y1, x2, y2)
  icon:setRenderTexture(icon:getBaseTexture())
end
