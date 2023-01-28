# Detailed Explanation of PECMD in WinPE - PECMD.INI File Configuration

---

> Taken from:
>
> - https://www.isunshare.com/blog/detailed-explanation-for-pecmd-in-winpe-pecmd-ini-file-configuration-1/
> - https://www.isunshare.com/blog/detailed-explanation-for-pecmd-in-winpe-pecmd-ini-file-configuration-2/
>
> Looks like this has been taken from somewhere else, but couldn't find a
> friendlier resource for archiving, formatting and reading.

---

At present, most domestic WinPE systems are supported by a core software which
is pecmd.exe (referred to a command line interpretive program), and there are
more than 70 items in it.

## 1. Command category

### 1.1 Commonly used command line

### 1.2 Window controls, subroutine command

#### 1.2.1 System variables

- `CurDir` = Current Directory
- `Desktop` = Desktop
- `Favorites` = Favorites
- `Personal` = My Documents
- `Programs` = Programs
- `Send To` = Sent To
- `Start` = Start Menu
- `Startup` = Automatic Operation
- `Quick Launch` = Quick Launch Bar
- `System Driver` = System Partition
- `System Root` = System Folder

#### 1.2.2 Commonly used controls

`ComboBox`, `Button`, `Picture`, `CheckBox`, `HotKey`, `PopupMenu`, `Progress`,
`BarGroup`, `Static`, `Timer`, `Radio`, `CHEK`, `Menu`, `LABE`, `EDIT`, `GROU`,
`IMAG`, `ITEM`, `MEMO`, `PBAR`, `TIME`, `RADI`

### 1.3 Character string, character control

`LPOS`, `LSTR`, `MSTR`, `RPOS`, `RSTR`, `STRL`

### 1.4 Window, subroutine sign

`_END`, `_SUB`

### 1.5 Commonly used commands

`BROW`, `CALC`, `CALL`, `DATE`, `DEVI`, `DISP`, `EJEC`, `ENVI`, `EXEC`, `EXIT`,
`FBWF`, `FDIR`, `FDRV`, `FEXT`, `FILE`, `FIND`, `FONT`, `FORX`, `HELP`, `HKEY`,
`HOTK`, `IFEX`, `INIT`, `KILL`, `LINK`, `LIST`, `LOAD`, `LOGO`, `LOGS`, `MAIN`,
`MD5C`, `MENU`, `MESS`, `MOUN`, `NAME`, `NUMK`, `PAGE`, `PATH`, `RAMD`, `REGI`,
`RUNS`, `SEND`, `SERV`, `SHEL`, `SHOW`, `SHUT`, `SITE`, `SUBJ`, `TEAM`, `TEMP`,
`TEXT`, `TIPS`, `UPNP`

#### [_SUB]

- Format: `_SUB <sub-process name> or _SUB <window name>, <window shape>, [window title], [window event], [window icon], [window type]`
- Function: define a sub-process or define a window.

Parameters:

