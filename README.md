# Advent of Code 2024 in Lua

## Usage

### Run a day
Run a GIVEN day:

```
DAY=GIVEN devbox run day
```

It is expected that there will be an input file for the GIVEN day at `input/dayGIVEN.txt`.

For example, to run Day 1, you would want to save the puzzle input to `input/day1.txt` then run:

```
DAY=1 devbox run day
```

### Run tests

Run the tests:

```
devbox run test
```

Run the tests on file changes:

```
devbox run watch
```

### Run benchmarks

Run a benchmark for a GIVEN day:

```
DAY=GIVEN devbox run bench
```

Just like with running a GIVEN day, it is expected that there is an input file for the GIVEN day in the `input/` directory.
