import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swornim/pages/models/user/user_types.dart';
import 'package:swornim/pages/providers/auth/auth_provider.dart';
import 'package:swornim/pages/widgets/auth/logo_section.dart';
import 'package:swornim/pages/widgets/auth/role_selection.dart';
import 'package:swornim/pages/widgets/auth/signup_form.dart';
import 'package:swornim/pages/widgets/common/custom_button.dart';
import 'login.dart';

class SignupPage extends ConsumerStatefulWidget {
  final VoidCallback? onLoginClicked;

  const SignupPage({super.key, this.onLoginClicked});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedRole = 'client';
  bool _agreeToTerms = false;

  // Define user roles - mapping to UserType enum
  final Map<String, Map<String, dynamic>> _userRoles = {
    'client': {
      'title': 'Client',
      'icon': Icons.person_outline,
      'color': const Color(0xFF2563EB),
      'description': 'Book events and services',
      'userType': UserType.client,
    },
    'cameraman': {
      'title': 'Cameraman',
      'icon': Icons.camera_alt_outlined,
      'color': const Color(0xFF7C3AED),
      'description': 'Provide photography services',
      'userType': UserType.photographer,
    },
    'venue': {
      'title': 'Venue Owner',
      'icon': Icons.location_on_outlined,
      'color': const Color(0xFF059669),
      'description': 'List and manage venues',
      'userType': UserType.venue, // Assuming venue owner is a service provider
    },
    'makeup_artist': {
      'title': 'Makeup Artist',
      'icon': Icons.brush_outlined,
      'color': const Color(0xFFDC2626),
      'description': 'Offer makeup services',
      'userType': UserType.makeupArtist,
    },
  };

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _trySignup() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        _showSnackBar(
          'Please agree to the Terms of Service and Privacy Policy',
          isError: true,
        );
        return;
      }

      _formKey.currentState!.save();
      
      // Use the AuthProvider instead of AuthService
      final authNotifier = ref.read(authProvider.notifier);
      
      try {
        await authNotifier.signup(
          name: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,  // Keep only this one
          userType: _userRoles[_selectedRole]!['userType'],  // Remove passwordConfirm parameter
        );

        // Check if signup was successful
        final authState = ref.read(authProvider);
        if (authState.error == null) {
          if (mounted) {
            String roleTitle = _userRoles[_selectedRole]!['title'];
            _showSnackBar(
              'Account created successfully! Welcome to Swornim as $roleTitle, ${_usernameController.text}!',
              isError: false,
            );

            // Navigate to login page after successful signup
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(onSignupClicked: () {})),
            );
          }
        }
      } catch (e) {
        // Error handling is managed by the AuthProvider
        // The error will be displayed via the Consumer widget
      }
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: isError ? const Color(0xFFDC2626) : const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(onSignupClicked: () {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch auth state for loading and error handling
    final authState = ref.watch(authProvider);
    
    // Show error if there's one
    if (authState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackBar(authState.error!, isError: true);
        // Clear the error after showing it
        ref.read(authProvider.notifier).clearError();
      });
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  
                  // Logo Section
                  const LogoSection(),
                  
                  const SizedBox(height: 32),

                  // Welcome text
                  Text(
                    'Create Account',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Sign up to get started with Swornim',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Role Selection
                  RoleSelection(
                    userRoles: _userRoles,
                    selectedRole: _selectedRole,
                    onRoleChanged: (role) => setState(() => _selectedRole = role),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Signup Form
                  SignupForm(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Terms and conditions checkbox
                  _buildTermsCheckbox(),
                  
                  const SizedBox(height: 32),
                  
                  // Signup button - use loading state from AuthProvider
                  CustomButton(
                    text: 'Create Account',
                    onPressed: authState.isLoading ? null : _trySignup,
                    isLoading: authState.isLoading,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Login redirect
                  _buildLoginRedirect(),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
          activeColor: const Color(0xFF2563EB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF6B7280),
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2563EB),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2563EB),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF6B7280),
          ),
        ),
        GestureDetector(
          onTap: _navigateToLogin,
          child: Text(
            'Sign in',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}