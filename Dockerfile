FROM gcc:7.5.0 AS builder

RUN apt-get update && apt-get install cmake -y

WORKDIR /MMKV

COPY . .

WORKDIR /MMKV/POSIX/golang
RUN mkdir -p build && cd build && rm -rf ./* && \
    cmake .. -DCMAKE_INSTALL_PREFIX=. -DCMAKE_BUILD_TYPE=Release &&\
    make -j8 install

RUN uname -a > /MMKV/POSIX/golang/build/tencent.com/build_info.txt 2>&1 && \
    gcc -v >> /MMKV/POSIX/golang/build/tencent.com/build_info.txt 2>&1 && \
    cmake --version >> /MMKV/POSIX/golang/build/tencent.com/build_info.txt 2>&1

FROM scratch AS export-stage
COPY --from=builder /MMKV/POSIX/golang/build/tencent.com /tencent.com

