function PaGlobal_CrewMain_All:initialize()
  if true == PaGlobal_CrewMain_All._initialize then
    return
  end
  self._ui.stc_mainBG = UI.getChildControl(Panel_Window_CrewMain_All, "Static_Main_BG")
  self._ui.stc_titleBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Title_BG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_crewInfoBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Crew_Info")
  self._ui.txt_crewName = UI.getChildControl(self._ui.stc_crewInfoBG, "StaticText_CrewName")
  self._ui.txt_crewMasterName = UI.getChildControl(self._ui.stc_crewInfoBG, "StaticText_LeaderName")
  self._ui.edit_comment = UI.getChildControl(self._ui.stc_crewInfoBG, "Edit_Comment")
  self._ui.btn_saveNotice = UI.getChildControl(self._ui.edit_comment, "Static_Pen")
  self._ui.btn_destroyCrew = UI.getChildControl(self._ui.stc_crewInfoBG, "Button_CrewDestroyed")
  self._ui.txt_winRate = UI.getChildControl(self._ui.stc_crewInfoBG, "StaticText_Rate_Value")
  self._ui.txt_gameRecord = UI.getChildControl(self._ui.stc_crewInfoBG, "StaticText_Log")
  self._ui.stc_crewMemberBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Crew_Member_BG")
  self._ui.txt_currentMemberCount = UI.getChildControl(self._ui.stc_crewMemberBG, "StaticText_Count_Value")
  self._ui.txt_maxMemberCount = UI.getChildControl(self._ui.stc_crewMemberBG, "StaticText_Count_Total")
  self._ui.list2_crewMember = UI.getChildControl(self._ui.stc_crewMemberBG, "List2_Member")
  self._ui.stc_entryBG = UI.getChildControl(self._ui.stc_mainBG, "Static_Entry_BG")
  self._ui.stc_entryListBG = UI.getChildControl(self._ui.stc_entryBG, "Static_EntryList_BG")
  self._ui.stc_entrySlotTemplate = UI.getChildControl(self._ui.stc_entryListBG, "Static_Slot_Templete")
  self._ui.txt_currentEntryMemberCount = UI.getChildControl(self._ui.stc_entryBG, "StaticText_EntryCount_Value")
  self._ui.txt_maxEntryMemberCount = UI.getChildControl(self._ui.stc_entryBG, "StaticText_EntryCount_Total")
  self._ui.btn_inviteCrewMember = UI.getChildControl(self._ui.stc_mainBG, "Button_Invite")
  self._ui.btn_startMatch = UI.getChildControl(self._ui.stc_mainBG, "Button_Match")
  self._ui.stc_subMenuBG = UI.getChildControl(Panel_Window_CrewMain_All, "Static_SubMenu")
  self._ui.btn_whisper = UI.getChildControl(self._ui.stc_subMenuBG, "Button_Whisper")
  self._ui.btn_inviteParty = UI.getChildControl(self._ui.stc_subMenuBG, "Button_Invite_Party")
  self._ui.btn_changeMaster = UI.getChildControl(self._ui.stc_subMenuBG, "Button_ChangeMaster")
  self._ui.btn_disjoin = UI.getChildControl(self._ui.stc_subMenuBG, "Button_Disjoin")
  self._ui.btn_kick = UI.getChildControl(self._ui.stc_subMenuBG, "Button_Kick")
  local slotSizeY = self._ui.stc_entrySlotTemplate:GetSizeY()
  local gap = 3
  for index = 0, self._maxEntryCount - 1 do
    local slot = {}
    slot.bg = UI.cloneControl(self._ui.stc_entrySlotTemplate, self._ui.stc_entryListBG, "Static_Slot_EntryMember" .. index)
    slot.class = UI.getChildControl(slot.bg, "StaticText_ClassIcon")
    slot.userName = UI.getChildControl(slot.bg, "StaticText_Name")
    slot.level = UI.getChildControl(slot.bg, "StaticText_1")
    slot.bg:SetShow(false)
    slot.bg:SetPosY(gap + (slotSizeY + gap) * index)
    self._ui.entryMemberList[index] = slot
  end
  self._ui.stc_subMenuBG:SetShow(false)
  self._ui.stc_entrySlotTemplate:SetShow(false)
  self._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_CrewMain_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuideY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui.stc_KeyGuideX = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui.stc_KeyGuideA = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuideB = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuideLTY = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_LTY_ConsoleUI")
  self._ui.stc_KeyGuideLS = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_LC_ConsoleUI")
  self._ui.stc_KeyGuideRS = UI.getChildControl(self._ui.stc_keyGuideBG, "StaticText_RC_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CrewMain_All:setConsoleUI()
  if true == self._isConsole then
    self._ui.stc_keyGuideBG:SetShow(true)
    self._ui.btn_close:SetShow(false)
    self._ui.btn_destroyCrew:SetShow(false)
    self._ui.btn_saveNotice:SetShow(false)
    self._ui.btn_inviteCrewMember:SetShow(false)
    self._ui.btn_startMatch:SetShow(false)
    Panel_Window_CrewMain_All:SetSize(Panel_Window_CrewMain_All:GetSizeX(), Panel_Window_CrewMain_All:GetSizeY() - self._ui.btn_startMatch:GetSizeY())
    self._ui.stc_mainBG:SetSize(self._ui.stc_mainBG:GetSizeX(), self._ui.stc_mainBG:GetSizeY() - self._ui.btn_startMatch:GetSizeY())
    self:setAlignKeyGuide()
  else
    self._ui.stc_keyGuideBG:SetShow(false)
    self._ui.btn_close:SetShow(true)
    self._ui.btn_destroyCrew:SetShow(true)
    self._ui.btn_saveNotice:SetShow(true)
    self._ui.btn_inviteCrewMember:SetShow(true)
    self._ui.btn_startMatch:SetShow(true)
  end
end
function PaGlobal_CrewMain_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui.stc_KeyGuideLS,
    self._ui.stc_KeyGuideRS,
    self._ui.stc_KeyGuideLTY,
    self._ui.stc_KeyGuideX,
    self._ui.stc_KeyGuideY,
    self._ui.stc_KeyGuideA,
    self._ui.stc_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_CrewMain_All:registEventHandler()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  if true == self._isConsole then
    self._ui.edit_comment:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_CrewMain_All_VirtualKeyBoardEnd")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_Close()")
    self._ui.btn_destroyCrew:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_DestroyCrew()")
    self._ui.btn_inviteCrewMember:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_InviteCrewMember()")
    self._ui.btn_startMatch:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_StartCrewMatch()")
    self._ui.btn_saveNotice:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SetCrewNotice()")
    self._ui.btn_destroyCrew:addInputEvent("Mouse_On", "HandleEventOnOut_CrewMain_All_ShowDestroyTooltip(true)")
    self._ui.btn_destroyCrew:addInputEvent("Mouse_Out", "HandleEventOnOut_CrewMain_All_ShowDestroyTooltip(false)")
  end
  self._ui.list2_crewMember:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_CrewMain_All_MemberList_ControlCreate")
  self._ui.list2_crewMember:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_CrewMain_All_Resize")
  registerEvent("FromClient_ResponseDestroyCrew", "FromClient_CrewMain_All_ResponseDestroyCrew")
  registerEvent("FromClient_ResponseSetCrewNotice", "FromClient_CrewMain_All_ResponseSetCrewNotice")
  registerEvent("FromClient_ResponseKickCrewMember", "FromClient_CrewMain_All_ResponseKickCrewMember")
  registerEvent("FromClient_ResponseInviteCrew", "FromClient_CrewMain_All_ResonseCrewInvite")
  registerEvent("FromClient_ResponseRefuseCrewJoin", "FromClient_CrewMain_All_ResonseRefuseCrewJoin")
  registerEvent("FromClient_ResponseJoinCrew", "FromClient_CrewMain_All_ResonseJoinCrew")
  registerEvent("FromClient_ResponseDisjoinCrew", "FromClient_CrewMain_All_ResonseDisjoinCrew")
  registerEvent("FromClient_ResponseChangeCrewMaster", "FromClient_CrewMain_All_ResonseChangeCrewMaster")
  registerEvent("FromClient_UpdateCrewInformation", "FromClient_CrewMain_All_UpdateCrewInformation")
