import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime date;
  final CalendarDayType type;
  final GestureTapCallback? onTap;
  final int taskCount;
  final int emojiIndex;

  final double width = 50;
  final double height = 50;
  final double emojiHeight = 72;
  final blackStyle = const TextStyle(
    fontSize: 14,
  );
  final whiteStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );
  final blueStyle = const TextStyle(
    color: Color(0xFF016EED),
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );
  final taskColor = const [
    Color(0xFFFFCC0C),
    Color(0xFFC376FF),
    Color(0xFFFF270D),
  ];

  const CalendarDay({
    super.key,
    required this.date,
    required this.type,
    this.onTap,
    this.taskCount = 0,
    this.emojiIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    var isToday = DateTime.now() == date;
    switch (type) {
      case CalendarDayType.generic:
        return isToday ? generic() : today();
      case CalendarDayType.selected:
        return selected();
      case CalendarDayType.rangeStart:
        return rangeStart();
      case CalendarDayType.rangeMiddle:
        return rangeMiddle();
      case CalendarDayType.rangeEnd:
        return rangeEnd();
      case CalendarDayType.emoji:
        return emojiGeneric();
        break;
    }
  }

  Widget generic({Widget? child}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (taskCount > 0) const SizedBox(height: 6),
            if (child != null)
              child
            else
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                child: Text("${date.day}", style: blackStyle),
              ),
            if (taskCount > 0) const SizedBox(height: 2),
            if (taskCount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  taskCount,
                  (index) => Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: taskColor[index % taskColor.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget selected() {
    return generic(
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF016EED),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text("${date.day}", style: whiteStyle),
      ),
    );
  }

  Widget today() {
    return generic(
      child: SizedBox(
        width: 36,
        height: 36,
        child: CustomPaint(
          painter: TodayPainter(),
          child: Center(child: Text("${date.day}", style: blackStyle)),
        ),
      ),
    );
  }

  Widget rangeStart() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: RangeStartPainter(),
        child: Text("${date.day}", style: blackStyle),
      ),
    );
  }

  Widget rangeMiddle() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: RangeMiddlePainter(),
        child: Text("${date.day}", style: whiteStyle),
      ),
    );
  }

  Widget rangeEnd() {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: CustomPaint(
        painter: RangeEndPainter(),
        child: Text("${date.day}", style: blackStyle),
      ),
    );
  }

  Widget emojiGeneric({Widget? child}) {
    return Container(
      width: width,
      height: emojiHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFE0EFFE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 52,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, bottom: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF016EED),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text("${date.day}", style: whiteStyle),
          ),
        ],
      ),
    );
  }
}

enum CalendarDayType {
  generic,
  selected,
  rangeStart,
  rangeMiddle,
  rangeEnd,
  emoji,
}

class TodayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF80B7F6);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 18, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RangeStartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF80B7F6);
    canvas.drawRect(Rect.fromLTWH(size.width / 2, size.height / 2 - 18, 25, 36),
        borderPaint);
    var rectPaint = Paint()..color = const Color(0xFFDDECFD);
    canvas.drawRect(
        Rect.fromLTWH(size.width / 2, size.height / 2 - 18, 25, 36), rectPaint);
    var circlePaint = Paint()..color = const Color(0xFF016EED);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 18, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RangeMiddlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF80B7F6);
    canvas.drawLine(
      Offset(0, size.height / 2 - 18),
      Offset(50, size.height / 2 - 18),
      borderPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2 + 18),
      Offset(50, size.height / 2 + 18),
      borderPaint,
    );
    var rectPaint = Paint()..color = const Color(0xFFDDECFD);
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2, size.height / 2 - 18, 25, 36),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RangeEndPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF80B7F6);
    canvas.drawRect(
        Rect.fromLTWH(0, size.height / 2 - 18, 25, 36), borderPaint);
    var rectPaint = Paint()..color = const Color(0xFFDDECFD);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height / 2 - 18, 25, 36),
      rectPaint,
    );
    var circlePaint = Paint()..color = const Color(0xFF016EED);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 18, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

enum EmojiType {
  empty,
  glum,
  happy,
  sad,
}
