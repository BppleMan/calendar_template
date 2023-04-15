import 'package:date_picker/calendar/calendar_controller.dart';
import 'package:date_picker/calendar/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef Changed = void Function(CalendarRenderModel model);

class Calendar extends StatelessWidget {
  final CalendarController controller = Get.find();

  final Changed onChanged;

  final itemWidth = 50.0;
  final itemHeight = 48.0;
  final verticalEdge = 32;
  final horizontalEdge = 16;
  final style = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );

  Calendar({
    super.key,
    required this.onChanged,
    CalendarController? controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(controller.model.value.radius),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              yearMonth(),
              const SizedBox(height: 24),
              Obx(
                () {
                  var calendar = controller.model.value.calendar;
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: controller.model.value.weekNames
                              .map((e) => Container(
                                    width: itemWidth,
                                    height: itemHeight,
                                    alignment: Alignment.center,
                                    child: Text(e, style: style),
                                  ))
                              .toList(),
                        ),
                        ...List.generate(
                          calendar.length,
                          (row) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  List.generate(calendar[row].length, (col) {
                                if (calendar[row][col] == null) {
                                  return SizedBox(
                                      width: itemWidth, height: itemHeight);
                                }
                                if (calendar[row][col] ==
                                    controller.selectedDate.value) {
                                  return selectedDay(calendar[row][col]!);
                                }
                                return emptyDay(calendar[row][col]!);
                              }),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget yearMonth() {
    return Row(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => controller.prevMonth(),
          icon: const ImageIcon(AssetImage("images/icon/left.png")),
        ),
        Obx(
          () {
            return Text(
              "${controller.model.value.date.year}/${controller.model.value.date.month}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () => controller.nextMonth(),
          icon: const ImageIcon(AssetImage("images/icon/right.png")),
        ),
      ],
    );
  }

  Widget emptyDay(DateTime date) {
    return InkWell(
      onTap: () => controller.changeSelectedDate(date),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        alignment: Alignment.center,
        child: Text("${date.day}", style: style),
      ),
    );
  }

  Widget selectedDay(DateTime date) {
    return InkWell(
      onTap: () => controller.changeSelectedDate(date),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        alignment: Alignment.center,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF016EED),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text("${date.day}", style: style),
        ),
      ),
    );
  }

  // Widget rangeStart(DateTime date) {}
}
