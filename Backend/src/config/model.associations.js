const User = require("../modules/user/user.model");
const Photographer = require("../modules/photographer/photographer.model");
const MakeupArtist = require("../modules/makeupartist/makeupartist.model");

// User - Photographer
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

//User - MakeupArtist
User.hasOne(MakeupArtist, {
  foreignKey: "userId",
  as: "makeupArtist",
  onDelete: "CASCADE",
  onUpdate: "CASCADE",
});

MakeupArtist.belongsTo(User, {
  foreignKey: "userId",
  as: "user",
  onDelete: "CASCADE",
  onUpdate: "CASCADE",
});

module.exports = {
  User,
  Photographer,
  MakeupArtist,
};
