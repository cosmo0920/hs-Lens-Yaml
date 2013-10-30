import Data.Yaml.App

main :: IO ()
main = do
  result <- billTo
  fuga <- getFuga
  putStrLn $ show result
  putStrLn $ show fuga
  test <- setSetting "test" "fuga" -- FIXME: display changed value
  return ()
