@echo off
chcp 65001 >nul
title Starts Music Batch ♫
setlocal enabledelayedexpansion

:debut
set "texte_complet="
set "TARGET=Starts Music Batch"
set "BLACK=[30m"
set "YELLOW=[33m"
set "RED=[31m"
set "GREEN=[32m"
set "RESET=[0m"
set "BLUE=[34m"
set VERSION=1.0
cls
echo.
echo.
echo.        V%VERSION%
echo.
echo. 
echo 			         ███████╗        ███╗   ███╗        ██████╗ 
echo 				 ██╔════╝        ████╗ ████║        ██╔══██╗
echo 				 ███████╗        ██╔████╔██║        ██████╔╝
echo 		                 ╚════██║        ██║╚██╔╝██║        ██╔══██╗
echo 			         ███████║        ██║ ╚═╝ ██║        ██████╔╝
echo 				 ╚══════╝!GREEN!TARTS!RESET!   ╚═╝     ╚═╝!GREEN!USIC!RESET!    ╚═════╝!GREEN!ATCH!RESET! 
echo.
echo.
echo.
echo   Par CAPOAPK
echo   Copyright 2026 © "starts Music Batch"
echo   Tous droits reserves et toute reproduction est strictement interdite.
echo.
pause

if not exist "%TARGET%\" (
    echo.
)

if not exist "%TARGET%" (
    mkdir "%TARGET%"
    echo.
) else (
    echo.
)

cls
echo.

set /a countTXT=0
set /a countWAV=0
set /a countOther=0


for %%F in ("%TARGET%\*.txt") do (
    if exist "%%F" (
        set /a countTXT+=1
    )
)
if !countTXT!==0 echo    😶 (aucun fichier texte)

for %%F in ("%TARGET%\*.wav") do (
    if exist "%%F" (
        set /a countWAV+=1
    )
)
if !countWAV!==0 echo    😶 (aucun fichier wav)

for %%F in ("%TARGET%\*.*") do (
    if /I not "%%~xF"==".txt" if /I not "%%~xF"==".wav" (
        set /a countOther+=1
    )
)
if !countOther!==0 echo    😶 (aucun autre fichier)
echo.

:menu
setlocal enabledelayedexpansion

cls
echo.   !BLUE!📄 Fichiers texte!RESET! : !YELLOW!!countTXT!!RESET! / !BLUE!🎧 Fichiers WAV!RESET! : !YELLOW!!countWAV!!RESET! / !BLUE!📦 Autres fichiers!RESET! : !YELLOW!!countOther!!RESET! /
echo.
echo.
echo       [!GREEN!1!RESET!] 💾 Générer enregistrée   
echo. 
echo       [!GREEN!2!RESET!]  ▶️Lecteur   
echo. 
echo       [!GREEN!3!RESET!] ⌨️ Générer manuel 
echo.  
echo       [!GREEN!4!RESET!] 🎲 Générer automatique  
echo. 
echo       [!GREEN!5!RESET!] 📖 Livre vocal   
echo.
echo       [!GREEN!6!RESET!] ℹ️ Information 
echo. 
echo       [!GREEN!7!RESET!] 🔄 Actualiser
echo.
echo       [!GREEN!8!RESET!] 🚪 Quitter
echo.
choice /c 12345678 /n /m "  👉 : "

if errorlevel 8 exit
if errorlevel 7 goto debut
if errorlevel 6 goto info
if errorlevel 5 goto modelivre
if errorlevel 4 goto melo2
if errorlevel 3 goto melo1
if errorlevel 2 goto playeur
if errorlevel 1 goto generateur


:info
cls
set "TARGET=Starts Music Batch"

if not exist "%TARGET%\" (
    echo.
    echo  ❌ [[!RED!ERREUR!RESET!]] Le dossier "%TARGET%" est introuvable.
    echo  📁 Verifiez qu'il se trouve dans le meme repertoire que ce script.
    echo.
    pause
    goto debut
)

cls
echo.


set /a countTXT=0
set /a countWAV=0
set /a countOther=0

echo   📄 [ FICHIERS TEXTE ]  
echo.
for %%F in ("%TARGET%\*.txt") do (
    if exist "%%F" (
        call :AfficherVert "%%~nxF" "%%~zF"
        set /a countTXT+=1
    )
)
if !countTXT!==0 echo    😶 (aucun fichier texte)
echo.

echo   🎧 [ FICHIERS AUDIO WAV ]  
echo.
for %%F in ("%TARGET%\*.wav") do (
    if exist "%%F" (
        call :AfficherJaune "%%~nxF" "%%~zF"
        set /a countWAV+=1
    )
)
if !countWAV!==0 echo    😶 (aucun fichier wav)
echo.

echo   📦 [ AUTRES FICHIERS ]  
echo.
for %%F in ("%TARGET%\*.*") do (
    if /I not "%%~xF"==".txt" if /I not "%%~xF"==".wav" (
        call :AfficherBlanc "%%~nxF" "%%~zF"
        set /a countOther+=1
    )
)
if !countOther!==0 echo    😶 (aucun autre fichier)
echo.

pause
goto menu


:AfficherVert
powershell -NoProfile -Command "Write-Host '    📄  %~1' -ForegroundColor Green -NoNewline; Write-Host ('   [' + '%~2' + ' octets]') -ForegroundColor DarkGray"
exit /b

:AfficherJaune
powershell -NoProfile -Command "Write-Host '    🎧  %~1' -ForegroundColor Yellow -NoNewline; Write-Host ('   [' + '%~2' + ' octets]') -ForegroundColor DarkGray"
exit /b

:AfficherBlanc
powershell -NoProfile -Command "Write-Host '    📦  %~1' -ForegroundColor Gray -NoNewline; Write-Host ('   [' + '%~2' + ' octets]') -ForegroundColor DarkGray"
exit /b

