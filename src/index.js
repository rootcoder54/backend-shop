require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

app.use(cors({
  origin: '*', // Frontend URL
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));


app.use(express.json());

const authRoutes = require('./routes/auth');
const shopRoutes = require('./routes/shop');


app.use('/auth', authRoutes);
app.use('/shops', shopRoutes);

app.listen(3000, () => console.log('Serveur en ligne sur http://localhost:3000'));
