from requests import post, get
from time import sleep
from pathlib import Path
from json import loads

configuration = {'checkRate': 0.1}
data = {'inputfile': 'path/to/input/file', 'outputfile': 'path/to/output/file'}

def readFile():
    if Path.exists(data['inputfile']):
        with open(data['inputfile'], 'r') as file:
            return file.read()

def writeFile(data):
    if Path.exists(data['outputfile']):
        with open(data['outputfile'], 'w') as file:
            file.write(data)

while True:
    try:
        fileData = readFile()
        if fileData == '': continue

        parameters = fileData.split(':Cut:')
        if parameters[0] == 'POST':
            response = post(parameters[1], headers=loads(parameters[2]), json=loads(parameters[3]))
            writeFile(response)
        elif parameters[0] == 'GET':
            response = get(parameters[1], params=loads(parameters[2]))
            writeFile(response)
    except Exception as e:
        writeFile(f'Failed to fetch data: {str(e)}')

    sleep(configuration['checkRate'])
