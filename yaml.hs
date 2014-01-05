import Data.Yaml.App
import Data.Maybe

main :: IO ()
main = do
  result <- billTo
  fuga <- getFuga
  putStrLn $ show result
  putStrLn $ show fuga
  return ()
