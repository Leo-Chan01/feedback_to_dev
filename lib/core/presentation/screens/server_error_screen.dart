// import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
// import 'package:feedback_to_vfd/core/utils/app_routes.dart';
// import 'package:feedback_to_vfd/core/utils/ui_component_exports.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ServerErrorScreen extends StatefulWidget {
//   const ServerErrorScreen({super.key});

//   static const String name = 'serverErrorScreen';
//   static const String path = '/server-error-screen';

//   @override
//   State<ServerErrorScreen> createState() => _ServerErrorScreenState();
// }

// class _ServerErrorScreenState extends State<ServerErrorScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Server Error, Click to Try again.',
//               style: 16.w700,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             BlocConsumer<PingBloc, PingState>(
//               builder: (context, state) {
//                 return GestureDetector(
//                   onTap: (state is PingLoadingState)
//                       ? null
//                       : () async {
//                           context.read<PingBloc>().add(
//                             PingServerRequestedEvent(),
//                           );
//                           // await Provider.of<PingProvider>(
//                           //   context,
//                           //   listen: false,
//                           // ).setServerReachable().then((value) {
//                           //   if (mounted) {
//                           //     if (value == true) {
//                           //       if (!context.mounted) return;
//                           //       context.replace(AppRoutes.createAccountRoute);
//                           //     } else {
//                           //       if (!context.mounted) return;
//                           //       context.replaceNamed(ServerErrorScreen.name);
//                           //     }
//                           //   }
//                           // });
//                         },
//                   child: (state is PingLoadingState)
//                       ? const yfdCircleLoader()
//                       : Text(
//                           'Try Again',
//                           style: TextStyle(
//                             color: AppColors.yfdPrimary,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                 );
//               },
//               listener: (context, state) {
//                 if (state is PingFailureState) {
//                   context.replaceNamed(ServerErrorScreen.name);
//                   return;
//                 } else if (state is PingSuccessState) {
//                   context.replace(AppRoutes.createAccountRoute);
//                   return;
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
