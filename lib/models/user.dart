import 'package:feathersjs_demo_app/global.dart';

class User {
  String name;
  String email;
  String imageUrl;

  static List<String> profileImages = [
    "https://cdn.pixabay.com/photo/2020/05/09/13/29/photographer-5149664_1280.jpg",
    'https://i.pinimg.com/736x/fd/6e/04/fd6e04548095d7f767917f344a904ff1.jpg',
    'https://sguru.org/wp-content/uploads/2017/03/cute-n-stylish-boys-fb-dp-2016.jpg',
  ];

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: profileImages[random.nextInt(profileImages.length)],
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}
