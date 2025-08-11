$audiodgProcess = Get-Process -Name audiodg -ErrorAction SilentlyContinue
$voicemeeterProcess = Get-Process | Where-Object {$_.ProcessName -like "*voicemeeter*"}

if ($null -eq $audiodgProcess -or $null -eq $voicemeeterProcess) {
    Write-Host "The audiodg process or voicemeeter is not running." -ForegroundColor Red
} else {

    $numberOfCores = (Get-WmiObject Win32_ComputerSystem).NumberOfLogicalProcessors
    $lastCoreAffinity = [math]::Pow(2, $numberOfCores - 1)
    $lastCoreAffinity = [IntPtr]::new($lastCoreAffinity)

    $audiodgProcess.ProcessorAffinity = $lastCoreAffinity
    $audiodgProcess.PriorityClass = "High"
    $voicemeeterProcess.ProcessorAffinity = $lastCoreAffinity
    $voicemeeterProcess.PriorityClass = "High"

    Write-Host "Process affinity & priority of audiodg and voicemeeter has been updated" -ForegroundColor Blue
}
