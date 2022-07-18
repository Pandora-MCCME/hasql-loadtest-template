{-# LANGUAGE RecordWildCards #-}
module Database.Codec
  ( module Database.Codec
  , E.noParams
  )
  where

import Data.Vector (Vector, toList)

import qualified Hasql.Decoders as D
import qualified Hasql.Encoders as E

import App.Types

resultTHDecoder :: (Int64, Text, Maybe Text, Maybe Text) -> Result
resultTHDecoder ( resultF1
                , resultF2
                , resultF3
                , resultF4
                ) = Result{..}

resultVectorTHDecoder :: Vector (Int64, Text, Maybe Text, Maybe Text) -> [Result]
resultVectorTHDecoder = map resultTHDecoder . toList

boolDecoder :: D.Result Bool
boolDecoder = D.singleRow $ D.column (D.nonNullable D.bool)

resultDecoder :: D.Row Result
resultDecoder = Result
            <$> D.column (D.nonNullable D.int8)
            <*> D.column (D.nonNullable D.text)
            <*> D.column (D.nullable D.text)
            <*> D.column (D.nullable D.text)

resultSingletonDecoder :: D.Result Result
resultSingletonDecoder = D.singleRow resultDecoder

resultListDecoder :: D.Result [Result]
resultListDecoder = D.rowList resultDecoder

resultVectorDecoder :: D.Result [Result]
resultVectorDecoder = fmap toList $! D.rowVector resultDecoder
