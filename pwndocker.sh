#!/bin/bash
# 0xc4m3l

export DISABLE_AUTO_TITLE="true"

session="pwn"
path=$(pwd)
libc=$1

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run -d -it -h pwn --name pwn -v $(pwd):/ctf/work -p 22222:22222 --cap-add=SYS_PTRACE 0xc4m3l/pwndocker bash
docker exec -it pwn mkdir lib
docker exec -it pwn cp /glibc/"${libc}"/64/lib/ld-"${libc}".so /ctf/work/lib
docker exec -it pwn cp /glibc/"${libc}"/64/lib/libc.so.6 /ctf/work/lib
docker exec -it pwn patchelf --set-interpreter /ctf/work/lib/ld-"${libc}".so /ctf/work/pwn
docker exec -it pwn tmux
docker exec -it pwn bash