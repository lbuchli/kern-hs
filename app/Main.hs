module Main where

import Lib

main :: IO ()
main = do
  -- putStrLn (pprintProg preludeDefs)
  -- print (klex 0 "add a b = \n a + b if \n a == b -- This is a comment \n this is not")
  -- print (klex 0 "a a a")
  -- print (pBoolArray (klex 0 "[True, False, True, True]"))
  -- print (pZeroOrMore (pLit "A") (klex 0 "A A A"))
  -- print (pThen (++) (pLit "Help") (pLit "me") (klex 0 "Help me"))
  putStrLn (either id id (mapLeft pprintProg (kParse (klex 0 (unlines [
                                          "f = 3;",
                                          "g x y = let z = x in z;",
                                          "h x = case (let y = x in y) of",
                                          "    <1> => 2;",
                                          "    <2> => 5;"
                                               ])))))
  putStrLn . either id id
    . mapLeft showResults
    . mapLeft eval
    . mapLeft compile
    . kParse . klex 0 $ unlines [
    "pair x y f = f x y;",
    "first p = p fst;",
    "second p = p snd;",
    "f x y = letrec",
    "        a = pair x b;",
    "        b = pair y a",
    "    in",
    "        first (second (second (second a)));",
    "main = f 3 4;"
                                ]
