import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing_app/app/router/app_router.gr.dart';
import 'package:flutter_testing_app/auth/auth.dart';
import 'package:lottie/lottie.dart';

class SuccessLoginAnimation extends StatefulWidget {
  const SuccessLoginAnimation({super.key});

  @override
  State<SuccessLoginAnimation> createState() => _SuccessLoginAnimationState();
}

class _SuccessLoginAnimationState extends State<SuccessLoginAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            context.read<ActivityMonitorBloc>().add(
              const ExtendAuthSession(Duration(minutes: 1)),
            );
            context.router.replace(const MainRoute());
          }
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Lottie.asset(
        'assets/lotties/success.json',
        height: 300,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..reset()
            ..forward();
        },
      ),
    );
  }
}
