module Handlers where

import Control.Monad.IO.Class (liftIO)

import Servant (Handler)

import Database
import Types

sessionHandler :: Handler [Result]
sessionHandler = liftIO $ run Session NoRelease query

sessionMinimalHandler :: Handler Bool
sessionMinimalHandler = liftIO $ run Session Release queryMinimal

sessionTHHandler :: Handler [Result]
sessionTHHandler = liftIO $ run Session NoRelease queryTH

sessionReleasedHandler :: Handler [Result]
sessionReleasedHandler = liftIO $ run Session Release query

transactionHandler :: Handler [Result]
transactionHandler = liftIO $ run Transaction NoRelease query

transactionMinimalHandler :: Handler Bool
transactionMinimalHandler = liftIO $ run Transaction NoRelease queryMinimal

transactionSingularHandler :: Handler Result
transactionSingularHandler = liftIO $ run Transaction NoRelease querySingular

transactionSingularThunkHandler :: Handler [Result]
transactionSingularThunkHandler = liftIO $ run Transaction NoRelease queryPseudoSingular

transactionTHHandler :: Handler [Result]
transactionTHHandler = liftIO $ run Transaction NoRelease queryTH

transactionReleasedHandler :: Handler [Result]
transactionReleasedHandler = liftIO $ run Transaction Release queryTH
