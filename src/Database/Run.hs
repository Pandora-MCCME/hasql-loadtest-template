{- Internal module -}
module Database.Run
  ( module Database.Run
  , Statement
  )
  where

import Hasql.Connection
import Hasql.Statement (Statement(..))
import Hasql.Session (Session)
import qualified Hasql.Session as Session

import qualified Hasql.Transaction as Transaction
import Hasql.Transaction.Sessions

import App.Types

fromRight :: Show a => Either a b -> b
fromRight (Right a) = a
fromRight (Left a) = error $ show a

connect :: Settings -> IO Connection
connect = fmap fromRight . acquire

unprepareStatement :: Statement a b -> Statement a b
unprepareStatement (Statement sql params result _) =
  Statement sql params result False

implicitTransaction :: Statement () a -> Session a
implicitTransaction = Session.statement () . unprepareStatement

explicitTransaction :: Statement () a -> Session a
explicitTransaction = unpreparedTransaction ReadCommitted Read
                    . Transaction.statement ()
                    . unprepareStatement

session :: RunTransaction -> Statement () a -> Session a
session Session = implicitTransaction
session Transaction = explicitTransaction

finalize :: RunRelease -> Connection -> IO ()
finalize NoRelease _ = pure ()
finalize Release conn = release conn

runIO :: Settings -> RunTransaction -> RunRelease -> Statement () a -> IO a
runIO connStr mode releaseFlag stmt = do
  conn <- connect connStr
  value <- fromRight <$> Session.run (session mode stmt) conn
  finalize releaseFlag conn
  return value
