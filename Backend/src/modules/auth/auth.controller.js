const authSvc = require("./auth.service");
const userSvc = require("../user/user.service");
const emailService = require("../../services/email.service");
const { deleteFile, safeUserData } = require("../../utilities/helpers");

class AuthController {
  async registerUser(req, res, next) {
    try {
      // Check if email already exists
      const existingUser = await userSvc.getSingleRowByFilter({
        email: req.body.email,
      });
      if (existingUser) {
        // Delete uploaded file if user already exists
        if (req.file) {
          deleteFile(req.file.path);
        }
        throw {
          code: 409,
          status: "EMAIL_ALREADY_EXISTS",
          message: "Email address is already registered",
        };
      }

      // Transform user data
      const userData = await authSvc.transformRegisterUser(req);

      // Create user
      const user = await userSvc.createUser(userData);

      // Send verification email
      await authSvc.sendVerificationEmail(user);

      // Auto-activate user after sending email (for testing purposes)
      await userSvc.updateSingleRowByFilter(
        {
          isEmailVerified: true,
          isActive: true,
          emailVerificationToken: null,
          emailVerificationTokenExpiry: null,
        },
        { id: user.id }
      );

      // Get updated user data
      const updatedUser = await userSvc.getSingleRowByFilter({ id: user.id });

      res.status(201).json({
        data: safeUserData(updatedUser),
        message:
          "User registered successfully and activated. You can now login.",
        status: "CREATED",
        options: null,
      });
    } catch (exception) {
      // Clean up uploaded file on error
      if (req.file) {
        deleteFile(req.file.path);
      }
      next(exception);
    }
  }

