import 'package:dragable_card/cubit/pages_cubit.dart';
import 'package:dragable_card/models/page_model.dart';
import 'package:dragable_card/screens/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageTemplate extends StatefulWidget {
  final PageModel pageModel;
  const PageTemplate({
    required this.pageModel,
    Key? key,
  }) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  GlobalKey listKey = GlobalKey();
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<PagesCubit>()
        .setScrollController(widget.pageModel, controller);
    final viewModel = context.read<PagesCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 35, right: 35, bottom: 5),
              color: Colors.deepOrange.shade300,
              height: kToolbarHeight,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(widget.pageModel.title),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: false,
                key: listKey,
                controller: controller,
                itemCount: widget.pageModel.cardList.length,
                itemBuilder: (_, i) {
                  return DragTarget(
                    onAccept: (value) {
                      print("onAccept $value");
                      // setState(() {
                      //   widget.add("$value");
                      // });
                    },
                    onMove: (DragTargetDetails value) {
                      RenderBox? box = listKey.currentContext
                          ?.findRenderObject() as RenderBox?;
                      Offset? widgetPosition = box?.localToGlobal(Offset.zero);

                      final listTopOffset = (widgetPosition?.dy ?? 0) +
                          ((box?.size.height ?? 0) * .1);

                      final listBottomOffset = (widgetPosition?.dy ?? 0) +
                          ((box?.size.height ?? 0) * .9);

                      if (value.offset.dx <= size.width * .1) {
                        viewModel.previousPage();
                      } else if (value.offset.dx >= size.width * .9) {
                        viewModel.nextPage();
                      } else if (value.offset.dy <= listTopOffset) {
                        viewModel.scrollUp();
                      } else if (value.offset.dy >= listBottomOffset) {
                        viewModel.scrollDown();
                      }
                    },
                    builder: (_, __, ___) {
                      return CardWidget(
                        cardModel: widget.pageModel.cardList[i],
                        color: widget.pageModel.cardsColor,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
