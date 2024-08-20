function PaGlobal_Guild_Point:initialize()
  if true == PaGlobal_Guild_Point._initialize then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Guild_Point, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.stc_mouseGuide = UI.getChildControl(Panel_Guild_Point, "Static_KeyGuide")
  self._ui.stc_leftArea = UI.getChildControl(Panel_Guild_Point, "Static_LeftArea")
  self._ui.stc_circleArea = UI.getChildControl(self._ui.stc_leftArea, "Static_CircleHere")
  self._ui.stc_progress = UI.getChildControl(self._ui.stc_circleArea, "CircularProgress_GuildPoint")
  self._ui.txt_guildPoint = UI.getChildControl(self._ui.stc_circleArea, "StaticText_GuildPoint")
  self._ui.txt_guildPointTotal = UI.getChildControl(self._ui.stc_circleArea, "StaticText_GuildPoint_Total")
  self._ui.txt_guildPointExp = UI.getChildControl(self._ui.stc_circleArea, "StaticText_GuildPointExp")
  self._ui.txt_state = UI.getChildControl(self._ui.stc_circleArea, "StaticText_State")
  self._ui.stc_guildArea = UI.getChildControl(self._ui.stc_circleArea, "Static_GuildInfo_BG")
  self._ui.stc_guildIconBg = UI.getChildControl(self._ui.stc_guildArea, "Static_GuildIcon_BG")
  self._ui.stc_guildIcon = UI.getChildControl(self._ui.stc_guildIconBg, "Static_GuildIcon")
  self._ui.txt_guildName = UI.getChildControl(self._ui.stc_guildArea, "StaticText_GuildName")
  self._ui.txt_guildLeaderName = UI.getChildControl(self._ui.stc_guildArea, "StaticText_GuildLeaderName")
  self._ui.txt_noGuild = UI.getChildControl(self._ui.stc_guildArea, "StaticText_Noguild")
  self._ui.txt_voteValue = UI.getChildControl(self._ui.stc_circleArea, "StaticText_Vote_Value")
  self._ui.txt_territoryName = UI.getChildControl(self._ui.stc_circleArea, "StaticText_TerritoryName")
  self._ui.btn_vote = UI.getChildControl(self._ui.stc_guildArea, "Button_Vote")
  self._ui.txt_voteBtnName = UI.getChildControl(self._ui.btn_vote, "StaticText_Icon")
  self._ui.btn_voteRefresh = UI.getChildControl(self._ui.stc_guildArea, "Button_Refresh")
  self._ui.list2 = UI.getChildControl(self._ui.stc_leftArea, "List2_1")
  self._ui.list2_content = UI.getChildControl(self._ui.list2, "List2_1_Content")
  self._ui.txt_noPolicy = UI.getChildControl(self._ui.stc_leftArea, "StaticText_Skill_FrameDesc_NoPolicy")
  self._ui.frame_Skill = UI.getChildControl(Panel_Guild_Point, "Frame_GuildSkill")
  self._ui.stc_resultBG = UI.getChildControl(self._ui.stc_circleArea, "Static_Result_BG")
  self._ui.txt_resultTerritoryName = UI.getChildControl(self._ui.stc_resultBG, "StaticText_TerritoryName")
  self._ui.txt_resultVote = UI.getChildControl(self._ui.stc_resultBG, "StaticText_Vote_Value")
  for ii = 1, self._MAX_RANK do
    self._ui.stc_rankList[ii] = UI.getChildControl(self._ui.stc_resultBG, "Static_Grade_" .. ii)
  end
  local TerritoryArea = UI.getChildControl(self._ui.stc_leftArea, "Static_TerritoryArea")
  self._ui.btn_territory[1] = UI.getChildControl(TerritoryArea, "RadioButton_Balenos")
  self._ui.btn_territory[2] = UI.getChildControl(TerritoryArea, "RadioButton_Serendia")
  self._ui.btn_territory[3] = UI.getChildControl(TerritoryArea, "RadioButton_Calpheon")
  self._ui.btn_territory[4] = UI.getChildControl(TerritoryArea, "RadioButton_Media")
  self._ui.btn_territory[5] = UI.getChildControl(TerritoryArea, "RadioButton_Valencia")
  self.slotConfig.template.effect = UI.getChildControl(Panel_Guild_Point, "Static_Icon_Skill_Effect")
  self.slotConfig.template.iconFG = UI.getChildControl(Panel_Guild_Point, "Static_Icon_FG")
  self.slotConfig.template.iconFGDisabled = UI.getChildControl(Panel_Guild_Point, "Static_Icon_FG_DISABLE")
  self.slotConfig.template.iconFG_Passive = UI.getChildControl(Panel_Guild_Point, "Static_Icon_BG")
  self.slotConfig.template.learnButton = UI.getChildControl(Panel_Guild_Point, "Button_Skill_Point")
  self._ui.btn_timeLog = UI.getChildControl(self._ui.stc_circleArea, "CheckButton_Active_Log")
  if false == _ContentsGroup_GuildPolicyTimeLine then
    self._ui.btn_timeLog:SetShow(false)
  end
  self.template_guideLine = {
    h = {
      [3] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_LT"),
      [4] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_CT"),
      [5] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_RT"),
      [6] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_LM"),
      [7] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_CM"),
      [8] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_RM"),
      [9] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_LB"),
      [10] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_CB"),
      [11] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_RB"),
      [12] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_HORI"),
      [13] = UI.getChildControl(Panel_Guild_Point, "Static_TypeH_VERTI")
    },
    v = {
      [3] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_LT"),
      [4] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_CT"),
      [5] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_RT"),
      [6] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_LM"),
      [7] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_CM"),
      [8] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_RM"),
      [9] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_LB"),
      [10] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_CB"),
      [11] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_RB"),
      [12] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_HORI"),
      [13] = UI.getChildControl(Panel_Guild_Point, "Static_TypeV_VERTI")
    },
    l = {
      [3] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_LT"),
      [4] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_CT"),
      [5] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_RT"),
      [6] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_LM"),
      [7] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_CM"),
      [8] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_RM"),
      [9] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_LB"),
      [10] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_CB"),
      [11] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_RB"),
      [12] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_HORI"),
      [13] = UI.getChildControl(Panel_Guild_Point, "Static_TypeL_VERTI")
    },
    s = {
      [3] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_LT"),
      [4] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_CT"),
      [5] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_RT"),
      [6] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_LM"),
      [7] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_CM"),
      [8] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_RM"),
      [9] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_LB"),
      [10] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_CB"),
      [11] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_RB"),
      [12] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_HORI"),
      [13] = UI.getChildControl(Panel_Guild_Point, "Static_TypeS_VERTI")
    }
  }
  self._parentBG = PaGlobal_GuildMain_All._ui.stc_Skill_Bg
  self.slots = {}
  local cellTable = getTerritoryWarSkillTree(self.territoryIndex[self._selectTerritoryKey])
  local content = self._ui.frame_Skill:GetFrameContent()
  self:initSkillTreeControl(cellTable, content, self.slots)
  self._ui.frame_Skill:UpdateContentScroll()
  self._ui.frame_Skill:UpdateContentPos()
  self._contentSize = content:GetSizeY()
  for index = 1, #self.territoryIndex do
    local isShow = ToClient_isStartMajorSiege(self.territoryIndex[index])
    self._ui.btn_territory[index]:SetMonoTone(not isShow)
    self._ui.btn_territory[index]:SetIgnore(not isShow)
  end
  PaGlobal_Guild_Point:registEventHandler()
  PaGlobal_Guild_Point:validate()
  PaGlobal_Guild_Point._initialize = true
