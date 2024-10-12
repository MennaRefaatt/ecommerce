import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15.sp,
        vertical: 15.sp,
      ),
      child: Column(
        children: [
          buildValidationRow('At least 1 lowercase letter', hasLowerCase),
          verticalSpacing(2),
          buildValidationRow('At least 1 uppercase letter', hasUpperCase),
          verticalSpacing(2),
          buildValidationRow(
              'At least 1 special character', hasSpecialCharacters),
          verticalSpacing(2),
          buildValidationRow('At least 1 number', hasNumber),
          verticalSpacing(2),
          buildValidationRow('At least 8 characters long', hasMinLength),
        ],
      ),
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: AppColors.grey,
        ),
        horizontalSpacing(6),
        Text(
          text,
          style: TextStyles.font13primaryRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: AppColors.primary,
            decorationThickness: 2,
            color: hasValidated ? AppColors.grey : AppColors.primary,
          ),
        )
      ],
    );
  }
}