end
function PaGlobal_CrewMain_All:prepareOpen()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  if false == _ContentsGroup_CrewMatch then
    return
  end
  if true == Panel_Window_CrewMain_All:GetShow() then
    return
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  ToClient_RequestCrewInformation()
  Panel_Window_CrewMain_All:ComputePos()
  PaGlobal_CrewMain_All:update()
  PaGlobal_CrewMain_All:open()
end
function PaGlobal_CrewMain_All:open()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  Panel_Window_CrewMain_All:SetShow(true)
end
function PaGlobal_CrewMain_All:prepareClose(allClose)
  if nil == Panel_Window_CrewMain_All then
    return
  end
  if false == Panel_Window_CrewMain_All:GetShow() then
    return
  end
  if true == allClose then
    self._ui.stc_subMenuBG:SetShow(false)
    PaGlobal_CrewMain_All:close()
    return
  end
  if true == self._ui.stc_subMenuBG:GetShow() then
    self._ui.stc_subMenuBG:SetShow(false)
    return
  end
  PaGlobal_CrewMain_All:close()
end
function PaGlobal_CrewMain_All:close()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  Panel_Window_CrewMain_All:SetShow(false)
end
function PaGlobal_CrewMain_All:subMenuOpen(index)
  if true == self._ui.stc_subMenuBG:GetShow() then
    self:subMenuClose()
    return
  end
  self._ui.stc_subMenuBG:SetShow(true)
  self:updateSubMenu(index)
