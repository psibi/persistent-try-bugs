{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Sqlite where

import Control.Monad.IO.Class  (liftIO)
import Database.Persist
import Database.Persist.Sqlite
import Database.Persist.TH
import Control.Monad.Reader

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
User
    age Int
    deriving Show
|]

getUser :: MonadIO m => ReaderT SqlBackend m [Entity User]
getUser = rawSql "select ?? from user where age * ? > ?" [PersistInt64 2, PersistInt64 40]

sqliteTest :: IO ()
sqliteTest = runSqlite "/home/sibi/test.db" $ do
               runMigration migrateAll

               johnId <- insert $ User 40
               janeId <- insert $ User 41
                                                
               users <- getUser
               liftIO $ print (users :: [Entity User])


