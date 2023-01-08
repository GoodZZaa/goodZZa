class NetWorkResult {
  Result result;
  dynamic response;

  NetWorkResult({
    required this.result,
    this.response,
  });
}

enum Result {
  fail,
  success,
}
