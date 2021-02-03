{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE DeriveAnyClass #-}

{- | Benchmark JSON encoding and decoding speed

On my MBP13 2020, 2 GHz Quad-Core Intel Core i5

benchmarking encode/twitter100-aeson
time                 242.9 μs   (242.0 μs .. 243.9 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 244.4 μs   (243.2 μs .. 247.4 μs)
std dev              6.089 μs   (2.797 μs .. 10.75 μs)
variance introduced by outliers: 18% (moderately inflated)

benchmarking encode/twitter100-z
time                 131.6 μs   (131.1 μs .. 132.1 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 131.3 μs   (130.8 μs .. 131.9 μs)
std dev              1.846 μs   (1.481 μs .. 2.493 μs)

benchmarking encode/jp100-aeson
time                 251.0 μs   (250.0 μs .. 252.1 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 251.4 μs   (250.5 μs .. 253.0 μs)
std dev              3.860 μs   (2.710 μs .. 6.565 μs)

benchmarking encode/jp100-z
time                 135.2 μs   (134.7 μs .. 135.9 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 135.8 μs   (134.8 μs .. 137.9 μs)
std dev              4.310 μs   (2.462 μs .. 7.448 μs)
variance introduced by outliers: 29% (moderately inflated)

benchmarking encode/geometry-aeson
time                 2.156 ms   (2.134 ms .. 2.178 ms)
                     0.998 R²   (0.995 R² .. 1.000 R²)
mean                 2.206 ms   (2.177 ms .. 2.279 ms)
std dev              145.6 μs   (66.45 μs .. 274.3 μs)
variance introduced by outliers: 48% (moderately inflated)

benchmarking encode/geometry-z
time                 1.564 ms   (1.549 ms .. 1.584 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 1.566 ms   (1.558 ms .. 1.576 ms)
std dev              28.40 μs   (19.41 μs .. 37.25 μs)

benchmarking encode/github-aeson
time                 260.1 μs   (257.4 μs .. 262.4 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 257.4 μs   (256.6 μs .. 258.6 μs)
std dev              3.520 μs   (2.563 μs .. 4.744 μs)

benchmarking encode/github-z
time                 151.4 μs   (149.9 μs .. 153.6 μs)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 150.6 μs   (149.8 μs .. 151.9 μs)
std dev              3.374 μs   (2.044 μs .. 5.198 μs)
variance introduced by outliers: 17% (moderately inflated)

benchmarking encode/buffer-builder-aeson
time                 562.9 μs   (560.0 μs .. 565.1 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 565.2 μs   (563.2 μs .. 569.9 μs)
std dev              10.21 μs   (6.531 μs .. 17.05 μs)

benchmarking encode/buffer-builder-z
time                 357.2 μs   (351.4 μs .. 366.3 μs)
                     0.998 R²   (0.996 R² .. 1.000 R²)
mean                 353.9 μs   (352.1 μs .. 357.1 μs)
std dev              7.881 μs   (4.374 μs .. 13.42 μs)
variance introduced by outliers: 15% (moderately inflated)

benchmarking typed encode/twitter100-aeson
time                 402.3 μs   (400.9 μs .. 404.0 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 403.5 μs   (401.7 μs .. 406.5 μs)
std dev              7.956 μs   (3.719 μs .. 12.71 μs)
variance introduced by outliers: 12% (moderately inflated)

benchmarking typed encode/twitter100-z
time                 99.06 μs   (98.61 μs .. 99.58 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 99.60 μs   (98.96 μs .. 100.7 μs)
std dev              2.653 μs   (1.733 μs .. 4.391 μs)
variance introduced by outliers: 24% (moderately inflated)

benchmarking typed encode/jp100-aeson
time                 398.9 μs   (396.6 μs .. 402.0 μs)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 400.5 μs   (397.8 μs .. 405.9 μs)
std dev              12.11 μs   (5.418 μs .. 22.66 μs)
variance introduced by outliers: 24% (moderately inflated)

benchmarking typed encode/jp100-z
time                 104.2 μs   (102.9 μs .. 105.3 μs)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 103.7 μs   (103.1 μs .. 104.4 μs)
std dev              2.117 μs   (1.755 μs .. 2.684 μs)
variance introduced by outliers: 16% (moderately inflated)

benchmarking decode/twitter100-aeson
time                 1.045 ms   (1.039 ms .. 1.053 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 1.042 ms   (1.037 ms .. 1.054 ms)
std dev              27.39 μs   (15.38 μs .. 48.72 μs)
variance introduced by outliers: 15% (moderately inflated)

benchmarking decode/twitter100-z
time                 361.0 μs   (357.0 μs .. 367.1 μs)
                     0.999 R²   (0.997 R² .. 1.000 R²)
mean                 360.3 μs   (358.7 μs .. 364.2 μs)
std dev              7.478 μs   (4.315 μs .. 14.09 μs)
variance introduced by outliers: 12% (moderately inflated)

benchmarking decode/jp100-aeson
time                 1.455 ms   (1.415 ms .. 1.517 ms)
                     0.994 R²   (0.985 R² .. 0.999 R²)
mean                 1.420 ms   (1.407 ms .. 1.450 ms)
std dev              61.71 μs   (34.56 μs .. 108.4 μs)
variance introduced by outliers: 31% (moderately inflated)

benchmarking decode/jp100-z
time                 445.0 μs   (443.2 μs .. 447.0 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 446.5 μs   (445.2 μs .. 447.9 μs)
std dev              4.865 μs   (4.050 μs .. 6.345 μs)

benchmarking decode/geometry-aeson
time                 1.949 ms   (1.943 ms .. 1.954 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.950 ms   (1.943 ms .. 1.958 ms)
std dev              23.32 μs   (17.66 μs .. 34.08 μs)

benchmarking decode/geometry-z
time                 710.7 μs   (704.2 μs .. 716.6 μs)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 711.0 μs   (707.6 μs .. 716.1 μs)
std dev              14.44 μs   (10.45 μs .. 22.72 μs)
variance introduced by outliers: 11% (moderately inflated)

benchmarking decode/github-aeson
time                 1.302 ms   (1.296 ms .. 1.307 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.297 ms   (1.293 ms .. 1.302 ms)
std dev              14.45 μs   (10.36 μs .. 20.48 μs)

benchmarking decode/github-z
time                 401.3 μs   (397.4 μs .. 406.5 μs)
                     0.998 R²   (0.993 R² .. 1.000 R²)
mean                 402.3 μs   (399.2 μs .. 410.7 μs)
std dev              15.79 μs   (6.401 μs .. 30.58 μs)
variance introduced by outliers: 33% (moderately inflated)

benchmarking decode/buffer-builder-aeson
time                 2.547 ms   (2.532 ms .. 2.563 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 2.537 ms   (2.530 ms .. 2.547 ms)
std dev              28.47 μs   (22.86 μs .. 37.43 μs)

benchmarking decode/buffer-builder-z
time                 944.0 μs   (939.5 μs .. 948.5 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 942.0 μs   (938.8 μs .. 946.4 μs)
std dev              12.74 μs   (9.637 μs .. 20.84 μs)

benchmarking typed decode/twitter100-aeson
time                 1.645 ms   (1.636 ms .. 1.653 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 1.646 ms   (1.641 ms .. 1.651 ms)
std dev              18.20 μs   (14.48 μs .. 26.57 μs)

benchmarking typed decode/twitter100-z
time                 591.5 μs   (589.4 μs .. 593.5 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 591.8 μs   (589.6 μs .. 595.3 μs)
std dev              9.416 μs   (6.395 μs .. 15.15 μs)

benchmarking typed decode/jp100-aeson
time                 1.990 ms   (1.973 ms .. 2.005 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 1.971 ms   (1.965 ms .. 1.981 ms)
std dev              25.12 μs   (17.84 μs .. 35.94 μs)

benchmarking typed decode/jp100-z
time                 676.2 μs   (673.3 μs .. 681.0 μs)
                     0.999 R²   (0.996 R² .. 1.000 R²)
mean                 680.7 μs   (675.0 μs .. 693.5 μs)
std dev              27.11 μs   (13.51 μs .. 44.48 μs)
variance introduced by outliers: 32% (moderately inflated)
-}

import Control.DeepSeq
import Criterion.Main    (Benchmark, bench, bgroup, defaultMain, nf)
import Data.Aeson as A
import Data.Int
import Data.Word
import GHC.Generics
import Z.Data.JSON as J
import qualified Z.Data.Text as ZT
import qualified Data.Text as T
import qualified Data.ByteString  as B (readFile)
import qualified Z.IO.FileSystem  as Z (readFile)

main :: IO ()
main = do
    !twitter100 <- B.readFile "asset/json-data/twitter100.json"
    !twitter100' <- Z.readFile "asset/json-data/twitter100.json"
    let Just !v_twitter100 = A.decodeStrict @A.Value twitter100
        Right !v_twitter100' = J.decode' @J.Value twitter100'
        Just !v_twitter100_t = A.decodeStrict @ResultA twitter100
        Right !v_twitter100_t' = J.decode' @ResultZ twitter100'

    !jp100 <- B.readFile "asset/json-data/jp100.json"
    !jp100' <- Z.readFile "asset/json-data/jp100.json"
    let Just !v_jp100 = A.decodeStrict @A.Value jp100
        Right !v_jp100' = J.decode' @J.Value jp100'
        Just !v_jp100_t = A.decodeStrict @ResultA jp100
        Right !v_jp100_t' = J.decode' @ResultZ jp100'

    !geometry <- B.readFile "asset/json-data/geometry.json"
    !geometry' <- Z.readFile "asset/json-data/geometry.json"
    let Just !v_geometry = A.decodeStrict @A.Value geometry
        Right !v_geometry' = J.decode' @J.Value geometry'

    !github <- B.readFile "asset/json-data/github-issues.json"
    !github' <- Z.readFile "asset/json-data/github-issues.json"
    let Just !v_github = A.decodeStrict @A.Value github
        Right !v_github' = J.decode' @J.Value github'

    !bb <- B.readFile "asset/json-data/buffer-builder.json"
    !bb' <- Z.readFile "asset/json-data/buffer-builder.json"
    let Just !v_bb = A.decodeStrict @A.Value bb
        Right !v_bb' = J.decode' @J.Value bb'

    defaultMain
        [ bgroup "encode"
          [ bench "twitter100-aeson" $ nf A.encode v_twitter100
          , bench "twitter100-z" $ nf J.encode v_twitter100'
          , bench "jp100-aeson" $ nf A.encode v_jp100
          , bench "jp100-z" $ nf J.encode v_jp100'
          , bench "geometry-aeson" $ nf A.encode v_geometry
          , bench "geometry-z" $ nf J.encode v_geometry'
          , bench "github-aeson" $ nf A.encode v_github
          , bench "github-z" $ nf J.encode v_github'
          , bench "buffer-builder-aeson" $ nf A.encode v_bb
          , bench "buffer-builder-z" $ nf J.encode v_bb'
          ]
        , bgroup "typed encode"
          [ bench "twitter100-aeson" $ nf (A.encode @ResultA) v_twitter100_t
          , bench "twitter100-z" $ nf (J.encode @ResultZ) v_twitter100_t'
          , bench "jp100-aeson" $ nf (A.encode @ResultA) v_jp100_t
          , bench "jp100-z" $ nf (J.encode @ResultZ) v_jp100_t'
          ]
        , bgroup "decode"
          [ bench "twitter100-aeson" $ nf (A.decodeStrict @A.Value) twitter100
          , bench "twitter100-z" $ nf (J.decode' @J.Value) twitter100'
          , bench "jp100-aeson" $ nf (A.decodeStrict @A.Value) jp100
          , bench "jp100-z" $ nf (J.decode' @J.Value) jp100'
          , bench "geometry-aeson" $ nf (A.decodeStrict @A.Value) geometry
          , bench "geometry-z" $ nf (J.decode' @J.Value) geometry'
          , bench "github-aeson" $ nf (A.decodeStrict @A.Value) github
          , bench "github-z" $ nf (J.decode' @J.Value) github'
          , bench "buffer-builder-aeson" $ nf (A.decodeStrict @A.Value) bb
          , bench "buffer-builder-z" $ nf (J.decode' @J.Value) bb'
          ]
        , bgroup "typed decode"
          [ bench "twitter100-aeson" $ nf (A.decodeStrict @ResultA) twitter100
          , bench "twitter100-z" $ nf (J.decode' @ResultZ) twitter100'
          , bench "jp100-aeson" $ nf (A.decodeStrict @ResultA) jp100
          , bench "jp100-z" $ nf (J.decode' @ResultZ) jp100'
          ]
        ]

--------------------------------------------------------------------------------
newtype Metadata = Metadata {
    result_type :: T.Text
  } deriving (Eq, Show, Generic, A.ToJSON, A.FromJSON)

instance NFData Metadata

data Geo = Geo {
    type_       :: T.Text
  , coordinates :: (Double, Double)
  } deriving (Eq, Show, Generic, A.ToJSON, A.FromJSON)

instance NFData Geo

data Story = Story {
    from_user_id_str  :: T.Text
  , profile_image_url :: T.Text
  , created_at        :: T.Text -- ZonedTime
  , from_user         :: T.Text
  , id_str            :: T.Text
  , metadata          :: Metadata
  , to_user_id        :: Maybe Int64
  , text              :: T.Text
  , from_user_id      :: Int64
  , geo               :: Maybe Geo
  , iso_language_code :: T.Text
  , to_user_id_str    :: Maybe T.Text
  , source            :: T.Text
  } deriving (Show, Generic, A.ToJSON, A.FromJSON)

instance NFData Story

data ResultA = ResultA {
    results          :: [Story]
  , max_id           :: Int64
  , since_id         :: Int64
  , refresh_url      :: T.Text
  , next_page        :: T.Text
  , results_per_page :: Int
  , page             :: Int
  , completed_in     :: Double
  , since_id_str     :: T.Text
  , max_id_str       :: T.Text
  , query            :: T.Text
  } deriving (Show, Generic, A.ToJSON, A.FromJSON)

instance NFData ResultA
--------------------------------------------------------------------------------
newtype MetadataZ = MetadataZ {
    result_type :: ZT.Text
  } deriving (Eq, Show, Generic, JSON)

instance NFData MetadataZ

data GeoZ = GeoZ {
    type_       :: ZT.Text
  , coordinates :: (Double, Double)
  } deriving (Eq, Show, Generic, JSON)

instance NFData GeoZ

data StoryZ = StoryZ {
    from_user_id_str  :: ZT.Text
  , profile_image_url :: ZT.Text
  , created_at        :: ZT.Text -- ZonedTime
  , from_user         :: ZT.Text
  , id_str            :: ZT.Text
  , metadata          :: MetadataZ
  , to_user_id        :: Maybe Int64
  , text              :: ZT.Text
  , from_user_id      :: Int64
  , geo               :: Maybe GeoZ
  , iso_language_code :: ZT.Text
  , to_user_id_str    :: Maybe ZT.Text
  , source            :: ZT.Text
  } deriving (Show, Generic, JSON)

instance NFData StoryZ

data ResultZ = ResultZ {
    results          :: [StoryZ]
  , max_id           :: Int64
  , since_id         :: Int64
  , refresh_url      :: ZT.Text
  , next_page        :: ZT.Text
  , results_per_page :: Int
  , page             :: Int
  , completed_in     :: Double
  , since_id_str     :: ZT.Text
  , max_id_str       :: ZT.Text
  , query            :: ZT.Text
  } deriving (Show, Generic, JSON)

instance NFData ResultZ
