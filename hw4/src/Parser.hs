module Parser (
    parseStlc
  ) where

import Control.Monad.Error
import Data.List (foldl1')
import Text.Parsec

import Monad
import Syntax

type Parser a = Parsec String () a

comment :: Parser ()
comment = do
    _ <- string "/*"
    _ <- many ((noneOf "*" >> return ()) <|> starNotCommentEnd)
    commentEnd
    return ()

starNotCommentEnd :: Parser ()
starNotCommentEnd = try (many1 (char '*') >> noneOf "/" >> return ())

commentEnd :: Parser ()
commentEnd = many1 (char '*') >> char '/' >> return ()

separator :: Parser ()
separator = (space >> return ()) <|> comment

separators :: Parser ()
separators = many separator >> return ()

symbol :: String -> Parser ()
symbol s = separators >> string s >> separators

keyword :: String -> Parser ()
keyword s = separators >> try (string s >> notFollowedBy alphaNum) >> separators

surroundedBy :: Parser ()
             -> Parser ()
             -> Parser a
             -> Parser a
surroundedBy open close parser = do
    open
    separators
    x <- parser
    separators
    close
    return x

parens :: Parser a -> Parser a
parens = surroundedBy (char '(' >> return ()) (char ')' >> return ())

parseBoolT :: Parser Type
parseBoolT = do
    _ <- keyword "Bool"
    return BoolT

parseBaseType :: Parser Type
parseBaseType = parseBoolT <|>
                parens parseBaseType

parseType :: Parser Type
parseType = parseBaseType `chainr1` (symbol "->" >> return FunT)

parseVar :: Parser Var
parseVar = do
    v   <- lower
    vs  <- many alphaNum
    return $ Var (v:vs)

parseVarE :: Parser Exp
parseVarE = do
    v <- parseVar
    return $ VarE v

parseAbsE :: Parser Exp
parseAbsE = do
    symbol "\\"
    v <- parseVar
    symbol ":"
    t <- parseType
    symbol "."
    e <- parseExp
    return $ AbsE v t e

parseTrueE :: Parser Exp
parseTrueE = do
    _ <- keyword "true"
    return TrueE

parseFalseE :: Parser Exp
parseFalseE = do
    _ <- keyword "false"
    return FalseE

{- Uncomment for EC
parseNatE :: Parser Exp
parseNatE = do
    n <- many1 digit
    return (numToExp (read n))
  where
    numToExp :: Integer -> Exp
    numToExp 0 = ZeroE
    numToExp n = SuccE (numToExp (n-1))

parseUnop :: String -> (Exp -> Exp) -> Parser Exp
parseUnop kw mkExp = do
    _ <- keyword kw
    t <- parseSimpleExp
    return (mkExp t)

parseSuccE :: Parser Exp
parseSuccE = parseUnop "succ" SuccE

parsePredE :: Parser Exp
parsePredE = parseUnop "pred" PredE

parseIsZeroE :: Parser Exp
parseIsZeroE = parseUnop "iszero" IsZeroE
-}

parseIfE :: Parser Exp
parseIfE = do
    _ <- keyword "if"
    t1 <- parseSimpleExp
    _ <- keyword "then"
    t2 <- parseSimpleExp
    _ <- keyword "else"
    t3 <- parseSimpleExp
    return (IfE t1 t2 t3)

parseSimpleExp :: Parser Exp
parseSimpleExp = parseAbsE <|>
                 parseTrueE <|>
                 parseFalseE <|>
                 parseIfE <|>
{- Uncomment for EC
                 parseSuccE <|>
                 parsePredE <|>
                 parseIsZeroE <|>
                 parseNatE <|>
-}
                 parseVarE <|>
                 parens parseExp

parseExp :: Parser Exp
parseExp = do
    es <- sepBy1 parseSimpleExp separators
    return $ foldl1' AppE es

semi :: Parser ()
semi = symbol ";"

parseExpD :: Parser Decl
parseExpD = do
    e <- parseExp
    return $ ExpD e

parseLetD :: Parser Decl
parseLetD = do
    v <- parseVar
    symbol "="
    e <- parseExp
    return $ LetD v e

parseDecl :: Parser Decl
parseDecl = try parseLetD <|>
            parseExpD

parseDecls :: Parser [Decl]
parseDecls = separators >> endBy1 parseDecl semi

parseStlc :: String -> EvalM [Decl]
parseStlc str =
    case parse parseDecls "arith" str of
      Left err     -> throwError (ParserError (show err))
      Right terms  -> return terms
