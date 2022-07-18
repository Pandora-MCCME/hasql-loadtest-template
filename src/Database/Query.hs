{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
module Database.Query where

import Database.Codec
import App.Types

import Hasql.Statement
import Hasql.TH

flagQueryTH :: Statement () Bool
flagQueryTH = [singletonStatement| SELECT 't'::bool |]

flagQuery :: Statement () Bool
flagQuery = Statement sql noParams boolDecoder False
  where
    sql = "SELECT 't'::bool"

itemQueryTH :: Statement () Result
itemQueryTH = refineResult (Right . resultTHDecoder) $
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

itemQuery :: Statement () Result
itemQuery = Statement sql noParams resultSingletonDecoder False
  where
    sql = "\
    \SELECT id :: int8\
         \, name :: text\
         \, color :: text\
         \, background :: text \
         \FROM objects \
    \WHERE flag \
    \ORDER BY orderc, id \
    \LIMIT 1\
    \"

vectorQueryTH :: Statement () [Result]
vectorQueryTH = refineResult (Right . resultVectorTHDecoder) $
  [vectorStatement|
  SELECT id :: int8
       , name :: text
       , color :: text?
       , background :: text?
  FROM objects
  WHERE flag
  ORDER BY orderc, id
  |]

listQuery :: Statement () [Result]
listQuery = Statement sql noParams resultListDecoder False
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

vectorQuery :: Statement () [Result]
vectorQuery = Statement sql noParams resultVectorDecoder False
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
