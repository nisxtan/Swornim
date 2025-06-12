const nodemailer = require("nodemailer");
const { EmailConfig, AppConfig } = require("../config/config");
const fs = require("fs");
const path = require("path");

class EmailService {
  constructor() {
    this.transporter = nodemailer.createTransport({
      host: EmailConfig.host,
      port: EmailConfig.port,
      secure: EmailConfig.secure,
      auth: EmailConfig.auth,
    });
  }

  async sendEmail(to, subject, htmlContent, textContent = null) {
    try {
      const mailOptions = {
        from: `${EmailConfig.from.name} <${EmailConfig.from.email}>`,
        to,
        subject,
        html: htmlContent,
        text: textContent || htmlContent.replace(/<[^>]*>/g, ""),
      };

      const result = await this.transporter.sendMail(mailOptions);
      console.log("Email sent successfully:", result.messageId);
      return result;
    } catch (error) {
      console.error("Failed to send email:", error);
      throw error;
    }
  }

  async sendVerificationEmail(user, token) {
    const verificationUrl = `${AppConfig.frontendUrl}/verify-email/${token}`;

    const htmlTemplate = this.getEmailTemplate("email_verification.html");
    const htmlContent = htmlTemplate
      .replace("{{USER_NAME}}", user.name)
      .replace("{{VERIFICATION_URL}}", verificationUrl);

    const subject = "Verify Your Email Address";

    await this.sendEmail(user.email, subject, htmlContent);
  }

  async sendPasswordResetEmail(user, token) {
    const resetUrl = `${AppConfig.frontendUrl}/reset-password/${token}`;

    const htmlTemplate = this.getEmailTemplate("password_reset.html");
    const htmlContent = htmlTemplate
      .replace("{{USER_NAME}}", user.name)
      .replace("{{RESET_URL}}", resetUrl);

    const subject = "Reset Your Password";

    await this.sendEmail(user.email, subject, htmlContent);
  }

  getEmailTemplate(templateName) {
    try {
      const templatePath = path.join(
        __dirname,
        "../templates/emails",
        templateName
      );
      return fs.readFileSync(templatePath, "utf8");
    } catch (error) {
      console.error("Failed to load email template:", error);
      // Return a basic template as fallback
      if (templateName.includes("verification")) {
        return `
          <html>
            <body>
              <h2>Welcome {{USER_NAME}}!</h2>
              <p>Please click the link below to verify your email address:</p>
              <a href="{{VERIFICATION_URL}}">Verify Email</a>
            </body>
          </html>
        `;
      } else {
        return `
          <html>
            <body>
              <h2>Password Reset</h2>
              <p>Hi {{USER_NAME}},</p>
              <p>Click the link below to reset your password:</p>
              <a href="{{RESET_URL}}">Reset Password</a>
            </body>
          </html>
        `;
      }
    }
  }
}

const emailService = new EmailService();
module.exports = emailService;
