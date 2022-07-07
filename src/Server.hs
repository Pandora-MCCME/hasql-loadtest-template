{-# LANGUAGE RecordWildCards #-}
module Server where

import Options.Applicative

import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Servant
import System.IO

import API
import Handlers

data Options = Options {
    optionsPort :: Int
  } deriving (Show, Eq)

optionsParser :: Parser Options
optionsParser = Options
  <$> option auto
      ( long "port"
     <> short 'p'
     <> metavar "PORT"
     <> value 9000
      )

options :: ParserInfo Options
options = info (optionsParser <**> helper)
   ( fullDesc
  <> progDesc "Hasql testing service"
   )

mkApp :: IO Application
mkApp = return $ serve api server

app :: Options -> IO ()
app Options{..} = runSettings settings . logStdoutDev =<< mkApp
  where settings =
          setPort optionsPort $
          setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show optionsPort)) $
          defaultSettings

server :: Server API
server = listHandler
    :<|> itemHandler
    :<|> flagHandler
    :<|> return NoContent
