const express = require('express');
const app = express();
const port = 3000;

const mockData = [
  {
    id:'1',
    name: 'Lime',
    purchaseDate: '2025-10-01T09:00:00Z',
    expiryDate: '2025-11-14T09:00:00Z',
    quantity: 2
  },
];

app.get('/api/items', (_, res) => {
  res.json(mockData);
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Listening at http://0.0.0.0:${port}`);
});