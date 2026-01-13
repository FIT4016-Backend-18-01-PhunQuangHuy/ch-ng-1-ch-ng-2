# SchoolManagement

This is an ASP.NET Core MVC application that manages Schools and Students using Entity Framework Core (Code First).

Features:
- Schools and Students models with 1-n relationship
- Constraints (PK, FK, Unique, Not Null) configured with Data Annotations and Fluent API
- Seeded sample data: 10 schools and 20 students
- Students CRUD (Create, Read with pagination, Update, Delete)
- Server-side validation and user-friendly English messages

How to run:
1. Ensure .NET SDK is installed.
2. Open the project root in terminal.
3. Restore & build: `dotnet build` or open in Visual Studio.
4. Apply migrations and update database (LocalDB) (already applied):
   - `dotnet ef database update --context ApplicationDbContext --project SchoolManagement.csproj --startup-project SchoolManagement.csproj`
5. Run the app: `dotnet run --project SchoolManagement.csproj` and open the URL shown in the terminal.

DB Connection:
- Default connection string uses LocalDB and database `SchoolManagementDb`. Change `appsettings.json` if needed.

Notes:
- Validation rules are enforced server-side (Data Annotations + controller checks).
- Seed data uses fixed dates to ensure deterministic migrations.

If you want, I can also add unit tests for validation and automated UI tests next. 