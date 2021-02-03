{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{-| HTTP benchmark test

This program read HTTP request(without parsing), and send some respond. You can use HTTP
benchmark tools such as ab or wrk to test IO throughput, remember to add a proper heap size
to improve performance (-Hx parammeter):

ulimit -n 10000
http-bench +RTS -H512M
wrk -c5000 http://localhost:8888

-}

module Main where

import Control.Monad
import Z.IO
import Z.IO.Network
import qualified Z.Data.Vector as V
import qualified Z.Data.ASCII as ASCII

main :: IO ()
main = startTCPServer defaultTCPServerConfig $ \ uvs ->  do
    i <- newBufferedInput uvs
    o <- newBufferedOutput uvs
    go i o
  where
    go i o = do
        bs <- readBuffer i
        unless (V.null bs) $ do
            let c = V.count ASCII.NEWLINE bs
            writeBuffer o (V.cycleN c "+PONG\r\n")
            flushBuffer o
            go i o





