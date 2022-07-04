{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Booleans where

import Servant.API (FromHttpApiData(..), ToHttpApiData(..))

import Data.Aeson.TH
import Data.Char (toLower)

class Enum a => IsNewBool a where

  fromBool :: Bool -> a
  fromBool = toEnum . fromEnum

  toBool :: a -> Bool
  toBool = toEnum . fromEnum

newBoolOptions :: forall a. (Enum a, Read a) => Options
newBoolOptions = defaultOptions
  { constructorTagModifier = map toLower . show . (/=) 0 . fromEnum . read @a
  }

data RunRelease = NoRelease | Release
  deriving (Eq, Enum, Read, Show, IsNewBool)

data RunTH = NoTH | WithTH
  deriving (Eq, Enum, Read, Show, IsNewBool)

data RunTransaction = Session | Transaction
  deriving (Eq, Enum, Read, Show, IsNewBool)

data RunList = RowVector | RowList
  deriving (Eq, Enum, Read, Show, IsNewBool)

instance {-# INCOHERENT #-} IsNewBool a => FromHttpApiData a where
  parseUrlPiece = fmap fromBool . parseUrlPiece

instance {-# INCOHERENT #-} IsNewBool a => ToHttpApiData a where
  toUrlPiece = toUrlPiece . toBool