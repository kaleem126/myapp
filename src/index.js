// src/index.js
const express = require('express');
const app = express();

// A health check route for Kubernetes or Docker
app.get('/health', (req, res) => res.send('ok'));

// A main route
app.get('/', (req, res) => res.send('Hello from myapp!'));

// Run on port 3000 or use environment variable PORT
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

