# ------------------------------
# Creating and manipulating graphs

import pandas as pd
import matplotlib as plt
from graph_tool.all import *

g = Graph()

ug = Graph(directed=False)

ug = Graph()
ug.set_directed(False)
assert ug.is_directed() == False

g1 = Graph()
g2 = Graph(g1)     

v1 = g.add_vertex()
v2 = g.add_vertex()
e = g.add_edge(v1, v2)

graph_draw(g, vertex_text=g.vertex_index, vertex_font_size=18, output_size=(200, 200))

print(v1.out_degree())
print(v1.in_degree())

print(e.source(), e.target())

vlist = g.add_vertex(10)

print(len(list(vlist)))

v = g.add_vertex()
print(g.vertex_index[v])
print(int(v))

g.remove_edge(e)
g.remove_vertex(v2) 

v = g.vertex(8)
g.add_edge(g.vertex(2), g.vertex(3))
e = g.edge(2, 3)
e = g.add_edge(g.vertex(0), g.vertex(1))

print(g.edge_index[e])

# ------------------------------
# Iterating over vertices and edges¶
for v in g.vertices():
    print(v)

for e in g.edges():
    print(e)

for v in g.vertices():
    for e in v.out_edges():
        print(e)

for w in v.out_neighbors():
    print(w)

# the edge and neighbors order always match
for e, w in zip(v.out_edges(), v.out_neighbors()):
    assert e.target() == w
```
 
## networkx

`py-networkx.py`

```{python}
#| eval: false
#| echo: true
#| code-fold: true

# ------------------------------
# networkx

import matplotlib.pyplot as plt
import networkx as nx

# exercise make a star
G = nx.Graph()

G.add_edges_from([(1, 2), (1, 3), (1,4), (1,5)])

# para gerar um frame limpo
plt.figure()

nx.draw(G, with_labels=True, font_weight='bold')

del(G)

# fazer via range
G1 = nx.Graph()

for i in range(1,6):
    G1.add_edge(0,i)

plt.figure()
nx.draw(G1, with_labels=True, font_weight='bold')

# whell
# para fazer uma rede direcional
g = nx.DiGraph()

for i in range(0,5):
    g.add_edge(5,i)
    g.add_edge(i, (i+1)%5)

plt.figure()
nx.draw(g, with_labels=True, font_weight='bold')

# modo alternativo, e fácil
g.add_cycle([0,1,2,3,4])

list(range(4, -1, -1))


# terceiro exemplo
g = nx.DiGraph()
g.add_cycle([0,1,2,3,4])
g.add_cycle([4,5,6,7,8])
# segundo caminho
# g.add_cycle([4,0,1,2,3,4,5,6,7,8,4])
plt.figure()
nx.draw(g, with_labels=True, font_weight='bold')

# quarto exemplo
g = nx.DiGraph()
g.add_cycle(range(5))
g.add_cycle(range(5,10))

for i in range(5):
    g.add_edge(i,i+5)

plt.figure()
nx.draw(g, with_labels=True, font_weight='bold')
```

## Cumminities

`py-cumminities.py`

```{python}
#| eval: false
#| echo: true
#| code-fold: true

from graph_tool import Graph
from graph_tool.draw import graph_draw
import pandas as pd
import numpy as np

# prepering test cases

# pentagon box

g_p = Graph(directed=False)

for i in range(5):
    g_p.add_edge(i, (i+1)%5)
    g_p.add_edge(i+5,(i+1)%5 + 5)
    g_p.add_edge(i,i+5)

from math import sin, cos, pi

pos_p = g_p.new_vertex_property('vector<double>')

for i in range(5):
    pos_p[i] = (sin(2*pi*(i/5)), cos(2*pi*(i/5)))
    pos_p[i+5] = (2*sin(2*pi*(i/5)), 2*cos(2*pi*(i/5)))

graph_draw(g_p, pos=pos_p)

# Nested squares
g_n = Graph(directed=False)

g_n.add_vertex(12)

side = 0
other = 1

for side in 0,2:
    for other in 1,3:
        for pair in (0,0), (0,1), (1,0), (1,2), (2,1), (2,2):
            index1, index2 = pair
            g_n.add_edge(side*3+index1, other*3+index2 )

graph_draw(g_n, vertex_tex=g_n.vertex_index, output="test.png")

# Facebook network

df = pd.read_csv('data/facebook/414.edges', sep=' ', names=['pr1', 'pr2'])

df = df.loc[df['pr1'] > df['pr2']]

df.head(5)

existing = df.unstack().unique()

new_labels = pd.Series(range(len(existing)), index=existing)

new_labels.head(5)

df['pr1'] = df['pr1'].map(new_labels)
df['pr2'] = df['pr2'].map(new_labels)

g_f = Graph(directed=False)
g_f.add_edge_list(df.values)

graph_draw(g_f, output="test.png")

def vector_difference(v1,v2):
    """
    return  the p
    """

a = np.array([1,0,0,1])
b = np.array([1,1,0,0])

vector_difference(a,b)

