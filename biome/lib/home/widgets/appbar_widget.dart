import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget({Key? key})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(56),
          child: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 500,
                width: 50,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),
        );
}
