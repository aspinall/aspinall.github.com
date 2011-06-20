import java.util.*;

public class BetterFizzBuzz {
	static List<String> fizzBuzz(int upperBound) {
		ArrayList<String> results = new ArrayList<String>();
		for (int i = 1; i <= upperBound; i++)
			if ((i % 3 == 0) && (i % 5 ==0))
				results.add("FizzBuzz");
			else if (i % 3 == 0)
				results.add("Fizz");
			else if (i % 5 == 0)
				results.add("Buzz");
			else
				results.add(String.valueOf(i));
		return results;
	}

	public static void main(String[] args) {
		for(String line: fizzBuzz(100))
			System.out.println(line);
	}
}
