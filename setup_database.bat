@echo off
echo ========================================
echo    HaircutBooking Database Setup
echo ========================================
echo.

echo Checking MySQL connection...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: MySQL is not installed or not in PATH
    echo Please install MySQL and add it to your system PATH
    pause
    exit /b 1
)

echo MySQL found! Starting database setup...
echo.

echo Creating database and inserting sample data...
mysql -u root -p < CompleteDatabase.sql

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo    DATABASE SETUP COMPLETE!
    echo ========================================
    echo.
    echo Database: HaircutBooking
    echo Admin Account: admin@haircut.com / admin123
    echo Test Users: john@example.com / password123
    echo.
    echo You can now run the application!
    echo.
) else (
    echo.
    echo ========================================
    echo    DATABASE SETUP FAILED!
    echo ========================================
    echo.
    echo Please check:
    echo 1. MySQL server is running
    echo 2. Username and password are correct
    echo 3. You have permission to create databases
    echo.
)

pause 