const { Sequelize } = require("sequelize");
const { DatabaseConfig } = require("./config");

// Create sequelize instance
const sequelize = new Sequelize(DatabaseConfig);

// Connection function
const connectDB = async () => {
  try {
    // Test the connection
    await sequelize.authenticate();

    // Sync all models (creates tables if they don't exist)
    await sequelize.sync({ alter: true }); // Use { force: true } to drop and recreate tables

    console.log("PostgreSQL server connected successfully.");
  } catch (exception) {
    console.log("********Error establishing DB connection ********");
    console.log(exception);
    process.exit(1);
  }
};

// Auto-connect when this file is required
connectDB();

// Export sequelize instance for use in other files
module.exports = sequelize;
