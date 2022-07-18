module Database.Pool
  ( instantiateConnectionPool
  , withResource
  )
  where

import Data.Pool

import Hasql.Connection

instantiateConnectionPool :: Settings -> Int -> IO (Pool Connection)
instantiateConnectionPool _ _ = undefined
