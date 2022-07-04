{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Types
  ( module Types
  , module Booleans
  , Int64, Text
  )
  where

import Booleans

import Data.Aeson.TH
import Data.Text (Text)
import Data.Int (Int64)

deriveJSON (newBoolOptions @RunRelease) ''RunRelease
deriveJSON (newBoolOptions @RunTH) ''RunTH
deriveJSON (newBoolOptions @RunTransaction) ''RunTransaction
deriveJSON (newBoolOptions @RunList) ''RunList

data Result = Result {
  resultF1 :: Int64
, resultF2 :: Text
, resultF3 :: Maybe Text
, resultF4 :: Maybe Text
}
deriveJSON defaultOptions ''Result
