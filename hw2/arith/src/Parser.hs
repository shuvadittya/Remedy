module Parser (
    parseArith
  ) where

import Control.Monad.Error
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

separators1 :: Parser ()
separators1 = many1 separator >> return ()

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

parseTrue :: Parser Term
parseTrue = do
    pos  <- getPosition
    _    <- string "true"
    return (TmTrue pos)

parseFalse :: Parser Term
parseFalse = do
    pos  <- getPosition
    _    <- string "false"
    return (TmTrue pos)

parseNat :: Parser Term
parseNat = do
    pos  <- getPosition
    n    <- many1 digit
    return (numToTerm pos (read n))
  where
    numToTerm :: SourcePos -> Integer -> Term
    numToTerm pos 0 = TmZero pos
    numToTerm pos n = TmSucc pos (numToTerm pos (n-1))

parseUnop :: String -> (SourcePos -> Term -> Term) -> Parser Term
parseUnop kw mkTerm = do
    pos  <- getPosition
    _    <- string kw
    separators1
    t <- parseTerm
    return (mkTerm pos t)

parseSucc :: Parser Term
parseSucc = parseUnop "succ" TmSucc

parsePred :: Parser Term
parsePred = parseUnop "pred" TmPred

parseIsZero :: Parser Term
parseIsZero = parseUnop "iszero" TmIsZero

parseIf :: Parser Term
parseIf = do
    pos <- getPosition
    _ <- string "if"
    separators1
    t1 <- parseTerm
    separators1
    _ <- string "then"
    separators1
    t2 <- parseTerm
    separators1
    _ <- string "else"
    separators1
    t3 <- parseTerm
    return (TmIf pos t1 t2 t3)

parseTerm :: Parser Term
parseTerm = parseTrue <|>
            parseFalse <|>
            (try parseIf) <|> -- use try, due to "iszero" below
            parseSucc <|>
            parsePred <|>
            parseIsZero <|>
            parseNat <|>
            parens parseTerm

termSep :: Parser ()
termSep = do
    separators
    _ <- char ';'
    separators

parseTerms :: Parser [Term]
parseTerms = separators >> endBy1 parseTerm termSep

parseArith :: String -> EvalM [Term]
parseArith str =
    case parse parseTerms "arith" str of
      Left err     -> throwError (ParserError (show err))
      Right terms  -> return terms
