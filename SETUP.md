# Setup Instructions

This document provides step-by-step instructions to set up and run the Order Management System.

## Prerequisites

Before starting, ensure you have the following installed:
- **.NET 8.0 SDK** or later (download from https://dotnet.microsoft.com/download)
- **SQL Server** (LocalDB is included with Visual Studio, or download SQL Server Express)
- **Git** (optional but recommended, download from https://git-scm.com)
- **Visual Studio 2022** or **Visual Studio Code** with C# extensions

## Step 1: Initial Git Setup

If you have Git installed, initialize the repository with meaningful commits:

### On Windows (PowerShell or Command Prompt):
```batch
cd FIT4016-BackEnd-KiemTra
init-git.bat
```

### On macOS/Linux:
```bash
cd FIT4016-BackEnd-KiemTra
chmod +x init-git.sh
./init-git.sh
```

### Verify Git commits:
```bash
git log --oneline
```

You should see 7+ commits with clear messages.

## Step 2: Restore Dependencies

Navigate to the OrderManagementApp folder and restore NuGet packages:

```bash
cd OrderManagementApp
dotnet restore
```

## Step 3: Database Setup

### Option A: Using Entity Framework CLI (Recommended)

```bash
# Create/update the database from the DbContext
dotnet ef database update
```

This command will:
- Create the OrderManagement database (if not exists)
- Create the `products` and `orders` tables
- Populate with seed data (16 products, 32 orders)

### Option B: Using Package Manager Console (Visual Studio)

1. Open Package Manager Console in Visual Studio
2. Ensure the Default project is set to `OrderManagementApp`
3. Run:
```powershell
Update-Database
```

### Option C: Manual Database Creation (SQL Server Management Studio)

If you prefer to create manually:
```sql
-- Run the SQL scripts in OrderDbContext.cs to create tables
-- Or use the Entity Framework migration approach above
```

## Step 4: Configure Connection String (If Needed)

If your SQL Server setup is different, update `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=OrderManagement;Trusted_Connection=true;TrustServerCertificate=true;"
  }
}
```

Replace with your SQL Server details if needed.

## Step 5: Run the Application

### Option A: Using dotnet CLI

```bash
cd OrderManagementApp
dotnet run
```

The application will start at `https://localhost:5001` (or similar)

### Option B: Using Visual Studio

1. Open the solution in Visual Studio
2. Set `OrderManagementApp` as the startup project
3. Press `F5` or click the Run button
4. The application will open in your default browser

### Option C: Using Visual Studio Code

1. Open the workspace in VS Code
2. Press `F5` or go to Run > Start Debugging
3. Select `.NET Core` as the environment
4. The application will start and open in browser

## Step 6: Verify Installation

Once the application is running:

1. **Check the Home Page**
   - URL: `https://localhost:5001/`
   - Should display welcome message and quick start buttons

2. **View Orders List**
   - Click "Get Started" or navigate to Orders list
   - Should display the 32 sample orders in a table
   - Verify pagination shows 10 orders per page

3. **Test Search Functionality**
   - Use the search box to find orders by number or customer name
   - Example: Search for "ORD-" to find orders by number

4. **Test Create Order**
   - Click "New Order" button
   - Fill in the form with valid data
   - Submit and verify success message

5. **Test Edit Order**
   - Click "Edit" on any order
   - Update some fields (Customer Name, Email, Quantity, Delivery Date)
   - Verify update success

6. **Test Delete Order**
   - Click "Delete" on any order
   - Confirm deletion
   - Verify order is removed from list

## Troubleshooting

### Error: "Could not find SQL Server"
- Ensure SQL Server LocalDB is installed
- Check if SQL Server service is running
- Verify connection string in `appsettings.json`

### Error: "Entity Framework migrations failed"
- Delete `bin` and `obj` folders
- Run: `dotnet clean`
- Run: `dotnet build`
- Run: `dotnet ef database update`

### Error: "Port 5001 is already in use"
- The application will try the next available port
- Or modify `Properties/launchSettings.json` to use different port

### Views not rendering
- Ensure all `.cshtml` files exist in the `Views` folder structure
- Check that `_Layout.cshtml` is in `Views/Shared/`
- Verify layout is referenced in `_ViewStart.cshtml`

### Database not created
- Run: `dotnet ef database update` again
- Check that you have SQL Server installed and running
- Verify connection string has correct server name

## Building for Production

To prepare the application for deployment:

```bash
cd OrderManagementApp

# Clean previous builds
dotnet clean

# Build release version
dotnet build -c Release

# Publish to folder
dotnet publish -c Release -o ./publish
```

The published files will be in the `publish` folder.

## Running Tests (If Added)

```bash
cd OrderManagementApp.Tests
dotnet test
```

## Useful Commands

```bash
# View Entity Framework database migrations
dotnet ef migrations list

# Create a new migration (after model changes)
dotnet ef migrations add MigrationName

# Revert to previous state
dotnet ef database update PreviousMigrationName

# Drop entire database
dotnet ef database drop

# View current database schema
dotnet sql-cache create "connection-string" "dbo" "table-name"
```

## Database Backup

To backup your database:

```bash
# Using SQL Server Management Studio
# Right-click Database > Tasks > Backup...

# Or using PowerShell
Backup-SqlDatabase -ServerInstance "(localdb)\mssqllocaldb" -Database "OrderManagement" -BackupFile "OrderManagement_$(Get-Date -Format 'yyyyMMdd').bak"
```

## Next Steps

After successful installation:

1. Review the code in `Models/`, `Controllers/`, and `Services/` folders
2. Understand the Entity Framework configuration in `Data/OrderDbContext.cs`
3. Test all CRUD operations
4. Try adding new features or modifying validation rules
5. Create your own commits as you make changes

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review comments in the code files
3. Consult the README.md for detailed documentation
4. Check official documentation:
   - ASP.NET Core: https://docs.microsoft.com/aspnet/core
   - Entity Framework: https://docs.microsoft.com/ef/core/
   - SQL Server: https://docs.microsoft.com/sql/

## Git Configuration

After initialization, you can view your commits:

```bash
# View all commits
git log

# View commits in one-line format
git log --oneline

# View detailed commit information
git log --stat
```

Example output:
```
7 commits
- Configure ASP.NET Core application with Entity Framework setup
- Create views for listing, creating, editing, and deleting orders
- Implement OrdersController with CRUD operations
- Add OrderValidator with comprehensive validation rules and OrderService
- Implement OrderDbContext with database configuration and seed data
- Create Product and Order entity models with Data Annotations
- Initial project setup with folder structure and documentation
```

## Project Structure Summary

```
FIT4016-BackEnd-KiemTra/
├── OrderManagementApp/              # Main application folder
│   ├── Controllers/                 # MVC Controllers (OrdersController, HomeController)
│   ├── Models/                      # Entity Models (Product, Order)
│   ├── Views/                       # Razor Views (CSHTML files)
│   │   ├── Orders/                  # Order-related views
│   │   ├── Home/                    # Home page
│   │   └── Shared/                  # Layout and shared components
│   ├── Data/                        # Database context (OrderDbContext)
│   ├── Services/                    # Business logic (OrderService)
│   ├── Validations/                 # Validation rules (OrderValidator)
│   ├── Program.cs                   # Application entry point
│   ├── appsettings.json            # Configuration
│   └── OrderManagementApp.csproj    # Project file
├── README.md                        # Project documentation
├── SETUP.md                         # This file
├── init-git.bat                     # Git initialization script (Windows)
├── init-git.sh                      # Git initialization script (Linux/macOS)
└── .gitignore                       # Git ignore rules
```

---

**Last Updated**: January 21, 2026
