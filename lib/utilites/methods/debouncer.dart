import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({
    this.delay = const Duration(
      milliseconds: 300,
    ),
  });

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(
      delay,
      action,
    );
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _timer?.cancel();
  }
}
