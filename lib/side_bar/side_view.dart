import 'package:date_picker/calendar/calendar_controller.dart';
import 'package:date_picker/calendar/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Side extends StatelessWidget {
  final CalendarController controller = Get.find();

  final titleStyle = const TextStyle(
    height: 1.45,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final contentStyle = TextStyle(
    height: 1.45,
    fontSize: 11,
    color: Colors.black.withOpacity(0.8),
  );

  Side({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 201,
      child: Column(
        children: [
          tab(),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          settings(),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          mainColor(),
        ],
      ),
    );
  }

  Widget tab() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: Text("Month", style: titleStyle),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: Text("Week", style: titleStyle),
            ),
          ),
        ],
      ),
    );
  }

  Widget settings() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date", style: titleStyle),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            height: 32,
            child: Obx(
              () {
                return TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: (() {
                      var now = DateTime.now();
                      return now.toString().split(" ")[0];
                    })(),
                    hintStyle: const TextStyle(textBaseline: TextBaseline.alphabetic),
                    prefixIcon: const ImageIcon(AssetImage("images/icon/date.png")),
                    isCollapsed: true,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: titleStyle,
                  inputFormatters: [FilteringTextInputFormatter(RegExp("[/.-\\d]"), allow: true)],
                  controller: controller.selectedDate.value != null
                      ? TextEditingController(text: controller.selectedDate.toString().split(" ")[0])
                      : TextEditingController(text: ""),
                  onChanged: (dateString) {
                    try {
                      var date = DateTime.parse(dateString);
                      controller.changeYearMonth(date);
                    } catch (e) {}
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text("Language Of The Week", style: titleStyle),
          const SizedBox(height: 8),
          SizedBox(
            height: 16,
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller.changeWeekLanguage(WeekLanguage.chinese),
                  child: SizedBox(
                    width: 84,
                    child: Row(
                      children: [
                        Obx(() {
                          var image = "images/icon/radio_fill.png";
                          if (controller.model.value.weekLanguage == WeekLanguage.english) {
                            image = "images/icon/radio_empty.png";
                          }
                          return ImageIcon(AssetImage(image), size: 13);
                        }),
                        const SizedBox(width: 4),
                        Text("Chinese", style: contentStyle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.changeWeekLanguage(WeekLanguage.english),
                  child: SizedBox(
                    width: 84,
                    child: Row(
                      children: [
                        Obx(() {
                          var image = "images/icon/radio_empty.png";
                          if (controller.model.value.weekLanguage == WeekLanguage.english) {
                            image = "images/icon/radio_fill.png";
                          }
                          return ImageIcon(AssetImage(image), size: 13);
                        }),
                        const SizedBox(width: 4),
                        Text("English", style: contentStyle),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text("First Day Of The Week", style: titleStyle),
          const SizedBox(height: 8),
          SizedBox(
            height: 16,
            child: Row(
              children: [
                InkWell(
                  onTap: () => controller.changeFirstDay(7),
                  child: SizedBox(
                    width: 84,
                    child: Row(
                      children: [
                        Obx(() {
                          var image = "images/icon/radio_fill.png";
                          if (controller.model.value.firstDay == 1) {
                            image = "images/icon/radio_empty.png";
                          }
                          return ImageIcon(AssetImage(image), size: 13);
                        }),
                        const SizedBox(width: 4),
                        Text("Sunday", style: contentStyle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.changeFirstDay(1),
                  child: SizedBox(
                    width: 84,
                    child: Row(
                      children: [
                        Obx(() {
                          var image = "images/icon/radio_empty.png";
                          if (controller.model.value.firstDay == 1) {
                            image = "images/icon/radio_fill.png";
                          }
                          return ImageIcon(AssetImage(image), size: 13);
                        }),
                        const SizedBox(width: 4),
                        Text("Monday", style: contentStyle),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mainColor() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Main Color", style: titleStyle),
          const SizedBox(height: 8),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: double.infinity,
                    width: 121,
                    child: Row(
                      children: [
                        colorBoard(),
                        Obx(() {
                          return Text(
                            (0xFFFFFFFF - controller.model.value.primaryColor.value).toRadixString(16).toUpperCase(),
                            style: contentStyle,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.1),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Obx(
                      () {
                        TextEditingController textEditingController =
                            TextEditingController(text: "${(controller.model.value.primaryColor.opacity * 100).ceil()}%");
                        return TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          textAlign: TextAlign.center,
                          controller: textEditingController,
                          style: contentStyle,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget colorBoard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: SizedBox(
          width: 16,
          height: 16,
          child: Obx(
            () {
              return Row(
                children: [
                  Expanded(child: Container(color: controller.model.value.primaryColor.withOpacity(1))),
                  Expanded(
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        color: controller.model.value.primaryColor,
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/icon/opacity_bg.png"),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
