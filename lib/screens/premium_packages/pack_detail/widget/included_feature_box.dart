import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncludedFeatureBox extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;

  const IncludedFeatureBox({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32.spMin,
            width: 32.spMin,
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              imageUrl,
              cacheHeight: 50,
              cacheWidth: 50,
            ),
          ),
          SizedBox(width: 16.spMin),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.spMin,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.spMin),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.spMin,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
