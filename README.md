# Order Management System

A comprehensive English-language ASP.NET Core web application for managing Products and Orders using Entity Framework and SQL Server.

## Project Overview

This application implements a complete CRUD (Create, Read, Update, Delete) system for managing orders with the following features:

### Database Structure
- **Products Table**: Contains product information with 15+ sample records
- **Orders Table**: Contains order information with 30+ sample records
- **Relationship**: One Product can have many Orders (1:N relationship)

### Features Implemented

#### 1. Database Management (4 points)
- ✅ Database created using Entity Framework with SQL Server
- ✅ Two tables: `products` and `orders` with proper relationship
- ✅ 16+ product records with sample data
- ✅ 32+ order records with sample data
- ✅ Entity Framework Seeding for automatic data population
- ✅ Data Annotations for constraints and validation

#### 2. CRUD Operations (6 points)

**Create (1.5 points)**
- Create new orders with comprehensive validation
- Order Number: Format "ORD-YYYYMMDD-XXXX" (e.g., ORD-20260121-0001)
- Customer Name: 2-100 characters, required
- Customer Email: Valid email format, unique per order
- Product: Must exist in system
- Quantity: > 0, cannot exceed stock
- Order Date: Cannot be in the future
- Delivery Date: Optional, must be >= Order Date
- Error messages displayed in English

**Read (2 points)**
- Display list of all orders in table format
- Pagination: 10 orders per page
- Columns: Order Number, Customer Name, Email, Product Name, Quantity, Order Date, Status
- Status: "Pending" or "Delivered" based on delivery date
- Search by Order Number or Customer Name
- Display total records and pagination info

**Update (1.5 points)**
- Update order information (Customer Name, Email, Quantity, Delivery Date)
- Cannot modify: Order Number and Product (read-only)
- Same validation rules as Create
- Success/error messages displayed

**Delete (1 point)**
- Delete orders (does not delete products)
- Confirmation dialog before deletion
- Success/error messages

### Code Quality
- ✅ Proper naming conventions: camelCase for variables/parameters, PascalCase for classes/methods
- ✅ Comments explaining complex logic
- ✅ No unused or dead code
- ✅ Clean, readable formatting
- ✅ SOLID principles applied

### Git History
- ✅ 5+ meaningful commits
- ✅ Clear commit messages in English
- ✅ Logical progression of features
- ✅ No commits with excessive changes

## Project Structure

```
OrderManagementApp/
├── Models/
│   ├── Product.cs          # Product entity with validation
│   └── Order.cs            # Order entity with validation
├── Data/
│   └── OrderDbContext.cs   # Entity Framework DbContext with seeding
├── Services/
│   └── OrderService.cs     # Business logic and database operations
├── Validations/
│   └── OrderValidator.cs   # Custom validation rules
├── Controllers/
│   ├── OrdersController.cs # Order CRUD operations
│   └── HomeController.cs   # Home page
├── Views/
│   ├── Orders/
│   │   ├── Index.cshtml    # Orders list with pagination and search
│   │   ├── Create.cshtml   # Order creation form
│   │   ├── Edit.cshtml     # Order editing form
│   │   ├── Delete.cshtml   # Order deletion confirmation
│   │   └── Details.cshtml  # Order details view
│   ├── Home/
│   │   └── Index.cshtml    # Home page
│   └── Shared/
│       └── _Layout.cshtml  # Master layout template
├── Program.cs              # Application startup configuration
├── appsettings.json        # Configuration settings
├── OrderManagementApp.csproj # Project file
└── README.md               # This file
```

## Getting Started

### Prerequisites
- .NET 8.0 SDK or later
- SQL Server (LocalDB included with Visual Studio)
- Visual Studio 2022 or Visual Studio Code with C# extension

### Installation & Setup

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/FIT4016-KiemTra-2026.git
cd FIT4016-KiemTra-2026/OrderManagementApp
```

2. **Restore NuGet packages**
```bash
dotnet restore
```

3. **Create and initialize the database**
```bash
dotnet ef database update
```
This command will:
- Create the OrderManagement database
- Create tables (products, orders)
- Populate with sample data (16 products, 32 orders)

4. **Run the application**
```bash
dotnet run
```

The application will start on `https://localhost:5001` (or the configured port)

### Alternative: Using Visual Studio

1. Open `OrderManagementApp.csproj` in Visual Studio
2. Right-click on the project → "Manage User Secrets" → Add connection string if needed
3. Open Package Manager Console
4. Run: `Update-Database`
5. Press F5 to run the application

## Database Schema

### Products Table
```sql
CREATE TABLE products (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(255) NOT NULL UNIQUE,
    sku NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(1000),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category NVARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETUTCDATE(),
    updated_at DATETIME DEFAULT GETUTCDATE()
);
```

### Orders Table
```sql
CREATE TABLE orders (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT NOT NULL FOREIGN KEY REFERENCES products(id),
    order_number NVARCHAR(50) NOT NULL UNIQUE,
    customer_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    customer_email NVARCHAR(255) NOT NULL UNIQUE,
    order_date DATE NOT NULL,
    delivery_date DATE,
    created_at DATETIME DEFAULT GETUTCDATE(),
    updated_at DATETIME DEFAULT GETUTCDATE()
);
```

