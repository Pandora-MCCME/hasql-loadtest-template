module Server where

import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Servant
import System.IO

import API
import Handlers

port :: Port
port = 9000

mkApp :: IO Application
mkApp = return $ serve api server

app :: IO ()
app = runSettings settings . logStdoutDev =<< mkApp
  where settings =
          setPort port $
          setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show port)) $
          defaultSettings

server :: Server API
server = listHandler
    :<|> itemHandler
    :<|> flagHandler
    :<|> return NoContent