:modelivre
setlocal EnableDelayedExpansion
set "WORK_DIR=%~dp0Starts Music Batch"
if not exist "%WORK_DIR%" mkdir "%WORK_DIR%"

echo.
echo       [!GREEN!1!RESET!] Placez votre fichier texte dans ce dossier : %WORK_DIR%
echo.    
echo       [!GREEN!2!RESET!] Assurez-vous que votre fichier , txt est encode en UTF-8.
echo.

set /p "TXT_NAME=Entrez le nom du fichier a lire (sans le .txt) : "
if /i "%TXT_NAME%"=="Q" goto fin_gen

set "INPUT_FILE=%WORK_DIR%\%TXT_NAME%.txt"

if not exist "%INPUT_FILE%" (
    echo.
    echo [!RED!ERREUR!RESET!] Le fichier "%INPUT_FILE%" est introuvable.
    pause
    goto menu
)

set "PS_SCRIPT=%TEMP%\tts_convert.ps1"

(
echo param([string]$txtFile, [string]$outPrefix^)
echo Add-Type -AssemblyName System.Speech
echo $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
echo $synth.Rate = 0 # Vitesse de la voix, 0 egale normal
echo.
echo $content = Get-Content -Path $txtFile -Encoding UTF8
echo $chunkSize = 10000 # Taille max en caracteres par fichier WAV
echo $fileIndex = 1
echo $currentLength = 0
echo $builder = New-Object System.Speech.Synthesis.PromptBuilder
echo.
echo foreach ($line in $content^) {
echo     $trimmed = $line.Trim(^)
echo     if ($trimmed -ne ""^) {
echo         $builder.AppendText($trimmed^)
echo         # Ajoute une pause de 800 millisecondes a la fin de chaque paragraphe
echo         $builder.AppendBreak([TimeSpan]::FromMilliseconds(800^)^) 
echo         $currentLength += $trimmed.Length
echo.
echo         if ($currentLength -ge $chunkSize^) {
echo             $outFile = "{0}_{1:D2}.wav" -f $outPrefix, $fileIndex
echo             Write-Host "-> Generation en cours : $outFile ..."
echo             $synth.SetOutputToWaveFile($outFile^)
echo             $synth.Speak($builder^)
echo             $synth.SetOutputToDefaultAudioDevice(^)
echo             $builder.ClearContent(^)
echo             $currentLength = 0
echo             $fileIndex++
echo         }
echo     }
echo }
echo.
echo # Traiter le reste du texte
echo if (-not $builder.IsEmpty^) {
echo     $outFile = "{0}_{1:D2}.wav" -f $outPrefix, $fileIndex
echo     Write-Host "-> Generation en cours : $outFile ..."
echo     $synth.SetOutputToWaveFile($outFile^)
echo     $synth.Speak($builder^)
echo     $synth.SetOutputToDefaultAudioDevice(^)
echo }
echo $synth.Dispose(^)
) > "%PS_SCRIPT%"

echo.
echo Conversion en cours... Cela peut prendre quelques minutes pour un long livre.
powershell -ExecutionPolicy Bypass -File "%PS_SCRIPT%" -txtFile "%INPUT_FILE%" -outPrefix "%WORK_DIR%\%TXT_NAME%"

del "%PS_SCRIPT%"
echo.
echo [!GREEN!SUCCES!RESET!] Vos fichiers audio ont ete generes dans :
echo %WORK_DIR%
echo.
pause
goto menu


:melo1
cls
goto piano_manuel

:melo2
cls
goto generateur_musique


:piano_manuel
cls

setlocal enabledelayedexpansion

:debut_piano
cls
echo.
echo. Vous : %texte_complet%
echo.
echo.
echo.
echo 	         ╭──────────────────────────────────────────────────────────────────────────╮
echo 	         │  ♪  │  !RED!1!RESET!  │  !RED!2!RESET!  │  !RED!3!RESET!  │  !RED!4!RESET!  │  !RED!5!RESET!  │  !RED!6!RESET!  │  !RED!7!RESET!  │  !RED!8!RESET!  │  !RED!9!RESET!  │  ♫  │ 𝄞 │ 🎶 │      
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  !GREEN!A!RESET!  │  !GREEN!Z!RESET!  │  !GREEN!E!RESET!  │  !GREEN!R!RESET!  │  !GREEN!T!RESET!  │  !GREEN!Y!RESET!  │  !GREEN!U!RESET!  │  !GREEN!I!RESET!  │  !GREEN!O!RESET!  │  !GREEN!P!RESET!  │    ENTREE    │
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  🪶 │  !GREEN!Q!RESET!  │  !GREEN!S!RESET!  │  !GREEN!D!RESET!  │  !GREEN!F!RESET!  │  !GREEN!G!RESET!  │  !GREEN!H!RESET!  │  !GREEN!J!RESET!  │  !GREEN!K!RESET!  │  !GREEN!L !RESET! │  !GREEN!M!RESET!  │ 🎧 │ ♪ │   
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  🎹 │ !GREEN!W!RESET!  │  !GREEN!X!RESET!  │  !GREEN!C!RESET!  │         ESPACE         │  !GREEN!V!RESET!  │  !GREEN!B!RESET!  │  !GREEN!N!RESET!  │ 🎵 │ 🎤│ 
echo 	         ╰──────────────────────────────────────────────────────────────────────────╯
echo.
choice /c ABCDEFGHIJKLMNOPQRSTUVWXYZ /n >nul



set "lettres=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set /a "index=%errorlevel%-1"
call set "lettre=%%lettres:~%index%,1%%"

echo Vous avez tape : %lettre%

if /i "%lettre%"=="Q" goto fin_gen

call :jouer_son %lettre%
set nouvelle_saisie=%lettre%
set "texte_complet=%texte_complet% %nouvelle_saisie%"
goto debut_piano

:generateur_musique
cls
echo.
set /p nb_notes="Combien de notes voulez-vous (1-50)? "

