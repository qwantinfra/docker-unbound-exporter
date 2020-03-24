FROM golang:1.14.1
MAINTAINER FOUCHARD Tony <t.fouchard@qwant.com>
ENV version 1739a339d3404a4164a5664dc38e328108c6a2a6
RUN apt-get update
RUN go get github.com/kumina/unbound_exporter
WORKDIR /go/src/github.com/kumina/unbound_exporter
RUN git checkout ${version}
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/unbound_exporter -ldflags "-w -s -v -extldflags -static"
RUN strip /bin/unbound_exporter

FROM busybox:1.28.3
COPY --from=0 /bin/unbound_exporter /bin/unbound_exporter
CMD ["/bin/unbound_exporter"]
