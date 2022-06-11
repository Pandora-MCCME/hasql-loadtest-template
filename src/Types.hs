{-# LANGUAGE TemplateHaskell #-}
module Types
  ( module Types
  , Int64, Text
  )
  where

import Data.Aeson.TH

import Data.Text (Text)
import Data.Int (Int64)

data RunRelease = NoRelease | Release

data RunMode = Session | Transaction

data Result = Result {
  resultF1 :: Int64
, resultF2 :: Text
, resultF3 :: Bool
, resultF4 :: Bool
, resultF5 :: Maybe Text
, resultF6 :: Maybe Text
}
deriveJSON defaultOptions ''Result
