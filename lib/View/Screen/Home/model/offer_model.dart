import 'package:flutter/material.dart';

class OfferModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color backgroundColor;

  OfferModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.backgroundColor = const Color(0xFFE3F2FD),
  });
}
