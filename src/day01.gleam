import aoc2024
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

const day_num = "01"

pub type InputType {
  InputType(#(List(String), List(String)))
}

pub fn parse(input: String) -> InputType {
  input
  |> string.split("\n")
  |> list.fold(InputType(#([], [])), fn(list, line) {
    let assert [first, second] = line |> string.split("   ")
    let InputType(#(left, right)) = list
    InputType(#([first, ..left], [second, ..right]))
  })
}

pub fn part1(input: InputType) -> String {
  let InputType(#(left, right)) = input
  let left =
    list.map(left, int.parse)
    |> result.values()
    |> list.sort(int.compare)
  let right =
    list.map(right, int.parse)
    |> result.values()
    |> list.sort(int.compare)

  list.zip(left, right)
  |> list.map(fn(tuple) {
    int.absolute_value(pair.first(tuple) - pair.second(tuple))
  })
  |> int.sum()
  |> int.to_string
}

pub fn part2(input: InputType) -> String {
  let InputType(#(left, right)) = input
  let left =
    list.map(left, int.parse)
    |> result.values()

  let right =
    list.map(right, int.parse)
    |> result.values()

  list.map(left, fn(first) {
    first * list.count(right, fn(second) { first == second })
  })
  |> int.sum
  |> int.to_string
}

pub fn main() {
  let input = aoc2024.read_file(day_num) |> parse()
  io.println("Day " <> day_num <> " part 1:")
  io.println(part1(input))
  io.println("Day " <> day_num <> " part 2:")
  io.println(part2(input))
}
