{-# LANGUAGE OverloadedStrings #-}
module Handlers where

import Servant

import App
import Database
import App.Types

listHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> RunList -> App [Result]
listHandler mode NoTH release _ RowList = run mode release listQuery
listHandler mode NoTH release _ RowVector = run mode release vectorQuery
listHandler mode WithTH release _ RowVector = run mode release vectorQueryTH
listHandler _ WithTH _ _ RowList =
  throwError err404 {errBody = "hasql-th does not provide listStatement."}

itemHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> App Result
itemHandler mode NoTH release _ = run mode release itemQuery
itemHandler mode WithTH release _ = run mode release itemQueryTH

flagHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> App Bool
flagHandler mode NoTH release _ = run mode release flagQuery
flagHandler mode WithTH release _ = run mode release flagQueryTH
