import 'package:flutter/material.dart';

class UserGiftCardModel {
  final String id;
  final String senderName;
  final String email;
  final String amountText;
  final String badgeType; // 'Received' or 'Purchased'
  final Color cardColor;

  UserGiftCardModel({
    required this.id,
    required this.senderName,
    required this.email,
    required this.amountText,
    required this.badgeType,
    this.cardColor = const Color(0xFF195ABE),
  });
}
