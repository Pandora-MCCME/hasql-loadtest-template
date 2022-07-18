module Database.Pool
  ( instantiateConnectionPool
  , withResource
  )
  where

import Data.Pool

import Hasql.Connection

import Database.Run

instantiateConnectionPool :: Settings -> Int -> IO (Pool Connection)
instantiateConnectionPool postgres size = newPool poolConfig
  where
    poolConfig = PoolConfig {
      createResource = connect postgres
    , freeResource = release
    , poolCacheTTL = 5
    , poolMaxResources = size
    }
