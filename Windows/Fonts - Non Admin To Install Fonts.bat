:: Running this script will add the security tab to C:\Windows\Fonts allowing non-administrators to install fonts.
attrib -r -s %systemroot%\fonts
takeown /F %systemroot%\fonts\ /A
cacls %systemroot%\fonts /E /G Users:F