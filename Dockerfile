#https://www.youtube.com/watch?v=USbPCBi_d4U
#get latest golang image
FROM golang:latest as base

#create another stage called "dev" that is based off of our "base" (so we have golang available to us)
FROM base as dev

#Install the air binary so we get live code-reloading when we save files
RUN curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh -s -- -b $(go env GOPATH)/bin

#set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64 

#move to working directory /opt/app/api
WORKDIR /opt/app/api

#copy and download dependency using go mod
COPY go.mod .
#COPY go.sum .
RUN go mod download

#cope the code into the contianer
COPY . .

#build hte application
# RUN go build -o main .

#move to /dist directory as the place for resulting binary folder
#WORKDIR /dist

#copy binary from build to main folder
# RUN cp /build/main .

#export necessary port
EXPOSE 3000

#command to run when starting the container
CMD ["air"]