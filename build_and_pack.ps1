$tools = ('qpakman','nav2json','fteqcc64')
$folder_pak = 'build_pak'
$folder_zip = 'build_zip'

function Add-Tools-Path
{
    $path = ([IO.Path]::Combine(".","set_path.ps1"))
    if ((Get-Command $path -ErrorAction SilentlyContinue) -ne $null)
    {
        Invoke-Expression -Command $path
    }
}

function Combine-Paths([string[]]$paths)
{
    return ([System.IO.Path]::Combine($paths))
}

function Check-Tools-Are-In-Path
{
    foreach($tool in $tools) 
    {
        if ((Get-Command $tool -ErrorAction SilentlyContinue) -eq $null)
        {
            Write-Host "ERROR: Unable to find ${tool}, make sure it is in path" -ForegroundColor Red
            return $FALSE
        }
    }
}

function Start-Pak
{
    Remove-Item $folder_pak -Recurse -ErrorAction SilentlyContinue
    New-Item $folder_pak -ItemType "directory"
}

function Build-Pak($name)
{
    Push-Location (Combine-Paths @($folder_pak,"contents"))
    
    try
    {   
        Start-Process "qpakman" -NoNewWindow -Wait -ArgumentList @("*","-o",(Combine-Paths @("..",$name)))
    }
    finally
    {
        Pop-Location
    }
}

function Copy-And-Create($from,$to)
{
    New-Item -ItemType File -Path $to -Force
    Copy-Item -Path $from -Destination $to
}

function Compile-QuakeC($arguments = "")
{
    if($arguments.length -GT 0) {
        Start-Process "fteqcc64" -WorkingDirectory "quakec" -NoNewWindow -Wait -ArgumentList $arguments
    } else {
        Start-Process "fteqcc64" -WorkingDirectory "quakec" -NoNewWindow -Wait
    }
}

function Convert-NavJson-To-Nav
{
    Push-Location (Combine-Paths @('.','bots','navigation'))
    
    try 
    {
        foreach($navjson in (Get-ChildItem -Path '.' -File -Filter "*.navjson"))
        {
            Start-Process "nav2json" -ArgumentList @("-nav","-ow",($navjson | Resolve-Path -Relative)) -NoNewWindow -Wait
        }
    }
    finally
    {
        Pop-Location
    }
}

function Copy-To-Folder-Relative($folderPath,$from,$to)
{
    if($path.GetType() -eq [String])
    {
        $file = $path
    }
    elseif($path.GetType() -eq [Object[]]) {
        $file = Combine-Paths $path
    }
    
    if($zipDest -EQ $null) {
        $zipDest = $path
    }
    
    if($zipDest.GetType() -eq [String])
    {
        $dest = Combine-Paths ($folderPath + @($zipDest))
    }
    elseif($zipDest.GetType() -eq [Object[]]) {
        $dest = Combine-Paths ($folderPath + $zipDest)
    }
    
    Copy-And-Create $file $dest
}

function Add-To-Pak($path)
{
    Copy-To-Folder-Relative @(".",$folder_pak,"contents") $path
}

function Add-To-Zip($path,$zipDest)
{
    Copy-To-Folder-Relative @(".",$folder_zip) $path $zipDest
}

function Add-To-Pak-Filter([string[]]$path,[string]$filter)
{
    foreach($file in (Get-ChildItem -Path (Combine-Paths $path) -File -Filter $filter))
    {
        Add-to-Pak ($file | Resolve-Path -Relative)
    }
}

function Build-Zip
{
    Compress-Archive -Path (Combine-Paths @(".",$folder_zip,"*")) -CompressionLevel "Optimal" -Destination "build.zip" -Force
}

function Main
{
    Add-Tools-Path
    
    if(Check-Tools-Are-In-Path -eq $FALSE) {
        return
    }
    
    # Clear the zip output folder
    Remove-Item $folder_zip -Recurse -ErrorAction SilentlyContinue
    New-Item $folder_zip -ItemType "directory"
    
    #Compile for regular quake
    Write-Host "Compiling QuakeC..."
    Compile-QuakeC
    
    Start-Pak
    
    Add-To-Pak @("progs.dat")
    Add-To-Pak @("mapdb.json")
    Add-To-Pak @("README.md")
    
    Build-Pak "pak_id1.pak"
    Add-To-Zip @($folder_pak,"pak_id1.pak") @("pak0.pak") #id1
     
    Add-To-Zip "README.md"
    
    Build-Zip
}

Main


