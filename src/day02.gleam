import aoc2024
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/result
import gleam/string

const day_num = "02"

pub type InputType {
  InputType(List(List(Int)))
}

type Dir {
  Up
  Down
  Unknown
  Failed
}

pub fn parse(input: String) -> InputType {
  InputType(
    input
    |> string.split("\n")
    |> list.map(fn(s) {
      string.split(s, " ")
      |> list.map(fn(n) { int.parse(n) })
      |> result.values()
    }),
  )
}

pub fn part1(input: InputType) -> String {
  let InputType(list) = input
  list.count(list, is_line_valid)
  |> int.to_string
}

pub fn part2(input: InputType) -> String {
  let InputType(list) = input
  list.count(list, fn(line) {
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
  list.window_by_2(line)
  |> list.all(fn(tuple) {
    let diff = int.absolute_value(pair.first(tuple) - pair.second(tuple))
    diff < 4 && diff > 0
  })
  && {
    case
      list.window_by_2(line)
      |> list.fold(Unknown, fn(dir, tuple) {
        let diff = pair.first(tuple) - pair.second(tuple)
        case dir {
          Unknown ->
            case diff > 0 {
              True -> Down
              False -> Up
            }
          Failed -> Failed
          Up ->
            case diff > 0 {
              True -> Failed
              False -> Up
            }
          Down ->
            case diff < 0 {
              True -> Failed
              False -> Down
            }
        }
      })
    {
      Failed -> False
      _ -> True
    }
  }
}
