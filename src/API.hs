{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module API where

import Servant

import Types (Result)

type API = "hasql" :> "session" :> Get '[JSON] [Result]
      :<|> "hasql" :> "session-minimal" :> Get '[JSON] Bool
      :<|> "hasql" :> "session-th" :> Get '[JSON] [Result]
      :<|> "hasql" :> "session-release" :> Get '[JSON] [Result]
      :<|> "hasql" :> "transaction" :> Get '[JSON] [Result]
      :<|> "hasql" :> "transaction-minimal" :> Get '[JSON] Bool
      :<|> "hasql" :> "transaction-singlerow" :> Get '[JSON] Result
      :<|> "hasql" :> "transaction-singlerow-thunk" :> Get '[JSON] [Result]
      :<|> "hasql" :> "transaction-th" :> Get '[JSON] [Result]
      :<|> "hasql" :> "transaction-release" :> Get '[JSON] [Result]
      :<|> "plain" :> Get '[JSON] NoContent

api :: Proxy API
api = Proxy
