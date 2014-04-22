module Syntax (
    Term(..),
    tmSourcePos,
    isNumerical,
    isVal
  ) where

import Text.Parsec.Pos

-- SourcePos is like the info type in the book
data Term = TmTrue SourcePos
          | TmFalse SourcePos
          | TmIf SourcePos Term Term Term
          | TmZero SourcePos
          | TmSucc SourcePos Term
          | TmPred SourcePos Term
          | TmIsZero SourcePos Term

tmSourcePos :: Term -> SourcePos
tmSourcePos  (TmTrue pos)      = pos
tmSourcePos  (TmFalse pos)     = pos
tmSourcePos  (TmIf pos _ _ _)  = pos
tmSourcePos  (TmZero pos)      = pos
tmSourcePos  (TmSucc pos _)    = pos
tmSourcePos  (TmPred pos _)    = pos
tmSourcePos  (TmIsZero pos _)  = pos

isNumerical :: Term -> Bool
isNumerical (TmZero _)    = True
isNumerical (TmSucc _ t)  = isNumerical t
isNumerical _             = False

isVal :: Term -> Bool
isVal (TmTrue _)         = True
isVal (TmFalse _)        = True
isVal t | isNumerical t  = True
isVal _                  = False

instance Show Term where
    show (TmTrue _)         =  "true"
    show (TmFalse _)        =  "false"
    show (TmIf _ t1 t2 t3)  =  "if " ++ show t1 ++
                               " then " ++ show t2 ++
                               " else " ++ show t3
    show (TmZero _)         = "0"
    show (TmSucc _ t)
        | isNumerical t     = showAsNum t 1
        | otherwise         = "(succ " ++ show t ++ ")"
      where
        showAsNum :: Term -> Integer -> String
        showAsNum (TmZero _)     num = show num
        showAsNum (TmSucc _ t')  num = showAsNum t' (num + 1)
        showAsNum _              _   = error "showAsNum: non-numerical term"
    show (TmPred _ t)       = "(pred " ++ show t ++ ")"
    show (TmIsZero _ t)     = "iszero " ++ show t

    showList []      = \s -> s
    showList (t:ts)  = shows t . showChar '\n' . showList ts
