# Data Engineering Project Template

<info>

## Overview

The Campus Pulse project is an end-to-end data pipeline designed to measure activity totals by event type across different campus zones. By processing fresh streaming data, this pipeline allows decision-makers to respond to campus usage patterns and make informed operational choices as events happen.  

At a high level, the pipeline ingests raw JSON event data from a Kafka topic, uses Spark Structured Streaming to parse and save the data into a typed Bronze Parquet dataset, and then aggregates the numeric counts into a Gold JSON summary. The entire two-stage workflow is orchestrated incrementally using Apache Airflow. As an added data quality measure, a quarantine branch protects the trusted totals by routing invalid or unapproved zones into a separate dataset.

### Data Visualization

<img>

### Data Architecture

<img>

<info>

## Prerequisites

<directions>

- Prerequisite 1
- Prerequisite 2
- Prerequisite 3

## How to Run This Project

<steps>
ex:
1. Install x packages
2. Run command: `python x`
3. Make sure it's running properly by checking z
4. To clean up at the end, run script: `python cleanup.py`

## Lessons Learned

<info>

## Contact

<info>
