module VanillaBench (benchmarks) where

import Vanilla

import Criterion

benchmarks :: [Benchmark]
benchmarks =
    [ bench "main" (nfIO main)
    ]
