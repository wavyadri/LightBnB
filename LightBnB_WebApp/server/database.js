const properties = require('./json/properties.json');
const users = require('./json/users.json');

// connect to psql
const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'lightbnb',
});

/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function (email) {
  return pool
    .query(`SELECT * FROM users WHERE email = $1`, [email])
    .then((result) => {
      if (result.rows.length) {
        return result.rows[0];
      }
      return null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function (id) {
  return pool
    .query(`SELECT * FROM users WHERE id = $1`, [id])
    .then((result) => {
      if (result.rows.length) {
        return result.rows[0];
      }
      return null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};
exports.getUserWithId = getUserWithId;

/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser = function (user) {
  const { name, password, email } = user;
  return pool
    .query(
      `INSERT INTO users (email, name, password) VALUES ($1, $2, $3) RETURNING *`,
      [email, name, password]
    )
    .then((result) => {
      if (result.rows.length) {
        return result.rows[0];
      }
      return null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function (guest_id, limit = 10) {
  return pool
    .query(
      `SELECT * FROM properties
        JOIN reservations ON properties.id = property_id
        WHERE guest_id = $1
        LIMIT $2
      `,
      [guest_id, limit]
    )
    .then((result) => {
      if (result.rows.length) {
        return result.rows;
      }
      return null;
    })
    .catch((err) => {
      console.log(err.message);
    });
};
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */

// const getAllProperties = (options, limit = 10) => {
//   return pool
//     .query(`SELECT * FROM properties LIMIT $1`, [limit])
//     .then((result) => {
//       return result.rows;
//     })
//     .catch((err) => {
//       console.log(err.message);
//     });
// };

const getAllProperties = function (options, limit = 10) {
  const queryParams = [];
  // JOIN
  let queryString = `
  SELECT properties.*, avg(property_reviews.rating) as average_rating
  FROM properties
  JOIN property_reviews ON properties.id = property_id
  `;

  // WHERE, AND
  if (options.city) {
    const optionsCity = options.city.slice(1);
    queryParams.push(`%${optionsCity}`);
    queryString += `${queryParams.length === 1 ? 'WHERE' : 'AND'} 
    city LIKE $${queryParams.length}`;
  }

  if (options.owner_id) {
    queryParams.push(options.owner_id);
    queryString += `${queryParams.length === 1 ? 'WHERE' : 'AND'} 
    owner_id = $${queryParams.length}`;
  }

  if (options.minimum_price_per_night) {
    queryParams.push(options.minimum_price_per_night * 100);
    queryString += `${queryParams.length === 1 ? 'WHERE' : 'AND'} 
    cost_per_night > $${queryParams.length}`;
  }

  if (options.maximum_price_per_night) {
    queryParams.push(options.maximum_price_per_night * 100);
    queryString += `${queryParams.length === 1 ? 'WHERE' : 'AND'} 
    cost_per_night < $${queryParams.length}`;
  }

  // GROUP
  queryString += `GROUP BY properties.id`;

  // HAVING
  if (options.minimum_rating) {
    queryParams.push(options.minimum_rating);
    queryString += `HAVING AVG(property_reviews.rating) >= $${queryParams.length}`;
  }

  // ORDER, LIMIT
  queryParams.push(limit);
  queryString += `
  ORDER BY cost_per_night
  LIMIT $${queryParams.length};
  `;

  console.log(queryString, queryParams);

  return pool.query(queryString, queryParams).then((res) => res.rows);
};
exports.getAllProperties = getAllProperties;

/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function (property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};
exports.addProperty = addProperty;
