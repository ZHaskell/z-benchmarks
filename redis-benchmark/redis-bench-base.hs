{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Control.Monad (unless, forever, void)
import qualified Data.ByteString as S
import Network.Run.TCP
import Network.Socket.ByteString (recv, sendAll)
import Foreign.Storable (sizeOf)

main :: IO ()
main = runTCPServer Nothing "8888" talk
  where
    talk s = do
        msg <- recv s bufSiz
        unless (S.null msg) $ do
            let c = S.count 10 msg
            sendAll s (S.concat (replicate c "+PONG\r\n"))
            talk s

    bufSiz = 32*1024 - 2*(sizeOf (undefined :: Int))
