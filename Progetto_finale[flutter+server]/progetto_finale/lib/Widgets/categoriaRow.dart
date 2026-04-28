
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progetto_finale/camera.dart';
import 'package:progetto_finale/costanti.dart';
import 'package:progetto_finale/models.dart';
import 'package:provider/provider.dart';

import '../Helpers/notiefier.dart';

class CategoriaRow extends StatelessWidget {
  final SezioneArmadio sezione;
  final Function(String path)? onSetCover;

  const CategoriaRow({super.key, required this.sezione, this.onSetCover});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: sezione.capi.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) return _returnToTransparent(context);
          if (index == sezione.capi.length + 1) return _buildAddCard(context);

          final capo = sezione.capi[index - 1];
          final bool isCover = sezione.coverPath == capo.imagePath;

          return GestureDetector(
            onDoubleTap: () {
              popUpElimina(context, capo);
            },
            onTap: () {
              if (onSetCover != null) onSetCover!(capo.imagePath);
              Feedback.forLongPress(context);
            },
            child: Stack(
              children: [
                _buildImageCard(capo.imagePath),
                if (isCover)
                  Positioned(
                    top: 8,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: appStrokeColor, shape: BoxShape.circle),
                      child: const Icon(Icons.star,
                          color: Colors.white, size: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
  Future<dynamic> popUpElimina(context,Capo capo){
    return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Conferma eliminazione'),
                  content: const Text('Sei davvero sicuro di voler cancellare questo elemento?'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Chiude semplicemente il popup
                      },
                      child: const Text('Annulla', style: TextStyle(color: Colors.grey)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        
                        final notifier = Provider.of<ArmadioNotifier>(context,listen: false);
                          await notifier.eliminaCapo(capo);
                          Navigator.pop(context);
                      },
                      child: const Text('Sicuro di cancellare'),
                    ),
                  ],
                );
              },
            );
  }
  Widget _returnToTransparent(BuildContext context) {
    return GestureDetector(
      onTap: () => onSetCover?.call(""),
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Colors.grey.shade300,
              width: 1.5,
              style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers_clear_outlined,
                size: 28, color: Colors.grey.shade400),
            const SizedBox(height: 4),
            Text("Reset",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String path) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Image(
        image: ResizeImage(FileImage(File(path)), width: 300),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildAddCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CameraView(categoria: sezione.titolo)),
        );
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
              style: BorderStyle.solid),
        ),
        child: Center(
          child: Icon(Icons.add_a_photo,
              size: 32, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}