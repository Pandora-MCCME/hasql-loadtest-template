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

implicitSession :: Statement () a -> Session a
implicitSession = Session.statement () . unprepareStatement

explicitSession :: Statement () a -> Session a
explicitSession = unpreparedTransaction ReadCommitted Read
                . Transaction.statement ()
                . unprepareStatement

session :: RunMode -> Statement () a -> Session a
session Session = implicitSession
session Transaction = explicitSession

finalize :: RunRelease -> Connection -> IO ()
finalize NoRelease _ = pure ()
finalize Release conn = release conn

run :: RunMode -> RunRelease -> Statement () a -> IO a
run mode releaseFlag stmt = do
  conn <- connect
  value <- fromRight <$> Session.run (session mode stmt) conn
  finalize releaseFlag conn
  return value
