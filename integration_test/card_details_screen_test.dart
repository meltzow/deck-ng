import 'package:deck_ng/env.dart';
import 'package:deck_ng/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'Localization.dart';

void main() {
  testWidgets('tap on the floating action button, verify counter',
      (tester) async {
    var lo = await Localization.getLocalizations(tester);
    BuildEnvironment.init(flavor: BuildFlavor.testing);
    assert(env != null);

    await tester.pumpWidget(MyApp(debugShowCheckedModeBanner: false));
    Get.toNamed('/cards/details');
    await Future.delayed(const Duration(seconds: 1), () {});
    await tester.pumpAndSettle();

    // Verify the counter starts at 0.
    expect(find.text('0'), findsOneWidget);

    // Finds the floating action button to tap on.
    final fab = find.byKey(const Key('increment'));

    // Emulate a tap on the floating action button.
    await tester.tap(fab);

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Verify the counter increments by 1.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
