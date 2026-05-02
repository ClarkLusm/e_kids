import 'package:flutter/material.dart';

/// Ảnh minh hoạ cho câu fill-in-the-blank.
/// Hiển thị compact hơn so với PictureMatchScreen
/// vì phần chính là câu văn, không phải ảnh.
class FillBlankIllustrationWidget extends StatelessWidget {
  final String imageUrl;
  final double height;

  const FillBlankIllustrationWidget({
    required this.imageUrl,
    this.height = 140,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFFEEEDFE),
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 36,
                color: Color(0xFF534AB7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
