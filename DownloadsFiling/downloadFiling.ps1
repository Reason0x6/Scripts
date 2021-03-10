
$Location = "C:\Users\Reason6\Downloads"
$MOVEDCOUNT = 0
$FILESMOVED = @()

#Finding Files & Creating days sort folder
$files = Get-ChildItem -Path $Location -Attributes a
$date = Get-Date -Format "yyy_MM_dd"

if(Test-Path "C:\Users\Reason6\Downloads\$date"){
    Write-host "Todays Directory Found"
}else{
    [system.io.directory]::CreateDirectory("C:\Users\Reason6\Downloads\$date")
}


## File Sorting
$MOVEDCOUNT = 0
foreach($file in $files){
    $ext = $file.Extension
    $tempPath = "C:\Users\Reason6\Downloads\$date\$ext"

    if(Test-Path $tempPath){
        Write-host "$ext Directory Found"
    }else{
        [system.io.directory]::CreateDirectory($tempPath)
    }
    
    Move-Item -Path "C:\Users\Reason6\Downloads\$($file.Name)" -Destination "C:\Users\Reason6\Downloads\$date\$ext\$($file.Name)"

    #logging data for this file
    $MOVEDCOUNT += 1
    $TEMPARR = @("$($file.Name)`n")
    $FILESMOVED += $TEMPARR
}

# Entering file data into log file
$TimeStamp = Get-Date
"$TimeStamp -> $MOVEDCOUNT Files Moved:`n $FILESMOVED" >> "C:\Users\Reason6\Downloads\Logs\Updates.txt"

