import requests
import hashlib
import os

# paper_query = requests.get("https://papermc.io/api/v2/projects/paper").json()
builds_query = requests.get("https://papermc.io/api/v2/projects/paper/versions/1.18.1").json()
latest_build = builds_query["builds"][len(builds_query["builds"]) - 1]
info_query = requests.get("https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/" + str(latest_build)).json()
filename = info_query["downloads"]["application"]["name"]
checksum = info_query["downloads"]["application"]["sha256"]

# Check if downloaded versions of paperclip.jar already exists
if os.path.isfile("paperclip.jar") == True:
    print("paperclip.jar already exists, removing...")
    os.remove("paperclip.jar")

# Download and write to file
paper_download = requests.get("https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/" + str(latest_build) + "/downloads/" + filename)
print("Downloading " + filename + "...")
file = open("paperclip.jar", "wb")
file.write(paper_download.content)
print("Downloaded to paperclip.jar")
file.close()

# Check SHA-256 hash
file = open("paperclip.jar", "rb")
if hashlib.sha256(file.read()).hexdigest() == checksum:
    print("SHA-256 checksum match!")
else:
    print("SHA-256 checksum mismatch! Be careful with the downloaded file.")
    if os.path.isfile("paperclip.jar.old") == True:
        os.remove("paperclip.jar.old")
    os.rename("paperclip.jar", "paperclip.jar.old")
file.close()