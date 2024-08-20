function PaGlobal_SelectInstruments_All:initialize()
  if true == PaGlobal_SelectInstruments_All._initialize then
    return
  end
  local stc_TitleBG = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_TitleBG")
  self._ui._btn_Close_PC = UI.getChildControl(stc_TitleBG, "Button_Win_Close_PC")
  local stc_MainBG = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_MainBg")
  self._ui._btn_WayPoint_Shop = UI.getChildControl(stc_MainBG, "Button_WayPoint_Shop")
  local stc_BottomGroup = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_BottomGroup")
  self._ui._btn_Confirm = UI.getChildControl(stc_BottomGroup, "Button_Confirm")
  local stc_MainBg = UI.getChildControl(Panel_Window_SelectInstruments_All, "Static_MainBg")
  self._ui._frame = UI.getChildControl(stc_MainBg, "Frame_1")
  self._ui._frame_content = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._ui._frame_content_btn = UI.getChildControl(self._ui._frame_content, "RadioButton_Instruments_Slot")
  self._ui._frame_content_txt = UI.getChildControl(self._ui._frame_content_btn, "StaticText_1")
  self._ui._frame_content_title = UI.getChildControl(self._ui._frame_content, "StaticText_Title_Temp")
  self._ui._frame_vertical = UI.getChildControl(self._ui._frame, "Frame_1_VerticalScroll")
  self._ui._frame_vertical_ctrl = UI.getChildControl(self._ui._frame_vertical, "Frame_1_VerticalScroll_CtrlButton")
  self._ui._frame_horizontal = UI.getChildControl(self._ui._frame, "Frame_1_HorizontalScroll")
  self._ui._btn_Close = UI.getChildControl(stc_BottomGroup, "Button_Close")
  PaGlobal_SelectInstruments_All:createControl()
  PaGlobal_SelectInstruments_All:registEventHandler()
  PaGlobal_SelectInstruments_All:validate()
  PaGlobal_SelectInstruments_All._initialize = true
end
function PaGlobal_SelectInstruments_All:createControl()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  local nextPos = 0
  for advancedType = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
    self._titleTable[advancedType] = UI.createAndCopyBasePropertyControl(self._ui._frame_content, "StaticText_Title_Temp", self._ui._frame_content, "StaticText_Title_Temp_" .. advancedType)
    if nil ~= self._titleTable[advancedType] then
      self._titleTable[advancedType]:SetShow(true)
      self._titleTable[advancedType]:SetSize(self._ui._frame_content_title:GetSizeX(), self._ui._frame_content_title:GetSizeY())
      self._titleTable[advancedType]:SetText(PAGetString(Defines.StringSheet_GAME, self._AdvancedTextTable[advancedType + 1]))
    end
  end
  local totalTrackCount = Toclient_MidiInstrumentTrackCount()
  for index = 0, totalTrackCount - 1 do
    local trackType = Toclient_getTrackTypeByIndex(index)
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui._frame_content, "RadioButton_Instruments_Slot", self._ui._frame_content, "RadioButton_Instruments_Slot_" .. index)
    if nil ~= tempContent then
      local tempTitle = UI.createAndCopyBasePropertyControl(self._ui._frame_content_btn, "StaticText_1", tempContent, "StaticText_" .. index)
      if nil ~= tempTitle then
        self._controlTable[index] = {}
        self._controlTable[index].content = tempContent
        self._controlTable[index].title = tempTitle
        self._controlTable[index].trackType = trackType
        self._controlTable[index].content:SetShow(true)
        self._controlTable[index].content:SetSize(self._ui._frame_content_btn:GetSizeX(), self._ui._frame_content_btn:GetSizeY())
        nextPos = nextPos + self._controlTable[index].content:GetSizeY()
        self:setTextureControl(self._controlTable[index].content, trackType)
        self._controlTable[index].title:SetShow(true)
        self._controlTable[index].title:SetSize(self._ui._frame_content_txt:GetSizeX(), self._ui._frame_content_txt:GetSizeY())
        self:setNameControl(self._controlTable[index].title, trackType)
      end
    end
  end
