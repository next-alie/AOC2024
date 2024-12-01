import day01
import gleeunit/should

pub fn day01_part1_test() -> Nil {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"

  let expected = "11"

  day01.parse(input) |> day01.part1() |> should.equal(expected)
}

pub fn day01_part2_test() -> Nil {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"

  let expected = "31"

  day01.parse(input) |> day01.part2() |> should.equal(expected)
}
