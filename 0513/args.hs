{-
This is referenced from "Learn You a Haskell for Great 
Good! "
-}
{- example
> ./todo add todo.txt "buy mild."
> ./todo view todo.txt
> ./todo remove todo.txt 2
-}
{-
>TODO
Test filename that is a argument if it is existed or not. 
-}

import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Monad
import Control.Exception

dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "view" = view
dispatch "remove" = remove
dispatch "help" = help
dispatch command = doesntExist command

main = do
 args <- getArgs
 let command = if null args then [] else head args
  argList = if null args then [] else tail args
 dispatch command argList

doesntExist :: String -> [String] -> IO ()
doesntExist [] _ = help []
doesntExist command _ = do
	putStrLn $ "The " ++ command ++ " command doesn't exist."
	help []

-- add something to todolist.
add :: [String] -> IO ()
add [filename , todoItem ] = appendFile filename ( todoItem ++ "\n" )
add _ = putStrLn "The add command takes exactly two 
arguments."

-- view todolist
view :: [String] -> IO ()
view [filename] = do
  contents <- readFile filename
  let todoItems = lines contents
   outputs = zipWith makeStr [0..] todoItems
	where makeStr = (\n item -> show n ++ " - " ++ item )

  putStrLn $ unlines outputs
view _ = putStrLn "The view command takes exactly one arguments."

remove :: [String] -> IO ()
remove [filename , numberString ] = do
 contents <- readFile filename
 let todoTasks = lines contents
  index = read numberString
  newTasks = unlines $ delete ( todoTasks !! index ) todoTasks

 bracketOnError (openTempFile "." "temp")
	(\(path,h) -> do
		hClose h
		removeFile path) 
	(\(path,h) -> do
		hPutStr h newTasks
		hClose h
		removeFile filename
		renameFile path filename )
remove _ = putStrLn "The remove command takes exactly two arguments."

help :: [String] -> IO ()
help _ = do
 putStrLn "Suppoted command is ..."
 putStrLn "view <filename>"
 putStrLn "add <filename> <task>"
 putStrLn "remove <filename> <number>"
