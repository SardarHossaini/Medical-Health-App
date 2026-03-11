import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_health_app/screen/login_screen.dart';
import 'package:medical_health_app/widgets/navbar_roots.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passToggle = true;
  bool confirmPassToggle = true;
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top decorative header
            Container(
              height: size.height * 0.28,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7165D6), Color(0xFF9B8EFC)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7165D6).withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated medical icon
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      builder: (context, double value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.medical_services, color: Colors.white, size: 35),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12),

                    // Welcome text
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 5),

                    // Subtitle
                    Text(
                      "Join us to start your health journey",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Form Section
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),

                    // Progress indicator (optional)
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF7165D6), Color(0xFF9B8EFC)],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Step 1 of 3",
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    // Full Name Field
                    _buildInputField(
                      controller: _fullNameController,
                      label: "Full Name",
                      hint: "Enter your full name",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    // Email Field
                    _buildInputField(
                      controller: _emailController,
                      label: "Email",
                      hint: "Enter your email address",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    // Phone Field
                    _buildInputField(
                      controller: _phoneController,
                      label: "Phone Number",
                      hint: "Enter your phone number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    // Password Field
                    _buildPasswordField(
                      controller: _passwordController,
                      label: "Password",
                      hint: "Create a password",
                      isVisible: passToggle,
                      onToggle: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Password must contain at least one number';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 15),

                    // Confirm Password Field
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: "Confirm Password",
                      hint: "Re-enter your password",
                      isVisible: confirmPassToggle,
                      onToggle: () {
                        setState(() {
                          confirmPassToggle = !confirmPassToggle;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10),

                    // Password strength indicator (optional)
                    if (_passwordController.text.isNotEmpty)
                      _buildPasswordStrengthIndicator(_passwordController.text),

                    SizedBox(height: 15),

                    // Terms and Conditions Checkbox
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: true, // You can make this stateful
                            onChanged: (value) {
                              // Handle terms acceptance
                            },
                            activeColor: Color(0xFF7165D6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                              children: [
                                TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: TextStyle(
                                    color: Color(0xFF7165D6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: Color(0xFF7165D6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    // Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFF7165D6), Color(0xFF9B8EFC)]),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF7165D6).withOpacity(0.3),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Navigate to next step or home
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => NavbarRoots()),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Social Sign Up Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.email,
                          color: Colors.red[700],
                          onTap: () {},
                          isAsset: false,
                        ),
                        SizedBox(width: 15),
                        _buildSocialButton(
                          icon: Icons.facebook,
                          color: Colors.blue[700],
                          onTap: () {},
                          isAsset: false,
                        ),
                        SizedBox(width: 15),
                        _buildSocialButton(icon: Icons.apple, onTap: () {}, isAsset: false),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7165D6),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF7165D6),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for input fields
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Color(0xFF7165D6), size: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
        validator: validator,
      ),
    );
  }

  // Helper method for password fields
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isVisible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF7165D6), size: 22),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              isVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[500],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
        validator: validator,
      ),
    );
  }

  // Password strength indicator
  Widget _buildPasswordStrengthIndicator(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    String strengthText;
    Color strengthColor;

    switch (strength) {
      case 0:
      case 1:
        strengthText = "Weak";
        strengthColor = Colors.red;
        break;
      case 2:
        strengthText = "Fair";
        strengthColor = Colors.orange;
        break;
      case 3:
        strengthText = "Good";
        strengthColor = Colors.yellow[700]!;
        break;
      case 4:
        strengthText = "Strong";
        strengthColor = Colors.green;
        break;
      default:
        strengthText = "";
        strengthColor = Colors.grey;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Row(
          children: [
            Text("Password strength: ", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            Text(
              strengthText,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: strengthColor),
            ),
          ],
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: strength / 4,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
          minHeight: 4,
        ),
      ],
    );
  }

  // Social login button
  Widget _buildSocialButton({
    dynamic icon,
    Color? color,
    required VoidCallback onTap,
    bool isAsset = true,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: isAsset
                ? Image.asset(icon, height: 30, width: 30)
                : Icon(icon, size: 35, color: color),
          ),
        ),
      ),
    );
  }
}
