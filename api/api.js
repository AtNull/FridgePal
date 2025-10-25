const express = require('express');
const app = express();
const port = 3000;

app.listen(port, '0.0.0.0', () => {
  console.log(`Listening at http://0.0.0.0:${port}`);
});