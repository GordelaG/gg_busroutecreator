local routes = {}
local fileName = 'routescreated.lua'

-- Save routes in an exportable format (with vector3 and vector4)
local function saveToFile()
    local fileContent = 'cfg.routeData = ' .. dumpTable(routes, 0)
    SaveResourceFile(GetCurrentResourceName(), fileName, fileContent, -1)
end

-- Load routes from file
local function loadRoutes()
    local file = LoadResourceFile(GetCurrentResourceName(), fileName)
    if not file then
        --print("[BusRoute] No file found, starting empty.")
        return
    end

    local env = {
        vector3 = vector3,
        vector4 = vector4
    }

    local fn, err = load(file, '@busroutes', 't', env)
    if not fn then
        --print("[BusRoute] Error loading file: " .. err)
        return
    end

    local ok, result = pcall(fn)
    if not ok then
        --print("[BusRoute] Error executing routes: " .. result)
        return
    end

    routes = result.cfg and result.cfg.routeData or result.cfg or {}
    --print("[BusRoute] Routes loaded successfully.")
end

-- Function to format tables as a string (with indentation and vector3/4)
function dumpTable(tbl, indent)
    indent = indent or 0
    local formatting = string.rep("\t", indent)
    local str = "{\n"

    for _, route in ipairs(tbl) do
        str = str .. formatting .. "\t{\n"
        str = str .. formatting .. string.format("\t\tlabel = \"%s\",\n", route.label)
        str = str .. formatting .. string.format("\t\tarea = \"%s\",\n", route.area)
        str = str .. formatting .. string.format("\t\tlevel = %d,\n", route.level)
        str = str .. formatting .. string.format("\t\tseats_required = %d,\n", route.seats_required)
        str = str .. formatting .. "\t\trewards = {\n"
        str = str .. formatting .. string.format("\t\t\tmoney = %d,\n", route.rewards.money)
        str = str .. formatting .. string.format("\t\t\texperience = %d,\n", route.rewards.experience)
        str = str .. formatting .. "\t\t},\n"
        str = str .. formatting .. "\t\tstops = {\n"

        for _, stop in ipairs(route.stops or {}) do
            str = str .. formatting .. "\t\t\t{\n"
            str = str .. formatting .. string.format("\t\t\t\tstop_coord = vector3(%.2f, %.2f, %.2f),\n", stop.stop_coord.x, stop.stop_coord.y, stop.stop_coord.z)
            str = str .. formatting .. "\t\t\t\tnpc_positions = {\n"

            for _, npc in ipairs(stop.npc_positions or {}) do
                str = str .. formatting .. string.format("\t\t\t\t\tvector4(%.2f, %.2f, %.2f, %.2f),\n", npc.x, npc.y, npc.z, npc.w)
            end

            str = str .. formatting .. "\t\t\t\t}\n"
            str = str .. formatting .. "\t\t\t},\n"
        end

        str = str .. formatting .. "\t\t}\n"
        str = str .. formatting .. "\t},\n"
    end

    str = str .. formatting .. "}"
    return str
end

-- Events
RegisterNetEvent('busroute:saveRoutes', function(newRoutes)
    routes = newRoutes
    saveToFile()
    --print("[BusRoute] Routes saved successfully.")
end)

RegisterNetEvent('busroute:requestRoutes', function()
    TriggerClientEvent('busroute:loadRoutes', source, routes)
end)

-- Load on start
CreateThread(function()
    Wait(500)
    loadRoutes()
end)