#!/bin/sh -x

# COMPILE IT (on Arch Linux):
# aarch64-linux-gnu-gcc -static test.c -lpthread -o glibc-static.out
# aarch64-linux-gnu-gcc -lpthread test.c -o glibc.out

# In arm64v8/alpine Docker container: (no aarch64-linux-gnu-musl on Arch Linux)
# apk add gcc musl-dev
# gcc test.c -o musl.out
# gcc -static test.c -o musl-static.out

# glibc binary (glibc.out & glibc-static.out): glibc 2.32
# glibc qemu (qemu-aarch64): qemu 5.1.0

# musl binary (musl.out & musl-static.out): musl 1.1.24
# musl qemu (qemu-aarch64-static): qemu 5.1.0


echo ------ glibc qemu + glibc binary ------
qemu-aarch64 /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 --library-path "/usr/aarch64-linux-gnu/lib:/usr/aarch64-linux-gnu/lib64" ./glibc.out

echo ------ musl qemu + glibc binary ------
qemu-aarch64-static /usr/aarch64-linux-gnu/lib/ld-linux-aarch64.so.1 --library-path "/usr/aarch64-linux-gnu/lib:/usr/aarch64-linux-gnu/lib64" ./glibc.out

echo ------ glibc qemu + glibc static binary ------
qemu-aarch64 ./glibc-static.out

echo ------ musl qemu + glibc static binary ------
qemu-aarch64-static ./glibc-static.out

echo ------ glibc qemu + musl binary ------
qemu-aarch64 ./ld-musl-aarch64.so.1 ./musl.out

echo ------ musl qemu + musl binary ------
qemu-aarch64-static ./ld-musl-aarch64.so.1 ./musl.out

echo ------ glibc qemu + musl static binary ------
qemu-aarch64 ./musl-static.out

echo ------ musl qemu + musl static binary ------
qemu-aarch64-static ./musl-static.out
