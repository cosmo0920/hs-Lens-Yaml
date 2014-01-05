module Data.Yaml.App
  ( billTo
  , getFuga
  , readSetting
  , readSettingkeys
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
getFuga = readSettingkeys "hoge" "fuga"

readSetting :: (ToJSON v, FromJSON v) => String -> IO v
readSetting val = do
  str <- readYamlFile
  let retval = str ^. key (pack val)
  return (fromJust retval)

readSettingkeys :: (ToJSON v, FromJSON v) => String -> String -> IO v
readSettingkeys val1 val2 = do
  str <- readYamlFile
  let retval = str ^. key (pack val1) ^. key (pack val2)
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