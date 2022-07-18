{-# LANGUAGE OverloadedStrings #-}
module Handlers where

import Servant

import App
import Database
import App.Types

listHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> RunList -> App [Result]
listHandler mode NoTH release pool RowList = run mode release pool listQuery
listHandler mode NoTH release pool RowVector = run mode release pool vectorQuery
listHandler mode WithTH release pool RowVector = run mode release pool vectorQueryTH
listHandler _ WithTH _ _ RowList =
  throwError err404 {errBody = "hasql-th does not provide listStatement."}

itemHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> App Result
itemHandler mode NoTH release pool = run mode release pool itemQuery
itemHandler mode WithTH release pool = run mode release pool itemQueryTH

flagHandler :: RunTransaction -> RunTH -> RunRelease -> RunPool -> App Bool
flagHandler mode NoTH release pool = run mode release pool flagQuery
flagHandler mode WithTH release pool = run mode release pool flagQueryTH
