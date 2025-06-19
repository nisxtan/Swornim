const MakeupArtist = require("./makeupartist.model");
const User = require("../user/user.model");
const { UserStatus } = require("../../config/constants");
const { Op } = require("sequelize");
const cloudinarySvc = require("../../services/cloudinary.service");

class MakeupArtistService {
  async createMakeupArtist(data) {
    try {
      if (data.profileImage && data.profileImage.path) {
        const uploadResult = await cloudinarySvc.fileUpload(data.profileImage.path, "makeupartists/profiles/");
        data.profileImage = uploadResult.url;
        data.profileImagePublicId = uploadResult.publicId;
      }
      const makeupArtist = await MakeupArtist.create(data);
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async getSingleRowByFilter(filter) {
    try {
      const makeupArtist = await MakeupArtist.findOne({
        where: filter,
        include: [
          {
            model: User,
            as: "user",
            attributes: ["id", "name", "email", "phone", "profileImage", "userType"],
          },
        ],
      });
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async getAllRowsByFilter(filter = {}, options = {}) {
    try {
      const {
        page = 1,
        limit = 10,
        sortBy = "createdAt",
        sortOrder = "DESC",
        search = "",
        specializations = [],
        minRating = 0,
        maxPrice = null,
        minPrice = null,
        location = "",
        isAvailable = null,
      } = options;

      const offset = (page - 1) * limit;
      const whereClause = { ...filter };

      if (search) {
        whereClause[Op.or] = [
          { businessName: { [Op.iLike]: `%${search}%` } },
          { description: { [Op.iLike]: `%${search}%` } },
        ];
      }

      if (specializations.length > 0) {
        whereClause.specializations = {
          [Op.overlap]: specializations,
        };
      }

      if (minRating > 0) {
        whereClause.rating = {
          [Op.gte]: minRating,
        };
      }

      if (minPrice !== null || maxPrice !== null) {
        whereClause.hourlyRate = {};
        if (minPrice !== null) {
          whereClause.hourlyRate[Op.gte] = minPrice;
        }
        if (maxPrice !== null) {
          whereClause.hourlyRate[Op.lte] = maxPrice;
        }
      }

      if (location) {
        whereClause.location = {
          [Op.contains]: { city: location },
        };
      }

      if (isAvailable !== null) {
        whereClause.isAvailable = isAvailable;
      }

      const { count, rows } = await MakeupArtist.findAndCountAll({
        where: whereClause,
        include: [
          {
            model: User,
            as: "user",
            attributes: ["id", "name", "email", "phone", "profileImage", "userType"],
          },
        ],
        order: [[sortBy, sortOrder]],
        limit: parseInt(limit),
        offset: parseInt(offset),
      });

      return {
        makeupArtists: rows,
        totalCount: count,
        currentPage: parseInt(page),
        totalPages: Math.ceil(count / limit),
        hasNextPage: page * limit < count,
        hasPrevPage: page > 1,
      };
    } catch (exception) {
      throw exception;
    }
  }

  async updateSingleRowByFilter(updateData, filter) {
    try {
      const [updatedCount] = await MakeupArtist.update(updateData, {
        where: filter,
      });
      return updatedCount;
    } catch (exception) {
      throw exception;
    }
  }

  async deleteSingleRowByFilter(filter) {
    try {
      const deletedCount = await MakeupArtist.destroy({
        where: filter,
      });
      return deletedCount;
    } catch (exception) {
      throw exception;
    }
  }

  async getMakeupArtistWithUser(makeupArtistId) {
    try {
      const makeupArtist = await MakeupArtist.findOne({
        where: { id: makeupArtistId },
        include: [
          {
            model: User,
            as: "user",
            attributes: ["id", "name", "email", "phone", "profileImage", "userType"],
          },
        ],
      });
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async updateMakeupArtistProfile(makeupArtistId, updateData) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }

      if (updateData.profileImage && updateData.profileImage.path) {
        if (makeupArtist.profileImagePublicId) {
          await cloudinarySvc.deleteFile(makeupArtist.profileImagePublicId);
        }
        const uploadResult = await cloudinarySvc.fileUpload(updateData.profileImage.path, "makeupartists/profiles/");
        updateData.profileImage = uploadResult.url;
        updateData.profileImagePublicId = uploadResult.publicId;
      }

      await makeupArtist.update(updateData);
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async updateAvailability(makeupArtistId, isAvailable) {
    try {
      const result = await this.updateSingleRowByFilter(
        { isAvailable },
        { id: makeupArtistId }
      );
      return result > 0;
    } catch (exception) {
      throw exception;
    }
  }

  async updateHourlyRate(makeupArtistId, hourlyRate) {
    try {
      const result = await this.updateSingleRowByFilter(
        { hourlyRate },
        { id: makeupArtistId }
      );
      return result > 0;
    } catch (exception) {
      throw exception;
    }
  }

  async addSpecialization(makeupArtistId, specialization) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }
      makeupArtist.addSpecialization(specialization);
      await makeupArtist.save();
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async removeSpecialization(makeupArtistId, specialization) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }
      makeupArtist.removeSpecialization(specialization);
      await makeupArtist.save();
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async addPortfolioImage(makeupArtistId, imageUrl) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }
      makeupArtist.addPortfolioImage(imageUrl);
      await makeupArtist.save();
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async removePortfolioImage(makeupArtistId, imageUrl) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }
      makeupArtist.removePortfolioImage(imageUrl);
      await makeupArtist.save();
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async updateRating(makeupArtistId, newRating, totalReviews) {
    try {
      const makeupArtist = await this.getSingleRowByFilter({ id: makeupArtistId });
      if (!makeupArtist) {
        throw {
          code: 404,
          status: "MAKEUPARTIST_NOT_FOUND",
          message: "Makeup artist not found",
        };
      }
      makeupArtist.updateRating(newRating, totalReviews);
      await makeupArtist.save();
      return makeupArtist;
    } catch (exception) {
      throw exception;
    }
  }

  async getTopRatedMakeupArtists(limit = 10) {
    try {
      const makeupArtists = await MakeupArtist.findAll({
        where: { userStatus: UserStatus.ACTIVE },
        order: [["rating", "DESC"]],
        limit,
      });
      return makeupArtists;
    } catch (exception) {
      throw exception;
    }
  }

  async getAvailableMakeupArtists() {
    try {
      const makeupArtists = await MakeupArtist.findAll({
        where: { isAvailable: true, userStatus: UserStatus.ACTIVE },
      });
      return makeupArtists;
    } catch (exception) {
      throw exception;
    }
  }
}

module.exports = new MakeupArtistService(); 