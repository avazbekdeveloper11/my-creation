import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    this.interval,
    required this.onChangeEnd,
    required this.values,
    this.onChanged,
    this.title = '',
  });

  final num min;
  final num max;
  final double? interval;
  final SfRangeValues values;
  final ValueChanged<SfRangeValues>? onChangeEnd;
  final Function(SfRangeValues values)? onChanged;
  final String title;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.verticalSpace,
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        6.verticalSpace,
        SfRangeSlider(
          min: widget.min,
          max: widget.max,
          values: widget.values,
          interval: widget.interval ?? 5,
          showTicks: true,
          showLabels: true,
          showDividers: true,
          onChangeEnd: widget.onChangeEnd,
          stepSize: 1,
          activeColor: AppColor.mainColor.withOpacity(0.8),
          enableTooltip: true,
          minorTicksPerInterval: 5,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
