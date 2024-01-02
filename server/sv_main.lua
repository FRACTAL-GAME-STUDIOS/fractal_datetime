function formatLocalTime(data)
    local now = os.date("*t")
    local formattedTime = ''
    local formattedDate = ''

    if data.time then
        local hour = data.hour or now.hour
        local minutes = data.minutes or now.min
        local seconds = data.seconds or now.sec
        local ampm = hour >= 12 and " PM" or " AM"
        local formattedHour = data.format == "12" and (hour % 12 == 0 and 12 or hour % 12) or hour

        formattedHour = string.format("%02d", formattedHour)
        minutes = string.format("%02d", minutes)
        seconds = string.format("%02d", seconds)

        formattedTime = formattedHour .. ":" .. minutes .. ":" .. seconds
        if data.format == "12" then
            formattedTime = formattedTime .. ampm
        end
    end

    if data.date then
        print(data.date)
        local day = data.day or now.day
        local month = data.month or now.month
        local year = data.year or now.year
        local monthNames = data.months or {}
        local monthNumber = string.format("%02d", month)
        local monthName = monthNames[month] or monthNumber

        if data.notation == "American" then
            formattedDate = monthName .. "/" .. day .. "/" .. year
        elseif data.notation == "European" then
            formattedDate = day .. "/" .. monthName .. "/" .. year
        elseif data.notation == "ISO 8601" then
            formattedDate = year .. "-" .. monthNumber .. "-" .. day
        end
    end

    return formattedDate .. (formattedDate ~= "" and formattedTime ~= "" and " " or "") .. formattedTime
end

RegisterNetEvent("fractal_datetime:server:getTime")
AddEventHandler("fractal_datetime:server:getTime", function(data)
    local localTime = ""
    if data == "datetime" then
        localTime = formatLocalTime({
            notation = Config.Notation,
            format = Config.TimeFormat,
            months = Config.Months,
            date = true,
            time = true
        })
    elseif data == "date" then
        localTime = formatLocalTime({
            notation = Config.Notation,
            format = Config.TimeFormat,
            months = Config.Months,
            date = true,
            time = false
        })
    elseif data == "time" then
        localTime = formatLocalTime({
            notation = Config.Notation,
            format = Config.TimeFormat,
            months = Config.Months,
            date = false,
            time = true
        })
    end

    TriggerClientEvent("fractal_datetime:client:time", source, localTime)
end)