import java.util.*;

public class FunctionalFizzBuzz {
	static boolean isMultipleOf3(final int num) { return num % 3 == 0; }

	static boolean isMultipleOf5(final int num) { return num % 5 == 0; }

	static String fizzBuzzOrNumber(final int num) {
		if (isMultipleOf3(num) && isMultipleOf5(num))
			return "FizzBuzz";
		else if (isMultipleOf3(num))
			return "Fizz";
		else if (isMultipleOf5(num))
			return "Buzz";
		else
			return String.valueOf(num);
	}

	static List<String> fizzBuzz(final int upperBound) {
		ArrayList<String> results = new ArrayList<String>();
		for (int i = 1; i <= upperBound; i++)
			results.add(fizzBuzzOrNumber(i));
		return Collections.unmodifiableList(results);
	}

	public static void main(String[] args) {
		for (String line: fizzBuzz(100))
			System.out.println(line);
	}
}
