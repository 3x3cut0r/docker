FROM nginx:stable-alpine
LABEL maintainer="Julian Reith <julianreith@gmx.de>"
LABEL description="404 error page - based on nginx"

# copy html content
COPY html /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/template && \
    cp /usr/share/nginx/html/index.html /usr/share/nginx/template/index.html

WORKDIR /usr/share/nginx/html

# set environment variables
ENV TZ="UTC" \
    TITLE="404 Not Found" \
    LINK="https://404.3x3cut0r.de" \
    BG="#141019" \
    BG-PRIMARY="#908392" \
    BG-SECONDARY="#0d060e" \
    GROUND-TOP="#2F1829" \
    GROUND-BOTTOM="#2F1829" \
    GROUND-RIGHT="#2F1829" \
    GROUND-LEFT="#2F1829" \
    NUMBER-LEFT-TOP="#3B223C" \
    NUMBER-LEFT-BOTTOM="#2F1829" \
    NUMBER-LEFT-REFLECTION="white" \
    NUMBER-MIDDLE-TOP="#3B223C" \
    NUMBER-MIDDLE-BOTTOM="#2F1829" \
    NUMBER-MIDDLE-LEAF-TOP="#2F1829" \
    NUMBER-MIDDLE-LEAF-BOTTOM="#3B223C" \
    NUMBER-RIGHT-TOP="#3B223C" \
    NUMBER-RIGHT-BOTTOM="#2F1829" \
    NUMBER-RIGHT-REFLECTION="white" \
    SHRUB-MIDDLE="#982245" \
    SHRUB-RIGHT="#982245" \
    SHRUB-LEFT="#982245" \
    LEAF-1="#FFADAE" \
    LEAF-2="#F3475C" \
    LEAF-3="#FFCA51" \
    LEAF-RIGHT="#2F1829" \
    LEAF-MIDDLE="black" \
    LEAF-MIDDLE-RIGHT="#2F1829" \
    LEAF-MIDDLE-LEFT="#2F1829" \
    LEAF-LEFT="black" \
    CLOUD-BG-TOP="#FEF5DA" \
    CLOUD-BG-BOTTOM="#E8D197" \
    CLOUD-BG-RIGHT="#FEF5DA" \
    CLOUD-BG-RIGHT-SHADOW="#E8D197" \
    CLOUD-BG-LEFT="#FEF5DA" \
    CLOUD-BG-LEFT-SHADOW="#E8D197" \
    CLOUD-RIGHT-TOP="white" \
    CLOUD-RIGHT-BOTTOM="white" \
    CLOUD-RIGHT-TOP-SHADOW="white" \
    CLOUD-LEFT-TOP="white" \
    CLOUD-LEFT-BOTTOM="white" \
    CLOUD-LEFT-TOP-SHADOW="white" \
    MAN-HAIR="#2F172B" \
    MAN-SHIRT="#FFCA51" \
    MAN-SLEEVE-LEFT="#2F1829" \
    MAN-SLEEVE-RIGHT="#2F1829" \
    MAN-PANTS="#2F1829" \
    MAN-PANTS-LEFT="#4C3146" \
    MAN-PANTS-RIGHT="#4C3146" \
    MAN-SHOE-LEFT="#1F3247" \
    MAN-SHOE-LEFT-TOP="#122230" \
    MAN-SHOE-RIGHT="#1F3247" \
    MAN-FLASHLIGHT="#2F1829" \
    MAN-FLASHLIGHT-NEAR="white" \
    MAN-FLASHLIGHT-FAR="white" \
    MAN-FLASHLIGHT-SHADOW="white" \
    WOMAN-HAIR="#2F1829" \
    WOMAN-PONY="#2F1829" \
    WOMAN-SHIRT="#F5B539" \
    WOMAN-PANTS="#2F1829" \
    WOMAN-SHOE-LEFT="#1F3247" \
    WOMAN-SHOE-RIGHT="#1F3247" \
    WOMAN-SHOE-RIGHT-TOP="white" \
    WOMAN-FLASHLIGHT="#2F1829" \
    WOMAN-FLASHLIGHT-NEAR="white" \
    WOMAN-FLASHLIGHT-FAR="white" 

VOLUME /usr/share/nginx/html

# add docker-entrypoint.sh
COPY ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:80 || exit 1