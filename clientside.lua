local requestLib = {waitThreshold = 1.25}

-- THE ARGUMENTS SHOULD BE WRITTEN IN A PYTHON FORMAT!

function requestLib:httpPost(url: 'https://example.com', headers: 'Header Input', json: 'Json Input', inputfile, outputfile)
    if not inputfile or not outputfile then return end
    writefile(outputfile, '')
    writefile(inputfile, string.format('POST:Cut:%s:Cut:Cut:%s:Cut:%s', url, headers, json))

    local timeSince, content = tick()
    while true do
        if tick() - timeSince > requestLib.waitThreshold then break end
        content = readfile(outputfile)
        if content ~= '' then break end
    end

    return content
end

function requestLib:httpGet(url: 'https://example.com', params: '{"Params"}', inputfile, outputfile)
    if not inputfile or not outputfile then return end
    writefile(outputfile, '')
    writefile(inputfile, string.format('GET:Cut:%s:Cut:Cut:%s:Cut:%s', url, params))

    local timeSince, content = tick()
    while true do
        if tick() - timeSince > requestLib.waitThreshold then break end
        content = readfile(outputfile)
        if content ~= '' then break end
    end

    return content
end

return requestLib
