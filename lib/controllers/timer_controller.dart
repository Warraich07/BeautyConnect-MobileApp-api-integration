// timer_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class TimerController extends GetxController {
  Timer? timer;
  int remainingSeconds = 0;
  final time = '00:00'.obs;
  RxInt seconds = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRemainingTime();
  }

  @override
  void onClose() {
    timer?.cancel();
    _saveRemainingTime();
    super.onClose();
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    time.value = '00:00'; // Reset the displayed time if necessary
    seconds.value = 0;
    Workmanager().cancelByTag('timer_task'); // Cancel WorkManager task
  }
  //
  // void updateSeconds(int timeInSeconds) {
  //   if (seconds.value == 0) {
  //     seconds.value = timeInSeconds;
  //     _startTimer(seconds.value);
  //     _scheduleBackgroundTask(seconds.value); // Schedule WorkManager task
  //   }
  // }
  void updateSeconds(int timeInSeconds) {
    if (timer == null) {  // Only start if there's no existing timer
      seconds.value = timeInSeconds;
      _startTimer(seconds.value);
      _scheduleBackgroundTask(seconds.value); // Schedule WorkManager task
    }
  }


  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds <= 0) {
        timer.cancel();
        Workmanager().cancelByTag('timer_task'); // Cancel WorkManager task when timer finishes
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value = '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
        print(time.value);
        remainingSeconds--;
        // print(remainingSeconds);
        _saveRemainingTime();  // Save time on each tick
      }
    });
  }

  Future<void> _saveRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingSeconds', remainingSeconds);
  }

  Future<void> _loadRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();
    remainingSeconds = prefs.getInt('remainingSeconds') ?? 0;
    if (remainingSeconds > 0) {
      _startTimer(remainingSeconds);
      _scheduleBackgroundTask(remainingSeconds); // Ensure background task is scheduled
    }
  }

  void _scheduleBackgroundTask(int seconds) {
    Workmanager().registerOneOffTask(
      'timer_task',
      'timerTask',
      initialDelay: Duration(seconds: seconds),
      inputData: <String, dynamic>{'time': seconds},
      tag: 'timer_task', // Optional tag for cancellation
    );
  }
}
