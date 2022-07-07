module Main where

import Server (app, options)

import Options.Applicative (execParser)

main :: IO ()
main = execParser options >>= app