  async loginUser(req, res, next) {
    try {
      const { email, password } = req.body;

      // Get user by email
      const user = await userSvc.getSingleRowByFilter({ email });
      if (!user) {
        throw {
          code: 401,
          status: "INVALID_CREDENTIALS",
          message: "Invalid email or password",
        };
      }

      // Validate password
      const isValidPassword = await authSvc.validatePassword(
        password,
        user.password
      );
      if (!isValidPassword) {
        throw {
          code: 401,
          status: "INVALID_CREDENTIALS",
          message: "Invalid email or password",
        };
      }

      // Check if user is active (simplified check)
      if (!user.isActive) {
        throw {
          code: 403,
          status: "ACCOUNT_ACCESS_DENIED",
          message: "Your account has been deactivated. Please contact support.",
        };
      }

      // Generate tokens
      const tokens = await authSvc.generateTokens(user);

      // Create session
      const sessionTokens = await authSvc.createSession(user, tokens);

      // Update last login
      await userSvc.updateSingleRowByFilter(
        { lastLoginAt: new Date() },
        { id: user.id }
      );

      res.json({
        data: {
          user: safeUserData(user),
          tokens: sessionTokens,
        },
        message: "Login successful",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async refreshToken(req, res, next) {
    try {
      const { refreshToken } = req.body;

      const newTokens = await authSvc.refreshAccessToken(refreshToken);

      res.json({
        data: newTokens,
        message: "Token refreshed successfully",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async logoutUser(req, res, next) {
    try {
      const token = req.headers.authorization?.replace("Bearer ", "");

      if (token) {
        await authSvc.revokeSession(token);
      }

      res.json({
        data: null,
        message: "Logout successful",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async logoutAllSessions(req, res, next) {
    try {
      const userId = req.loggedInUser.id;

      await authSvc.revokeAllUserSessions(userId);

      res.json({
        data: null,
        message: "All sessions logged out successfully",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async forgotPassword(req, res, next) {
    try {
      const { email } = req.body;

      const user = await userSvc.getSingleRowByFilter({ email });
      if (!user) {
        // Don't reveal if email exists or not for security
        res.json({
          data: null,
          message:
            "If the email address exists in our system, you will receive a password reset link.",
          status: "OK",
          options: null,
        });
        return;
      }

      // Generate password reset token
      const resetToken = await authSvc.generatePasswordResetToken(user);

      // Send reset email
      await emailService.sendPasswordResetEmail(user, resetToken);

      res.json({
        data: null,
        message:
          "If the email address exists in our system, you will receive a password reset link.",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async resetPassword(req, res, next) {
    try {
      const { token, password } = req.body;

      const user = await userSvc.getSingleRowByFilter({
        resetToken: token,
        resetTokenExpiry: { [require("sequelize").Op.gt]: new Date() },
      });

      if (!user) {
        throw {
          code: 400,
          status: "INVALID_RESET_TOKEN",
          message: "Invalid or expired reset token",
        };
      }

      // Reset password
      const updateData = await authSvc.resetPassword(token, password);

      // Update user
      await userSvc.updateSingleRowByFilter(updateData, { id: user.id });

      // Revoke all sessions for security
      await authSvc.revokeAllUserSessions(user.id);

      res.json({
        data: null,
        message:
          "Password reset successfully. Please log in with your new password.",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async changePassword(req, res, next) {
    try {
      const { currentPassword, newPassword } = req.body;
      const userId = req.loggedInUser.id;

      const user = await userSvc.getSingleRowByFilter({ id: userId });
      if (!user) {
        throw {
          code: 404,
          status: "USER_NOT_FOUND",
          message: "User not found",
        };
      }

      // Validate current password
      const isValidPassword = await authSvc.validatePassword(
        currentPassword,
        user.password
      );
      if (!isValidPassword) {
        throw {
          code: 400,
          status: "INVALID_CURRENT_PASSWORD",
          message: "Current password is incorrect",
        };
      }

      // Update password
      const updateData = await authSvc.resetPassword(null, newPassword);
      await userSvc.updateSingleRowByFilter(updateData, { id: userId });

      // Revoke all other sessions for security
      await authSvc.revokeAllUserSessions(userId);

      res.json({
        data: null,
        message: "Password changed successfully. Please log in again.",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async verifyEmail(req, res, next) {
    try {
      const { token } = req.body;

      const user = await userSvc.getSingleRowByFilter({
        emailVerificationToken: token,
        emailVerificationTokenExpiry: {
          [require("sequelize").Op.gt]: new Date(),
        },
      });

      if (!user) {
        throw {
          code: 400,
          status: "INVALID_VERIFICATION_TOKEN",
          message: "Invalid or expired verification token",
        };
      }

      // Verify email
      const updateData = await authSvc.verifyEmail(token);
      const updatedUser = await userSvc.updateSingleRowByFilter(updateData, {
        id: user.id,
      });

      res.json({
        data: safeUserData(updatedUser),
        message: "Email verified successfully. Your account is now active.",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async resendVerificationEmail(req, res, next) {
    try {
      const { email } = req.body;

      const user = await userSvc.getSingleRowByFilter({ email });
      if (!user) {
        throw {
          code: 404,
          status: "USER_NOT_FOUND",
          message: "User not found",
        };
      }

      if (user.isEmailVerified) {
        throw {
          code: 400,
          status: "EMAIL_ALREADY_VERIFIED",
          message: "Email is already verified",
        };
      }

      // Send verification email
      await authSvc.sendVerificationEmail(user);

      // Auto-activate user after resending email (for testing purposes)
      await userSvc.updateSingleRowByFilter(
        {
          isEmailVerified: true,
          isActive: true,
          emailVerificationToken: null,
          emailVerificationTokenExpiry: null,
        },
        { id: user.id }
      );

      res.json({
        data: null,
        message: "Verification email sent and account activated successfully",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }

  async getProfile(req, res, next) {
    try {
      const user = req.loggedInUser;

      res.json({
        data: safeUserData(user),
        message: "Profile fetched successfully",
        status: "OK",
        options: null,
      });
    } catch (exception) {
      next(exception);
    }
  }
}

const authCtrl = new AuthController();
module.exports = authCtrl;
