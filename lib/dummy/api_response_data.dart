Map<String, dynamic> apiResponse = {
  "isSuccess": true,
  "failReason": "",
  "failReasonContent": "",
  "successContents": {}, // data will go here it can be a list or Map
};

Map<String, dynamic> login = {"login": 'abc@gmail.com', 'password': "abc123"};

Map<String, dynamic> user = {
  "userID": 0,
  "emailAddress": "abc@gmail.com",
  "name": "Murtuza khan",
  "address": "user complete address",
  "city": "karachi",
  "zipCode": 75500,
  "stateCode": "Sindh",
  "photo":
      "https://images.unsplash.com/photo-1541963463532-d68292c34b19?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
  "token": "A12aw8q63ewg9xc9rt4g2se",
  "preferredLanguage": "en",
};


Map<String, dynamic> signUp = {
  "name": "Murtuza Khan",
  "email": "abc@gmail.com",
  "password": "abc123",
  "confirmPassword": "abc123",
};


Map<String, dynamic> verifyOtp = {
  "otp": 123456,
};