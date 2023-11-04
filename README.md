# public_toilets

## การสร้าง API server บน localhost
1. ติดตั้ง [Node.js](https://nodejs.org/en/download)
2. ติดตั้ง `json-server` โดยพิมพ์คำสั่งที่ terminal (command-line):

```bash
npm install -g json-server
```

3. รัน API server โดยใช้ข้อมูลจากไฟล์ db.json ที่อยู่ในโฟลเดอร์ assets/data ของโปรเจคนี้

```bash
json-server --watch assets/data/db.json
```

> Note: ถ้าหาก terminal ไม่ได้อยู่ที่ root folder ของโปรเจค ให้ `cd` มาที่ root folder ของโปรเจคก่อน แล้วค่อยพิมพ์คำสั่งข้างต้น แต่ปกติเมื่อเปิด terminal ขึ้นมาใหม่ใน VS Code หรือ Android Studio โฟลเดอร์ปัจจุบันใน terminal จะเป็น root folder ของโปรเจคอยู่แล้ว

4. ทดสอบการทำงานของ API server โดยใช้ web browser เข้าไปที่

    * http://localhost:3000/toilets
    * http://localhost:3000/reviews
    * http://localhost:3000/toilets?_embed=reviews