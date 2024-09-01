Map<String, dynamic> productDetails = {
  "id": 0,
  "title": "Women Shoulder Handbag",
  "rating": 4.7,
  "noOfRating": 5,
  "likeCount": 67,
  "deliveryDays": 7,
  "price": 37.39,
  "auctionEndDate": DateTime.now().add(
    const Duration(days: 1),
  ), // We only need this data for auction details if it is product details api should not contain this field
  "productImages": [
    {
      "id": 0,
      "imageUrl":
          "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "id": 1,
      "imageUrl":
          "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg",
    },
    {
      "id": 2,
      "imageUrl":
          "https://images.unsplash.com/photo-1471879832106-c7ab9e0cee23?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D",
    },
  ],
  "seller": {
    "id": 0,
    "name": "John Smith",
    "email": "abc@gmail.com",
    "isActive": true,
    "imageUrl":
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
    "rating": 4.7,
    "noOfReviews": 60,
  },
};
Map<String, dynamic> technicianDetail = {
  "id": 0,
  "title": "Technician",
  "rating": 4.7,
  "noOfRating": 5,
  "likeCount": 67,
  "deliveryDays": 7,
  "price": 37.39,
  "auctionEndDate": DateTime.now().add(
    const Duration(days: 1),
  ), // We only need this data for auction details if it is product details api should not contain this field
  "productImages": [
    {
      "id": 0,
      "imageUrl":
          "https://images.pexels.com/photos/17591304/pexels-photo-17591304/free-photo-of-narrow-alley-along-historic-townhouses.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      "id": 1,
      "imageUrl":
          "https://images.unsplash.com/photo-1621905251918-48416bd8575a?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "id": 2,
      "imageUrl":
          "https://images.unsplash.com/photo-1621905251918-48416bd8575a?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ],
  "seller": {
    "id": 0,
    "name": "John Smith",
    "email": "abc@gmail.com",
    "isActive": true,
    "imageUrl":
        "https://images.pexels.com/photos/1553783/pexels-photo-1553783.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "rating": 4.7,
    "noOfReviews": 60,
  },
};