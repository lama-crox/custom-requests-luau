from requests import post, get
from time import sleep
from os import path
from json import loads

configuration = {'checkRate': 0.1}
table = {'inputfile': 'path/to/input', 'outputfile': 'path/to/output'}

def readFile():
    if path.exists(table['inputfile']):
        with open(table['inputfile'], 'r') as file:
            return file.read()

def writeFile(data):
    if path.exists(table['outputfile']):
        with open(table['outputfile'], 'w') as file1, open(table['inputfile'], 'w') as file2:
            file1.write(data)
            file2.write('')

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
