import aoc2024
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

const day_num = "02"

pub type ReportList =
  List(List(Int))

pub fn parse(input: String) -> ReportList {
  input
  |> string.split("\n")
  |> list.map(fn(s) {
    string.split(s, " ")
    |> list.map(fn(n) { int.parse(n) })
    |> result.values()
  })
}

pub fn part1(input: ReportList) -> String {
  list.count(input, is_line_valid)
  |> int.to_string
}

pub fn part2(input: ReportList) -> String {
  list.count(input, fn(line) {
    [line, ..list.combinations(line, list.length(line) - 1)]
    |> list.any(is_line_valid)
  })
  |> int.to_string
}

pub fn main() {
  let input = aoc2024.read_file(day_num) |> parse()
  io.println("Day " <> day_num <> " part 1:")
  io.println(part1(input))
  io.println("Day " <> day_num <> " part 2:")
  io.println(part2(input))
}

fn is_line_valid(line: List(Int)) -> Bool {
  let diffs =
    list.window_by_2(line)
    |> list.map(fn(tuple) { pair.first(tuple) - pair.second(tuple) })

  list.all(diffs, fn(diff) { int.absolute_value(diff) < 4 })
  && {
    list.all(diffs, fn(diff) { diff < 0 })
    || list.all(diffs, fn(diff) { diff > 0 })
  }
}
