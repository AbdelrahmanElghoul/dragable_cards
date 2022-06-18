import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragable_card/cubit/pages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/page_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PagesCubit>().setCarouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PagesCubit>();
    return Scaffold(
      body: CarouselSlider(
        carouselController: viewModel.carouselController,
        items: viewModel.pages
            .map(
              (page) => PageTemplate(pageModel: page),
            )
            .toList(),
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
