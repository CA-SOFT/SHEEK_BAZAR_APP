class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'title_onbording1',
      image: 'assets/images/onbording1.png',
      discription: 'description_onbording1'),
  UnbordingContent(
      title: 'title_onbording2',
      image: 'assets/images/onbording2.png',
      discription: "description_onbording2"),
  UnbordingContent(
      title: 'title_onbording3',
      image: 'assets/images/onbording3.png',
      discription: "description_onbording3"),
  UnbordingContent(
      title: 'title_onbording4',
      image: 'assets/images/onbording4.png',
      discription: "description_onbording4"),
];
