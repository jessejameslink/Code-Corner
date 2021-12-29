import requests
import re
import argparse

parser = argparse.ArgumentParser("Passing URL to Script")
parser.add_argument("url", help="Enter url to extract emails from.", type=str)
args = parser.parse_args()
print(args.url)

# get url
url = args.url

# connect to the url
website = requests.get(url)

# read html
html = website.text

# use re.findall to grab all the links
#links = re.findall('"((http|ftp)s?://.*?)"', html)
emails = re.findall('([\w\.,]+@[\w\.,]+\.\w+)', html)


# print the number of links in the list
#print("\nFound {} links".format(len(links)))
for email in emails:
    #print(email)
    f= open("/root/working/external/harvested-emails.txt","a+")
    f.write(email)
    f.write("\n")
    f.close()

url = ""
email = ""

