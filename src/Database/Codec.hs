{-# LANGUAGE RecordWildCards #-}
module Database.Codec
  ( module Database.Codec
  , E.noParams
  )
  where

import Data.Vector (Vector, toList)

import qualified Hasql.Decoders as D
import qualified Hasql.Encoders as E

import Types

resultTHDecoder :: (Int64, Text, Bool, Bool, Maybe Text, Maybe Text) -> Result
resultTHDecoder ( resultF1
                , resultF2
                , resultF3
                , resultF4
                , resultF5
                , resultF6
                ) = Result{..}

resultListTHDecoder :: Vector (Int64, Text, Bool, Bool, Maybe Text, Maybe Text) -> [Result]
resultListTHDecoder = map resultTHDecoder . toList

resultDecoder :: D.Row Result
resultDecoder = Result
            <$> D.column (D.nonNullable D.int8)
            <*> D.column (D.nonNullable D.text)
            <*> D.column (D.nonNullable D.bool)
            <*> D.column (D.nonNullable D.bool)
            <*> D.column (D.nullable D.text)
            <*> D.column (D.nullable D.text)

resultListDecoder :: D.Result [Result]
resultListDecoder = D.rowList resultDecoder
