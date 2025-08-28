param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

$ContainerName = "trino"

Write-Host "Running $FilePath inside container $ContainerName..."
docker cp -- $FilePath "${ContainerName}:/tmp/"
$Leaf = Split-Path -Leaf $FilePath
docker exec $ContainerName sh -c "trino --file /tmp/$Leaf"
Write-Host "Done."