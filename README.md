# DE_Project2
# Project Overview
The relational database models e-commerce workflows, tracking client relationships, inventory pricing matrices, and sales distribution pipelines.
---
# Relational Schema & Table Definitions
The core data architecture is built on three highly decoupled entity relations:  
*   **`customers`**: Stores structural demographic identifiers (`customer_id`, name, email, geographic region, and initialization timestamps).
*   **`products`**: Maintains master records of physical line inventory grouped by category boundaries and base currency valuation rules (`unit_price`).
*   **`orders`**: The core transactional fact table capturing operational quantities and binding customers seamlessly to products via composite indexes.
---
# Query Explanations & Analytical Engineering
1. Unified Master Transaction Log (Multi-Table Consolidation)
*   **Functional Objective**: Synthesizes the normalized data structure back into a flat, row-level transactional journal for reporting ingestion.
*   **Technical Implementation**: Employs two standard `INNER JOIN` operations to bind the core transaction records to customer descriptive nodes and product operational metadata. It computes an on-the-fly metric—`line_revenue`—using mathematical matrix multiplication (`quantity * unit_price`).
*   **Business Value**: Serves as the raw analytical extraction layer for Business Intelligence (BI) layers (like Power BI or Tableau). It shows who bought what, when, and exactly how much value it generated.

 2. Customer Revenue Rollups (Monetary Attribution)
*   **Functional Objective**: Aggregates complete lifetime transactional value attributed to individual customers.
*   **Technical Implementation**: Combines transactional orders with user attributes, grouping by the relational identity block (`customer_id`, `customer_name`). It applies the deterministic `SUM()` aggregation to compound the transactional lines.
*   **Business Value**: Identifies high-value relationships, monitors individual account health, and forms the structural baseline for Customer Lifetime Value (CLV) evaluation.

3. Categorical Product Matrix (Market Segment Performance)
*   **Functional Objective**: Breaks down financial performance across distinct high-level product domains.
*   **Technical Implementation**: Joins the product dimensional catalog with operational sales data, executing a strict deterministic aggregation grouped explicitly by the `category` classification vector.
*   **Business Value**: Informs inventory management matrices and procurement cycles by highlighting which categories dominate top-line growth and which segments require demand generation.

4. Top 5 Client Spend Index (VIP Cohort Analysis)
*   **Functional Objective**: Isolates and targets the absolute highest-grossing customers within the database lifecycle.
*   **Technical Implementation**: Leverages Microsoft SQL Server's native positional constraint parser (`TOP 5`) alongside a descending sorting operator (`ORDER BY total_spend DESC`) to slice the aggregated cohort.
*   **Business Value**: Powers targeted VIP loyalty campaigns, account management prioritization, and retention workflows aimed at securing core revenue streams.
