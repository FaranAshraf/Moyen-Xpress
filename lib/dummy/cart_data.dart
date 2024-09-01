List<Map<String, dynamic>> cartData = [
  {
    "id": 0,
    "shopName": "Mike-Kilo",
    "items": [
      {
        "id": 0,
        "qty": 5,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 20.0,
        "discount": 0.5,
        "tax": 0.0,
      },
      {
        "id": 1,
        "qty": 4,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 21.0,
        "discount": 1.0,
        "tax": 2.0,
      },
      {
        "id": 2,
        "qty": 1,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 8.0,
        "discount": 1.5,
        "tax": 2.9,
      },
    ],
    "deliveryType": [
      {
        "id": 0, // use 0 for Express Delivery
        "estimatedDeliveryDays": 10,
        "deliveryCharges": 5.0,
      },
      {
        "id": 1, // use 1 for Ship With Moyen
        "estimatedDeliveryDays": 7,
        "deliveryCharges": 5.0,
      },
    ],
  },
  {
    "id": 1,
    "shopName": "Mike-Kilo-2",
    "items": [
      {
        "id": 0,
        "qty": 4,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 20.0,
        "discount": 0.5,
        "tax": 0.0,
      },
      {
        "id": 1,
        "qty": 8,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 21.0,
        "discount": 0.0,
        "tax": 2.0,
      },
      {
        "id": 2,
        "qty": 2,
        "imageUrl":
            "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "title": "Demo Product",
        "price": 8.0,
        "discount": 1.5,
        "tax": 2.9,
      },
    ],
    "deliveryType":
        null, // send null if this product can only be ordered as quote a job
  },
];
