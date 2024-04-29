
module Test.Trivial where

import Test.Tasty.HUnit ((@=?), Assertion)

unit_trivial :: Assertion
unit_trivial = (1 + 1) @=? (2 :: Int)
