import Data.Char (isSpace, isDigit)
import Data.List (groupBy)
import Data.Either (fromRight)

--- From somewhere on StackOverflow


data Token = TNum Int | TOp Operator deriving (Show)
data Operator = Add
              | Mult
              | LBrace
              | RBrace
              deriving (Show, Eq)

splitTok :: String -> [String]
splitTok = groupBy (\x y -> isDigit x && isDigit y) . filter (not . isSpace)

str2tok :: String -> Either String Token
str2tok tkn@(c:_)
    | isDigit c = Right $ TNum $ read tkn
    | otherwise = case tkn of
        "+" -> Right $ TOp Add
        "*" -> Right $ TOp Mult
        "(" -> Right $ TOp LBrace
        ")" -> Right $ TOp RBrace
        _   -> Left  $ "No such operator: \"" ++ tkn ++ "\""

tok2str :: Token -> String
tok2str (TNum t) = show t
tok2str (TOp t) = case t of
    Add  -> "+"
    Mult -> "*"
    _    -> "ERROR"

precedence :: Operator -> Int
precedence Add    = 1
precedence Mult   = 1
precedence LBrace = 3
precedence RBrace = 3

-- shuntYard (Operator stack) (Token Queue) (Token Buffer) = new Token Queue
shuntYard :: [Operator] -> [Token] -> [Either String Token] -> Either String [Token]
shuntYard _ _ (Left s:_) = Left s
shuntYard stack queue [] = Right $ queue ++ map TOp stack
shuntYard stack queue (Right (TNum t):ts) = shuntYard stack (queue ++ [TNum t]) ts
shuntYard stack queue (Right (TOp t):ts) =
    shuntYard ustack uqueue ts
  where
    (ustack, uqueue) = case t of
        LBrace -> (t : stack, queue)
        RBrace -> (stail srest, queue ++ map TOp sstart)
        _      -> (t : ssend, queue ++ map TOp ssops)
    (sstart, srest) = break (==LBrace) stack
    currprec = precedence t
    (ssops, ssend) = span (\op -> precedence op > currprec && op /= LBrace) stack
    stail :: [a] -> [a]
    stail (x:xs) = xs
    stail [] = []

tokenise :: String -> [Either String Token]
tokenise = map str2tok . splitTok

untokenise :: Either String [Token] -> String
untokenise (Left s) = s
untokenise (Right ts) = unwords . map tok2str $ ts


---


evalRPN :: [Token] -> Int
evalRPN = extr . head . foldl eval []
  where
    eval :: [Token] -> Token -> [Token]
    eval (x:y:ys) (TOp Mult) = (mult x y):ys
    eval (x:y:ys) (TOp Add)  = (add  x y):ys
    eval xs x = x:xs
    mult (TNum x) (TNum y) = TNum (x * y)
    add  (TNum x) (TNum y) = TNum (x + y)
    extr (TNum x)          = x

calc :: String -> Int
calc = evalRPN . fromRight [] . shuntYard [] [] . tokenise . rev
  where
  rev = map tr . reverse
  tr '(' = ')'
  tr ')' = '('
  tr  x  =  x


main = do
  contents <- lines <$> readFile "dat/day_18.dat"
  putStrLn $ show $ sum $ map calc contents