- Sub-procedure name: character string
- Window name: character string. Window name should be unique and can not be
/gcsame as other control names or environment variable names.
- Window title: text
- Window shape: window position and size. The format is <LTWH>, in which L
/gcstands for Left, T for Top, W for Width, H for Hight. And all of them are
/gcnumerical values. Besides, if the Left and Top are omitted, the window will
/gcbe centered.
- Window event: The command is executed when closing the window. And it must be
/gca command supported by PECMD.EXE.
- Window icon: icons in the window title bar and taskbar. Its format is < icon
/gcfile name # ID>
- Window type: [ – ] [ # ] [ value ]. ” – ” stands for no title bar, “# ” for
/gcthe chromeless window, and value for transparency. Moreover, value higher
/gcthan 99 is hidden window.

Example:

- `_SUB` DoLoop
- `_SUB` Windows1, W360H440, PECMD function demonstration, EXEC $instructions,
/gcTXT,%IconFile%#19,20

Remarks:

- The first character of sub-process name or window name can not be a “$”. And
/gcthere must be a space between the command keyword `_SUB` and the sub-process
/gcname or window name.
- If there are multiple `_SUB` commands, names used for defining the commands
/gccan not be repeated and approximated. These names can not be set as
/gcenvironment variables.
- This command must come in pair with `_END` command. And both of them can not
/gcbe used in the command line. For other information, please refer to the
/gcillustration of `_END` command and CALL command.
- To set the window title, you can use the “ENVI @window name=window title”.
/gcPlease make reference to the explanation of ENVI command.

#### [_END]

- Format: `_END`
- Function: End sub procedure or window definition.

Parameters:

-/gcNo

Example:

- `_END`

Remarks:

- When defining sub-process’s `_SUB` command and `_END` command, they must be a
/gcseparate line. In other words, the FIND, IFEX, TEAM commands can not defined
/gcsub-process within them.
- The command between `_SUB` and `_END` ( i.e. sub-process ) can only be
/gcexecuted by the corresponding CALL command, while the main process will skip
/gcthese commands.
- `_END` command must match with `_SUB` command, and the sub-process can not
/gcdefine sub-process within it.
- The sub-process placed at any position of the configuration file can be
/gccalled by CALL command in the same configuration file. And it is suggested to
/gcput it at the beginning of the file.
- This command and `_SUB` command can only be used in the configuration file,
/gcand can not be used in the command line.

#### [BROW]

- Format: `BROW <variable name>, [[* | &]initial path], [tip text], [extensions]`
- Function: Browse disk files and directory.

Parameters:

- Variable Name: variable name used for saving the browse result
- Initial Path: Default the selected files or directory for the browser window.
/gcWhen this parameter is omitted, it will locate to the system default path.
/gcMoreover, leading character “*” represents directory browse dialog, the leading
/gccharacter “& ” stands for save file dialog, and omitting the leading character
/gcmeans open file dialog.
- Tip Text: It can be omitted. When it is omitted, the default text is the
/gcsystem default tip text.
- Extension: Browse the specified file’s extension. If it is omitted, the file
/gcrepresents all files.

Example:

- BROW Boot_Ini, C: \ Windiws \ BOOT.INI, please select a file, INI
- BROW Tag, * C: \ Windiws, please select a directory

Remarks:

- This command opens a file directory browsing dialog box, allowing users to
/gcbrowse the disk file directory. And the user can select certain file or
/gcdirectory.
- Selection result will be saved in the specified process environment variable.
/gcExample 2 can be referenced through the environment variable %Tag%.
- BROW command must be executed after the INIT command or on the desktop .

#### [CALC]

- Format: `CALC [#] <variable 0><=><variable 1><operator> <variable 2>`
- Function: Operate “variable 1” and “variable 2” as “operator “, and store the
/gcoperation result in the “variable 0”.

Parameters:

- Leading character “#” indicates that all variables are managed according to
/gcint data type. If the leading character is omitted, it indicates that all
/gcvariables are managed according to double data type.
- “Variable 1” and “variable 2″ can be specific values, or existing variables.
- ” Operator” currently only supports four kinds of operations including/gc“+ “,
/gc” – “, “* “, “/ “.

Example:

- Add operation: CALC #Sum = 128 + 32 or CALC Sum =%Datum1% +%Datum2%
- Multiplication: CALC #Result = 128 * 64 or CALC Result =%Datum1% * %Datum2%

Remarks:

- “Variable 1” or “variable 2” can be directly set by ENVI command (referred to
/gcassignment), or be the result of assignment operated by CALC command.
- When “variable 1” or “variable 2” has no assignment, it can be processed as
/gcvalue “0”. To complete complex four arithmetic operation, you can use a
/gcseries of CACL commands.
- When CACL command uses double type variables to process data, up to four
/gcdecimal places can be reserved. Moreover, to compare the numerical size, IFEX
/gccommand can be used.

#### [CALL]

- Format: `CALL <$DLL name>, [function], [[#]parameter 1], [[#]parameter 2], [[#]parameter 3], [[#]parameter 4] or CALL <process> or CALL <@ window>`
- Function: Calling DLL function or subprocess.

Parameters:

- Leading character “$” indicates calling DLL functions, specifying DLL path,
/gcfunction name and parameters. If the function name is omitted,
/gc“DllRegisterServer” will be called, and parameters are defaulted as UNICODE
/gcstring. If the leading character of parameters is “#”, it indicates integer.
/gcAnd up to four function parameters are supported.
- Leading character “@” indicates calling a window defined by the `_SUB`
/gccommand. Don’t execute CALL @another window in the window defined by the
/gc`_SUB` command.
- If the leading character “$” is omitted, it indicates calling sub-process,
/gcand the parameters are the names of subprocesses.

Example:

- Call DLL function: CALL $ SHELL32.DLL, DllInstall, # 1, U
- Call window procedure: CALL @ Window1
- Call subprocess: FIND MEM> 127, CALL EXPLORER_SHELL! CALL CMD_SHELL

Remarks:

- Call DLL functions : Functions in DLL must be exported in the way of STDCALL.
/gc(If you do not understand what it means, you can take it as no problem.)
- Call window procedure: When using CALL’s leading character “@ ” to call a
/gcwindow, the execution of the commands after CALL command will be suspended
/gcuntil the window is closed.
- Call subprocess: CALL command can only invoke sub-processes in the same
/gcconfiguration file, and its function of calling sub-process can not be used
/gcin the command line. As for other information, please refer to illustration of
/gc`_SUB` and `_END` commands.

#### [CHEK]

- Format: `CHEK < check box name >, < check box shape >, [ check box title ], [
/gccheck box event ], [ check box state ];`
- Function: Establish a check box control in a window defined by `_SUB`.

Parameters:

- Check box name: string. The check box name should be unique, and can not be
/gcsame as other controls’ names or environment variables’ names.
- Check box shape: check box’s location and size. Format : <LTWH>./gcL stands
/gcfor Left, T for Top, W for Width, H for Hight. And all of them are numerical
/gcvalues.
- Check box Title: It is the text on the check box, and the text is used to
/gcdescribe the check box’s function or description.
- Check box event: When clicking the check box, the command executed must be a
/gcvalid command supported by PECMD.
- Check box state: numbers. 1 or -1 stands for checked state, 0, 2 or -2 for
/gcnot checked state, and less than 0 for gray unavailable state.

Example:

- CHEK Check1, L180T336W100H20, writable mount , 1

Remarks:

- CHEK command must locate between `_SUB` command and `_END` command. CHEK
/gccommand located at other places is invalid. Please refer to the descriptions
/gcof `_SUB` and CALL commands.
- Environment variables: %check box name% is the check box title. To set the
/gctitle, you can use “ENVI @check box name=check box title” .
- Use “ENVI @check box name. Check=numerical value” to set the check box
/gcchecked state. If the value is 0, the check box state is not checked state.
/gcWhile non-zero value represents checked state.
- Use “ENVI @check box name. Enable=numerical value” to set the check box’s
/gcavailable state. 0 stands for disabled state, while non-zero value represents
/gcavailable state.

#### [DATE]

- Format: `DATE [ variable name ]; Function: Return to the current date and time of system`

Parameters:

- Variable name: save the variable names of system’s current date and time

Example:

- DATE SysDate

Remarks:

- The result is saved as ” Year – Month – Day | Week | Hour: Minute: Second” in
/gcthe specified variable. To remove the ” date” or “time” , please use string
processing commands of PECMD (LPOS, RPOS, LSTR, MSTR, RSTR) to deal with.
- If the ” variable names ” is omitted, the result is stored in the environment
/gcvariable %CurDate%. Then the example results may be “2008-8-8 | 5 | 20:8:8”.

#### [DEVI]

- Format: `DEVI [$] <CAB path>`
- Function: Find (and install ) driver from a CAB file or the specified folder.

Parameters:

- Specified CAB file path. The leading character “$” means installing the
/gcdriver after extracting driver file. Otherwise, do not install the driver.

Example:

- DEVI %SystemRoot% \ DRV.CAB

Remarks:

- This command uses the custom driven search algorithm (rather than the
/gcsystem’s), which can quickly extract the drive programs that may be used.
/gcTherefore , a device can search for multiple drivers.
- In the CAB , put each driver in a separate directory, and ensure that the INF
/gcfile in CAB is always located at the beginning of the current directory.
/gcMeanwhile, the INF file in CAB must be processed. And it is recommended to use
/gcmatching program XCAB to make.
- INF files are extracted to the “%SystemRoot%\INF” directory, SYS files are
/gcextracted to %SystemRoot%\SYSTEM32\DRIVERS directory, and other files are
/gcextracted to %SystemRoot%\SYSTEM32 directory.
- If other files need to be extracted to specified directories, you can use “#”
/gcin the file name to replace directory separators. For example, the file,
/gc“SYSTEM32#WBEM#MOF#XXX.MOF”, will be extracted to the directory of “%
/gcSystemRoot% \ SYSTEM32 \ WBEM \ MOF \ XXX.MOF”.
- Another function of the command: Search drivers in the local disks. e.g.
/gc“DEVI \ Windows, Display”. However, this command is not perfect, and it will
/gcprompt driver file dialog box. Therefore, this function temporarily provides no
/gctechnical support.

#### [DISP]

- Format: `DISP [W horizontal resolution H vertical resolution] [B color depth ] [F refresh rate] [T wait(ms)]`
- Function: Set the display parameters.

Parameters:

- Separately specify screen parameters. If omitted, use the original settings.

Example:

- DISP W1024 H768 B32 F70 T5000

Remarks:

- The first three sets of parameters can be used alone. For example, to set the
/gcrefresh rate as 75 , you can use DISP F75 .

#### [EDIT]

- Format: `EDIT < edit box name >, < edit box shape >, [ edit box content ], [ edit box event ], [ edit box type ]`
- Function: Establish a single line text edit box in the window defined by `_SUB` command.

Parameters:

- Edit box name: String. Edit box name should be unique, and can not be same as
/gcother controls’ names or environment variables’ names.
- Edit box shape: edit box’s position and size./gcFormat : <LTWH>.  L stands for
/gcLeft, T for Top, W for Width, H for Hight. And all of them are numerical
/gcvalues.
- Edit box contents: string. The text filled when initializing the edit box.
- Edit box events: The command which is executed by pressing the Enter key in
/gcthe edit box. And it must be a valid command supported by PECMD.
- Edit box type: number. The default value is 0, representing normal edit box;
/gcvalue greater than 0 indicates password input box; value less than 0 means
/gcgray disabled edit box.

Example:

- EDIT Edit1, L32T244W240H24, C: \ Windows, ENVI @ Label1 =% Edit1%

Remarks:

- EDIT command must be located between `_SUB` command and `_END` command. EDIT
/gccommand placed at other locations is invalid. Please refer to illustrations
/gcof `_SUB` and CALL commands.
- To set the text in the edit box, you can use “ENVI @edit box name = text
/gccontent”. Please make reference to explanation of ENVI command.
- Use “ENVI @edit box name. Enable = numerical value” to set the edit box’s
/gcavailable state. 0 represents unavailable state and non-zero value stands for
/gcavailable state.
- Use “ENVI @edit box name. ReadOnly =numerical value ” to set the edit box’s
/gcread-only status. 0 means non-read-only status, non-zero value is read-only
/gcstate.

#### [EJEC]

- Format: `EJEC [C-| U-| R:]`
- Function: Remove or eject the specified USB or CD ROM drive. The command’s function is not perfect.

Parameters:

- Parameter “C-” will eject all possible CD-ROM discs; parameter “U-” will
/gcremove all possible USB disks.
- Parameter “R:” will eject or remove the specified CD-ROM disks or USB
/gcdevices. If it is omitted, all possible CD-ROM disks or USB devices.

Example:

- EJEC
- EJEC C-
- EJEC U-
- EJEC H:

Remarks:

- This command is used in PE whose system tray has no U disk management icon.
/gcFor PE whose system tray has U disk management icon, it is suggested to use
/gcsystem tray icon.
- This command can not be used in the configuration file. The INIT command with
/gc“I” parameter will install the command’s function in the tray icon menu.

#### [ENVI]

- Format: `ENVI [$ | @ | *] [ name ] [ [ = ] value ]`
- Function: Set or clear environment variables.

Parameters:

- Specified the name and value of environment variable. If the leading
/gccharacter is omitted and a value is not specified, the environment variable
/gcis a variable whose specified name is deleted. .
- Leading character ” $ ” means setting system-level environment variable.
/gcWithout it, the command can only set the program’s internal used environment
/gcvariable ( process level ).
- Leading character ” @ ” indicates setting the name or title of window
/gccontrol.
- Leading character ” * ” (omitting the name and value) represents writing
/gcCD-ROM drive letter as CDROM0, CDROM, CDROM1, CDROM2 in system environment
/gcvariables.

Example:

- ENVI TEMP=%SystemDrive%\TEMP

Remarks:

- If the program executed by “EXEC” is used, the program’s environment
/gcvariables will be automatically inherited. In other words, if a “$ ”
/gcenvironment variable is set in the configuration file, it will be effective to
/gcthe “EXEC” program behind.
- Under the command prompt, you can use ENVI command without parameters to
/gcrefresh environment variables.
- When only parameter “$” exists, initialize the user folder. Under the command
/gcprompt,  environment variables can also be refreshed.

#### [EXEC]

- Format: `EXEC [=] [!] [@] [$] [&] <EXE path> [ parameters ]`
- Function: Execute EXE, BAT and CMD procedures.

Parameters:

- Specified program path and parameters. Leading parameters are as follows:
/gc(They can be used simultaneously, regardless of the order.)
- Leading character “=” means waiting for execution completion; the leading
/gccharacter ” ! ” means executing in hidden manner.
- Leading character “@” means executing in the background Desktop (WinLogon).
/gcThe execution is completely hidden and can not interact with the user, but it
/gccan be used for registration. e.g.
/gc`EXEC@PECMD.EXE CALL $ SHELL32.DLL,  DllInstall, # 1, U`.
- Leading character “&” indicates modifying process shutdown code (articulating
/gc“ExitWindowsEx” function). It is advised to execute “EXEC & EXPLORER.EXE” to
/gcmodify SHELL shutdown function. In this way, when executing “Start -> Shut down
/gcthe system”, it will run “PECMD.EXE SHUT” command to shut down the computer.
- Leading character “$” denotes executing by ShellExecute function to open
/gcnon-executable files such as TXT, BMP, etc.

Example:

- EXEC =! CMD.EXE /C “DEL /Q /F% TEMP%”

Remarks:

- SHELL is also loaded through this command.

#### [EXIT]

- Format: `EXIT`
- Function: Exit the current subprocess called by CALL command, or exit the configuration file process invoked by the LOAD command.

Parameters:

- No

Example:

- IFEX $%Val%=10, EXIT! ENVI Val =
- FIND $%CancelIt% =YES, EXIT! ENVI CancelIt =

Remarks:

- Example 1 indicates exiting the current process when the numerical value of
/gcthe numerical variable Val is 10.
- Example 2 indicates exiting the current process when CancelIt environment
/gcvariable is YES.

#### [FBWF]

- Format: `FBWF [P percentage of available memory] [L minimum value] [H maximum value]`
- Function: Set the FBWF cache

Parameters:

- Maximum value and minimum value are MB.

Example:

- FBWF P20 L32 H64

Remarks:

- Three parameters can be used alone. For example, FBWF L64 indicates
/gcmandatorily setting FBWF of 64M. Moreover, FBWF command must be used behind
/gcMOUN command.

#### [FDIR]

- Format: `FDIR < variable name > <= > < file name >`
- Function: Return to the directory name (no ” \ ” at the last) where the specified “file name” is.

Parameters:

- Variable name: variable name used to store directory name
- File name: valid file name

Example:

- FDIR fPath = C: \ Windows \ System32 \ calc.exe
- FDIR aPath =% CurDir% \ Path1 \ Path2 \ FileName

Remarks:

- When the file name is a relative path, the return value result is PECMD.EXE
/gcworking directory or configuration file’s working directory.
- The result of example 1 is “C: \ Windows \ System32”.
- The result of example 2 is “% CurDir% \ Path1 \ Path2”.

#### [FDRV]

- Format: `FDRV < variable name > <=> [ file directory name]`
- Function: Return to the partition letter (end with “:” and no ” \ ” at the
/gclast) where the specified ” file directory name” is or all system drive
/gcletters.

Parameters:

- Variable name: variable name used for saving partition letter
- File name: legitimate file directory name (It can be omitted. When omitted,
/gcit has other meaning. Please refer to the “Remarks” explanation.)

Example:

- FDRV fDrive=C: \ Windows \ System32 \ calc.exe
- FDRV AllDrive=

Remarks:

- When the file name is a relative path, the return value result is the
/gcpartition letter where the PECMD.EXE working directory or configuration
/gcfile’s working directory is.
- Return all system drive letter when omitting “file directory name”. The
/gcreturn value is in the form of C: | D: | E: | F: | …
- The result of example 1 is “C:”, and the result of example is a list of all
/gcsystem drive letters. (Please note that this list is not fixed and will
/gcchange at any time.)

#### [FEXT]

- Format: `FEXT < variable name > <= > < file name >`
- Function: Return to the extension (without “.” ) of the specified file name.

Parameters:

- Variable name: variable name used for saving the extension name
- File name: valid file name

Example:

- FEXT fExt = C: \ Windows \ System32 \ calc.exe
- FEXT aExt = X: \ Path1 \ Path2 \ FileName

Remarks:

- The result of example 1 is “exe”, while the result of example 2 is null value.
- The return value of FDIR, FDRV, FEXT can be detected or compared by using FIND command.

#### [FILE]

- Format: `FILE < file path > [ operator ] [ target path ]`
- Function: Operate file or directory

Parameters:

- Specified the source file path and destination path, supporting wildcards.
/gcYou can manipulate multiple files simultaneously with semicolons. Operator ”
/gc-> ” and “=> ” respectively correspond to move and copy, while no operators
/gcmeans deleting operation.

Example:

- FILE% SystemRoot% \ INF \ *. INF =>% TEMP%

Remarks:

- If a RAMDISK is used to boot the system, you can delete useless file like a
/gc2M NTOSKRNL.EXE after startup to increase writable space of the RAMDISK.

#### [FIND]

- Format: `FIND < condition > [ Command 1 ] [ ! Command 2 ]`
- Function: According to whether the conditional expression is established or not, execute command 1 if it is established; execute command 2 if it is not.

Parameters:

- Condition: judgment for [ total memory ], [ total disk space ], [ key ], [
/gcenvironment variables ] or [ memory process ]
- Total memory: MEM < comparison operator > value
- Total disk space: R: \ < comparison operator > value. “R:” represents the
/gcdrive letter .
- Keys: KEY < comparison operator > value
- Memory process: memory process name
- Environment variable: $%environment variable name% < comparison operator >
/gcenvironment variable value. The comparison of environment variables is not
/gccase-insensitive.
- Comparison operator: Comparison operators include “<“, “>” and “=” which
/gcrespectively indicates ” less than”, “greater than” and “equal”.
- Numerical values: values used for comparison. The unit for disk and memory is
/gcMB, and the key value is the key code.

Example:

- FIND MEM <128, SHEL% SystemRoot% \ SYSTEM32 \ XPLORER2.EXE! SHELL% SystemRoot% \ EXPLORER.EXE
- FIND $% OUTSIDE% =, ENVI $ OUTSIDE =% CurDrv% \ external program

Remarks:

- This command is very powerful and complex. It can be used by nesting FIND or
/gcIFEX to judge multiple conditions. The function of IFEX command is similar to
/gcthis command’s.
- The ” , ” after < conditional expression> can be replaced by ” * “.
- When this command is nesting FIND or IFEX command, the nested command can not
/gcuse the ” ! ” separator.
- When the FIND command is used to detect keys, if user presses keys of ‘A’ ~
/gc‘Z’ or ‘0 ‘ to ‘9 ‘, the key result will be stored in the environment
/gcvariable %PressKey%.

#### [FONT]

- Format: `FONT < font path >, [ initial partition ]`
- Function: Register font or external font.

Parameters:

- font file path and the initial partition

Example:

- FONT% CurDrv% \ external program \ FONT
- FONT \ WINDOWS
- FONT \ WINDOWS, C:

Remarks:

- When commanding the first character as ” \ “, this command will start from
/gcthe specified initial partition to search all fonts under all partitions’
/gcWindows \ Fonts directory, then install and register. Defining the initial
/gcpartition can avoid searching existing floppy drives of the computer. If the
/gcinitial partition is omitted, all partitions in the computer will be searched,
/gcincluding floppy disks.

#### [FORX]

- Format: `FORX [@] [[!] \] < File >, < variable > , [ value ] , < command > [ parameter, parameter … ] <% variable% > [ , parameter, parameter … ] [ , … ]`
- Function: matching file directory corresponding command operations, similar to the function of the command for command of CMD.EXE .

Parameters:

- File : specified the file directory name which can be with wildcards
/gccharacter
- Variable: specified variable name. It can not be the existed environment
/gcvariable or window control name.
- Value: It indicates executing command operation of corresponding number to
/gcthe matching file directory. 0 or < 0 means executing command operation to
/gcall existing files.
- Command : PECMD.EXE legitimate and valid command. The parameter format and
/gcnumber after the command are decided by it.

Example:

- FORX% CurDir% \ Path1 \ *. DLL, AnyDLL, 0, CALL% AnyDLL%
- FORX \ auto *. INF, AutoRunVirus, 0, FILE% AutoRunVirus%
- FORX! \ WinPE \ WinPE.INI, MyIni, 1, LOAD% MyIni%

Remarks:

- This command can search for the file directory with attributes, such as the
/gchidden attribute file directory.
- Leading character ” \ ” means searching all partitions. ” ! ” indicates
/gcmaking reverse search for all partitions. In the two leading characters ” [ !
/gc] \ “, the ” ! ” can not exist alone.
- Leading character ” @ ” indicates searching only the directory and making
/gccorresponding operation. If ” @ ” is omitted, it means searching only the
/gcfiles and operating accordingly.

Example:

- Example 1 means registering all DLL in the directory of %CurDir% \ Path1 \.
- Example 2 means deleting auto *. INF file in all partition root directories.
- Example 3 means reversely searching for WinPE.INI in all partitions’ WinPE directories. Then use LOAD command to load the the first WinPE.INI.

#### [GROU]

- Format: `GROU < combination panel name >, < combination panel shape > , [ combination panel title ]`
- Function: Establish a combination panel in the window defined by `_SUB` command, for/gc explaining the controls function and role in the combination panel.

Parameters:

- Combination panel name: String. The combination panel name should be unique,
/gcand can not be same as other controls names or environment variables names.
- Combination panel shape: combination panel location and size. Its format
/gcis<LTWH>, in which L stands for Left, T for Top, W for Width, H for Hight.
/gcAnd all of them are numerical values.
- Combination panel title: string used to describe the role and function of the
/gccombination panel .

Example:

- GROU Group1, L8T4W336H400, register WimShExt.DLL

Remarks:

- GROU command must locate between `_SUB` command `_END` command. GROU command
/gcplaced at other locations is invalid. Please refer to illustrations of `_SUB`
/gcand CALL commands.
- To set the combination panel title, you can use “ENVI @ combination panel
/gcname = combination panel title”. Pleas make reference to the description of
/gcENVI commands.

#### [HELP]

- Format: `HELP [ text foreground color ] [ # text background color ]`
- Function: Display help information

Parameters:

- Value ( supporting hexadecimal )

Example:

- HELP 0x00EEFF # 0xFF0000

Remarks:

- Directly executing the program without command line parameters will display
/gchelp information as well.

#### [HKEY]

- Format: `HKEY [ modifier keys + ] <# virtual key code > , <hotkey command >`
- Function: Set the system hotkey and assign the command executed by the hotkey.

Parameters:

- Auxiliary keys: 4 modifier keys (Alt, Ctrl, Shift and Win) can be represented
/gcas string. Use modifier keys “+ ” to connect the modifier keys.
- Key code: A key is represented by a virtual key code. Hexadecimal values is
/gcsupported.
- Hotkey command: It must be valid command supported by PECMD.

Example:

- HKEY # 255, SHUT R
- HKEY Ctrl + Alt + # 0x41, DISP W800H600B16F75

Remarks:

- HKEY command must locate between `_SUB` command and `_END` command. HKEY
/gccommand placed at other locations is invalid. Please refer to illustrations
/gcof `_SUB` and CALL commands.
- The first example is calling SHUT command to restart when pressing the power
/gcbutton.
- The set hotkey can not be conflict with hot keys of other programs .

#### [HOTK]

- Format: `HOTK [ modifier keys + ] <# virtual key code >, < command >`
- Function:/gcSet the system hotkey and assign the command executed by the hotkey. (. EXE or . CMD or . BAT)

Parameters:

- 4 auxiliary keys can be represented by strings, and other keys by virtual key code. Hexadecimal values is supported.

Example:

- HOTK # 255, PECMD.EXE SHUT E
- HOTK Ctrl + Alt + # 36, PECMD.EXE

Remarks:

- The first example is calling SHUT command of PECMD to shut down the computer
/gcwhen pressing the power button.
- This command can not be used in the command line. It can only be used in the
/gcconfiguration file. PECMD can set up to 8 groups hot keys.
- The register result of hot keys is in the registry’s “HKEY_LOCAL_MACHINE \
/gcSOFTWARE \ PELOGON”.
- SHEL command must be behind HOTK command.
- Only by using SHEL command to load SHELL, can you register hot keys by use of
/gcHOTK command.

#### [IFEX]

- Format: `IFEX < condition >, [ Command 1 ] [ ! Command 2 ]`
- Function: According to whether the conditional expression is established, execute command 1 if it is established, while execute command 2 if it is not.

Parameters:

- Condition: judgment for [ available memory ], [ disk free space ], [ key ], [
/gcnumeric variable ] or [ file directory ]
- Available memory: MEM < comparison operators > value
- Disk free space: R: \ < comparison operator > value. “R:” represents the
/gcdrive letter .
- Key: KEY < comparison operator > value
- File directory: file directory name. Wildcards can be used.
- Numeric variable: $%numeric variable name%< comparison operator > numerical
/gcvalue or numeric variable name. The numeric variable is a variable set by
/gcCALC or ENVI assignment.
- Comparison operators: The comparison operators include “<” , “>” and “=”
/gcwhich respectively represents ” less than” , “greater than ” and ” equal “.
- Numerical value: values for comparison. The unit of disk and memory is MB.
/gcAnd the key value is the key code.

Example:

- IFEX KEY = 17, TEAM TEXT search fonts | FONT \ WINDOWS! TEAM TEXT install fonts | FONT% CurDrv% \ external program \ FONT
- IFEX C: \ Windows,! MESS directory C: \ Windows not exist, \ n please click [ OK ] . @ directory check # OK

Remarks:

- This command is very powerful and complex. It can be used by nesting IFEX or
/gcFIND, to judge multiple conditions. The function of FIND is similar to this
/gccommand’s.
- The ” , ” after < conditional expression> can be replaced by ” * “.
- When this command is nesting IFEX or FIND command, the nested command can not
/gcuse the ” ! ” separator.
- When the IFEX command is used to detect keys, if user presses keys of ‘A’ ~
/gc‘Z’ or ‘0 ‘ ~ ‘9 ‘, the key result will be stored in the %PressKey%.
- When the command is used to judge the variables, all variables should be
/gcprocessed according to double data type. ( Up to four decimal places can be
/gcreserved.)

#### [IMAG]

- Format: `IMAG < picture box name >, [ picture box shape ], [ image filename ]`
- Function: Establish a picture box in a window defined by `_SUB` command.

Parameters:

- Picture box name : string. The picture box name should be unique, and can not
/gcbe same as other controls names or environment variables names.
- Picture box shape: Picture box’s size and location. Its format is <LTWH>, in
/gcwhich L stands for Left, T for Top, W for Width, H for Hight. And all of them
/gcare numerical values.
- Image file name: Image files ( all image files supported by Windows) will be
/gcdisplayed in the specified picture boxes.

Example:

- IMAG Image1, L8T380W140H70,%CurDir% \ logo.gif

Remarks:

- IMAG command must be located between `_SUB` command and `_END` command. IMAG
/gccommand placed at any other locations is invalid. Please refer to
/gcdescriptions of  `_SUB` and `CALL` commands.
- Because PECMD.EXE is script interpreter, so it is not recommended to load the
/gclarge size image file. Otherwise, the display will be slow.

#### [INIT]

- Format: `INIT [C] [I] [K] [U]`
- Function: Perform basic initialization, register Windows shell, initialize user folders and environment variables, install the keyboard hook, and create the following directories:
Favorites, Programs, Desktop, SendTo, StartMenu, Personal, Startup, QuickLaunch

Parameters:

- Parameter “C” indicates writing the drive letter into environment variable;
/gcparameter “I” means installing some functions of PECMD in the tray icon menu.
- Parameter “K” indicates executing INIT command to immediately install
/gclow-level keyboard hook. Otherwise, install low-level keyboard hook after
loading SHELL.
- Parameter “U” means writing the USB letter into environment variable. (The
/gcfunction is not perfect.)

Example:

- INIT
- INIT C
- INIT CH
- INIT CIK
- INIT CIKU

Remarks:

- After executing INIT command, perform the SHEL to load the specified SHELL.
/gcThen a minimized WinPE can be booted.
- Make sure that there is writable space in the partition where %USERPROFILE%
/gcis before executing INIT command. Otherwise, INIT command can not complete
/gcthe work.
- With parameter “C”, the drive letter is stored in the environment variables
/gcstarting with CDROM. (These environment variables will take effect after
/gcrestarting and refreshing.)
- Parameter “K” indicates instantly installing the keyboard hook, taking charge
/gcof Ctrl + Alt + Del, and calling out Task Manager.
- With parameter “U”, USB drive letter is stored in the environment variables
/gcstarting with USB. (These environment variables will take effect after
/gcrestarting and refreshing.)
- The public offering WinPE INIT command is not recommended to have “K”
/gcparameter. This command can not be used in the command line. It can only be
/gcused in the configuration file.

#### [ITEM]

- Format: `ITEM < button name >, < button shape >, [ button title ], [ button event ], [ button icon ], [ button state ]`
- Function: Establish a button in a window defined by `_SUB` command.

Parameters:

- Button name: string. The button name should be unique, and can not be the
/gcsame as other controls names or environment variables names.
- Button shape: button’s location and size. Its format is <LTWH>, in which L
/gcstands for Left, T for Top, W for Width, H for Hight. And all of them are
/gcnumerical values.
- Button title: text on the button, used for describing the button’s function
/gcor executing command.
- Button event: the command executed by clicking the button. It must be a valid
/gccommand supported by PECMD.
- Button icon: the icon displayed on the button. Its format is < icon file name
/gc# ID>, icon size = button height – 6.
- Button state: number. If the default value is 0, it indicates that the button
/gcis available button; if the value is non-zero, it means that the button is
gray unavailable button.

Example:

- ITEM Button3, L32T108W300H54, resource manager, EXEC explorer.exe, %SystemRoot% \ explorer.exe

Remarks:

- ITEM command must be located between `_SUB` command and `_END` command. ITEM
/gccommand placed at any other locations is invalid. Please refer to the
/gcillustrations of  `_SUB` and CALL commands.
- To set the text on the button, you can use “ENVI @ button name = button text
/gc“. Please make reference to the explanation of ENVI command.
- Use “ENVI @ button name. Enable = value ” to set the edit box’s available
/gcstate. 0 stands for unavailable state, while non-zero value represents
/gcavailable state.

#### [KILL]

- Format: `KILL [[<\> window title ] | [ process name ] ]`
- Function: Close the window of specified title or forcefully terminate specified process

Parameters:

- The leading character ” \ ” indicates closing the window of specified title.
/gcIf the window title is omitted, the window defined by `_SUB` command will be
/gcclosed.
- Omitting the leading character ” \ ” indicates ending the process of the
/gcspecified name (EXE filename, no path). If the process name is omitted, the
/gcPECMD’s parent process will be terminated.

Example:

- KILL WinLogon.EXE
- KILL \ Calculator

Remarks:

- Process name without window title should be ended up with process name.
- When ending the process, all processes matching with the process name will be terminated.

#### [LABE]

- Format: `LABE < text label name >, < text label shape >, [ text label content ]`
- Function: Establish a static text label in a window defined by `_SUB` command.

Parameters:

- Label name : string. Label name should be unique, and can not be same as
/gcother controls names or environment variables names.
- Label shape: label’s location and size. Its format is <LTWH>, in which L
/gcstands for Left, T for Top, W for Width, H for Hight. And all of them are
/gcnumerical values.
- Label content: string; text displayed by the label, supporting multiple lines
/gcdisplay. Use “\ n” between lines.

Example:

- LABE Label1, L32T280W128H48, please click the “Open” button to browse the file.

Remarks:

- LABE must be located between `_SUB` command and `_END` command. LABE command
/gcplaced at any other location is invalid. Please refer to the introductions of
/gc`_SUB` and `CALL` commands.
- To set the text on the label, you can use the “ENVI @label name = label
/gctext”. Please make reference to the description of ENVI command.

#### [LINK]

- Format: `LINK [!] < shortcut path >, < target path >, [ operating parameters ], [ icon path [ # icon index ] ], [ target remark ], [ initial position ]`
Function : Create a shortcut.

Parameters:

- Shortcut : Specify the path of a shortcut to be generated. The “. LNK”
/gcextension name is not needed.
- Target path: Specify a shortcut’s target file directory (available relative
/gcpath) . If the target does not exist, it will not create a shortcut.
- Operating parameters: target program’s operating parameters.
- Icon path: shortcut icon path.
- Icon index: the serial number of a shortcut icon in the file resources. 0
/gcstands for the first one, while nothing filled means default.
- Icon remarks: strings, description for the target program or directory.
- Initial position: the working directory commanded by the target program.

Example:

- LINK!% Desktop% \ broadband connection, RASPPPOE.CMD, RASDIAL.DLL # 19

Remarks:

- Leading character ” ! ” indicates starting up a program in the minimizing form, and can be used to minimize command windows when executing batch files.

#### [LIST]

- Format: `LIST < combo box name >, < combo box shape >, < combo box content >, [ combo box event ], [ default selected entry ]`
- Function: Establish a combo box in the window defined by `_SUB` command.

Parameters:

- Combo box name: string. The combo box name should be exclusive, and can not
/gcbe same as other controls names or environment variables names.
- Combo box shape: combo box’s position and size. Its format is <LTWH>, in
/gcwhich L stands for Left, T for Top, W for Width, H for Hight. And all of them
/gcare numerical values.
- Combo box content : entries to be selected in the combo box. Use “|” between
/gcthe entries.
- Combo box event: the command to be executed when changes occur in the entries
/gcfor selection of the combo box. It must be a valid command supported by
/gcPECMD.
- Default selected entries: Initialize the drop-down list box and set the
/gcselected entry.

Example:

- LIST List1, L200T360W128H32, EXPLORER | XPLORER2 | CMD, ENVI @ Label1 =% List1%, EXPLORER

Remarks:

- LIST command must be located between `_SUB` command and `_END` command. LIST
/gccommand placed at any other location is invalid. Please refer to the
/gcdescriptions of `_SUB` and `CALL` commands.
- The environment variable, % environment variable name%, is the selected entry
/gc( string ) in the combo box.
- Use “ENVI @combo box name. Enable = numerical value ” to set the edit box’s
/gcavailable state. 0 means unavailable state, while non-zero value represents
/gcavailable state.

#### [LOAD]

- Format: `LOAD < file path >`
- Function: Run the commands in the configuration file in order.

Parameters:

- Specified file name ( including the path; supporting environment variables)

Example:

- LOAD \ external program \ PECMD.INI

Remarks:

- Each command is in a single line. The main process’s orders is executed
/gcsequentially. Incorrect command or an empty line is negligible.
- It supports text files of ANSI and UNICODE formats. UNICODE format text file
/gcis recommended to use.
- Configuration file supports whole-line comments and after-line comments. It
/gcis suggested to use ” ` ” ( the character below the Esc key) as a comment
/gcstarting.
- In the configuration file, use the environment variable “%CurDrv%” to
/gcindicate the current drive letter.
- If the first character of the file path is ” \ “, files in the specified
/gcdirectory of all disks will be searched. “LOAD \ MyWinPE \ PECMD.INI” is an
/gcexample here.
- The configuration file directory is set as the current directory. Then when
/gccreating a shortcut, the shortcut’s target path can use relative path.
- Regarding to other information, please refer to the illustration of MAIN
/gccommand.

#### [LOGO]

- Format: `LOGO [[# background color ] | [ image file ] ], [ position and size ]`
Function : Set or close the login screen.

Parameters:

- Background color: numerical values. There must be a leading character ” # ”
/gcwhen setting the background color. If the color set is invalid, the default
/gccolor in the registry will be used.
- Image files : supporting BMP / JPG / PNG / GIF format, needing the support of
/gcGDI+. Only choose one between the background color and the image file.
- Position and size : LOGO window’s position and size. Its format is <LTWH>, in
/gcwhich L stands for Left, T for Top, W for Width, H for Hight. And all of them
/gcare numerical values.
- If there are no parameters, turn off the splash screen ( fade out ).

Example:

- LOGO% SystemRoot% \ LOGON.JPG
- LOGO # 0xFF0000, L100T100W300H200

Remarks:

- This command is executed with non-blocking mode. After finishing this command
/gc, the next command will be executed at once.
- This command can only be used in the configuration file. If it is used in the
/gccommand line, the program exits immediately, so the result can not be saw.
- If the “LT” is omitted, the window is centered; If the “WH” is omitted, the
/gcwindow is  full-screen size; If “LTWH” is omitted, the window is a full
/gcscreen one.
- Before the end of the configuration file, a “LOGO” command without parameters
/gcmust be called once so as to close the splash screen.
- When booting WinPE, it is recommended to use full screen window ( position
/gcand size ). The use of a LOGO image requires large LOGO memory.

#### [LOGS]

- Format: `LOGS [ file path ] , [ numerical value ]`
- Function: Enables logs so as to record the executing results of each command, and help users verify the correctness of the configuration file.

Parameters:

- File path: the log file name, including the path.
- Numerical value: the memory space (unit is KB) applied for the log file. The
/gcmore log records are, the more memory space is needed. If it is omitted, the
/gcdefault value, 16K, is applied.

Example:

- LOGS% SystemRoot% \ PECMD.LOG

Remarks:

- Before the end of the configuration file, a “LOGO” command without parameters
/gcmust be called once so as to close the splash screen. (make sure the log is
/gcwritten in file)
- This command can not be used in the command line. (It must be used in the
/gcconfiguration file.)
- It is not recommended to enable log file in public offering WinPE.

#### [LPOS]

- Format: `LPOS < variable name > <= > < string >, < characters >, < value >`
- Function: Return to the specified character’s position where it appears from the left of the ” string”.

Parameters:

- Variable name: variable name used for saving the command result
- String: string to be detected. Its length can not exceed 2K.
- Characters: characters to be detected. They are not case-insensitive.
- Value: Specify the detected characters’ appearance number.

Example:

- LPOS iPos = 123A56 | 1234A6 | abcdef, a, 2
- LPOS iPos = 123A56 | 1234A6 | abcdef, a, 3

Remarks:

- When the “value” is less than 1, it is returned to the rightmost detected
/gccharacter’s position. For instance, the result of the above example is 15. If
/gcthe return result is 0, it means “not found”.
- This command is processed according to Unicode string. The return value of
/gcexample 1 is 12, and that of example 2 is 15. ( Its result is the same as the
/gcresult when the value is 0.)

#### [LSTR]

- Format: `LSTR < variable name > <= > < string >, <number >`
- Function: Intercept characters of specified number from the left of specified “string”, and return the result to the variable with assigned name.

Parameters:

- Variable name: variable name used for saving command result
- String: source string. Its length can not exceed 2K.
- Number: Specify the number of intercepting characters.

Example:

- LSTR aStr = 1234567890,2
- LSTR aStr = 1234567890,5

Remarks:

- When the “value” is less than 1 or exceeds the length of the source string,
/gcthe result is the entire source string ( equivalent to string copy ).
- This command is processed according to Unicode strings. The return value of
/gcexample 1 is “12” and that of example 2 is “12345 “.

#### [MAIN]

- Format: `MAIN [ file path ]`
Function : Initialize the desktop, take over Ctrl + Alt + Del, and create a new process to execute LOAD function .

Parameters:

- Specified initialization configuration file path

Example:

- MAIN %SystemRoot% \ PECMD \ PECMD.INI

Remarks:

- After MAIN command creates a LOAD process and executes the LOAD function, it
/gcwill stay in the memory, install key hook, and mount “ExitWindowsEx”
/gcfunction.
- PECMD’s stay takes up larger memory. You can use the PECMD’s LAOD function,
/gcwhile the MAIN function is replaced by PELOGON.EXE.
- After LOAD command completes loading file function, it will automatically
/gcexit from the memory. For other information, please make reference to the
/gcillustration of the LOAD command.

#### [MD5C]

- Format: `MD5C [ file name | $ string ], [ variable name ]`
- Function: Calculate MD5 check code of file or string, and use it for setting or verifying the MD5 verification of WinPE login password.

Parameters:

- File name: the full name of the file whose MD5 check code is to be
/gccalculated; String: the string whose MD5 check code is to be calculated.
- The leading character ” $”: It means the thing to be calculated is the
/gcstring’s MD5. If the first character of the string is “$”, please add another
/gc“$” at the beginning of the string.
- Variable name: variable name used to save the calculated result.

Example:

- MD5C% SystemRoot% \ System32 \ UserInit.EXE, UserInitMD5
- MD5C $ Lxl1638, PassWordMD5

Remarks:

- When using MD5C command to calculate string’s MD5 check code, the string’s
/gcnumber of character is limited within 256. ( The character “,” can not be
/gcincluded.)
- File name can not contain “,” character. The system exclusive file’s MD5
/gccheck code is “d41d8cd98f00b204e9800998ecf8427e” or all “0”.
- The verified string can include Chinese and English letters, and they are
/gccase sensitive.
- If the variable name is given, MD5C command will save the calculation result
/gcto the specified variable. Example 2 can be referenced through the
/gcenvironment variable %PassWordMD5%.
- If the variable name is omitted, MD5C command’s calculation result will be
/gcdisplayed in the message window, and will also be saved to a paste board.

#### [MEMO]

- Format: `MEMO < edit box name >, < edit box shape >, [ edit box content ] , [
/gctarget file name ], [ edit box type ]`
- Function: Create a multiple-line text edit box in the window defined by _SUB
/gccommand. Parameters:
- Edit box name: string. The edit box name should be unique, and can not be
/gcsame as other controls names or environment variables names.
- Edit box shape: edit box’s position and size. Its format is <LTWH>, in which
/gcL stands for Left, T for Top, W for Width, H for Hight. And all of them are
/gcnumerical values.
- Edit box content: the content filled when initializing the edit box,
/gcsupporting multiple lines text. Use “\ n” between lines to indicate line
/gcbreak. And the total length must be less than 1K.
- Target file name : Specified text file name. The content of multiple-line
/gctext edit box is loaded by the file.
- Edit box type: numeric number. Default, omission or 0 means that it is an
/gceditable multiple-line text edit box, while non-zero value indicates that it
/gcis a read-only one.

Example:

- MEMO Memo1, L304T268W280H88,,%CurDir% \ Readme.TXT, 0

Remarks:

- MEMO command must be located between _SUB command and _END command. MEMO
/gccommand placed at any other location is invalid. Please refer to the
/gcintroductions of  _SUB and CALL commands.
- If the “edit box content ” is not empty, the ” target file name ” will be
/gcignored. If it is empty, the specified content of ” target file name ” will
/gcbe loaded. Overlong ” edit box content ” can connect as a new string variable
/gcthrough environment variable assignment, which makes it easy to read in the
/gcNotepad.
- Use “ENVI @edit box name. Enable = numerical value” to set the edit box
/gcavailable state. 0 represents unavailable state, while non-zero value stands
/gcfor available state.
- Use “ENVI @edit box name. ReadOnly =numerical value ” to set the edit box
/gcread-only status. 0 means non-read-only status, non-zero value represents
/gcread-only status.

#### [MENU]

- Format: `MENU < menu item name >, [ menu item title ], [ menu item event ], [ menu item state ]`
- Function: Add a menu in a custom tray icon menu.

Parameters:

- Menu item name: string. Apart from the separation line, the menu item name
/gcshould be unique, and can not be same as other controls names or environment
/gcvariables names. When the menu item name or the first character of the menu
/gcitem name is ” – “, it indicates separation line. Otherwise, it means normal
/gcmenu.
- Menu item title: the text on the menu item, used for describing the function
/gcor description of the menu item.
- Menu item event: The command is executed by clicking the menu item. It must
/gcbe a valid command supported by PECMD.
- Menu item status: The default value is 0 which means available state, while
/gcnon-zero value stands for gray unavailable status.

Example:

- MENU Menu2, resolution 1024X768 color 32-bit refresh rate 85, DISP W1024H768B32F85
- MENU –

Remarks:

- MENU command must be located between _SUB command and _END command. MENU
/gccommand placed at any other location is invalid. Please refer to the
/gcdescriptions of  _SUB and CALL commands.
- During the period of running, the support to modify the menu item title is
/gctemporarily not provided. That is, it can not use environment variable %menu
/gcitem name% to refer to the menu item title, nor support using “ENVI @ menu item
/gcname ” to set or modify the menu item title.
- The icon of the tray icon menu is decided by the window title defined by the
/gc_SUB command. If it is omitted, the main icon of PECMD will be applied.
- Use “ENVI @ menu item name. Enable = numerical value ” to set the edit box
/gcavailable state. 0 means unavailable state, while non-zero value represents
/gcavailable status.

#### [MESS]

- Format: `MESS < message window text > < @message window text title > <#message window type > [ * automatic turn off time ( ms ) ] [ $ default option ]`
- Function: Display a [ Yes / No ] selection message window or display a message window with [ OK ] button.

Parameters:

- ” Message window text ” supports multiple-line text and the “\ n” should be
/gcused between lines to disconnect them. “Message window type ” currently
/gcsupports “YN” and “OK” types.
- When the auto-off time is set as 0 or not set, the message window does not
/gcclose automatically. The default option is represented by Y or N, such as $ Y
/gcor $ N.

Example:

- MESS find insufficient physical memory, \ n whether to set virtual memory? @ set virtual memory # YN * 10000 $ N

Remarks:

- Users’ selection result of “YN” type message window is stored in the
/gcenvironment variable %YESNO%. When[ YES ] is selected, the value of the
/gcenvironment variable % YESNO% is YES; when the window is closed because of
/gctimeout or [ No ] is selected, the value of the environment variable % YESNO%
/gcis NO. IFEX or FIND command can be used to judge the environment variable
/gcvalue.
- When “YN” type message window omits the default choice parameters, the return
/gcvalue of auto-off is NO.
- The “OK” type message window does not have return value. It only display the
/gcprompt message to users.

#### [MOUN]

- Format: `MOUN [!] [Wim file name ] , <Mount target directory> , [ image ID ], [WimFltr temporary working directory ]`
- Function: Mount certain image of WIM file to specified directory or remove the mounted image file.

Parameters:

- Wim file name: Microsoft Windows Imaging Format (WIM) image format file.
- Mount target directory: the directory which a WIM image file is mounted to.
- Wim file image ID: the image ID in Wim file, represented by numerical value.
/gcWhen the mount image is read-only or the image ID is 1, it can be omitted.
- WimFltr temporary directory: During the process of setting WimFltr temporary
/gcworking directory, if it indicates mounting by RW way, this directory is
/gcrecommended to set to hard disk.

Example:

- MOUN% CurDrv% \ external program \ PROGRAMS.WIM,% ProgramFiles%, 1

Remarks:

- File directory name supports environment variables explanation. When using
/gcFBWF command, it must be used after MOUN command.
- If ” \ ” is at the beginning of the file name, it means searching specified
/gcdirectory files of all partitions (including hidden partitions). e.g.: MOUN \
/gcMyPE \ OP.WIM,% PF%, 1
- The leading character ” ! ” indicates that after successfully mounting WIM in
/gca hidden partition, a drive letter should be given to the hidden partition.
/gce.g.: MOUN! \ MyPE \ OP.WIM,% PF%, 1
- Omitting Wim file name means unmounting the image. If the image ID is
/gcnon-zero value, it indicates saving the changes when unmounting the image. If
/gcthe image ID is 0, it means not saving the changes.

#### [MSTR]

- Format: `MSTR < variable name > <=> < string >, <location >, <length>`
- Function: Intercept the characters of specified length from the starting position of assigned “string” and return the result to the specified variable.

Parameters:

- Variable name: variable name used for saving command result.
- String: source string. Its length can not exceed 2K.
- Location: numerical value. Specify the starting position of the source string.
- Length: numeric value, specifying the length of interception.

Example:

- MSTR aStr = 1234567890,2,4
- MSTR aStr = 1234567890,5,7

Remarks:

- When the “position” value is less than 1, it is processed as 1. When the ”
/gclength” value is less than 1 or exceeds the length of the source string,
/gcreturn all characters after the starting position.
- This command is processed according to Unicode string. The return value of
/gcexample 1 is “2345”, and that of example 2 is “567890”.

#### [NAME]

- Format: `NAME < variable name > <= > < file name >`
Function : Return the base name ( without directory and extension ) of the specified file name.

Parameters:

- Variable name: variable name used for saving command return value.
- File name: detected legal file name

Example:

- NAME aFileName = C: \ WINDOWS \ NOTEPAD.EXE
- NAME aName =% CurDir% \ Path1 \ Path2 \ FileName

Remarks:

- When the specified file name is the partition’s root directory, the command’s
/gcreturns result is a null value.
- The return result of example 1 is “NOTEPAD”, and that of example 2 is
/gc“FileName”.

#### [NUMK]

- Format: `NUMK <numerical value>`
- Function: Control the switching state of the small numeric keypad.

Parameters:

- When the value is 0, the state is off; When it is non-zero value, the status is open.

Example:

- NUMK 1

Remarks:

- The original SEND command can achieve the same function, but it is not very
/gcaccurate. When NUMK is on, it will turn off by sending a button again.

#### [PAGE]

- Format: `PAGE < page file path > < initial size > [ Max ]`
Function : Set the page file ( virtual memory ).

Parameters:

- Specified path to the page file: It can only use path of DOS 8.3 format, such
/gcas “C: \ PageFile.sys”.
- The unit of initial size and maximum value is MB. When the max is omitted, it
/gcwill automatically set “max = initial size”.

Example:

- PAGE C: \ PAGEFILE.SYS 128 256

Remarks:

- If the page file is set, the partition is not able to perform operations such
/gcas formatting and other operations.
- When available memory is larger than initial size, the command will not set
/gcthe page file. That is, defining the initial size can be a setting condition
/gcof page file.
- This command has intelligent function. In other words, it will start
/gcsearching from the partition where the page file name ( including the drive
/gcletter ) you defined is for eligible    ( hard drives and capacity ) partition
/gcto set the page file, avoiding slow U-disk and removable hard disk. When
/gcbooting with U disk or removable hard disk, the page file defined by the
/gcconfiguration file may be in the U disk or removable hard disk. Only after
/gcsearching and qualified hard disk partition for setting page file cannot be
/gcfound, can you use U disk or removable hard disk to set the page file.

#### [PATH]

- Format: `PATH [@] [#] [ directory name ]`
- Function: Operate directory, set the current working directory of PECMD.EXE, create a directory, or delete directory.

Parameters:

- Directory name (Containing environment variable is supported.)

Example:

- PATH @% CurDrv% \ external program or PATH %TEMP%

Remarks:

- The leading character “@” indicates setting the current working directory of
/gcPECMD.EXE, facilitating EXEC, DEVI and other commands to use relative paths
/gcso as to shorten the length of command line.
- The leading character “#” means deleting directory. Please note that this
/gcoperation can also delete a homonymous file.
- When the leading characters “@” and “#” are omitted, PATH is used to create a
/gcdirectory. ( It is able to build multi-level directory. )
- It must be careful to use PATH command with the leading character “@” in the
/gcconfiguration file so as to avoid causing confusion.
- When the parameter is empty, the PECMD.EXE defaulted current directory
/gc(%SystemRoot% \ SYSTEM32) will be restored.

#### [PBAR]

- Format: `PBAR < progress bar name >, < progress bar shape >, [ progress bar schedule]`
- Function: Build a progress bar in the window defined by _SUB command.

Parameters:

- Progress bar name: string. The progress bar name should be unique, and can
/gcnot be same as other controls names or environment variables names.
- Progress bar shape: progress bar’s position and size. Its format is <LTWH>,
/gcin which L stands for Left, T for Top, W for Width, H for Hight. And all of
/gcthem are numerical values.
- Progress bar schedule: Value ( 1 to 100 ), initializing the schedule
/gcpercentage of the progress bar. The default value is 0.

Example:

- PBAR Pbar1, L360T11W428H16, 0

Remarks:

- PBAR command must be located between _SUB command and _END command. PBAR
/gccommand placed at any other location is invalid. Please refer to the
/gcdescriptions of  _SUB and CALL commands.
- To set the progress bar schedule, you can use “ENVI @ progress bar name =
/gcnumerical value”. Please make reference to the description of ENVI command.
/gcWhen the set value is less than 0, the progress bar will be hidden. The value
/gcgreater than 100 will be ignored .

#### [RADI]

- Format: `RADI < single marquee name >, < single marquee shape >, [ single marquee title ], [ single marquee event ], [ single marquee state ], [ single marquee group ID]`
- Function: Establish a single marquee control in the window defined by _SUB command.

Parameters:

- Single marquee name: string. It should be unique, and can not be same as
/gcother controls names or environment variables names.
- Single marquee shape: single marquee’s position and size. It is format is
/gc<LTWH>, in which L stands for Left, T for Top, W for Width, H for Hight. And
/gcall of them are numerical values.
- Single marquee title: text on the single marquee, used to describe the single
/gcmarquee’s function or illustration.
- Single marquee event: The command is executed by clicking the single marquee.
/gcIt must be a valid command supported by PECMD command.
- Single marquee status: numbers. 1 or -1 stands for checked state, 0, 2 or -2
/gcfor not checked state, and value less than 0 for gray unavailable state.
- Single marquee group ID: numeric number. The default value is 0. You can
/gcdivide multiple single marquees into groups, and select one from many in a
/gcgroup. Meanwhile, groups will not influence each other.

Example:

- RADI RadioButton1, L32T314W100H20, uninstall WimShExt.DLL, ENVI @ Group1 =% RadioButton1%, 1,1

Remarks:

- RADI command must be located between _SUB command and _END command. RADI
/gccommand placed at any other location is invalid. Please refer to the
/gcexplanations of  _SUB and CALL commands.
- To set a single marquee title, use “ENVI @ single marquee name = single
/gcmarquee title “. Please refer to the illustration of ENVI command.
- Use “ENVI @ single marquee name. Check = numeric value” to set the single
/gcmarquee’s available state. 0 represents non-checked state, while non-zero
/gcvalue stands for checked state.
- Use “ENVI @single marquee name. Enable = numerical value” to set the single
/gcmarquee’s available state. 0 means disabled status, while non-zero value
/gcindicates available state.

#### [RAMD]

- Format: `RAMD [P percentage of available memory ] [L min ] [H max ]`
Function : Set the size of RamDisk

Parameters:

- The unit for maximum value and minimum value is MB.

Example:

- RAMD P20 L32 H64

Remarks:

- The three parameters can be used alone. For example, if RAMD P10 is used, it indicates that 10% of available memory is set as the size of RamDisk.


#### [`REGI`]

Format:
```
REGI [ leading character ] <HKLM|HKCU|HKCR|HKU|HKCC> <\subkey\> 
     { <key name, variable name > | [ [ key name ] [ operator ] [ [ type character ] data value ] ] }
```
Function: Read, set or delete the registry data.

Parameters:

- The leading characters `$`, `#` and `@` respectively denote reading type
  `/gcdata` of `REG_SZ`, `REG_DWORD`, `REG_BINARY` in the registry. If they are
  omitted, `/gcit` means setting and deleting registry data. And the variable
  name (The default `/gcis` RegDat.) is used to save the return value.
- Subkey name: the full name of the registry in the selected `ROOTKEY`.
- Key name: the key value name to be operated. If it is omitted, operate the
  `/gcdefault` key. If the operator is `!` and without `=`, it is used to
  delete `/gcthe` entire subkey.
- Operator: Operator `!` means deleting the entire subkey; operator `=` and
  `/gcwithout` data indicates deletion; operator `=` and with data denotes
  setting `/gcdata`.
- Type character: data type. If it is omitted, the data type is string; if it
  `/gcis` `#`, the data type is `REG_DWORD` data type such as `#0x20`; if it is
  `@`, `/gcthe` data type is `REG_BINARY` data type such as `@233490255`.
- Data value: string. A null value is represented by `""`. `REG_DWORD`
  `REG_BINARY` `/gcdata` types support hexadecimal value.

Example:

- `REGI HKCU\SOFTWARE\WinCMD\Version=#1200`
- `REGI HKCR\lnkfile\IsShortcut=""`
- `REGI $ HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\Cache, IECache`

Remarks:

- This command is very complex. Please carefully read the notes. Example 3 is
  to read the location of `IE cache`.


#### [RPOS]

- Format: `RPOS < variable name > <= > < string >, <characters>, <value>`
- Function: Return to the specified character’s location where it appears from the right of the “string”.

Parameters:

- Variable name: variable name used for saving command result.
- String: the string to be detected. Its length can not exceed 2K.
- Character: the character to be detected. It is not case-insensitive.
- Value: Specify the detected character’s occurrence number.

Example:

- RPOS iPos = 123A56 | 1234A6 | abcdef, a, 2
- RPOS iPos = 123A56 | 1234A6 | abcdef, a, 3

Remarks:

- When the “value” of less than 1, it is returned to the leftmost detected
/gccharacter’s position. For instance, the result of the above example is 4. If
/gcthe return result is 0, it means “not found”.
- This command is processed according to Unicode string. The return value of
/gcexample 1 is 12, and that of example 2 is 4.

#### [RSTR]

- Format: `RSTR < variable name > <= > < string >, <numeric value>`
- Function: Intercept characters of specified number from the right of the appointed string/gcand return the result to the assigned variable name.

Parameters:

- Variable name: variable name used to save the command result.
- String: source string. Its length can not exceed 2K.
- Numeric value: Specify the number of intercepted characters.

Example:

- RSTR aStr = 1234567890,2
- RSTR aStr = 1234567890,5

Remarks:

- When the “value” is less than 1 or exceeds the length of the source string,
/gcthe return result is the entire source string ( equivalent to string copy ).
- This command is processed according to Unicode string. The return value of
/gcexample 1 is “90”, and that of example 2 is ” 67890 “.

#### [RUNS]

- Format: `RUNS < program command > <* |,> < starting item name >`
- Function: Set the starting item of Windows

Parameters:

- Program command includes EXE, CMD, BAT and other executable commands which can be with parameters. The startup item name is text.

Example:

- RUNS PECMD.EXE EXEC!% CurDrv% \ external program \ DRIVER \ STARTDRIVER.CMD, install driver.

Remarks:

- The original REGI order can achieve the same functionality. But when using
/gcREGI command, long text is needed to make this functionality into a command.
- The separators between program command and startup item name are right “*”
/gcand left “|”. 
- This command can not be used in the command line and it can only be used in
/gcthe configuration file.

#### [SEND]

- Format: `SEND < key code 1 [_ | ^]>, [ key code 2 ], [ key code 3 ] …`
Function : Simulate button.

Parameters:

- Virtual key code: VK_NUMLOCK is an example. Please refer to the relevant
/gcprogramming documentation. If the key code is ended with ” _ “, only simulate
/gckey down; “^ ” means only simulate key up. Otherwise, simulate down and up.

Example:

- SEND 0x12_, 0x09_, 0x09 ^, 0x12 ^

Remarks:

- The above example simulates Alt + Tab. Key code supports hexadecimal and decimal.

#### [SERV]

- Format: `SERV [!] < service name >
Function : Start or stop service or driver program.

Parameters:

- Specified service name: The leading character ” ! ” means stopping a service.
/gcAnd without it indicates starting the service.

Example:

- SERV FBWF

Remarks:

- This command is used to start the FBWF service ( if you install it ), which
/gccan increase the system disk’s writable space. Then PE can run on the disk.

#### [SHEL]

- Format: `SHEL < file name ( including the path ) > [ Password MD5 string ], [ number of retry ]`
- Function: Load the specified SHELL and lock it.

Parameters:

- File name: SHELL file name ( including the path; environment variable can be
/gcused.).
- Password: English letters and numbers. The password is case-sensitive and its
/gcmaximum length is 12 characters.
- If the password MD5 string is omitted, it will automatically log in. The
/gcdefault number of retry is 3.

Example:

- SHEL% SystemRoot% \ EXPLORER.EXE, e10adc3949ba59abbe56e057f20f883e, 5

Remarks:

- This command’s functionality is similar to EXEC $’s. It can modify in-process
/gcshutdown code ( mount “ExitWindowsEx” function ).
- This command also has the function of locking SHELL. When the SHELL is
/gcdeleted, it will automatically load SHELL.
- It is recommended to open LOGO command before opening the SHELL command with
/gca login password .
- Parameters of TEXT command after SHEL command may need reset.
- SHEL command must be after HOTK command. Meanwhile, it can not be used in the
/gccommand line, and can only be used in the configuration file.

#### [SHOW]

- Format: `SHOW [ hard disk number | identifier ] [ : partition number ], [ letter ]`
- Function: Display the hidden partitions of removable hard disks or fixed one in the system, and assign drive letters to the partitions.

Parameters:

- Hard disk number: the hard disks in the computer. “0” means “hd0”; “1”
/gcindicates “hd1”; “2” indicates “hd2”, etc.
- Identifier: identified used for representing hard disk type. The fixed hard
/gcdisks are represented by “F”, while the removable hard disks are denoted by
/gc“R”. Between identifier or hard disk number, only one of them can be selected.
- Partition number: “0” indicates all partitions which have not been assigned
/gcdrive letter. “1” represents the first partition; “2” indicates the second
/gcpartition; and so on.
- Drive letter: Drive letter is represented by letter of “C ~ Z” ( without “:”
/gc). If the letter is omitted or the drive letter is set unreasonably,
/gcPECMD.EXE will automatically assign drive letters.

Example:

- SHOW 0:1, H
- SHOW R: 1, U
- SHOW F: 0
- SHOW

Remarks:

- Some models can identify removable hard disk after starting WinPE mobile hard
/gcdisk, but do not assign drive letters to them. So SHOW command’s “R”
/gcidentifier can be used to allocate letters to removable hard disks. Example 2
/gcmeans assigning drive letter ” U: ” to the first partition of removable hard
/gcdisks.
- Example 1 means assigning drive letter “H:” to “hidden partition 1 of hard
/gcdisk 0″; Example 3 indicates automatically allocating letters to ” all hidden
/gcpartitions of fixed hard disk.
- SUBJ command can be used to delete drive letters. When SHOW command
/gccooperates with SUBJ command, they can load hidden partition’s external
/gcprogram and keep the original hidden attribute of hidden partition.

#### [SHUT]

- Format: `SHUT [H | E | R | S]`
- Function: Shut down or restart the computer and so forth.

Parameters:

- No parameters: The default is shutting down system.
- Parameter “H”: Perform dormancy operation. It can only be used in normal
/gcsystem which supports dormancy ( It can be enabled in the control panel.).
- Parameter “E”: Pop up drive before closing the system, and then turn off the
/gcsystem after 10 seconds.
- Parameter “R”: Execute restart the system operation.
- Parameter “S”: Perform suspend system operation. It can only be used in the
/gcnormal system.

Example:

- SHUT E
- SHUT R
- SHUT H
- SHUT S

Remarks:

- This command can be used in command line. Its feature is fast shutdown by
/gcwhich all data may not be saved.

#### [SITE]

- Format: `SITE < file directory path >, < file directory attribute >`
- Function: Set or remove the file directory attribute. SITE command supports the four properties of A, H, R and S.

Parameters:

- Setting the attribute with the ” +” and clear it with “-“. (A = ARCHIVE; H =
/gcHIDDEN; R = READONLY; S = SYSTEM)

Example:

- SITE%SystemRoot% \ System32 \ PELOGON.EXE, + H + R

Remarks:

- SITE command can set file attribute and directory property.

#### [STRL]

- Format: `STRL < variable name > <=> < string >`
- Function: Returns specified string’s length.

Parameters:

- Variable name: variable name used for saving command result.
- String: string to be detected. Its length can not exceed 2K.

Example:

- STRL iLen = 1234567890
- STRL dLen = 12345

Remarks:

- The return result of this command is the length of Unicode string. The return
/gcvalue of example 1 is 10, and that of example 2 is 5.

#### [SUBJ]

- Format: `SUBJ < virtual drive >, [ the path assigned to virtual drive ]`
- Function: Associate the path with the drive number. The command is equivalent to SUBST command of CMD.

Parameters:

- If ” the path assigned to virtual drive” is omitted, the specified virtual
/gcdrive will be removed.

Example:

- SUBJ B:, X: \ PE_Tools

Remarks:

- During the virtual process, the virtual drive must be non-existent. When
/gcdeleting the virtual drive, the drive letter must be accurate. Otherwise, the
/gcphysical drive may be removed.

#### [TEAM]

- Format: `TEAM [ command 1] [| command 2] [| command 3] … [| command n]`
- Function: Execute the specified command group’s each command in order.

Parameters:

- One or many commands: Use “|” between commands to separate multiple commands.

Example:

- TEAM TEXT loading the desktop | LOGO | SHEL%SystemRoot% \ EXPLORER.EXE | WAIT 3000

Remarks:

- The command after TEAM command can not nest IFEX or FIND command.

#### [TEMP]

- Format: `TEMP <[@] Delete | Setting>`
- Function: Clean up user temporary folder, or reset the location of user temporary folder.

Parameters:

- Delete means cleaning up temporary directory. The leading character “@”
/gcindicates direct cleaning up without user’s confirmation. Setting denotes
/gcresetting the location of the temporary directory.

Example:

- TEMP Delete

Remarks:

- Do not use this command in the configuration file. It must be used by booting
/gcto the desktop. This command is to read temporary directory location from the
/gcregistry.

#### [TEXT]

- Format: `TEXT [ text line 1] [\ n] text line 2 [\ n] text line 3 … ] [ # color ] [L left ] [T top ] [R right ] [B bottom ] [ $ font size ]`
- Function: Display text in the login screen or desktop window.

Parameters:

- If the text is empty, remove the recently defined text in rectangular area.
/gcThe default color is white; The default coordinate is roughly in the top left
/gccorner; The “*” at the end means that before the new text is displayed, the
/gcoriginally displayed text is not removed.

Example:

- TEXT registering components …… # 0xFFDDDD L4 T720 R300 B768 $ 20

Remarks:

- This command supports multiple-line display text. Use “\ n” to indicate line
/gcbreak between text lines.
- Font size: The default font size is 14 ( equivalent to Song typeface’s small
/gcfive font ).
- The specified location [ left, top, right, bottom ] is related with the text
/gclength and font size.
- If this command is used in the configuration file during the login process,
/gcthe text will display in the login screen; If it is used in Windows after
/gclogin, the text will display desktop window; If the text is empty, remove the
/gcrecently defined text in rectangular area.

#### [TIME]

- Format: `TIME < timer name >, < timer period >, [ timer event ]`
- Function: Build a timer control within the window defined by _SUB command.

Parameters:

- Timer name: string. It should be unique, and can not be same as other
/gccontrols names environment variables names.
- Timer period: numerical value. Its unit is ms. If the value is greater than
/gc0, it indicates that the timer works immediately; If the value is 0, it means
/gcthat the timer pauses working.
- Timer event: The command is executed when triggering the timer. And it must
/gcbe a valid command supported by PECMD command.

Example:

- TIME Timer1, 10000, FILE% TEMP% \ *. *

Remarks:

- TIME command must be located between `_SUB` command and `_END` command. TIME
/gcat any other location is invalid. Please make reference to the descriptions
/gcof `_SUB` and `CALL` commands.
- Environment variable, %timer name%, is the timer’s working status. 0
/gcrepresents “suspend”, non-zero value stands for “started”.
- Use “ENVI @ timer name = 0” to suspend timer; Use “ENVI @ timer name = timer
/gcperiod( value )” to restart the timer.

#### [TIPS]

- Format: `TIPS [ prompt box title ], < prompt box content >, [ prompt box life ], [ icon style ID], [<@ [A] prompt box location > | [ tray bar icon ] ]`
- Function: Display a bubble prompt box in the specified location or tray bar of a screen. If all parameters are omitted, it indicates removing invalid icons in tray bar.

Parameters:

- Prompt box title: string; text displayed at the prompt box title. It can not
/gcbe longer than 64 characters, and the exceeding part is invalid.
- Prompt box content: string; body content displayed at the prompt. It can not
/gcbe longer than 256 characters. Meanwhile, “\ n” can be used as line break.
- Prompt box life: number, used for representing the prompt box’s continuous
/gcdisplay time( ms ). If it is omitted, the default is 10 seconds. And the
/gclongest display time is determined by the system.
- Icon style ID: number. 0, the default value, stands for no icon; 1 for
/gcinformation icon; 2 for warning icon; 3 for error icon; 4 or value larger
/gcthan 4 for tray icon.
- Prompt box location: It must be with a leading character “@”, which
/gcrepresents displaying prompt box in specified location of the screen. The
/gcleading character “A” represents arrow type prompt box. If it is omitted,
/gcrectangular prompt box will display. The position is expressed by LxxTyy (xx
/gcand yy represents numbers.) And this parameter can not be used together with
/gctray bar icon.
- Tray bar icon: Its format is ” file name # number”. When omitting the “file
/gcname”, use the specified icon in PECMD.EXE program resource.

Example:

- TIPS title, content \ n can branch \ n line 3 , 5000,1 , # 1
- TIPS title, content \ n can branch \ n line 3 , 5000,2, @ aL600T400

Remarks:

- Tray bar bubble prompt box can continue to display after the end of
/gcPECMD.EXE. When the PECMD.EXE life is longer than the prompt box life, the
/gcPECMD.EXE will end the prompt box after the specified time. After the end of
/gcPECMD.EXE life, the still existing prompt box will be processed by the system
/gcor user.
- The screen prompt box will end after the end of PECMD. So make sure that
/gcPECMD lifetime is slightly longer than prompt box’s (WAIT command delay) .

#### [UPNP]

- Format: `UPNP [$] < parameter >`
- Function: Perform the functionality of BartPE.EXE.

Parameters:

- The leading character “$” indicates displaying the execution interface of BartPE.EXE.
- Parameter: BartPE.EXE’s command line parameter.

Example:

- UPNP-pnp
- UPNP $-pnp

Remarks:

- This command embeds execute code of new BartPE.EXE. Without BartPE.EXE file,
/gcWinPE can also implement the functionality of BartPE.EXE.
- The command is executed in blocking mode. The command must be finished before
/gcexecuting the next command. Please pay attention to BartPE.EXE parameters and
/gctheir case sensitivity.

#### [USER]

- Format: `USER < user name > <* |,> < company name >`
- Function: Set the user name and company name in context menu properties of “My Computer”.

Parameters:

- Parameters are texts.

Example:

- USER Laojiu*Worry-free Start Forum
- USER Laojiu, Worry-free Start Forum

Remarks:

- The separator between user name and company name must be “*” or “,”. This
/gccommand can only be used in the configuration file.

#### [WAIT]

- Format: `WAIT [-] [ wait time ], [ quantitative change name ]`
- Function: Pause or continue to execute the command after waiting for a specified time.

Parameters:

- Leading character ” – “: Stop waiting when encountering any key during the
/gcspecified wait time. Otherwise, wait until the end of waiting time.
- Wait time: numerical value (unit is ms.). When the value is 0, suspend on
/gcencountering any key; Without keys, wait indefinitely ( equivalent to any key
/gcto continue ).
- Quantitative change name: It is used to save keys’ variables during wait
/gctime. The user’s key results will be saved in the specified variable.

Example:

- WAIT 2000
- WAIT 0, PKey

Remarks:

- When the parameter is 0, pause. Press any key to continue. Do not
/gccontinuously use pause functionality in short intervals, and it is
/gcrecommended to use pause functionality only once. WAIT 0 can detect the user’s
/gckey of ‘A’ ~ ‘Z’ or ‘0 ‘~’ 9 ‘. When omitting the variable name, the key result
/gcis stored in the environment variable %PressKey%.

#### [WALL]

- Format: `WALL < wallpaper file name >`
- Function: Set wallpaper

Parameters:

- Wallpaper file name

Example:

- WALL%CurDrv% \ external program \ WallPage.JPG

Remarks:

- It supports environment variables and different formats’ picture files. WALL
/gccommand of setting wallpaper must be before SHEL command of loading the
/gcdesktop.
- This command can not be used in command line. It can only be used in the
/gcconfiguration file.
