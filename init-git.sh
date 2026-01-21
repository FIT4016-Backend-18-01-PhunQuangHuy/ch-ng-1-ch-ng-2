#!/bin/bash
# Initialize Git Repository and Create Commits
# This script sets up the git repository with meaningful commits

echo "Initializing Git repository..."
git init

echo "Configuring Git user..."
git config user.email "student@fit.edu.vn"
git config user.name "FIT Student"

echo "Adding initial project structure..."
git add .gitignore README.md
git commit -m "Initial project setup with folder structure and documentation"

echo "Adding entity models..."
git add OrderManagementApp/Models/
git commit -m "Create Product and Order entity models with Data Annotations"

echo "Adding database context..."
git add OrderManagementApp/Data/
git commit -m "Implement OrderDbContext with database configuration and seed data"

echo "Adding validation and services..."
git add OrderManagementApp/Validations/ OrderManagementApp/Services/
git commit -m "Add OrderValidator with comprehensive validation rules and OrderService"

echo "Adding controllers..."
git add OrderManagementApp/Controllers/
git commit -m "Implement OrdersController with CRUD operations"

echo "Adding views..."
git add OrderManagementApp/Views/
git commit -m "Create views for listing, creating, editing, and deleting orders"

echo "Adding project configuration..."
git add OrderManagementApp/Program.cs OrderManagementApp/appsettings.json OrderManagementApp/OrderManagementApp.csproj
git commit -m "Configure ASP.NET Core application with Entity Framework setup"

echo ""
echo "Git repository initialized successfully!"
echo "View commit history with: git log --oneline"
