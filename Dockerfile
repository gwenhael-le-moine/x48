FROM i386/alpine:3.11 AS build

#Install the necessary things to build x48
RUN apk update && apk add bzip2 make vim gcc libx11-dev autoconf automake libc6-compat man-pages xtrans libxau-dev libxdmcp-dev libx11-dev pkgconf libxt-dev g++

#Copy over the necessary files to build x48
WORKDIR /app
COPY configure.ac version.m4 Makefile.am autogen.sh INSTALL NEWS README AUTHORS ChangeLog ./
COPY src src
COPY romdump romdump
COPY rpm rpm
COPY ROMs ROMs
COPY utils utils
RUN ./autogen.sh
RUN ./configure
RUN make
RUN cd ROMs; bunzip2 *.bz2

#Squash the layers into a smaller image with only the necessary parts.
FROM i386/alpine:3.11 as final
WORKDIR /app
COPY --from=build /app/src/x48 .
COPY --from=build /app/ROMs ./
COPY --from=build /usr/lib/libX11.so.6 /usr/lib/libxcb.so.1 /usr/lib/libXau.so.6 /usr/lib/libXdmcp.so.6 /usr/lib/libbsd.so.0 /usr/lib/


ENTRYPOINT ["./x48","-quiet"]
CMD ["-rom", "gxrom-r"]
