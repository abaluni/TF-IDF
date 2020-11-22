import pandas as pd
read_result_data = pd.read_csv('CombinedResult.txt', sep="\t", names = ["words", "TF-IDF"])
read_result_data["words"] = read_result_data["words"].str.split(" ",n=1,expand=True)
final = read_result_data.sort_values(by = ["TF-IDF"], ascending=False).head(10)
print(final)