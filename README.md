
# Swiggy-Style Food Delivery Database Design and Normalization

## Overview
This project models the backend relational database schema of a Swiggy-like online food delivery platform. It captures the essential operations such as managing restaurants, menu items, customers, orders, delivery, and customer support interactions.

## Project Components

- **Database Design**: Includes 12 core tables with detailed entity descriptions, attributes, data types, and relationships.
- **ER Diagram**: Visual entity-relationship modeling with Crow’s Foot notation and Supertype/Subtype classification.
- **Normalization**: Demonstrates normalization up to 3NF with explanation and dependency diagrams.
- **SQL Dump**: Contains all table definitions, relationships, and sample queries.
- **Sample Queries**:
  - Pull data from single and multiple tables
  - Subqueries for analytics (e.g., orders by age group)

## Tables Included
- `RESTAURANT`, `MENU_ITEM`, `CUSTOMER`, `ORDER`, `ORDER_ITEM`
- `DELIVERY_EXECUTIVE`, `PAYMENT`, `PROMOTION`, `REVIEW`
- `CUSTOMER_ADDRESS`, `CUSTOMERCARE_INTERACTION`, `DELIVERY_EXECUTIVE_ASSIGNMENT`

## Features
- Captures complex real-world business rules
- Many-to-many relationships handled via bridge tables
- Demonstrates practical data modeling and normalization techniques

##  How to Use
1. Clone the repo.
2. Load the SQL dump file (`code.sql`) into your MySQL or MariaDB instance.
3. Refer to `Report.pdf` for schema walkthrough and normalization logic.
4. Run provided queries to test functionality or expand based on your use case.
