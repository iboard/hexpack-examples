# Hexpack Examples
[![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](http://hexdocs.pm/hexpack_examples/)
[![Documentation](https://travis-ci.com/iboard/hexpack_examples.svg?branch=master)](https://travis-ci.com/iboard/hexpack_examples)

The aim of this repository is to show examples of how my HEX-packages
can be used in a tested manner. This makes this examples for 

- [data_source][]
- [bucketier][]
- [timewrap][]

the first place to look at when you want to use one of these packages
in Elixir.

### Configuration

In your `mix.exs` file add the following dependencies (or some of them).
When using `Timewrap`, don't forget to add it as an `extra_application`.

        # Run "mix help compile.app" to learn about applications.
        def application do
          [
            extra_applications: [:logger,:timewrap],
            mod: {HexpackExamples.Application, []}
          ]
        end

        # Run "mix help deps" to learn about dependencies.
        defp deps do
          [
            {:data_source, "~> 0.1" },
            {:bucketier, "~> 0.1" },
            {:timewrap, "~> 0.1" }
          ]
        end

### Examples

See file `test/hexpack_examples_test.exs`. These are the examples of
usage.


[data_source]: https://hexdocs.pm/data_source
[bucketier]: https://hexdocs.pm/bucketier
[timewrap]: https://hexdocs.pm/timewrap
