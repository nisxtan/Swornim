import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback? onLoginClicked;

  const SignupPage({super.key, this.onLoginClicked});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  // Add animation controllers and animations
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _logoRotation;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String _selectedRole = 'client'; // Add role selection
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _agreeToTerms = false;

  // Define user roles
  final Map<String, Map<String, dynamic>> _userRoles = {
    'client': {
      'title': 'Client',
      'icon': Icons.person_outline,
      'color': const Color(0xFF2563EB),
      'description': 'Book events and services'
    },
    'cameraman': {
      'title': 'Cameraman',
      'icon': Icons.camera_alt_outlined,
      'color': const Color(0xFF7C3AED),
      'description': 'Provide photography services'
    },
    'venue': {
      'title': 'Venue Owner',
      'icon': Icons.location_on_outlined,
      'color': const Color(0xFF059669),
      'description': 'List and manage venues'
    },
    'makeup_artist': {
      'title': 'Makeup Artist',
      'icon': Icons.brush_outlined,
      'color': const Color(0xFFDC2626),
      'description': 'Offer makeup services'
    },
  };

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Initialize animations
    _logoAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOutBack,
    ));

    _logoRotation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOutBack,
    ));

    // Start the animation
    _logoAnimationController.forward();

    // Focus management
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_usernameFocus);
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _trySignup() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please agree to the Terms of Service and Privacy Policy',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        return;
      }

      _formKey.currentState!.save();
      
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 2000));

      if (mounted) {
        String roleTitle = _userRoles[_selectedRole]!['title'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created successfully! Welcome to Swornim as $roleTitle, $username!',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0xFF059669),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        // Navigate to login page after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage(onSignupClicked: () {})),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(onSignupClicked: () {})),
    );
  }

  // Add logo section builder
  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoAnimation, _logoRotation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: Transform.rotate(
            angle: _logoRotation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E40AF),
                    const Color(0xFF3B82F6),
                    const Color(0xFF60A5FA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.25),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF1E40AF).withOpacity(0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/LogoSwornim.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SWORNIM',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'YOUR EVENT ALLY',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.85),
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

 // Replace your existing _buildRoleSelection() method with this improved version

Widget _buildRoleSelection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'I am a...',
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF374151),
        ),
      ),
      const SizedBox(height: 16),
      
      // Use Column with Wrap for better responsive layout
      Column(
        children: [
          // First row - 2 items
          Row(
            children: [
              Expanded(child: _buildRoleCard('client')),
              const SizedBox(width: 12),
              Expanded(child: _buildRoleCard('cameraman')),
            ],
          ),
          const SizedBox(height: 12),
          // Second row - 2 items  
          Row(
            children: [
              Expanded(child: _buildRoleCard('venue')),
              const SizedBox(width: 12),
              Expanded(child: _buildRoleCard('makeup_artist')),
            ],
          ),
        ],
      ),
      
      const SizedBox(height: 16),
      
      // Description container
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _userRoles[_selectedRole]!['color'].withOpacity(0.08),
              _userRoles[_selectedRole]!['color'].withOpacity(0.03),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _userRoles[_selectedRole]!['color'].withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _userRoles[_selectedRole]!['color'].withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: _userRoles[_selectedRole]!['color'],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _userRoles[_selectedRole]!['description'],
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _userRoles[_selectedRole]!['color'].withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// Add this new helper method for individual role cards
Widget _buildRoleCard(String roleKey) {
  Map<String, dynamic> role = _userRoles[roleKey]!;
  bool isSelected = _selectedRole == roleKey;
  
  return GestureDetector(
    onTap: () => setState(() => _selectedRole = roleKey),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 70, // Reduced height
      decoration: BoxDecoration(
        gradient: isSelected 
          ? LinearGradient(
              colors: [
                role['color'].withOpacity(0.12),
                role['color'].withOpacity(0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.circular(12), // Reduced radius
        border: Border.all(
          color: isSelected ? role['color'] : const Color(0xFFE5E7EB),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: isSelected ? [
          BoxShadow(
            color: role['color'].withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8), // Reduced padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Important: prevent overflow
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(6), // Reduced padding
              decoration: BoxDecoration(
                color: isSelected 
                  ? role['color'].withOpacity(0.15)
                  : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                role['icon'],
                color: isSelected ? role['color'] : const Color(0xFF6B7280),
                size: 18, // Reduced icon size
              ),
            ),
            
            const SizedBox(height: 4), // Reduced spacing
            
            // Title text with better constraints
            Flexible(
              child: Text(
                role['title'],
                style: GoogleFonts.inter(
                  fontSize: 10, // Reduced font size
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? role['color'] : const Color(0xFF6B7280),
                  height: 1.1, // Tighter line height
                ),
                textAlign: TextAlign.center,
                maxLines: 1, // Single line only
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // Update the build method to include the role selection
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Reduce vertical padding
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16), // Reduce from 20
                  
                  // Logo/Brand section
                  _buildLogoSection(),
                  
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
                  _buildRoleSelection(),
                  
                  const SizedBox(height: 24),
                  
                  // Username field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _usernameController,
                        focusNode: _usernameFocus,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Choose a username',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF6B7280),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF2563EB),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Username is required';
                          }
                          if (val.trim().length < 3) {
                            return 'Username must be at least 3 characters';
                          }
                          if (val.trim().length > 20) {
                            return 'Username must be less than 20 characters';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(val)) {
                            return 'Username can only contain letters, numbers, and underscores';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_emailFocus),
                        onSaved: (val) => username = val!.trim(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Email field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF6B7280),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF2563EB),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFocus),
                        onSaved: (val) => email = val!.trim(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Password field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Create a strong password',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF6B7280),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF6B7280),
                            ),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF2563EB),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Password is required';
                          }
                          if (val.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(val)) {
                            return 'Password must contain uppercase, lowercase, and numbers';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_confirmPasswordFocus),
                        onSaved: (val) => password = val!,
                        onChanged: (val) => password = val,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Confirm Password field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        obscureText: _obscureConfirmPassword,
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF6B7280),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF6B7280),
                            ),
                            onPressed: () => setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            }),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E7EB),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF2563EB),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFDC2626),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (val != password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _trySignup(),
                        onSaved: (val) => confirmPassword = val!,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Terms and conditions checkbox
                  Row(
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
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Signup button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: _isLoading ? null : _trySignup,
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            'Create Account',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  
                  const SizedBox(height: 20), // Reduce from 24
                  
                  // Login redirect
                  Row(
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
                  ),
                  
                  const SizedBox(height: 24), // Reduce from 32
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}