end
function PaGlobal_CrewMain_All:subMenuClose()
  self._ui.stc_subMenuBG:SetShow(false)
end
function PaGlobal_CrewMain_All:updateSubMenu(index)
  local isCrewMaster = false
  local selfPlayer = getSelfPlayer()
  local selfProxy
  if nil ~= selfPlayer then
    selfProxy = selfPlayer:get()
    if nil ~= selfProxy then
      if true == selfProxy:isCrewMaster() then
        isCrewMaster = true
      end
    else
      return
    end
  end
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local crewMemberWrapper = crewWrapper:getMemberByIndex(index)
  if nil == crewMemberWrapper then
    return
  end
  local isMe = selfProxy:getUserNo() == crewMemberWrapper:getUserNo()
  local buttonCount = 0
  local buttonPos = 0
  local buttonSize = self._ui.btn_whisper:GetSizeY()
  local gap = 1
  if false == isMe then
    self._ui.btn_whisper:SetShow(true)
    self._ui.btn_whisper:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SubMenu(" .. self._subMenuIndex.WHISPER .. "," .. index .. ")")
    self._ui.btn_whisper:SetPosY(buttonPos)
    buttonPos = buttonPos + buttonSize + gap
    buttonCount = buttonCount + 1
    self._ui.btn_inviteParty:SetShow(true)
    self._ui.btn_inviteParty:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SubMenu(" .. self._subMenuIndex.INVITEPARTY .. "," .. index .. ")")
    self._ui.btn_inviteParty:SetPosY(buttonPos)
    buttonPos = buttonPos + buttonSize + gap
    buttonCount = buttonCount + 1
  else
    self._ui.btn_whisper:SetShow(false)
    self._ui.btn_inviteParty:SetShow(false)
  end
  if true == isMe and false == isCrewMaster then
    self._ui.btn_disjoin:SetShow(true)
    self._ui.btn_disjoin:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SubMenu(" .. self._subMenuIndex.DISJOIN .. "," .. index .. ")")
    self._ui.btn_disjoin:SetPosY(buttonPos)
    buttonPos = buttonPos + buttonSize + gap
    buttonCount = buttonCount + 1
  else
    self._ui.btn_disjoin:SetShow(false)
  end
  if true == isCrewMaster and false == isMe then
    self._ui.btn_changeMaster:SetShow(true)
    self._ui.btn_changeMaster:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SubMenu(" .. self._subMenuIndex.CHANGEMASTER .. "," .. index .. ")")
    self._ui.btn_changeMaster:SetPosY(buttonPos)
    buttonPos = buttonPos + buttonSize + gap
    buttonCount = buttonCount + 1
    self._ui.btn_kick:SetShow(true)
    self._ui.btn_kick:addInputEvent("Mouse_LUp", "PaGlobalFunc_CrewMain_All_SubMenu(" .. self._subMenuIndex.KICKMEMBER .. "," .. index .. ")")
    self._ui.btn_kick:SetPosY(buttonPos)
    buttonPos = buttonPos + buttonSize + gap
    buttonCount = buttonCount + 1
  else
    self._ui.btn_changeMaster:SetShow(false)
    self._ui.btn_kick:SetShow(false)
  end
  if true == self._isConsole then
    self._ui.btn_whisper:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetSubMenuEvent()")
    self._ui.btn_inviteParty:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetSubMenuEvent()")
    self._ui.btn_disjoin:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetSubMenuEvent()")
    self._ui.btn_changeMaster:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetSubMenuEvent()")
    self._ui.btn_kick:addInputEvent("Mouse_On", "HandleEventMOn_CrewMain_All_SetSubMenuEvent()")
  end
  self._ui.stc_subMenuBG:SetSize(self._ui.stc_subMenuBG:GetSizeX(), buttonSize * buttonCount + (gap * buttonCount - 1))
  if 0 == buttonCount then
    self:subMenuClose()
  end
