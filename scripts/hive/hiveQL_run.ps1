
$FilePath = ".\select.sql"
$ContainerName = "hive-metastore"

Write-Host "Running $FilePath inside container $ContainerName..."

# ファイル名を取得
$Leaf = Split-Path -Leaf $FilePath

# ファイルをコンテナにコピー
docker cp $FilePath "${ContainerName}:/tmp/$Leaf"

# SQLファイルの内容を修正（hive.default → default）してHiveで実行
$ModifiedFile = "/tmp/${Leaf}_hive.sql"
docker exec $ContainerName sh -c "sed 's/hive\.default\./default./g' /tmp/$Leaf > $ModifiedFile"
$result = docker exec $ContainerName sh -c "/opt/hive/bin/hive -S -f $ModifiedFile 2>/dev/null | head -10"
Write-Output $result

Write-Host "Done."