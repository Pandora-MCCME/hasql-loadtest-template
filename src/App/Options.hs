module App.Options (Options(..), options) where

import Options.Applicative

data Options = Options {
    optionsPort :: Int
  , optionsConnectionStringVariable :: String
  , optionsPoolSize :: Int
  } deriving (Show, Eq)

optionsParser :: Parser Options
optionsParser = Options
  <$> option auto
      ( long "port"
     <> short 'p'
     <> metavar "PORT"
     <> value 9000
      )
  <*> option str
      ( long "db"
     <> short 'd'
     <> metavar "DATABASE"
     <> value "POSTGRES"
      )
  <*> option auto
      ( long "pool"
     <> short 's'
     <> metavar "POOL"
     <> value 80
      )

options :: ParserInfo Options
options = info (optionsParser <**> helper)
   ( fullDesc
  <> progDesc "Hasql testing service"
   )
