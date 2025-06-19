const User = require("../modules/user/user.model");
const Photographer = require("../modules/photographer/photographer.model");

// User - Photographer association (One-to-One)
User.hasOne(Photographer, {
  foreignKey: "userId",
  as: "photographer",
  onDelete: "CASCADE",
  onUpdate: "CASCADE",
});

Photographer.belongsTo(User, {
  foreignKey: "userId",
  as: "user",
  onDelete: "CASCADE",
  onUpdate: "CASCADE",
});

module.exports = {
  User,
  Photographer,
}; 