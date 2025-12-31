import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscure = true;

  Future<void> _login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() => _loading = true);

    final error = await AuthService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() => _loading = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: const Text('Đăng nhập'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// EMAIL
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// QUÊN MẬT KHẨU
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forgot_password'),
                    child: const Text('Quên mật khẩu?'),
                  ),
                ),

                const SizedBox(height: 16),

                /// NÚT ĐĂNG NHẬP
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                /// OR
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 16),

                /// GOOGLE
                _socialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Tiếp tục với Google',
                  onTap: () {},
                ),

                const SizedBox(height: 12),

                /// FACEBOOK
                _socialButton(
                  icon: Icons.facebook,
                  text: 'Tiếp tục với Facebook',
                  onTap: () {},
                ),

                const SizedBox(height: 24),

                /// ĐĂNG KÝ
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Bạn chưa có tài khoản? '),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/sign_up'),
                      child: Text(
                        'Đăng ký ngay',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
