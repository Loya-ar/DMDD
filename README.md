# Database Management Project

## Overview

This project automates an e-commerce system by implementing a robust database solution that adheres to key business rules. It supports user management, inventory management, order placement, and reporting, showcasing a wide range of database functionalities.

## Features

1. **User Management**  
   - Users can place orders.  
   - Influencers can promote products.

2. **Inventory Management**  
   - Admin and Inventory Managers can update product details and stock levels.

3. **Order Management**  
   - Orders are validated for stock availability before placement.  
   - Order statuses are tracked and updated.

4. **Reporting**  
   - Dynamic views provide insights into sales, inventory, and influencer performance.

5. **Error Handling**  
   - Extensive validations ensure business rules are met.

---

## Project Components

1. **Tables**  
   - `Tables.sql`: Defines tables for users, products, influencers, orders, and order details.  
   - **Sample Data**: Includes 10 sample users, influencers, and products, along with simulated transactions.

2. **Roles**  
   - `Users.sql`: Creates roles with specific access levels:  
     - `APP_ADMIN`: Full access to all objects and management capabilities.  
     - `INVENTORY_MANAGER`: Can update products and manage stock levels.  
     - `INFLUENCER_USER`: Read-only access to products and sales data.  
     - `APP_USER`: Access to place orders.

3. **Views**  
   - `Views.sql`: Defines views for reporting:  
     - `Current_Inventory_Status`: Tracks stock levels.  
     - `Total_Sales_Region`: Summarizes sales by region.  
     - `Customer_Purchase_Behavior`: Tracks customer orders and spending.

4. **Procedures and Functions**  
   - `Procedures.sql`:  
     - `place_order`: Places a validated order.  
     - `upsert_user_details`: Adds or updates user information.  
   - `Functions.sql`:  
     - `calculate_order_total`: Computes the total order cost.

5. **Triggers**  
   - `Triggers.sql`:  
     - `Update_Inventory_After_Order`: Adjusts inventory after an order.  
     - `Prevent_Out_Of_Stock_Order`: Prevents ordering out-of-stock products.

6. **Reports**  
   - `Reports.sql`: Provides insights such as:  
     - Top customers by orders.  
     - Sales performance by influencer.  
     - Inventory status and low stock alerts.

---

## Execution Steps

### Pre-requisites
1. Oracle Database (version 12c or higher).  
2. SQL Client (e.g., SQL Developer or command-line interface).  
3. Access credentials for admin.

### Steps
1. **Create Users and Roles**  
   - Execute `Users.sql` to create roles.  
   - Assign grants using `Grants.sql`.

2. **Create Database Objects**  
   - Run `Tables.sql` to create tables and sequences.

3. **Insert Sample Data**  
   - Populate tables with initial data.

4. **Create Views**  
   - Execute `Views.sql` to create dynamic reports.

5. **Compile and Execute Procedures and Functions**  
   - Run `Procedures.sql` and `Functions.sql`.  
   - Validate using test scripts.

6. **Create Triggers**  
   - Execute `Triggers.sql`.  
   - Test triggers with sample operations.

7. **Run Reports**  
   - Execute `Reports.sql` to generate insights.

---

## Error Handling

1. **ORA-01031 (Insufficient Privileges)**  
   - Ensure roles and grants are correctly assigned.

2. **ORA-00001 (Unique Constraint Violated)**  
   - Check for duplicate data during `INSERT` operations.

---

## Conclusion

This project demonstrates end-to-end database management with role-based access control, comprehensive error handling, and robust reporting capabilities. The implementation adheres to real-world business rules, ensuring seamless database functionality.

---

## Team Members

- **Anurag Gher**  
  NUID: 002845719  
  Email: gher.a@northeastern.edu  

- **Arjun Loya**  
  NUID: 002318612  
  Email: loya.a@northeastern.edu  

- **Lokesh Thodkar**  
  NUID: 002088709  
  Email: thodkar.l@northeastern.edu  

---
