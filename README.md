## Benchmarks

[![Linux Build Status](https://github.com/ZHaskell/benchmarks/workflows/ubuntu-ci/badge.svg)](https://github.com/ZHaskell/benchmarks/actions) [![MacOS Build Status](https://github.com/ZHaskell/benchmarks/workflows/osx-ci/badge.svg)](https://github.com/ZHaskell/benchmarks/actions) [![Windows Build Status](https://github.com/ZHaskell/benchmarks/workflows/win-ci/badge.svg)](https://github.com/ZHaskell/benchmarks/actions)

Benchmarks to monitor [Z.Haskell](https://github.com/haskell-Z/Z) libraries' performance:

* redis-bench, benchmark network performance with redis benchmark tools.

```
# start redis PING-PONG server with Haskell base lib
cabal run redis-benchmark-base
# start redis PING-PONG server with Z.Haskell lib
cabal run redis-benchmark-z
# start redis PING-PONG server with golang
cd redis-benchmark/tcp_golang
go build main.go
./main 8888
# start redis PING-PONG server with rust mio
cd redis-benchmark/tcp_mio
cargo build
target/debug/tcp_mio 8888
# start redis PING-PONG server with libuv
cd redis-benchmark/tcp_uv
./build.sh
./build/tcp_uv 8888

# run redis-benchmark from redis package
redis-benchmark -p 8888 -t ping -n 100000 -q
```

* json-bench, benchmark JSON encoding and decoding performance.
    
```
cabal run json-benchmark
```
    
