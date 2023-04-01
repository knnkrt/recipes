import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:recipes/app/modules/home/home_controller.dart';
import 'package:recipes/app/routes/app_routes.dart';
import 'package:recipes/app/utils/constants/sizer.dart';
import 'package:recipes/app/widgets/buttons/loading_secondary_button.dart';
import 'package:recipes/app/widgets/buttons/secondary_button.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFFfffbf4),
              Color(0XFFf9fdf9),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kWidth30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(Get.width),
                child: Image.asset(
                  "assets/logo.png",
                  width: Get.width / 2,
                ),
              ),
              SizedBox(height: kHeight40),
              // Animated Texts
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: List.generate(
                  controller.homeTexts.length,
                  (index) => TypewriterAnimatedText(
                    controller.homeTexts[index],
                    textAlign: TextAlign.center,
                    textStyle: Theme.of(context).textTheme.headlineSmall!,
                  ),
                ),
              ),
              SizedBox(height: kHeight50),
              // Search box
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.search),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(Get.width),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kHeight10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: kFontSize15,
                      ),
                      SizedBox(width: kWidth12),
                      Text(
                        "Search",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: kHeight15),
              // Random recipe button
              Obx(
                () => controller.findingRandomRecipe.isFalse
                    ? SecondaryButton(
                        text: "Get a random recipe",
                        onPressed: () => controller.getRandomRecipe(),
                      )
                    : const LoadingSecondaryButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
