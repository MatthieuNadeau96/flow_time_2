class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    // takes the number of ticks (seconds) and returns a stream of the remaining ticks every second
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
