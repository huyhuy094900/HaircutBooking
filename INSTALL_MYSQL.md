# 🐬 MySQL Installation Guide for Windows

## 📥 Download MySQL

### Option 1: MySQL Installer (Recommended)
1. Go to: https://dev.mysql.com/downloads/installer/
2. Download "MySQL Installer for Windows"
3. Choose the larger file (about 450MB) - it includes all components

### Option 2: XAMPP (Easier for beginners)
1. Go to: https://www.apachefriends.org/download.html
2. Download XAMPP for Windows
3. Includes MySQL, Apache, PHP, and phpMyAdmin

## 🔧 Installation Steps

### Using MySQL Installer
1. **Run the installer** as Administrator
2. **Choose Setup Type:** "Developer Default" or "Server only"
3. **Installation:** Click "Next" through the wizard
4. **Configuration:**
   - Set root password (remember this!)
   - Configure MySQL as a Windows Service
   - Set port to 3306 (default)
5. **Complete installation**

### Using XAMPP
1. **Run XAMPP installer**
2. **Select components:** At minimum, select MySQL and Apache
3. **Install to default location**
4. **Start services:**
   - Open XAMPP Control Panel
   - Click "Start" for MySQL
   - Click "Start" for Apache (optional, for phpMyAdmin)

## 🔗 Add MySQL to PATH

### Method 1: Manual PATH Addition
1. **Open System Properties** (Win + R, type `sysdm.cpl`)
2. **Click "Environment Variables"**
3. **Under "System Variables", find "Path"**
4. **Click "Edit" and add:**
   ```
   C:\Program Files\MySQL\MySQL Server 8.0\bin
   ```
   (Adjust path based on your MySQL version)

### Method 2: Using XAMPP
If using XAMPP, add to PATH:
```
C:\xampp\mysql\bin
```

## ✅ Verify Installation

### Test Command Line
1. **Open Command Prompt** as Administrator
2. **Test MySQL:**
   ```cmd
   mysql --version
   ```
3. **Connect to MySQL:**
   ```cmd
   mysql -u root -p
   ```
4. **Enter your password when prompted**

### Test with phpMyAdmin (XAMPP)
1. **Open browser**
2. **Go to:** http://localhost/phpmyadmin
3. **Login with:** root / your_password

## 🚀 Quick Setup Commands

### After MySQL is installed:
```cmd
# Navigate to your project folder
cd D:\sehuy\BookingService

# Run the database setup
mysql -u root -p < CompleteDatabase.sql
```

### Or use the batch file:
```cmd
# Double-click setup_database.bat
# Or run from command line:
setup_database.bat
```

## 🔧 Common Issues

### "mysql is not recognized"
- **Solution:** Add MySQL to PATH (see above)
- **Alternative:** Use full path to mysql.exe

### "Access denied for user 'root'@'localhost'"
- **Solution:** Reset root password
- **Command:** `mysql -u root -p`

### "Can't connect to MySQL server"
- **Solution:** Start MySQL service
- **Command:** `net start mysql80` (or your version)

## 📞 Need Help?

1. **Check MySQL documentation:** https://dev.mysql.com/doc/
2. **XAMPP documentation:** https://www.apachefriends.org/docs.html
3. **Common error solutions:** https://dev.mysql.com/doc/refman/8.0/en/problems.html

---

**After MySQL is installed, you can run the database setup scripts!** 