#!/bin/bash
app_path="/BDMA"

# spark hadoop version
# https://spark.apache.org/downloads.html
spark_version=3.0.1
hadoop_version=2.7
spark_package_name=spark-${spark_version}-bin-hadoop${hadoop_version}
spark_package_url=https://downloads.apache.org/spark/spark-${spark_version}/${spark_package_name}.tgz

if [ -d ${spark_package_name} ]; then
    echo "${spark_package_name} exists."
else
    if [ -f "${spark_package_name}.tgz" ]; then
        echo "${spark_package_name}.tgz exists."
    else
        echo "downloading ${spark_package_name}.tgz."
        if wget ${spark_package_url}
        then
            tar -xf ${spark_package_name}.tgz
            rm ${spark_package_name}.tgz
        else
            echo "Can't download file. Please go to this site for downloading the file \
                  and putting it under the BDMA folder"
            echo "${spark_package_url}"
            exit 1
        fi
    fi
fi

docker build --build-arg spark_package_name="${spark_package_name}" \
             --build-arg app_path="${app_path}" \
             --network=host \
             -f dockerfile/base_os.dockerfile \
             -t base_os .

docker build --network=host \
             -f dockerfile/master.dockerfile \
             -t spark_master .

docker build --network=host \
             -f dockerfile/worker.dockerfile \
             -t spark_worker .

docker build --network=host \
             -f dockerfile/jupyterlab.dockerfile \
             -t jupyter_lab .

docker build --network=host \
             -f dockerfile/nginx.dockerfile \
             -t ssl_nginx .