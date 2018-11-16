Set-Location $PSScriptRoot

$env:XDG_CONFIG_HOME = $PWD
$env:XDG_DATA_HOME   = $PWD

if (!(Test-Path function:_OldPrompt))
{
    function global:_OldPrompt { '' }
    $function:_OldPrompt = $function:prompt
}

function global:prompt
{
    Write-Host '(nvim) ' -NoNewline
    & $function:_OldPrompt
}
