class SplashModel {
  final String image;
  final String title;
  final String subTitle;
  final int index;
  final Function() onPressed;
  SplashModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.index,
      required this.onPressed});
}
