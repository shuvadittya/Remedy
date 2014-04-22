module Main where

import System.Console.GetOpt
import System.Environment
import System.IO

import Eval
import Monad
import Parser

data Flag = Verbose
          | BigStep
  deriving (Eq, Show)

main :: IO ()
main = do
    (flags, files) <- getArgs >>= parseOpts
    mapM_ (evalFile flags) files

parseAndEval :: [Flag] -> String -> EvalM String
parseAndEval flags s = do
    ts   <- parseArith s
    ts'  <- if BigStep `elem` flags
            then bigevalTerms ts
            else evalTerms ts
    return (show ts')

evalFile :: [Flag] -> String -> IO ()
evalFile flags filename = do
    s <- readFile filename
    case parseAndEval flags s of
      Left err -> hPutStrLn stderr ("Error: " ++ show err)
      Right ts -> putStr ts

options :: [OptDescr Flag]
options =
 [ Option ['v'] ["verbose"] (NoArg Verbose)  "be verbose"
 , Option ['b'] ["bigstep"] (NoArg BigStep)  "use the big-step evaluator"
 ]

parseOpts :: [String] -> IO ([Flag], [String])
parseOpts argv =
    case getOpt Permute options argv of
      (o,n,[]  ) -> return (o,n)
      (_,_,errs) -> ioError (userError (concat errs ++ usageInfo header options))
  where
    header = "Usage: arith [OPTION...] files..."
