-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Working with Higher-Order Functions

-- COMMAND ----------

SELECT * FROM enrollments

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Filter Function

-- COMMAND ----------

SELECT
enroll_id,
courses,
FILTER (courses, course -> course.discount_percent >= 60) AS highly_discounted_courses
FROM enrollments

-- COMMAND ----------

SELECT enroll_id, highly_discounted_courses
FROM (
 SELECT
   enroll_id,
   courses,
   FILTER (courses, course -> course.discount_percent >= 60) AS highly_discounted_courses
 FROM enrollments)
WHERE size(highly_discounted_courses) > 0;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ## Transform Function

-- COMMAND ----------

SELECT
  enroll_id,
  courses,
  TRANSFORM (courses, course -> ROUND(course.subtotal * 1.2, 2) ) AS courses_after_tax
FROM enrollments;

-- COMMAND ----------

SELECT
  enroll_id,
  courses,
  TRANSFORM (
    courses,
    course -> (course.course_id,
              ROUND(course.subtotal * 1.2, 2) AS subtotal_with_tax)
  ) AS courses_after_tax
FROM enrollments;
