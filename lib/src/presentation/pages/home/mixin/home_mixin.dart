part of '../home_page.dart';

mixin HomeMixin on State<HomePage> {
  late final ScrollController _scrollController;
  late final HomeBloc bloc = context.read<HomeBloc>();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    getColors(localSource.gender);
    _handleVerificationOrLocationRequest();
    _initializeScrollController();
    _checkProfileIdRequirement();
    _initializeFCMTokenListener();
  }

  void _handleVerificationOrLocationRequest() {
    if (!localSource.isVerified) {
      _startLivenessDetection();
    } else {
      _requestLocationPermission();
    }
  }

  void _initializeScrollController() {
    _scrollController = ScrollController();
  }

  void _checkProfileIdRequirement() {
    if (localSource.profileId.isEmpty) {
      localSource.setRequiredQuestionnaire(value: true);
    }
  }

  void _initializeFCMTokenListener() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      if (newToken.isNotEmpty) {
        localSource.setDeviceData(fcmToken: newToken);
        await sl<AuthRepository>().setDeviceId();
      }
    });
  }

  Future<void> _startLivenessDetection() async {
    try {
      final result = await MncIdentifierFace().startLivenessDetection();
      final smileDetection = result.detectionResult.firstWhere(
        (e) => e.detectionMode.toString() == 'SMILE',
      );

      context.read<ImageUploadBloc>().add(
            UploadImageEvent(file: File(smileDetection.imagePath), isVerification: true),
          );
    } catch (e) {
      context.showFloatingSnackBar(message: 'Tasdiqlanmadi');
      await _startLivenessDetection();
    }
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        final openedSettings = await Geolocator.openLocationSettings();
        if (openedSettings) {
          bloc.add(GetUsersEvent(filter: localSource.filter));
        }
      }
    } else if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  void _scrollToTopAndNotify() {
    _scrollController
        .animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .then((_) {
      bloc.add(const HomeScroll(isScrollingTop: false));
    });
  }

  void listener(BuildContext context, HomeState state) {
    _scrollToTopAndNotify();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
