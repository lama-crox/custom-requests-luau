local requestLib = {}

-- Configuration

requestLib.waitThreshold = 1.25
requestLib.sleepTime = 0.01

function requestLib.setWaitThreshold(value)
    module.waitThreshold = value
end

function requestLib.setSleepTime(value)
    module.sleepTime = value
end

-- THE ARGUMENTS SHOULD BE WRITTEN IN A PYTHON FORMAT!

function requestLib:httpPost(url: 'https://example.com', headers: 'Header Input', json: 'Json Input', inputfile, outputfile)
    if not inputfile or not outputfile then return end
    writefile(outputfile, '')
    writefile(inputfile, string.format('POST:Cut:%s:Cut:%s:Cut:%s', url, headers, json))

    local timeSince, content = tick()
    while task.wait(requestLib.sleepTime) do
        if tick() - timeSince > requestLib.waitThreshold then break end
        content = readfile(outputfile)
        if content ~= '' then break end
    end

    return content
end

function requestLib:httpGet(url: 'https://example.com', params: '{"Params"}', inputfile, outputfile)
    if not inputfile or not outputfile then return end
    writefile(outputfile, '')
    writefile(inputfile, string.format('GET:Cut:%s:Cut:%s', url, params))

    local timeSince, content = tick()
    while task.wait(requestLib.sleepTime) do
        if tick() - timeSince > requestLib.waitThreshold then break end
        content = readfile(outputfile)
        if content ~= '' then break end
    end

    return content
end

return requestLib
