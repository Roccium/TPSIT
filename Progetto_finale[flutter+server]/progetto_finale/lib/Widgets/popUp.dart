import 'package:flutter/material.dart';
import 'package:progetto_finale/costanti.dart';
import 'package:progetto_finale/models.dart';
import 'package:progetto_finale/notiefier.dart';
import 'package:provider/provider.dart';

import 'categoriaRow.dart';

class PopupCategoria extends StatelessWidget {
  final SezioneArmadio sezione;
  const PopupCategoria({super.key, required this.sezione});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sezione.titolo,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: appDarkColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Premi un capo per impostarlo come sfondo.",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ),
            CategoriaRow(
              sezione: sezione,
              onSetCover: (path) {
                context
                    .read<ArmadioNotifier>()
                    .setCategoriaCover(sezione.titolo, path);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}