if "%nb_notes%"=="" goto erreur_nombre
set /a test=%nb_notes% 2>nul
if %test% LSS 1 goto erreur_nombre
if %test% GTR 50 goto erreur_nombre

echo.
echo Generation d'une musique de %nb_notes% notes...
echo Appuyez sur une touche pour commencer la musique!
pause >nul
echo.
echo ♪♫ MUSIQUE EN COURS ♫♪
echo.

:: Generer et jouer la musique
for /L %%i in (1,1,%nb_notes%) do (
    call :generer_note_aleatoire
    echo Note %%i : !note_aleatoire!
    call :jouer_son !note_aleatoire!
    timeout /t 1 /nobreak >nul
)

echo.
echo ♪♫ FIN DE LA MUSIQUE ♫♪
echo.
echo Appuyez sur une touche pour retourner au menu...
pause >nul
goto menu

:erreur_nombre
echo Erreur: Veuillez entrer un nombre entre 1 et 50.
echo Appuyez sur une touche pour continuer...
pause >nul
goto generateur_musique

:generer_note_aleatoire
:: Generer un nombre aleatoire entre 1 et 26 pour choisir une lettre
set /a "rand=%random% %% 26 + 1"
set "lettres_musique=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set /a "index_rand=%rand%-1"
call set "note_aleatoire=%%lettres_musique:~%index_rand%,1%%"
goto :eof

:jouer_son
set key=%1
:: Gamme complete (associe chaque lettre a une frequence)
if /i "%key%"=="A" powershell -Command "[console]::beep(262,400)" & goto :eof   :: DO
if /i "%key%"=="B" powershell -Command "[console]::beep(277,400)" & goto :eof   :: DO#
if /i "%key%"=="C" powershell -Command "[console]::beep(294,400)" & goto :eof   :: RE
if /i "%key%"=="D" powershell -Command "[console]::beep(311,400)" & goto :eof   :: RE#
if /i "%key%"=="E" powershell -Command "[console]::beep(330,400)" & goto :eof   :: MI
if /i "%key%"=="F" powershell -Command "[console]::beep(349,400)" & goto :eof   :: FA
if /i "%key%"=="G" powershell -Command "[console]::beep(370,400)" & goto :eof   :: FA#
if /i "%key%"=="H" powershell -Command "[console]::beep(392,400)" & goto :eof   :: SOL
if /i "%key%"=="I" powershell -Command "[console]::beep(415,400)" & goto :eof   :: SOL#
if /i "%key%"=="J" powershell -Command "[console]::beep(440,400)" & goto :eof   :: LA
if /i "%key%"=="K" powershell -Command "[console]::beep(466,400)" & goto :eof   :: LA#
if /i "%key%"=="L" powershell -Command "[console]::beep(494,400)" & goto :eof   :: SI
if /i "%key%"=="M" powershell -Command "[console]::beep(523,400)" & goto :eof   :: DO (octave+1)
if /i "%key%"=="N" powershell -Command "[console]::beep(554,400)" & goto :eof   :: DO# (octave+1)
if /i "%key%"=="O" powershell -Command "[console]::beep(587,400)" & goto :eof   :: RE (octave+1)
if /i "%key%"=="P" powershell -Command "[console]::beep(622,400)" & goto :eof   :: RE# (octave+1)
if /i "%key%"=="Q" powershell -Command "[console]::beep(330,400)" & goto :eof   :: MI (retour menu)
if /i "%key%"=="R" powershell -Command "[console]::beep(659,400)" & goto :eof   :: MI (octave+1)
if /i "%key%"=="S" powershell -Command "[console]::beep(698,400)" & goto :eof   :: FA (octave+1)
if /i "%key%"=="T" powershell -Command "[console]::beep(740,400)" & goto :eof   :: FA# (octave+1)
if /i "%key%"=="U" powershell -Command "[console]::beep(784,400)" & goto :eof   :: SOL (octave+1)
if /i "%key%"=="V" powershell -Command "[console]::beep(831,400)" & goto :eof   :: SOL# (octave+1)
if /i "%key%"=="W" powershell -Command "[console]::beep(880,400)" & goto :eof   :: LA (octave+1)
if /i "%key%"=="X" powershell -Command "[console]::beep(932,400)" & goto :eof   :: LA# (octave+1)
if /i "%key%"=="Y" powershell -Command "[console]::beep(988,400)" & goto :eof   :: SI (octave+1)
if /i "%key%"=="Z" powershell -Command "[console]::beep(1047,400)" & goto :eof  :: DO (octave+2)
goto :eof


:generateur
setlocal enabledelayedexpansion

set "DOSSIER_OUT=%~dp0Starts Music Batch"
if not exist "%DOSSIER_OUT%" mkdir "%DOSSIER_OUT%"

:menu_gen
cls
echo.   !BLUE!📄 Fichiers texte!RESET! : !YELLOW!!countTXT!!RESET! / !BLUE!🎧 Fichiers WAV!RESET! : !YELLOW!!countWAV!!RESET! / !BLUE!📦 Autres fichiers!RESET! : !YELLOW!!countOther!!RESET! /
echo.
echo.
echo       [!GREEN!1!RESET!] Generer une musique aleatoire 🎲 + 💾
echo.
echo       [!GREEN!2!RESET!] Composer moi-meme (manuel) ⌨️ + 💾
echo.
echo       [!GREEN!3!RESET!] Retour au menu principal 🚪
echo.
choice /c 123 /n /m " 👉 : "

if errorlevel 3 goto fin_gen
if errorlevel 2 goto export_manuel
if errorlevel 1 goto export_aleatoire

:export_aleatoire
echo.
set /p nb_notes="Combien de notes pour la musique (1-100) ? "
set /a test=%nb_notes% 2>nul
if %test% LSS 1 goto export_aleatoire
set "ma_compo="
set "lettres_musique=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for /L %%i in (1,1,%nb_notes%) do (
    set /a "rand=!random! %% 26"
    for %%r in (!rand!) do set "note=!lettres_musique:~%%r,1!"
    set "ma_compo=!ma_compo!!note!"
)
goto export_nommer

