import 'package:flutter/material.dart';

class GiftCardModel {
  final String id;
  final String title;
  final String amountText;
  final Color cardColor;
  final String svgPath;

  GiftCardModel({
    required this.id,
    required this.title,
    required this.amountText,
    required this.cardColor,
    required this.svgPath,
  });
}
