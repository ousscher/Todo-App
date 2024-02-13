const jwt = require("jsonwebtoken");

const verify = function (req, res, next) {
  const authorizationHeader = req.headers['authorization'];

  if (authorizationHeader) {
    const [bearer, token] = authorizationHeader.split(' ');

    if (!token) {
      return res.status(401).json({ "error": "Missing token" });
    }

    try {
      // Use jwt.verify() for token verification
      const decoded = jwt.verify(token, process.env.SECRET_KEY);

      // You can access the decoded information if verification is successful
      console.log("Decoded Token:", decoded);

      // Call next() to proceed to the next middleware or route handler
      next();
    } catch (e) {
      // Handle the case where the token is invalid or expired
      return res.status(401).json({ "error": "Invalid token" });
    }
  } else {
    return res.status(401).json({ "error": "Missing token" });
  }
};

module.exports = verify;
