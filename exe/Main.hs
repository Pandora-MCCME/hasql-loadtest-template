module Main where

import Server (app)
import App.Options (options)

import Options.Applicative (execParser)

main :: IO ()
main = execParser options >>= app
