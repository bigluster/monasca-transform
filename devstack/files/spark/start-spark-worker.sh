#!/usr/bin/env bash
. /opt/spark/current/conf/spark-env.sh
export EXEC_CLASS=org.apache.spark.deploy.worker.Worker
export INSTANCE_ID=1
export SPARK_CLASSPATH=/opt/spark/current/conf/:/opt/spark/current/lib/spark-assembly-1.6.1-hadoop2.6.0.jar:/opt/spark/current/lib/datanucleus-core-3.2.10.jar:/opt/spark/current/lib/datanucleus-rdbms-3.2.9.jar:/opt/spark/current/lib/datanucleus-api-jdo-3.2.6.jar
export log="$SPARK_LOG_DIR/spark-spark-"$EXEC_CLASS"-"$INSTANCE_ID"-127.0.0.1.out"
export SPARK_HOME=/opt/spark/current

start-stop-daemon -c spark:spark --pidfile /var/run/spark/spark-spark-"$EXEC_CLASS"-"$INSTANCE_ID".pid --name spark-worker --start --exec  /usr/bin/java -- -cp $SPARK_CLASSPATH $SPARK_DAEMON_JAVA_OPTS -Xms1g -Xmx1g -XX:MaxPermSize=256m "$EXEC_CLASS" --webui-port "$SPARK_WORKER_WEBUI_PORT" --port $SPARK_WORKER_PORT $SPARK_MASTERS >> "$log" 2>&1 < /dev/null
