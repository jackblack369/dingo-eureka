# Use the specified base image
# outer-base: dingodatabase/dingofs-base:rocky9 inner-base: harbor.zetyun.cn/dingofs/dingofs-base:rocky9
FROM dingodatabase/dingofs-base:rocky9 AS builder

# Create a working directory
WORKDIR /dingo-eureka

# Copy the project files to the working directory
COPY . .

# Build and install
RUN mkdir build && cd build && \
    cmake .. && \
    make -j 32

# Final stage
FROM dingodatabase/dingofs-base:rocky9

ENV THIRD_PARTY_INSTALL_PATH=/root/.local/dingo-eureka

# Copy installed files from builder
COPY --from=builder /root/.local/dingo-eureka /root/.local/dingo-eureka

