import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_colors.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: EdgeInsets.only(bottom: 5),
      color: AppColors.darkPageBG,
      child: Row(
        // crossAxisAlignment: .start,
        // mainAxisAlignment: .spaceBetween,
        spacing: 8,
        children: [
          SizedBox(
            width: 20,
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              "تعذر تحديث الموقع، يتم عرض الموقع محفوظة.\n اسحب الشاشة لأسفل للمحاولة مجدداً.",
              textAlign: .center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.orange,
                height: 1.8,
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
