FROM base_os

# Port for web UI (default: 8080 for master, 8081 for worker)
EXPOSE 8080

WORKDIR ${SPARK_HOME}
RUN mkdir logs
CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out
