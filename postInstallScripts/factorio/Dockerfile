FROM golang:alpine AS build

WORKDIR /app

COPY . .

RUN go mod download

# Builds the application as a staticly linked one, to allow it to run on alpine
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o factorio .

# Moving the binary to the 'final Image' to make it smaller
FROM alpine:latest

WORKDIR /app

# Create the `public` dir and copy all the assets into it
# RUN mkdir ./static
# COPY ./static ./static

# `boilerplate` should be replaced here as well
COPY --from=build /app .

# Exposes port 3000 because our program listens on that port
# EXPOSE 3000

CMD [ "./factorio", "-p", "./routines/factorio.json"]
