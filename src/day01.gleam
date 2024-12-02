import aoc2024
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

const day_num = "01"

pub type LocationIds =
  #(List(String), List(String))

pub fn parse(input: String) -> LocationIds {
  input
  |> string.split("\n")
  |> list.fold(#([], []), fn(list, line) {
    let assert [first, second] = line |> string.split("   ")
    let #(left, right) = list
    #([first, ..left], [second, ..right])
  })
}

pub fn part1(input: LocationIds) -> String {
  let #(left, right) = input
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

pub fn part2(input: LocationIds) -> String {
  let #(left, right) = input
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
