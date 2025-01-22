import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sovchilar_mobile/src/core/extension/extension.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/filter/filter_bloc.dart';
import 'package:sovchilar_mobile/src/presentation/bloc/questionnaire/questionnaire_bloc.dart';

import '../../../data/models/home/user_model.dart';

class CityBottomSheet extends StatelessWidget {
  const CityBottomSheet({super.key, required this.onTap});

  final Function(PlaceOfBirth? name) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) => previous.parentPlaceApiStatus != current.parentPlaceApiStatus,
      builder: (context, state) {
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'district'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 0.7.sh,
                child: !state.parentPlaceApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.parentPlaces?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () => onTap(state.parentPlaces?[index]),
                              title: Text(state.parentPlaces?[index].localization?.localizedValue ?? ''),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 14.sp,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CityBottomSheetProfile extends StatelessWidget {
  const CityBottomSheetProfile({super.key, required this.onTap});

  final Function(PlaceOfBirth? name) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionnaireBloc, QuestionnaireState>(
      buildWhen: (previous, current) => previous.parentPlaceApiStatus != current.parentPlaceApiStatus,
      builder: (context, state) {
        return Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'district'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              12.verticalSpace,
              SizedBox(
                height: 0.7.sh,
                child: !state.parentPlaceApiStatus.isLoading
                    ? SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.parentPlaces?.length ?? 0,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () => onTap(state.parentPlaces?[index]),
                              title: Text(state.parentPlaces?[index].localization?.localizedValue ?? ''),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 14.sp,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
