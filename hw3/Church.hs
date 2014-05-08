zero = \f -> \z -> z
one = \f -> \z -> f (z)
two = \f -> \z ->  f (f z)

--zero = \f  id
--one = \f \f
--two = \f \f . f

type Church a = ( a -> a ) ->  a -> a 


churchToInteger :: Church Integer -> Integer

churchToInteger n = n (+1) 0

 -- It took 2 hours to solve the problem
