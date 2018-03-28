@echo off

REM ## markdown 形式のファイルリストを作成する。
if exist mdlist.txt del mdlist.txt
for %%a in (source\*.md) do (
  echo %%a >> mdlist.txt
)

REM ## markdown 形式のファイルを reStructuredText 形式に
REM ## 変換するコマンドを羅列する。
echo @echo off > __md2rst.bat
for /f "tokens=1,2 delims=." %%a in (mdlist.txt) do (
  echo pandoc -f markdown -t rst -o %%a.rst %%a.%%b >> __md2rst.bat
)

REM ## md から rst に変換する。
call __md2rst.bat
del __md2rst.bat mdlist.txt

REM ## ついでに HTML も生成する。
make html
