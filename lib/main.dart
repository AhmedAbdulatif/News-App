import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/business_logic/news_cubit/NewsCubit.dart';
import 'package:news_app/business_logic/news_cubit/NewsStates.dart';
import 'package:news_app/data/api/news_api.dart';
import 'package:news_app/data/cashe_helper.dart';
import 'package:news_app/layout/news_layout.dart';

import 'shared/constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBool(key: 'isDark');
  bool? isRtl = CashHelper.getBoolRtl(key: 'isRtl');

  runApp(MyApp(isDark, isRtl));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final bool? isRtl;

  const MyApp(this.isDark, this.isRtl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..changeAppMode(fromShared: isDark)
        ..changeAppDirection(fromShared: isRtl)
        ..getGeneralArticles()
        ..getTechnologyArticles()
        ..getSportsArticles()
        ..getHealthArticles(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode:
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Directionality(
              textDirection: NewsCubit.get(context).isRtl
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: const NewsLayout()),
        ),
      ),
    );
  }
}
