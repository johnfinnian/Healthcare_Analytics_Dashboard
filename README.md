# 🏥📊 Healthcare Job Analytics Dashboard

![Dashboard Preview](/Healthcare_Project/Analytics_Dashboard/Images/Dashboard_GIF.gif)

## 🎯 1. Problem Statement

Healthcare job seekers face a **highly fragmented labor market**. Job postings are spread across platforms, salary information is inconsistent, compensation types vary (hourly vs yearly), and meaningful comparisons across roles, specialties, locations, and benefits are difficult to make.

This project was created to **centralize and structure healthcare job market data**, transforming a general, multi-industry job postings dataset into a **healthcare-focused analytical model**. The goal is to deliver **clear, comparable, and decision-ready insights** into healthcare salaries, hiring demand, and job quality.

---

## 🧱 2. Data & Modeling

The analytical foundation of this project is built by **extracting and structuring healthcare-specific information** from a non-specialized job postings dataset.

### 🧠 Domain Extraction

* 🏷️ Healthcare roles identified using curated keyword dictionaries applied to job titles
* 🏥 Clinical **roles, specialties, and units** inferred via priority-based matching
* 🔍 Only confidently classified healthcare postings propagated into the analytical layer

This approach reduces noise while preserving domain accuracy.

---

### 🗂️ Fact & Dimension Modeling

* 📦 Job postings structured into **analytics-ready fact and dimension tables**
* 🧩 Dedicated dimensions enable stable slicing by:

  * Role
  * Specialty
  * Unit
  * Location
  * Work type
  * Compensation type

This star-aligned structure ensures **metric integrity, scalability, and BI performance**.

---

### 💰 Salary Normalization

* 🔁 Hourly and yearly salaries standardized into a **single comparable framework**

* ⏱️ Hourly salaries converted using a full-time assumption:

  ```
  Hourly × 2080
  ```

* 📊 Normalized compensation enables **fair cross-role and cross-region analysis**

---

## 📊 3. Analytics & Visualization (Power BI)

The modeled data is presented through a **two-page interactive Power BI dashboard**, designed for both **high-level insight** and **deep exploration**.

🖥️ Built using **Power BI Desktop (free)**
📁 Delivered as a `.pbix` file for local interaction

### ▶️ Open Locally

* Download: `powerbi/healthcare Job Dashboard.pbix`
* Open with **Power BI Desktop**

---

### 🧹 Data Preparation (Power Query)

Lightweight semantic-layer preparation includes:

* 🧽 Removal of unused and non-analytical columns
* 🔄 Completion of missing yearly salaries using derived hourly equivalents

This ensures a **clean, performant analytical surface** without duplicating core modeling logic.

---

### 📐 Metrics Design (DAX)

All KPIs are implemented using **explicit analytical measures**, including:

* 📌 Total healthcare job count
* 📈 Median yearly salary
* ⏱️ Median hourly salary

This guarantees **correct aggregation behavior** across all slicers and drill-through interactions.

---

### 🧭 Dashboard Pages & Interactivity

#### 📍 Page 1 – Healthcare Job Overview

![Dashboard Page 1](/Healthcare_Project/Analytics_Dashboard/Images/Healthcare_Job_Dashboard_P1.png)

* 📊 High-level KPIs (job count & compensation)
* 🏆 Top-paying healthcare jobs with dynamic switching by:

  * Role
  * Specialty
  * Unit
* 🧩 Work type distribution
* 🎁 Job benefits analysis
* 🔗 Benefits act as a **global cross-page filter**



#### 📍 Page 2 – Salary & Hiring Demand


![Dashboard Page 2](/Healthcare_Project/Analytics_Dashboard/Images/Healthcare_Job_Dashboard_P2.png)


* ⚖️ Hourly vs yearly compensation comparison
* 📆 Hiring trends over time
* 🌍 Median salary by location
* 🏢 Company-level hiring demand

All visuals are **fully interactive**, with filters applied consistently across both pages.

---

## 🔍 4. Insights & Outcomes

### 📌 What the Analysis Reveals

* 💵 Compensation structures vary widely across healthcare roles, with some specialties (e.g. OB/GYN, Primary Care) favoring hourly pay
* 🎁 Roles offering comprehensive benefits tend to align with higher median compensation
* 📉 Hiring demand is uneven across specialties and locations, indicating **targeted workforce needs**
* 🌍 Location remains a strong driver of salary variance, even within identical roles

---

### 🎯 Why It Matters

This project demonstrates how **structured data modeling and disciplined analytics design** can transform fragmented job postings into **actionable labor market intelligence**.

* 👩‍⚕️ **For job seekers**: enables informed career decisions
* 📊 **For analysts & stakeholders**: showcases a scalable, reusable workforce analytics framework applicable beyond healthcare

