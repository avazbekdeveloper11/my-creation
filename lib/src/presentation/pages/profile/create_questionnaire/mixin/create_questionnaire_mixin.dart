part of '../create_questionnaire_page.dart';

mixin CreateQuestionnaireMixin on State<CreateQuestionnairePage> {
  /// scroll
  late final ScrollController _scrollController;
  late final GlobalKey<FormState> formKey;

  bool appBarShow = false;
  bool autoValidate = false;

  /// controller
  late final TextEditingController nameController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController healthyStatusController;
  late final TextEditingController workPlaceController;
  late final TextEditingController professionController;
  late final TextEditingController skillsController;
  late final TextEditingController bioController;
  late final TextEditingController requirementsController;

  /// focus
  late final FocusNode nameFocusNode;
  late final FocusNode heightFocusNode;
  late final FocusNode weightFocusNode;
  late final FocusNode healthyStatusFocusNode;
  late final FocusNode workPlaceFocusNode;
  late final FocusNode professionFocusNode;
  late final FocusNode skillsFocusNode;
  late final FocusNode bioFocusNode;
  late final FocusNode requirementsFocusNode;

  @override
  void initState() {
    context.read<QuestionnaireBloc>().add(ClearEvent());
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

    /// controller
    nameController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    healthyStatusController = TextEditingController();
    workPlaceController = TextEditingController();
    professionController = TextEditingController();
    skillsController = TextEditingController();
    bioController = TextEditingController();
    requirementsController = TextEditingController();

    /// focus
    nameFocusNode = FocusNode();
    heightFocusNode = FocusNode();
    weightFocusNode = FocusNode();
    healthyStatusFocusNode = FocusNode();
    workPlaceFocusNode = FocusNode();
    professionFocusNode = FocusNode();
    skillsFocusNode = FocusNode();
    bioFocusNode = FocusNode();
    requirementsFocusNode = FocusNode();

    nameFocusNode.addListener(
      () {
        if (nameFocusNode.hasFocus) {
          _scrollController.animateTo(
            40,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    heightFocusNode.addListener(
      () {
        if (heightFocusNode.hasFocus) {
          _scrollController.animateTo(
            137,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    weightFocusNode.addListener(
      () {
        if (weightFocusNode.hasFocus) {
          _scrollController.animateTo(
            137,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    healthyStatusFocusNode.addListener(
      () {
        if (healthyStatusFocusNode.hasFocus) {
          _scrollController.animateTo(
            601,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    workPlaceFocusNode.addListener(
      () {
        if (workPlaceFocusNode.hasFocus) {
          _scrollController.animateTo(
            940,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    professionFocusNode.addListener(
      () {
        if (professionFocusNode.hasFocus) {
          _scrollController.animateTo(
            1150,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    skillsFocusNode.addListener(
      () {
        if (skillsFocusNode.hasFocus) {
          _scrollController.animateTo(
            1470,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    bioFocusNode.addListener(
      () {
        if (bioFocusNode.hasFocus) {
          _scrollController.animateTo(
            1480,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    requirementsFocusNode.addListener(
      () {
        if (requirementsFocusNode.hasFocus) {
          _scrollController.animateTo(
            1490,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    /// controller
    nameController.dispose();
    heightController.dispose();
    weightController.dispose();
    healthyStatusController.dispose();
    workPlaceController.dispose();
    professionController.dispose();
    skillsController.dispose();
    bioController.dispose();
    requirementsController.dispose();

    /// focus
    nameFocusNode.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();
    healthyStatusFocusNode.dispose();
    workPlaceFocusNode.dispose();
    professionFocusNode.dispose();
    skillsFocusNode.dispose();
    bioFocusNode.dispose();
    requirementsFocusNode.dispose();
    super.dispose();
  }
}
