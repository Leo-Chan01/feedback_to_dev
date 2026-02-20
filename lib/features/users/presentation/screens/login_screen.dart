import 'package:feedback_to_vfd/core/helpers/extensions/num_extension.dart';
import 'package:feedback_to_vfd/features/users/presentation/provider/auth_provider.dart';
import 'package:feedback_to_vfd/injection_container.dart';
import 'package:feedback_to_vfd/shared/configs/theme/colors.dart';
import 'package:feedback_to_vfd/shared/widgets/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String name = 'LoginScreen';
  static const String path = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController accessIdController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    accessIdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sl<AuthProvider>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: accessIdController,
                  decoration: InputDecoration(
                    hint: Text(
                      'Input your generated Access Id (CLXXXX)',
                      style: 12.w400,
                    ),
                    label: Text(
                      'Access Id',
                      style: 12.w400.copyWith(color: AppColors.darkGrey02),
                    ),
                    hintStyle: 12.w400.copyWith(color: AppColors.darkGrey02),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.darkGrey01),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.darkGrey01),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.darkGrey01),
                    ),
                  ),
                  style: 14.w400,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an access id';
                    }
                    final usernameRegex = RegExp(r'^CL-[A-Z0-9]{8}$');
                    if (!usernameRegex.hasMatch(value.trim().toUpperCase())) {
                      return 'Please enter a valid access id (e.g., CL-00000000)';
                    }
                    return null;
                  },
                ),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 50,
                      child: MaterialButton(
                        onPressed: provider.isLoading
                            ? null
                            : () => _logUserIn(provider),
                        elevation: 0,
                        color: AppColors.yfdPrimary,
                        disabledColor: AppColors.yfdPrimary.withValues(
                          alpha: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: provider.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Login',
                                style: 16.w400,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _logUserIn(AuthProvider provider) async {
    if (!_formKey.currentState!.validate()) {
      GlobalSnackBar.showInfo('Clear Errors before proceeding');
    } else {
      await provider.logIn(accessIdController.text);
    }
  }
}
