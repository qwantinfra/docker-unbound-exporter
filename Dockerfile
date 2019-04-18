FROM golang:1.10.2
MAINTAINER FOUCHARD Tony <t.fouchard@qwant.com>
ENV version b7e842d893d29200a5108eab717f5ab01d783c0c
RUN apt-get update
RUN go get github.com/kumina/unbound_exporter
WORKDIR /go/src/github.com/kumina/unbound_exporter
RUN git checkout ${version}
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/unbound_exporter -ldflags "-w -s -v -extldflags -static"
RUN strip /bin/unbound_exporter

FROM busybox:1.28.3
COPY --from=0 /bin/unbound_exporter /bin/unbound_exporter
CMD ["/bin/unbound_exporter"]
