$audiodgProcess = Get-Process -Name audiodg -ErrorAction SilentlyContinue
$voicemeeterProcess = Get-Process | Where-Object {$_.ProcessName -like "*voicemeeter*"}

if ($null -eq $audiodgProcess -or $null -eq $voicemeeterProcess) {
    Write-Host "Le processus audiodg ou voicemeeter n'est pas en cours d'execution." -ForegroundColor Red
} else {

    $numberOfCores = (Get-WmiObject Win32_ComputerSystem).NumberOfLogicalProcessors
    $lastCoreAffinity = [math]::Pow(2, $numberOfCores - 1)
    $lastCoreAffinity = [IntPtr]::new($lastCoreAffinity)

    $audiodgProcess.ProcessorAffinity = $lastCoreAffinity
    $audiodgProcess.PriorityClass = "High"
    $voicemeeterProcess.ProcessorAffinity = $lastCoreAffinity
    $voicemeeterProcess.PriorityClass = "High"

    Write-Host "Laffinite et la priorite du processus audiodg et voicemeeter ont ete modifiees." -ForegroundColor Green
}