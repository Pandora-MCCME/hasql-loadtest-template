{-# LANGUAGE RecordWildCards #-}
module Database
  ( module Database.Query
  , run
  )
  where

import Control.Monad.Reader (ask)
import Control.Monad.IO.Class (liftIO)

import Database.Query
import Database.Run (runIO, Statement)

import App
import App.Types

run :: RunTransaction -> RunRelease -> Statement () a -> App a
run mode releaseFlag stmt = do
  Settings{..} <- ask
  liftIO $ runIO postgresConnectionString mode releaseFlag stmt
