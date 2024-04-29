
module Haedosa.App where

import Haedosa.Lib (who)

main :: IO ()
main = print $ "Hello " ++ who ++ "!"
