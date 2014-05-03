Bin b = #
            |b 0
            |b 1
            deriving (Show)

binDenotation :: Bin -> Integer
binDenotation # = 0
binDenotation # 0 = 0
binDenotation b 0 = 2*b
binDenotation b 1 = 2*b +1
