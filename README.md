# Relational Data Normalization & Open-Source Curation

Transforms raw flat-file CSV datasets (such as global restaurant and commerce records) into fully normalized, third normal form (3NF) relational database structures. Establishes clean primary and foreign key mapping dependencies, validates schema integrity, and stages structured, ready-to-query datasets for open-source publication and advanced analytics.


# SQL Datasets

# 1. Superstore Dataset

The original Superstore dataset, while invaluable for analysis, is a single massive table where transaction details are mixed with customer profiles, product catalogs, and deep geographic hierarchy information. This leads to massive data redundancy and limits its utility for teaching or testing production-grade data engineering practices. This project solves those issues by decomposing the data into distinct, normalized tables connected by precise keys.

Kaggle Link: https://www.kaggle.com/datasets/kartikanidhi/superstore-database