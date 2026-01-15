# 🏥 Hospital Analytics Data Warehouse (OLTP → OLAP)

## 📌 Project Overview

This project designs and implements a **hospital analytics data warehouse** using a **Star Schema** to support fast, reliable, and scalable OLAP queries.

The work demonstrates the full data warehousing lifecycle:

- Starting from a normalized OLTP schema
- Designing dimensions, fact tables, and bridge tables
- Implementing ETL logic
- Optimizing analytical queries
- Evaluating performance improvements using execution plans

**Goal:** Demonstrate why and how star schemas outperform normalized schemas for analytical workloads.

---

## 🏗️ Architecture Overview

### Source System (OLTP)

The OLTP schema models real hospital operations, including:

- Patients
- Providers
- Encounters
- Diagnoses
- Procedures
- Billing

This schema is **highly normalized** and optimized for transactions (INSERT/UPDATE).

### Target System (OLAP)

The OLAP schema reorganizes data into a **Star Schema** optimized for analytics:

- One central fact table
- Multiple dimension tables
- Bridge tables for many-to-many relationships

---

## ⭐ Star Schema Design

### Fact Table

**`fact_encounter`**

- **Grain:** One row per encounter
- **Stores:**
  - Surrogate keys to all dimensions
  - Pre-aggregated metrics
  - Flags used for analytics

**Key metrics include:**

- `total_allowed_amount`
- `diagnosis_count`
- `procedure_count`
- `is_readmission`

### Dimension Tables

| Dimension | Purpose |
|-----------|---------|
| `dim_patient` | Patient demographics |
| `dim_provider` | Provider details |
| `dim_specialty` | Medical specialties |
| `dim_department` | Hospital departments |
| `dim_date` | Calendar attributes |
| `dim_encounter_type` | Encounter classification |
| `dim_diagnosis` | ICD-10 diagnosis details |
| `dim_procedure` | CPT procedure details |

All dimensions use **surrogate keys** to ensure:

- Stable joins
- Faster query performance
- Independence from OLTP key changes

### Bridge Tables

| Bridge Table | Relationship |
|--------------|--------------|
| `bridge_encounter_diagnoses` | Encounter ↔ Diagnosis |
| `bridge_encounter_procedures` | Encounter ↔ Procedure |

Bridge tables handle true **many-to-many relationships** without exploding the fact table.

---

## 🔄 ETL Process

### ETL Strategy

The ETL process moves data from OLTP to OLAP in four stages:

1. **Extract**
   - Pull data from OLTP tables

2. **Transform**
   - Clean data
   - Deduplicate
   - Derive metrics

3. **Load Dimensions**
   - Generate surrogate keys
   - Load descriptive attributes

4. **Load Facts & Bridges**
   - Lookup dimension keys
   - Store pre-aggregated metrics

### Load Order (Critical)

1. `dim_date`
2. `dim_specialty`
3. `dim_department`
4. `dim_encounter_type`
5. `dim_provider`
6. `dim_patient`
7. `dim_diagnosis`
8. `dim_procedure`
9. `fact_encounter`
10. Bridge tables

---

## 📊 Analytical Queries (OLAP)

The star schema supports common healthcare analytics such as:

- Monthly encounters by specialty and encounter type
- Most common diagnosis–procedure combinations
- Readmission rates by specialty
- Revenue trends over time

Queries are:

- ✅ Short
- ✅ Easy to read
- ✅ Fast to execute
- ✅ Free of complex business logic

---

## ⚡ Performance Improvements

| Query | OLTP Time | OLAP Time | Improvement |
|-------|-----------|-----------|-------------|
| Diagnosis–Procedure Analysis | 0.18 ms | 0.04 ms | **4.5× faster** |
| Revenue by Specialty | 0.25 ms | 0.06 ms | **4.2× faster** |

### Why the Speedup?

- ✅ Fewer joins
- ✅ No join explosion
- ✅ Pre-computed metrics
- ✅ No `COUNT(DISTINCT ...)`
- ✅ Dimensional date handling

---

## 📁 Project Structure

```
├── oltp_schema.sql        # Original normalized schema
├── olap_schema.sql        # Star schema (fact, dimensions, bridges)
├── etl_design.txt         # ETL logic documentation
├── reflection.md          # Design & performance reflection
├── sample_queries.sql     # OLAP analytical queries
└── README.md              # Project documentation
```

---

## 🧠 Key Concepts Demonstrated

- OLTP vs OLAP design principles
- Star schema modeling
- Fact table grain selection
- Surrogate keys
- Bridge tables for many-to-many relationships
- Pre-aggregation during ETL
- Query performance analysis using execution plans

---

## 🧪 Tools & Technologies

- **Database:** MySQL
- **SQL:** DDL, DML, analytical queries
- **Modeling:** Dimensional modeling (Kimball style)
- **Performance Analysis:** EXPLAIN / execution plans

---

## 🎯 Learning Outcomes

By completing this project, you gain hands-on experience with:

- ✅ Designing analytics-optimized schemas
- ✅ Writing ETL logic for data warehouses
- ✅ Understanding why schema design impacts performance
- ✅ Translating business questions into OLAP queries

---

## 🚀 Future Enhancements

- [ ] Slowly Changing Dimensions (Type 2)
- [ ] Incremental ETL automation
- [ ] Summary / aggregate fact tables
- [ ] Dashboard integration (Power BI / Tableau)
- [ ] Data quality checks

---

## 👤 Author

**Percy Ayimbila Nsolemna**  
*Data Engineering & Analytics Project*

---

## 📄 License

This project is available for educational and portfolio purposes.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

---

## ⭐ Show Your Support

Give a ⭐️ if this project helped you learn about data warehousing!