import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> dispatchError(
  dynamic exception,
  StackTrace stack, [
  String reason = '[no description]',
]) async {
  try {
    final crashlytics = FirebaseCrashlytics.instance;

    await crashlytics.recordError(
      exception,
      stack,
      reason: 'by $reason',
      printDetails: true,
    );
  } catch (_) {}
}
