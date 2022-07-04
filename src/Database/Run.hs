module Database.Run
  (run)
  where

import System.Environment (getEnv)

import Data.ByteString.Char8 (pack)

import Hasql.Connection
import Hasql.Statement (Statement(..))
import Hasql.Session (Session)
import qualified Hasql.Session as Session

import qualified Hasql.Transaction as Transaction
import Hasql.Transaction.Sessions

import Types

fromRight :: Show a => Either a b -> b
fromRight (Right a) = a
fromRight (Left a) = error $ show a

connect :: IO Connection
connect = getEnv "POSTGRES"
      >>= fmap fromRight . acquire . pack

unprepareStatement :: Statement a b -> Statement a b
unprepareStatement (Statement sql params result _) =
  Statement sql params result False

implicitTransaction = Session.statement () . unprepareStatement
implicitTransaction :: Statement () a -> Session a

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

run :: RunTransaction -> RunRelease -> Statement () a -> IO a
run mode releaseFlag stmt = do
  conn <- connect
  value <- fromRight <$> Session.run (session mode stmt) conn
  finalize releaseFlag conn
  return value
