import day02
import gleeunit/should

pub fn day01_part1_test() -> Nil {
  let input =
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

  let expected = "2"

  day02.parse(input) |> day02.part1() |> should.equal(expected)
}

pub fn day01_part2_test() -> Nil {
  Nil
}
