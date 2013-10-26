module Data.Yaml.App
  ( billTo
  , getFuga
  ) where
import Control.Lens
import qualified Data.Aeson as A
import Data.Aeson.Lens
import Data.Maybe
import Data.Text
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import Data.Yaml as Y

billTo :: IO String
billTo = readSetting "test"

getFuga :: IO String
getFuga = readSetting' "hoge" "fuga"

readSetting :: String -> IO String
readSetting val = do
  str <- readYamlFile
  let retval = str ^. key (pack val) :: Maybe String
  return (fromJust retval)

readSetting' :: String -> String -> IO String
readSetting' val1 val2 = do
  str <- readYamlFile
  let retval = str ^. key (pack val1) ^. key (pack val2) :: Maybe String
  return (fromJust retval)

-- | read setting from yaml
readYamlFile :: IO (Maybe Value)
readYamlFile = do
  fstr <- B.readFile settingFile
  let v = Y.decode fstr :: Maybe Value
  putStrLn $ show (fromJust v)
  return v

-- | set setting file name
settingFile :: String
settingFile = "test.yaml"