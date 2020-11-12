# 簡介 #

BDMA課程的作業環境[here](https://myweb.ntut.edu.tw/~jhwang/BDM/ "here")
由於機台在校內，連網頁必須要使用ssl，此處使用nginx做代理，如不需ssl直接port mapping即可
(nginx的location只搞了一半.....)

目前只有spark環境，hdfs尚未建立

--------------

# 環境資訊 #

- Ubuntu 16.04
- 請先安裝docker, docker-compose
- Python 版本：Python 3
- Hadoop 版本：2.7
- Spark 版本：3.0.1
- VM版本請見 [here](https://140.124.183.8/107598035/Spark_auto_deploy "here") (不建議)
- 最後修改日期：2020/11/13

--------------

# 設定 #

- python 需要用到的 lib 請寫在 dockerfile/base_os
- spark 和 hadoop 的版本需要更改請到 build.sh 底下設定
- 若要更改 worker，請到 docker-compose.yaml 底下自行增減 services
- jupyter lab 預設密碼 878787，可到docker-compose.yaml自行設定

--------------

# 啟動 #

1. `bash build.sh`
2. `docker-compose up -d`
(關閉 docker-compose down)

--------------
# 注意事項 #

- 若在作業過程中發現lib不夠用需要新增，而改寫base_os.dockerfile，請重新build。
1. `bash clean.sh`
2. `bash build.sh`