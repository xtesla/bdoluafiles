function PaGlobal_Guild_Create_All:initialize()
  if true == PaGlobal_Guild_Create_All._initialize then
    return
  end
  PaGlobal_Guild_Create_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Guild_Create_All:controlAll_Init()
  PaGlobal_Guild_Create_All:controlPc_Init()
  PaGlobal_Guild_Create_All:controlConsole_Init()
  PaGlobal_Guild_Create_All:SetUiSetting()
  PaGlobal_Guild_Create_All._isConfirm = false
  if true == PaGlobal_Guild_Create_All._isConsole then
    local tempBtnGroup = {
      PaGlobal_Guild_Create_All._ui_console.btn_duplication_console,
      PaGlobal_Guild_Create_All._ui_console.btn_confirm,
      PaGlobal_Guild_Create_All._ui_console.btn_close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, PaGlobal_Guild_Create_All._ui_console.stc_bottomBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_Guild_Create_All:registEventHandler()
  PaGlobal_Guild_Create_All:validate()
  PaGlobal_Guild_Create_All:setGuildDese()
  PaGlobal_Guild_Create_All._initialize = true
end
function PaGlobal_Guild_Create_All:controlAll_Init()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui.stc_nameBg = UI.getChildControl(Panel_Guild_Create_All, "Static_NameBg")
  PaGlobal_Guild_Create_All._ui.stc_guildName = UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_nameBg, "Edit_GuildName")
  PaGlobal_Guild_Create_All._originGuildNameEditSizeX = PaGlobal_Guild_Create_All._ui.stc_guildName:GetSizeX()
  local guildBg = UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_nameBg, "StaticText_GuildBg")
  PaGlobal_Guild_Create_All._ui.stc_guildDesc = UI.getChildControl(guildBg, "StaticText_GuildDesc")
end
function PaGlobal_Guild_Create_All:controlPc_Init()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui_pc.btn_close = UI.getChildControl(Panel_Guild_Create_All, "Button_Close_PCUI")
  PaGlobal_Guild_Create_All._ui_pc.btn_confirm = UI.getChildControl(Panel_Guild_Create_All, "Button_Confirm_PCUI")
  PaGlobal_Guild_Create_All._ui_pc.btn_cancle = UI.getChildControl(Panel_Guild_Create_All, "Button_Cancel_PCUI")
  PaGlobal_Guild_Create_All._ui_pc.btn_duplication_pc = UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_nameBg, "Button_Duplication")
end
function PaGlobal_Guild_Create_All:controlConsole_Init()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui_console.stc_bottomBg = UI.getChildControl(Panel_Guild_Create_All, "Static_BottomBg_ConsoleUI")
  PaGlobal_Guild_Create_All._ui_console.btn_confirm = UI.getChildControl(PaGlobal_Guild_Create_All._ui_console.stc_bottomBg, "StaticText_A_ConsoleUI")
  PaGlobal_Guild_Create_All._ui_console.btn_close = UI.getChildControl(PaGlobal_Guild_Create_All._ui_console.stc_bottomBg, "StaticText_B_ConsoleUI")
  PaGlobal_Guild_Create_All._ui_console.btn_duplication_console = UI.getChildControl(PaGlobal_Guild_Create_All._ui_console.stc_bottomBg, "StaticText_Y_ConsoleUI")
