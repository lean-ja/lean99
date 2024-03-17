/-
# Problem 31
Determine whether a given integer number is prime.
-/

def isPrime (n : Nat) : Bool :=
  -- sorry
  if n == 0 || n == 1 then
    false
  else
    -- natural numbers less than `n`
    -- `[2, ..., n-1]`
    let candidate := List.range n |> List.drop 2

    -- List of proper divisors of `n`
    let divList := candidate.filter (n % · == 0)

    divList.length == 0
  -- sorry

-- The following code is a test case and you should not change it.

example : isPrime 7 = true := rfl

example : isPrime (7 * 43) = false := rfl

example : isPrime 307 = true := rfl

example : isPrime 0 = false := rfl

example : isPrime 1 = false := rfl
