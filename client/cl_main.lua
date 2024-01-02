RegisterNUICallback('sendTime', function(data, cb)
    local localTime = data.time
    lib.notify({
        title = localTime,
        position = "top-center",
        type = "info",
        icon = "calendar"
    })
    cb('ok')
end)

RegisterNetEvent("fractal_datetime:client:time")
AddEventHandler("fractal_datetime:client:time", function(localTime)
    lib.notify({
        title = localTime,
        position = "top-center",
        type = "info",
        icon = "calendar"
    })
end)

function clientTime()
    lib.registerContext({
        id = "main",
        title = "Fractal DateTime",
        options = {
            {
                name = "alldatetime",
                title = "Show All Date time",
                icon = "calendar",
                onSelect = function()
                    SendNUIMessage({
                        action = "datetime",
                        notation = Config.Notation,
                        format = Config.TimeFormat,
                        months = Config.Months
                    })
                end
            },
            {
                name = "date",
                title = "Show Date",
                icon = "calendar",
                onSelect = function()
                    SendNUIMessage({
                        action = "date",
                        notation = Config.Notation,
                        format = Config.TimeFormat,
                        months = Config.Months
                    })
                end
            },
            {
                name = "time",
                title = "Show Time",
                icon = "clock",
                onSelect = function()
                    SendNUIMessage({
                        action = "time",
                        notation = Config.Notation,
                        format = Config.TimeFormat,
                        months = Config.Months
                    })
                end
            }
        }
    })

    lib.showContext("main")
end
exports("clientTime", clientTime)

-- RegisterCommand("showMenu", function(source, args, rawCommand)
--     --clientTime()
--     serverTime()
-- end, false)

function serverTime()
    lib.registerContext({
        id = "mainServer",
        title = "Fractal DateTime",
        options = {
            {
                name = "alldatetime",
                title = "Show All Date time",
                icon = "calendar",
                onSelect = function()
                    TriggerServerEvent("fractal_datetime:server:getTime", "datetime")
                end
            },
            {
                name = "date",
                title = "Show Date",
                icon = "calendar",
                onSelect = function()
                    TriggerServerEvent("fractal_datetime:server:getTime", "date")
                end
            },
            {
                name = "time",
                title = "Show Time",
                icon = "clock",
                onSelect = function()
                    TriggerServerEvent("fractal_datetime:server:getTime", "time")
                end
            }
        }
    })

    lib.showContext("mainServer")
end
exports("serverTime", serverTime)