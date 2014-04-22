module Eval (
    evalTerms,
    bigevalTerms
  ) where

import Control.Monad.Error

import Monad
import Syntax

eval1 :: Term -> EvalM Term
eval1 (TmIf _ (TmTrue _) t2 _) =
    return t2

eval1 (TmIf _ (TmFalse _) _ t3) =
    return t3

eval1 (TmIf pos t1 t2 t3) = do
    t1' <- eval1 t1
    return (TmIf pos t1' t2 t3)

eval1 (TmSucc pos t1) = do
    t1' <- eval1 t1
    return (TmSucc pos t1')

eval1 (TmPred _ (TmZero pos)) =
    return (TmZero pos)

eval1 (TmPred _ (TmSucc _ nv1)) | isNumerical nv1 =
    return nv1

eval1 (TmPred pos t1) = do
    t1' <- eval1 t1
    return (TmPred pos t1')

eval1 (TmIsZero pos (TmZero _)) = do
    return (TmTrue pos)

eval1 (TmIsZero pos (TmSucc _ nv1)) | isNumerical nv1 =
    return (TmFalse pos)

eval1 (TmIsZero pos t1) = do
    t1' <- eval1 t1
    return (TmIsZero pos t1')

eval1 _ =
    throwError NoRuleApplies

eval :: Term -> EvalM Term
eval t =
    case eval1 t of
      Left NoRuleApplies  -> Right t
      Left err            -> Left err
      Right t'            -> eval t'

evalTerms :: [Term] -> EvalM [Term]
evalTerms [] =
    return []

evalTerms (t:ts) = do
    t' <- eval t
    ts' <- evalTerms ts
    return (t':ts')

bigeval :: Term -> EvalM Term

bigeval (TmIf _ t1 t2 t3) =
  do t1' <- bigeval t1
     case t1' of
       TmTrue _  -> bigeval t2
       TmFalse _ -> bigeval t3
       _         -> throwError NoRuleApplies      
 
bigeval (TmSucc pos t1) =
  do nv' <- bigeval t1
     if isNumerical nv'
        then return (TmSucc pos nv')
        else throwError NoRuleApplies	

bigeval (TmPred pos t1) =
  do t1' <- bigeval t1  
     case t1' of
       TmZero _       -> bigeval (TmZero pos)
       TmSucc _ nv1   -> bigeval nv1 
       _              -> throwError NoRuleApplies


bigeval (TmIsZero pos t1) = 
  do t1' <- bigeval t1
     case t1' of
        TmZero _     -> bigeval (TmTrue pos) 
        TmSucc _ nv1 -> bigeval (TmFalse pos) 
        _            -> throwError NoRuleApplies
   

bigeval v = return v	

bigevalTerms :: [Term] -> EvalM [Term]
bigevalTerms [] =
    return []

bigevalTerms (t:ts) = do
    t' <- bigeval t
    ts' <- bigevalTerms ts
    return (t':ts')
-- It took 12 hours at least to figure out and solve this problem
