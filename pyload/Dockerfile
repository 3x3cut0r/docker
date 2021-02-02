FROM writl/pyload:latest
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="pyload from writl/pyload with python-openssl for SSL/HTTPS support"

RUN apt-get update && apt-get install -y python-openssl

CMD ["/run.sh"]
