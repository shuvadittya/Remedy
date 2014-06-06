module IntSet (
    IntSet,
    emptyS,
    memberS,
    insertS,
    mergeS,
    deleteS
  ) where

import Data.List
import Test.QuickCheck

type IntSet = [(Int,Int)]

-- Creating empty set
emptyS :: IntSet
emptyS = []

-- Checking if an integer is in the set
memberS :: Int -> IntSet -> Bool
memberS _ [] = False
memberS x [(a,b)] 
    | (x<a)= False
    | (x>=a) && (x<=b) = True
    | otherwise = False

memberS x ((a,b):ys) 
    | (x < a) = False
    | (x>=a && x<=b) = True
    | (x>b) && (x < (fst (head ys)))= False 
    | otherwise = (memberS x ys)    
-- d
-- Adding an element to the set
insertS :: Int -> IntSet -> IntSet
insertS x [] = [(x,x)]
insertS x [(a,b)] 
     |(x>a) && (x<b)= [(a,b)]
     |(x==a)|| (x==b) = [(a,b)]
     | (x<a) && (a-x== 1) = [(x,b)]
     | (x<a) && (a-x>1) = [(x,x),(a,b)]
     | (x>b) && (x-b==1) =[(a,x)]
     | (x>b) && (x-b>1)=[(a,b), (x,x)] 

insertS x ((a,b):ys)
     | (x< a && (a-x) == 1) = ((x,b):ys)
     | (x<a && (a-x) >1) = ((x,x):(a,b): ys) 
     | (x>=a && x<=b) = ((a,b):ys)
     | (x>b && (x-b)==1) = ((a,x): ys)
     | (x>b && (x-b)>1 && (fst(head ys)- x)> 1) = ((a,b): (x,x): ys)
     | (x>b && (x-b)>1 && (fst(head ys)- x)== 1) = ((a,b): (x, (snd (head ys))): (tail ys))
     | (x>b) && (x - (fst (head ys))==0) = ((a,b):ys)
     | (x>b) && (x - (snd (head ys))==0) = ((a,b):ys)
     | (x > (fst (head ys)))&& (x < (snd (head ys)))   = ((a,b):ys)
     | (x > (snd (head ys)))&& (x- (snd (head ys))==1)= ((a,b):(fst (head ys), x): (tail ys))
     | (x > (snd (head ys)))&& (x- (snd (head ys))>1)= ((a,b):(head ys): (x,x): (tail ys))
     | (x - (snd (last (tail ys))) ==0) = ((a,b): ys) 
     | (x - (fst (last (tail ys))) ==0) = ((a,b): ys) 
     | (x - (snd (last (tail ys))) >1) = ((a,b): ys) ++ [(x,x)]  
     | otherwise = ((a,b):(insertS x ys)) 



-- Union two sets
mergeS :: IntSet -> IntSet -> IntSet
mergeS [] [] = []
mergeS [] t = t
mergeS t [] = t
mergeS ((a,b): xs) ((c,d): ys) 
     | (a == c)&& (b==d)= ((a,b): (mergeS xs ys))
     | (a == c) && (b<d)  = ((a,d) : (mergeS xs ys))
     | (a == c) && (b>d)  =((a,b): (mergeS xs ys))
     | (a < c) && (b==d)  = ((a,b): (mergeS xs ys))
     | (a < c) && (b<d) && (b<c) = ((a,b) : (c,d): (mergeS xs ys))
     | (a < c) && (b<d) && (b==c) = ((a,d): (mergeS xs ys))
     | (a < c) && (b<d) && (b>c) = ((a,d) : (mergeS xs ys))
     | (a < c) && (b>d)    = ((a,b) : (mergeS xs ys))
     | (a >  c) && (b==d) =((c,d): (mergeS xs ys))
     | (a >  c) && (b<d) =((c,d): (mergeS xs ys))
     | (a >  c) && (a<d) && (b>d) =((c,b): (mergeS xs ys))
     | (a >  c) && (a>d) && (b>d) =((c,d): (a,b) : (mergeS xs ys))
     | (a >  c) && (a==d) && (b>d) =((c,b): (mergeS xs ys))
     | otherwise = ((a,b): (c,d) : (mergeS xs ys))

          
deleteS :: Int -> IntSet -> IntSet
deleteS x [] = []
deleteS x [(a,b)]
     | (x<a)= [(a,b)]
     | (x>b)= [(a,b)]
     | (a==b) && (x==a)= []
     | (a /=b) && (x==a) = [(a+1,b)]
     | (a/=b) && (x==b) = [(a,b-1)]
     | otherwise = [(a,x-1), (x+1,b)]
  
deleteS x ((a,b):ys)
     | (x<a) = ((a,b):ys)
     | (x==a && x==b) = (ys)
     | (x==a && x<b) = ((a+1,b):ys)
     | (x>a && x==b) = ((a,b-1):ys)
     | (x>a && x<b) = ((a,x-1):(x+1,b): ys)
     | (x>b && (x<(fst(head ys)))) = ((a,b): ys)  
     | otherwise = ((a,b):(deleteS x ys))