end
function PaGlobal_Guild_Create_All:SetUiSetting()
  if false == PaGlobal_Guild_Create_All._isConsole then
    Panel_Guild_Create_All:SetSize(Panel_Guild_Create_All:GetSizeX(), PaGlobal_Guild_Create_All._pcPanelSizeY)
    PaGlobal_Guild_Create_All._ui_pc.btn_close:SetShow(true)
    PaGlobal_Guild_Create_All._ui_pc.btn_confirm:SetShow(true)
    PaGlobal_Guild_Create_All._ui_pc.btn_cancle:SetShow(true)
    PaGlobal_Guild_Create_All._ui_pc.btn_duplication_pc:SetShow(true)
    PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:SetShow(false)
    PaGlobal_Guild_Create_All._ui.stc_guildName:SetSize(PaGlobal_Guild_Create_All._originGuildNameEditSizeX, PaGlobal_Guild_Create_All._ui.stc_guildName:GetSizeY())
    UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_guildName, "StaticText_X_ConsoleUI"):SetShow(false)
    UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_guildName, "Static_TextIcon"):SetShow(false)
    PaGlobal_Guild_Create_All._ui.stc_nameBg:SetSize(PaGlobal_Guild_Create_All._ui.stc_nameBg:GetSizeX(), PaGlobal_Guild_Create_All._consolePanelSizeY)
  else
    Panel_Guild_Create_All:SetSize(Panel_Guild_Create_All:GetSizeX(), PaGlobal_Guild_Create_All._consolePanelSizeY + PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:GetSizeY())
    PaGlobal_Guild_Create_All._ui_pc.btn_close:SetShow(false)
    PaGlobal_Guild_Create_All._ui_pc.btn_confirm:SetShow(false)
    PaGlobal_Guild_Create_All._ui_pc.btn_cancle:SetShow(false)
    PaGlobal_Guild_Create_All._ui_pc.btn_duplication_pc:SetShow(false)
    local bottomBgPosY = PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:GetPosY()
    PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:SetShow(true)
    PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:SetPosY(bottomBgPosY + 5)
    local guildBg = UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_nameBg, "StaticText_GuildBg")
    PaGlobal_Guild_Create_All._ui.stc_guildName:SetSize(guildBg:GetSizeX(), PaGlobal_Guild_Create_All._ui.stc_guildName:GetSizeY())
    UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_guildName, "StaticText_X_ConsoleUI"):ComputePos()
    UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_guildName, "StaticText_X_ConsoleUI"):SetShow(true)
    UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_guildName, "Static_TextIcon"):SetShow(true)
  end
end
function PaGlobal_Guild_Create_All:registEventHandler()
  if nil == Panel_Guild_Create_All then
    return
  end
  registerEvent("FromClient_notifyChangeNameResult", "FromClient_NotifyChangeNameResult")
  registerEvent("onScreenResize", "FromClient_Guild_Create_All_onScreenResize")
  if false == PaGlobal_Guild_Create_All._isConsole then
    PaGlobal_Guild_Create_All._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_Create_All_Close()")
    PaGlobal_Guild_Create_All._ui_pc.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Create_All_clickedConfirm()")
    PaGlobal_Guild_Create_All._ui_pc.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Create_All_clickedCancel()")
    PaGlobal_Guild_Create_All._ui_pc.btn_duplication_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_Check_Duplication()")
  else
    Panel_Guild_Create_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Guild_Create_All_clickedConfirm()")
    Panel_Guild_Create_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "Input_Guild_Create_All_setFocus()")
    Panel_Guild_Create_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Check_Duplication()")
    PaGlobal_Guild_Create_All._ui.stc_guildName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_Guild_Create_All_HideVirtualKeyboard")
  end
end
function PaGlobal_Guild_Create_All:prepareOpen()
  if nil == Panel_Guild_Create_All then
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  if nil == PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange then
    return
  end
  local isAppliedNickNameChange = PaGlobal_ChangeNickName_All_CheckAndOpenQuickNameChange()
  if false == isAppliedNickNameChange then
    return
  end
  PaGlobal_Guild_Create_All._isValidGuildName = false
  PaGlobal_Guild_Create_All._checkedValidGuildName = ""
  PaGlobal_Guild_Create_All._ui.stc_guildName:SetEditText("")
  PaGlobal_Guild_Create_All._ui.stc_guildName:SetMaxInput(getGameServiceTypeGuildNameLength())
  if true == PaGlobal_Guild_Create_All._isConsole then
    ToClient_padSnapChangeToTarget(PaGlobal_Guild_Create_All._ui_console.btn_confirm)
  end
  PaGlobal_Guild_Create_All:open()
end
function PaGlobal_Guild_Create_All:open()
  if nil == Panel_Guild_Create_All then
    return
  end
  Panel_Guild_Create_All:SetShow(true)
end
function PaGlobal_Guild_Create_All:prepareClose()
  if nil == Panel_Guild_Create_All then
    return
  end
  if false == PaGlobal_Guild_Create_All._isConfirm and PaGlobal_Guild_Create_All._isConsole then
    _AudioPostEvent_SystemUiForXBOX(50, 3)
  end
  PaGlobal_Guild_Create_All:close()
end
function PaGlobal_Guild_Create_All:close()
  if nil == Panel_Guild_Create_All then
    return
  end
  Panel_Guild_Create_All:SetShow(false)
end
function PaGlobal_Guild_Create_All:update()
  if nil == Panel_Guild_Create_All then
    return
  end
end
function PaGlobal_Guild_Create_All:validate()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All:allValidate()
  PaGlobal_Guild_Create_All:pcValidate()
  PaGlobal_Guild_Create_All:consoleValidate()
