-----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- | 
-- | Module  : Main
-- | Author  : Xiao Ling
-- | Date    : 9/11/2016
-- |             
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

module Main where

 
import System.Directory
import Data.Text (Text, unpack, pack, splitOn)
import Data.Set  (Set, union, fromList, toList)
import qualified System.IO as S
import qualified Data.Conduit.Text as CT


import Src
import Lib
import Scripts

{-----------------------------------------------------------------------------
  Main
------------------------------------------------------------------------------}

inputs = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth"]

main :: IO ()
main = do
  main_count_phrase inputs
  main_count_words  inputs

main_count_phrase :: [String] -> IO ()
main_count_phrase wrds = do
  con        <- sysConfig
  let inpath = corpus con
  let weak   = weakStrong con
  let strong = strongWeak con

  count_phrase strong inpath "strong" `mapM` pset wrds
  count_phrase weak   inpath "weak"   `mapM` pset wrds
  return ()

pset :: Eq a => [a] -> [(a,a)]
pset xs = [(u,v) | u <- xs, v <- xs]

-- * query for word frequence of every word in here
main_count_words :: [String] -> IO ()
main_count_words wrds = do
  con <- sysConfig
  let inpath = corpus con ++ "vocab.txt"
  count_words inpath "words" wrds
  return ()

{-----------------------------------------------------------------------------
  Paths
------------------------------------------------------------------------------}

sysConfig :: IO Config
sysConfig = do
  d <- take 6 <$> getCurrentDirectory 
  if d == "/Users" then config_l
  else config_r


config_l :: IO Config
config_l = do
    Just con <- config corpus_l patterns_l
    return con

config_r :: IO Config
config_r = do
    Just con <- config corpus_r patterns_r
    return con

-- * local

corpus_l   = "/Users/lingxiao/Documents/research/data/ngrams/corpus/"
patterns_l = "/Users/lingxiao/Documents/research/code/stage/set-1/inputs/"

-- * remote
corpus_r   = "/nlp/data/xiao/ngrams/corpus/"
patterns_r = "/home1/l/lingxiao/xiao/stage/set-1/inputs"





















