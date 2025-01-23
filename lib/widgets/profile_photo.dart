// import 'package:flutter/material.dart';
// import 'package:beauty_connect/constants/global_variables.dart';
//
// class BuildProfile extends StatelessWidget {
//   final String profilePhoto;
//   BuildProfile({super.key, required this.profilePhoto});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 48,
//       height: 48,
//       child: Stack(children: [
//         Positioned(
//           left: 5,
//           child: Container(
//             width: 38,
//             height: 38,
//             padding: const EdgeInsets.all(1),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Image(
//                 image: AssetImage(profilePhoto),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 12,
//           left: 1,
//           child: Container(
//               padding: EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.add,
//                 size: 10,
//               )),
//         ),
//       ]),
//     );
//   }
// }
