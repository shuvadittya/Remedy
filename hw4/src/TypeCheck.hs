module TypeCheck (
    tcExp
  ) where

import Control.Monad.Error

import Monad
import Syntax

type Gamma = [(Var, Type)]

-- t1 is the type we got, t2 is the type we want
checkTypesEqual :: Type -> Type -> EvalM ()
checkTypesEqual t1 t2 | t1 == t2 = return ()

checkTypesEqual t1 t2 =
    throwError $ TypeError t1 t2

safetype :: Type -> Maybe Type

safetype x = if x  == BoolT then Just x else Nothing


tcExp :: Gamma ->  Exp -> EvalM Type

tcExp _ TrueE = do return  BoolT
tcExp _ FalseE = do return BoolT

tcExp g (IfE t1 t2 t3) = 
           do {   v1 <- tcExp g t1
                 ; v2 <- tcExp g t2
                 ; v3 <- tcExp g t3
                 ; if (v1 == BoolT) 
		 ;    then if (v2 == v3)
                 ;             then return v2        
                 ;             else throwError $ TypeError v2 v3
                 ;    else throwError $ OtherError "t1 needs to be Bool. type mismatch"
               }
tcExp g (VarE x) =
        case (lookup x g) of
        Just t -> do return t
        Nothing -> throwError $ NotInScope x

tcExp g (AbsE x t e) = 
         do {   --let g = g ++ [(x,t)]
              -- v <- (tcExp g e) 
          ;      case t of 
                     BoolT -> do return (FunT t BoolT)
                           
                     _ -> throwError $ NotInScope x 
              
           } 

              
tcExp g (AppE e1 e2) =
        do {    v <- tcExp g e1
             ;  v2 <- tcExp g e2
             ;    case v of 
                        FunT t1 t2 ->
                                  (case v2 of
                                       t1 -> do return t2     
                                       t2 -> throwError $ TypeError t2 t1) 
                        _  -> throwError  $ FunTypeError v
  
            }

tcExp g ZeroE = do return NatT

tcExp g (SuccE e) = 
       do {  v <- tcExp g e
           ;   if (v == NatT) 
           ;     then do return NatT
           ;     else throwError $ NoRuleApplies    
         }

tcExp g (PredE e) =
       do {  v <- tcExp g e
           ;   if (v == NatT)
           ;     then do return NatT
           ;     else throwError $ NoRuleApplies
         }

tcExp g (IsZeroE e) =
       do {  v <- tcExp g e
           ;   if (v == NatT)
           ;     then do return BoolT
           ;     else throwError $ NoRuleApplies
         }


