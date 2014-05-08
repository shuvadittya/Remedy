-- Left identity:	
-- return a >>= f
-- =	
--f a

--Right identity:	

--Left identity:

--do { x' <- return x;                       
--     f x'
--   }
-- = do {f x)


-- Right identity:

--do { x<-m;
--  return x
--}

-- =  do {m}

-- Associativity

-- do { y <- do { x <- m;
--               f x
--           }
--     g y
--   }

-- = do { x <- m;
--     do { y <- f x;
--          g y
--        }
--   }
-- = do { x <- m;
--     y <- f x;
--     g y
--   }



newtype Identity a = Id { unId :: a }

                  deriving (Show)

instance Monad Identity where
    return x = Id x 
    m >>= f = f(unId m)  

-- it took 3 hours to solve it
