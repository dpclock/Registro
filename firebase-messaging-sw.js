// [START initialize_firebase_in_sw]
importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyAIndvoCzeUSNIC8F2VuA4QbyIWn3SdLy4",
  authDomain: "registro-app-369cf.firebaseapp.com",
  projectId: "registro-app-369cf",
  storageBucket: "registro-app-369cf.firebasestorage.app",
  messagingSenderId: "145687174734",
  appId: "1:145687174734:web:464da8cb3fd2f8f542ad1f",
  measurementId: "G-D4M121T49B"
});

const messaging = firebase.messaging();
// [END initialize_firebase_in_sw] 