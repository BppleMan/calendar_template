import 'package:date_picker/calendar/calendar_model.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  late Rx<CalendarRenderModel> model;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  CalendarController({DateTime? date, int firstDay = 7}) {
    var now = DateTime.now();
    model = CalendarRenderModel(date: date ?? DateTime.now()).obs;
  }

  void nextYear() {}

  void nextMonth() {
    model.update((val) {
      if (val != null) {
        val.date = DateTime(val.date.year, val.date.month + 1);
      }
    });
  }

  void prevMonth() {
    model.update((val) {
      if (val != null) {
        val.date = DateTime(val.date.year, val.date.month - 1);
      }
    });
  }

  void changeWeekLanguage(WeekLanguage wl) {
    model.update((val) {
      val?.weekLanguage = wl;
    });
  }

  void changeFirstDay(int firstDay) {
    model.update((val) {
      val?.firstDay = firstDay;
    });
  }

  void changeYearMonth(DateTime date) {
    model.update((val) {
      val?.date = date;
    });
  }

  void changeSelectedDate(DateTime date) {
    if (selectedDate.value == date) {
      selectedDate.value = null;
    } else {
      selectedDate.value = date;
    }
  }
}
