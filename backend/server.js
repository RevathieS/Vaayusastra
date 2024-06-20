const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/login_demo', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected...'))
  .catch(err => console.log(err));

// User Schema
const UserSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  dob: String,
  phone: String,
  password: String
});

const User = mongoose.model('User', UserSchema);

// Routes
app.post('/register', async (req, res) => {
  console.log('Received register request:', req.body);
  const { name, email, dob, phone, password } = req.body;

  try {
    const user = new User({ name, email, dob, phone, password });
    await user.save();
    res.status(200).send('User registered');
  } catch (error) {
    res.status(400).send('Error registering user: ' + error.message);
  }
});

app.post('/login', async (req, res) => {
  console.log('Received login request:', req.body);
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email, password });

    if (user) {
      res.status(200).send('Login successful');
    } else {
      res.status(400).send('Invalid email or password');
    }
  } catch (error) {
    res.status(400).send('Error logging in: ' + error.message);
  }
});

app.listen(port, () => {
  console.log('Server running on port ${port}');
});
