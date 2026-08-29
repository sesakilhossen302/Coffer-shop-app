import 'package:flutter/material.dart';
import '../../../Utils/AppColors/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLoader({
    super.key,
    this.size = 36,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
