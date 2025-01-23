import '../constants/app_images.dart';

class OnBoardingModel {
  String imagePath;
  String title;
  String desc;

  OnBoardingModel({
    required this.imagePath,
    required this.title,
    required this.desc,
  });
}

List<OnBoardingModel> onBoarding = [
  OnBoardingModel(
    title: 'We provide professional services at friendly price',
    desc: 'Get the professional and expert home cleaning services nearby you',
    imagePath: AppImages.intro1,
  ),
  OnBoardingModel(
    title: 'Let’s make awesome changes to home with your experise',
    desc:
        'Find more opportunities to grow you home services in by applying on regular jobs',
    imagePath: AppImages.intro2,
  ),
];
