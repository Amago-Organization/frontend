// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ProfileMenuNavDetail extends StatelessWidget {
  final String? name;
  final String? image;
  final double? size;
  const ProfileMenuNavDetail({
    super.key,
    required this.name,
    this.image,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: image != null
          ? Image.network(
              image!,
              width: size ?? SizeToken.xl3,
              height: size ?? SizeToken.xl3,
            )
          : Container(
              width: size ?? SizeToken.xl3,
              height: size ?? SizeToken.xl3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorToken.dark,
                    ColorToken.neutral,
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: TextLabelL1Light(
                text: (name?.isNotEmpty == true) ? name![0].toUpperCase() : '?',
              ),
            ),
    );
  }
}