end
function PaGlobal_CrewMain_All:update()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  self:updateCrewInfo()
  self:updateCrewMember()
  self:updateEntryMember()
  self:updateButton()
end
function PaGlobal_CrewMain_All:updateCrewInfo()
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local crewName = crewWrapper:getCrewName()
  local crewMasterName = crewWrapper:getCrewMasterName()
  self._ui.txt_crewName:SetText(crewName)
  self._ui.txt_crewMasterName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CREW_MAIN_LEADER", "name", crewMasterName))
  local winCount = crewWrapper:getWinCount()
  local loseCount = crewWrapper:getWinCount()
  local totalCount = winCount + loseCount
  local winRate = 0
  if 0 == totalCount or 0 == winCount then
    winRate = 0
  elseif 0 == loseCount then
    winRate = 100
  else
    winRate = winCount / loseCount
  end
  self._ui.txt_winRate:SetText(tostring(winRate) .. "%")
  self._ui.txt_gameRecord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_CREW_MAIN_RECORD_VALUE", "win", tostring(winCount), "lose", tostring(loseCount)))
  local crewNotice = crewWrapper:getNotice()
  if nil ~= crewNotice then
    self._ui.edit_comment:SetEditText(crewNotice)
  end
end
function PaGlobal_CrewMain_All:updateCrewMember()
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local currentMemberCount = crewWrapper:getMemberCount()
  local maxMemberCount = crewWrapper:getMaxMemberCount()
  self._ui.txt_currentMemberCount:SetText(currentMemberCount)
  self._ui.txt_maxMemberCount:SetText("/ " .. maxMemberCount)
  self._ui.list2_crewMember:getElementManager():clearKey()
  local rowCount = math.ceil(currentMemberCount / 2)
  for index = 0, rowCount - 1 do
    self._ui.list2_crewMember:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_CrewMain_All:updateEntryMember()
  local crewWrapper = ToClient_GetMyCrewInfoWrapper()
  if nil == crewWrapper then
    return
  end
  local currentEntryMemberCount = crewWrapper:getEntryMemberCount()
  local maxEntryMemberCount = crewWrapper:getMaxEntryMemberCount()
  self._ui.txt_currentEntryMemberCount:SetText(currentEntryMemberCount)
  self._ui.txt_maxEntryMemberCount:SetText("/ " .. maxEntryMemberCount)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local myUserNo = selfProxy:getUserNo()
  for index = 0, self._maxEntryCount - 1 do
    local slot = self._ui.entryMemberList[index]
    if nil ~= slot then
      slot.bg:SetShow(false)
      slot.bg:addInputEvent("Mouse_RUp", "")
    end
  end
  for index = 0, currentEntryMemberCount - 1 do
    local slot = self._ui.entryMemberList[index]
    if nil ~= slot then
      slot.bg:SetShow(true)
      local entryMemberWrapper = crewWrapper:getEntryMemberByIndex(index)
      if nil ~= entryMemberWrapper then
        local userName = entryMemberWrapper:getName()
        slot.userName:SetText(userName)
        local level = entryMemberWrapper:getLevel()
        slot.level:SetText(level)
        local classType = entryMemberWrapper:getClassType()
        if __eClassType_Count ~= classType then
          PaGlobalFunc_Util_ChangeTextureClass(slot.class, classType)
        end
        if entryMemberWrapper:getUserNo() == myUserNo then
          slot.bg:addInputEvent("Mouse_RUp", "PaGlobalFunc_CrewMain_All_EntryCrewMatch(false)")
        end
      end
    end
  end
