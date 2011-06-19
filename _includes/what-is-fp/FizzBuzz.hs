import Control.Monad

multipleOf3 num = num `mod` 3 == 0

multipleOf5 num = num `mod` 5 == 0

fizzBuzzOrNumber num =
	if multipleOf3 num && multipleOf5 num then "FizzBuzz" else
		if multipleOf3 num then "Fizz" else
			if multipleOf5 num then "Buzz"
				else show num

fizzBuzz upperBound = map fizzBuzzOrNumber [1..upperBound]

main = forM_ (fizzBuzz 100) putStrLn
