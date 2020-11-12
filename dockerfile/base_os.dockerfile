# spark use java 8/11
FROM openjdk:8

ARG app_path
WORKDIR ${app_path}

ARG spark_package_name
COPY ${spark_package_name} ./${spark_package_name}

#install python
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip

# install required dependencies
RUN pip3 install py4j numpy

ENV APP_PATH ${app_path}
ENV SPARK_HOME ${app_path}/${spark_package_name}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3
ENV PYTHONPATH $SPARK_HOME/python/:$PYTHONPATH