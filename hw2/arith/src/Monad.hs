module Monad (
    ArithError(..),
    EvalM
  ) where

import Control.Monad.Error

data ArithError = ParserError String
                | OtherError String
                | NoRuleApplies

instance Show ArithError where
    show (ParserError msg)  = "Parse Error: " ++ msg
    show (OtherError msg)   = "Error: " ++ msg
    show NoRuleApplies      = "No rule applies:"

instance Error ArithError where
    strMsg s = OtherError s

type EvalM a = Either ArithError a
