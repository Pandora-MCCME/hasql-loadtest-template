FROM debian

RUN apt-get update && apt-get install -y \
	dumb-init \
	curl \
	librsvg2-2 \
	libpq5 \
	libtinfo5 \
	build-essential \
	locales \
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i '/ru_RU.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:ru  
ENV LC_ALL ru_RU.UTF-8

COPY bin bin
