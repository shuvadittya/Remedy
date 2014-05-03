type Val =  Integer
type Move = (Val,Val)
pairWithSquareRec ::[Integer] ->[Move]
pairWithSquareRec [] = []
pairWithSquareRec (a:as) = [(a,a*a)] ++ pairWithSquareRec as


pairWithSquareNon :: [Integer] ->[Move]
pairWithSquareNon [] = []
pairWithSquareNon[a] = [(a,a*a)] ++
pairWithSquareNon[as] = map as

map  :: [a] -> [b]
map   []               =  []
map  (x:xs)            =  [(x, x*x)] ++ map xs



pairWith :: (a -> b) -> [a] -> [b]

pairWith f [] = []
pairWith f (x: xs) = [(x, f x)] ++ pairWith f xs
