data RegExp = Empty                  
            | Epsilon
            | Lit Char
            | Alt  RegExp RegExp      
	    | Cat  RegExp RegExp    
            | Star RegExp           
            deriving (Show)


match :: RegExp -> String -> Bool

match r s =  match' r s null

type Cont = String -> Bool   

match' :: RegExp -> String -> Cont -> Bool  
match' Empty  cs k = False
match' Epsilon cs k = k cs
match' (Lit c) (c':cs) k = c==c' && k cs
match' (Lit c) []  k = False

match' (Cat re1 re2) cs k = match' re1 cs (\v -> match' re2 v k)
match' (Alt re1 re2) cs k = match' re1 cs k || match' re2 cs k
match' (Star re) cs k = match'' re cs k
	where 
match'' re cs k = k cs || match' re cs (\v-> v /= cs && (match' (Star re) v k))

-- It took 12 hours to solve this problem
