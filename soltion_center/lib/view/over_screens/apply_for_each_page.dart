import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';

import 'internet_check_dialog.dart';
import 'not_supported_web.dart';

class ApplyForEachPage extends StatelessWidget {
  final Widget child;
  const ApplyForEachPage({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NotSupportedWebView(
      child: Stack(
        children: [
          SafeArea(
            top: false,
            bottom: true,
            child: WillPopScope(
              onWillPop: () async => false,
              child: directionalityWidget(context, child),
            ),
          ),
          directionalityWidget(
            context,
            const InternetCheckDialog(),
          ),
        ],
      ),
    );
  }

  Widget directionalityWidget(BuildContext context, Widget child) {
    final lang = context.watch<LocalizationController>();
    return Directionality(
        textDirection: TextDirection.values
            .byName(lang.getAppLang == 'ar' ? 'rtl' : 'ltr'),
        child: child);
  }
}