:export_manuel
cls
echo.
echo. Vous : %texte_complet%
echo.
echo.
echo.
echo 	         ╭──────────────────────────────────────────────────────────────────────────╮
echo 	         │  ♪  │  !RED!1!RESET!  │  !RED!2!RESET!  │  !RED!3!RESET!  │  !RED!4!RESET!  │  !RED!5!RESET!  │  !RED!6!RESET!  │  !RED!7!RESET!  │  !RED!8!RESET!  │  !RED!9!RESET!  │  ♫  │ 𝄞 │ 🎶 │      
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  !GREEN!A!RESET!  │  !GREEN!Z!RESET!  │  !GREEN!E!RESET!  │  !GREEN!R!RESET!  │  !GREEN!T!RESET!  │  !GREEN!Y!RESET!  │  !GREEN!U!RESET!  │  !GREEN!I!RESET!  │  !GREEN!O!RESET!  │  !GREEN!P!RESET!  │    ENTREE    │
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  🪶 │  !GREEN!Q!RESET!  │  !GREEN!S!RESET!  │  !GREEN!D!RESET!  │  !GREEN!F!RESET!  │  !GREEN!G!RESET!  │  !GREEN!H!RESET!  │  !GREEN!J!RESET!  │  !GREEN!K!RESET!  │  !GREEN!L !RESET! │  !GREEN!M!RESET!  │ 🎧 │ ♪ │   
echo 	         │──────────────────────────────────────────────────────────────────────────│
echo 	         │  🎹 │ !GREEN!W!RESET!  │  !GREEN!X!RESET!  │  !GREEN!C!RESET!  │         ESPACE         │  !GREEN!V!RESET!  │  !GREEN!B!RESET!  │  !GREEN!N!RESET!  │ 🎵 │ 🎤│ 
echo 	         ╰──────────────────────────────────────────────────────────────────────────╯
echo.
set /p ma_compo="( Exemple : AABBCCDDE ) Ta composition : "
if /i "%ma_compo%"=="Q" goto fin_gen

if "%ma_compo%"=="" goto export_manuel
set nouvelle_saisie=%ma_compo%
set "texte_complet=%texte_complet% %nouvelle_saisie%"
goto export_nommer

:export_nommer
echo.
set /p nom_fichier="Donne un nom a ton fichier (sans extension) : "
if "%nom_fichier%"=="" set "nom_fichier=MaMusique_!random!"

echo.
echo [!GREEN!1!RESET!/3] Preparation du moteur audio...

set "PS_FILE=%TEMP%\export_wav.ps1"

echo param($NotesStr, $FileName, $OutPath) > "%PS_FILE%"
echo $ErrorActionPreference = 'Stop' >> "%PS_FILE%"
echo $path = Join-Path $OutPath ($FileName + '.wav') >> "%PS_FILE%"
echo $notes = $NotesStr.ToUpper().ToCharArray() >> "%PS_FILE%"
echo $sr = 44100 >> "%PS_FILE%"
echo $dMs = 0.4 >> "%PS_FILE%"
echo $spn = [int]($sr * $dMs) >> "%PS_FILE%"
echo $ms = New-Object IO.MemoryStream >> "%PS_FILE%"
echo $bw = New-Object IO.BinaryWriter($ms) >> "%PS_FILE%"
echo $bw.Write([char[]]'RIFF') >> "%PS_FILE%"
echo $bw.Write([int]0) >> "%PS_FILE%"
echo $bw.Write([char[]]'WAVE') >> "%PS_FILE%"
echo $bw.Write([char[]]'fmt ') >> "%PS_FILE%"
echo $bw.Write([int]16) >> "%PS_FILE%"
echo $bw.Write([System.Int16]1) >> "%PS_FILE%"
echo $bw.Write([System.Int16]1) >> "%PS_FILE%"
echo $bw.Write([int]$sr) >> "%PS_FILE%"
echo $bw.Write([int]($sr * 2)) >> "%PS_FILE%"
echo $bw.Write([System.Int16]2) >> "%PS_FILE%"
echo $bw.Write([System.Int16]16) >> "%PS_FILE%"
echo $bw.Write([char[]]'data') >> "%PS_FILE%"
echo $bw.Write([int]0) >> "%PS_FILE%"
echo $m = @{'A'=262;'B'=277;'C'=294;'D'=311;'E'=330;'F'=349;'G'=370;'H'=392;'I'=415;'J'=440;'K'=466;'L'=494;'M'=523;'N'=554;'O'=587;'P'=622;'Q'=330;'R'=659;'S'=698;'T'=740;'U'=784;'V'=831;'W'=880;'X'=932;'Y'=988;'Z'=1047} >> "%PS_FILE%"
echo foreach ($n in $notes) { >> "%PS_FILE%"
echo   $f = $m[[string]$n] >> "%PS_FILE%"
echo   if ($f) { >> "%PS_FILE%"
echo     for ($i=0; $i -lt $spn; $i++) { >> "%PS_FILE%"
echo       $val = [System.Int16]([math]::Sin(2 * [math]::PI * $f * ($i / $sr)) * 16000) >> "%PS_FILE%"
echo       $bw.Write($val) >> "%PS_FILE%"
echo     } >> "%PS_FILE%"
echo   } >> "%PS_FILE%"
echo } >> "%PS_FILE%"
echo $dl = $ms.Position - 44 >> "%PS_FILE%"
echo $ms.Position = 4 >> "%PS_FILE%"
echo $bw.Write([int]($dl + 36)) >> "%PS_FILE%"
echo $ms.Position = 40 >> "%PS_FILE%"
echo $bw.Write([int]$dl) >> "%PS_FILE%"
echo [IO.File]::WriteAllBytes($path, $ms.ToArray()) >> "%PS_FILE%"
echo $bw.Close() >> "%PS_FILE%"

