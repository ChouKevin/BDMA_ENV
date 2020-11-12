FROM base_os

WORKDIR ${APP_PATH}
EXPOSE 8888
RUN pip3 install jupyterlab


CMD jupyter lab --ip 0.0.0.0 --no-browser --allow-root