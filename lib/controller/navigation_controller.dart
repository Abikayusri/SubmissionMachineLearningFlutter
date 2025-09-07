import 'package:flutter/material.dart';
import 'package:submission/ui/result_page.dart';
import 'package:submission/utils/snackbar_extension.dart';

class NavigationController extends ChangeNotifier {
  void goToDetailReference(BuildContext context, String keyword) {
    context.showSuccessSnackBar("Go To Detail Reference $keyword!");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DetailRestaurantScreen(restaurantId: restaurantId),
    //   ),
    // );
  }

  void goToSettings(BuildContext context) {
    context.showSuccessSnackBar("Go To Settings");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const SettingsScreen(),
    //   ),
    // );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void goToResultPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage()),
    );
  }
}