echo [!GREEN!2!RESET!/3] Generation des ondes audio (WAV)...
powershell -NoProfile -ExecutionPolicy Bypass -File "%PS_FILE%" -NotesStr "!ma_compo!" -FileName "!nom_fichier!" -OutPath "!DOSSIER_OUT!"

if exist "%PS_FILE%" del "%PS_FILE%"

echo [!GREEN!3!RESET!/3] Termine !
echo.
echo [!GREEN!SUCCES!RESET!] : Ton fichier a ete cree !
echo [!GREEN!Nom!RESET!] : !nom_fichier!.wav
echo [!GREEN!Lieu!RESET!] : !DOSSIER_OUT!
echo.
pause
goto menu_gen

:fin_gen
endlocal
goto menu

:playeur
setlocal


set "BATFILE=%~f0"
set "PSFILE=%TEMP%\StartsMusicBatch.ps1"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=[IO.File]::ReadAllText($env:BATFILE,[Text.Encoding]::UTF8); $m='::PSB'+'EGIN::'; $i=$s.IndexOf($m); $j=$s.IndexOf([char]10,$i)+1; [IO.File]::WriteAllText($env:PSFILE,$s.Substring($j),(New-Object Text.UTF8Encoding $true))"
if errorlevel 1 (
  echo Impossible de preparer le lecteur.
  pause
  endlocal
  goto menu
)

start "" powershell -NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File "%PSFILE%" "%~dp0."
endlocal
goto menu

::PSBEGIN::
param([string]$BaseDir)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Xaml
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# ---------------------------------------------------------------- dossier
if ([string]::IsNullOrWhiteSpace($BaseDir)) { $BaseDir = Join-Path $env:USERPROFILE 'Music' }
$MusicDir = Join-Path (Resolve-Path $BaseDir).Path 'Starts Music Batch'
if (-not (Test-Path -LiteralPath $MusicDir)) {
    New-Item -ItemType Directory -Path $MusicDir -Force | Out-Null
}

