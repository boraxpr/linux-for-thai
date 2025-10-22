เมื่อ install linux distro แล้ว ในหลาย distro มักให้ set font ได้แค่ภาษาอังกฤษหรือภาษาไทย เพียงหนึ่งภาษาเท่านั้น ไม่มีUI ให้ set font แยก 2 ภาษา ดังนั้น font ของภาษาไทยมักจะถูก fallback เป็น Noto sans ซึ่งเป็น Font ไทยที่ไม่มีหัวและอ่านยาก ถ้าไม่ใช้ font ที่มี ทั้งไทยและอังกฤษและมีหัวในเวลาเดียวกัน

script นี้จะทำการ download font google sarabun และ override เมื่อเป็นภาษาไทย

```bash
wget -qO- https://raw.githubusercontent.com/boraxpr/linux-for-thai/refs/heads/main/fonts/sarabunizer.sh | sh
```

**FROM DEFAULT:**<br><img src="asset/thai-no-loop-notosan.png" width="400">

**TO:**<br><img src="asset/thai-loop-sarabun.png" width="400">

