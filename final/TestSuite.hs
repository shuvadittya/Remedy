
import Data.List
import Test.QuickCheck

prop_reverse_append :: [Int] -> [Int] -> Bool
prop_reverse_append xs ys =
  reverse (xs ++ ys) == reverse ys ++ reverse xs