end
function PaGlobal_SelectInstruments_All:updateControl(musicInfo)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  local totalTrackCount = Toclient_MidiInstrumentTrackCount()
  for advancedType = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
    self._titleTable[advancedType]:SetShow(false)
  end
  for index = 0, totalTrackCount - 1 do
    if nil ~= self._controlTable[index] and nil ~= self._controlTable[index].content then
      self._controlTable[index].content:SetShow(false)
    end
  end
  local nextPos = 0
  local instrumentTrackListSize = musicInfo:getTrackSize()
  if true == _ContentsGroup_AdvancedMusic then
    for advancedType = __eInstrumentAdvancedType_Novice, __eInstrumentAdvancedType_Count - 1 do
      self._titleTable[advancedType]:SetShow(true)
      self._titleTable[advancedType]:SetPosY(nextPos)
      nextPos = nextPos + self._titleTable[advancedType]:GetSizeY()
      for index = 0, instrumentTrackListSize - 1 do
        local trackType = musicInfo:getTrackTypeByIndex(index)
        if false == musicInfo:isEmpty(trackType) and true == Toclient_isHaveInstrument(trackType) and advancedType == ToClient_getAdvancedTypeByIndex(trackType) then
          for ii = 0, #self._controlTable do
            if trackType == self._controlTable[ii].trackType then
              self._controlTable[ii].content:SetShow(true)
              self._controlTable[ii].content:SetPosY(nextPos)
              self._controlTable[ii].content:SetCheck(false)
              nextPos = nextPos + self._controlTable[ii].content:GetSizeY()
            end
          end
        end
      end
    end
  else
    self._titleTable[__eInstrumentAdvancedType_Novice]:SetShow(true)
    self._titleTable[__eInstrumentAdvancedType_Novice]:SetPosY(nextPos)
    nextPos = nextPos + self._titleTable[__eInstrumentAdvancedType_Novice]:GetSizeY()
    for index = 0, instrumentTrackListSize - 1 do
      local trackType = musicInfo:getTrackTypeByIndex(index)
      if false == musicInfo:isEmpty(trackType) and true == Toclient_isHaveInstrument(trackType) and __eInstrumentAdvancedType_Novice == ToClient_getAdvancedTypeByIndex(trackType) then
        for ii = 0, #self._controlTable do
          if trackType == self._controlTable[ii].trackType then
            self._controlTable[ii].content:SetShow(true)
            self._controlTable[ii].content:SetPosY(nextPos)
            self._controlTable[ii].content:SetCheck(false)
            nextPos = nextPos + self._controlTable[ii].content:GetSizeY()
          end
        end
      end
    end
  end
  self._ui._frame_content:SetSize(self._ui._frame_content:GetSizeX(), nextPos)
  local verticalControlSize = self._ui._frame_vertical:GetSizeY() * (self._ui._frame:GetSizeY() / nextPos)
  self._ui._frame_vertical_ctrl:SetSize(self._ui._frame_vertical_ctrl:GetSizeX(), verticalControlSize)
  self._ui._frame:UpdateContentScroll()
  self._ui._frame:UpdateContentPos()
end
function PaGlobal_SelectInstruments_All:registEventHandler()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Close(false)")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_Close(false)")
  self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_ConfirmBtn()")
  self._ui._btn_WayPoint_Shop:addInputEvent("Mouse_LUp", "HandleClicked_TownNpcIcon_NaviStart(40)")
