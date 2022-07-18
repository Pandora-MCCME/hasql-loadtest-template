{-# LANGUAGE RecordWildCards #-}
module Database
  ( module Database.Query
  , run
  )
  where

import Control.Monad.Reader (ask)
import Control.Monad.IO.Class (liftIO)

import Database.Query
import Database.Run (connect, runIO, Statement)
import Database.Pool

import App
import App.Types

run :: RunTransaction -> RunRelease -> RunPool -> Statement () a -> App a
run mode releaseFlag pool stmt = do
  Settings{..} <- ask
  liftIO $ case pool of
    WithPool -> withResource hasqlConnectionPool
              $ runIO mode releaseFlag stmt
    WithoutPool -> connect postgresConnectionString
               >>= runIO mode releaseFlag stmt
