# Om Medical Store — Full Stack App (Website + PWA + Backend)

This repository contains a **complete React + Node.js app** for **Om Medical Store**, which allows customers to scan a QR/barcode, open/install the app, upload a prescription image, and place orders directly. The store owner can view, confirm, and manage these orders with payment integration support.

---

## 🏗️ Folder Structure
```
OmMedicalStore/
│
├── client/                 # React Frontend (PWA)
│   ├── src/
│   │   ├── App.jsx
│   │   ├── api.js
│   │   ├── styles.css
│   │   └── index.jsx
│   ├── public/
│   │   ├── index.html
│   │   ├── manifest.json
│   │   └── icons/
│   └── package.json
│
├── server/                 # Node.js + Express Backend
│   ├── index.js
│   ├── orders.json
│   └── package.json
│
└── README.md
```

---

## 🚀 Setup Instructions

### 1️⃣ Clone Repository
```bash
git clone https://github.com/YOUR_GITHUB_USERNAME/ommedical-store.git
cd ommedical-store
```

### 2️⃣ Install Dependencies
Frontend:
```bash
cd client
npm install
```
Backend:
```bash
cd ../server
npm install
```

### 3️⃣ Environment Setup
Create a `.env` file inside `/server` with the following keys:
```bash
PORT=4000
ADMIN_TOKEN=om_admin_token
TEST_PAYMENT_LINK=https://rzp.io/l/demo-link
```

### 4️⃣ Start the App
Run backend:
```bash
cd server
node index.js
```
Run frontend:
```bash
cd ../client
npm start
```

Then open: [http://localhost:3000](http://localhost:3000)

---

## 🌐 Features
✅ Upload prescription (image upload via Multer)  
✅ Auto-order creation and saving (JSON persistence)  
✅ Razorpay/Stripe payment integration placeholder  
✅ Working contact buttons (Call & WhatsApp)  
✅ PWA (installable app)  
✅ Admin panel protected by token  
✅ Fully mobile responsive and QR-scan friendly

---

## 🧠 How It Works

1. Customer opens the website (or scans the QR).  
2. Uploads prescription photo + enters name, phone, address.  
3. Clicks **Order Now** — backend saves the order, returns a payment link.  
4. Customer pays → store owner gets notified → delivery initiated.

---

## 🧾 Contact Details
**Om Medical Store**  
Nagla Kachchiyan, Mustfa Quarter, Agra Cantt, Agra (U.P)  
📞 Call/WhatsApp: [+91 89587 02215](tel:+918958702215)

---

## 🌍 Deployment (GitHub + Base44 + Custom Domain)

1. Push this code to your GitHub repository.
2. Connect Base44 app → select “Deploy from GitHub”.
3. Build frontend → output goes to `/client/build`.
4. Set backend as root folder `/server`.
5. Add custom domain (e.g. `ommedicalstore.in`) → Configure DNS (A/CNAME records) → Enable SSL.

---

## 📱 QR / Barcode Setup
- Use [qr-code-generator.com](https://www.qr-code-generator.com) or `qrcode` npm package.
- Encode your app URL (e.g., `https://ommedicalstore.in`) into the QR.
- Print and place on your store.

---

## 💳 Payment Integration (Razorpay Example)
Add this in `/server/index.js` where `payment_link` is generated:
```js
const Razorpay = require('razorpay');
const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET
});

const orderData = await razorpay.orders.create({
  amount: 50000, // amount in paise
  currency: 'INR',
  receipt: 'receipt_'+id,
  notes: { name, phone }
});

const payment_link = `https://rzp.io/i/${orderData.id}`;
```

---

## 🧑‍💼 Admin Panel
- Access: `/admin`
- Token required: set `x-admin-token` in headers.
- Features: view orders, update status, view payment confirmations.

---

## 🧩 Tech Stack
- **Frontend:** React (PWA + Hooks + CSS 3D)
- **Backend:** Node.js + Express + Multer
- **Database:** JSON (can replace with MongoDB)
- **Payments:** Razorpay / Stripe ready

---

## 🛡️ Security Notes
- Never expose `.env` in public repo.
- Use HTTPS with SSL.
- Use real DB and authentication in production.

---

## 📦 Build & Deploy Commands
```bash
# Build frontend
cd client
npm run build

# Copy build folder to server
del /server/build && cp -r build ../server/build

# Deploy backend
git add .
git commit -m "Deploy Om Medical Store"
git push origin main
```

---

## 🏁 Author
**Developed for:** Om Medical Store (Agra, U.P)  
**Developer:** Ghanendra Sharma  
**Contact:** +91 89587 02215
