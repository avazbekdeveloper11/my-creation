import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/config/themes/themes.dart';
import 'package:sovchilar_mobile/src/core/utils/utils.dart';
import 'package:sovchilar_mobile/src/data/models/image/image_model.dart';
import 'package:sovchilar_mobile/src/presentation/pages/image/image_screen.dart';

class CustomCarouselWithIndicator extends StatefulWidget {
  const CustomCarouselWithIndicator({super.key, this.images});

  final List<ImageModel>? images;

  @override
  State<CustomCarouselWithIndicator> createState() => _CustomCarouselWithIndicatorState();
}

class _CustomCarouselWithIndicatorState extends State<CustomCarouselWithIndicator> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppUtils.kGap12,
        CarouselSlider(
          items: (widget.images ?? [])
              .map(
                (image) => ClipRRect(
                  borderRadius: AppUtils.kBorderRadius12,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImageScreen(
                            list: widget.images ?? [],
                            index: _currentIndex,
                            isAdmin: true,
                          ),
                        ),
                      );
                    },
                    borderRadius: AppUtils.kBorderRadius12,
                    child: CachedNetworkImage(
                      imageUrl: (image.url ?? ''),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => Icon(Icons.error, color: Colors.red),
                      placeholder: (context, error) => Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 260.h,
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (widget.images ?? []).asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = entry.key;
                }),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key ? AppColor.mainColor : AppColor.mainBackColor,
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
