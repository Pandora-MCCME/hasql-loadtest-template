{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeApplications #-}
module Server where

import Control.Monad.Reader

import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Servant
import System.IO

import API
import qualified App
import App.Options (Options(..))
import Handlers

mkApp :: Options -> IO Application
mkApp opts = App.readSettings opts >>= \s -> return $ serve api (server s)

app :: Options -> IO ()
app opts@Options{..} = runSettings settings . logStdoutDev =<< mkApp opts
  where settings =
          setPort optionsPort $
          setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show optionsPort)) $
          defaultSettings

server :: App.Settings -> Server API
server s = hoistServer (Proxy @API)
             (flip runReaderT s . App.runApp) appServer

appServer :: App.Server API
appServer = listHandler
       :<|> itemHandler
       :<|> flagHandler
       :<|> return NoContent
