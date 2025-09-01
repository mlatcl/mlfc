---
title: "Practical 2: Data and Python"
practical: 2
featured_image: slides/diagrams/datasets/football-database.png
abstract: >
  In this lab session we will explore the use of SQL and pandas with a football data base.
layout: practical
venue: 
author:
- family: Sendyka
  given: Radzim
time: "14:00"
date: 2025-09-02
transition: None
reveal: false
ipynb: true
postsdir: ../_practicals/ # Where compiled lecture HTML files go
---

\subsection{Data and Python}

\subsubsection{The Data}

\notes{We'll be using a partial EA FC 25 database for this workshop.}

\includefigure{\includepng{\diagramsDir/datasets/football-database}}{60%}{}

\notes{Find it in this GitHub repo: `radzim/football_data`}

\setupcode{import os, subprocess}

\code{repo_url = "https://github.com/radzim/football_data.git"
repo_dir = "football_data"

if not os.path.exists(repo_dir):
    subprocess.run(["git", "clone", repo_url], check=True)}

\notes{What we have:}

\code{os.listdir('football_data')}

\code{with open('football_data/models.csv') as f:
    print(f.read()[:394])}

\subsubsection{Introduction}

\notes{> If you wish to make an apple pie from scratch, you must first invent the universe. - *Carl Sagan*}

\notes{In Python we deal with information all the time. Every variable, every list is data stored and operated on.}

\code{text = 'hello world'
year = 2025
primes = [2, 3, 5, 7]}

\subsubsection{Memory}

\notes{
Something not many people think about, is what these actually are, under the hood.}

\code{True, '1', 1, 1.0}

\notes{Someone coming from a C++ background, would call the above `primitives` - expecting them to just be raw data in memory.}

\code{type(True), type('1'), type(1), type(1.0)}

\notes{Let's check this assumption - we would expect a bool to take `1 bit` or `1 byte`, int `1-4 bytes`, string `1-2 bytes`, and float `4 bytes`}

\setupcode{import sys}
\code{sys.getsizeof(True), sys.getsizeof('1'), sys.getsizeof(1), sys.getsizeof(1.0)}

\notes{The above numbers look nothing like our predictions - why is that?

Turns out, in Python, everything is actually an object. The simple `1` we saw above is represented in memory as:

```
ob_refcnt: 8 bytes
ob_type: 8 bytes
ob_size: 8 bytes (Py_ssize_t)
ob_digit: 4 bytes per 30 bits of int
```

The four types above are somewhat special in Python too, with a slightly different implementation than other objects. Other types and structures are built up in similar ways, but don't store actual values inside, but rather pointers to "primitives" objects.}

\notes{In the example above we needed 28 bytes to encode one bit of information. Native Python is insanely inefficient for operations on large data. This memory design also impacts other ways in which we accelerate data operations, namely caching.}

\subsubsection{Data Structures}

\notes{Hardware acceleration and memory layouts can only take us so far, usually some constant multiplier faster. For real step-changes in performance, we need to be mathematically clever about how we arrange our data.}

\subsubsection{Basic data structures}

\notes{```
list
tuple
set
dict
```}

\notes{By default, you would use a list for data. But other data types have their advantages too - set has very quick lookups, dict has quick lookups and stores values, and tuple is mutable and hashable (more on that later).}

\notes{Example where set massively outperforms a list:}

\setupcode{import time
import random}

\code{data_list = list(range(1000000))
queries = [random.randint(0, 2000000) for _ in range(1000)]

start_time = time.time()
hits = sum(1 for q in queries if q in data_list)
print(hits, time.time() - start_time)}

\code{data_set = set(range(1000000))

start_time = time.time()
hits = sum(1 for q in queries if q in data_set)
print(hits, time.time() - start_time)}

\subsubsection{Other useful data structures}

\subsubsection{Counter}

\setupcode{from collections import Counter}

\code{with open('football_data/leagueteamlinks.csv') as f:
  leagues = ([x.split(',')[12] for x in f.read().split('\n')[1:-1]]) # 13th column is leagueid
c = Counter(leagues)
print(c)}

\notes{*To be expanded as I get reminded of cool things.*}

\subsubsection{Mutability}

\code{l1, l2, l3 = ['apple'], ['banana'], ['cherry']
list_of_lists = [l1, l2, l3]
s1, s2, s3 = 'apple', 'banana', 'cherry'
list_of_strings = [s1, s2, s3]
print(list_of_lists, list_of_strings)}

\code{l3[0] = 'cranberry'
s3 = 'cranberry'
print(l3, s3)
print(list_of_lists)
print(list_of_strings)}

\notes{This will be particularly important when working with Pandas, when operations on rows will sometimes be in-place, and sometimes return new objects. You will get serious silent bugs if you're not careful.}

\subsubsection{Hashability}

\notes{
Python property, means roughly "can convert this to a number for lookups".}

\code{try:
    s = {'a', 'b', 'c', ['d', 'e']}
    print(s)
except TypeError as e:
    print(e)}

\code{{'a', 'b', 'c', ('d', 'e')}}

\code{dict_ = {1: 'one', 2: 'two', (3, 4): 'three or four'}
dict_[(3, 4)]}

\subsubsection{Spatial (and Temporal) locality}

\notes{![storage_pyramid.png](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABQAAAALQCAMAAAD4oy1kAAADAFBMVEX////+/v7+/v39/v7+/f39/f79/f38/f7+/Pv8/P78/Pz7/P7++/r7+/77+/v++fj+9vP4/P36+vv5+fr4+Pj49/f39/f1+fz29vf19ff09PTx+Prq9vjj9PPj9PL38/Lz8/P87+vy8vTx8fHw7+/u8fvu7u7u7e3q8Pfs7O7+6+Pv6+ro6/rn6/n8597w6ejo6ern5+fl6fnj5/jm5eXk5OT74Nb62cvk4+P32tr308n30Mf2y8H2yL3h8/Hf7/ne8O7Z7u7U7uvV6+ze5fjP6OrL5uvh4ujK4srh4ODg39/e3d3d4ffb4ffb4PfZ3vDL4MbL3cLK38Xb3N/b2trZ2NjX1tbS1+3Q1OTO0+fK0fPS0dHQ0NDPzc3MzMzLycnJ5uvG4+bB5uW55ODB4OK83uvE383B1+y62cPH0PLEzPHFydnIyMjJx8et3d6y2Nyv1+Gs1Nan0tanz8yq0LijzK6a2NKb0eSby9KYyMOL0c9+zMWSyeN4ysN1ycJ1ycFyyMBvx7/2w6/dxKzTwK3Sw7PIxsbFxcXEw8PDwsLCwcHAwMDBv7+/v7/zu7L1uZ71spTvsrHStaH0p4XjpZ7vnYXwmnK4w+60vN6ruO21uMu2s7OQxMWVwqChteOJvaikrtivrKyopaWinp6WpueTpOePoOWNn+WLneWKneWMneCJm+SHmuScmqGGwMqGmeSGmeJ9wOhtuOZmteRfseNcsOOEvLeCuoF2wLpiwbl1trl4s5Vbv7VSu7FbsONApetorKVdpp5VruVLqehVp7hkpXxZm1hRn5dKm5JVmVTtl33vlWvvk2jrjoXxj2Lzil3niIjshHHpgXX4gVHmgIDmgH/ygFPoeHnyekrub1LsaW7waTPvXybtUhTtSwqsk5OalpaXlJSWkpKUkJCRjY2El+OOi4+KhoaFgYGAk+F6j+J6j9+BfYB9eHh7dnZ5dHR4c3N3cnJ2i+F2cXFzid5uhd9Clo49k4o6kYg5kYhgedlXcddNaNQ/XdExUs4tTs3kFQt5AABF3UlEQVR42u3dC3BV9b3o8RXFYFMbnhImkDPJIFBozCQ8wytAIY4QxdYJ8Q7hqTCDTAQ9+JiIHgvtkVe34ISGYVBmePjo4BwLUphy9BzouSot0jJT7HEQHSxU8FZQQ4OooPf//6/HXmvvnWQn2Y//2uv7nbnNfrOTnn7u+v/W2msbBhERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERERUSoa+cgjBzK1RxYv5r9gImqRvwOZHgQSUeweOXAAAYkokC0WPjy/ePHtmdpiBfwj/BdNRDH9e+T2zE4SOJL/qokosgD4ZwrIf9VEFGMD8PbM73k2AYkoFoCPBADAxUwBiSgqsThcDIBEFMiCsQK+/XaGgEQEgEREAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAAiARASAAEhEAMh/2UQEgEREAEhEAAiARASAiW/xgTffeuvNA887Cpk9sti6V2RefORAct8JABJRagG8+8AfrN58WF7/Q7i35A0Py0vqntufl7cBIBFlCoB3vxkB3h/cAj4CgESUuQCa239vvWX+uNsL4B/+8AgAElGmArj4LWtDb7GS8HkTQPHj7ofVDW8CIBFlKoDPm5t5ci0sKTzgACh6U3kHgESUoQC+GTbtgHkxDKDCcTEAElGGAmht9qnV8CMiACSiwAAY5i7qFnM8yBKYiDIUwMWxATzw/PPPv6l2DB8AQCIKFoDhAwEXAyARZSiAd7cOIAdCE1HmAujeCRIF4FsH7uajcESUuQC+GQbw+bfeeutNawb48MMPL77bvPlh50hB+0AZACSijADwgDnosy++Gb1f2LVKth4BgESUEQCq7Tu11H3kD5GfBHEfK73YeSwAElGGAGieDOEt8S/8wZr1RQFoPeL5A2+FF8MASEQZAODit1x7fZ+PdWj03e5HJPXMrABIRCkF8PaH3/TqFn1gzMNhAd+8GwCJKHMAvP3uA2+ai9yHnQNjno94xPOKwLfeTOb6FwCJKPUASuEefnhxW494ZDFfikREGQigJgEgEQEgEREAEhEA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)}

\notes{Spatial locality means a program is likely to access nearby memory addresses soon after accessing one (e.g., iterating through an array). CPUs exploit both by loading data from RAM based on expected patterns of use.

Temporal locality benefits from keeping recently used data in cache, while spatial locality benefits from prefetching adjacent data to speed up sequential access.}

\notes{Let's test it out using a toy example - summing over 1m numbers, first in order, then randomly.}

\setupcode{import time}
\code{arr = [1]*10000000
indices = list(range(10000000))
start_time = time.time()
s = 0
for i in indices:
    s += arr[i]
print(s, time.time()-start_time)}

\setupcode{import random}
\code{arr = [1]*10000000
indices = list(range(10000000))
random.shuffle(indices)
start_time = time.time()
s = 0
for i in indices:
    s += arr[i]
print(s, time.time()-start_time)}

\notes{Mathematically speaking, these two operations are the same. Yet one takes about 5-10 times longer. This is exactly due to locality - it's much faster to read data that's right next to each other in memory.

Python's huge representations of data, and overused pointers, limit the capabilities of caching.}

\notes{It is a little bit silly to be optimising Python code, given how much inefficiency our choice of language brings on, but the considerations are still important, and translate to other systems you may build.}

\code{# temporal locality would be this - difference is quite small
# import time
# arr = [1]*10000000
# indices = [1]*10000000
# start_time = time.time()
# s = 0
# for i in indices:
#     s += arr[i]
# print(s, time.time()-start_time)}

\subsubsection{Numerical Computation `np`}

\setupcode{import numpy as np}

\notes{Probably all of you have written the above line hundreds of times. Let's recap why we do it.

NumPy is a Python library for fast numerical computing. It’s the foundation for many data science and machine learning libraries, including Pandas. Under the hood, NumPy is written largely in C to achieve high performance.}

\code{arr = [1]*10000000
indices = list(range(10000000))
start_time = time.time()
s = 0
for i in indices:
    s += arr[i]
print(s, time.time()-start_time)

np_arr = np.array(arr)
start_time = time.time()
s = np_arr.sum()
print(s, time.time()-start_time)}

\notes{NumPy is insanely fast. Use it everywhere you can!}

\subsubsection{# Cheat Sheet}

\notes{Create Arrays

```
a = np.array([1, 2, 3, 4, 5])
print(a)        # [1 2 3 4 5]
print(a.shape)  # (5,)
```

Multidimensional array:

```
b = np.array([[1, 2, 3],
              [4, 5, 6]])
print(b)
# [[1 2 3]
#  [4 5 6]]
print(b.shape)  # (2, 3)
```

Array Slicing

```
arr = np.array([10, 20, 30, 40, 50])
print(arr[1:4])   # [20 30 40]
print(arr[:3])    # [10 20 30]
print(arr[-2:])   # [40 50]
```

2D slicing:

```
b = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])
print(b[0:2, 1:3])
# [[2 3]
#  [5 6]]
```

Fancy Indexing & Boolean Masking

```
arr = np.array([5, 10, 15, 20, 25])
print(arr[[0, 2, 4]])    # [ 5 15 25]
print(arr[arr > 10])     # [15 20 25]
```

Vectorized Operations

```
x = np.array([1, 2, 3])
y = np.array([10, 20, 30])

print(x + y)    # [11 22 33]
print(x * y)    # [10 40 90]
print(x ** 2)   # [1 4 9]
```

Cumulative Sum & Other Reductions

```
arr = np.array([1, 2, 3, 4])
print(np.cumsum(arr))  # [ 1  3  6 10]
print(np.sum(arr))     # 10
print(np.prod(arr))    # 24
print(np.mean(arr))    # 2.5
```

Reshaping Arrays

```
arr = np.arange(1, 13)
reshaped = arr.reshape(3, 4)
print(reshaped)
# [[ 1  2  3  4]
#  [ 5  6  7  8]
#  [ 9 10 11 12]]
```

Useful Utilities

```
np.zeros((2, 3))     # [[0. 0. 0.]
                     #  [0. 0. 0.]]
np.ones((2, 3))      # [[1. 1. 1.]
                     #  [1. 1. 1.]]
np.arange(0, 10, 2)  # [0 2 4 6 8]
np.linspace(0, 1, 5) # [0.   0.25 0.5  0.75 1. ]
```}

\subsubsection{Structured Data `pd`}

\setupcode{import pandas as pd}

\notes{Again, probably all of you have written the above line hundreds of times. Let's recap why we do it.

Pandas is a library built on top of NumPy. It provides two main data structures: Series (1D) and DataFrame (2D) to handle structured data efficiently.

Pandas supports data cleaning, transformation, aggregation, merging, time-series analysis, and visualisation with minimal code. It integrates neatly with common libraries (`np`, `plt`, `sk`, ...).

It moves all numerical operations to NumPy, for great speed. It also has builtin support for tonnes of data formats, like `csv`, `xlsx`, `db` ... .

One of the most used tools in data science and machine learning.}

\subsubsection{Cheat Sheet}

\notes{Create DataFrames

```
df = pd.DataFrame({
    "playerid": [1, 2, 3, 4],
    "playername": ["Messi", "Ronaldo", "Mbappe", "Haaland"],
    "height": [170, 187, 178, 195]
})
print(df)
```

Read & Inspect Data

```
df = pd.read_csv("football_data/players.csv")
print(df.head())      # First 5 rows
print(df.info())      # Column info & types
print(df.describe())  # Stats summary for numeric columns
print(df.columns)     # List of column names
print(df.shape)       # (rows, columns)
```

Selecting Columns & Rows

```
df["playername"]                  # Single column - Series
df[["playername", "height"]]      # Multiple columns

df.iloc[0]          # by position
df.loc[0]           # by label
df.iloc[0:3]        # First 3 rows
df.loc[df["height"] > 185]   # Conditional filter
```

Sorting

```
df.sort_values("height", ascending=False).head()
```

Grouping & Aggregation

```
df.groupby("nationality")["height"].mean()
```

Merging & Joining

```
teamplayerlinks = pd.read_csv("football_data/teamplayerlinks.csv")
df_merged = df.merge(teamplayerlinks, on="playerid", how="left")
print(df_merged.head())
```

Missing Data

```
df.isna().sum()
df["height"].fillna(df["height"].mean())
df.dropna(subset=["height"])
```

Exporting Data

```
df.to_csv("players_clean.csv", index=False)
df.to_pickle("players_clean.pkl")
```

Avoiding mutability issues

```
df2 = df.copy()
```}

\subsubsection{Apply}

\code{df = pd.read_csv('football_data/players.csv')
start = time.time()
df["height_m"] = df["height"].map(lambda x: x / 100)
df["bmi"] = df.apply(lambda x: x["weight"]/x["height_m"]**2, axis=1)
print(time.time()-start)
df["bmi"]
# .map is very similar to `apply` for Series, slightly faster, accepts a dictionary too not just function}

\notes{Caveat: Apply is not vectorised, not very fast. Use vectorised operations where possible!}

\code{df = pd.read_csv('football_data/players.csv')
start = time.time()
df["height_m"] = df["height"]/100
df["bmi"] = df["weight"]/df["height_m"]**2
print(time.time()-start)
df["bmi"]}

\subsubsection{Pickles}

\notes{Pickles are a Python way of storing objects as files. Very useful, and usually faster than the naive way of doing things.}

\code{t = time.time()
df.to_csv("data.csv")
pd.read_csv("data.csv")
print("csv", time.time() - t)

t = time.time()
df.to_pickle("data.pkl")
pd.read_pickle("data.pkl")
print("pickle", time.time() - t)}

\notes{Pickle are very general and can store basically any Python object, even functions.}

\setupcode{import pickle}
\code{def greet(name): return f"Hello, {name}!"
pickle.dump(greet, open("func.pkl", "wb"))
f = pickle.load(open("func.pkl", "rb"))
print(f("World"))}

\subsubsection{Databases `sql`}

\notes{You should already know this from previous courses, but here's a little recap.}

\subsubsection{Cheat Sheet}

\notes{Create Tables & Insert Data

```
CREATE TABLE players (
    playerid INTEGER PRIMARY KEY,
    playername TEXT,
    height INTEGER
);
INSERT INTO players (playerid, playername, height) VALUES
(1, 'Messi', 170),
(2, 'Ronaldo', 187),
(3, 'Mbappe', 178),
(4, 'Haaland', 195);
```

Read & Inspect Data

```
SELECT * FROM players LIMIT 5;
SELECT COUNT(*) FROM players;
PRAGMA table_info(players);
SELECT name FROM sqlite_master WHERE type='table';
```

Selecting Columns & Rows

```
SELECT playername FROM players;
SELECT playername, height FROM players;
SELECT * FROM players WHERE playerid = 1;
SELECT * FROM players WHERE height > 185;
SELECT * FROM players LIMIT 3;
```

Sorting

```
SELECT * FROM players
ORDER BY height DESC
LIMIT 5;
```

Grouping & Aggregation

```
SELECT nationality, AVG(height) AS avg_height
FROM players
GROUP BY nationality;

SELECT teamid, COUNT(*) AS num_players
FROM teamplayerlinks
GROUP BY teamid;
```

Joining Tables

```
SELECT p.playerid, p.playername, p.height, t.teamid
FROM players AS p
LEFT JOIN teamplayerlinks AS t
    ON p.playerid = t.playerid
LIMIT 5;
```

Handling Missing / NULL Values

```
SELECT * FROM players WHERE height IS NULL;
UPDATE players
SET height = (SELECT AVG(height) FROM players)
WHERE height IS NULL;
DELETE FROM players WHERE height IS NULL;
```

Exporting Data (from CLI)

```
.headers on
.mode csv
.output players_clean.csv
SELECT * FROM players;
.output stdout
```

Nested
```
SELECT * FROM players
WHERE playerid IN (
  SELECT playerid FROM teamplayerlinks WHERE teamid = 10
);
```

Indexing and Query Planning

```
CREATE INDEX idx_players_height ON players(height);
CREATE INDEX idx_tpl_player ON teamplayerlinks(playerid);
CREATE INDEX idx_tpl_team_player ON teamplayerlinks(teamid, playerid);
```}

\subsubsection{SQL in Python}

\notes{
Just a reminder, you can use SQL inside Python very neatly. It's the recommended practice, and leaves you compatible with other systems using your database.}

\code{import sqlite3
import pandas as pd}

\code{df = pd.read_csv("football_data/players.csv")
conn = sqlite3.connect("example.db")
cur = conn.cursor()

cur.execute("DROP TABLE IF EXISTS players")
df.to_sql("players", conn, if_exists="replace", index=False)

for row in cur.execute("SELECT playerid FROM players WHERE potential > 92"):
    print(row)

cur.close()
conn.close()}

\subsubsection{Credential Storage}

\notes{Many times when working with APIs and non-public data, you will use passwords, usernames, keys. It's commonplace to just leave them in the notebook, but that's a horrible idea, for obvious reasons.

Better way is to set the values as environment variables. Ideally you would set them in your system, like:

```
set API_KEY=your_api_key_here
set DB_PASSWORD=your_db_password
```

Or in Python:}

\code{os.environ["API_KEY"] = "my_secret_key"
os.environ["DB_PASSWORD"] = "super_secret"
# remember to remove this from anything someone else might have access to,
# including autosave and version control!

print(os.getenv("API_KEY"))
print(os.getenv("DB_PASSWORD"))}

\notes{The above might be very annoying when working in a notebook where we keep resetting runtime, with you having to re-type the environment variables again and again.

A middle-ground between security and usability.}

\code{import json}

\code{secrets = {
    "API_KEY": "my_secret_key", # remember to remove, or ideally edit in file only
    "DB_PASSWORD": "super_secret" # remember to remove, or ideally edit in file only
}
with open("secrets.json", "w") as f:
    json.dump(secrets, f, indent=4)}

\code{with open("secrets.json") as f:
    loaded = json.load(f)

print("API_KEY:", loaded["API_KEY"])
print("DB_PASSWORD:", loaded["DB_PASSWORD"])
# remember to not have outputs like this in anything visible to others}

\notes{`.env` files and the `dotenv` library is also a less intuitive but more professional way to do it.}

\notes{You can also use `input`
```
api_key = input("Enter API key: ")
db_password = input("Enter DB password: ")
```
or IPython interact
```
import ipywidgets as w
from IPython.display import display

api_key = w.Text(description="API Key")
db_password = w.Password(description="Password")

display(api_key, db_password)
# api_key.value
# db_password.value
```
as other means of not leaving passwords in your notebook.}

\subsubsection{Indexing}

\subsubsection{Background}

\notes{A database is not a special piece of hardware, it can live on any medium. It's just an organized collection of data stored in a structured way, allowing efficient storage, retrieval, and management of information.

What we usually mean by a database is just a standard digital implementation of such a system.}

\includefigure{\includejpg{\diagramsDir/slides/datasets/british-geological-survey}}{50%}{Photo by British Geological Survey}

\notes{What makes databases special is the structure - the information is conveyed in a way that allows for complicated lookup operations to be completed quickly.}

\subsubsection{Physical Index}

\notes{
This is what you would usually mean when talking about simple indexes. This is how dictionaries, encyclopedias work. Many datasets have built-in physical indices, even if not explicitly defined.}

\notes{In our example, we can see that some tables are sorted by an important column - eg. `models.csv` is sorted by `playerid`. We can use this to our advantage when searching through it.

Without abstracting away to library search functions, let's follow through on what it might look like to find who is player `188545`.}

\setupcode{import pandas as pd}
\code{models_df = pd.read_csv('football_data/models.csv')

start = time.time()
search_id = 188545
for i in range(len(models_df)):
    if models_df.iloc[i]['playerid'] == search_id:
        print(models_df.iloc[i]['playername'])
print(time.time()-start)}

\notes{Now, let's assume the table is sorted on `playerid`. This allows us to search through the data cleverly, only checking a couple values.}

\code{models_df = pd.read_csv('football_data/models.csv')
start = time.time()
search_id = 188545
left, right = 0, len(models_df) - 1
while left <= right:
    mid = (left + right) // 2
    val = models_df.iloc[mid]['playerid']
    if val == search_id:
        print(models_df.iloc[mid]['playername'])
        break
    elif val < search_id:
        left = mid + 1
    else:
        right = mid - 1
print(time.time() - start)}

\notes{The above is not *truly* an index, as many `playerids` are missing, so we can't just look up the 188545th row instantly - we still used `O(log(n))` lookups. Proper indexing will allow us to do that.}

\code{models_df_indexed = pd.read_csv('football_data/models.csv').set_index('playerid')
start = time.time()
search_id = 188545
print(models_df_indexed.loc[search_id]['playername'])
print(time.time() - start)}

\subsubsection{Logical index}

\notes{A logical index is an external structure that we build next to our database. Pandas doesn't really allow that (limit 1 index), but you can use as many as you want in SQL.}

\notes{Let's demonstrate a home-made logical index on the same dataframe, where we index the player names, for a quick `playername -> playerid` search.}

\code{name_to_index = {name: i for i, name in enumerate(models_df_indexed['playername'])}
start = time.time()
models_df_indexed.iloc[name_to_index['Robert Lewandowski']]
print(time.time() - start)}

\notes{Databases will do that under the hood for you, just use SQL like:

```
CREATE INDEX index_name
ON table_name (column1, column2, ...);
```}

\subsubsection{Practical example}

\notes{Let's load in the `players`, `teams`, and `teamplayerlinks` tables we have, to a new database.}

\code{db_path = "football.db"
players_csv = "football_data/players.csv"
teams_csv = "football_data/teams.csv"
teamlinks_csv = "football_data/teamplayerlinks.csv"

conn = sqlite3.connect(db_path)

players_df = pd.read_csv(players_csv)
teams_df = pd.read_csv(teams_csv)
teamlinks_df = pd.read_csv(teamlinks_csv)

players_df.to_sql("players", conn, if_exists="replace", index=False)
teams_df.to_sql("teams", conn, if_exists="replace", index=False)
teamlinks_df.to_sql("teamplayerlinks", conn, if_exists="replace", index=False)

cur = conn.cursor()}

\code{query = """
SELECT p.overallrating
FROM players p
JOIN teamplayerlinks tpl ON p.playerid = tpl.playerid
JOIN teams t ON tpl.teamid = t.teamid
WHERE t.teamname = "Sheffield Utd";
"""

start = time.time()
cur.execute(query)
results = [row[0] for row in cur.fetchall()]
print(time.time() - start)

print(results)}

\notes{Now, let's make indices on `teamid` and `playerid` (others optional).}

\code{queries = [
    "CREATE INDEX IF NOT EXISTS idx_teams_teamname ON teams(teamname);",
    "CREATE INDEX IF NOT EXISTS idx_tpl_teamid ON teamplayerlinks(teamid);",
    "CREATE INDEX IF NOT EXISTS idx_tpl_playerid ON teamplayerlinks(playerid);",
    "CREATE INDEX IF NOT EXISTS idx_players_playerid ON players(playerid);"
]

for q in queries:
    cur.execute(q)}

\notes{And now, let's call the same query we did before. This should be massively faster.}

\code{query = """
SELECT p.overallrating
FROM players p
JOIN teamplayerlinks tpl ON p.playerid = tpl.playerid
JOIN teams t ON tpl.teamid = t.teamid
WHERE t.teamname = "Sheffield Utd";
"""

start = time.time()
cur.execute(query)
results = [row[0] for row in cur.fetchall()]
print(time.time() - start)

print(results)}

\subsubsection{Multi-column Index}

\notes{Sometimes you will be repetitively looking for data that fits multiple criteria at once. The most common example would be coordinates - latitude and longitude.

Imagine if, when looking for houses within 10km of Mt Kenya, you had to search through all the houses on earth one by one. That would be very inefficient. But single indices on latitude and longitude would still not help you that much - there are millions of houses within 10km of the equator, in Kongo, Ecuador, Indonesia - you would first narrow it down to all of those, and then have to search through them again, with respect to longitude.}

\includefigure{\includewebp{\diagramsDir/datasets/world-map-continents-oceans}}{80%}{}

\notes{That's why we have multi-column indices. The simplest example would be a map - given a detailed map, I can easily find the area I'm looking for data in.}

\notes{Using our `players` example, let's look for players who are both tall and strong.}

\code{start = time.time()
query = """
SELECT playerid, height, strength
FROM players
WHERE height > 190 AND strength > 90
"""
cur.execute(query)
results = cur.fetchall()
print(time.time() - start)

print(len(results))}

\notes{Now, if we set individual indices, this becomes much faster:}

\code{queries = [
    "CREATE INDEX IF NOT EXISTS idx_players_height ON players(height);",
    "CREATE INDEX IF NOT EXISTS idx_players_strength ON players(strength);",
]

for q in queries:
    cur.execute(q)}

\code{start = time.time()
query = """
SELECT playerid, height, strength
FROM players
WHERE height > 190 AND strength > 90
"""
cur.execute(query)
results = cur.fetchall()
print(time.time() - start)

print(len(results))}

\code{queries = [
"CREATE INDEX idx_players_height_strength ON players(height, strength);"
]

for q in queries:
    cur.execute(q)}

\code{start = time.time()
query = """
SELECT playerid, height, strength
FROM players
WHERE height > 190 AND strength > 90
"""
cur.execute(query)
results = cur.fetchall()
print(time.time() - start)

print(len(results))}

\notes{Looks like this is not actually that good of an example - performance didn't change much, maybe actually got worse. Don't be alarmed, this is just because our table is quite small (27000 rows), and traversing the indices takes more time than just reading the table. The difference will be huge on larger datasets though, so remember about these!}

\notes{Remember to close the connection}

\code{conn.close()}

\subsubsection{Pandas MultiIndex}

\notes{Despite similar name, and pertaining to similar things, a Pandas MultiIndex is not what we described above. It's not an index where you can search over multiple columns, but rather a *hierarchical* index, where you're looking over multiple columns as if they were one key.}

\code{tpl_df = pd.read_csv('football_data/teamplayerlinks.csv')
tpl_df = tpl_df.set_index(['teamid', 'jerseynumber'])
tpl_df = tpl_df.sort_index()
tpl_df.tail()}

\notes{Then, we can neatly look up the stats of the player who plays with `#9` for team `241 - FC Barcelona`.}

\code{tpl_df.loc[241, 9]}

\notes{This falls in the *syntactic sugar* category of things, not really improving performace, just allowing for neat code.}

\subsubsection{Plotting `plt`}

\setupcode{import matplotlib.pyplot as plt}

\notes{Matplotlib is a plotting library, used by nearly everyone. Inspired by matlab.

Support for many types of plots, lot of flexibility in options, but also short minimal required code.}

\code{df = pd.read_csv("football_data/players.csv")

plt.scatter(df['acceleration'], df['sprintspeed'])
plt.show()}

\notes{Lot's of things to improve on, even in such a simple chart. Remember that at the end, half of your reader's attention will go to charts. You should give some thought to make sure they show what you want them to, clearly and legibly.}

\code{plt.figure(figsize=(6, 6))
plt.scatter(df['acceleration'], df['sprintspeed'], alpha=0.05, color='blue', edgecolors='none')

plt.xlabel("Acceleration")
plt.ylabel("Sprint Speed")
plt.title("Acceleration vs Sprint Speed")
plt.grid(True)
plt.show()}

\subsubsection{Cheat Sheet}

\notes{Basic Line Plot

```
import matplotlib.pyplot as plt

x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

plt.plot(x, y)
plt.show()
```

Scatter Plot

```
plt.scatter(df['acceleration'], df['sprintspeed'], alpha=0.2)
plt.xlabel("Acceleration")
plt.ylabel("Sprint Speed")
plt.title("Acceleration vs Sprint Speed")
plt.show()
```

Bar Chart

```
categories = ['A', 'B', 'C']
values = [4, 7, 3]

plt.bar(categories, values)
plt.xlabel("Category")
plt.ylabel("Value")
plt.title("Bar Chart Example")
plt.show()
```

Histogram

```
data = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

plt.hist(data, bins=4, edgecolor='black')
plt.xlabel("Bins")
plt.ylabel("Frequency")
plt.title("Histogram Example")
plt.show()
```

Pie Chart

```
sizes = [30, 40, 20, 10]
labels = ['A', 'B', 'C', 'D']

plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=90)
plt.title("Pie Chart Example")
plt.show()
```

Adding Labels, Title, and Legend

```
x = [1, 2, 3]
y1 = [2, 4, 6]
y2 = [1, 3, 5]

plt.plot(x, y1, label="Line 1")
plt.plot(x, y2, label="Line 2")
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Multiple Lines Example")
plt.legend()
plt.show()
```

Figure Size and Style

```
plt.figure(figsize=(8, 5))
plt.style.use('seaborn-v0_8')

x = [1, 2, 3, 4]
y = [10, 20, 25, 30]

plt.plot(x, y, marker='o')
plt.title("Styled Plot")
plt.show()
```

Subplots

```
x = [1, 2, 3, 4]
y1 = [1, 4, 9, 16]
y2 = [1, 2, 3, 4]

plt.subplot(1, 2, 1)
plt.plot(x, y1)
plt.title("Plot 1")

plt.subplot(1, 2, 2)
plt.plot(x, y2)
plt.title("Plot 2")

plt.tight_layout()
plt.show()
```

Saving Figures

```
plt.plot([1, 2, 3], [4, 5, 6])
plt.title("Save Example")
plt.savefig("plot.png", dpi=300)
```

Common Utilities

```
plt.grid(True)          # Show gridlines
plt.xlim(0, 10)         # Set x-axis limits
plt.ylim(0, 20)         # Set y-axis limits
plt.axhline(5, color='r', linestyle='--')  # Horizontal line
plt.axvline(2, color='g', linestyle=':')   # Vertical line
```}

\subsubsection{Alternatives}

\notes{What I outlined are the commonly used libraries/methods in data science. Each have alternatives, each with proponents and opponents.

For best reusability, stick to standards where it doesn't matter, and if you do stray, pick the second or third most well known option, don't force your reader to learn an obscure framework they'll never see again.}

\subsubsection{Seaborn}

\code{# !pip install seaborn}

\setupcode{import seaborn as sns}

\code{sns.set_theme(style="whitegrid")

sns.relplot(
    data=df,
    x="acceleration",
    y="sprintspeed",
    kind="scatter",
    alpha=0.05,
    height=6,
    aspect=1
)}

\subsubsection{Parquet}

\notes{Parquet is an alternative to pickle for storing data, but it's designed specifically for tabular data. Many good built-in features like compression. Comes pre-installed with}

\setupcode{#!pip install pyarrow
#install backend for pandas to use}

\code{df = pd.read_csv('football_data/teamplayerlinks.csv')

t = time.time()
df.to_pickle("data.pkl")
pd.read_pickle("data.pkl")
print("pickle", os.path.getsize("data.pkl"))

t = time.time()
df.to_parquet("data.parquet", engine="pyarrow")
pd.read_parquet("data.parquet", engine="pyarrow")
print("parquet", os.path.getsize("data.parquet"))}

\notes{Works across languages, enforces schema, columnar storage, partial reads.

Caveat: only tabular data, and can be slower.}

\code{data = pd.DataFrame({"a": [1, 2, 'three']})

data.to_pickle("data.pickle")
try:
    data.to_parquet("data.parquet")
except Exception as e:
    print(e)}

\code{t = time.time()
df.to_pickle("data.pkl")
pd.read_pickle("data.pkl")
print("pickle", time.time() - t)

t = time.time()
df.to_parquet("data.parquet", engine="pyarrow")
pd.read_parquet("data.parquet", engine="pyarrow")
print("parquet", time.time() - t)}

\subsubsection{Polars}

\notes{An alternative to Pandas with a Rust backend. Faster on very big datasets, but not a big improvement on small ones. Slightly different syntax.}

\code{# !pip install polars}

\code{# import polars as pl

# df_pd = pd.read_csv("football_data/players.csv")
# print(len(df_pd[df_pd["overallrating"] > 90]))

# df_pl = pl.read_csv("football_data/players.csv")
# print(len(df_pl.filter(pl.col("overallrating") > 90)))}

\subsubsection{Online Databases}

\notes{An example would be Amazon AWS Relational Database (RDS)}

\code{# import pandas as pd, sqlalchemy as sa

# df = pd.read_csv("football_data/players.csv")

# DATABASE_URL = "postgresql+psycopg2://USER:PASSWORD@HOST:5432/DBNAME"
# engine = sa.create_engine(DATABASE_URL)

# with engine.begin() as conn:
#     conn.exec_driver_sql("DROP TABLE IF EXISTS players")
#     df.to_sql("players", conn, if_exists="replace", index=False)
#     for row in conn.exec_driver_sql("SELECT playerid FROM players WHERE potential > 92"):
#         print(row)}

\subsubsection{Online Storage}

\notes{For example Amazon AWS Simple Storage Service (S3)}

\code{# import boto3

# bucket = "your-bucket-name"
# key = "players.csv"
# filename = "players.csv"

# s3 = boto3.client("s3")

# # Upload file
# s3.upload_file(filename, bucket, key)
# print("Uploaded", filename, "to s3://"+bucket+"/"+key)

# # Download file
# s3.download_file(bucket, key, "players_downloaded.csv")
# print("Downloaded to players_downloaded.csv")}

\subsubsection{Exercises}

\subsubsection{Exercise 1: Make a database}

\subsubsection{1.1 Create a full SQL database from the following tables:}

\notes{- players.csv
- teams.csv
- leagues.csv
- countries.csv
- teamplayerlinks.csv
- leagueteamlinks.csv
- models.csv}

\code{# TODO}

\subsubsection{1.2 Make the appropriate indices:}

\notes{- playerid
- teamid
- leagueid}

\code{# TODO}

\subsubsection{Exercise 2: Answer questions}

\notes{Use Pandas and SQL. Use the one that will be faster, neater, to solve the following questions.

Make sure your code is correct and reasonably efficient. use SQL for at least one of them. Compare results and runtimes with other students.}

\subsubsection{2.1 Who are the best penalty takers in the `Premier League`?}

\code{# TODO}

\subsubsection{2.2 Which team has the biggest difference between the fastest and slowest player?}

\code{# TODO}

\subsubsection{2.3 Which team has players of the most different nationalities?}

\code{# TODO}

\subsubsection{2.4 Who is the player from `Kenya` who plays in `Poland`?}

\code{# TODO}

\subsubsection{2.5 Plot the relationship between age and average overall and potential ratings.}

\code{# TODO}

\subsubsection{2.6 (extended) What is the most common tag (initials+number, like `CR7`, `LM10`) among the 1000 highest rated players?}

\code{# TODO}

\subsubsection{2.7 (extended) If in 5 years players who are now over 30 will retire, and others will reach half of their potential, which team will have the best starting 11?}

\code{# TODO}

\subsubsection{Exercise 3: Debug}

\subsubsection{3.1 What are the best ratings for each team?}

\notes{We would like to query the above about a couple teams. But it's taking us way too long.}

\code{teams = pd.read_csv('football_data/teams.csv')
players = pd.read_csv('football_data/players.csv')
tp_links = pd.read_csv('football_data/teamplayerlinks.csv')

conn = sqlite3.connect("football31.db")
cur = conn.cursor()
teams.to_sql("teams", conn, if_exists="replace", index=False)
players.to_sql("players", conn, if_exists="replace", index=False)
tp_links.to_sql("teamplayerlinks", conn, if_exists="replace", index=False)

teams_list = teams['teamname'].unique()[1:104] #skip 1 bc that's the default value}

\code{# todo
# the query below should take about 0.1s}

\code{q = """
SELECT
  t.teamid,
  t.teamname,
  MAX(p.overallrating) AS max_overallrating
FROM teamplayerlinks AS l
JOIN players AS p ON p.playerid = l.playerid
JOIN teams   AS t ON t.teamid   = l.teamid
WHERE t.teamid = (
    SELECT MIN(teamid)
    FROM teams
    WHERE teamname = ?
)
GROUP BY t.teamid, t.teamname;
"""

start = time.time()

results = []
for team in teams_list:
    df_team = pd.read_sql_query(q, conn, params=[team])
    results.append(df_team)

df = pd.concat(results, ignore_index=True)

print(time.time() - start)
print(df)}

\code{conn.close()}

\subsubsection{3.2 Which period of 365 days had the most footballers born?}

\notes{Improve on the code below. It should be able to run in a fraction of a second. *hint: cumulative sum*}

\code{players = pd.read_csv('football_data/players.csv')
start = time.time()
players = players[players['birthdate']>0]
counts = []
for i in range(min(players['birthdate']), max(players['birthdate'])-365):
    bigger = players['birthdate'] >= i
    smaller = players['birthdate'] < i+365
    counts.append(len(players[bigger*smaller]))
print(np.argmax(counts)+min(players['birthdate']))
print(time.time()-start)}

\subsubsection{3.3 Average height in metres by nationality}

\notes{The below code is supposed to calculate the average height of players from different countries. It has a subtle logical bug that makes all the returned heights tiny - find and describe it.}

\code{players = pd.read_csv('football_data/players.csv')
countries = pd.read_csv('football_data/countries.csv')
players = players[players['playerid']>0]
nationalities = players['nationality'].unique()
mean_heights_m = {}
for nationality in nationalities:
    players_temp = players
    players_temp['height'] = players_temp['height']/100
    mean_value = players_temp[players_temp['nationality'] == nationality]['height'].mean()
    mean_heights_m[nationality] = mean_value
countries['height'] = countries['countryid'].map(mean_heights_m)
countries}

\code{#TODO describe the bug, and the minimal fix}

\notes{Other than the minimal fix, the code is in general overcomplicated. Now, rewrite the code - it can probably be much faster and half the lines. *hint: use groupby*}

\code{#TODO}

\subsubsection{3.4 Nested select}

\notes{We will be looking for the numbers of players from each country wearing numbers `1-11`.

The below code joins the two dataframes, and then selects based on the criteria. Change it slightly, so it can run about 10 times faster.}

\code{countries = pd.read_csv('football_data/countries.csv')
players = pd.read_csv('football_data/players.csv')
players = players[players['playerid']>1]
tp_links = pd.read_csv('football_data/teamplayerlinks.csv')
tp_links = tp_links[tp_links['playerid']>1]

start = time.time()
counts = {}
for i, (countryid, countryname) in countries.iterrows(): # this is inefficient but leave it, look for improvements within the loop - also don't move anything out of the loop
    joined_df = players.merge(tp_links, on='playerid', how='inner')
    joined_df = joined_df[(joined_df['nationality']==countryid)&(joined_df['jerseynumber']<=11)]
    counts[countryname] = len(joined_df)
print(time.time() - start)
counts['Kenya']}

\notes{If we try to recreate the same speed improvement by reordering the equivalent SQL query:

```
SELECT COUNT(*) AS cnt
FROM players AS p
JOIN teamplayerlinks AS l
    ON p.playerid = l.playerid
WHERE p.playerid > 1
  AND l.playerid > 1
  AND p.nationality = ?
  AND l.jerseynumber <= 11;
```

For example into something like this:

```
SELECT COUNT(*) AS cnt
FROM (
    SELECT playerid
    FROM players
    WHERE playerid > 1
      AND nationality = ?
) AS p
JOIN (
    SELECT playerid
    FROM teamplayerlinks
    WHERE playerid > 1
      AND jerseynumber <= 11
) AS l
ON p.playerid = l.playerid;
```

We don't actually see any improvement. This is because SQLite does this optimisation for us under the hood!}

\notes{End of Practical 1¾
```
 _______  __   __  _______  __    _  ___   _  _______  __
|       ||  | |  ||   _   ||  |  | ||   | | ||       ||  |
|_     _||  |_|  ||  |_|  ||   |_| ||   |_| ||  _____||  |
  |   |  |       ||       ||       ||      _|| |_____ |  |
  |   |  |       ||       ||  _    ||     |_ |_____  ||__|
  |   |  |   _   ||   _   || | |   ||    _  | _____| | __
  |___|  |__| |__||__| |__||_|  |__||___| |_||_______||__|
```}

\thanks
