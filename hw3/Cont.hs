newtype Cont r a = Cont { runCont :: (a -> r) -> r }

instance Monad (Cont r) where
    return x = Cont ($ x)
    m >>= f  = Cont $ \k -> runCont m $ \a -> runCont (f a) k

-- it toook 2 hours to solve roughly
