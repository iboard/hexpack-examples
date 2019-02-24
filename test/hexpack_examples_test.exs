defmodule HexpackExamplesTest do
  use ExUnit.Case
  doctest HexpackExamples

  #
  # Read this tests as an example-usage of my hex-packages
  # timewrap, bucketier, and data_source
  #
  
  describe "TIMEWRAP:" do
    use Timewrap

    test "use a new :test_timer" do
    
      # You don't need to use `new_timer(:default_timer)`, this is started with the app
      # For other timer instances you can use `new_timer(:atom)` as here
      
      {:ok, t} = new_timer(:test_timer)
      freeze_time(:test_timer, ~N[1964-08-31 06:00:00])
      
      :timer.sleep(1_010)

      assert current_time(:test_timer) == ~N[1964-08-31 06:00:00]

      unfreeze_time(:test_timer)
      
      # Don't forget to release a timer started with `new_timer` before.
      release_timer(t)
    end

    test "use `with_frozen_time`" do
      # At the moment `with_frozen_times` works with the `:default_timer` only.
      subject = with_frozen_time(~N[1964-08-31 06:00:00], fn -> current_time() end)
      assert -168_372_000 == subject
    end
  end

  describe "BUCKETIER:" do
    alias Bucketier.Bucket

    test "write to and read from bucket" do
      Bucket.bucket("shopping list")
      |> Bucket.put(1, "Milk")
      |> Bucket.put(2, "Butter")
      |> Bucket.put(3, "Bread")
      |> Bucket.commit()

      assert %Bucketier.Bucket{
               data: %{1 => "Milk", 2 => "Butter", 3 => "Bread"},
               name: "shopping list"
             } == Bucket.bucket("shopping list")
    end
  end

  describe "DATA_SOURE:" do
    defmodule ConsumerSpy do
      # A simple spy that records all events received and simulates a 
      # workload by sleeping 10ms
      use GenStage

      def start_link(), do: GenStage.start_link(ConsumerSpy, [])
      @impl true
      def init(state), do: {:consumer, state}

      @impl true
      def handle_events(events, _from, state) do
        # Simulate load
        Process.sleep(10)
        {:noreply, [], [events | state]}
      end

      @impl true
      def handle_call(:get, _from, state) do
        {:reply, Enum.flat_map(state, & &1), [], state}
      end
    end

    test "a consumer receives data" do
      {:ok, datasource} = Datasource.start_link(0, fn state -> {state, state + 1} end)
      {:ok, producer} = Datasource.DataStage.start_link(datasource)
      {:ok, consumer} = ConsumerSpy.start_link()

      GenStage.sync_subscribe(consumer, to: producer, max_demand: 1)
      Process.sleep(100)

      assert GenStage.call(consumer, :get) |> Enum.count() > 9
    end
  end
end
