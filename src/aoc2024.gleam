import gleam/io
import simplifile

pub fn main() {
  io.println("Hello from aoc2024!")
}

pub fn read_file(day_num: String) -> String {
  let assert Ok(contents) = simplifile.read("input/day" <> day_num)
  contents
}