# ---------------------------------------------------------------- interface
$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Starts Music Batch" Height="650" Width="1000" MinHeight="520" MinWidth="820"
        WindowStartupLocation="CenterScreen" WindowStyle="None" AllowsTransparency="True"
        Background="Transparent" ResizeMode="CanResize" FontFamily="Segoe UI"
        TextOptions.TextFormattingMode="Display">
  <Window.Resources>
    <Style x:Key="Nav" TargetType="Button">
      <Setter Property="Foreground" Value="#B9AFC9"/>
      <Setter Property="Height" Value="38"/>
      <Setter Property="FontSize" Value="14"/>
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Margin" Value="0,0,0,4"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="b" Background="Transparent" CornerRadius="9">
              <ContentPresenter VerticalAlignment="Center" HorizontalAlignment="Left" Margin="14,0"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="b" Property="Background" Value="#2A2138"/>
                <Setter Property="Foreground" Value="#F2EDE4"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Glyph" TargetType="Button">
      <Setter Property="Foreground" Value="#D6CDE4"/>
      <Setter Property="FontSize" Value="17"/>
      <Setter Property="Width" Value="38"/>
      <Setter Property="Height" Value="38"/>
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="b" Background="Transparent" CornerRadius="19">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="b" Property="Background" Value="#2E2440"/>
                <Setter Property="Foreground" Value="#FFFFFF"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Accent" TargetType="Button" BasedOn="{StaticResource Glyph}">
      <Setter Property="Width" Value="52"/>
      <Setter Property="Height" Value="52"/>
      <Setter Property="FontSize" Value="22"/>
      <Setter Property="Foreground" Value="#1B1526"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="b" Background="#E9A23B" CornerRadius="26">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="b" Property="Background" Value="#F5B85C"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Bar" TargetType="Slider">
      <Setter Property="Focusable" Value="False"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Slider">
            <Grid Height="18" VerticalAlignment="Center" Background="Transparent">
              <Border Height="4" CornerRadius="2" Background="#372C4A" VerticalAlignment="Center"/>
              <Track x:Name="PART_Track">
                <Track.DecreaseRepeatButton>
                  <RepeatButton Command="Slider.DecreaseLarge" Focusable="False">
                    <RepeatButton.Template>
                      <ControlTemplate TargetType="RepeatButton">
                        <Border Height="4" CornerRadius="2" Background="#E9A23B" VerticalAlignment="Center"/>
                      </ControlTemplate>
                    </RepeatButton.Template>
                  </RepeatButton>
                </Track.DecreaseRepeatButton>
                <Track.IncreaseRepeatButton>
                  <RepeatButton Command="Slider.IncreaseLarge" Focusable="False">
                    <RepeatButton.Template>
                      <ControlTemplate TargetType="RepeatButton">
                        <Border Background="Transparent"/>
                      </ControlTemplate>
                    </RepeatButton.Template>
                  </RepeatButton>
                </Track.IncreaseRepeatButton>
                <Track.Thumb>
                  <Thumb Focusable="False">
                    <Thumb.Template>
                      <ControlTemplate TargetType="Thumb">
                        <Ellipse Width="12" Height="12" Fill="#F2EDE4"/>
                      </ControlTemplate>
                    </Thumb.Template>
                  </Thumb>
                </Track.Thumb>
              </Track>
            </Grid>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Field" TargetType="TextBox">
      <Setter Property="Foreground" Value="#F2EDE4"/>
      <Setter Property="CaretBrush" Value="#E9A23B"/>
      <Setter Property="FontSize" Value="13"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="TextBox">
            <Border Background="#241C33" CornerRadius="9" BorderBrush="#372C4A" BorderThickness="1">
              <ScrollViewer x:Name="PART_ContentHost" Margin="12,0" VerticalAlignment="Center"/>
            </Border>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style x:Key="Rows" TargetType="ListBox">
      <Setter Property="Background" Value="Transparent"/>
      <Setter Property="BorderThickness" Value="0"/>
      <Setter Property="ScrollViewer.HorizontalScrollBarVisibility" Value="Disabled"/>
      <Setter Property="ItemContainerStyle">
        <Setter.Value>
          <Style TargetType="ListBoxItem">
            <Setter Property="Padding" Value="14,9"/>
            <Setter Property="Margin" Value="0,1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
              <Setter.Value>
                <ControlTemplate TargetType="ListBoxItem">
                  <Border x:Name="b" Background="Transparent" CornerRadius="9">
                    <ContentPresenter Margin="{TemplateBinding Padding}"/>
                  </Border>
                  <ControlTemplate.Triggers>
                    <Trigger Property="IsMouseOver" Value="True">
                      <Setter TargetName="b" Property="Background" Value="#241C33"/>
                    </Trigger>
                    <Trigger Property="IsSelected" Value="True">
                      <Setter TargetName="b" Property="Background" Value="#2E2440"/>
                    </Trigger>
                  </ControlTemplate.Triggers>
                </ControlTemplate>
              </Setter.Value>
            </Setter>
          </Style>
        </Setter.Value>
      </Setter>
      <Setter Property="ItemTemplate">
        <Setter.Value>
          <DataTemplate>
            <Grid>
              <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
              </Grid.ColumnDefinitions>
              <StackPanel>
                <TextBlock Text="{Binding Name}" Foreground="#F2EDE4" FontSize="14" TextTrimming="CharacterEllipsis"/>
                <TextBlock Text="{Binding Sub}" Foreground="#8E82A3" FontSize="11" Margin="0,3,0,0" TextTrimming="CharacterEllipsis"/>
              </StackPanel>
              <TextBlock Grid.Column="1" Text="{Binding Tag}" Foreground="#E9A23B" FontSize="11" VerticalAlignment="Center"/>
            </Grid>
          </DataTemplate>
        </Setter.Value>
      </Setter>
    </Style>
  </Window.Resources>

  <Border CornerRadius="14" Background="#1B1526" BorderBrush="#372C4A" BorderThickness="1">
    <Grid>
      <Grid.RowDefinitions>
        <RowDefinition Height="46"/>
        <RowDefinition Height="*"/>
        <RowDefinition Height="112"/>
      </Grid.RowDefinitions>

      <!-- barre de titre -->
      <Border x:Name="TitleBar" Background="Transparent">
        <Grid>
          <TextBlock Text="Starts Music Batch" Foreground="#F2EDE4" FontSize="13" FontWeight="SemiBold"
                     VerticalAlignment="Center" Margin="20,0"/>
          <StackPanel Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,0,10,0">
            <Button x:Name="BtnMin" Style="{StaticResource Glyph}" Content="—" FontSize="13"/>
            <Button x:Name="BtnClose" Style="{StaticResource Glyph}" Content="✕" FontSize="13"/>
          </StackPanel>
        </Grid>
      </Border>

      <!-- corps -->
      <Grid Grid.Row="1" Margin="14,0,14,0">
        <Grid.ColumnDefinitions>
          <ColumnDefinition Width="212"/>
          <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <StackPanel Grid.Column="0" Margin="0,4,14,0">
          <Button x:Name="NavFiles" Style="{StaticResource Nav}" Content="Mes fichiers"/>
          <Button x:Name="NavRadio" Style="{StaticResource Nav}" Content="Radios en ligne"/>
          <Border Height="1" Background="#2A2138" Margin="6,10"/>
          <Button x:Name="BtnFolder" Style="{StaticResource Nav}" Content="Ouvrir le dossier"/>
          <Button x:Name="BtnReload" Style="{StaticResource Nav}" Content="Actualiser la liste"/>
          <TextBlock x:Name="LblPath" Foreground="#6F6486" FontSize="10" TextWrapping="Wrap" Margin="14,16,4,0"/>
        </StackPanel>

        <Grid Grid.Column="1">
          <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
          </Grid.RowDefinitions>

          <Grid x:Name="SearchRow" Margin="0,4,0,10" Visibility="Collapsed">
            <Grid.ColumnDefinitions>
              <ColumnDefinition Width="*"/>
              <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <TextBox x:Name="TxtSearch" Style="{StaticResource Field}" Height="38"/>
            <Button x:Name="BtnSearch" Grid.Column="1" Style="{StaticResource Nav}" Content="Chercher"
                    Foreground="#E9A23B" Margin="8,0,0,0"/>
          </Grid>

          <ListBox x:Name="List" Grid.Row="1" Style="{StaticResource Rows}"/>
          <TextBlock x:Name="Empty" Grid.Row="1" Foreground="#8E82A3" FontSize="13" TextWrapping="Wrap"
                     HorizontalAlignment="Center" VerticalAlignment="Center" MaxWidth="420"
                     TextAlignment="Center" Visibility="Collapsed"/>
        </Grid>
      </Grid>

      <!-- lecteur -->
      <Border Grid.Row="2" Background="#171122" CornerRadius="0,0,13,13" BorderBrush="#2A2138" BorderThickness="0,1,0,0">
        <Grid Margin="22,14,22,14">
          <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
          </Grid.RowDefinitions>

          <Grid Grid.Row="0">
            <Grid.ColumnDefinitions>
              <ColumnDefinition Width="46"/>
              <ColumnDefinition Width="*"/>
              <ColumnDefinition Width="46"/>
            </Grid.ColumnDefinitions>
            <TextBlock x:Name="LblPos" Text="0:00" Foreground="#8E82A3" FontSize="11" VerticalAlignment="Center"/>
            <Slider x:Name="Seek" Grid.Column="1" Style="{StaticResource Bar}" Minimum="0" Maximum="1000" Margin="8,0"/>
            <TextBlock x:Name="LblDur" Grid.Column="2" Text="0:00" Foreground="#8E82A3" FontSize="11"
                       VerticalAlignment="Center" TextAlignment="Right"/>
          </Grid>

          <Grid Grid.Row="1" Margin="0,8,0,0">
            <Grid.ColumnDefinitions>
              <ColumnDefinition Width="*"/>
              <ColumnDefinition Width="Auto"/>
              <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <StackPanel VerticalAlignment="Center">
              <TextBlock x:Name="LblTitle" Text="Rien en lecture" Foreground="#F2EDE4" FontSize="14"
                         TextTrimming="CharacterEllipsis"/>
              <TextBlock x:Name="LblSub" Text="Choisissez une piste ou une radio" Foreground="#8E82A3"
                         FontSize="11" Margin="0,3,0,0" TextTrimming="CharacterEllipsis"/>
            </StackPanel>

            <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
              <Button x:Name="BtnPrev" Style="{StaticResource Glyph}" Content="⏮"/>
              <Button x:Name="BtnPlay" Style="{StaticResource Accent}" Content="▶" Margin="10,0"/>
              <Button x:Name="BtnNext" Style="{StaticResource Glyph}" Content="⏭"/>
              <Button x:Name="BtnStop" Style="{StaticResource Glyph}" Content="⏹" Margin="10,0,0,0"/>
            </StackPanel>

            <StackPanel Grid.Column="2" Orientation="Horizontal" HorizontalAlignment="Right" VerticalAlignment="Center">
              <TextBlock Text="Volume" Foreground="#8E82A3" FontSize="11" VerticalAlignment="Center" Margin="0,0,10,0"/>
              <Slider x:Name="Vol" Style="{StaticResource Bar}" Width="110" Minimum="0" Maximum="1" Value="0.6"/>
            </StackPanel>
          </Grid>
        </Grid>
      </Border>
    </Grid>
  </Border>
