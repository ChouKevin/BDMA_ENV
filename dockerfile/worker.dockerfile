FROM base_os

WORKDIR ${SPARK_HOME}
RUN mkdir logs
# Port for web UI (default: 8080 for master, 8081 for worker)
EXPOSE 8081

# dont use RUN here because you need to start the spark master at beginning
# docker exec RUN command at building time, this will cause error
CMD bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> logs/spark-worker.out