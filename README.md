Power Bi Dashboard-https://app.fabric.microsoft.com/links/j1jHvyy90y?ctid=18fba71d-17f8-49c6-89b8-2613315bb69d&pbi_source=linkShare

# Clinical-Data-Analysis-Project
A high-volume clinical data analytics project where I worked with over 20 million rows of clinical data using SQL Server and Power BI.

---


🔍 **Challenges & Solutions**:
Due to the massive data volume, importing directly into Power BI wasn't efficient. So, I architected the solution with a **data lake and data warehouse layer in SQL Server**. All major **data cleaning, transformation, and modeling tasks** were executed at the SQL level, ensuring performance and scalability.

📊 **Advanced Data Profiling**:
Using **dynamic SQL**, I developed a profiling process to calculate:

* Mean, Median, Mode
* Standard Deviation, Min/Max
* Null count, Distinct count, Zero values
* Column-wise frequency distribution

These insights were essential to understand the underlying structure and behavior of the dataset.

🛠 **Modeling & Transformation**:

* Normalized date ranges between 2024–2030 using **T-SQL**
* Performed **feature selection** to optimize datasets for reporting
* Connected refined tables to **Power BI** for visual insights

📈 **Power BI Insights & Optimization**:
Built KPIs to track metrics such as:

* Number of infections
* Readmissions
* Admissions
* Deaths by hospital and over time

Enabled **incremental data refresh** for efficient report updates and **migrated the data pipeline** from SQL Server to MySQL without affecting Power BI reports. Also set up **multiple workspaces** in Power BI for better data governance.

'Clinical Data Analytics Project – Data Flow Architecture'

           +------------------+
           |  Raw Clinical    |
           |     Data         |
           | (CSV, EHR, etc.) |
           +--------+---------+
                    |
                    v
       +-------------------------+
       |  SQL Server - Data Lake |
       |  (Staging Layer)        |
       +-------------------------+
                    |
                    v
       +--------------------------+
       | SQL Server - Data        |
       | Warehouse (Model Layer)  |
       | - Cleansing              |
       | - Transformation (T-SQL) |
       | - Feature Selection      |
       +------------+-------------+
                    |
                    v
       +----------------------------+
       |   Power BI Dataflow        |
       | - Reusable Datasets        |
       | - Lightweight Transform    |
       | - Connects to SQL Views    |
       +------------+---------------+
                    |
       +------------v-------------+
       |   Data Profiling Logic   |
       | - Mean, Median, Mode     |
       | - Std Dev, Min/Max       |
       | - Nulls, Distincts       |
       | - Frequency Distributions|
       +------------+-------------+
                    |
                    v
          +----------------------+
          |   Power BI Desktop   |
          | - Import/DirectQuery |
          | - Star Schema Model  |
          | - Measures & DAX     |
          +----------+-----------+
                     |
                     v
        +-----------------------------+
        | Power BI Reports & KPIs     |
        | - Admissions, Infections    |
        | - Readmissions, Deaths      |
        | - Trends Over Time/Hospitals|
        +-------------+---------------+
                      |
                      v
        +-----------------------------+
        | Power BI Service Workspaces |
        | - Role-based Access         |
        | - Incremental Refresh       |
        | - Deployment Pipelines      |
        +-----------------------------+







---

Snap:
Hospital Analysis:

![h1](https://github.com/user-attachments/assets/5592a19f-2239-4617-863e-1130c3517926)

Analysis by Date:
![h2](https://github.com/user-attachments/assets/99f2b0fd-e7db-43b9-9bfe-4714c58e1093)