end
function PaGlobal_CrewMain_All:updateButton()
  local isCrewMaster = false
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local selfProxy = selfPlayer:get()
    if nil ~= selfProxy and true == selfProxy:isCrewMaster() then
      isCrewMaster = true
    end
  end
  if true == self._isConsole then
    if true == isCrewMaster then
      self._ui.stc_KeyGuideX:SetShow(true)
      self._ui.stc_KeyGuideLTY:SetShow(true)
      self._ui.stc_KeyGuideLS:SetShow(true)
      self._ui.stc_KeyGuideRS:SetShow(true)
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_CrewMain_All_InviteCrewMember()")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_CrewMain_All_StartCrewMatch()")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobalFunc_CrewMain_All_DestroyCrew()")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PaGlobalFunc_CrewMain_All_SetFocus()")
    else
      self._ui.stc_KeyGuideX:SetShow(false)
      self._ui.stc_KeyGuideLTY:SetShow(false)
      self._ui.stc_KeyGuideLS:SetShow(false)
      self._ui.stc_KeyGuideRS:SetShow(false)
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
      Panel_Window_CrewMain_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "")
    end
    self:setAlignKeyGuide()
  else
    self._ui.btn_inviteCrewMember:SetShow(isCrewMaster)
    self._ui.btn_startMatch:SetShow(isCrewMaster)
    self._ui.btn_destroyCrew:SetShow(isCrewMaster)
    self._ui.btn_saveNotice:SetShow(isCrewMaster)
    if true == isCrewMaster then
      self._ui.edit_comment:SetTextSpan(50, 0)
    else
      self._ui.edit_comment:SetIgnore(true)
    end
  end
end
function PaGlobal_CrewMain_All:validate()
  if nil == Panel_Window_CrewMain_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_crewInfoBG:isValidate()
  self._ui.txt_crewName:isValidate()
  self._ui.txt_crewMasterName:isValidate()
  self._ui.edit_comment:isValidate()
  self._ui.btn_saveNotice:isValidate()
  self._ui.btn_destroyCrew:isValidate()
  self._ui.txt_winRate:isValidate()
  self._ui.txt_gameRecord:isValidate()
  self._ui.stc_crewMemberBG:isValidate()
  self._ui.txt_currentMemberCount:isValidate()
  self._ui.txt_maxMemberCount:isValidate()
  self._ui.list2_crewMember:isValidate()
  self._ui.stc_entryBG:isValidate()
  self._ui.stc_entryListBG:isValidate()
  self._ui.stc_entrySlotTemplate:isValidate()
  self._ui.txt_currentEntryMemberCount:isValidate()
  self._ui.txt_maxEntryMemberCount:isValidate()
  self._ui.btn_inviteCrewMember:isValidate()
  self._ui.btn_startMatch:isValidate()
  self._ui.stc_subMenuBG:isValidate()
  self._ui.btn_whisper:isValidate()
  self._ui.btn_inviteParty:isValidate()
  self._ui.btn_changeMaster:isValidate()
  self._ui.btn_disjoin:isValidate()
  self._ui.btn_kick:isValidate()
  self._ui.stc_keyGuideBG:isValidate()
  self._ui.stc_KeyGuideY:isValidate()
  self._ui.stc_KeyGuideX:isValidate()
  self._ui.stc_KeyGuideA:isValidate()
  self._ui.stc_KeyGuideB:isValidate()
  self._ui.stc_KeyGuideLTY:isValidate()
  self._ui.stc_KeyGuideLS:isValidate()
  self._ui.stc_KeyGuideRS:isValidate()
end
