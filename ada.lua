local mean = 0
local std = 0
local threshold = 3

local function calculate_mean(data)
    local sum = 0
    for i = 1, #data do
        sum = sum + data[i]
    end
    return sum / #data
end

local function calculate_std(data, mean)
    local sum = 0
    for i = 1, #data do
        sum = sum + (data[i] - mean)^2
    end
    return math.sqrt(sum / (#data - 1))
end

local function detect_anomaly(data)
    mean = calculate_mean(data)
    std = calculate_std(data, mean)
    local anomalies = {}
    for i = 1, #data do
        if math.abs(data[i] - mean) > threshold * std then
            anomalies[#anomalies + 1] = i
        end
    end
    return anomalies
end

local data = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
local anomalies = detect_anomaly(data)
for i = 1, #anomalies do
    ngx.log(ngx.ERR, "Anomaly detected at index: " .. anomalies[i])
end
