const jwt = require('jsonwebtoken');
const SECRET = process.env.JWT_SECRET || 'secret_key';

module.exports = function (req, res, next) {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'Token requis' });

  const token = authHeader.split(' ')[1];
  try {
    const payload = jwt.verify(token, SECRET);
    req.user = payload;
    next();
  } catch {
    res.status(401).json({ error: 'Token invalide' });
  }
};
