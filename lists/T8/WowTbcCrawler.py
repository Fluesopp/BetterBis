import json
import requests
import urllib.request
from bs4 import BeautifulSoup
import re
from threading import Thread

def getId(name):
    search = name
    search.replace(" ", "+")
    url = 'https://www.wowdb.com/find'

    headers = {
        'Accept' : '*/*',
        'Accept-Language': 'en-US,en;q=0.5',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.82',
    }
    parameters = {'q': search}
    content = requests.get(url, headers = headers, params = parameters).text
    findafter = "https://www.wowdb.com/items/"
    numbers = re.search(findafter+'(\d+)', content, re.IGNORECASE)
    numbers = re.findall(r'\d+', str(numbers)) 
    if numbers:
        return numbers[2]
    else:
        return "Unknown"


def writeFile(classspec):
    weburl = "https://wowtbc.gg/page-data/wotlk/bis-list/"+classspec+"/page-data.json"
    splitted = classspec.split("-")
    filename = ""
    itemDict = {}

    for item in splitted:
        filename += item.capitalize()
    filename += ".lua" 

    print("---------- "+filename+" ----------")

    # Headers to mimic the browser
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 \
        (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'
    }

    with urllib.request.urlopen(weburl) as url:
        data = json.load(url)


    bislist = data["result"]["pageContext"]["bisList"]
    f = open(filename, "a")
    for item in bislist:
        try:
            name = item["name"]
            where = item["source"]
            who = item["source_type"]
            id = getId(name)

            if id != "Unknown" and id in itemDict:
                continue
            
            itemDict[id] = name

            start = 'BbisRegItem('
            startmid = ',"'
            middle = '","'
            end = '")'
            comment = "--"
            s = "   "
            newline = "\n"
            f.write(start+s+id+s+startmid+who+middle+where+end+s+comment+s+name+newline)
            print(item+" - "+id+": "+name)
        except:
            pass

    print(item+" Done!")
    f.close()
    thread[item].join()


classspec = [
            "blood-tank-death-knight",
            "frost-death-knight",
            "unholy-death-knight",
            "feral-tank-druid",
            "feral-dps-druid",
            "restoration-druid",
            "beast-mastery-hunter",
            "marksmanship-hunter",
            "survival-hunter",
            "arcane-mage",
            "fire-mage",
            "frost-mage",
            "holy-paladin",
            "protection-paladin",
            "retribution-paladin",
            "discipline-priest",
            "holy-priest",
            "shadow-priest",
            "assassination-rogue",
            "combat-rogue",
            "elemental-shaman",
            "enhancement-shaman",
            "restoration-shaman",
            "demonology-warlock",
            "destruction-warlock",
            "arms-warrior",
            "fury-warrior",
            "protection-warrior",
            ]

thread = {}
for item in classspec:
    
    thread[item] = Thread(target=writeFile, args=(item, ))
    thread[item].start()



    
    