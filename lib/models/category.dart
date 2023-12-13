import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.title,
    required this.id,
    required this.color,
    required this.imageUrl,
  });
  final String title;
  final String id;
  final Color color;
  final String imageUrl;
}
