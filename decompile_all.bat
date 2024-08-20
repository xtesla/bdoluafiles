for /r %%v in (*.luac) do java -jar unluac_v3.jar %%v > %%vx
rename *.luacx *.lua
pause