PaGlobal_HorseRacing_KeyGuide = {
  _ui = {_txt_Desc = nil},
  _isInitialized = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_KeyGuideInit")
function FromClient_HorseRacing_KeyGuideInit()
  PaGlobal_HorseRacing_KeyGuide:initialize()
end
function PaGlobal_HorseRacing_KeyGuide:initialize()
end
function PaGlobal_HorseRacing_KeyGuide:validate()
end
function PaGlobal_HorseRacing_KeyGuide:prepareOpen()
  PaGlobal_HorseRacing_KeyGuide:open()
end
function PaGlobal_HorseRacing_KeyGuide:open()
  Panel_HorseRacing_KeyGuide:SetShow(true)
end
function PaGlobal_HorseRacing_KeyGuide:prepareClose()
  self:close()
end
function PaGlobal_HorseRacing_KeyGuide:close()
  Panel_HorseRacing_KeyGuide:SetShow(false)
end
function PaGlobal_HorseRacing_KeyGuide_Open()
  PaGlobal_HorseRacing_KeyGuide:prepareOpen()
end
function PaGlobal_HorseRacing_KeyGuide_Close()
  PaGlobal_HorseRacing_KeyGuide:prepareClose()
end
