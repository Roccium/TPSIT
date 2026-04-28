import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progetto_finale/Widgets/popUp.dart';
import 'package:progetto_finale/costanti.dart';
import 'package:progetto_finale/models.dart';

class BodyZone extends StatelessWidget {
  final SezioneArmadio sezione;

  const BodyZone({super.key, required this.sezione});

  void _apriPopupGalleria(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PopupCategoria(sezione: sezione),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImages = sezione.capi.isNotEmpty;
    final String? coverPath = sezione.coverPath ?? (hasImages ? sezione.capi.last.imagePath : null);

    return GestureDetector(
      onLongPress: () => _apriPopupGalleria(context),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 1.5,
          ),
          image: coverPath != null
              ? DecorationImage(
                  image: ResizeImage(FileImage(File(coverPath)), width: 400),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: coverPath == null
            ? Center(
                child: Icon(
                  kCategoriaIcone[sezione.titolo] ?? Icons.add_a_photo,
                  color: Colors.grey.withValues(alpha: 0.3),
                  size: 28,
                ),
              )
            : null,
      ),
    );
  }
}

