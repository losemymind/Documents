@echo off
REM
REM download.bat
REM
REM Download file from remote dir
REM
REM

echo This script for download file and extract the file
echo download.bat [The file remote dir] [The file name,file name contains no suffix]
echo Usage:
echo     download.bat http://files.vagrantup.com/ precise32.box

set prefix=%1%
set filename=%2%

if "%prefix%"=="" (
echo File url is empty!!!
set/p prefix="Please input file url:"
)

if "%filename%"=="" (
echo File name is empty!!!
set/p filename="Please input file name:"
)

echo Downloading %filename% from %prefix%
%~d0
cd %~dp0
> temp.cs ECHO using System;
>> temp.cs ECHO using System.Net;
>> temp.cs ECHO using System.ComponentModel;
>> temp.cs ECHO class Program
>> temp.cs ECHO {
>> temp.cs ECHO     static string file = "%filename%";
>> temp.cs ECHO     static string url = "%prefix%/" + file;
>> temp.cs ECHO     static bool done = false;
>> temp.cs ECHO     static void Main(string[] args)
>> temp.cs ECHO     {
>> temp.cs ECHO         try
>> temp.cs ECHO         {
>> temp.cs ECHO             WebClient client = new WebClient();
>> temp.cs ECHO             client.Proxy = null;
>> temp.cs ECHO             client.DownloadProgressChanged += new DownloadProgressChangedEventHandler(DownloadProgressChanged);
>> temp.cs ECHO             client.DownloadFileCompleted += new AsyncCompletedEventHandler(DownloadFileCompleted);
>> temp.cs ECHO             Console.Write("Downloading " + file + ": 0%%    ");
>> temp.cs ECHO             client.DownloadFileAsync(new Uri(url), file);
>> temp.cs ECHO             while (!done) System.Threading.Thread.Sleep(500);
>> temp.cs ECHO         }
>> temp.cs ECHO         catch (Exception x)
>> temp.cs ECHO         {
>> temp.cs ECHO             Console.WriteLine("Error: " + x.Message);
>> temp.cs ECHO         }
>> temp.cs ECHO     }
>> temp.cs ECHO     static void DownloadProgressChanged(object sender, DownloadProgressChangedEventArgs e)
>> temp.cs ECHO     {
>> temp.cs ECHO         Console.Write("\rDownloading " + file + ": " + e.ProgressPercentage + "%%    ");
>> temp.cs ECHO     }
>> temp.cs ECHO     static void DownloadFileCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
>> temp.cs ECHO     {
>> temp.cs ECHO         Console.WriteLine("\rDownloading " + file + ": Done.    ");
>> temp.cs ECHO         done = true;
>> temp.cs ECHO     }
>> temp.cs ECHO }

if exist %windir%\Microsoft.NET\Framework\v2.0.50727\csc.exe (
    %windir%\Microsoft.NET\Framework\v2.0.50727\csc temp.cs
) else (
if exist %windir%\Microsoft.NET\Framework\v4.0.30319\csc.exe (
    %windir%\Microsoft.NET\Framework\v4.0.30319\csc temp.cs
) else (
    goto USE_VBS_AS_FALLBACK
))
temp.exe
del temp.cs
del temp.exe

