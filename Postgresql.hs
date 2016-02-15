module Postgresql where

{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

import           Control.Monad.IO.Class  (liftIO)
import           Control.Monad.Logger    (runStderrLoggingT)
import           Database.Persist
import           Control.Monad.Reader
import           Data.Text
import           Database.Persist.Sql
import           Database.Persist.Postgresql
import           Database.Persist.TH

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Person
    name String
    age Int Maybe
    deriving Show
|]

conn = "host=localhost dbname=new_db user=postgres password=postgres port=5432"

deletePerson :: MonadIO m => ReaderT SqlBackend m ()
deletePerson = rawSql "select from person where id=4" []

postgreSQLTest :: IO ()
postgreSQLTest = runStderrLoggingT $ withPostgresqlPool conn 10 $ liftSqlPersistMPool $ do
         runMigration migrateAll
         print test
         getPerson

