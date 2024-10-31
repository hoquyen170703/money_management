import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/providers/go_router_provider.dart';
import '../../../../utilities/extensions/widget_ref_extension.dart';

class InputCompleteScreen extends ConsumerStatefulWidget {
  const InputCompleteScreen({super.key});

  @override
  ConsumerState createState() => _InputCompleteScreenState();
}

class _InputCompleteScreenState extends ConsumerState<InputCompleteScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ref.colors.background,
      insetPadding: const EdgeInsets.all(32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      icon: Lottie.asset(
        'assets/lotties/input_complete.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(() {
              ref.read(goRouterProvider).pop();
            });
        },
      ),
      title: Text(
        ref.appLocalizations.inputComplete,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ref.colors.mainText,
        ),
      ),
    );
  }
}
