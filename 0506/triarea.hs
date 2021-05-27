triarea :: Float -> Float -> String
triarea h b = show (0.5 * h * b)

main :: IO ()
main = do
	putStrLn "The base?"
	base <- getLine
	putStrLn "The height?"
	height <- getLine
	let outStr = triarea (read base) (read height)
	putStrLn("The area of that triangle is " ++ outStr)