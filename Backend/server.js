const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;

// CORS should be configured before other middleware
app.use(cors());

// Create a pool to connect to PostgreSQL
const pool = new Pool({
  user: 'postgres', // Replace with your PostgreSQL username
  host: 'localhost',
  database: 'test', // Your database name
  password: '1231', // Replace with your password
  port: 5432,
});



// Middleware to parse JSON request bodies
app.use(bodyParser.json());


// Read All Orders
app.get('/orders', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM orders');
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Update Order
app.put('/orders/:id', async (req, res) => {
  const orderId = parseInt(req.params.id);
  const { breakfast_status, lunch_status, dinner_status, comments, delivery_permission } = req.body;

  try {
    const query = `
      UPDATE orders
      SET 
          breakfast_status = $1, 
          lunch_status = $2, 
          dinner_status = $3, 
          comments = $4, 
          delivery_permission = $5
      WHERE id = $6
      RETURNING *;
    `;
    const values = [breakfast_status, lunch_status, dinner_status, comments, delivery_permission, orderId];

    const result = await pool.query(query, values);

    if (result.rows.length > 0) {
      res.status(200).json(result.rows[0]);
    } else {
      res.status(404).json({ error: 'Order not found' });
    }
  } catch (err) {
    console.error('Error during update operation:', err);
    res.status(500).json({ error: 'Internal Server Error', details: err.message });
  }
});

app.get('/orders/:roomNumber', async (req, res) => {
  const { roomNumber } = req.params;

  try {
    const query = 'SELECT * FROM orders WHERE room_number = $1';
    const result = await pool.query(query, [roomNumber]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'No orders found for this room number.' });
    }

    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Internal server error.' });
  }
});


// ----------------------

app.put('/orders/:orderId/update', async (req, res) => {
  const { orderId } = req.params;
  const { mealIndex, deliveredTime } = req.body; // Receive deliveredTime from frontend

  if (![1, 2, 3].includes(mealIndex)) {
    return res.status(400).json({ message: 'Invalid meal index. Valid values are 1 (Breakfast), 2 (Lunch), 3 (Dinner).' });
  }

  try {
    console.log('Updating order:', { orderId, mealIndex, deliveredTime });

    const updateQuery = `
      UPDATE orders
      SET 
        order_status[$1] = TRUE, 
        delivered_time[$1] = $2
      WHERE id = $3
      RETURNING *;
    `;

    const result = await pool.query(updateQuery, [mealIndex, deliveredTime, orderId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Order not found' });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error('Error updating meal order:', error.message);
    res.status(500).json({ message: `Failed to update meal order: ${error.message}` });
  }
});



// --------------

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
