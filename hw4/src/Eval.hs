module Eval (
    evalDecls
  ) where

import Control.Monad.Error
import Data.List ((\\))

import Monad
import Syntax
import TypeCheck

eval1 :: Exp -> EvalM Exp
eval1 (AppE (AbsE x _ e1) v2) | isVal v2 =
    return $ subst x v2 e1

eval1 (AppE v1 e2) | isVal v1 = do
    e2' <- eval1 e2
    return $ AppE v1 e2'

eval1 (AppE e1 e2) = do
    e1' <- eval1 e1
    return $ AppE e1' e2

eval1 (IfE TrueE t2 _) =
    return t2

eval1 (IfE FalseE _ t3) =
    return t3

eval1 (IfE t1 t2 t3) = do
    t1' <- eval1 t1
    return (IfE t1' t2 t3)

{- Uncomment for EC
eval1 (SuccE t1) = do
    t1' <- eval1 t1
    return (SuccE t1')

eval1 (PredE ZeroE) =
    return ZeroE

eval1 (PredE (SuccE nv1)) | isNumerical nv1 =
    return nv1

eval1 (PredE t1) = do
    t1' <- eval1 t1
    return (PredE t1')

eval1 (IsZeroE ZeroE) = do
    return TrueE

eval1 (IsZeroE (SuccE nv1)) | isNumerical nv1 =
    return FalseE

eval1 (IsZeroE t1) = do
    t1' <- eval1 t1
    return (IsZeroE t1')
-}

eval1 _ =
    throwError NoRuleApplies

eval :: Exp -> EvalM Exp
eval t =
    case eval1 t of
      Left NoRuleApplies  -> Right t
      Left err            -> Left err
      Right t'            -> eval t'

evalDecls :: Bool -> [Decl] -> [(Exp, Either StlcError Exp)]
evalDecls doTc ds0 =
    loop id ds0
  where
    loop :: (Exp -> Exp) -> [Decl] -> [(Exp, Either StlcError Exp)]
    loop _ [] =
        []

    loop theta (ExpD e : ds) =
        (e,e') : loop theta ds
      where
        e' = if doTc
             then tcExp [] (theta e) >> eval (theta e)
             else eval (theta e)

    loop theta (LetD v e : ds) = do
        loop theta' ds
      where
        theta' = subst v e . theta

allVars :: [Var]
allVars = [Var [c] | c <- ['a'..'z']] ++
          [Var (unVar cs++[c]) | cs <- allVars, c <- ['a'..'z']]

fvs :: Exp -> [Var]
fvs (VarE x)        = [x]
fvs (AbsE x _ e)    = fvs e \\ [x]
fvs (AppE e1 e2)    = fvs e1 ++ fvs e2
fvs TrueE           = []
fvs FalseE          = []
fvs (IfE e1 e2 e3)  = fvs e1 ++ fvs e2 ++ fvs e3
{- Uncomment for EC
fvs ZeroE           = []
fvs (SuccE e)       = fvs e
fvs (PredE e)       = fvs e
fvs (IsZeroE e)     = fvs e
-}

-- subst v e1 e2 substitutes e1 for v in e2
subst :: Var -> Exp -> Exp -> Exp
subst x e1 e2@(VarE y)
    | y == x     = e1
    | otherwise  = e2

subst x e1 (AbsE y t e2)
    | y `elem` fvs e1  = AbsE y' t (subst x e1 e2')
    | otherwise        = AbsE y t (subst x e1 e2)
  where
    y'  = head (allVars \\ (x : fvs e1 ++ fvs e2))
    e2' = subst y (VarE y') e2

subst x e1 (AppE e21 e22) =
    AppE (subst x e1 e21) (subst x e1 e22)

subst _ _ TrueE  = TrueE
subst _ _ FalseE = FalseE

subst x e (IfE e1 e2 e3) = IfE (subst x e e1) (subst x e e2) (subst x e e3)

{- Uncomment for EC
subst _ _ ZeroE = ZeroE

subst x e1 (SuccE e2)    = SuccE (subst x e1 e2)
subst x e1 (PredE e2)    = PredE (subst x e1 e2)
subst x e1 (IsZeroE e2)  = IsZeroE (subst x e1 e2)
-}
