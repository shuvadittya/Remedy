type Peg = String
type Move = (Peg,Peg)

hanoi::Integer->Peg->Peg->Peg->[Move]
hanoi 0 _ _ _ = []
hanoi n a b c =
	let
		step1 = hanoi (n-1) a c b
		stepN = (a,b)
		step3 = hanoi (n-1) c b a
	in
		step1 ++ [stepN] ++ step3

-- It took 1 hour yo solve this problem
