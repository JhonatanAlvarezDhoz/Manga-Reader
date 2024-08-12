import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:manga_reader/base/ui/widgets/custom_text.dart';
import 'package:manga_reader/localization/languageManager.dart';
import 'package:manga_reader/modules/home/ui/widgets/widgets.dart';
import 'package:manga_reader/themes/theme_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final List<BoxShadow> boxShadow = [
      BoxShadow(
        color: theme.textTheme.bodyMedium!.color!.withOpacity(0.2),
        offset: const Offset(0, 10), // Desplazamiento en X y Y
        blurRadius: 5, // Radio del desenfoque
        spreadRadius: -4, // Radio de expansión
      ),
    ];
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
          child: Column(
            children: [
              SizedBox(height: constraints.maxHeight * 0.05),
              GestureDetector(
                onTap: () async {
                  log("Tap");
                  await showSearch(
                    context: context,
                    delegate: SearchMangaDelegate(),
                  );
                },
                child: const SearchableTextFormField(),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                      vertical: 10, horizontal: constraints.maxWidth * 0.04),
                  child: CustomText(
                      text: LanguageManager().translate().continueReading)),
              SizedBox(height: constraints.maxHeight * 0.02),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                height: constraints.maxHeight * 0.35,
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: theme.textTheme.bodyMedium!.color!
                            .withOpacity(0.2), // Color con opacidad
                        offset: const Offset(0, 10), // Desplazamiento en X y Y
                        blurRadius: 15, // Radio del desenfoque
                        spreadRadius: -3, // Radio de expansión
                      ),
                    ],
                    color: theme.scaffoldBackgroundColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Kimetsu no yaiba",
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    const CustomText(
                      text: "Chapter",
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    SizedBox(
                      height: 82,
                      width: constraints.maxHeight,
                      child: Row(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            height: 20,
                            child: ProgressBar(
                              value: 0.6,
                              height: 8.0,
                              backgroundColor: Colors.grey[300]!,
                              progressColor: ThemeColors.greenColor,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.37,
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.symmetric(
                                  horizontal: constraints.maxWidth * 0.05,
                                  vertical: constraints.maxHeight * 0.01),
                              width: constraints.maxWidth,
                              child: SvgPicture.asset(
                                "assets/icons/reader.svg",
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.05,
                          width: constraints.maxWidth * 0.3,
                          decoration: BoxDecoration(
                            color: theme.hintColor,
                            boxShadow: boxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: LanguageManager().translate().see,
                                color: ThemeColors.white,
                              ),
                              SizedBox(width: constraints.maxWidth * 0.02),
                              SvgPicture.asset(
                                "assets/icons/see.svg",
                                color: ThemeColors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