end
function PaGlobal_Guild_Create_All:allValidate()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui.stc_nameBg:isValidate()
  PaGlobal_Guild_Create_All._ui.stc_guildName:isValidate()
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:isValidate()
end
function PaGlobal_Guild_Create_All:pcValidate()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui_pc.btn_duplication_pc:isValidate()
  PaGlobal_Guild_Create_All._ui_pc.btn_close:isValidate()
  PaGlobal_Guild_Create_All._ui_pc.btn_confirm:isValidate()
  PaGlobal_Guild_Create_All._ui_pc.btn_cancle:isValidate()
end
function PaGlobal_Guild_Create_All:consoleValidate()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:isValidate()
  PaGlobal_Guild_Create_All._ui_console.btn_confirm:isValidate()
  PaGlobal_Guild_Create_All._ui_console.btn_close:isValidate()
  PaGlobal_Guild_Create_All._ui_console.btn_duplication_console:isValidate()
end
function PaGlobal_Guild_Create_All:setGuildDese()
  if nil == Panel_Guild_Create_All then
    return
  end
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:SetTextMode(__eTextMode_AutoWrap)
  local defaultNameDecs = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_POPUP_1_PARAM", "min", tostring(getGameServiceTypeNameMinLength()), "max", tostring(getGameServiceTypeGuildNameLength()))
  local txt_NameDesc = defaultNameDecs
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
    txt_NameDesc = defaultNameDecs .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  else
    txt_NameDesc = defaultNameDecs
  end
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:SetText(txt_NameDesc)
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:SetSize(PaGlobal_Guild_Create_All._ui.stc_guildDesc:GetSizeX(), PaGlobal_Guild_Create_All._ui.stc_guildDesc:GetTextSizeY())
  local paddingY = 20
  local guildBgControl = UI.getChildControl(PaGlobal_Guild_Create_All._ui.stc_nameBg, "StaticText_GuildBg")
  local originGuildBgSizeY = guildBgControl:GetSizeY()
  guildBgControl:SetSize(guildBgControl:GetSizeX(), PaGlobal_Guild_Create_All._ui.stc_guildDesc:GetSizeY() + paddingY)
  local changedSizeY = guildBgControl:GetSizeY() - originGuildBgSizeY
  local editNameSizeY = PaGlobal_Guild_Create_All._ui.stc_guildName:GetSizeY()
  local guildBgSizeY = guildBgControl:GetSizeY()
  local newNameBgSizeY = editNameSizeY + guildBgSizeY + paddingY * 4
  PaGlobal_Guild_Create_All._ui.stc_nameBg:SetSize(PaGlobal_Guild_Create_All._ui.stc_nameBg:GetSizeX(), newNameBgSizeY)
  local originPanelY = Panel_Guild_Create_All:GetSizeY()
  Panel_Guild_Create_All:SetSize(Panel_Guild_Create_All:GetSizeX(), originPanelY + changedSizeY)
  if false == PaGlobal_Guild_Create_All._isConsole then
    local originConfirmBtnSpanSizeY = PaGlobal_Guild_Create_All._ui_pc.btn_confirm:GetSpanSize().y
    local originCancleBtnSpanSizeY = PaGlobal_Guild_Create_All._ui_pc.btn_cancle:GetSpanSize().y
    PaGlobal_Guild_Create_All._ui_pc.btn_confirm:SetSpanSize(PaGlobal_Guild_Create_All._ui_pc.btn_confirm:GetSpanSize().x, originConfirmBtnSpanSizeY + changedSizeY)
    PaGlobal_Guild_Create_All._ui_pc.btn_cancle:SetSpanSize(PaGlobal_Guild_Create_All._ui_pc.btn_cancle:GetSpanSize().x, originCancleBtnSpanSizeY + changedSizeY)
  end
  Panel_Guild_Create_All:ComputePos()
  if true == PaGlobal_Guild_Create_All._isConsole then
    PaGlobal_Guild_Create_All._ui_console.stc_bottomBg:ComputePos()
    PaGlobal_Guild_Create_All._ui_console.btn_confirm:ComputePos()
    PaGlobal_Guild_Create_All._ui_console.btn_close:ComputePos()
    PaGlobal_Guild_Create_All._ui_console.btn_duplication_console:ComputePos()
  else
  end
  PaGlobal_Guild_Create_All._ui.stc_nameBg:ComputePos()
  PaGlobal_Guild_Create_All._ui.stc_guildName:ComputePos()
  guildBgControl:ComputePos()
  PaGlobal_Guild_Create_All._ui.stc_guildDesc:ComputePos()
end
