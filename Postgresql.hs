{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Postgresql where

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
    age Int 
    ude Int
    deriving Show
|]

conn = "host=localhost dbname=perm2 user=jack password=jack port=5432"

postgreSQLTest :: IO ()
postgreSQLTest = runStderrLoggingT $ withPostgresqlPool conn 10 $ liftSqlPersistMPool $ do
         runMigration migrateAll
         return ()