end
function PaGlobal_SelectInstruments_All:prepareOpen(musicIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  PaGlobal_SelectInstruments_All:update(musicIndex)
  PaGlobal_SelectInstruments_All:open()
end
function PaGlobal_SelectInstruments_All:open()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  Panel_Window_SelectInstruments_All:SetShow(true)
end
function PaGlobal_SelectInstruments_All:prepareClose(isConfirm)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectMusicIndex = -1
  self._selectTrackIndex = -1
  if false == isConfirm then
    PaGlobal_MusicBoard_All_SelectTrack(self._selectMusicIndex, self._selectTrackIndex)
  end
  PaGlobal_SelectInstruments_All:close()
end
function PaGlobal_SelectInstruments_All:close()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  Panel_Window_SelectInstruments_All:SetShow(false)
end
function PaGlobal_SelectInstruments_All:update(musicIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectMusicIndex = musicIndex
  local musicInfo = ToClient_GetMusicInfoByIndex(musicIndex)
  if nil == musicInfo then
    return
  end
  PaGlobal_SelectInstruments_All:updateControl(musicInfo)
end
function PaGlobal_SelectInstruments_All:validate()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._ui._btn_Close_PC:isValidate()
  self._ui._btn_WayPoint_Shop:isValidate()
  self._ui._btn_Confirm:isValidate()
end
function PaGlobal_SelectInstruments_All:setTextureControl(control, trackType)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  local normalUV, onUV, clickUV
  if 0 == trackType then
    normalUV = {
      x1 = 187,
      y1 = 87,
      x2 = 217,
      y2 = 117
    }
    onUV = {
      x1 = 187,
      y1 = 118,
      x2 = 217,
      y2 = 148
    }
    clickUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == trackType then
    normalUV = {
      x1 = 1,
      y1 = 87,
      x2 = 31,
      y2 = 117
    }
    onUV = {
      x1 = 1,
      y1 = 118,
      x2 = 31,
      y2 = 148
    }
    clickUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == trackType then
    normalUV = {
      x1 = 404,
      y1 = 118,
      x2 = 434,
      y2 = 148
    }
    onUV = {
      x1 = 404,
      y1 = 87,
      x2 = 434,
      y2 = 117
    }
    clickUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == trackType then
    normalUV = {
      x1 = 156,
      y1 = 87,
      x2 = 186,
      y2 = 117
    }
    onUV = {
      x1 = 156,
      y1 = 118,
      x2 = 186,
      y2 = 148
    }
    clickUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == trackType then
    normalUV = {
      x1 = 94,
      y1 = 87,
      x2 = 124,
      y2 = 117
    }
    onUV = {
      x1 = 94,
      y1 = 118,
      x2 = 124,
      y2 = 148
    }
    clickUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == trackType then
    normalUV = {
      x1 = 63,
      y1 = 87,
      x2 = 93,
      y2 = 117
    }
    onUV = {
      x1 = 63,
      y1 = 118,
      x2 = 93,
      y2 = 148
    }
    clickUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == trackType then
    normalUV = {
      x1 = 125,
      y1 = 87,
      x2 = 155,
      y2 = 117
    }
    onUV = {
      x1 = 125,
      y1 = 118,
      x2 = 155,
      y2 = 148
    }
    clickUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == trackType then
    normalUV = {
      x1 = 342,
      y1 = 87,
      x2 = 372,
      y2 = 117
    }
    onUV = {
      x1 = 342,
      y1 = 118,
      x2 = 372,
      y2 = 148
    }
    clickUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == trackType then
    normalUV = {
      x1 = 311,
      y1 = 87,
      x2 = 341,
      y2 = 117
    }
    onUV = {
      x1 = 311,
      y1 = 118,
      x2 = 341,
      y2 = 148
    }
    clickUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == trackType then
    normalUV = {
      x1 = 373,
      y1 = 87,
      x2 = 403,
      y2 = 117
    }
    onUV = {
      x1 = 373,
      y1 = 118,
      x2 = 403,
      y2 = 148
    }
    clickUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  elseif 10 == trackType then
    normalUV = {
      x1 = 187,
      y1 = 87,
      x2 = 217,
      y2 = 117
    }
    onUV = {
      x1 = 187,
      y1 = 118,
      x2 = 217,
      y2 = 148
    }
    clickUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 11 == trackType then
    normalUV = {
      x1 = 1,
      y1 = 87,
      x2 = 31,
      y2 = 117
    }
    onUV = {
      x1 = 1,
      y1 = 118,
      x2 = 31,
      y2 = 148
    }
    clickUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 12 == trackType then
    normalUV = {
      x1 = 404,
      y1 = 118,
      x2 = 434,
      y2 = 148
    }
    onUV = {
      x1 = 404,
      y1 = 87,
      x2 = 434,
      y2 = 117
    }
    clickUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 13 == trackType then
    normalUV = {
      x1 = 311,
      y1 = 180,
      x2 = 341,
      y2 = 210
    }
    onUV = {
      x1 = 311,
      y1 = 211,
      x2 = 341,
      y2 = 241
    }
    clickUV = {
      x1 = 311,
      y1 = 242,
      x2 = 341,
      y2 = 272
    }
  elseif 14 == trackType then
    normalUV = {
      x1 = 94,
      y1 = 87,
      x2 = 124,
      y2 = 117
    }
    onUV = {
      x1 = 94,
      y1 = 118,
      x2 = 124,
      y2 = 148
    }
    clickUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 15 == trackType then
    normalUV = {
      x1 = 63,
      y1 = 87,
      x2 = 93,
      y2 = 117
    }
    onUV = {
      x1 = 63,
      y1 = 118,
      x2 = 93,
      y2 = 148
    }
    clickUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 16 == trackType then
    normalUV = {
      x1 = 125,
      y1 = 87,
      x2 = 155,
      y2 = 117
    }
    onUV = {
      x1 = 125,
      y1 = 118,
      x2 = 155,
      y2 = 148
    }
    clickUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 17 == trackType then
    normalUV = {
      x1 = 342,
      y1 = 87,
      x2 = 372,
      y2 = 117
    }
    onUV = {
      x1 = 342,
      y1 = 118,
      x2 = 372,
      y2 = 148
    }
    clickUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 18 == trackType then
    normalUV = {
      x1 = 311,
      y1 = 87,
      x2 = 341,
      y2 = 117
    }
    onUV = {
      x1 = 311,
      y1 = 118,
      x2 = 341,
      y2 = 148
    }
    clickUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 19 == trackType then
    normalUV = {
      x1 = 373,
      y1 = 87,
      x2 = 403,
      y2 = 117
    }
    onUV = {
      x1 = 373,
      y1 = 118,
      x2 = 403,
      y2 = 148
    }
    clickUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV or nil == onUV or nil == clickUV then
    return
  end
  control:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  control:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  control:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(control, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
  control:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(control, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  control:SetCheck(false)
  control:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_SelectTrackIndex(" .. tostring(trackType) .. ")")
end
function PaGlobal_SelectInstruments_All:setNameControl(control, trackType)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  control:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(trackType)))
  control:SetFontColor(Defines.Color.C_FFDDC39E)
end
function PaGlobal_SelectInstruments_All_ListControlCreate(control, key)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  local self = PaGlobal_SelectInstruments_All
  local _key = Int64toInt32(key)
  local btn_Slot = UI.getChildControl(control, "RadioButton_Instruments_Slot")
  local text = UI.getChildControl(btn_Slot, "StaticText_1")
  text:SetText(PAGetString(Defines.StringSheet_GAME, "AUDIO_MIDI_INSTRUMENT_" .. tostring(key)))
  local normalUV, onUV, clickUV
  if 0 == _key then
    normalUV = {
      x1 = 187,
      y1 = 87,
      x2 = 217,
      y2 = 117
    }
    onUV = {
      x1 = 187,
      y1 = 118,
      x2 = 217,
      y2 = 148
    }
    clickUV = {
      x1 = 187,
      y1 = 149,
      x2 = 217,
      y2 = 179
    }
  elseif 1 == _key then
    normalUV = {
      x1 = 1,
      y1 = 87,
      x2 = 31,
      y2 = 117
    }
    onUV = {
      x1 = 1,
      y1 = 118,
      x2 = 31,
      y2 = 148
    }
    clickUV = {
      x1 = 1,
      y1 = 149,
      x2 = 31,
      y2 = 179
    }
  elseif 2 == _key then
    normalUV = {
      x1 = 404,
      y1 = 118,
      x2 = 434,
      y2 = 148
    }
    onUV = {
      x1 = 404,
      y1 = 87,
      x2 = 434,
      y2 = 117
    }
    clickUV = {
      x1 = 404,
      y1 = 149,
      x2 = 434,
      y2 = 179
    }
  elseif 3 == _key then
    normalUV = {
      x1 = 156,
      y1 = 87,
      x2 = 186,
      y2 = 117
    }
    onUV = {
      x1 = 156,
      y1 = 118,
      x2 = 186,
      y2 = 148
    }
    clickUV = {
      x1 = 156,
      y1 = 149,
      x2 = 186,
      y2 = 179
    }
  elseif 4 == _key then
    normalUV = {
      x1 = 94,
      y1 = 87,
      x2 = 124,
      y2 = 117
    }
    onUV = {
      x1 = 94,
      y1 = 118,
      x2 = 124,
      y2 = 148
    }
    clickUV = {
      x1 = 94,
      y1 = 149,
      x2 = 124,
      y2 = 179
    }
  elseif 5 == _key then
    normalUV = {
      x1 = 63,
      y1 = 87,
      x2 = 93,
      y2 = 117
    }
    onUV = {
      x1 = 63,
      y1 = 118,
      x2 = 93,
      y2 = 148
    }
    clickUV = {
      x1 = 63,
      y1 = 149,
      x2 = 93,
      y2 = 179
    }
  elseif 6 == _key then
    normalUV = {
      x1 = 125,
      y1 = 87,
      x2 = 155,
      y2 = 117
    }
    onUV = {
      x1 = 125,
      y1 = 118,
      x2 = 155,
      y2 = 148
    }
    clickUV = {
      x1 = 125,
      y1 = 149,
      x2 = 155,
      y2 = 179
    }
  elseif 7 == _key then
    normalUV = {
      x1 = 342,
      y1 = 87,
      x2 = 372,
      y2 = 117
    }
    onUV = {
      x1 = 342,
      y1 = 118,
      x2 = 372,
      y2 = 148
    }
    clickUV = {
      x1 = 342,
      y1 = 149,
      x2 = 372,
      y2 = 179
    }
  elseif 8 == _key then
    normalUV = {
      x1 = 311,
      y1 = 87,
      x2 = 341,
      y2 = 117
    }
    onUV = {
      x1 = 311,
      y1 = 118,
      x2 = 341,
      y2 = 148
    }
    clickUV = {
      x1 = 311,
      y1 = 149,
      x2 = 341,
      y2 = 179
    }
  elseif 9 == _key then
    normalUV = {
      x1 = 373,
      y1 = 87,
      x2 = 403,
      y2 = 117
    }
    onUV = {
      x1 = 373,
      y1 = 118,
      x2 = 403,
      y2 = 148
    }
    clickUV = {
      x1 = 373,
      y1 = 149,
      x2 = 403,
      y2 = 179
    }
  end
  if nil == normalUV or nil == onUV or nil == clickUV then
    return
  end
  btn_Slot:ChangeTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  btn_Slot:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  btn_Slot:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_Concert_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, normalUV.x1, normalUV.y1, normalUV.x2, normalUV.y2)
  btn_Slot:getBaseTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, onUV.x1, onUV.y1, onUV.x2, onUV.y2)
  btn_Slot:getOnTexture():setUV(x1, y1, x2, y2)
  local x1, y1, x2, y2 = setTextureUV_Func(btn_Slot, clickUV.x1, clickUV.y1, clickUV.x2, clickUV.y2)
  btn_Slot:getClickTexture():setUV(x1, y1, x2, y2)
  btn_Slot:setRenderTexture(btn_Slot:getBaseTexture())
  btn_Slot:SetCheck(false)
  btn_Slot:addInputEvent("Mouse_LUp", "PaGloabl_SelectInstruments_All_SelectTrackIndex(" .. tostring(_key) .. ")")
end
function PaGlobal_SelectInstruments_All:selectTrackIndex(trackIndex)
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  self._selectTrackIndex = trackIndex
end
function PaGlobal_SelectInstruments_All:confirmBtn()
  if nil == Panel_Window_SelectInstruments_All then
    return
  end
  PaGlobal_MusicBoard_All_SelectTrack(self._selectMusicIndex, self._selectTrackIndex)
  PaGloabl_SelectInstruments_All_Close(true)
end
