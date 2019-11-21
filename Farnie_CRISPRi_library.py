# Done in Jupyter Lab, exported to HTML

!date
!pwd
!conda env list | grep '*'
!python --version

# import

import pandas as pd
import numpy as np

# read in Sanger gene list
sanger = pd.read_csv("sanger_panel.csv", header=None)
# rename column
sanger.columns = ["gene"]
# check how many rows (therefore how many genes)

print("Number of genes in Sanger list") 
sanger.shape

# read in E3 ubiquitin ligase list
ub = pd.read_csv("e3_ub_ligases.csv")

print("Number of genes in E3 ubiquitin ligase family") 
ub.shape

# read in SLC family list
slc = pd.read_csv("slc_list.csv")

print("Number of genes in SLC family") 
slc.shape

# read in HDAC family list
hdac = pd.read_csv("hdac_genes.csv", header=None)
hdac.columns = ["gene"]

print("Number of genes in HDAC family") 
hdac.shape

# read in NUDIX family list
nudix = pd.read_csv("nudix_genes.csv")

print("Number of genes in NUDIX family") 
nudix.shape

# create APOBEC list
apobec_genes = [["AID"], ["APOBEC2"], ["APOBEC1"], ["APOBEC3A"], ["APOBEC3B"], ["APOBEC3C"], ["APOBEC3D"], 
                ["APOBEC3F"],["APOBEC3G"], ["APOBEC3H"], ["APOBEC4"]]
apobec = pd.DataFrame(apobec_genes, columns=["gene"])

print("Number of genes in APOBEC family") 
apobec.shape

# create list of positive control genes

pos_genes = [["CTNNB1"], ["PTK2"], ["NOTCH1"], ["NOTCH4"]]
pos = pd.DataFrame(pos_genes, columns=["gene"])

print("Number of positive control genes") 
pos.shape

# combine gene families together to make one big pandas dataframe
all_families = ub.append(slc)
all_families = all_families.append(hdac)
all_families = all_families.append(nudix)
all_families = all_families.append(apobec)

len(all_families)

# convert to lists
sanger_list = sanger.values.tolist()

genes_list = all_families.values.tolist()
len(genes_list)

# check genes in genes_list and return if not found in sanger_list

def Diff(list1, list2):
    list_diff = [i for i in list2 if i not in list1]
    return list_diff

missing_genes_list = Diff(sanger_list, genes_list)
len(missing_genes_list)

# change list of missing genes into a dataframe

missing_genes = pd.DataFrame(missing_genes_list)
missing_genes.columns = ["gene"]
missing_genes.shape

# add onto end of Sanger dataframe to create new dataframe

farnie = sanger.append(missing_genes)
farnie.shape

# export farnie as csv file
farnie.to_csv("farnie_library.csv")
