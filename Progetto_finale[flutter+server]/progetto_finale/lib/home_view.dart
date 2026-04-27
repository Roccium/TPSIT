import 'package:flutter/material.dart';
import 'package:progetto_finale/Widgets/draggableWidget.dart';
import 'package:provider/provider.dart';
import '../notiefier.dart';
import 'package:progetto_finale/Widgets/bodyZone.dart';
import 'costanti.dart';
// ─────────────────────────────────────────────────────────────────────────────
// HOME VIEW
// ─────────────────────────────────────────────────────────────────────────────

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final armadio = context.watch<ArmadioNotifier>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Armadio di inserirenome',
          style: TextStyle(color: appDarkColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: armadio.isLoading
          ? const Center(child: CircularProgressIndicator(color: appDarkColor))
          : LayoutBuilder(
              builder: (context, constraints) {
                return  Stack(
                    clipBehavior: Clip.none,
                    children: armadio.widgets.map((w) {final id = armadio.sezioni.indexWhere((e) => e.titolo == w['id']);
  return DraggableRotatableWidget( 
    key: ValueKey(w['id']),
    initialDx: w['dx'],
    initialDy: w['dy'],
    onPositionChanged: (dx, dy) {
      armadio.updateWidgetPosition(w['id'], dx, dy);
    },
    onTap: () => _showOrderMenu(context, w['id'], armadio),
    child: SizedBox(
      height: w['h'],
      width: w['w'],
      child: BodyZone(sezione: armadio.sezioni[id]),
    ),
  );
}).toList(),
                  );
                
              },
            ),
    );
  }
}

void _showOrderMenu(BuildContext context, String id, ArmadioNotifier armadio) async {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  final result = await showMenu<String>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx + 100,
      position.dy + 100,
    ),
    items: [
      const PopupMenuItem(
        value: 'front',
        child: Row(children: [
          Icon(Icons.arrow_upward),
          SizedBox(width: 8),
          Text('Primo piano'),
        ]),
      ),
      const PopupMenuItem(
        value: 'back',
        child: Row(children: [
          Icon(Icons.arrow_downward),
          SizedBox(width: 8),
          Text('Secondo piano'),
        ]),
      ),
    ],
  );

  if (result == 'front') armadio.bringToFront(id); // 👈 passa id non index
  if (result == 'back') armadio.sendToBack(id);
}

