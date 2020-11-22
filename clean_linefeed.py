#Import Pandas library for reading and writing CSV
#Import Regular Expressions library
import pandas as pd
import re

#Input the CSV file from the location
df = pd.read_csv("test1.csv")

#Using regular expression library remove the spaces, new lines, tabs in both Body and Title columns
df["Body"] = df.Body.apply(lambda x: re.sub('\\n*\\t*\\r*\\s+',' ', x))
df["Title"] = df.Title.apply(lambda y: re.sub('\\n*\\t*\\r*\\s+',' ', y))

#Writing the data back to CSV files at the Output folder
df.to_csv("cleaned_test1.csv")
