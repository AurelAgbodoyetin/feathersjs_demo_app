import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Colors.blue,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}

class MiniCPI extends StatelessWidget {
  const MiniCPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 15, maxWidth: 15),
      child: Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.blue.withOpacity(.7),
            backgroundColor: Colors.white,
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
