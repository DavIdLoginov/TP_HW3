import csv
import random
import os
import sys

NUM_ROWS = 50


COLUMNS = ["animal", "age", "weight", "habitat"]

def generate_row():

    return {
        "animal": random.choice(["lion", "tiger", "bear", "wolf", "fox"]),
        "age": random.randint(1, 20),
        "weight": round(random.uniform(50.0, 500.0), 2),
        "habitat": random.choice(["forest", "savanna", "arctic"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

