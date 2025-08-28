# Hive Metastore イメージのベース構築
FROM openjdk:8-jre-slim AS hive-metastore

# Hive/Metastore を動かすための最低限のツール導入（ダウンロード・疎通確認用）
RUN apt-get update && apt-get install -y \
    wget \
    procps \
    netcat \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 使用する Hadoop / Hive のバージョンを固定して再現性を確保
ENV HADOOP_VERSION=3.3.4
ENV HIVE_VERSION=3.1.3

# Hive が S3 や Metastore を利用するための基盤として Hadoop を配置
RUN wget -q https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ \
    && mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop \
    && rm hadoop-${HADOOP_VERSION}.tar.gz

# Hive Metastore の本体を配置し CLI / Thrift サービスを利用可能にする
RUN wget -q https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
    && tar -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz -C /opt/ \
    && mv /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive \
    && rm apache-hive-${HIVE_VERSION}-bin.tar.gz

# Metastore が外部DB(PostgreSQL)に接続できるよう JDBC ドライバを追加
RUN wget -q https://jdbc.postgresql.org/download/postgresql-42.7.1.jar \
    && mv postgresql-42.7.1.jar /opt/hive/lib/

# MinIO(S3互換ストレージ) を扱うために必要なライブラリを導入
RUN wget -q https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.367/aws-java-sdk-bundle-1.12.367.jar \
    && mv aws-java-sdk-bundle-1.12.367.jar /opt/hive/lib/

RUN wget -q https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar \
    && mv hadoop-aws-3.3.4.jar /opt/hive/lib/

# Hadoop/Hive コマンドを直接利用できるように環境変数と PATH を設定
ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin

# Hive Metastore Thrift サービスが外部から利用できるようにポート公開
EXPOSE 9083


# Trino サーバー構築
FROM trinodb/trino:latest AS trino

# 外部から Trino に接続してクエリを実行できるようにポート公開
EXPOSE 8080
