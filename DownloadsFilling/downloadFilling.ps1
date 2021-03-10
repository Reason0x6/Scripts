
$FILESCOUNT = 0

function run-Clean{
    Param (
        [parameter(Mandatory=$true)]
        [String]
        $Location
    )
    #$Location = "C:\Users\Reason6\Downloads"

    $MOVEDCOUNT = 0
    $FILESMOVED = @()

    #Finding Files & Creating days sort folder
    $files = Get-ChildItem -Path $Location -Attributes a

    if($files.count -eq $FILESCOUNT){
        return "No New Files"
    }
    $date = Get-Date -Format "yyy_MM_dd"

    if(Test-Path "$Location\$date"){
        Write-host "Todays Directory Found"
    }else{
        [system.io.directory]::CreateDirectory("$Location\$date")
    }


    ## File Sorting
    $MOVEDCOUNT = 0
    foreach($file in $files){
        $ext = $file.Extension
        $tempPath = "$Location\$date\$ext"

        if(Test-Path $tempPath){
            Write-host "$ext Directory Found"
        }else{
            [system.io.directory]::CreateDirectory($tempPath)
        }
        
        Move-Item -Path "$Location\$($file.Name)" -Destination "$Location\$date\$ext\$($file.Name)"

        #logging data for this file
        $MOVEDCOUNT += 1
        $TEMPARR = @("$($file.Name)`n")
        $FILESMOVED += $TEMPARR
    }

    # Entering file data into log file
    $TimeStamp = Get-Date
    "$TimeStamp -> $MOVEDCOUNT Files Moved:`n $FILESMOVED" >> "$Location\Logs\Updates.txt"

}



#Ghetto Timer for basic testing
while($true){
    run-Clean -Location "C:\Users\Reason6\Downloads"
    Start-Sleep(300)
}
