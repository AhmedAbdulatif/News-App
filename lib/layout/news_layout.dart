import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/presentation/screens/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                cubit.changeAppDirection();
              },
              icon: const Icon(
                Icons.change_circle_outlined,
              ),
            ),
            title: appBarText(context),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {
                    NewsCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_rounded,
                  )),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius:  BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: [
                 BoxShadow(
                    color: Colors.black54, spreadRadius: 0, blurRadius: 5),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: cubit.isRtl
                    ? cubit.bottomItemsArabic
                    : cubit.bottomItemsEnglish,
                currentIndex: cubit.currentIndex,
                onTap: (index) => cubit.changeBottomNavBar(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
