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

tcExp :: Gamma ->  Exp -> EvalM Type
tcExp _ TrueE = do return  BoolT
tcExp _ FalseE = do return BoolT
tcExp g (IfE t1 t2 t3) = 
          do {
		v1  <-  tcExp g t2;
                v2  <-  tcExp g t3;

		if (v1== v2)
                    then return v1;
	        else throwError $ TypeError v1 v2;
             }
tcExp _ e =
    fail $ "I don't yet know how to type check expression: " ++ show e
