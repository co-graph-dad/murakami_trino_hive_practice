Dataset: ECommerceFakeData by Sachin Gupta, licensed under Apache License 2.0

# Hive Metastore + Trino + MinIO データ操作練習環境

MinIO上でデータを管理し、Hive MetastoreでテーブルメタデータをTrinoから操作する環境です。

## アーキテクチャ

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    MinIO    │◄───┤Hive Metastore│◄───┤   Trino     │◄───┤   Client    │
│(Data Storage)│    │ (Metadata)  │    │ (Query)     │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       │                    │
       │            ┌─────────────┐
       │            │ PostgreSQL  │
       │            │(Metastore DB)│
       │            └─────────────┘
       │
 ┌─────────────┐
 │ orders.csv  │
 │   (1GB Data)│
 └─────────────┘
```

## サービス構成
- **MinIO**: オブジェクトストレージ（S3互換）- ローカル環境で動作
- **PostgreSQL**: Hive Metastoreのバックエンドデータベース  
- **Hive Metastore**: テーブルメタデータ管理
- **Trino**: 分散SQLクエリエンジン

## アクセス情報
- **MinIO Console**: http://localhost:9001 (minioadmin/minioadmin)
- **Trino Web UI**: http://localhost:8080
- **HiveServer2 Web UI**: http://localhost:10002
- **Hive Metastore**: thrift://localhost:9083
- **HiveServer2**: jdbc:hive2://localhost:10000

## ファイル構成

```
tr_hv_practice/
├── docker-compose.yml          # 全サービス定義
├── Dockerfile                  # マルチステージビルド（Hive、Trino）
├── trino/
│   ├── config.properties       # Trino基本設定
│   └── hive.properties         # Trinoカタログ設定
├── hive_metastore/
│   ├── hive-site.xml          # Hive設定
│   ├── core-site.xml          # Hadoop設定
│   ├── metastore-site.xml     # Metastore設定
│   └── hadoop-env.sh          # Hadoop環境変数
├── data/
│   └── orders.csv             # 注文データ（約1.1GB、470万行、15列構造）
└── scripts/
    ├── trino/
    │   ├── select.sql         # SQLクエリ例
    │   └── trino_run.ps1      # Trinoクエリ実行PowerShellスクリプト
    └── hive/
        ├── select.sql         # Hiveクエリ例
        └── hiveQL_run.ps1     # Hiveクエリ実行PowerShellスクリプト
```