</Window>
'@

$win = [Windows.Markup.XamlReader]::Parse($xaml)

$List      = $win.FindName('List')
$Empty     = $win.FindName('Empty')
$SearchRow = $win.FindName('SearchRow')
$TxtSearch = $win.FindName('TxtSearch')
$Seek      = $win.FindName('Seek')
$Vol       = $win.FindName('Vol')
$LblTitle  = $win.FindName('LblTitle')
$LblSub    = $win.FindName('LblSub')
$LblPos    = $win.FindName('LblPos')
$LblDur    = $win.FindName('LblDur')
$BtnPlay   = $win.FindName('BtnPlay')
$win.FindName('LblPath').Text = $MusicDir

# ---------------------------------------------------------------- lecteur
$player = New-Object System.Windows.Media.MediaPlayer
$player.Volume = 0.6

$script:mode      = 'files'
$script:items     = @()
$script:index     = -1
$script:playing   = $false
$script:duration  = 0
$script:live      = $false

$exts = @('.mp3','.wav','.wma','.m4a','.aac','.mp4','.mid')

function Format-Time([double]$s) {
    if ($s -le 0) { return '0:00' }
    $t = [TimeSpan]::FromSeconds($s)
    if ($t.TotalHours -ge 1) { return ('{0}:{1:00}:{2:00}' -f [int]$t.TotalHours, $t.Minutes, $t.Seconds) }
    return ('{0}:{1:00}' -f [int]$t.TotalMinutes, $t.Seconds)
}

function Show-List($data, $emptyText) {
    $script:items = @($data)
    $List.ItemsSource = $script:items
    if ($script:items.Count -eq 0) {
        $Empty.Text = $emptyText
        $Empty.Visibility = 'Visible'
        $List.Visibility = 'Collapsed'
    } else {
        $Empty.Visibility = 'Collapsed'
        $List.Visibility = 'Visible'
    }
}

function Load-Files {
    $script:mode = 'files'
    $SearchRow.Visibility = 'Collapsed'
    $data = Get-ChildItem -LiteralPath $MusicDir -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $exts -contains $_.Extension.ToLower() } |
        Sort-Object Name |
        ForEach-Object {
            [pscustomobject]@{
                Name    = [IO.Path]::GetFileNameWithoutExtension($_.Name)
                Sub     = ('{0}, {1:N1} Mo' -f $_.Extension.TrimStart('.').ToUpper(), ($_.Length / 1MB))
                Tag     = ''
                Uri     = $_.FullName
                IsRadio = $false
            }
        }
    Show-List $data "Le dossier est vide. Déposez vos fichiers audio dans `"$MusicDir`" puis cliquez sur Actualiser la liste."
}

function Get-Radios([string]$query) {
    $servers = @(
        'https://de1.api.radio-browser.info',
        'https://nl1.api.radio-browser.info',
        'https://at1.api.radio-browser.info'
    )
    $path = if ([string]::IsNullOrWhiteSpace($query)) {
        '/json/stations/search?countrycode=FR&limit=40&hidebroken=true&order=clickcount&reverse=true'
    } else {
        '/json/stations/search?name=' + [uri]::EscapeDataString($query) +
        '&limit=40&hidebroken=true&order=clickcount&reverse=true'
    }
    foreach ($s in $servers) {
        try {
            $r = Invoke-RestMethod -Uri ($s + $path) -TimeoutSec 10 -Headers @{ 'User-Agent' = 'StartsMusicBatch/1.0' }
            if ($r) { return $r }
        } catch { }
    }
    return $null
}

function Load-Radio([string]$query) {
    $script:mode = 'radio'
    $SearchRow.Visibility = 'Visible'
    Show-List @() 'Recherche des stations en cours...'
    $win.Dispatcher.Invoke([action]{}, [Windows.Threading.DispatcherPriority]::Render) | Out-Null

    $r = Get-Radios $query
    if ($null -eq $r) {
        Show-List @() "Le service de radios ne répond pas. Vérifiez votre connexion, puis relancez la recherche."
        return
    }
    $data = $r | Where-Object { $_.url_resolved -or $_.url } | ForEach-Object {
        $parts = @()
        if ($_.country) { $parts += $_.country }
        if ($_.tags)    { $parts += (($_.tags -split ',') | Select-Object -First 2) -join ', ' }
        [pscustomobject]@{
            Name    = $_.name.Trim()
            Sub     = ($parts -join ', ')
            Tag     = $(if ($_.bitrate -gt 0) { "$($_.bitrate) kbps" } else { '' })
            Uri     = $(if ($_.url_resolved) { $_.url_resolved } else { $_.url })
            IsRadio = $true
        }
    }
    Show-List $data "Aucune station ne correspond à cette recherche."
}

function Resolve-Stream([string]$u) {
    if ($u -match '\.(pls|m3u)(\?|$)') {
        try {
            $c = (Invoke-WebRequest -Uri $u -TimeoutSec 8 -UseBasicParsing).Content
            $line = ($c -split "`n" | Where-Object { $_ -match 'https?://' } | Select-Object -First 1)
            if ($line) { return (($line -replace '^\s*File\d+\s*=', '') -replace '\s+$', '').Trim() }
        } catch { }
    }
    return $u
}

