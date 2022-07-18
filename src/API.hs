{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module API where

import Servant

import App.Types

type API = "hasql" :> "collection"
        :> QueryParam' '[Required] "transaction" RunTransaction
        :> QueryParam' '[Required] "th" RunTH
        :> QueryParam' '[Required] "release" RunRelease
        :> QueryParam' '[Required] "pool" RunPool
        :> QueryParam' '[Required] "list" RunList
        :> Get '[JSON] [Result]
      :<|> "hasql" :> "item"
        :> QueryParam' '[Required] "transaction" RunTransaction
        :> QueryParam' '[Required] "th" RunTH
        :> QueryParam' '[Required] "release" RunRelease
        :> QueryParam' '[Required] "pool" RunPool
        :> Get '[JSON] Result
      :<|> "hasql" :> "flag"
        :> QueryParam' '[Required] "transaction" RunTransaction
        :> QueryParam' '[Required] "th" RunTH
        :> QueryParam' '[Required] "release" RunRelease
        :> QueryParam' '[Required] "pool" RunPool
        :> Get '[JSON] Bool
      :<|> "plain" :> Get '[JSON] NoContent

api :: Proxy API
api = Proxy
