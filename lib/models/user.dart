import 'package:feathersjs_demo_app/global.dart';
import 'package:username_gen/username_gen.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  static List<String> profileImages = [
    "https://cdn.pixabay.com/photo/2020/05/09/13/29/photographer-5149664_1280.jpg",
    'https://i.pinimg.com/736x/fd/6e/04/fd6e04548095d7f767917f344a904ff1.jpg',
    'https://sguru.org/wp-content/uploads/2017/03/cute-n-stylish-boys-fb-dp-2016.jpg',
  ];

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.id,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      name: UsernameGen().generate(),
      email: map['email'] as String,
      imageUrl: profileImages[random.nextInt(profileImages.length)],
    );
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}