function Set-PlayGlyph { $BtnPlay.Content = $(if ($script:playing) { '❚❚' } else { '▶' }) }

function Play-Index([int]$i) {
    if ($script:items.Count -eq 0) { return }
    if ($i -lt 0 -or $i -ge $script:items.Count) { return }
    $script:index = $i
    $List.SelectedIndex = $i
    $it = $script:items[$i]

    $LblTitle.Text = $it.Name
    $LblSub.Text   = $(if ($it.IsRadio) { 'Radio en direct' } else { 'Fichier local' })
    $script:live   = [bool]$it.IsRadio
    $script:duration = 0
    $Seek.Value = 0
    $LblPos.Text = '0:00'
    $LblDur.Text = $(if ($script:live) { 'direct' } else { '0:00' })

    $target = $it.Uri
    if ($it.IsRadio) {
        $LblSub.Text = 'Connexion à la station...'
        $win.Dispatcher.Invoke([action]{}, [Windows.Threading.DispatcherPriority]::Render) | Out-Null
        $target = Resolve-Stream $target
    }

    try {
        $player.Open([uri]$target)
        $player.Play()
        $script:playing = $true
    } catch {
        $LblSub.Text = 'Lecture impossible pour cette source'
        $script:playing = $false
    }
    Set-PlayGlyph
}

function Step([int]$d) {
    if ($script:items.Count -eq 0) { return }
    $n = $script:index + $d
    if ($n -lt 0) { $n = $script:items.Count - 1 }
    if ($n -ge $script:items.Count) { $n = 0 }
    Play-Index $n
}

# ---------------------------------------------------------------- événements
$win.FindName('TitleBar').Add_MouseLeftButtonDown({ $win.DragMove() })
$win.FindName('BtnClose').Add_Click({ $win.Close() })
$win.FindName('BtnMin').Add_Click({ $win.WindowState = 'Minimized' })

$win.FindName('NavFiles').Add_Click({ Load-Files })
$win.FindName('NavRadio').Add_Click({ Load-Radio '' })
$win.FindName('BtnReload').Add_Click({ if ($script:mode -eq 'files') { Load-Files } else { Load-Radio $TxtSearch.Text } })
$win.FindName('BtnFolder').Add_Click({ Start-Process explorer.exe $MusicDir })
$win.FindName('BtnSearch').Add_Click({ Load-Radio $TxtSearch.Text })
$TxtSearch.Add_KeyDown({ param($s, $e) if ($e.Key -eq 'Return') { Load-Radio $TxtSearch.Text } })

$List.Add_MouseDoubleClick({ if ($List.SelectedIndex -ge 0) { Play-Index $List.SelectedIndex } })

$BtnPlay.Add_Click({
    if ($script:index -lt 0) {
        Play-Index $(if ($List.SelectedIndex -ge 0) { $List.SelectedIndex } else { 0 })
        return
    }
    if ($script:playing) { $player.Pause(); $script:playing = $false }
    else { $player.Play(); $script:playing = $true }
    Set-PlayGlyph
})
$win.FindName('BtnStop').Add_Click({
    $player.Stop(); $script:playing = $false; $Seek.Value = 0; $LblPos.Text = '0:00'; Set-PlayGlyph
})
$win.FindName('BtnPrev').Add_Click({ Step -1 })
$win.FindName('BtnNext').Add_Click({ Step 1 })

$Vol.Add_ValueChanged({ $player.Volume = $Vol.Value })

$Seek.Add_PreviewMouseLeftButtonDown({
    param($s, $e)
    if ($script:duration -gt 0 -and -not $script:live) {
        $ratio = $e.GetPosition($s).X / $s.ActualWidth
        if ($ratio -lt 0) { $ratio = 0 }
        if ($ratio -gt 1) { $ratio = 1 }
        $player.Position = [TimeSpan]::FromSeconds($ratio * $script:duration)
    }
    $e.Handled = $true
})

$player.Add_MediaOpened({
    if ($player.NaturalDuration.HasTimeSpan) {
        $script:duration = $player.NaturalDuration.TimeSpan.TotalSeconds
        $LblDur.Text = Format-Time $script:duration
        $script:live = $false
    } else {
        $script:duration = 0
        $LblDur.Text = 'direct'
    }
    if ($script:index -ge 0 -and $script:items[$script:index].IsRadio) { $LblSub.Text = 'Radio en direct' }
})
$player.Add_MediaEnded({ Step 1 })
$player.Add_MediaFailed({ $LblSub.Text = 'Flux indisponible, essayez une autre source'; $script:playing = $false; Set-PlayGlyph })

$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(400)
$timer.Add_Tick({
    if ($script:playing) {
        $p = $player.Position.TotalSeconds
        $LblPos.Text = Format-Time $p
        if ($script:duration -gt 0) { $Seek.Value = ($p / $script:duration) * 1000 }
    }
})
$timer.Start()

Load-Files
$win.Add_Closed({ $timer.Stop(); $player.Close() })
$win.ShowDialog() | Out-Null