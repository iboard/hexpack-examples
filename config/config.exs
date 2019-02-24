# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :timewrap,
    timer: :default,
    unit: :second,
    calendar: Calendar.ISO,
    representation: :unix
