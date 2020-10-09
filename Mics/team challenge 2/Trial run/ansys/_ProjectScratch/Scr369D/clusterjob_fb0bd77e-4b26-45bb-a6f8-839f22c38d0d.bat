@ECHO OFF
SETLOCAL
CHCP 65001
ECHO Job started on %COMPUTERNAME%
SET /A errno=0
ECHO ClusterSharedDirectory=C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D
IF NOT EXIST "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\." goto NOSTAGINGDIR
ECHO AWP_ROOT201=%AWP_ROOT201%
IF "%AWP_ROOT201%" == "" GOTO NOAWPROOTENV
IF NOT EXIST "%AWP_ROOT201%\." goto NOAWPROOTDIR
ECHO Command=%AWP_ROOT201%/commonfiles/CPython/3_7/winx64/Release/python/python.exe
IF NOT EXIST "%AWP_ROOT201%/commonfiles/CPython/3_7/winx64/Release/python/python.exe" goto NOCOMMAND
ECHO running the commmand
ECHO command: "%AWP_ROOT201%/commonfiles/CPython/3_7/winx64/Release/python/python.exe" -B -E "%AWP_ROOT201%/RSM/Config/scripts/ClusterJobs.py" "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\control_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsm"
"%AWP_ROOT201%/commonfiles/CPython/3_7/winx64/Release/python/python.exe" -B -E "%AWP_ROOT201%/RSM/Config/scripts/ClusterJobs.py" "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\control_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsm"
IF %ERRORLEVEL% NEQ 0 SET /A errno=%ERRORLEVEL%
GOTO END
:NOAWPROOTENV
ECHO The AWP_ROOT201 environment variable was NOT detected.
ECHO 1000 > "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\exitcode_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsmout"
SET /A errno=1000
GOTO END
:NOCOMMAND
ECHO Command was NOT detected on execution host.
ECHO 1007 > "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\exitcode_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsmout"
SET /A errno=1007
GOTO END
:NOSTAGINGDIR
ECHO Shared cluster directory does not exist on execution node, make sure it is shared and can be accessed from all nodes.
ECHO 1008 > "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\exitcode_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsmout"
SET /A errno=1008
GOTO END
:NOAWPROOTDIR
ECHO AWP_ROOT201 directory does not exist on execution host.
ECHO 1009 > "C:\Users\mende\Documents\repos\team_18\team challenge 2\Trial run\ansys\_ProjectScratch\Scr369D\exitcode_fb0bd77e-4b26-45bb-a6f8-839f22c38d0d.rsmout"
SET /A errno=1009
GOTO END
:END
EXIT /B %errno%
