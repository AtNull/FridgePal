const express = require('express');
const app = express();
const port = 3000;

const mockData = [
  { id: '1', name: 'Lime', imageUrl: 'https://provisioning.scrubisland.com/cdn/shop/products/Limes_600x.png?v=1571841822', purchaseDate: '2025-09-22T08:30:00Z', expiryDate: '2025-10-03T08:30:00Z', quantity: 5 },
  { id: '2', name: 'Egg', imageUrl: 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/eggs-in-carton-cabral-stock.jpg', purchaseDate: '2025-09-24T09:15:00Z', expiryDate: '2025-10-29T09:15:00Z', quantity: 12 },
  { id: '3', name: 'Tomato', imageUrl: 'https://www.tasteofhome.com/wp-content/uploads/2018/05/GettyImages-1043681048.jpg?fit=700%2C700', purchaseDate: '2025-09-27T10:00:00Z', expiryDate: '2025-10-04T10:00:00Z', quantity: 3 },
  { id: '4', name: 'Banana', imageUrl: 'https://images.immediate.co.uk/production/volatile/sites/30/2025/03/Bunch-of-bananas-00871a2.jpg?quality=90&webp=true&resize=400,400', purchaseDate: '2025-09-30T11:30:00Z', expiryDate: '2025-10-06T11:30:00Z', quantity: 5 },
  { id: '5', name: 'Peanut butter', imageUrl: 'https://www.peanutbutter.com/wp-content/uploads/Web_800_Natural-Creamy-Peanut-Butter_15.png', purchaseDate: '2025-10-01T14:10:00Z', expiryDate: '2026-03-31T14:10:00Z', quantity: 3 },
  { id: '6', name: 'Yogurt', imageUrl: 'https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/512/512/true/eyJpZCI6IjQxNzkzZWEwNmJhZjhjMTk3ZTFkMzZjMmE4MTgxMzg1Iiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=d1548eac3945d30cd22c66890ff288184b3b2de0c41ffe84873ca41ea4e63cd1', purchaseDate: '2025-10-02T08:45:00Z', expiryDate: '2025-10-23T08:45:00Z', quantity: 8 },
  { id: '7', name: 'Milk', imageUrl: 'https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Glass-and-bottle-of-milk-fe0997a.jpg', purchaseDate: '2025-10-03T09:30:00Z', expiryDate: '2025-10-13T09:30:00Z', quantity: 6 },
  { id: '8', name: 'Carrot', imageUrl: 'https://klcode-images.imgix.net/KZ8Y9foNQ1iSpQZum77Z_iStock-479805740.jpg', purchaseDate: '2025-10-04T10:00:00Z', expiryDate: '2025-11-01T10:00:00Z', quantity: 4 },
  { id: '9', name: 'Ham', imageUrl: 'https://images.heb.com/is/image/HEBGrocery/008448514-4', purchaseDate: '2025-10-05T11:20:00Z', expiryDate: '2025-10-10T11:20:00Z', quantity: 2 },
  { id: '10', name: 'Strawberry Jam', imageUrl: 'https://thebakersalmanac.com/wp-content/uploads/2020/04/Homemade-strawberry-jam-recipe-image-new.jpg', purchaseDate: '2025-10-06T12:00:00Z', expiryDate: '2026-03-10T12:00:00Z', quantity: 3 },
  { id: '11', name: 'Pesto', imageUrl: 'https://online.idea.rs/images/products/154/154031143_1l.jpg?1689174933', purchaseDate: '2025-10-07T13:00:00Z', expiryDate: '2025-10-13T13:00:00Z', quantity: 1 },
  { id: '12', name: 'Butter', imageUrl: 'https://assets.usfoods.com/Product/Image/3824517/3d637e9a0f45abf9430baec462162a3a.jpg', purchaseDate: '2025-10-08T14:00:00Z', expiryDate: '2025-10-29T14:00:00Z', quantity: 4 },
  { id: '13', name: 'Gouda', imageUrl: 'https://oldamsterdam.com/wp-content/uploads/2023/08/Baby_Gouda_Natural_2.png', purchaseDate: '2025-10-10T15:00:00Z', expiryDate: '2025-10-31T15:00:00Z', quantity: 3 },
  { id: '14', name: 'Avocado', imageUrl: 'https://cdn.britannica.com/72/170772-050-D52BF8C2/Avocado-fruits.jpg', purchaseDate: '2025-10-12T16:00:00Z', expiryDate: '2025-10-17T16:00:00Z', quantity: 6 },
  { id: '15', name: 'Ketchup', imageUrl: 'https://res.cloudinary.com/kraft-heinz-whats-cooking-ca/image/upload/f_auto/q_auto/c_limit,w_3840/f_auto/q_auto/v1/dxp-images/heinz/products/00013000011105-tomato-ketchup-with-no-sugar-added/marketing-view-color-front_c4cd3b9648e820b16a4e89870eb32717ba47c2ba_f7008a0360d04890cff19f81f8dbffa4?_a=BAVAfVDW0', purchaseDate: '2025-10-15T17:00:00Z', expiryDate: '2026-04-06T17:00:00Z', quantity: 2 }
];

app.get('/api/items', (_, res) => {
  res.json(mockData);
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Listening at http://0.0.0.0:${port}`);
});