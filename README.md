# CS Course Projects

Selected projects from my Computer Science coursework at **San Francisco Bay University**, covering object-oriented programming, relational databases and SQL, numerical methods, statistics, and computer architecture.

| Project | What it does | Tech |
|---|---|---|
| [Library Management System](library-management-system) | Menu-driven console app to add, search, borrow and return books and manage students | Java (OOP) |
| [Property Management Database](sql-property-management-system) | Relational database for a property-management company: owners, tenants, properties, leases, payments | SQL (MySQL) |
| [Agricultural Data Analysis](sql-agricultural-data-analysis) | Database and analytical queries on crop production, land, weather and market data for Bangladesh | SQL (MySQL) |
| [Newton's Method Root Finding](newtons-method-root-finding) | Finds the negative root of eˣ = 4 − x² (x ≈ −1.964636) to 6 decimal places and exports iteration data | Python, NumPy, pandas |
| [Research reports](#research-reports) | Linear regression on Google stock prices, CPU vs AI microprocessors, XOR algorithms | Statistics, Computer Organization, Discrete Math |

## Projects

### Library Management System (Java)
Console application built with object-oriented design: `Book` and `Student` classes, an `ArrayList`-backed catalog, and a menu for adding/searching books, registering students, and borrowing/returning books with quantity tracking.
- Code: [`LibraryManagementSystem.java`](library-management-system/LibraryManagementSystem.java)
- Sample run: [Library management system OUTPUT.txt.pdf](Library%20management%20system%20OUTPUT.txt.pdf)

```bash
cd library-management-system
javac LibraryManagementSystem.java && java LibraryManagementSystem
```

### Property Management Database (SQL)
Schema with 8 tables (Owner, Tenant, Property, Apartments, Rental Application, Lease, Payment, Maintenance Request) and queries covering `SELECT`/`UPDATE`/`ALTER`, `GROUP BY`, inner/left/right joins and nested joins.
- [`schema.sql`](sql-property-management-system/schema.sql) · [`queries.sql`](sql-property-management-system/queries.sql)
- Presentation: [Triangle Property Management System (PDF)](Triangle%20Property%20Management%20System%20by%20using%20SQL%20and%20Relational%20database.pptx.pdf)

### Agricultural Data Analysis (SQL)
10-table schema (Location, Farmer, Crop, Land, Production, Weather, Market, Sales, Pest, plus a Farmer–Land junction table) and 15 analytical queries, from `GROUP BY`/`HAVING` basics to multi-table and nested joins (including a `FULL OUTER JOIN` emulated with `UNION` in MySQL).
- [`schema.sql`](sql-agricultural-data-analysis/schema.sql) · [`queries.sql`](sql-agricultural-data-analysis/queries.sql)
- Presentation: [Agricultural Data Analysis (PPTX)](Agricultural%20Data%20Analysis%20By%20Using%20SQL%20and%20Dtabase.pptx)

### Newton's Method Root Finding (Python)
Implements Newton–Raphson iteration for f(x) = eˣ + x² − 4 with a 10⁻⁶ tolerance, records every iteration, and writes the iteration table and plot data to Excel to verify the root graphically.
- Code: [`newtons_method.py`](newtons-method-root-finding/newtons_method.py) · Data: [`plot_data.csv`](newtons-method-root-finding/plot_data.csv)
- Report: [Newton's Method for Root Approximation (PDF)](Newton%E2%80%99s%20Method%20for%20Root%20Approximation.pdf)

### Research reports
- [Linear Regression Analysis of Google's Opening and Closing Stock Prices (Aug–Dec 2023)](A%20Linear%20Regression%20Analysis%20of%20Google%E2%80%99s%20Opening%20and%20Closing%20Stock%20Prices%20%28August%201%20%E2%80%93%20December%205%2C%202023%29.pdf) (Probability & Statistics)
- [A Comparative Study of General-Purpose and AI Microprocessors](A%20Comparative%20Study%20of%20General-Purpose%20and%20AI%20Microprocessors.pdf) (Computer Organization)
- [5 Algorithms of XOR Operations](5-Algorithyms%20of%20X-OR%20%20operations.pdf) (Discrete Mathematics)

## Contact
[LinkedIn](https://www.linkedin.com/in/md-azmir-bhuiyan-97174034b) · More ML work: [machine-learning-projects](https://github.com/azmir9083/machine-learning-projects)
