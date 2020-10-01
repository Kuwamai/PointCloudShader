import numpy as np
import bpy

for item in bpy.data.meshes:
    bpy.data.meshes.remove(item)

n_tris = 1024 ** 2

verts = []
tri = np.array([[0, 0, 0], [1, 1, 0], [0, 2, 0]])

for j in range(n_tris):
    for i in range(3):
        verts.append(tri[i] + np.array([0, 0, j]))
    
faces = []

for j in range(n_tris):
    for i in range(1):
        faces.append([i + j*3, i+1 + j*3, i+2 + j*3])


msh = bpy.data.meshes.new("trismesh")
msh.from_pydata(verts, [], faces)
obj = bpy.data.objects.new("tris", msh)
bpy.context.scene.collection.objects.link(obj)