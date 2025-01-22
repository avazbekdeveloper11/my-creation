part of '../edit_profile/edit_profile_page.dart';

mixin EditProfileMixin on State<EditProfilePage> {
  /// ScrollController
  late final ScrollController _scrollController;
  late final GlobalKey<FormState> formKey;

  bool appBarShow = false;
  bool autoValidate = false;

  /// TextEditingController
  late final TextEditingController nameController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController healthyStatusController;
  late final TextEditingController workPlaceController;
  late final TextEditingController professionController;
  late final TextEditingController skillsController;
  late final TextEditingController bioController;
  late final TextEditingController requirementsController;

  /// FocusNode
  late final FocusNode nameFocusNode;
  late final FocusNode heightFocusNode;
  late final FocusNode weightFocusNode;
  late final FocusNode healthyStatusFocusNode;
  late final FocusNode workPlaceFocusNode;
  late final FocusNode professionFocusNode;
  late final FocusNode skillsFocusNode;
  late final FocusNode bioFocusNode;
  late final FocusNode requirementsFocusNode;

  final Map<FocusNode, double> focusScrollPositions = {};

  @override
  void initState() {
    super.initState();

    context.read<QuestionnaireBloc>().add(
          FillDataEvent(profileModel: widget.profile),
        );

    _scrollController = ScrollController();
    formKey = GlobalKey<FormState>();

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels > 40) {
          setState(() {
            appBarShow = true;
          });
        } else if (appBarShow) {
          setState(() {
            appBarShow = false;
          });
        }
      },
    );

    nameController = TextEditingController(text: widget.profile?.name ?? '');
    healthyStatusController = TextEditingController(text: widget.profile?.healthIssues ?? '');
    heightController = TextEditingController(text: widget.profile?.height?.toInt().toString() ?? '');
    weightController = TextEditingController(text: widget.profile?.weight?.toInt().toString() ?? '');
    workPlaceController = TextEditingController(text: widget.profile?.workPlace ?? '');
    professionController = TextEditingController(text: widget.profile?.profession ?? '');
    skillsController = TextEditingController(text: widget.profile?.skills ?? '');
    bioController = TextEditingController(text: widget.profile?.bio ?? '');
    requirementsController = TextEditingController(text: widget.profile?.requirements ?? '');

    /// FocusNode initialization
    nameFocusNode = FocusNode();
    heightFocusNode = FocusNode();
    weightFocusNode = FocusNode();
    healthyStatusFocusNode = FocusNode();
    workPlaceFocusNode = FocusNode();
    professionFocusNode = FocusNode();
    skillsFocusNode = FocusNode();
    bioFocusNode = FocusNode();
    requirementsFocusNode = FocusNode();

    focusScrollPositions[nameFocusNode] = 60;
    focusScrollPositions[heightFocusNode] = 170;
    focusScrollPositions[weightFocusNode] = 170;
    focusScrollPositions[workPlaceFocusNode] = 940;
    focusScrollPositions[professionFocusNode] = 1150;
    focusScrollPositions[skillsFocusNode] = 1470;
    focusScrollPositions[bioFocusNode] = 1480;
    focusScrollPositions[requirementsFocusNode] = 1490;

    nameFocusNode.addListener(() => _handleFocusChange(nameFocusNode));
    heightFocusNode.addListener(() => _handleFocusChange(heightFocusNode));
    weightFocusNode.addListener(() => _handleFocusChange(weightFocusNode));
    workPlaceFocusNode.addListener(() => _handleFocusChange(workPlaceFocusNode));
    professionFocusNode.addListener(() => _handleFocusChange(professionFocusNode));
    skillsFocusNode.addListener(() => _handleFocusChange(skillsFocusNode));
    bioFocusNode.addListener(() => _handleFocusChange(bioFocusNode));
    requirementsFocusNode.addListener(() => _handleFocusChange(requirementsFocusNode));
  }

  void _handleFocusChange(FocusNode focusedNode) {
    if (focusedNode.hasFocus) {
      final targetPosition = focusScrollPositions[focusedNode];
      if (targetPosition != null) {
        _scrollController.animateTo(
          targetPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    /// Dispose controllers and focus nodes
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    healthyStatusController.dispose();
    workPlaceController.dispose();
    professionController.dispose();
    skillsController.dispose();
    bioController.dispose();
    requirementsController.dispose();

    nameFocusNode.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();
    healthyStatusFocusNode.dispose();
    workPlaceFocusNode.dispose();
    professionFocusNode.dispose();
    skillsFocusNode.dispose();
    bioFocusNode.dispose();
    requirementsFocusNode.dispose();

    _scrollController.dispose();
    super.dispose();
  }
}
