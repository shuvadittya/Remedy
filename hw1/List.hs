data List a =  Nil 
                 | Cons a (List a)
                   deriving (Show)

fromHaskellList (x:xs) = Cons x (fromHaskellList xs)
fromHaskellList []     = Nil

toHaskellList (Cons x xs) = (x:(toHaskellList xs))
toHaskellList Nil = []

mymap::(a->b)->List a->List b
mymap f Nil = Nil

mymap f (Cons a b)= Cons (f a) (mymap f b)

myreverse::List a -> List a
myreverse Nil = Nil
myreverse l = myrev l Nil
	where
        myrev::List a ->List a ->List a
      	myrev Nil acc= acc
	myrev (Cons x xs) acc = myrev xs (Cons x acc)

 
myappend::List a->List a ->List a
myappend Nil Nil = Nil
myappend (Cons x xs) Nil = Cons x xs
myappend Nil (Cons x xs) = Cons x xs
myappend (Cons x xs)(Cons a bs) = Cons x (myappend xs (Cons a bs) )

-- To complete it took 8 hours

