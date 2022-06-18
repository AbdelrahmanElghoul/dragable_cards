import 'package:dragable_card/models/card_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final CardModel cardModel;
  final Color color;
  const CardWidget({
    required this.color,
    required this.cardModel,
    Key? key,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: LayoutBuilder(builder: (context, constrain) {
        return LongPressDraggable<CardModel>(
          data: widget.cardModel,
          ignoringFeedbackSemantics: false,
          maxSimultaneousDrags: 1,
          // widget appear when dragged
          feedback: SizedBox(
            width: constrain.maxWidth,
            height: constrain.maxHeight,
            child: _card(),
          ),
          // hapticFeedbackOnStart: false,
          dragAnchorStrategy: (Draggable<Object> draggable,
              BuildContext context, Offset position) {
            RenderBox? box =
                _key.currentContext?.findRenderObject() as RenderBox?;
            Offset? widgetPosition = box?.localToGlobal(Offset.zero);

            return const Offset(0, 0);
          },
          childWhenDragging: Opacity(
            opacity: .2,
            child: _card(),
          ),
          // onDragUpdate: (drag) {
          //   // print('''
          //   // ${drag.globalPosition.dx} / ${size.width}
          //   // ${drag.globalPosition.dy} / ${size.height}
          //   // ''');
          //
          //   // if(drag.globalPosition.d)
          // },
          child: _card(key: _key),
        );
      }),
    );
  }

  Widget _card({Key? key}) {
    return Card(
      margin: const EdgeInsetsDirectional.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 100,
        width: 200,
        color: widget.color,
        alignment: Alignment.center,
        child: Text(widget.cardModel.name),
      ),
    );
  }
}
