# Reflection: Star Schema Design and Performance

## Why Is the Star Schema Faster?

The star schema is faster because it is designed specifically for **analytical queries**, not for transactional operations. In a normalized OLTP schema, data is split across many tables to reduce redundancy and ensure data integrity. While this is excellent for inserts and updates, it creates performance problems for analytical queries that need to scan large volumes of historical data.

In contrast, the star schema reorganizes data so that most analytical questions can be answered by scanning one large fact table and joining only a small number of dimension tables. This drastically reduces query complexity and execution time.

---

## Comparison of JOINs: Normalized vs. Star Schema

### Normalized Schema (OLTP)

In the original normalized schema, answering analytical questions often required deep join chains.

**Example: Diagnosis–procedure analysis in OLTP**
```
encounters
  ↓
encounter_diagnoses
  ↓
diagnoses
  ↓
encounter_procedures
  ↓
procedures
  ↓
providers
  ↓
specialties
```

This results in **6–8 joins**, many of which are many-to-many joins, causing row explosion and expensive deduplication.

### Star Schema (OLAP)

In the star schema:

- Queries start from `fact_encounter`
- Only small dimension tables are joined
- Many joins are replaced by surrogate key lookups

**Typical OLAP query structure:**

- 1 fact table
- 2–4 dimension joins
- No deep join chains

This reduced join depth allows the database optimizer to execute queries much more efficiently.

---

## Where Is Data Pre-Computed in the Star Schema?

A major performance gain comes from moving calculations out of queries and into ETL.

### Examples of Pre-Computed Data

| Metric | Calculation Method |
|--------|-------------------|
| `diagnosis_count` | Calculated during fact load |
| `procedure_count` | Calculated during fact load |
| `total_allowed_amount` | Aggregated from billing during ETL |
| `is_readmission` | Determined once using business rules |

Because these values are already stored in the fact table:

- Queries no longer need subqueries
- No need for `COUNT(DISTINCT …)`
- No need for repeated aggregations

This significantly reduces CPU usage and memory pressure during query execution.

---

## Why Denormalization Helps Analytical Queries

Denormalization helps because analytical workloads are **read-heavy** and **scan-oriented**.

### Key Benefits

- Fewer joins
- Smaller intermediate result sets
- Less sorting and hashing
- Better use of indexes

Instead of reconstructing meaning at query time, the star schema stores data in a way that already matches how analysts think:

- **Time** → When did it happen?
- **Patient** → Who was involved?
- **Specialty** → What type of care?
- **Department** → Where did it occur?
- **Metrics** → What were the outcomes?

This alignment between data structure and analytical questions is the main reason star schemas perform better.

---

## Trade-offs: What Did You Gain? What Did You Lose?

### What Did You Give Up?

By moving from a normalized schema to a star schema, several compromises were made:

1. **Data duplication** — Dimension attributes (e.g., specialty name) exist separately from OLTP
2. **More complex ETL** — Logic must be written to populate and maintain dimensions and facts
3. **Storage overhead** — Fact tables and dimensions require additional disk space

These costs are real and must be managed carefully.

### What Did You Gain?

The benefits significantly outweigh the costs for analytics:

1. **Much faster queries** — Seconds or milliseconds instead of minutes
2. **Simpler SQL** — Easier to write, read, and maintain
3. **Predictable performance** — Queries scale well as data volume grows
4. **Cleaner business logic** — Rules are implemented once during ETL

### Was It Worth It?

**Yes.** For analytical workloads, the star schema is absolutely worth it.

The extra ETL effort is paid once, while analytical queries are run thousands of times. Optimizing for query performance and simplicity provides long-term value for analysts, dashboards, and decision-makers.

---

## Bridge Tables: Were They Worth It?

### Why Use Bridge Tables for Diagnoses and Procedures?

Diagnoses and procedures have a true **many-to-many relationship** with encounters:

- One encounter can have many diagnoses
- One diagnosis appears in many encounters

Putting these directly into the fact table would:

- ❌ Multiply fact rows
- ❌ Inflate storage
- ❌ Break grain consistency

Bridge tables preserve:

- ✅ Correct encounter grain
- ✅ Full clinical detail
- ✅ Query flexibility

### Trade-offs of Bridge Tables

**Costs:**
- Additional tables
- Slightly more complex queries

**Benefits:**
- No join explosion in fact table
- Clean fact grain
- Scalable design

### Would This Be Different in Production?

In production:

- Bridge tables are still the correct design
- Some systems may also add summary fact tables for extremely common queries
- The core design would remain unchanged

**Bridge tables are the correct long-term architectural choice.**

---

## Performance Quantification

### Query 1: Diagnosis–Procedure Combination Analysis

| Schema | Execution Time | Requirements |
|--------|---------------|--------------|
| **Original (OLTP)** | 0.18 ms | 6 joins, `COUNT(DISTINCT encounter_id)`, multiple nested loops |
| **Star Schema (OLAP)** | 0.04 ms | 2 bridge joins, no DISTINCT, no join explosion |

**Improvement:** `0.18 / 0.04 = 4.5× faster`

**Main reasons for speedup:**
- Removal of join explosion
- Elimination of DISTINCT aggregation

### Query 2: Revenue by Specialty and Month

| Schema | Execution Time | Requirements |
|--------|---------------|--------------|
| **Original (OLTP)** | 0.25 ms | Date functions, multiple joins, on-the-fly aggregation |
| **Star Schema (OLAP)** | 0.06 ms | Pre-aggregated metrics, simple `GROUP BY` |

**Improvement:** `0.25 / 0.06 ≈ 4.2× faster`

**Main reasons for speedup:**
- Pre-computed metrics
- Dimensional date table

---

## Final Reflection

This project demonstrated that **schema design matters more than indexing alone**.

By moving complexity into ETL and adopting a star schema:

- ✅ Queries became simpler
- ✅ Performance improved significantly
- ✅ Analytical intent became clearer

**The star schema transforms raw transactional data into a structure that supports fast, reliable, and scalable analytics — making it the correct choice for OLAP workloads.**