end
function PaGlobal_Guild_Point:registEventHandler()
  if nil == Panel_Guild_Point then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_Point_Close()")
  for index = 1, #self.territoryIndex do
    self._ui.btn_territory[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Guild_Point_SelectTerritory(" .. index .. ")")
  end
  self._ui.list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PaGlobal_Guild_Point_CreateSkillContent")
  self._ui.list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_vote:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Vote()")
  self._ui.btn_voteRefresh:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Vote_Refresh()")
  self._ui.btn_timeLog:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Guild_Point_OpenActiveTimeLine()")
  registerEvent("FromClient_GuildPointImformation", "FromClient_GuildPointImformation")
  registerEvent("FromClient_ChangeInvestImformation", "FromClient_ChangeInvestImformation")
  registerEvent("FromClient_ShowGuildPolicy", "FromClient_ShowGuildPolicy")
  registerEvent("FromClient_ChangeVoteResult", "FromClient_ChangeVoteResult")
end
function PaGlobal_Guild_Point:createSkillControl(content, key)
  local skillDesc = UI.getChildControl(content, "StaticText_Skill_FrameDesc")
  local skillGroup = UI.getChildControl(content, "StaticText_SkillGroupTitle")
  local skillNo = Int64toInt32(key)
  PaGlobal_Guild_Point._ui.txt_noPolicy:SetShow(false)
  skillDesc:SetShow(true)
  skillGroup:SetShow(true)
  if skillNo < 200 then
    skillDesc:SetShow(false)
    skillGroup:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_POLICY_SKILLGROUP_TITLE_" .. skillNo))
  else
    skillGroup:SetShow(false)
    local skillSS = getSkillTypeStaticStatus(skillNo)
    if nil ~= skillSS then
      skillDesc:SetText(tostring(skillSS:getName()))
    end
  end
end
function PaGlobal_Guild_Point:resetSkillTreeControl(cellTable, parent, container)
  local cols = cellTable:capacityX()
  local rows = cellTable:capacityY()
  self._cellTableCols = cols
  self._cellTableRows = rows
  for index = 0, #self.guideLineTable do
    if nil ~= self.guideLineTable[index] then
      self.guideLineTable[index]:SetShow(false)
    end
  end
  for row = 0, rows - 1 do
    for col = 0, cols - 1 do
      local cell = cellTable:atPointer(col, row)
      local skillNo = cell._skillNo
      if cell:isSkillType() and nil ~= container[skillNo] then
        container[skillNo]:clearSkill()
        if nil ~= container[skillNo].icon then
          container[skillNo].icon:SetShow(false)
          container[skillNo].icon:addInputEvent("Mouse_LUp", "")
          container[skillNo].icon:addInputEvent("Mouse_RUp", "")
        end
      end
    end
  end
end
function PaGlobal_Guild_Point:initSkillTreeControl(cellTable, parent, container)
  local cols = cellTable:capacityX()
  local rows = cellTable:capacityY()
  self._cellTableCols = cols
  self._cellTableRows = rows
  local LineCount = 0
  local startY = self.config.slotStartY
  local inValidateCount = 0
  local currentInvestType = __eGuildPointInvestType_Count
  self._firstSkillNo = nil
  for row = 0, rows - 1 do
    local startX = self.config.slotStartX
    local isSlotRow = 0 == row % 2
    if isSlotRow then
      startY = startY + self.config.emptyGapY
    else
      startY = startY + self.config.slotGapY
    end
    for col = 0, cols - 1 do
      local cell = cellTable:atPointer(col, row)
      local skillNo = cell._skillNo
      local isSlotColumn = 0 == col % 2
      if isSlotColumn then
        startX = startX + self.config.emptyGapX
      else
        startX = startX + self.config.slotGapX
      end
      if cell:isSkillType() then
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        if skillTypeStaticWrapper:isValidLocalizing() then
          if nil == self._firstSkillNo then
            self._firstSkillNo = skillNo
          end
          local slot = {}
          local isInvestedSkill = false
          local isInvestedFinalSkill = false
          local isPossibleInvestSkill = false
          if __eGuildPolicyTimeType_SettingPolicyGuild == self._guildPolicyTimeType then
            isInvestedSkill = ToClient_IsInvestedPolicy(skillNo)
            isInvestedFinalSkill = ToClient_IsInvestedFinalPolicy(skillNo)
            isPossibleInvestSkill = ToClient_IsPossibleInvestPolicy(skillNo)
          elseif __eGuildPolicyTimeType_AllShow == self._guildPolicyTimeType then
            isInvestedSkill = ToClient_IsInvestedPolicy(skillNo)
            isInvestedFinalSkill = ToClient_IsInvestedFinalPolicy(skillNo)
          end
          if nil ~= container[skillNo] then
            slot = container[skillNo]
          else
            SlotSkill.new(slot, skillNo, parent, self.slotConfig)
          end
          if nil ~= slot then
            if nil ~= slot.icon then
              slot.icon:SetShow(true)
              slot.icon:addInputEvent("Mouse_On", "InputEventMOnOut_PaGlobal_Guild_Point_ShowSkillTooltip(" .. skillNo .. ", \"GuildPolicy\", true)")
              slot.icon:addInputEvent("Mouse_Out", "InputEventMOnOut_PaGlobal_Guild_Point_ShowSkillTooltip(" .. skillNo .. ", \"GuildPolicy\", false)")
            end
            if nil ~= slot.learnButton then
              slot.learnButton:SetIgnore(true)
            end
            if nil ~= slot.iconMinus then
              slot.iconMinus:SetShow(true)
            end
            if true == skillTypeStaticWrapper:get():isActiveSkill() then
              if true == isInvestedSkill then
                local investType = self._ACTIVE_POLICY_INVEST_TYPE
                if currentInvestType ~= investType then
                  currentInvestType = self._ACTIVE_POLICY_INVEST_TYPE
                  self._ui.list2:getElementManager():pushKey(toInt64(0, self._ACTIVE_POLICY_INVEST_TYPE))
                  self._ui.list2:getElementManager():pushKey(toInt64(0, skillNo))
                else
                  self._ui.list2:getElementManager():pushKey(toInt64(0, skillNo))
                end
              end
              slot.iconFG_Passive:SetShow(false)
              slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Guild_Point_InvestSkill(" .. skillNo .. ")")
            else
              if true == isInvestedSkill then
                if nil ~= slot.iconFG_Passive then
                  slot.iconFG_Passive:SetShow(false)
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_PaGlobal_Guild_Point_CancelInvestSkill(" .. skillNo .. ")")
                  if true == isInvestedFinalSkill then
                    local investType = ToClient_GetGuildPointInvestType(skillNo)
                    if currentInvestType ~= investType then
                      currentInvestType = investType
                      self._ui.list2:getElementManager():pushKey(toInt64(0, investType))
                      self._ui.list2:getElementManager():pushKey(toInt64(0, skillNo))
                    else
                      self._ui.list2:getElementManager():pushKey(toInt64(0, skillNo))
                    end
                  end
                end
              elseif nil ~= slot.iconFG_Passive then
                slot.iconFG_Passive:SetShow(true)
                slot.icon:addInputEvent("Mouse_RUp", "")
              end
              if true == isPossibleInvestSkill then
                if nil ~= slot.learnButton then
                  slot.learnButton:SetShow(true)
                  slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Guild_Point_InvestSkill(" .. skillNo .. ")")
                end
              elseif nil ~= slot.learnButton then
                slot.learnButton:SetShow(false)
                slot.icon:addInputEvent("Mouse_LUp", "")
              end
              if nil ~= slot.icon and false == isInvestedSkill and false == isPossibleInvestSkill then
                slot.icon:addInputEvent("Mouse_RUp", "HandleEventLUp_PaGlobal_Guild_Point_CantInvestSkill()")
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Guild_Point_CantInvestSkill()")
              end
            end
          end
          slot:setPos(startX, startY)
          container[skillNo] = slot
          slot:setSkillTypeStatic(skillTypeStaticWrapper)
        else
          inValidateCount = inValidateCount + 1
          local point = {_col = col, _row = row}
          self._inValidateSlots[inValidateCount] = point
        end
      elseif cell:isLineType() then
        local template = self:getLineTemplate(isSlotColumn, isSlotRow, cell._cellType)
        if nil ~= template then
          if nil == self.guideLineTable[LineCount] then
            self.guideLineTable[LineCount] = UI.createControl(__ePAUIControl_Static, parent, "Static_Line" .. LineCount)
          end
          CopyBaseProperty(template, self.guideLineTable[LineCount])
          self.guideLineTable[LineCount]:SetPosX(startX)
          self.guideLineTable[LineCount]:SetPosY(startY)
          self.guideLineTable[LineCount]:SetIgnore(true)
          self.guideLineTable[LineCount]:SetShow(true)
          LineCount = LineCount + 1
        end
      end
    end
  end
  if inValidateCount > 0 then
    for slotIdx = 1, inValidateCount do
      for dIdx = 0, #self._direction do
        self:hideInvalidateLine(cellTable, parent, self._inValidateSlots[slotIdx], self._direction[dIdx])
      end
    end
  end
  self._ui.frame_Skill:UpdateContentPos()
  self._ui.frame_Skill:UpdateContentScroll()
end
function PaGlobal_GuildSkill_All:hideInvalidateLine(cellTable, parent, point, direction)
  local col = point._col + direction._col
  if col < 0 or col > self._cellTableCols then
    return
  end
  local row = point._row + direction._row
  if row < 0 or row > self._cellTableRows then
    return
  end
  local cell = cellTable:atPointer(col, row)
  if cell:isSkillType() then
    return
  elseif cell:isLineType() then
    local line = UI.getChildControl(parent, "Static_Line_" .. col .. "_" .. row)
    if nil ~= line then
      if line:GetShow() then
        line:SetShow(false)
      else
        return
      end
    end
    if 12 == cell._cellType or 13 == cell._cellType then
      local point = {_col = col, _row = row}
      self:hideInvalidateLine(cellTable, parent, point, direction)
    else
      local point = {_col = col, _row = row}
      self:hideInvalidateLine(cellTable, parent, point, self._direction[2])
    end
    return
  end
end
function PaGlobal_Guild_Point:getLineTemplate(isSlotColumn, isSlotRow, lineType)
  local lineDef
  if isSlotColumn and isSlotRow then
    lineDef = self.template_guideLine.l
  elseif not isSlotColumn and isSlotRow then
    lineDef = self.template_guideLine.v
  elseif isSlotColumn and not isSlotRow then
    lineDef = self.template_guideLine.h
  else
    lineDef = self.template_guideLine.s
  end
  return lineDef[lineType]
end
function PaGlobal_Guild_Point:prepareOpen()
  if nil == Panel_Guild_Point then
    return
  end
  local cellTable = getTerritoryWarSkillTree(self.territoryIndex[self._selectTerritoryKey])
  local content = self._ui.frame_Skill:GetFrameContent()
  self:resetSkillTreeControl(cellTable, content, self.slots)
  local vScroll = self._ui.frame_Skill:GetVScroll()
  vScroll:SetControlPos(0)
  content:SetSize(content:GetSizeX(), self._contentSize + 20)
  local territory = ToClient_RequestTerritoryKeyByGuildNo()
  if -1 ~= territory then
    self._selectTerritoryKey = territory + 1
  end
  for index = 1, #self._ui.btn_territory do
    if index == self._selectTerritoryKey then
      self._ui.btn_territory[index]:SetCheck(true)
    else
      self._ui.btn_territory[index]:SetCheck(false)
    end
  end
  self:update()
  PaGlobal_Guild_Point:open()
end
function PaGlobal_Guild_Point:open()
  if nil == Panel_Guild_Point then
    return
  end
  Panel_Guild_Point:SetShow(true)
end
function PaGlobal_Guild_Point:prepareClose()
  if nil == Panel_Guild_Point then
    return
  end
  Panel_SkillTooltip_Hide()
  PaGlobal_GuildPoint_SkillLog_Close()
  local cellTable = getTerritoryWarSkillTree(self.territoryIndex[self._selectTerritoryKey])
  local content = self._ui.frame_Skill:GetFrameContent()
  self:resetSkillTreeControl(cellTable, content, self.slots)
  self._ui.frame_Skill:UpdateContentPos()
  PaGlobal_Guild_Point:close()
end
function PaGlobal_Guild_Point:close()
  if nil == Panel_Guild_Point then
    return
  end
  Panel_Guild_Point:SetShow(false)
end
function PaGlobal_Guild_Point:update()
  if nil == Panel_Guild_Point then
    return
  end
  local guildNo = ToClient_RequestTerritoryGuildNo(self.territoryIndex[self._selectTerritoryKey])
  if false == self._isApplicationTime then
    if true == ToClient_isDoingSiegeTerritory(self.territoryIndex[self._selectTerritoryKey]) then
      self._guildPolicyTimeType = __eGuildPolicyTimeType_DoSiege
    elseif 0 == Int64toInt32(guildNo) then
      self._guildPolicyTimeType = __eGuildPolicyTimeType_Emancipation
    elseif true == ToClient_GetSiegeOccupyMyGuild(self.territoryIndex[self._selectTerritoryKey]) then
      self._guildPolicyTimeType = __eGuildPolicyTimeType_SettingPolicyGuild
    else
      self._guildPolicyTimeType = __eGuildPolicyTimeType_SettingPolicy
    end
  elseif 0 == Int64toInt32(guildNo) then
    self._guildPolicyTimeType = __eGuildPolicyTimeType_Emancipation
  else
    self._guildPolicyTimeType = __eGuildPolicyTimeType_AllShow
  end
  PaGlobal_Guild_Point._ui.txt_noPolicy:SetShow(true)
  local cellTable = getTerritoryWarSkillTree(self.territoryIndex[self._selectTerritoryKey])
  local content = self._ui.frame_Skill:GetFrameContent()
  self._ui.list2:getElementManager():clearKey()
  self:initSkillTreeControl(cellTable, content, self.slots)
  self._ui.frame_Skill:UpdateContentScroll()
  local vScroll = self._ui.frame_Skill:GetVScroll()
  self._ui.frame_Skill:UpdateContentPos()
  self:setData(self._selectTerritoryKey)
  self:setGuildPoint()
end
function PaGlobal_Guild_Point:setGuildPoint()
  if nil == Panel_Guild_Point then
    return
  end
  local guildPoint = ToClient_RequestTerritoryGuildPoint(self.territoryIndex[self._selectTerritoryKey])
  local weekGuildPoint = ToClient_RequestGuildPointWeek(self.territoryIndex[self._selectTerritoryKey])
  if self._guildPolicyTimeType == __eGuildPolicyTimeType_Emancipation then
    self._ui.txt_state:SetShow(true)
    self._ui.txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDPOINT_STATE_READY"))
    self._ui.txt_voteValue:SetShow(false)
    self._ui.txt_guildPoint:SetText(tostring(0))
    self._ui.txt_guildPointTotal:SetText("/ " .. tostring(0) .. " Pt")
    self:setProcess(0, 0)
  elseif self._guildPolicyTimeType == __eGuildPolicyTimeType_DoSiege then
    self._ui.txt_state:SetShow(true)
    self._ui.txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDPOINT_STATE_SIEGEWAR"))
    self._ui.txt_voteValue:SetShow(false)
    self._ui.txt_guildPoint:SetText(tostring(0))
    self._ui.txt_guildPointTotal:SetText("/ " .. tostring(0) .. " Pt")
    self:setProcess(0, 0)
  elseif self._guildPolicyTimeType == __eGuildPolicyTimeType_SettingPolicy then
    self._ui.txt_state:SetShow(true)
    self._ui.txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDPOINT_STATE_DISCUSSION"))
    self._ui.txt_voteValue:SetShow(false)
    self._ui.txt_guildPoint:SetText(tostring(weekGuildPoint))
    self._ui.txt_guildPointTotal:SetText("/ " .. tostring(weekGuildPoint) .. " Pt")
    self:setProcess(weekGuildPoint, weekGuildPoint)
  elseif self._guildPolicyTimeType == __eGuildPolicyTimeType_SettingPolicyGuild then
    self._ui.txt_state:SetShow(false)
    self._ui.txt_voteValue:SetShow(true)
    self._ui.txt_guildPoint:SetText(tostring(guildPoint))
    self._ui.txt_guildPointTotal:SetText("/ " .. tostring(weekGuildPoint) .. " Pt")
    self:setProcess(guildPoint, weekGuildPoint)
  elseif self._guildPolicyTimeType == __eGuildPolicyTimeType_AllShow then
    self._ui.txt_state:SetShow(false)
    self._ui.txt_voteValue:SetShow(true)
    self._ui.txt_guildPoint:SetText(tostring(guildPoint))
    self._ui.txt_guildPointTotal:SetText("/ " .. tostring(weekGuildPoint) .. " Pt")
    self:setProcess(guildPoint, weekGuildPoint)
  end
end
function PaGlobal_Guild_Point:setData(index)
  if nil == Panel_Guild_Point then
    return
  end
  if false == ToClient_IsCanVoteToTerritory() and true == ToClinet_IsShowVoteResult() then
    for ii = 1, self._MAX_RANK do
      self._ui.stc_rankList[ii]:SetShow(false)
    end
    self._ui.stc_resultBG:SetShow(true)
    self._ui.txt_resultTerritoryName:SetText(getTerritoryNameByKey(getTerritoryByIndex(self.territoryIndex[self._selectTerritoryKey])))
    self._ui.txt_resultVote:SetText(tostring(ToClient_GetVoteCount(self.territoryIndex[self._selectTerritoryKey])))
    local rank = ToClient_GetVoteRank(self.territoryIndex[self._selectTerritoryKey])
    if nil ~= self._ui.stc_rankList[rank] then
      self._ui.stc_rankList[rank]:SetShow(true)
    end
  else
    self._ui.stc_resultBG:SetShow(false)
  end
  self._ui.txt_territoryName:SetText(getTerritoryNameByKey(getTerritoryByIndex(self.territoryIndex[self._selectTerritoryKey])))
  self:setGuildPoint()
  local guildNo = ToClient_RequestTerritoryGuildNo(self.territoryIndex[index])
  local guildInfo = ToClient_GetGuildWrapperByGuildNo(guildNo)
  if nil == guildInfo then
    self._ui.txt_noGuild:SetShow(true)
    self._ui.txt_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDPOINT_STATE_READY"))
    self._ui.txt_state:SetShow(true)
    self._ui.stc_guildIconBg:SetShow(false)
    self._ui.txt_voteValue:SetShow(false)
    self._ui.txt_guildName:SetShow(false)
    self._ui.txt_guildLeaderName:SetShow(false)
    self._ui.txt_voteValue:SetText(tostring(0))
    self:calcPos()
    return
  end
  self._ui.txt_noGuild:SetShow(false)
  self._ui.stc_guildIconBg:SetShow(true)
  self._ui.txt_state:SetShow(false)
  self._ui.txt_voteValue:SetShow(true)
  self._ui.txt_guildName:SetShow(true)
  self._ui.txt_guildLeaderName:SetShow(true)
  local isSet = false
  if false == guildInfo:isAllianceGuild() then
    self._ui.txt_guildName:SetText(tostring(guildInfo:getName()))
    isSet = setGuildTextureByGuildNo(guildInfo:getGuildNo_s64(), self._ui.stc_guildIcon)
  else
    local allianceInfo = ToClient_GetGuildAllianceWrapperbyNo(guildNo)
    if nil ~= allianceInfo then
      self._ui.txt_guildName:SetText(tostring(allianceInfo:getRepresentativeName()))
    end
    isSet = setGuildTextureByAllianceNo(guildInfo:getGuildNo_s64(), self._ui.stc_guildIcon)
  end
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if false == isSet then
    self._ui.stc_guildIcon:getBaseTexture():setUV(0, 0, 1, 1)
    self._ui.stc_guildIcon:setRenderTexture(self._ui.stc_guildIcon:getBaseTexture())
  end
  self._ui.stc_guildIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_guildIcon:setRenderTexture(self._ui.stc_guildIcon:getBaseTexture())
  self._ui.txt_guildLeaderName:SetText(tostring(guildInfo:getGuildMasterName()))
  self._ui.txt_voteValue:SetText(tostring(ToClient_GetVoteCount(self.territoryIndex[self._selectTerritoryKey])))
  self:calcPos()
end
function PaGlobal_Guild_Point:setVoteResult(territoryKey)
  if nil == PaGlobal_Guild_Point then
    return
  end
  if territoryKey ~= self.territoryIndex[self._selectTerritoryKey] then
    return
  end
  self._ui.txt_voteValue:SetText(tostring(ToClient_GetVoteCount(territoryKey)))
  self:calcPos()
end
function PaGlobal_Guild_Point:calcPos()
  if nil == PaGlobal_Guild_Point then
    return
  end
  local centerPosX = self._ui.stc_circleArea:GetSizeX() / 2
  centerPosX = centerPosX - (self._ui.txt_voteValue:GetSizeX() + self._ui.txt_voteValue:GetTextSizeX() + 8) / 2
  self._ui.txt_voteValue:SetPosX(centerPosX)
  centerPosX = self._ui.stc_resultBG:GetSizeX() / 2
  centerPosX = centerPosX - (self._ui.txt_resultVote:GetSizeX() + self._ui.txt_resultVote:GetTextSizeX() + 8) / 2
  self._ui.txt_resultVote:SetPosX(centerPosX)
  centerPosX = self._ui.btn_vote:GetSizeX() / 2
  centerPosX = centerPosX - (self._ui.txt_voteBtnName:GetSizeX() + self._ui.txt_voteBtnName:GetTextSizeX() + 8) / 2
  self._ui.txt_voteBtnName:SetPosX(centerPosX)
end
function PaGlobal_Guild_Point:openMouseGuide(isShow)
  if nil == PaGlobal_Guild_Point then
    return
  end
  if false == isShow then
    self._ui.stc_mouseGuide:SetShow(false)
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil ~= selfPlayerWrapper then
    local occupyGuildNo = Int64toInt32(ToClient_RequestTerritoryGuildNo(self.territoryIndex[self._selectTerritoryKey]))
    local guildNo = Int64toInt32(selfPlayerWrapper:getGuildNo_s64())
    local alliacneNo = Int64toInt32(selfPlayerWrapper:getGuildAllianceNo_s64())
    if 0 == guildNo and 0 == alliacneNo or 0 ~= alliacneNo and occupyGuildNo ~= alliacneNo or 0 ~= guildNo and occupyGuildNo ~= guildNo then
      self._ui.stc_mouseGuide:SetShow(false)
      return
    end
  end
  local panel
  if nil ~= Panel_Tooltip_SkillGroup_forLearning and true == Panel_Tooltip_SkillGroup_forLearning:GetShow() then
    panel = Panel_Tooltip_SkillGroup_forLearning
  elseif nil ~= Panel_Tooltip_SkillGroup and true == Panel_Tooltip_SkillGroup:GetShow() then
    panel = Panel_Tooltip_SkillGroup
  end
  if nil == panel then
    self._ui.stc_mouseGuide:SetShow(false)
  else
    local posX = panel:GetPosX()
    local posY = panel:GetPosY()
    posX = panel:GetPosX() - Panel_Guild_Point:GetPosX()
    posY = panel:GetPosY() - Panel_Guild_Point:GetPosY() - PaGlobal_Guild_Point._ui.stc_mouseGuide:GetSizeY() - 10
    self._ui.stc_mouseGuide:SetPosXY(posX, posY)
    self._ui.stc_mouseGuide:SetShow(true)
  end
end
function PaGlobal_Guild_Point:setProcess(guildPoint, guildPointWeek)
  if nil == Panel_Guild_Point then
    return
  end
  local point = 0
  if 0 ~= guildPointWeek then
    self._ui.stc_progress:SetProgressRate(guildPoint / guildPointWeek * 100)
    point = string.format("%.0f", guildPoint / guildPointWeek * 100)
  else
    self._ui.stc_progress:SetProgressRate(0)
    point = string.format("%.0f", 0)
  end
  self._ui.txt_guildPointExp:SetText(tostring(point) .. " %")
end
function PaGlobal_Guild_Point:validate()
  if nil == Panel_Guild_Point then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_leftArea:isValidate()
  self._ui.stc_circleArea:isValidate()
  self._ui.stc_progress:isValidate()
  self._ui.txt_guildPoint:isValidate()
  self._ui.txt_guildPointExp:isValidate()
  self._ui.txt_territoryName:isValidate()
  self._ui.stc_leftArea:isValidate()
  self._ui.stc_resultBG:isValidate()
  self._ui.txt_resultTerritoryName:isValidate()
  self._ui.txt_resultVote:isValidate()
  self._ui.txt_voteBtnName:isValidate()
  self._ui.stc_mouseGuide:isValidate()
  for ii = 1, self._MAX_RANK do
    self._ui.stc_rankList[ii]:isValidate()
  end
end