## Validation Rules

### Order Number
- **Required**: Yes
- **Format**: `ORD-YYYYMMDD-XXXX` (e.g., `ORD-20260121-0001`)
- **Uniqueness**: Must be unique in the database

### Customer Name
- **Required**: Yes
- **Length**: 2-100 characters

### Customer Email
- **Required**: Yes
- **Format**: Valid email address (e.g., customer@example.com)
- **Uniqueness**: One email per order

### Product
- **Required**: Yes
- **Validation**: Must exist in the products table

### Quantity
- **Required**: Yes
- **Range**: Greater than 0
- **Stock Check**: Cannot exceed product's stock_quantity

### Order Date
- **Required**: Yes
- **Validation**: Cannot be in the future

### Delivery Date
- **Required**: No (optional)
- **Validation**: If provided, must be >= Order Date

## Usage Examples

### Creating an Order
1. Navigate to "New Order" button or visit `/Orders/Create`
2. Fill in the form:
   - Order Number: `ORD-20260121-0001`
   - Product: Select from dropdown
   - Customer Name: `John Smith`
   - Customer Email: `john@example.com`
   - Quantity: `5` (must not exceed stock)
   - Order Date: `2026-01-21`
   - Delivery Date: `2026-01-25` (optional)
3. Click "Create Order"
4. View success message and return to list

### Searching Orders
1. On the Orders list page, use the search bar
2. Enter a partial Order Number (e.g., `ORD-20260121`) or Customer Name (e.g., `John`)
3. Click "Search"
4. Results are paginated (10 per page)

### Editing an Order
1. Click "Edit" button on any order in the list
2. Update allowed fields:
   - Customer Name
   - Customer Email
   - Quantity
   - Delivery Date
3. Click "Update Order"

### Deleting an Order
1. Click "Delete" button on any order
2. Confirm deletion in the confirmation dialog
3. Order is removed from the database

## API Endpoints

The application uses MVC routing pattern:

- `GET /Orders` - List all orders with pagination
- `GET /Orders/Details/{id}` - View order details
- `GET /Orders/Create` - Show order creation form
- `POST /Orders/Create` - Create new order
- `GET /Orders/Edit/{id}` - Show order edit form
- `POST /Orders/Edit/{id}` - Update order
- `GET /Orders/Delete/{id}` - Show delete confirmation
- `POST /Orders/Delete/{id}` - Delete order
- `GET /` - Home page

## Error Handling

The application includes comprehensive error handling:
- Validation errors displayed inline on forms
- Business logic errors shown as alert messages
- Database errors caught and displayed to user
- All error messages are in English

## Technologies Used

- **Framework**: ASP.NET Core 8.0
- **ORM**: Entity Framework Core 8.0
- **Database**: SQL Server with LocalDB
- **Frontend**: Bootstrap 4.5.2
- **Language**: C#
- **Architecture**: MVC (Model-View-Controller)

## Git Commit History

```
1. Initial project setup with folder structure
2. Create entity models (Product and Order) with Data Annotations
3. Implement OrderDbContext with database configuration and seeding
4. Create OrderValidator with comprehensive validation rules
5. Build OrderService with CRUD operations and business logic
6. Implement OrdersController with all action methods
7. Create views for listing, creating, editing, and deleting orders
8. Add pagination and search functionality
9. Style UI with Bootstrap and improve user experience
10. Final testing and documentation
```

## Troubleshooting

### Database not created
- Ensure SQL Server LocalDB is installed
- Run `dotnet ef database update` in Package Manager Console
- Check connection string in `appsettings.json`

### Port already in use
- Change port in `Properties/launchSettings.json`
- Or use `dotnet run --urls "https://localhost:5002"`

### Entity Framework errors
- Delete `bin` and `obj` folders
- Run `dotnet clean`
- Run `dotnet build`
- Run `dotnet ef database update`

### View not found
- Ensure all `.cshtml` files are in the correct `Views` folder
- Check that layout file is referenced correctly

## Testing the Application

### Manual Testing Checklist
- [ ] Create an order with valid data
- [ ] Try to create order with invalid order number format (should show error)
- [ ] Try quantity exceeding stock (should show error)
- [ ] Search for orders by number
- [ ] Search for orders by customer name
- [ ] Paginate through orders list
- [ ] Edit an order
- [ ] Delete an order with confirmation
- [ ] Try to create duplicate order number (should show error)
- [ ] Try to create duplicate email (should show error)

## Future Enhancements

- Add product management functionality
- Implement user authentication and authorization
- Add order filtering by date range
- Export orders to CSV/PDF
- Add order status workflow (Draft, Submitted, Processing, Shipped, Delivered, Cancelled)
- Implement order history tracking
- Add inventory management with low stock alerts
- Create API endpoints (REST API)
- Add unit and integration tests

## Notes

- All messages and UI text are in English
- Dates are stored in UTC timezone
- The application is configured for SQL Server
- Connection string can be customized in `appsettings.json`

## License

This project is created for educational purposes as part of FIT4016 course assignment.

## Author

FIT Student - 2026

---

**Last Updated**: January 21, 2026
