module Syntax (
    Var(..),
    Exp(..),
    Type(..),
    Decl(..),
    isVal,

    isNumerical

  ) where

newtype Var = Var { unVar :: String }
  deriving (Eq)

data Exp = VarE Var
         | AbsE Var Type Exp
         | AppE Exp Exp
         | TrueE
         | FalseE
         | IfE Exp Exp Exp
         | ZeroE
         | SuccE Exp
         | PredE Exp
         | IsZeroE Exp

data Type = BoolT
          | FunT Type Type
          | NatT
  deriving (Eq)

data Decl = ExpD Exp
          | LetD Var Exp


isNumerical :: Exp -> Bool
isNumerical ZeroE      = True
isNumerical (SuccE e)  = isNumerical e
isNumerical _          = False


isVal :: Exp -> Bool
isVal (AbsE _ _ _)       = True
isVal TrueE              = True
isVal FalseE             = True

isVal e | isNumerical e  = True

isVal _                  = False

instance Show Var where
    showsPrec _ (Var v) = showString v

instance Show Exp where
    showsPrec p (VarE v)        =  showsPrec p v
    showsPrec p (AbsE v t e)    =  showParen (p > 0) $
                                   showString "\\" .
                                   shows v .
                                   showString " : " .
                                   shows t .
                                   showString " . " .
                                   shows e
    showsPrec p (AppE e1 e2)    =  showParen (p > 1) $
                                   showsPrec 1 e1 .
                                   showString " " .
                                   showsPrec 2 e2
    showsPrec _ TrueE           =  showString "true"
    showsPrec _ FalseE          =  showString "false"
    showsPrec p (IfE e1 e2 e3)  =  showParen (p > 0) $
                                   showString "if " .
                                   showsPrec 1 e1 .
                                   showString " then " .
                                   showsPrec 1 e2 .
                                   showString " else " .
                                   showsPrec 1 e3


    showsPrec _ ZeroE           = showString "0"
    showsPrec p (SuccE e)
        | isNumerical e  = showAsNum e 1
        | otherwise      = showParen (p > 0) $
                           showString "succ " . showsPrec 1 e
      where
        showAsNum :: Exp -> Integer -> ShowS
        showAsNum ZeroE       num  = showsPrec p num
        showAsNum (SuccE e')  num  = showAsNum e' (num + 1)
        showAsNum _           _    = error "showAsNum: non-numerical term"

    showsPrec p (PredE e)       = showParen (p > 0) $
                                  showString "pred " . showsPrec 1 e
    showsPrec _ (IsZeroE e)     = showString "iszero " . showsPrec 1 e


    showList []      = \s -> s
    showList (e:es)  = shows e . showChar '\n' . showList es

instance Show Type where
    show BoolT         = "Bool"

    show NatT          = "Nat"

    show (FunT t1 t2)  = show t1 ++ " -> " ++ show t2

instance Show Decl where
    showsPrec _ (ExpD e)   = shows e
    showsPrec _ (LetD v e) = shows v .
                             showString " = " .
                             shows e
