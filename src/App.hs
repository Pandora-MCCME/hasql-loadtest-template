{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE StrictData #-}
module App
  ( App(runApp)
  , Settings(..)
  , readSettings
  , Server
  )
  where

import System.Environment (getEnv)

import Control.Monad.Reader (MonadReader, ReaderT, MonadIO)
import Control.Monad.Except (MonadError)

import Data.ByteString.Char8 (pack)
import Data.Pool

import qualified Hasql.Connection as DB

import Servant (Handler, ServerT, ServerError)

import Database.Pool (instantiateConnectionPool)

import App.Options

data Settings = Settings {
  postgresConnectionString :: DB.Settings
, hasqlConnectionPool :: ~(Pool DB.Connection)
}

readSettings :: Options -> IO Settings
readSettings Options{..} = do
  postgresConnectionString <- pack <$> getEnv optionsConnectionStringVariable
  hasqlConnectionPool <- return undefined --instantiateConnectionPool postgresConnectionString optionsPoolSize
  return Settings{..}

newtype App a = App {runApp :: ReaderT Settings Handler a}
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader Settings, MonadError ServerError)
  via ReaderT Settings Handler

type Server api = ServerT api App
