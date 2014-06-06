import IntSet
import Data.List
import Test.QuickCheck

newtype IS = IntSet IntSet
  deriving (Eq,Show)

{-
instance Arbitrary IS where
    arbitrary = do xs <- arbitrary
                   return $ IntSet $ go (sort xs)
      where
        go (lo:hi:xs) = (lo,hi) : go (dropWhile (<=hi+1) xs)
        go _          = []
-}

instance Arbitrary IS where
  arbitrary = do xs <- sized (\s -> arbIntSet s 0)
                 return (IntSet xs)
    where
      arbIntSet :: Int -> Int -> Gen IntSet
      arbIntSet 0    min = return []
      arbIntSet size min = oneof [return [], arbIntSetRec]
        where
          arbIntSetRec :: Gen IntSet
          arbIntSetRec = do
              NonNegative lo    <- fmap (`mod` 100) arbitrary
              NonNegative delta <- fmap (`mod` 100) arbitrary
              xs  <- arbIntSet (size-1) (lo+delta+min+2)
              return ((lo+min,lo+delta+min):xs)

main :: IO ()
main = runTests

runTests = do
    quickCheck prop_valid
    quickCheck prop_empty
    quickCheck prop_member
    quickCheck prop_merge
    quickCheck prop_insert
    quickCheck prop_delete

-- Model an IntSet by a list of Ints in the set
model :: IntSet -> [Int]
model xs = nub $ sort $ concat [[lo..hi] | (lo,hi) <- xs]

-- The IntSet invariant from the problem description
invariant :: IntSet -> Bool
invariant xs =
    all (\(lo,hi) -> lo <= hi) xs &&
    all (\((_,hi), (lo,_)) -> lo > hi + 1) (xs `zip` drop 1 xs)

prop_valid :: IS -> Bool
prop_valid (IntSet xs) = invariant xs

prop_empty :: Bool

prop_empty =  emptyS == []

prop_member :: Int -> IS -> Bool

prop_member x (IntSet xs) = (memberS x xs)== (elem x (model xs)) 


prop_merge :: IS -> IS -> Bool
prop_merge (IntSet xs) (IntSet ys) =  model (mergeS xs ys) ==  (sort (nub ((model xs)++ (model ys))))

prop_insert :: Int -> IS -> Bool
prop_insert x (IntSet xs) = model (insertS x xs)== sort (nub (insert x (model xs)))     --  (elem x (model (insertS x xs))) == (elem x (insert x (model xs)))

prop_delete :: Int -> IS -> Bool
prop_delete x (IntSet xs) = model (deleteS x xs) == sort (delete x (model xs))
