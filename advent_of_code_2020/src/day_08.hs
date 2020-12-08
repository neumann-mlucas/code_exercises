data Instruction = Acc Int | Jmp Int | Nop Int deriving (Show, Read, Eq)

processLine :: [String] -> Instruction
processLine (cmd:num:_) =
  case cmd of
    "acc" -> Acc (sgn * int)
    "jmp" -> Jmp (sgn * int)
    "nop" -> Nop (sgn * int)
  where
   int = read $ drop 1 num
   sgn = toSign $ take 1 num
   toSign "+" =  1
   toSign "-" = -1

accumulator :: [Instruction] -> Int -> Int -> [Int] -> (Int,Bool)
accumulator insSet pos acc visited
  | pos `elem` visited = (acc, False)
  | isLast = (acc, True)
  | otherwise = exec cmd
  where
    cmd = insSet !! pos
    isLast = pos >= length insSet
    exec (Acc n) = accumulator insSet (pos+1) (acc+n) (pos:visited)
    exec (Jmp n) = accumulator insSet (pos+n) (acc) (pos:visited)
    exec (Nop n) = accumulator insSet (pos+1) (acc) (pos:visited)

isInfinitLoop :: [Instruction] -> Bool
isInfinitLoop insSet = snd (accumulator insSet 0 0 [])

changeToNop :: [Instruction] -> Int -> [Instruction]
changeToNop insSet pos = (take pos insSet) ++ [Nop 666] ++ (drop (pos+1) insSet)

allJmps :: [Instruction] -> [Int]
allJmps insSet = filter (\pos -> isJmp $ insSet !! pos) [0..length insSet -1]
  where
    isJmp (Jmp _) = True
    isJmp (Acc _) = False
    isJmp (Nop _) = False

main = do
  contents <- readFile "dat/day_08.dat"
  let instructionSet = map (processLine . words)  (lines contents)
  let modInstructionSets = map (changeToNop instructionSet) (allJmps instructionSet)
  let validMod = head $ filter isInfinitLoop modInstructionSets

  putStrLn $ show $ fst $ accumulator instructionSet 0 0 []
  putStrLn $ show $ fst $ accumulator validMod 0 0 []
