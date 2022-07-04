{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module Database.Query where

import Database.Codec
import Types

import Hasql.Statement
import Hasql.TH

-- Main test case.
queryMinimal :: Statement () Bool
queryMinimal = [singletonStatement| SELECT 'true'::bool |]

querySingular :: Statement () Result
querySingular = refineResult (Right . resultTHDecoder) $
  [singletonStatement|
  SELECT id :: int8
       , name :: text
       , color :: text?
       , background :: text?
  FROM objects
  WHERE flag
  ORDER BY orderc, id
  LIMIT 1
  |]

queryPseudoSingular :: Statement () [Result]
queryPseudoSingular = refineResult (Right . resultListTHDecoder) $
  [vectorStatement|
  SELECT id :: int8
       , name :: text
       , color :: text?
       , background :: text?
  FROM objects
  WHERE flag
  ORDER BY orderc, id
  LIMIT 1
  |]

queryTH :: Statement () [Result]
queryTH = refineResult (Right . resultListTHDecoder) $
  [vectorStatement|
  SELECT id :: int8
       , name :: text
       , color :: text?
       , background :: text?
  FROM objects
  WHERE flag
  ORDER BY orderc, id
  |]

query :: Statement () [Result]
query = Statement sql noParams resultListDecoder False
  where
    sql = "\
    \SELECT id :: int8\
         \, name :: text\
         \, color :: text\
         \, background :: text \
         \FROM objects \
    \WHERE flag \
    \ORDER BY orderc, id\
    \"
