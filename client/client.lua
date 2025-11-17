if not _L then
    _L = function(key, ...)
        local locale = Config and Config.Locale or 'pt'
        local entry = Locales and Locales[locale] and Locales[locale][key]
        if type(entry) == 'function' then
            return entry(...)
        end
        return entry or key
    end
end

local routes = {}

RegisterNetEvent('busroute:loadRoutes', function(data)
    routes = data or {}
end)

TriggerServerEvent('busroute:requestRoutes')

local function saveRoutes()
    TriggerServerEvent('busroute:saveRoutes', routes)
end

RegisterCommand('createroutes', function(source)
    lib.registerContext({
        id = 'bus_route_main',
        title = _L('menu_title'),
        options = {
            {
                title = _L('menu_create_title'),
                description = _L('menu_create_desc'),
                event = 'busroute:createRoute'
            },
            {
                title = _L('menu_edit_title'),
                description = _L('menu_edit_desc'),
                event = 'busroute:editRoutes'
            },
        }
    })
    lib.showContext('bus_route_main')
end)

RegisterNetEvent('busroute:createRoute', function()
    local input = lib.inputDialog(_L('dialog_title'), {
        { type = 'input', label = _L('label_route'), required = true, description = _L('ds_route')},
        { type = 'input', label = _L('label_area'), required = true, description = _L('ds_area')},
        { type = 'number', label = _L('label_level'), required = true, description = _L('ds_level')},
        { type = 'number', label = _L('label_seats'), required = true, description = _L('ds_seats')},
        { type = 'number', label = _L('label_money'), required = true, description = _L('ds_money')},
        { type = 'number', label = _L('label_exp'), required = true, description = _L('ds_exp')},
    })

    if not input then return end

    local newRoute = {
        label = input[1],
        area = input[2],
        level = input[3],
        seats_required = input[4],
        rewards = {
            money = input[5],
            experience = input[6]
        },
        stops = {}
    }

    table.insert(routes, newRoute)
    saveRoutes()
    TriggerEvent('busroute:addStops', #routes)
end)

RegisterNetEvent('busroute:addStops', function(routeIndex)
    local route = routes[routeIndex]
    if not route then return end

    lib.notify({
        title = _L('route_editor'),
        description = _L('route_instructions'),
        type = 'inform'
    })

    CreateThread(function()
        local adding = true
        while adding do
            Wait(0)

            local coords = GetEntityCoords(PlayerPedId())
            DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0,
                       0.5, 0.5, 0.5, 0, 255, 0, 200, false, true, 2)

            if IsControlJustReleased(0, 38) then
                local stopCoord = vec3(coords.x, coords.y, coords.z)
                local npcs = {}

                lib.notify({
                    title = _L('npc_editor'),
                    description = _L('npc_instructions'),
                    type = 'inform'
                })

                local npcIndex = 1
                while npcIndex <= 4 do
                    Wait(0)
                    local pos = GetEntityCoords(PlayerPedId())
                    DrawMarker(2, pos.x, pos.y, pos.z + 1.0, 0, 0, 0, 0, 0, 0,
                               0.3, 0.3, 0.3, 0, 150, 255, 200, false, true, 2)

                    if IsControlJustReleased(0, 38) then
                        npcs[#npcs+1] = vec4(pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()))
                        lib.notify({
                            title = _L('npc_editor'),
                            description = _L('npc_positioned', npcIndex),
                            type = 'success'
                        })
                        npcIndex = npcIndex + 1
                    elseif IsControlJustReleased(0, 47) then
                        break
                    end
                end

                route.stops[#route.stops+1] = {
                    stop_coord = stopCoord,
                    npc_positions = npcs
                }
                saveRoutes()
            elseif IsControlJustReleased(0, 47) then
                lib.notify({
                    title = _L('route_editor'),
                    description = _L('finished'),
                    type = 'success'
                })
                adding = false
            end
        end
    end)
end)

RegisterNetEvent('busroute:editRoutes', function()
    if not routes or #routes == 0 then
        lib.notify({ title = 'Erro', description = 'Nenhuma rota encontrada.', type = 'error' })
        return
    end

    local routeOptions = {}

    for i, route in ipairs(routes) do
        routeOptions[#routeOptions + 1] = {
            title = route.label,
            description = _L('menu_edit_select_desc'),
            event = 'busroute:editRouteStops',
            args = { routeIndex = i }
        }
    end

    lib.registerContext({
        id = 'busroute_select_route',
        title = _L('menu_edit_select_route'),
        options = routeOptions
    })

    lib.showContext('busroute_select_route')
end)

RegisterNetEvent('busroute:editRouteStops', function(data)
    local route = routes[data.routeIndex]
    if not route or not route.stops then return end

    local stopOptions = {}

    for i, stop in ipairs(route.stops) do
        stopOptions[#stopOptions + 1] = {
            title = _L('menu_stop_title', i),
            description = _L('menu_stop_desc'),
            event = 'busroute:editSingleStop',
            args = {
                routeIndex = data.routeIndex,
                stopIndex = i
            }
        }
    end

    lib.registerContext({
        id = 'busroute_select_stops_' .. data.routeIndex,
        title = _L('menu_edit_title') .. route.label,
        menu = _L('menu_edit_desc'),
        options = stopOptions
    })

    lib.showContext('busroute_select_stops_' .. data.routeIndex)
end)

RegisterNetEvent('busroute:editSingleStop', function(data)
    local route = routes[data.routeIndex]
    local stop = route and route.stops and route.stops[data.stopIndex]

    if not stop then return end

    lib.notify({
        title = _L('edit_stop_title'),
        description = _L('edit_stop_instruction'),
        type = 'inform'
    })

    CreateThread(function()
        local updated = false
        while true do
            Wait(0)
            DrawMarker(1, stop.stop_coord.x, stop.stop_coord.y, stop.stop_coord.z - 1.0,
                0, 0, 0, 0, 0, 0,
                0.5, 0.5, 0.5, 255, 255, 0, 200, false, true, 2)

            if IsControlJustReleased(0, 38) then
                local newCoord = GetEntityCoords(PlayerPedId())
                stop.stop_coord = vec3(newCoord.x, newCoord.y, newCoord.z)
                updated = true
                break
            end
        end

        if updated then
            lib.notify({
                title = _L('stop_updated'),
                description = _L('edit_npc_instruction'),
                type = 'inform'
            })

            stop.npc_positions = {}

            local npcIndex = 1
            while npcIndex <= 4 do
                Wait(0)
                local pos = GetEntityCoords(PlayerPedId())
                DrawMarker(2, pos.x, pos.y, pos.z + 1.0,
                    0, 0, 0, 0, 0, 0,
                    0.3, 0.3, 0.3, 0, 150, 255, 200, false, true, 2)

                if IsControlJustReleased(0, 38) then
                    stop.npc_positions[#stop.npc_positions+1] = vec4(pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()))
                    lib.notify({
                        title = _L('npc_editor'),
                        description = _L('npc_positioned', npcIndex),
                        type = 'success'
                    })
                    npcIndex = npcIndex + 1
                elseif IsControlJustReleased(0, 47) then
                    break
                end
            end

            saveRoutes()

            lib.notify({
                title = _L('success'),
                description = _L('stop_and_npc_updated'),
                type = 'success'
            })
        end
    end)
end)
