{-# LANGUAGE OverloadedStrings #-}
module Handlers where

import Control.Monad.IO.Class (liftIO)

import Servant

import Database
import Types

listHandler :: RunTransaction -> RunTH -> RunRelease -> RunList -> Handler [Result]
listHandler mode NoTH release RowList = liftIO $ run mode release listQuery
listHandler mode NoTH release RowVector = liftIO $ run mode release vectorQuery
listHandler mode WithTH release RowVector = liftIO $ run mode release vectorQueryTH
listHandler _ WithTH _ RowList =
  throwError err404 {errBody = "hasql-th does not provide listStatement."}

itemHandler :: RunTransaction -> RunTH -> RunRelease -> Handler Result
itemHandler mode NoTH release = liftIO $ run mode release itemQuery
itemHandler mode WithTH release = liftIO $ run mode release itemQueryTH

flagHandler :: RunTransaction -> RunTH -> RunRelease -> Handler Bool
flagHandler mode NoTH release = liftIO $ run mode release flagQuery
flagHandler mode WithTH release = liftIO $ run mode release flagQueryTH
