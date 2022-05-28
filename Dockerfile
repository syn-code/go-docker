#https://www.youtube.com/watch?v=USbPCBi_d4U
#get latest golang image
FROM golang:latest

#set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 

#move to working directory /build
WORKDIR /build

#copy and download dependency using go mod
COPY go.mod .
#COPY go.sum .
RUN go mod download

#cope thecode into the contianer
COPY . .

#build hte application
RUN go build -o main .

#move to /dist directory as the place for resulting binary folder
WORKDIR /dist

#copy binary from build to main folder
RUN cp /build/main .

#export necessary port
EXPOSE 3000

#command to run when starting the container
CMD ["/dist/main"]




# RUN go build -o /out/example .
# FROM scratch AS bin
# COPY --from=build /out/example /

# FROM golang:1.14.3-alpine AS build
# WORKDIR /src
# COPY . .
# RUN go build -o /out/example .
# FROM scratch AS bin
# COPY --from=build /out/example /